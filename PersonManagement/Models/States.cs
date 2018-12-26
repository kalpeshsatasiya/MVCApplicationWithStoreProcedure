using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PersonManagement.Models
{
    [Table("states")]
    public class States
    {
        [Key]
        public int State_Id { get; set; }
        public string State_Code { get; set; }
    }
}