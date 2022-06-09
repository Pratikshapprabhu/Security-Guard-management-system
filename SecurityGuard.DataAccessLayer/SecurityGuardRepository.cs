using System;
using System.Collections.Generic;
using System.Text;
using SecurityGuard.DataAccessLayer.Models;
using System.Data.SqlClient;
using System.Linq;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;


namespace SecurityGuard.DataAccessLayer
{
    public class SecurityGuardRepository
    {
            SecurityGuardDBContext Context { get; set; }
        public SecurityGuardRepository()
            {
                Context = new SecurityGuardDBContext();
            }
        //-------------------------------------------------------------REGISTER USER--------------------------------------------
        Users newuser = new Users();
        public int AddUser(string userName, string userPassword, string email, long phoneNumber)
        {
            int status;
            newuser.UserName = userName;
            newuser.UserPassword = userPassword;
            newuser.Email = email;
            newuser.PhoneNumber = phoneNumber;

            SqlParameter prmUserName = new SqlParameter("@UserName", userName);
            SqlParameter prmUserPassword = new SqlParameter("@UserPassword", userPassword);
            SqlParameter prmEmail = new SqlParameter("@Email", email);
            SqlParameter prmPhoneNumber = new SqlParameter("@PhoneNumber", phoneNumber);


            SqlParameter prmResult = new SqlParameter("@Result", System.Data.SqlDbType.Int);
            prmResult.Direction = System.Data.ParameterDirection.Output;

            try
            {
                Context.Database.ExecuteSqlRaw("EXEC @Result = usp_RegisterUser @UserName, @UserPassword, @Email, @PhoneNumber", prmResult, prmUserName, prmUserPassword, prmEmail, prmPhoneNumber);

                status = Convert.ToInt32(prmResult.Value);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                status = -89;
            }
            return status;
        }

        //----------------------------------------------------Login User-----------------------------------------------------------
        public string ValidateLoginUsingLinq(string email, string userPassword)
        {

            string message = "";
            try
            {
                var objUser = (from usr in Context.Users
                               where usr.Email == email && usr.UserPassword == userPassword
                               select usr).FirstOrDefault<Users>();

                if (objUser != null)
                {
                    message = "Login Success  " + objUser.UserId;
                }
                else
                {
                    message = "Invalid credentials  " + objUser.UserId;
                }
            }
            catch (Exception)
            {
                message = "Invalid credentials";
            }
            return message;
        }

        //-----------------------------------------------------------------VIEW USER---------------------------------------------------------
             public List<Users> ViewRegisteredUsers()
        {
            var usersList = (from user in Context.Users
                                select user).ToList();
            return usersList;
        }

        //------------------------------------------REMOVE USER------------------------------------------------------------------------------
        public bool RemoveUser(string EmailId)
        {

            bool status = false;
            try
            {

                var user = (from usr in Context.Users
                            where usr.Email == EmailId
                            select usr).FirstOrDefault<Users>();
                var result = Context.Users.Remove(user);
                Console.WriteLine(result);

                Context.SaveChanges();
                status = true;

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                status = false;
            }
            return status;
        }

        //------------------------------------------------ADD EMPLOYEE DETAILS--------------------------------------------------------------------------

        Employee empdetail = new Employee();
        public int AddEmployee(string empName, string email, string address,string city, int pinCode, string pan, long adharNumber,string photo, int roleId)
        {
            int status;
            empdetail.EmpName = empName;
            empdetail.Email = email;
            empdetail.Address = address;
            empdetail.City = city;
            empdetail.PinCode = pinCode;
            empdetail.Pan = pan;
            empdetail.AdharNumber = adharNumber;
           // empdetail.Photo = photo;
            empdetail.RoleId = roleId;

            SqlParameter prmEmpName = new SqlParameter("@EmpName", empName);
            SqlParameter prmEmail = new SqlParameter("@Email", email);
            SqlParameter prmAddress = new SqlParameter("@Address", address);
            SqlParameter prmCity = new SqlParameter("@City", city);
            SqlParameter prmPinCode = new SqlParameter("@PinCode", pinCode);
            SqlParameter prmPan = new SqlParameter("@Pan", pan);
            SqlParameter prmAdharNumber = new SqlParameter("@AdharNumber", adharNumber);
            SqlParameter prmPhoto = new SqlParameter("@Photo", photo);
            SqlParameter prmRoleId = new SqlParameter("@RoleId", roleId);



            SqlParameter prmResult = new SqlParameter("@Result", System.Data.SqlDbType.Int);
            prmResult.Direction = System.Data.ParameterDirection.Output;

            try
            {
                Context.Database.ExecuteSqlRaw("EXEC @Result =  usp_AddEmployee @EmpName, @Email, @Address, @City, @PinCode, @Pan, @AdharNumber, @Photo, @RoleId", prmResult, prmEmpName, prmEmail, prmAddress, prmCity, prmPinCode, prmPan, prmAdharNumber, prmPhoto, prmRoleId);

                status = Convert.ToInt32(prmResult.Value);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                status = -89;
            }
            return status;
        }
        //------------------------------------------------------------Add branch------------------------------------------------------------------
        public bool AddClient(Client client)
        {
            bool status = false;
            try
            {
                Client clientObj = new Client();
                clientObj.ClientName = client.ClientName;
                clientObj.Address = client.Address;
                clientObj.City = client.City;
                clientObj.PinCode = client.PinCode;
                clientObj.Email = client.Email;
                clientObj.Pan = client.Pan;

                Context.Client.Add(clientObj);
                Context.SaveChanges();
                status = true;
            }
            catch (Exception ex)
            {
                status = false;
            }
            return status;
        }
        //------------------------------------------------Add Company Brnch-------------------------------------------------------------------
        CompanyBranch branchdetail = new CompanyBranch();
        public int AddCompanyBranch(string branchName, string address, string city, int pinCode)
        {
            int status;
            branchdetail.BranchName = branchName;
            branchdetail.Address = address;
            branchdetail.City = city;
            branchdetail.PinCode = pinCode;            

            SqlParameter prmBranchName = new SqlParameter("@BranchName", branchName);
            SqlParameter prmAddress = new SqlParameter("@Address", address);
            SqlParameter prmCity = new SqlParameter("@City", city);
            SqlParameter prmPinCode = new SqlParameter("@PinCode", pinCode);



            SqlParameter prmResult = new SqlParameter("@Result", System.Data.SqlDbType.Int);
            prmResult.Direction = System.Data.ParameterDirection.Output;

            try
            {
                Context.Database.ExecuteSqlRaw("EXEC @Result =  usp_AddcompanyBranch @BranchName, @Address, @City, @PinCode", prmResult, prmBranchName, prmAddress, prmCity, prmPinCode);

                status = Convert.ToInt32(prmResult.Value);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                status = -89;
            }
            return status;
        }
        //-------------------------------------------------------------Add Bank Account---------------------------------------------------------
        //EmpBankAccount account = new EmpBankAccount();
        //public int AddCompanyBranch(string branchName, string address, string city, int pinCode)
        //{
        //    int status;
        //    account.BranchName = branchName;
        //    account.Address = address;
        //    account.City = city;
        //    account.PinCode = pinCode;

        //    SqlParameter prmBranchName = new SqlParameter("@BranchName", branchName);
        //    SqlParameter prmAddress = new SqlParameter("@Address", address);
        //    SqlParameter prmCity = new SqlParameter("@City", city);
        //    SqlParameter prmPinCode = new SqlParameter("@PinCode", pinCode);



        //    SqlParameter prmResult = new SqlParameter("@Result", System.Data.SqlDbType.Int);
        //    prmResult.Direction = System.Data.ParameterDirection.Output;

        //    try
        //    {
        //        Context.Database.ExecuteSqlRaw("EXEC @Result =  usp_AddcompanyBranch @BranchName, @Address, @City, @PinCode", prmResult, prmBranchName, prmAddress, prmCity, prmPinCode);

        //        status = Convert.ToInt32(prmResult.Value);
        //    }
        //    catch (Exception e)
        //    {
        //        Console.WriteLine(e.Message);
        //        status = -89;
        //    }
        //    return status;
        //}
    }
}
