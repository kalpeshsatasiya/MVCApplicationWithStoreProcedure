using PersonManagement.Models;
using System.Collections.Generic;

namespace PersonManagement.Services
{
    public interface IPersonService
    {
        List<Person> SearchPerson(string name);
        Person GetPerson(int person_Id);
        int AddEdit(Person person);
    }
}