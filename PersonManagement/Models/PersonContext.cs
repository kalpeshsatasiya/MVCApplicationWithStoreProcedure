using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace PersonManagement.Models
{
    public class PersonContext : DbContext
    {
        public PersonContext() : base("PersonConnectionString")
        {

        }

        public DbSet<States> States { get; set; }
        public DbSet<Person> Person { get; set; }
    }
}