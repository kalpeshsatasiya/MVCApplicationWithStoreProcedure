using PersonManagement.Models;
using System.Collections.Generic;
using System.Linq;

namespace PersonManagement.Services
{
    public class StateService : IStateService
    {
        private readonly PersonContext db;
        public StateService()
        {
            db = new PersonContext();
        }

        public List<States> GetAll()
        {
            return db.Database.SqlQuery<States>("uspStatesList").ToList<States>();
        }
        
    }
}