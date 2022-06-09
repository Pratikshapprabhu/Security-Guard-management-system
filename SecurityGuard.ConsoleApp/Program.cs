using System;
using SecurityGuard.DataAccessLayer;

namespace SecurityGuard.ConsoleApp
{
    class Program
    {
        static void Main(string[] args)
        {
            SecurityGuardRepository repository = new SecurityGuardRepository();
            //var categories = repository.GetAllCategories();
            Console.WriteLine("----------------------------------");
            Console.WriteLine("Hello World!");
            Console.WriteLine("----------------------------------");
            int result = repository.AddUser(11,"Gireesh", "Abc@12377", "Gireesh@gmail.com", 7888998819);
            //if (result == 1)
            //{
            //    Console.WriteLine("New category added successfully");
            //}
            //else
            //{
            //    Console.WriteLine("Something went wrong. Try again!");
            //}
            Console.WriteLine(result);
        }
    }
}
