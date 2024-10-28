(*
 * Cloud SMS 2024 Delphi Edition - Sample Project
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
 *)

unit smsf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ctcore, cttypes, ctsms;

type
  TFormSms = class(TForm)
    lblHeading: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cbServiceProviders: TComboBox;
    txtAccountKey: TEdit;
    txtAccountSecret: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    txtFrom: TEdit;
    btnSend: TButton;
    txtRecipients: TEdit;
    memoMessage: TMemo;
    ctSMS1: TctSMS;
    procedure btnSendClick(Sender: TObject);
    procedure cbServiceProvidersChange(Sender: TObject);
    procedure ctSMS1SSLServerAuthentication(Sender: TObject;
      CertEncoded: string; CertEncodedB: TArray<System.Byte>; const CertSubject,
      CertIssuer, Status: string; var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSms: TFormSms;

implementation

{$R *.dfm}

procedure TFormSms.btnSendClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    ctSMS1.AccountKey := txtAccountKey.Text;
    ctSMS1.AccountSecret := txtAccountSecret.Text;
    ctSMS1.MessageFrom := txtFrom.Text;
    ctSMS1.MessageRecipients := txtRecipients.Text;
    ctSMS1.MessageBody := memoMessage.Text;
    ctSMS1.Send;
  except on ex: ECloudSMS do
    ShowMessage('Exception: ' + ex.Message);
  end;
  Screen.Cursor := crDefault;
end;

procedure TFormSms.cbServiceProvidersChange(Sender: TObject);
begin
  txtAccountSecret.Enabled := true;
  txtAccountSecret.Color := clWindow;
  txtAccountKey.Clear;
  txtAccountSecret.Clear;
  if cbServiceProviders.Text = 'Twilio' then
    ctSMS1.ServiceProvider := TctSMSServiceProviders.spTwilio
  else if cbServiceProviders.Text = 'Sinch' then
    ctSMS1.ServiceProvider := TctSMSServiceProviders.spSinch
  else if cbServiceProviders.Text = 'SMS Global' then
    ctSMS1.ServiceProvider := TctSMSServiceProviders.spSMSGlobal
  else if cbServiceProviders.Text = 'SMS.to' then
  begin
    ctSMS1.ServiceProvider := TctSMSServiceProviders.spSMSto;
    txtAccountSecret.Enabled := false;
    txtAccountSecret.Color := clBtnFace;
  end
  else if cbServiceProviders.Text = 'Vonage' then
    ctSMS1.ServiceProvider := TctSMSServiceProviders.spVonage
  else if cbServiceProviders.Text = 'Clickatell' then
  begin
    ctSMS1.ServiceProvider := TctSMSServiceProviders.spClickatell;
    txtAccountSecret.Enabled := false;
    txtAccountSecret.Color := clBtnFace;
  end
end;

procedure TFormSms.ctSMS1SSLServerAuthentication(Sender: TObject;
  CertEncoded: string; CertEncodedB: TArray<System.Byte>; const CertSubject,
  CertIssuer, Status: string; var Accept: Boolean);
begin
  Accept := true;
end;

end.





