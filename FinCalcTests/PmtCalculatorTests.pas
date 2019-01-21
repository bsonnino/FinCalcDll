unit PmtCalculatorTests;

interface
uses
  DUnitX.TestFramework, PmtCalculator, Math;

type

  [TestFixture]
  TPmtCalculatorTests = class(TObject)
  public
    [Test]
    [TestCase('PresentValue','-1,0,0')]
    [TestCase('Rate','0,-1,0')]
    [TestCase('Periods','0,0,-1')]
    procedure NegativeInputParametersReturnNan(const PresentValue : Double;
      const Rate : Double; const Periods : Integer);

    [Test]
    [TestCase('OnePeriod','100,1')]
    [TestCase('TenPeriods','100,10')]
    [TestCase('OneHundredPeriods','100,100')]
    procedure ZeroRatePmtEqualsPresentValueDivPeriods(const PresentValue : Double;
      const Periods : Integer);

    [Test]
    [TestCase('OnePercent','100,0.01')]
    [TestCase('TenPercent','100,0.10')]
    [TestCase('HundredPercent','100,1.00')]
    procedure ZeroPeriodsValueEqualsPresentValue(const PresentValue, Rate: Double);

    [Test]
    [TestCase('OnePeriodOnePercent','100,0.01,1,101')]
    [TestCase('OnePeriodTenPercent','100,0.10,1,110')]
    [TestCase('OnePeriodHundredPercent','100,1.00,1,200')]
    [TestCase('TenPeriodOnePercent','100,0.01,10,10.56')]
    [TestCase('TenPeriodTenPercent','100,0.10,10,16.27')]
    [TestCase('TenPeriodHundredPercent','100,1.00,10,100.1')]
    [TestCase('HundredPeriodOnePercent','100,0.01,100,1.59')]
    [TestCase('HundredPeriodTenPercent','100,0.10,100,10')]
    [TestCase('HundredPeriodTwentyPercent','100,0.2,100,20')]
    procedure VariablePeriodTests(const PresentValue : Double;
      const Rate : Double; const Periods : Integer; const Expected : Double);

  end;

implementation

procedure TPmtCalculatorTests.NegativeInputParametersReturnNan(const PresentValue,
  Rate: Double; const Periods: Integer);
begin
  var result := CalculatePmt(PresentValue,Rate,Periods);
  Assert.IsTrue(IsNan(result));
end;

procedure TPmtCalculatorTests.VariablePeriodTests(const PresentValue, Rate: Double;
  const Periods: Integer; const Expected: Double);
begin
  var result := CalculatePmt(PresentValue,Rate,Periods);
  Assert.IsTrue(Abs(Expected-Double(result)) < 0.01);
end;

procedure TPmtCalculatorTests.ZeroPeriodsValueEqualsPresentValue(
  const PresentValue, Rate: Double);
begin
  var result := CalculatePmt(PresentValue,Rate, 0);
  Assert.IsFalse(IsNan(Result));
  Assert.AreEqual(Double(PresentValue),Double(result),0.01);
end;

procedure TPmtCalculatorTests.ZeroRatePmtEqualsPresentValueDivPeriods(
  const PresentValue: Double; const Periods: Integer);
begin
  var result := CalculatePmt(PresentValue,0,Periods);
  Assert.IsFalse(IsNan(Result));
  Assert.AreEqual(Double(PresentValue/Periods),Double(result),0.01);
end;

initialization
  TDUnitX.RegisterTestFixture(TPmtCalculatorTests);
end.
