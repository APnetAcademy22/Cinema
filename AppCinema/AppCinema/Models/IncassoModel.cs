namespace AppCinema.Models
{
    public class IncassoModel
    {
        public int IdIncasso { get; set; }
        public int IdSala { get; set; }
        public decimal Incasso { get; set; }
        public DateTime Data { get; set; }
    }
}
