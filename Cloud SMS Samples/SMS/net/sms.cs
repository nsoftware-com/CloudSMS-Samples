/*
 * Cloud SMS 2024 .NET Edition - Sample Project
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
 * 
 */

﻿using System;
using nsoftware.CloudSMS;

class smsDemo
{
  private static SMS sms;

  private static void sms_OnSSLServerAuthentication(object sender, SMSSSLServerAuthenticationEventArgs e)
  {
    if (e.Accept) return;
    Console.Write("Server provided the following certificate:\nIssuer: " + e.CertIssuer + "\nSubject: " + e.CertSubject + "\n");
    Console.Write("The following problems have been determined for this certificate: " + e.Status + "\n");
    Console.Write("Would you like to continue anyways? [y/n] ");
    if (Console.Read() == 'y') e.Accept = true;
  }

  static void Main(string[] args)
  {
    sms = new SMS();

    try
    {
      sms.OnSSLServerAuthentication += sms_OnSSLServerAuthentication;

      Console.WriteLine("Which SMS service provider would you like to use to send your message?");
      Console.WriteLine("   [0] - Twilio");
      Console.WriteLine("   [1] - Sinch");
      Console.WriteLine("   [2] - SMS Global");
      Console.WriteLine("   [3] - SMS.to");
      Console.WriteLine("   [4] - Vonage");
      Console.WriteLine("   [5] - Clickatell");
      Console.Write("Service provider: ");

      // Prompt for authentication information.
      int servicePrompt = int.Parse(Console.ReadLine());
      SelectServiceProvider(servicePrompt);

      // Process user commands.
      Console.WriteLine("Type \"?\" or \"help\" for a list of commands.");
      Console.Write("sms> ");
      string command;
      string[] arguments;

      while (true)
      {
        command = Console.ReadLine();
        arguments = command.Split();

        if (arguments[0] == "?" || arguments[0] == "help")
        {
          Console.WriteLine("Commands: ");
          Console.WriteLine("  ?                            display the list of valid commands");
          Console.WriteLine("  help                         display the list of valid commands");
          Console.WriteLine("  send <from> <to> <message>   send a message from one phone number to another phone number");
          Console.WriteLine("  quit                         exit the application");
        }
        else if (arguments[0] == "send")
        {
          if (arguments.Length > 3)
          {
            sms.MessageFrom = arguments[1];
            sms.MessageRecipients = arguments[2];

            string fullMessage = "";
            for (int i = 3; i < arguments.Length; i++)
            {
              fullMessage += arguments[i] + " ";
            }
            sms.MessageBody = fullMessage;

            // Send SMS.
            Console.Write("Sending message... ");
            sms.Send();
            Console.WriteLine(" sent.");
          }
          else
          {
            Console.WriteLine("Please supply two phone numbers and a message.");
          }
        }
        else if (arguments[0] == "quit")
        {
          break;
        }
        else if (arguments[0] == "")
        {
          // Do nothing.
        }
        else
        {
          Console.WriteLine("Invalid command.");
        } // End of command checking.

        Console.Write("sms> ");
      }
    }
    catch (Exception e)
    {
      Console.WriteLine(e.Message);
    }
  }

  private static void SelectServiceProvider(int servicePrompt)
  {
    switch (servicePrompt)
    {
      case 0:
        sms.ServiceProvider = SMSServiceProviders.spTwilio;

        Console.Write("Enter your Twilio account SID: ");
        sms.AccountKey = Console.ReadLine();

        Console.Write("Enter your Twilio auth token: ");
        sms.AccountSecret = Console.ReadLine();
        break;
      case 1:
        sms.ServiceProvider = SMSServiceProviders.spSinch;

        Console.Write("Enter your Sinch service plan ID: ");
        sms.AccountKey = Console.ReadLine();

        Console.Write("Enter your Sinch API token: ");
        sms.AccountSecret = Console.ReadLine();
        break;
      case 2:
        sms.ServiceProvider = SMSServiceProviders.spSMSGlobal;

        Console.Write("Enter your SMS Global API key: ");
        sms.AccountKey = Console.ReadLine();

        Console.Write("Enter your SMS Global API secret: ");
        sms.AccountSecret = Console.ReadLine();
        break;
      case 3:
        sms.ServiceProvider = SMSServiceProviders.spSMSto;

        Console.Write("Enter your SMS.to API key: ");
        sms.AccountKey = Console.ReadLine();
        break;
      case 4:
        sms.ServiceProvider = SMSServiceProviders.spVonage;

        Console.Write("Enter your Vonage API key: ");
        sms.AccountKey = Console.ReadLine();

        Console.Write("Enter your Vonage account secret: ");
        sms.AccountSecret = Console.ReadLine();
        break;
      case 5:
        sms.ServiceProvider = SMSServiceProviders.spClickatell;

        Console.Write("Enter your Clickatell API key: ");
        sms.AccountKey = Console.ReadLine();
        break;
      default:
        throw new Exception("Invalid SMS service provider.\n");
    }
  }
}




class ConsoleDemo
{
  /// <summary>
  /// Takes a list of switch arguments or name-value arguments and turns it into a dictionary.
  /// </summary>
  public static System.Collections.Generic.Dictionary<string, string> ParseArgs(string[] args)
  {
    System.Collections.Generic.Dictionary<string, string> dict = new System.Collections.Generic.Dictionary<string, string>();

    for (int i = 0; i < args.Length; i++)
    {
      // Add a key to the dictionary for each argument.
      if (args[i].StartsWith("/"))
      {
        // If the next argument does NOT start with a "/", then it is a value.
        if (i + 1 < args.Length && !args[i + 1].StartsWith("/"))
        {
          // Save the value and skip the next entry in the list of arguments.
          dict.Add(args[i].ToLower().TrimStart('/'), args[i + 1]);
          i++;
        }
        else
        {
          // If the next argument starts with a "/", then we assume the current one is a switch.
          dict.Add(args[i].ToLower().TrimStart('/'), "");
        }
      }
      else
      {
        // If the argument does not start with a "/", store the argument based on the index.
        dict.Add(i.ToString(), args[i].ToLower());
      }
    }
    return dict;
  }
  /// <summary>
  /// Asks for user input interactively and returns the string response.
  /// </summary>
  public static string Prompt(string prompt, string defaultVal)
  {
    Console.Write(prompt + (defaultVal.Length > 0 ? " [" + defaultVal + "]": "") + ": ");
    string val = Console.ReadLine();
    if (val.Length == 0) val = defaultVal;
    return val;
  }
}