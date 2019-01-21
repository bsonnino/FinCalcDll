unit PmtCalculator;

interface

Uses Math;

function CalculatePmt(PresentValue, InterestRate: Double;NumPeriods : Integer):
  Double; stdcall;

implementation

function CalculatePmt(PresentValue, InterestRate: Double;NumPeriods : Integer):
  Double;
begin
  if (PresentValue < 0) or (InterestRate < 0) or (NumPeriods < 0) then begin
    Result := NaN;
    exit;
  end;
  try
    if InterestRate = 0 then
      Result := PresentValue/NumPeriods
    else if NumPeriods = 0 then
      Result := PresentValue
    else
      Result := (PresentValue * InterestRate) * Power((1 + InterestRate),
        NumPeriods) / (Power((1 + InterestRate), NumPeriods) - 1);
  except
    Result := Nan;
  end;
end;

end.
