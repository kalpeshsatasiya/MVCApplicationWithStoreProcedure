using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using PersonManagement.Models;
using PersonManagement.Services;

namespace PersonManagement.Controllers
{
    public class PersonController : Controller
    {
        private PersonContext db = new PersonContext();
        private readonly IPersonService personService;
        private readonly IStateService stateService;

        public PersonController()
        {
            personService = new PersonService();
            stateService = new StateService();
        }

        // GET: Person
        public ActionResult Index(string name = "")
        {
            ViewBag.Name = name;
            var person = personService.SearchPerson(name);
            return View(person);
        }

        // GET: Person/AddEdit/{id?}
        public PartialViewResult AddEdit(int? id)
        {
            Person person = new Person();
            if (id > 0)
            {
                person = personService.GetPerson(Convert.ToInt32(id));
            }
            ViewBag.States = stateService.GetAll().Select(x => new SelectListItem() { Value = Convert.ToString(x.State_Id), Text = x.State_Code });
            ViewBag.Gender = new List<SelectListItem>()
            {
                new SelectListItem(){ Text="Male", Value="M"},
                new SelectListItem(){ Text="Female", Value="F"}
            };
            return PartialView("AddEdit", person);
        }

        // POST: Person/AddEdit
        [HttpPost]
        public ActionResult AddEdit(Person person)
        {
            if (ModelState.IsValid)
            {
                if (personService.AddEdit(person) == 1)
                    return Json(new { App_msg = "Save Successful", isSuccess = true });
                else
                    return Json(new { App_msg = "Error!!", isSuccess = false });
            }
            return Json(new { App_msg = "Error!!", isSuccess = false });
        }
      
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
