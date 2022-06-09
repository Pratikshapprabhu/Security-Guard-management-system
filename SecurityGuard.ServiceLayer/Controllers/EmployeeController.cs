using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SecurityGuards.ServiceLayer.Models;
using SecurityGuard.DataAccessLayer;
using SecurityGuard.DataAccessLayer.Models;

namespace SecurityGuard.ServiceLayer.Controllers
{
    //[Route("api/[controller]")]
    //[ApiController]
    public class EmployeeController : Controller
    {
        SecurityGuardRepository repository;
        public EmployeeController()
        {
            repository = new SecurityGuardRepository();
        }

        [Route("api/addEmployee")]
        [HttpPost]
        public JsonResult addEmployee(Employee empObj)
        {
            int registerstatus;
            string message = "dont know";

            try
            {
                Console.WriteLine(empObj.Email);
                var dal = new SecurityGuardRepository();
                registerstatus = dal.AddEmployee(empObj.EmpName, empObj.Email, empObj.Address, empObj.City, empObj.PinCode, empObj.Pan, empObj.AdharNumber, empObj.Photo, empObj.RoleId);
                if (registerstatus == 1)
                {
                    message = "Employee details addedd successfully";
                }
                else if (registerstatus == -1)
                    message = "Enter emailId";
                else if (registerstatus == -2)
                    message = "EmailId is present in database..please login";
                else if (registerstatus == -3)
                    message = "Enter Email in proper format";
                else if (registerstatus == -4)
                    message = "Enter Name only in letters";
                else if (registerstatus == -5)
                    message = "Enter Name";
                else if (registerstatus == -6)
                    message = "Enter Address";
                else if (registerstatus == -7)
                    message = "Enter cityname";
                else if (registerstatus == -8)
                    message = "Enter pincode";
                else if (registerstatus == -9)
                    message = "Enter pancard number";
                else if (registerstatus == -10)
                    message = "Enter adharcard number";
                else if (registerstatus == -11)
                    message = "Enter Photo link";
                else if (registerstatus == -12)
                    message = "Enter roleId";
                else if (registerstatus == -13)
                    message = "Enter adhar number";
                //else if (registerstatus == -14)
                //    message = "Enter valid PhoneNumber";
                else if (registerstatus == -99)
                    message = "Exception in sql";
                else
                    message = "Not added" + registerstatus;
            }
            catch (Exception)
            {
                registerstatus = 0;
                message = "This is exception";
            }
            return Json(message);
        }
    }
}
