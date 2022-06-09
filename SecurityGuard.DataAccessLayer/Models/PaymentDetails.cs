using System;
using System.Collections.Generic;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class PaymentDetails
    {
        public string PayerName { get; set; }
        public long? AmountPaid { get; set; }
        public long? TotalAmount { get; set; }
        public string PaymentType { get; set; }
        public DateTime? PaymentDate { get; set; }
        public long TransactionId { get; set; }
        public long? BalanceAmount { get; set; }
        public string PaymentMethod { get; set; }
        public string BankName { get; set; }
        public long InvoiceNumber { get; set; }

        public virtual Invoice InvoiceNumberNavigation { get; set; }
    }
}
