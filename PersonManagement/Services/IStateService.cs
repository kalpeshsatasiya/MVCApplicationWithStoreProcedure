using PersonManagement.Models;
using System.Collections.Generic;

namespace PersonManagement.Services
{
    public interface IStateService
    {
        List<States> GetAll();
    }
}