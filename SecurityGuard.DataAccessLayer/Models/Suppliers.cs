using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class Suppliers
    {
        public string SupplierId { get; set; }
        public string SupplierName { get; set; }
        public string ShopName { get; set; }
        public string ShopAddress { get; set; }
        public string LandMark { get; set; }
        public long? MobileNumber { get; set; }
        public long? Telephone { get; set; }
        public string EmailId { get; set; }
        public string Website { get; set; }
        public string ProprietorPhoto { get; set; }
        public long? Gstnumber { get; set; }
        public string City { get; set; }
    }
}
