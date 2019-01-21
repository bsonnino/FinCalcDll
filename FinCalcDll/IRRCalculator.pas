unit IRRCalculator;

interface

Uses Math;

function CalculateIRR(PresentValue, Payment: Double;NumPeriods : Integer):
  Double; stdcall;

implementation

function CalculateIRR(PresentValue, Payment: Double;NumPeriods : Integer):
  Double;
begin
  if (PresentValue <= 0) or (Payment <= 0) or (NumPeriods <= 0) then begin
    Result := NaN;
    exit;
  end;
  Result := Nan;
  try
    var FoundRate := False;
    var MinRate := 0.0;
    var MaxRate := 1.0;
    if Payment * NumPeriods < PresentValue then begin
      Result := -1;
      exit;
    end;
    if Payment * NumPeriods = PresentValue then begin
      Result := 0;
      exit;
    end;
    while not FoundRate do begin
      var Rate := (MaxRate + MinRate) / 2.0;
      var SumPayments := 0.0;
      for var I := 1 to NumPeriods do
        SumPayments := SumPayments + Payment / Power((1 + Rate), I);
      if Abs(SumPayments - PresentValue) > 0.01 then begin
        if PresentValue < SumPayments then begin
          MinRate := Rate;
        end
        else begin
          MaxRate := Rate;
        end;
      end
      else begin
        FoundRate := True;
        Result := Rate;
      end;
    end;
  except
  end;
end;

end.
