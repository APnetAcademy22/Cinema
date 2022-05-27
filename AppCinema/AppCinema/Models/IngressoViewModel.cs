namespace AppCinema.Models
{
    public class IngressoViewModel
    {
        public SpettatoreModel Spettatore { get; set; }
        //public Dictionary<SalaModel,FilmModel> Sale { get; set; } //not implemented yet
        public SalaModel SalaSelezionata { get; set; }
    }
}
