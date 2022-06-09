using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class Salary
    {
        public string SalaryId { get; set; }
        public long? Basic { get; set; }
        public long? Da { get; set; }
        public long? Hra { get; set; }
        public long? Incenive { get; set; }
        public long? Cca { get; set; }
        public long? GrossSalary { get; set; }
        public string IncoomeTax { get; set; }
        public string Fbf { get; set; }
        public string InsurancePremium { get; set; }
        public long? Pf { get; set; }
        public long? GroupInsurance { get; set; }
        public long? QuartersRent { get; set; }
        public string GroupGratuity { get; set; }
        public string NetSalary { get; set; }
        public DateTime? SalaryDate { get; set; }
        public string SalaryForMonthYear { get; set; }
        public string SiId { get; set; }

        public virtual CurrentBasic Si { get; set; }
    }
}
