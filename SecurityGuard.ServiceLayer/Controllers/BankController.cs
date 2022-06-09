//using Microsoft.AspNetCore.Http;
//using Microsoft.AspNetCore.Mvc;
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Threading.Tasks;
//using SecurityGuards.ServiceLayer.Models;
//using SecurityGuard.DataAccessLayer;
//using SecurityGuard.DataAccessLayer.Models;

//namespace SecurityGuard.ServiceLayer.Controllers
//{
//    //[Route("api/[controller]")]
//    //[ApiController]
//    public class BankController : Controller
//    {
//        SecurityGuardRepository repository;
//        public BankController()
//        {
//            repository = new SecurityGuardRepository();
//        }
//        [Route("api/addBankAccount")]
//        [HttpPost]
//        public JsonResult addBankAccount(EmpBankAccount accountObj)
//        {
//            bool registerstatus;
//            string message = "dont know";

//            try
//            {
//                Console.WriteLine(accountObj.AccountNumber);
//                var dal = new SecurityGuardRepository();
//                registerstatus = dal.AddBankAccount(accountObj);
//                if (registerstatus == true)
//                {
//                    message = "Bank details addedd successfully";
//                }
//                else
//                {
//                    message = "Bank details not added" + registerstatus;
//                }
//            }
//            catch (Exception)
//            {
//                registerstatus = false;
//                message = "This is exception";
//            }
//            return Json(message);
//        }
//    }
//}
