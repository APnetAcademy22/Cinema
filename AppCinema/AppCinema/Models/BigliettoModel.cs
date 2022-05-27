namespace AppCinema.Models
{
    public class BigliettoModel
    {
        public int IdBiglietto { get; set; }
        public int Posto { get; set; }
        public int IdSala { get; set; }
        public decimal Prezzo { get; set; }
        public bool Valido { get; set; }
    }
}
