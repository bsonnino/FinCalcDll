unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.WindowsStore, Vcl.StdCtrls, Vcl.ComCtrls, Math;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet3: TTabSheet;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    FvPresentValue: TEdit;
    IrPresentValue: TEdit;
    PvPresentValue: TEdit;
    NpPresentValue: TEdit;
    TabSheet4: TTabSheet;
    Label9: TLabel;
    Label16: TLabel;
    Label12: TLabel;
    Label10: TLabel;
    PvFutureValue: TEdit;
    IrFutureValue: TEdit;
    FvFutureValue: TEdit;
    NpFutureValue: TEdit;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    PvPayment: TEdit;
    IRPayment: TEdit;
    NpPayment: TEdit;
    PmtPayment: TEdit;
    TabSheet2: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    PvIRR: TEdit;
    PmtIRR: TEdit;
    NpIRR: TEdit;
    IRIRR: TEdit;
    WindowsStore1: TWindowsStore;
    procedure PaymentChange(Sender: TObject);
    procedure PresentValueChange(Sender: TObject);
    procedure FutureValueChange(Sender: TObject);
    procedure IRRChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function CalculatePV(FutureValue, InterestRate : Double;NumPeriods : Integer) :
  Double; stdcall; external 'FinCalcDll.dll';

function CalculateFV(PresentValue, InterestRate : Double;NumPeriods : Integer) :
  Double; stdcall; external 'FinCalcDll.dll';

function CalculateIRR(PresentValue, Payment: Double;NumPeriods : Integer) :
  Double; stdcall; external 'FinCalcDll.dll';

function CalculatePmt(PresentValue, InterestRate : Double;NumPeriods : Integer) :
  Double; stdcall; external 'FinCalcDll.dll';

procedure TForm1.PaymentChange(Sender: TObject);
begin
  try
    var PresentValue := StrToFloat(PvPayment.Text);
    var InterestRate := StrToFloat(IRPayment.Text) / 100.0;
    var NumPayments := StrToInt(NpPayment.Text);
    var Payment := CalculatePmt(PresentValue,InterestRate, NumPayments);
    PmtPayment.Text := FormatFloat('0.00', Payment);
  except
    On EConvertError do
      PmtPayment.Text := '';
  end;
end;

procedure TForm1.PresentValueChange(Sender: TObject);
begin
  try
    var FutureValue := StrToFloat(FvPresentValue.Text);
    var InterestRate := StrToFloat(IrPresentValue.Text) / 100.0;
    var NumPeriods := StrToInt(NpPresentValue.Text);
    var PresentValue := CalculatePV(FutureValue, InterestRate, NumPeriods);
    if IsNan(PresentValue) then
      PvPresentValue.Text := ''
    else
      PvPresentValue.Text := FormatFloat('0.00', PresentValue);
  except
    On EConvertError do
      PvPresentValue.Text := '';
  end;
end;

procedure TForm1.IRRChange(Sender: TObject);
begin
  try
    var NumPayments := StrToInt(NpIRR.Text);
    var PresentValue := StrToFloat(PvIRR.Text);
    var Payment := StrToFloat(PmtIRR.Text);
    var Rate := CalculateIRR(PresentValue, Payment, NumPayments);
    if Rate < 0 then begin
      IRIRR.Text := 'Rate Less than 0';
      exit;
    end;
    if IsNan(Rate) then begin
      IRIRR.Text := 'Error calculating rate';
      exit;
    end;
    IRIRR.Text := FormatFloat('0.00', Rate * 100.0);
  except
    On EConvertError do
      IRIRR.Text := '';
  end;
end;

procedure TForm1.FutureValueChange(Sender: TObject);
begin
  try
    var PresentValue := StrToFloat(PvFutureValue.Text);
    var InterestRate := StrToFloat(IrFutureValue.Text) / 100.0;
    var NumPeriods := StrToInt(NpFutureValue.Text);
    var FutureValue := CalculateFV(PresentValue,InterestRate, NumPeriods);
    if IsNan(FutureValue) then
      FvFutureValue.Text := ''
    else
      FvFutureValue.Text := FormatFloat('0.00', FutureValue);
  except
    On EConvertError do
      FvFutureValue.Text := '';
  end;
end;

end.
