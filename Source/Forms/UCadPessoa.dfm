object FrmCadPessoa: TFrmCadPessoa
  Left = 0
  Top = 0
  Caption = 'Cadastro de Pessoa'
  ClientHeight = 419
  ClientWidth = 757
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object PanelButtons: TPanel
    Left = 0
    Top = 375
    Width = 757
    Height = 44
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 374
    ExplicitWidth = 753
    DesignSize = (
      757
      44)
    object BtnIncluir: TButton
      Left = 135
      Top = 6
      Width = 82
      Height = 33
      Anchors = [akLeft, akTop, akBottom]
      Caption = 'Incluir'
      TabOrder = 0
      OnClick = BtnIncluirClick
    end
    object BtnEditar: TButton
      Left = 223
      Top = 6
      Width = 89
      Height = 33
      Anchors = [akLeft, akTop, akBottom]
      Caption = 'Editar'
      TabOrder = 1
      OnClick = BtnEditarClick
    end
    object BtnExcluir: TButton
      Left = 318
      Top = 6
      Width = 89
      Height = 33
      Anchors = [akLeft, akTop, akBottom]
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = BtnExcluirClick
    end
    object BtnGravar: TButton
      Left = 413
      Top = 6
      Width = 89
      Height = 33
      Anchors = [akLeft, akTop, akBottom]
      Caption = 'Gravar'
      TabOrder = 3
      OnClick = BtnGravarClick
    end
    object BtnCancel: TButton
      Left = 508
      Top = 6
      Width = 89
      Height = 33
      Anchors = [akLeft, akTop, akBottom]
      Caption = 'Cancelar'
      TabOrder = 4
      OnClick = BtnCancelClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 757
    Height = 375
    ActivePage = TabCadastro
    Align = alClient
    TabOrder = 1
    OnChange = PageControl1Change
    object TabCadastro: TTabSheet
      Caption = 'Cadastro de Pessoa'
      object PanelCrud: TPanel
        Left = 0
        Top = 0
        Width = 749
        Height = 345
        Align = alClient
        Enabled = False
        TabOrder = 0
        ExplicitTop = -2
        object Label1: TLabel
          Left = 137
          Top = 5
          Width = 47
          Height = 15
          Caption = 'Natureza'
        end
        object Label2: TLabel
          Left = 10
          Top = 5
          Width = 39
          Height = 15
          Caption = 'C'#243'digo'
        end
        object Label3: TLabel
          Left = 463
          Top = 5
          Width = 63
          Height = 15
          Caption = 'Documento'
        end
        object Label4: TLabel
          Left = 336
          Top = 5
          Width = 70
          Height = 15
          Caption = 'Data Registro'
        end
        object Label5: TLabel
          Left = 10
          Top = 52
          Width = 63
          Height = 15
          Caption = 'nmPrimeiro'
        end
        object Label6: TLabel
          Left = 10
          Top = 94
          Width = 65
          Height = 15
          Caption = 'nmSegundo'
        end
        object Label7: TLabel
          Left = 10
          Top = 138
          Width = 21
          Height = 15
          Caption = 'Cep'
        end
        object Label8: TLabel
          Left = 10
          Top = 184
          Width = 80
          Height = 15
          Caption = 'nmLogradouro'
        end
        object Label9: TLabel
          Left = 623
          Top = 184
          Width = 23
          Height = 15
          Caption = 'dsuf'
        end
        object Label10: TLabel
          Left = 10
          Top = 268
          Width = 49
          Height = 15
          Caption = 'nmBairro'
        end
        object Label11: TLabel
          Left = 10
          Top = 226
          Width = 89
          Height = 15
          Caption = 'dsComplemento'
        end
        object Label12: TLabel
          Left = 263
          Top = 268
          Width = 55
          Height = 15
          Caption = 'nmCidade'
        end
        object flNatureza: TComboBox
          Left = 137
          Top = 26
          Width = 185
          Height = 23
          ItemIndex = 0
          TabOrder = 0
          Text = 'Pessoa F'#237'sica'
          Items.Strings = (
            'Pessoa F'#237'sica'
            'Pessoa Juridica')
        end
        object idPessoa: TEdit
          Left = 10
          Top = 26
          Width = 121
          Height = 23
          Enabled = False
          TabOrder = 1
        end
        object dsDocumento: TEdit
          Left = 463
          Top = 26
          Width = 280
          Height = 23
          TabOrder = 2
        end
        object dtRegistro: TDateTimePicker
          Left = 328
          Top = 26
          Width = 129
          Height = 23
          Date = 45042.000000000000000000
          Time = 0.465077569446293600
          TabOrder = 3
        end
        object nmPrimeiro: TEdit
          Left = 10
          Top = 70
          Width = 733
          Height = 23
          CharCase = ecUpperCase
          TabOrder = 4
        end
        object nmSegundo: TEdit
          Left = 10
          Top = 113
          Width = 733
          Height = 23
          CharCase = ecUpperCase
          TabOrder = 5
        end
        object dscep: TEdit
          Left = 10
          Top = 158
          Width = 119
          Height = 23
          TabOrder = 6
          Text = '55028470'
          OnExit = dscepExit
        end
        object nmlogradouro: TEdit
          Left = 10
          Top = 201
          Width = 605
          Height = 23
          CharCase = ecUpperCase
          TabOrder = 7
        end
        object dsuf: TEdit
          Left = 621
          Top = 201
          Width = 60
          Height = 23
          CharCase = ecUpperCase
          TabOrder = 8
        end
        object nmbairro: TEdit
          Left = 10
          Top = 283
          Width = 239
          Height = 23
          CharCase = ecUpperCase
          TabOrder = 9
        end
        object dscomplemento: TEdit
          Left = 10
          Top = 243
          Width = 605
          Height = 23
          TabOrder = 10
        end
        object nmcidade: TEdit
          Left = 263
          Top = 283
          Width = 239
          Height = 23
          CharCase = ecUpperCase
          TabOrder = 11
        end
      end
    end
    object TabConsulta: TTabSheet
      Caption = 'Consultas'
      ImageIndex = 1
      object Label13: TLabel
        Left = 3
        Top = 6
        Width = 79
        Height = 15
        Caption = 'Tipo Consulta.:'
      end
      object Label14: TLabel
        Left = 29
        Top = 37
        Width = 53
        Height = 15
        Caption = 'Consulta.:'
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 65
        Width = 749
        Height = 255
        Align = alBottom
        DataSource = DsPessoa
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDblClick = DBGrid1DblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'idpessoa'
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nmprimeiro'
            Title.Caption = 'Nome'
            Width = 256
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nmsegundo'
            Title.Caption = 'Sobrenome'
            Width = 153
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dsdocumento'
            Title.Caption = 'N'#186' Documento'
            Width = 98
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dtregistro'
            Title.Caption = 'Data'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'flnatureza'
            Title.Caption = 'Natureza'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dscep'
            Title.Caption = 'Cep'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nmlogradouro'
            Title.Caption = 'Endere'#231'o'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nmbairro'
            Title.Caption = 'Bairro'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dscomplemento'
            Title.Caption = 'Complemento'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dsuf'
            Title.Caption = 'UF'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nmcidade'
            Title.Caption = 'Cidade'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'idendereco'
            Visible = True
          end>
      end
      object DBNavigator1: TDBNavigator
        Left = 0
        Top = 320
        Width = 749
        Height = 25
        DataSource = DsPessoa
        Align = alBottom
        TabOrder = 1
      end
      object ComboTipoConsulta: TComboBox
        Left = 88
        Top = 5
        Width = 145
        Height = 23
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 2
        Text = 'C'#243'digo'
        Items.Strings = (
          'C'#243'digo'
          'Nome'
          'Documento')
      end
      object EditConsulta: TEdit
        Left = 88
        Top = 34
        Width = 658
        Height = 23
        CharCase = ecUpperCase
        TabOrder = 3
        OnChange = EditConsultaChange
      end
    end
    object TabJson: TTabSheet
      Caption = 'Import Json'
      ImageIndex = 2
      object LabelContador: TLabel
        Left = 143
        Top = 320
        Width = 83
        Height = 15
        Caption = 'Qtde Registros.:'
      end
      object mJson: TMemo
        Left = 297
        Top = 1
        Width = 449
        Height = 313
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object BtnImportar: TButton
        Left = 2
        Top = 316
        Width = 135
        Height = 30
        Caption = 'Importar Objeto'
        TabOrder = 1
        OnClick = BtnImportarClick
      end
      object mResponse: TMemo
        Left = 3
        Top = 0
        Width = 288
        Height = 314
        ScrollBars = ssVertical
        TabOrder = 2
      end
    end
  end
  object Qry: TFDQuery
    Connection = DM.Connection
    SQL.Strings = (
      'SELECT '
      'P.dsdocumento,'
      'P.dtregistro,'
      'P.flnatureza,'
      'P.idpessoa,'
      'P.nmprimeiro,'
      'P.nmsegundo,'
      'E.dscep,'
      'E.idendereco,'
      'EI.dscomplemento,'
      'EI.dsuf,'
      'EI.idendereco,'
      'EI.nmbairro,'
      'EI.nmcidade,'
      'EI.nmlogradouro'
      'FROM PESSOA P'
      'INNER JOIN endereco E ON E.idpessoa = P.idpessoa'
      
        'INNER JOIN endereco_integracao EI ON EI.idendereco = E.idenderec' +
        'o')
    Left = 324
    Top = 170
    object Qrydsdocumento: TWideStringField
      FieldName = 'dsdocumento'
      Origin = 'dsdocumento'
    end
    object Qrydtregistro: TDateField
      FieldName = 'dtregistro'
      Origin = 'dtregistro'
    end
    object Qryflnatureza: TSmallintField
      FieldName = 'flnatureza'
      Origin = 'flnatureza'
    end
    object Qryidpessoa: TLargeintField
      FieldName = 'idpessoa'
      Origin = 'idpessoa'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object Qrynmprimeiro: TWideStringField
      FieldName = 'nmprimeiro'
      Origin = 'nmprimeiro'
      Size = 100
    end
    object Qrynmsegundo: TWideStringField
      FieldName = 'nmsegundo'
      Origin = 'nmsegundo'
      Size = 100
    end
    object Qrydscep: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'dscep'
      Origin = 'dscep'
      Size = 15
    end
    object Qrydscomplemento: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'dscomplemento'
      Origin = 'dscomplemento'
      Size = 100
    end
    object Qrydsuf: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'dsuf'
      Origin = 'dsuf'
      Size = 50
    end
    object Qryidendereco: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'idendereco'
      Origin = 'idendereco'
    end
    object Qrynmbairro: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmbairro'
      Origin = 'nmbairro'
      Size = 50
    end
    object Qrynmcidade: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmcidade'
      Origin = 'nmcidade'
      Size = 100
    end
    object Qrynmlogradouro: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmlogradouro'
      Origin = 'nmlogradouro'
      Size = 100
    end
  end
  object DsPessoa: TDataSource
    DataSet = Qry
    OnDataChange = DsPessoaDataChange
    Left = 324
    Top = 234
  end
end
