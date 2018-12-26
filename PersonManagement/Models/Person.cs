using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PersonManagement.Models
{
    [Table("Person")]
    public class Person
    {
        [Key]
        public int Person_Id { get; set; }
        [MaxLength(50)]
        [Required]
        public string First_Name { get; set; }
        [MaxLength(50)]
        [Required]
        public string Last_Name { get; set; }
        [Required]
        public int State_Id { get; set; }
        public string State_Code { get; set; }
        [Required]
        public string Gender { get; set; }
        [Required]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime Dob { get; set; }
    }
}