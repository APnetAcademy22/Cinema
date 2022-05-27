using AppCinema.Models;
using System.Data.SqlClient;

namespace AppCinema.SQL
{
    public class FilmConnector
    {
        private string _connectionString;
        public FilmConnector(string connectionString)
        {
            _connectionString = connectionString;
        }
        public FilmModel GetFilmById(int id)
        {
            var query = "SELECT * FROM Film WHERE IdFilm = @id;";
            using var connection = new SqlConnection(_connectionString);
            connection.Open();
            using var command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@id", id);

            using var reader = command.ExecuteReader();
            if (reader.Read())
            {
                return new FilmModel()
                {
                    IdFilm = int.Parse(reader["IdFilm"].ToString()),
                    Titolo = reader["Titolo"].ToString(),
                    Autore = reader["Autore"].ToString(),
                    Produttore = reader["Produttore"].ToString(),
                    Genere = reader["Genere"].ToString(),
                    Durata = decimal.Parse(reader["Durata"].ToString())
                };
            }
            else return null;
        }

        
    }
}
