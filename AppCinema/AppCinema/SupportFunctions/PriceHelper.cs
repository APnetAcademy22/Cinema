using AppCinema.Models;

namespace AppCinema.SupportFunctions
{
    public class PriceHelper
    {
        public static decimal ComputePrice(SpettatoreModel spettatore)
        {
            TimeSpan age = DateTime.Now - spettatore.DataNascita;
            switch (age.TotalDays / 365)
            {
                case < 5: return 4.00M;
                case > 70: return 3.50M;
                default: return 5.00M;
            }
        }
    }
}
