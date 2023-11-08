# 
# Cloud SMS 2022 Python Edition - Sample Project
# 
# This sample project demonstrates the usage of Cloud SMS in a 
# simple, straightforward way. It is not intended to be a complete 
# application. Error handling and other checks are simplified for clarity.
# 
# www.nsoftware.com/cloudsms
# 
# This code is subject to the terms and conditions specified in the 
# corresponding product license agreement which outlines the authorized 
# usage and restrictions.
# 

import sys
import string
from cloudsms import *

input = sys.hexversion<0x03000000 and raw_input or input


sms1 = SMS()

def fireSSLServerAuthentication(e):
  e.accept = True

try:
  sms1.on_ssl_server_authentication = fireSSLServerAuthentication

  print("Which SMS service provider would you like to use to send your message?")
  print(" [0] - Twilio")
  print(" [1] - Sinch")
  print(" [2] - SMS Global")
  print(" [3] - SMS.to")
  print(" [4] - Vonage")
  print(" [5] - Clickatell")

  sms1.set_service_provider(int(input("Service Provider: ")))
  
  if (sms1.get_service_provider() == 0):
    sms1.set_account_key(input("Enter your Twilio account SID: "))
    sms1.set_account_secret(input("Enter your Twilio auth token: "))
  elif (sms1.get_service_provider() == 1):
    sms1.set_account_key(input("Enter your Sinch service plan ID: "))
    sms1.set_account_secret(input("Enter your Sinch API token: "))
  elif (sms1.get_service_provider() == 2):
    sms1.set_account_key(input("Enter your SMS Global API key: "))
    sms1.set_account_secret(input("Enter your SMS Global API secret: "))
  elif (sms1.get_service_provider() == 3):
    sms1.set_account_key(input("Enter your SMS.to API key: "))
  elif (sms1.get_service_provider() == 4):
    sms1.set_account_key(input("Enter your Vonage API key: "))
    sms1.set_account_secret(input("Enter your Vonage account secret: "))
  elif (sms1.get_service_provider() == 5):
    sms1.set_account_key(input("Enter your Clickatell API key: "))

  while True:
    # Process user commands.
    print("Commands:")
    print("   [0] - send                send a message from one phone number to another")
    print("   [1] - quit                exit the application")
    option = int(input("sms> "))

    if (option == 0):
      sms1.set_message_from(input("Provide phone number that is sending the message: "))
      sms1.set_message_recipients(input("Provide phone number that is receiving the message: "))
      sms1.set_message_body(input("Provide SMS message text: "))
      sms1.send()
    elif (option == 1):
      print("Exiting program...")
      break
    else:
      print("Invalid command, exiting program...")
      break
    
    print("Message sent")

except Exception as e:
  print(e)





