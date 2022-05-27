namespace AppCinema.Models
{
    public class SpettatoreModel
    {
        public int IdSpettatore { get; set; }
        public string Nome { get; set; }
        public string Cognome { get; set; }
        public DateTime DataNascita { get; set; }
        public int IdBiglietto { get; set; }

    }
}
