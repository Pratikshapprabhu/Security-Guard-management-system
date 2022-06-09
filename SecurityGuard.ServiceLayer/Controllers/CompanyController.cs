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
    public class CompanyController : Controller
    {
        SecurityGuardRepository repository;
        public CompanyController()
        {
            repository = new SecurityGuardRepository();
        }
        [Route("api/addCompanyBranch")]
        [HttpPost]
        public JsonResult addCompanyBranch(CompanyBranch brachObj)
        {
            int registerstatus;
            string message = "dont know";

            try
            {
                Console.WriteLine(brachObj.BranchName);
                var dal = new SecurityGuardRepository();
                registerstatus = dal.AddCompanyBranch(brachObj.BranchName, brachObj.Address, brachObj.City, brachObj.PinCode);
                if (registerstatus == 1)
                {
                    message = "Company Banch details addedd successfully";
                }
                else if (registerstatus == -1)
                    message = "Enter BranchName";
                else if (registerstatus == -2)
                    message = "Address";
                else if (registerstatus == -3)
                    message = "Enter City";
                else if (registerstatus == -4)
                    message = "Enter Pincode";
                //else if (registerstatus == -5)
                //    message = "Enter Name";
                //else if (registerstatus == -6)
                //    message = "Enter Address";
                //else if (registerstatus == -7)
                //    message = "Enter cityname";
                //else if (registerstatus == -8)
                //    message = "Enter pincode";
                //else if (registerstatus == -9)
                //    message = "Enter pancard number";
                //else if (registerstatus == -10)
                //    message = "Enter adharcard number";
                //else if (registerstatus == -11)
                //    message = "Enter Photo link";
                //else if (registerstatus == -12)
                //    message = "Enter roleId";
                //else if (registerstatus == -13)
                //    message = "Enter adhar number";
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
