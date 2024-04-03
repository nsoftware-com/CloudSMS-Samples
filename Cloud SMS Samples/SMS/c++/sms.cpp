/*
 * Cloud SMS 2022 C++ Edition - Sample Project
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

#include <iostream>
#include <string>
#include "../../include/sms.h"

#define LINE_LEN 80
#define MESSAGE_LEN 1024

class MySms : public SMS
{
public:
  virtual int FireSSLServerAuthentication(SMSSSLServerAuthenticationEventParams *e)
  {
    if (e->Accept) return 0;
    printf("Server provided the following certificate:\nIssuer: %s\nSubject: %s\n",
      e->CertIssuer, e->CertSubject);
    printf("The following problems have been determined for this certificate: %s\n", e->Status);
    printf("Would you like to continue anyways? [y/n] ");
    if (getchar() == 'y') e->Accept = true;
    else exit(0);
    return 0;
  }
  void selectServiceProvider(int servicePrompt)
  {
    char command[LINE_LEN];

    switch (servicePrompt)
    {
      case 0:
        this->SetServiceProvider(0);

        printf("Enter your Twilio account SID: ");
        fgets(command, LINE_LEN, stdin);
        command[strcspn(command, "\n")] = 0; // strip the newline character
        this->SetAccountKey(command);

        printf("Enter your Twilio auth token: ");
        fgets(command, LINE_LEN, stdin);
        command[strcspn(command, "\n")] = 0;
        this->SetAccountSecret(command);
        break;
      case 1:
        this->SetServiceProvider(1);

        printf("Enter your Sinch service plan ID: ");
        fgets(command, LINE_LEN, stdin);
        command[strcspn(command, "\n")] = 0;
        this->SetAccountKey(command);

        printf("Enter your Sinch API token: ");
        fgets(command, LINE_LEN, stdin);
        command[strcspn(command, "\n")] = 0;
        this->SetAccountSecret(command);
        break;
      case 2:
        this->SetServiceProvider(2);

        printf("Enter your SMS Global API key: ");
        fgets(command, LINE_LEN, stdin);
        command[strcspn(command, "\n")] = 0;
        this->SetAccountKey(command);

        printf("Enter your SMS Global API secret: ");
        fgets(command, LINE_LEN, stdin);
        command[strcspn(command, "\n")] = 0;
        this->SetAccountSecret(command);
        break;
      case 3:
        this->SetServiceProvider(3);

        printf("Enter your SMS.to API key: ");
        fgets(command, LINE_LEN, stdin);
        command[strcspn(command, "\n")] = 0;
        this->SetAccountKey(command);
        break;
      case 4:
        this->SetServiceProvider(4);

        printf("Enter your Vonage API key: ");
        fgets(command, LINE_LEN, stdin);
        command[strcspn(command, "\n")] = 0;
        this->SetAccountKey(command);

        printf("Enter your Vonage account secret: ");
        fgets(command, LINE_LEN, stdin);
        command[strcspn(command, "\n")] = 0;
        this->SetAccountSecret(command);
        break;
      case 5:
        this->SetServiceProvider(5);

        printf("Enter your Clickatell API key: ");
        fgets(command, LINE_LEN, stdin);
        command[strcspn(command, "\n")] = 0;
        this->SetAccountKey(command);
        break;
      default:
        throw std::invalid_argument("\nInvalid SMS service provider.\n");
    }
  }
};

int main()
{
  char command[LINE_LEN];
  MySms sms;

  printf("Which SMS service provider would you like to use to send your message?\n");
  printf("   [0] - Twilio\n");
  printf("   [1] - Sinch\n");
  printf("   [2] - SMS Global\n");
  printf("   [3] - SMS.to\n");
  printf("   [4] - Vonage\n");
  printf("   [5] - Clickatell\n");
  printf("Service provider: ");

  fgets(command, LINE_LEN, stdin);

  // Prompt for authentication information.
  int servicePrompt = std::stoi(command);
  sms.selectServiceProvider(servicePrompt);

  // Process user commands.
  printf("Commands: \n");
  printf("   [0] - send                         send a message from one phone number to another phone number\n");
  printf("   [1] - quit                         exit the application\n");
  printf("sms> ");

  fgets(command, LINE_LEN, stdin);

  if (std::stoi(command) == 0) {
    printf("Provide phone number that is sending message: ");
    fgets(command, LINE_LEN, stdin);
    command[strcspn(command, "\n")] = 0; // strip the newline character
    sms.SetMessageFrom(command);

    printf("Provide phone number that is receiving message: ");
    fgets(command, LINE_LEN, stdin);
    command[strcspn(command, "\n")] = 0;
    sms.SetMessageRecipients(command);

    printf("Provide SMS message text: ");
    fgets(command, MESSAGE_LEN, stdin);
    command[strcspn(command, "\n")] = 0;
    sms.SetMessageBody(command);

    // Send SMS.
    printf("Sending message... ");
    sms.Send();

    if (sms.GetLastErrorCode()) {
      printf("Error %d: %s", sms.GetLastErrorCode(), sms.GetLastError());
    }
    else {
      printf(" sent.\n");
    }
  }
  else if (std::stoi(command) == 1) {
    exit(0);
  }
  else {
    printf("Invalid command.\n");
  }
}

