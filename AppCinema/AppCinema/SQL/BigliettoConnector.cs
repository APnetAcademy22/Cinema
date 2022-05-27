using AppCinema.Models;
using System.Data.SqlClient;

namespace AppCinema.SQL
{
    public class BigliettoConnector
    {
        private string _connectionString;
        public BigliettoConnector(string connectionString)
        {
            _connectionString = connectionString;
        }
        public BigliettoModel GetBigliettoById(int id)
        {
            var query = "select * from Biglietto where IdBiglietto=@id";
            using var connection = new SqlConnection(_connectionString);
            connection.Open();
            using var command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("id", id);

            using var reader = command.ExecuteReader();
            if (reader.Read())
            {
                return new BigliettoModel()
                {
                    IdBiglietto = int.Parse(reader["IdBiglietto"].ToString()),
                    Posto = int.Parse(reader["Posto"].ToString()),
                    IdSala = int.Parse(reader["IdSala"].ToString()),
                    Prezzo = decimal.Parse(reader["Prezzo"].ToString()),
                    Valido = int.Parse(reader["Valido"].ToString()) != 0
                };
            }
            else return null;
        }

        public int AddBiglietto(BigliettoModel biglietto)
        {
            string sql = @"insert into Biglietto
                            values (@IdBiglietto, @Posto, @IdSala, @Prezzo, @Valido)";
            using var connection = new SqlConnection(_connectionString);
            connection.Open();
            using var command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@IdBiglietto", biglietto.IdBiglietto);
            command.Parameters.AddWithValue("@Posto", biglietto.Posto);
            command.Parameters.AddWithValue("@IdSala", biglietto.IdSala);
            command.Parameters.AddWithValue("@Prezzo", biglietto.Prezzo);
            command.Parameters.AddWithValue("@Valido", biglietto.Valido?1:0 );

            return command.ExecuteNonQuery();
        }

        public int InvalidUsedBiglietti(int idSala)
        {
            string sql = @"UPDATE Biglietto SET Valido = 0 WHERE IdSala = @idSala;";
            using var connection = new SqlConnection(_connectionString);
            connection.Open();
            using var command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@IdSala", idSala);

            return command.ExecuteNonQuery();
        }

        public decimal GetIncassoSala(int idSala)
        {
            string sql = @"select sum(prezzo) as Incasso from Biglietto where valido = 1 AND IdSala = @IdSala ;";
            using var connection = new SqlConnection(_connectionString);
            connection.Open();
            using var command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@IdSala", idSala);

            using var reader = command.ExecuteReader();
            return decimal.Parse(reader["Incasso"].ToString());
        }
    }
}
