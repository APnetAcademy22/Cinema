using System.Data.SqlClient;
using AppCinema.Models;
using AppCinema.Exceptions;

namespace AppCinema.SQL
{
    public class SalaConnector
    {
        private string _connectionString;
        public SalaConnector(string connectionString)
        {
            _connectionString = connectionString;
        }
        public SalaModel GetSalaById(int id)
        {
            var query = "SELECT * FROM Sala WHERE Id = @id";
            using var connection = new SqlConnection(_connectionString);
            connection.Open();
            using var command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@id", id);

            using var reader = command.ExecuteReader();
            if (reader.Read())
            {
                return new SalaModel()
                {
                    IdSala = int.Parse(reader["IdSala"].ToString()),
                    Capienza = int.Parse(reader["Capienza"].ToString()),
                    PostiOccupati = int.Parse(reader["PostiOccupati"].ToString()),
                    Cinema = reader["Cinema"].ToString(),
                    IdFilm = int.Parse(reader["IdFilm"].ToString()),
                };
            }
            else return null;
        }

        public int AddSpettatore(int idSala)
        {
            SalaModel sala = GetSalaById(idSala);
            if (sala.PostiOccupati >= sala.Capienza)
            {
                throw new SalaAlCompletoException("Sala Piena!");
            }
            else
            {
                string sql = @"Update  Sala
                                set PostiOccupati = PostiOccupati + 1
                                where IdSala = @IdSala";
                using var connection = new SqlConnection(_connectionString);
                connection.Open();
                using var command = new SqlCommand(sql, connection);
                command.Parameters.AddWithValue("@IdSala", idSala);

                return command.ExecuteNonQuery();
            }
        }

        public int SvuotaSala(int idSala)
        {

            string sql = @"Update  Sala
                                set PostiOccupati = 0
                                where IdSala = @IdSala";
            using var connection = new SqlConnection(_connectionString);
            connection.Open();
            using var command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@IdSala", idSala);

            return command.ExecuteNonQuery();
        }
    }
}
