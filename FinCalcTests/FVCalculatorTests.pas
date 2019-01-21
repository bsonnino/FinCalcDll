unit FVCalculatorTests;

interface

uses
  DUnitX.TestFramework, FvCalculator, Math;

type

  [TestFixture]
  TFvCalculatorTests = class(TObject)
  private
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
    procedure ZeroRateFutureValueEqualsPresentValue(const PresentValue : Double;
      const Periods : Integer);

    [Test]
    [TestCase('OnePeriodOnePercent','0.01,1')]
    [TestCase('OnePeriodTenPercent','0.10,1')]
    [TestCase('OnePeriodHundredPercent','1.00,1')]
    [TestCase('TenPeriodOnePercent','0.01,10')]
    [TestCase('TenPeriodTenPercent','0.10,10')]
    [TestCase('TenPeriodHundredPercent','1.00,10')]
    [TestCase('HundredPeriodOnePercent','0.01,100')]
    [TestCase('HundredPeriodTenPercent','0.10,100')]
    [TestCase('HundredPeriodHundredPercent','1.00,100')]
    procedure ZeroPresentValueEqualsZeroFutureValue(const Rate: Double;
      const Periods: Integer);

    [Test]
    [TestCase('OnePeriodOnePercent','100,0.01,1,101')]
    [TestCase('OnePeriodTenPercent','100,0.10,1,110')]
    [TestCase('OnePeriodHundredPercent','100,1.00,1,200')]
    [TestCase('TenPeriodOnePercent','100,0.01,10,110.46')]
    [TestCase('TenPeriodTenPercent','100,0.10,10,259.37')]
    [TestCase('TenPeriodHundredPercent','100,1.00,10,102400')]
    [TestCase('HundredPeriodOnePercent','100,0.01,100,270.48')]
    [TestCase('HundredPeriodTenPercent','100,0.10,100,1378061.23')]
    [TestCase('HundredPeriodTwentyPercent','100,0.2,100,8281797452.20')]
    procedure VariablePeriodTests(const PresentValue : Double;
      const Rate : Double; const Periods : Integer; const Expected : Double);

  end;

implementation

procedure TFvCalculatorTests.NegativeInputParametersReturnNan(const PresentValue,
  Rate: Double; const Periods: Integer);
begin
  var result := CalculateFv(PresentValue,Rate,Periods);
  Assert.IsTrue(IsNan(result));
end;

procedure TFvCalculatorTests.VariablePeriodTests(const PresentValue, Rate: Double;
  const Periods: Integer; const Expected: Double);
begin
  var result := CalculateFv(PresentValue,Rate,Periods);
  Assert.IsTrue(Abs(Expected-Double(result)) < 0.01);
end;

procedure TFvCalculatorTests.ZeroPresentValueEqualsZeroFutureValue(
  const Rate: Double; const Periods: Integer);
begin
  var result := CalculateFv(0,Rate,Periods);
  Assert.AreEqual(Double(0.0),Double(result));
end;

procedure TFvCalculatorTests.ZeroRateFutureValueEqualsPresentValue(
  const PresentValue: Double; const Periods: Integer);
begin
  var result := CalculateFv(PresentValue,0,Periods);
  Assert.AreEqual(PresentValue,Double(result));
end;

initialization
  TDUnitX.RegisterTestFixture(TFvCalculatorTests);
end.

