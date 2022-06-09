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
    public class ClientController : Controller
    {
        SecurityGuardRepository repository;
        public ClientController()
        {
            repository = new SecurityGuardRepository();
        }
        [Route("api/addClient")]
        [HttpPost]
        public JsonResult addClient(Client clientObj)
        {
            bool registerstatus;
            string message = "dont know";

            try
            {
                //Console.WriteLine(clientObj.ClientName);
                var dal = new SecurityGuardRepository();
                registerstatus = dal.AddClient(clientObj);
                if (registerstatus == true)
                {
                    message = "Client details addedd successfully";
                }
                else
                {
                    message = "Client details not added";
                }
            }
            catch (Exception)
            {
                registerstatus = false;
                message = "This is exception";
            }
            return Json(message);
        }
    }
}
