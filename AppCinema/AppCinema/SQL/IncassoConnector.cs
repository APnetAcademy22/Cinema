using AppCinema.Models;
using System.Data.SqlClient;

namespace AppCinema.SQL
{
    public class IncassoConnector
    {
        private string _connectionString;
        public IncassoConnector(string connectionString)
        {
            _connectionString = connectionString;
        }

        public int AddIncasso(int idSala, decimal incasso)
        {
            string sql = @"insert into IncassiCinema values (@IdSala, @Incasso, @Data)";
            using var connection = new SqlConnection(_connectionString);
            connection.Open();
            using var command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@IdSala", idSala);
            command.Parameters.AddWithValue("@Incasso", incasso);
            command.Parameters.AddWithValue("@Data", DateTime.Now);

            return command.ExecuteNonQuery();
        }
    }
}
