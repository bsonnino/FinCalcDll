unit PVCalculatorTests;

interface

uses
  DUnitX.TestFramework, PVCalculator, Math;

type

  [TestFixture]
  TPvCalculatorTests = class(TObject)
  public
    [Test]
    [TestCase('FutureValue','-1,0,0')]
    [TestCase('Rate','0,-1,0')]
    [TestCase('Periods','0,0,-1')]
    procedure NegativeInputParametersReturnNan(const FutureValue : Double;
      const Rate : Double; const Periods : Integer);

    [Test]
    [TestCase('OnePeriod','100,1')]
    [TestCase('TenPeriods','100,10')]
    [TestCase('OneHundredPeriods','100,100')]
    procedure ZeroRatePresentValueEqualsFutureValue(const FutureValue : Double;
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
    procedure ZeroFutureValueEqualsZeroPresentValue(const Rate : Double;
      const Periods : Integer);

    [Test]
    [TestCase('OnePeriodOnePercent','100,0.01,1,99.01')]
    [TestCase('OnePeriodTenPercent','100,0.10,1,90.91')]
    [TestCase('OnePeriodHundredPercent','100,1.00,1,50')]
    [TestCase('TenPeriodOnePercent','100,0.01,10,90.53')]
    [TestCase('TenPeriodTenPercent','100,0.10,10,38.55')]
    [TestCase('TenPeriodHundredPercent','100,1.00,10,0.10')]
    [TestCase('HundredPeriodOnePercent','100,0.01,100,36.97')]
    [TestCase('HundredPeriodTenPercent','100,0.10,100,0.01')]
    [TestCase('HundredPeriodHundredPercent','100,1.00,100,0.00')]
    procedure VariablePeriodTests(const FutureValue : Double;
      const Rate : Double; const Periods : Integer; const Expected : Double);

  end;

implementation

procedure TPvCalculatorTests.NegativeInputParametersReturnNan(const FutureValue,
  Rate: Double; const Periods: Integer);
begin
  var result := CalculatePv(FutureValue,Rate,Periods);
  Assert.IsTrue(IsNan(result));
end;

procedure TPvCalculatorTests.VariablePeriodTests(const FutureValue, Rate: Double;
  const Periods: Integer; const Expected: Double);
begin
  var result := CalculatePv(FutureValue,Rate,Periods);
  Assert.AreEqual(Expected,Double(result),0.01);
end;

procedure TPvCalculatorTests.ZeroFutureValueEqualsZeroPresentValue(
  const Rate: Double; const Periods: Integer);
begin
  var result := CalculatePv(0,Rate,Periods);
  Assert.AreEqual(Double(0.0),Double(result),0.01);
end;

procedure TPvCalculatorTests.ZeroRatePresentValueEqualsFutureValue(
  const FutureValue: Double; const Periods: Integer);
begin
  var result := CalculatePv(FutureValue,0,Periods);
  Assert.AreEqual(FutureValue,Double(result),0.01);
end;

initialization
  TDUnitX.RegisterTestFixture(TPvCalculatorTests);
end.
