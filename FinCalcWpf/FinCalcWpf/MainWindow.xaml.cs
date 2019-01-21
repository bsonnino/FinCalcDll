using System;
using System.Runtime.InteropServices;
using System.Windows;
using System.Windows.Controls;

namespace FinCalcWpf
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        [DllImport("FinCalcDll.dll")]
        private static extern double CalculatePV(double futureValue, double interestRate, int numPeriods);

        [DllImport("FinCalcDll.dll")]
        private static extern double CalculateFV(double presentValue, double interestRate, int numPeriods);

        [DllImport("FinCalcDll.dll")]
        private static extern double CalculatePmt(double presentValue, double interestRate, int numPeriods);

        [DllImport("FinCalcDll.dll")]
        private static extern double CalculateIRR(double presentValue, double payment, int numPeriods);

        public MainWindow()
        {
            InitializeComponent();
            if (Environment.Is64BitProcess)
                Title += "(64 bit)";
        }

        private void PvOnTextChanged(object sender, TextChangedEventArgs e)
        {
            if (double.TryParse(PvFvBox.Text, out double futureValue) &&
                double.TryParse(PvIrBox.Text, out double interestRate) &&
                int.TryParse(PvNpBox.Text, out int numPeriods))
              PvPvBox.Text = CalculatePV(futureValue, interestRate / 100.0, numPeriods).ToString("N2");
        }

        private void FvOnTextChanged(object sender, TextChangedEventArgs e)
        {
            if (double.TryParse(FvPvBox.Text, out double presentValue) &&
                double.TryParse(FvIrBox.Text, out double interestRate) &&
                int.TryParse(FvNpBox.Text, out int numPeriods))
                FvFvBox.Text = CalculateFV(presentValue, interestRate / 100.0, numPeriods).ToString("N2");
        }

        private void PmtOnTextChanged(object sender, TextChangedEventArgs e)
        {
            if (double.TryParse(PmtPvBox.Text, out double presentValue) &&
                double.TryParse(PmtIrBox.Text, out double interestRate) &&
                int.TryParse(PmtNpBox.Text, out int numPeriods))
                PmtPmtBox.Text = CalculatePmt(presentValue, interestRate / 100.0, numPeriods).ToString("N2");
        }

        private void RrOnTextChanged(object sender, TextChangedEventArgs e)
        {
            if (double.TryParse(RrPvBox.Text, out double presentValue) &&
                double.TryParse(RrPmtBox.Text, out double payment) &&
                int.TryParse(RrNpBox.Text, out int numPeriods))
                RrRrBox.Text = (CalculateIRR(presentValue, payment, numPeriods)*100.0).ToString("N2");
        }
    }
}
