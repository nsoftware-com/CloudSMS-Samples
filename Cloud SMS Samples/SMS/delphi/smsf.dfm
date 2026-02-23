object FormSms: TFormSms
  Left = 200
  Top = 130
  BorderStyle = bsSingle
  Caption = 'SMS Demo'
  ClientHeight = 394
  ClientWidth = 500
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clDefault
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesigned
  TextHeight = 13
  object lblHeading: TLabel
    Left = 10
    Top = 8
    Width = 482
    Height = 26
    Caption = 
      'This demo shows how to use the SMS component to send SMS message' +
      's over the cloud.'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    WordWrap = True
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 27
    Width = 485
    Height = 110
    Caption = 'Account Info'
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 21
      Width = 82
      Height = 13
      Caption = 'Service Provider:'
    end
    object Label2: TLabel
      Left = 10
      Top = 48
      Width = 64
      Height = 13
      Caption = 'Account Key:'
    end
    object Label3: TLabel
      Left = 10
      Top = 75
      Width = 77
      Height = 13
      Caption = 'Account Secret:'
    end
    object cbServiceProviders: TComboBox
      Left = 98
      Top = 18
      Width = 369
      Height = 21
      TabOrder = 0
      OnChange = cbServiceProvidersChange
      Items.Strings = (
        'Twilio'
        'Sinch'
        'SMS Global'
        'SMS.to'
        'Vonage'
        'Clickatell')
    end
    object txtAccountKey: TEdit
      Left = 98
      Top = 45
      Width = 369
      Height = 21
      TabOrder = 1
    end
    object txtAccountSecret: TEdit
      Left = 98
      Top = 72
      Width = 369
      Height = 21
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 143
    Width = 485
    Height = 247
    Caption = 'Message Info'
    TabOrder = 1
    object Label4: TLabel
      Left = 10
      Top = 21
      Width = 28
      Height = 13
      Caption = 'From:'
    end
    object Label5: TLabel
      Left = 10
      Top = 48
      Width = 53
      Height = 13
      Caption = 'Recipients:'
    end
    object Label6: TLabel
      Left = 10
      Top = 75
      Width = 73
      Height = 13
      Caption = 'Message Body:'
    end
    object txtFrom: TEdit
      Left = 98
      Top = 18
      Width = 369
      Height = 21
      TabOrder = 0
    end
    object btnSend: TButton
      Left = 368
      Top = 211
      Width = 99
      Height = 25
      Caption = '&Send'
      TabOrder = 3
      OnClick = btnSendClick
    end
    object txtRecipients: TEdit
      Left = 98
      Top = 45
      Width = 369
      Height = 21
      TabOrder = 1
    end
    object memoMessage: TMemo
      Left = 10
      Top = 94
      Width = 457
      Height = 111
      ScrollBars = ssVertical
      TabOrder = 2
    end
  end
  object ctSMS1: TctSMS
    SSLCertStore = 'MY'
    OnSSLServerAuthentication = ctSMS1SSLServerAuthentication
    Left = 400
    Top = 215
  end
end


