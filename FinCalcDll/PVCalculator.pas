unit PVCalculator;

interface

Uses Math;

function CalculatePV(FutureValue, InterestRate: Double; NumPeriods : Integer):
  double; stdcall;

implementation

function CalculatePV(FutureValue, InterestRate: Double; NumPeriods : Integer):
  double;
begin
  if (FutureValue < 0) or (InterestRate < 0) or (NumPeriods < 0) then begin
    Result := NaN;
    exit;
  end;
  try
    Result := FutureValue / Power((1 + InterestRate), NumPeriods);
  except
    Result := NaN;
  end;
end;

end.
