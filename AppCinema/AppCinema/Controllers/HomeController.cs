using AppCinema.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using AppCinema.Models;
using AppCinema.SQL;
using AppCinema.Exceptions;
using AppCinema.SupportFunctions;

namespace AppCinema.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly FilmConnector _filmConnector;
        private readonly IncassoConnector _incassoConnector;
        private readonly BigliettoConnector _bigliettoConnector;
        private readonly SalaConnector _salaConnector;
        private readonly SpettatoreConnector _spettatoreConnector;

        public HomeController(ILogger<HomeController> logger,
                                FilmConnector filmConnector,
                                IncassoConnector incassoConnector,
                                BigliettoConnector biglietto,
                                SalaConnector salaConnector,
                                SpettatoreConnector spettatoreConnector)
        {
            _logger = logger;
            _filmConnector = filmConnector;
            _incassoConnector = incassoConnector;
            _bigliettoConnector = biglietto;
            _spettatoreConnector = spettatoreConnector;
            _salaConnector = salaConnector;
        }

        [HttpGet]
        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public IActionResult AggiungiSpettatore()
        {
            return View();
        }

        [HttpGet]
        public IActionResult SalaPiena()
        {
            return View();
        }

        [HttpPost]
        public IActionResult AggiungiSpettatore(IngressoViewModel ingresso)
        {
            int posto;
            try 
            {
                posto = _salaConnector.AddSpettatore(ingresso.SalaSelezionata.IdSala);
            }
            catch (SalaAlCompletoException)
            {
                return View(SalaPiena);
            }
            BigliettoModel biglietto = new BigliettoModel()
            {
                IdSala = ingresso.SalaSelezionata.IdSala,
                Posto = posto,
                Prezzo = PriceHelper.ComputePrice(ingresso.Spettatore),
                Valido = true
            };
            ingresso.Spettatore.IdBiglietto = _bigliettoConnector.AddBiglietto(biglietto);
            _spettatoreConnector.AddSpettatore(ingresso.Spettatore);
            return RedirectToAction("Index");
        }

        [HttpGet]
        public IActionResult AggiungiIncasso()
        {
            return View();
        }

        [HttpPost]
        public IActionResult AggiungiIncasso(SalaModel Sala)
        {
            decimal incasso = _bigliettoConnector.GetIncassoSala(Sala.IdSala);
            _bigliettoConnector.InvalidUsedBiglietti(Sala.IdSala);
            _salaConnector.SvuotaSala(Sala.IdSala);
            _incassoConnector.AddIncasso(Sala.IdSala, incasso);
            return RedirectToAction("Index");
        }

        [HttpGet]
        public IActionResult Statistiche()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}