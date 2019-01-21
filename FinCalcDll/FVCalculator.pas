unit FVCalculator;

interface

Uses Math;

function CalculateFV(PresentValue, InterestRate: Double;NumPeriods : Integer):
  Double; stdcall;

implementation

function CalculateFV(PresentValue, InterestRate: Double;NumPeriods : Integer):
  Double;
begin
  if (PresentValue < 0) or (InterestRate < 0) or (NumPeriods < 0) then begin
    Result := NaN;
    exit;
  end;
  try
    Result := PresentValue * Power((1 + InterestRate), NumPeriods);
  except
    Result := NAN;
  end;
end;

end.
