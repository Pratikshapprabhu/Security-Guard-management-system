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
    //[Route("api/[controller]/[action]")]
    //[ApiController]
    public class LoginController : Controller
    {
        SecurityGuardRepository repository;
        public LoginController()
        {
            repository = new SecurityGuardRepository();
        }

        [Route("api/login")]
        [HttpPost]
        public JsonResult Login(Users userObj)
        {
            string message = "";
            try
            {
                var dal = new SecurityGuardRepository();
                Console.WriteLine(userObj.Email);
                message = dal.ValidateLoginUsingLinq(userObj.Email, userObj.UserPassword);
            }
            catch (Exception)
            {
                message = "Invalid credentials";
            }

            return Json(message);
        }

        [Route("api/register")]
        [HttpPost]
        public JsonResult register(Users userObj)
        {
            int registerstatus;
            string message = "dont know";

            try
            {
                Console.WriteLine(userObj.Email);
                var dal = new SecurityGuardRepository();
                registerstatus = dal.AddUser(userObj.UserName, userObj.UserPassword, userObj.Email, userObj.PhoneNumber);
                if (registerstatus == 1)
                {
                    message = "User details addedd successfully";
                }
                else if (registerstatus == -1)
                    message = "Enter emailId";
                else if (registerstatus == -2)
                    message = "EmailId is present in database..please login";
                else if (registerstatus == -3)
                    message = "Enter Password";
                else if (registerstatus == -4)
                    message = "Enter Name";
                else if (registerstatus == -6)
                    message = "Enter PhoneNumber";
                else if (registerstatus == -7)
                    message = "Password Length should be between 8-16";
                else if (registerstatus == -8)
                    message = "Password Length should be between 8-16";
                else if (registerstatus == -9)
                    message = "Enter valid email";
                else if (registerstatus == -10)
                    message = "Firstname should be only letters";
                else if (registerstatus == -11)
                    message = "Enter Firstname without space";
                else if (registerstatus == -12)
                    message = "Lastname should be only letters";
                else if (registerstatus == -13)
                    message = "Enter Lastname without space";
                else if (registerstatus == -14)
                    message = "Enter valid PhoneNumber";
                else if (registerstatus == -15)
                    message = "Enter valid PhoneNumber";
            }
            catch (Exception)
            {
                registerstatus = 0;
            }
            return Json(message);
        }


        [Route("api/removeuser")]
        [HttpDelete]
        public JsonResult removeuser(string Email)
        {
            bool removeStatus = false;

            try
            {
                var dal = new SecurityGuardRepository();
                removeStatus = dal.RemoveUser(Email);
                return Json(removeStatus);
            }
            catch
            {
                removeStatus = false;
            }

            return Json(removeStatus);
        }

        [Route("api/viewregisteredusers")]
        [HttpGet]
        public JsonResult ViewUser()
        {
            List<Users> user = null;
            try
            {
                user = repository.ViewRegisteredUsers();
            }
            catch
            {
                user = null;
            }
            return Json(user);
        }
    }
}
