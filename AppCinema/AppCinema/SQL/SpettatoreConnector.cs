using AppCinema.Models;
using System.Data.SqlClient;

namespace AppCinema.SQL
{
    public class SpettatoreConnector
    {
        private string _connectionString;
        public SpettatoreConnector(string connectionString)
        {
            _connectionString = connectionString;
        }
        public SpettatoreModel GetSpettatoreById(int id)
        {
            var query = "SELECT * FROM Spettatore WHERE IdSpettatore = @id;";
            using var connection = new SqlConnection(_connectionString);
            connection.Open();
            using var command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@id", id);

            using var reader = command.ExecuteReader();
            if (reader.Read())
            {
                return new SpettatoreModel()
                {
                    IdSpettatore = int.Parse(reader["IdSpettatore"].ToString()),
                    Nome = reader["Nome"].ToString(),
                    Cognome = reader["Cognome"].ToString(),
                    IdBiglietto = int.Parse(reader["IdBiglietto"].ToString()),
                    DataNascita = DateTime.Parse(reader["IdBiglietto"].ToString())
                };
            }
            else return null;
        }

        public int AddSpettatore(SpettatoreModel spettatore)
        {
            string sql = @"insert into Spettatore
                            values (@Nome, @Cognome, @DataNascita, @IdBiglietto)";
            using var connection = new SqlConnection(_connectionString);
            connection.Open();
            using var command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@Nome", spettatore.Nome);
            command.Parameters.AddWithValue("@Cognome", spettatore.Cognome);
            command.Parameters.AddWithValue("@DataNascita", spettatore.DataNascita);
            command.Parameters.AddWithValue("@IdBiglietto", spettatore.IdBiglietto);

            return command.ExecuteNonQuery();
        }
    }
}
