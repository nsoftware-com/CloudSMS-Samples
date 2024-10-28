/*
 * Cloud SMS 2024 JavaScript Edition - Sample Project
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
 
const readline = require("readline");
const cloudsms = require("@nsoftware/cloudsms");

if(!cloudsms) {
  console.error("Cannot find cloudsms.");
  process.exit(1);
}
let rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

let sms = new cloudsms.sms();

main()

function promptUserInit() {
    console.log("Commands: ");
    console.log("  ?                            display the list of valid commands");
    console.log("  help                         display the list of valid commands");
    console.log("  send <from> <to> <message>   send a message from one phone number to another phone number");
    console.log("  quit                         exit the application");
    promptUser();
}

function promptUser() {
    rl.question("sms> ", async (command) => {
        let args = command.split(" ");

        if (args[0] === "?" || args[0] === "help") {
            console.log("Commands: ");
            console.log("  ?                            display the list of valid commands");
            console.log("  help                         display the list of valid commands");
            console.log("  send <from> <to> <message>   send a message from one phone number to another phone number");
            console.log("  quit                         exit the application");
            promptUser();
        } else if (args[0] === "send") {
            if (args.length > 3) {
                sms.setMessageFrom(args[1]);
                sms.setMessageRecipients(args[2]);

                let fullMessage = "";
                for (let i = 3; i < args.length; i++) {
                    fullMessage += args[i] + " ";
                }
                sms.setMessageBody(fullMessage);

                // Send SMS.
                console.log("Sending message... ");

                sms.send()
                .then(e => {
                    console.log("Message sent!")
                }).catch(e =>{
                    console.log("ERROR:" + e)
                }).finally(e => {
                    promptUser();
                })

            } else {
                console.log("Please supply two phone numbers and a message.");
                promptUser();
            }
        } else if (args[0] === "quit") {
            rl.close();
            process.exit(0);
        } else if (args[0] === "") {
            promptUser();
        } else {
            console.log("Invalid command.");
            promptUser();
        } // End of command checking.
    });
}


function main() {
    let initalPrompt =
        `Which SMS service provider would you like to use to send your message?
[0] - Twilio
[1] - Sinch
[2] - SMS Global
[3] - SMS.to
[4] - Vonage
[5] - ClickATell
Service provider: `

    rl.question(initalPrompt, smsOption => {
        selectServiceProvider(smsOption);
    })

}

function selectServiceProvider(servicePrompt) {
    switch (parseInt(servicePrompt)) {
        case 0:
            sms.setServiceProvider(0);
            rl.question("Enter your Twilio account SID: ", (accountKey) => {
                sms.setAccountKey(accountKey);
                rl.question("Enter your Twilio auth token: ", (accountSecret) => {
                    sms.setAccountSecret(accountSecret);
                    promptUserInit() 
                });
            });
            break;
        case 1:
            sms.setServiceProvider(1);
            rl.question("Enter your Sinch service plan ID: ", (accountKey) => {
                sms.setAccountKey(accountKey);
                rl.question("Enter your Sinch API token: ", (accountSecret) => {
                    sms.setAccountSecret(accountSecret);
                    promptUserInit() 
                });
            });
            break;
        case 2:
            sms.setServiceProvider(2);
            rl.question("Enter your SMS Global API key: ", (accountKey) => {
                sms.setAccountKey(accountKey);
                rl.question("Enter your SMS Global API secret: ", (accountSecret) => {
                    sms.setAccountSecret(accountSecret);
                    promptUserInit() 
                });
            });
            break;
        case 3:
            sms.setServiceProvider(3);
            rl.question("Enter your SMS.to API Key: ", (accountKey) => {
                sms.setAccountKey(accountKey);
            });
            break;
        case 4:
            sms.setServiceProvider(4);
            rl.question("Enter your Vonage API key: ", (accountKey) => {
                sms.setAccountKey(accountKey);
                rl.question("Enter your Vonage account secret: ", (accountSecret) => {
                    sms.setAccountSecret(accountSecret);
                    promptUserInit() 
                });
            });
            break;
        case 5:
            sms.setServiceProvider(5);
            rl.question("Enter your ClickATell API Key: ", (accountKey) => {
                sms.setAccountKey(accountKey);
            });
            break;
        default:
            console.log("Invalid SMS service provider.");
            rl.close();
    }

}


function prompt(promptName, label, punctuation, defaultVal)
{
  lastPrompt = promptName;
  lastDefault = defaultVal;
  process.stdout.write(`${label} [${defaultVal}] ${punctuation} `);
}
