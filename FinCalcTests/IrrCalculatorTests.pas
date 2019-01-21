unit IrrCalculatorTests;

interface
uses
  DUnitX.TestFramework, IRRCalculator, Math;

type

  [TestFixture]
  TIrrCalculatorTests = class(TObject)
  public
    [Test]
    [TestCase('PresentValue','-1,0,0')]
    [TestCase('Rate','0,-1,0')]
    [TestCase('Periods','0,0,-1')]
    procedure NegativeInputParametersReturnNan(const PresentValue : Double;
      const Payment : Double; const Periods : Integer);

    [Test]
    [TestCase('OnePeriodZeroPayment','100,0,1')]
    [TestCase('TenPeriodsZeroPayments','100,0,10')]
    [TestCase('OneHundredPeriodsZeroPayment','100,0,100')]
    [TestCase('OnePeriodZeroPresent','0,100,1')]
    [TestCase('TenPeriodsZeroPresent','0,100,10')]
    [TestCase('OneHundredPeriodsZeroPresent','0,100,100')]
    [TestCase('ZeroPeriod','100,100,0')]
    procedure ZeroPresentPaymentOrPeriodsReturnsNan(const PresentValue, Payment : Double;
      const Periods : Integer);

    [Test]
    [TestCase('OnePeriod','100,99,1')]
    [TestCase('TenPeriods','100,9,10')]
    [TestCase('OneHundredPeriods','100,0.9,100')]
    procedure PaymentsLessThanPresentReturnsMinus1(const PresentValue, Payment : Double;
      const Periods : Integer);

    [Test]
    [TestCase('OnePeriod','100,100,1')]
    [TestCase('TenPeriods','100,10,10')]
    [TestCase('OneHundredPeriods','100,1,100')]
    procedure PaymentsEqualsPresentReturnsZero(const PresentValue, Payment : Double;
      const Periods : Integer);

    [Test]
    [TestCase('OnePeriodOnePercent','100,101,1,0.01')]
    [TestCase('OnePeriodTenPercent','100,110,1,0.10')]
    [TestCase('OnePeriodHundredPercent','100,200,1,1.00')]
    [TestCase('TenPeriodOnePercent','100,10.56,10,0.01')]
    [TestCase('TenPeriodTenPercent','100,16.27,10,0.10')]
    [TestCase('TenPeriodHundredPercent','100,100.1,10,1.00')]
    [TestCase('HundredPeriodOnePercent','100,1.59,100,0.01')]
    [TestCase('HundredPeriodTenPercent','100,10,100,0.10')]
    [TestCase('HundredPeriodTwentyPercent','100,20,100,0.2')]
    procedure VariablePeriodTests(const PresentValue : Double;
      const Payment : Double; const Periods : Integer; const Expected : Double);

  end;

implementation

procedure TIrrCalculatorTests.NegativeInputParametersReturnNan(const PresentValue,
  Payment: Double; const Periods: Integer);
begin
  var result := CalculateIrr(PresentValue,Payment,Periods);
  Assert.IsTrue(IsNan(result));
end;

procedure TIrrCalculatorTests.PaymentsEqualsPresentReturnsZero(
  const PresentValue, Payment: Double; const Periods: Integer);
begin
  var result := CalculateIrr(PresentValue,Payment,Periods);
  Assert.IsFalse(IsNan(Result));
  Assert.AreEqual(0,Double(result),0.01);
end;

procedure TIrrCalculatorTests.PaymentsLessThanPresentReturnsMinus1(
  const PresentValue, Payment: Double; const Periods: Integer);
begin
  var result := CalculateIrr(PresentValue,Payment,Periods);
  Assert.IsFalse(IsNan(Result));
  Assert.AreEqual(-1,Double(result),0.01);
end;

procedure TIrrCalculatorTests.VariablePeriodTests(const PresentValue, Payment: Double;
  const Periods: Integer; const Expected: Double);
begin
  var result := CalculateIrr(PresentValue,Payment,Periods);
  Assert.IsFalse(IsNan(Result));
  Assert.AreEqual(Expected,Double(result),0.01);
end;

procedure TIrrCalculatorTests.ZeroPresentPaymentOrPeriodsReturnsNan(const PresentValue,
  Payment: Double; const Periods: Integer);
begin
  var result := CalculateIrr(PresentValue,Payment,Periods);
  Assert.IsTrue(IsNan(result));
end;


initialization
  TDUnitX.RegisterTestFixture(TIrrCalculatorTests);
end.
