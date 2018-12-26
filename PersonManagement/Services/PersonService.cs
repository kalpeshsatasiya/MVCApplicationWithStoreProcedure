using PersonManagement.Models;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;

namespace PersonManagement.Services
{
    public class PersonService : IPersonService
    {
        private readonly PersonContext db;
        public PersonService()
        {
            db = new PersonContext();
        }

        public List<Person> SearchPerson(string name)
        {
            var nameParam = new SqlParameter
            {
                ParameterName = "name",
                Value = name
            };
            return db.Database.SqlQuery<Person>("uspPersonSearch @name", nameParam).ToList<Person>();
        }

        public Person GetPerson(int person_Id)
        {
            var namePersonId = new SqlParameter
            {
                ParameterName = "person_Id",
                Value = person_Id
            };
            return db.Database.SqlQuery<Person>("uspPersonGet @person_Id", namePersonId).ToList<Person>()[0];
        }

        public int AddEdit(Person person)
        {
            try
            {
                var result = db.Database.ExecuteSqlCommand("uspPersonUpsert @person_Id={0}, @first_name={1}, @last_name={2}, @gender={3}, @state_Id={4}, @dob={5}",
                    person.Person_Id,
                    person.First_Name,
                    person.Last_Name,
                    person.Gender,
                    person.State_Id,
                    person.Dob
                    );
            }
            catch (System.Exception)
            {
                return 0;
            }
            return 1;
        }
    }
}