/*
 * Cloud SMS 2024 Java Edition - Sample Project
 *
 * This sample project demonstrates the usage of Cloud SMS in a 
 * simple, straightforward way. It is not intended to be a complete 
 * application. Error handling and other checks are simplified for clarity.
 *
 * www.nsoftware.com/cloudsms
 *
 * This code is subject to the terms and conditions specified in the 
 * corresponding product license agreement which outlines the authorized 
 * usage and restrictions.
 */

import java.io.*;
import cloudsms.*;
import java.util.Scanner;

public class sms {
  
  private static SMS sms;
  private static Scanner scanner;
  
  public sms() {
    sms = new SMS();
    scanner = new Scanner(System.in);
    
    try {
      sms.addSMSEventListener(new SMSEvents());
      
      System.out.println("Which SMS service provider would you like to use to send your message?");
      System.out.println("   [0] - Twilio");
      System.out.println("   [1] - Sinch");
      System.out.println("   [2] - SMS Global");
      System.out.println("   [3] - SMS.to");
      System.out.println("   [4] - Vonage");
      System.out.println("   [5] - Clickatell");
      System.out.print("Service provider: ");

      // Prompt for authentication information.
      int servicePrompt = Integer.parseInt(scanner.nextLine());
      selectServiceProvider(servicePrompt);

      // Process user commands.
      System.out.println("Type \"?\" or \"help\" for a list of commands.");
      System.out.print("sms> ");
      String command;
      String[] arguments;

      while (true) {
        command = scanner.nextLine();
        arguments = command.split(" ");

        if (arguments[0].equals("?") || arguments[0].equals("help")) {
          System.out.println("Commands: ");
          System.out.println("  ?                            display the list of valid commands");
          System.out.println("  help                         display the list of valid commands");
          System.out.println("  send <from> <to> <message>   send a message from one phone number to another phone number");
          System.out.println("  quit                         exit the application");
        } else if (arguments[0].equals("send")) {
          if (arguments.length > 3) {
            sms.setMessageFrom(arguments[1]);
            sms.setMessageRecipients(arguments[2]);

            String fullMessage = "";
            for (int i = 3; i < arguments.length; i++) {
              fullMessage += arguments[i] + " ";
            }
            sms.setMessageBody(fullMessage);

            // Send SMS.
            System.out.print("Sending message... ");
            sms.send();
            System.out.println(" sent.");
          } else {
            System.out.println("Please supply two phone numbers and a message.");
          }
        } else if (arguments[0].equals("quit")) {
          break;
        } else if (arguments[0].equals("")) {
          // Do nothing.
        } else {
          System.out.println("Invalid command.");
        } // End of command checking.

        System.out.print("sms> ");
      }
    } catch (Exception e) {
      System.out.println(e.getMessage());
    }
  }

  public static void main(String[] args) {
    try {
      new sms();
    } catch (Exception e) {
      System.out.println("Exception: " + e.getMessage());
    }
  }

  private static void selectServiceProvider(int servicePrompt) throws Exception {
    switch (servicePrompt) {
      case 0:
        sms.setServiceProvider(0);

        System.out.print("Enter your Twilio account SID: ");
        sms.setAccountKey(scanner.nextLine());

        System.out.print("Enter your Twilio auth token: ");
        sms.setAccountSecret(scanner.nextLine());
        break;
      case 1:
        sms.setServiceProvider(1);
        
        System.out.print("Enter your Sinch service plan ID: ");
        sms.setAccountKey(scanner.nextLine());

        System.out.print("Enter your Sinch API token: ");
        sms.setAccountSecret(scanner.nextLine());
        break;
      case 2:
        sms.setServiceProvider(2);
        
        System.out.print("Enter your SMS Global API key: ");
        sms.setAccountKey(scanner.nextLine());

        System.out.print("Enter your SMS Global API secret: ");
        sms.setAccountSecret(scanner.nextLine());
        break;
      case 3:
        sms.setServiceProvider(3);

        System.out.print("Enter your SMS.to API key: ");
        sms.setAccountKey(scanner.nextLine());
        break;
      case 4:
        sms.setServiceProvider(4);
        
        System.out.print("Enter your Vonage API key: ");
        sms.setAccountKey(scanner.nextLine());

        System.out.print("Enter your Vonage account secret: ");
        sms.setAccountSecret(scanner.nextLine());
        break;
      case 5:
        sms.setServiceProvider(5);

        System.out.print("Enter your Clickatell API key: ");
        sms.setAccountKey(scanner.nextLine());
        break;
      default:
        throw new Exception("Invalid SMS service provider.\n");
    }
  }
}

class SMSEvents extends DefaultSMSEventListener {

  Scanner scn = new Scanner(System.in);

  public void SSLServerAuthentication(SMSSSLServerAuthenticationEvent e) {
      if (e.accept) return;
      System.out.print("Server provided the following certificate:\nIssuer: " + e.certIssuer + "\nSubject: " + e.certSubject + "\n");
      System.out.print("The following problems have been determined for this certificate: " + e.status + "\n");
      System.out.print("Would you like to continue anyways? [y/n] ");
      if (scn.nextLine().charAt(0) == 'y') e.accept = true;
  }
}

class ConsoleDemo {
  private static BufferedReader bf = new BufferedReader(new InputStreamReader(System.in));

  static String input() {
    try {
      return bf.readLine();
    } catch (IOException ioe) {
      return "";
    }
  }
  static char read() {
    return input().charAt(0);
  }

  static String prompt(String label) {
    return prompt(label, ":");
  }
  static String prompt(String label, String punctuation) {
    System.out.print(label + punctuation + " ");
    return input();
  }
  static String prompt(String label, String punctuation, String defaultVal) {
      System.out.print(label + " [" + defaultVal + "] " + punctuation + " ");
      String response = input();
      if (response.equals(""))
        return defaultVal;
      else
        return response;
  }

  static char ask(String label) {
    return ask(label, "?");
  }
  static char ask(String label, String punctuation) {
    return ask(label, punctuation, "(y/n)");
  }
  static char ask(String label, String punctuation, String answers) {
    System.out.print(label + punctuation + " " + answers + " ");
    return Character.toLowerCase(read());
  }

  static void displayError(Exception e) {
    System.out.print("Error");
    if (e instanceof CloudSMSException) {
      System.out.print(" (" + ((CloudSMSException) e).getCode() + ")");
    }
    System.out.println(": " + e.getMessage());
    e.printStackTrace();
  }
}



