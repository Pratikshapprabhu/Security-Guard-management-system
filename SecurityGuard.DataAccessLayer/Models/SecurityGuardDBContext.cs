using System;
using System.IO;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.Extensions.Configuration;

namespace SecurityGuard.DataAccessLayer.Models
{
    public partial class SecurityGuardDBContext : DbContext
    {
        public SecurityGuardDBContext()
        {
        }

        public SecurityGuardDBContext(DbContextOptions<SecurityGuardDBContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Agreement> Agreement { get; set; }
        public virtual DbSet<Bank> Bank { get; set; }
        public virtual DbSet<Client> Client { get; set; }
        public virtual DbSet<ClientLocation> ClientLocation { get; set; }
        public virtual DbSet<Company> Company { get; set; }
        public virtual DbSet<CompanyBranch> CompanyBranch { get; set; }
        public virtual DbSet<CompanyBranchClient> CompanyBranchClient { get; set; }
        public virtual DbSet<CurrentBasic> CurrentBasic { get; set; }
        public virtual DbSet<DutyShift> DutyShift { get; set; }
        public virtual DbSet<EmpBankAccount> EmpBankAccount { get; set; }
        public virtual DbSet<EmpUserRole> EmpUserRole { get; set; }
        public virtual DbSet<Employee> Employee { get; set; }
        public virtual DbSet<HolidaysList> HolidaysList { get; set; }
        public virtual DbSet<Invoice> Invoice { get; set; }
        public virtual DbSet<LeaveApplication> LeaveApplication { get; set; }
        public virtual DbSet<LeaveType> LeaveType { get; set; }
        public virtual DbSet<PaymentDetails> PaymentDetails { get; set; }
        public virtual DbSet<PricingPlan> PricingPlan { get; set; }
        public virtual DbSet<Roles> Roles { get; set; }
        public virtual DbSet<Salary> Salary { get; set; }
        public virtual DbSet<ShiftSchedule> ShiftSchedule { get; set; }
        public virtual DbSet<ShiftsLocation> ShiftsLocation { get; set; }
        public virtual DbSet<Suppliers> Suppliers { get; set; }
        public virtual DbSet<Users> Users { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            var builder = new ConfigurationBuilder()
                       .SetBasePath(Directory.GetCurrentDirectory())
                       .AddJsonFile("appsettings.json");
            var config = builder.Build();
            var connectionString = config.GetConnectionString("SecurityGuardDBConnectionString");
            if (!optionsBuilder.IsConfigured)
            {
                // #warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer(connectionString);
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Agreement>(entity =>
            {
                entity.Property(e => e.AgreementId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ClientId)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.CompanyId)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.DateOfAgreement).HasColumnType("date");

                entity.Property(e => e.Document).IsRequired();

                entity.Property(e => e.Status)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ValidUpTo).HasColumnType("date");

                entity.HasOne(d => d.Client)
                    .WithMany(p => p.Agreement)
                    .HasForeignKey(d => d.ClientId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_clientId");

                entity.HasOne(d => d.Company)
                    .WithMany(p => p.Agreement)
                    .HasForeignKey(d => d.CompanyId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_companyId1");
            });

            modelBuilder.Entity<Bank>(entity =>
            {
                entity.HasIndex(e => e.Ifsc)
                    .HasName("uq_ifsc")
                    .IsUnique();

                entity.Property(e => e.BankId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Address)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.BankName)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.BranchName)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.City)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Ifsc)
                    .IsRequired()
                    .HasColumnName("IFSC")
                    .HasMaxLength(12)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Client>(entity =>
            {
                entity.HasIndex(e => e.Pan)
                    .HasName("uq_pan")
                    .IsUnique();

                entity.Property(e => e.ClientId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Address)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.City)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ClientName)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Email)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Gst)
                    .HasColumnName("GST")
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Pan)
                    .IsRequired()
                    .HasColumnName("PAN")
                    .HasMaxLength(20)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<ClientLocation>(entity =>
            {
                entity.HasKey(e => e.LocationId)
                    .HasName("pk_locId");

                entity.Property(e => e.LocationId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Address)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.City)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ClientId)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Gps)
                    .HasColumnName("GPS")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Gpsrange)
                    .HasColumnName("GPSRange")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.LocationName)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.HasOne(d => d.Client)
                    .WithMany(p => p.ClientLocation)
                    .HasForeignKey(d => d.ClientId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_clientId2");
            });

            modelBuilder.Entity<Company>(entity =>
            {
                entity.HasIndex(e => e.Gst)
                    .HasName("uq_gst")
                    .IsUnique();

                entity.HasIndex(e => e.Tin)
                    .HasName("uq_tin")
                    .IsUnique();

                entity.Property(e => e.CompanyId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Address)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.City)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.CompanyName)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Gst)
                    .HasColumnName("GST")
                    .HasMaxLength(15)
                    .IsUnicode(false);

                entity.Property(e => e.Tin)
                    .HasColumnName("TIN")
                    .HasMaxLength(10)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<CompanyBranch>(entity =>
            {
                entity.HasKey(e => e.BranchId)
                    .HasName("pk_branchId");

                entity.Property(e => e.BranchId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Address)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.BranchName)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.City)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.CompanyId)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.HasOne(d => d.Company)
                    .WithMany(p => p.CompanyBranch)
                    .HasForeignKey(d => d.CompanyId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_companyId");
            });

            modelBuilder.Entity<CompanyBranchClient>(entity =>
            {
                entity.HasKey(e => e.CBCId)
                   .HasName("pk_cbcId");

                entity.Property(e => e.BranchId)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ClientId)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.FromDate).HasColumnType("date");

                entity.Property(e => e.Status)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ToDate).HasColumnType("date");

                entity.HasOne(d => d.Branch)
                    .WithMany(p => p.CompanyBranchClient)
                    .HasForeignKey(d => d.BranchId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_branchId");

                entity.HasOne(d => d.Client)
                    .WithMany(p => p.CompanyBranchClient)
                    .HasForeignKey(d => d.ClientId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_clientId1");
            });

            modelBuilder.Entity<CurrentBasic>(entity =>
            {
                entity.HasKey(e => e.SiId)
                    .HasName("pk_siId");

                entity.Property(e => e.SiId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.DateOfIncrement).HasColumnType("date");

                entity.Property(e => e.EmpId)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Status)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.HasOne(d => d.Emp)
                    .WithMany(p => p.CurrentBasic)
                    .HasForeignKey(d => d.EmpId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_empId2");
            });

            modelBuilder.Entity<DutyShift>(entity =>
            {
                entity.HasKey(e => e.ShiftId)
                    .HasName("pk_shiftId");

                entity.Property(e => e.ShiftId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ShiftCode)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ShiftName)
                    .HasMaxLength(20)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<EmpBankAccount>(entity =>
            {
                entity.HasKey(e => e.AccountId)
                    .HasName("pk_accountId");

                entity.HasIndex(e => e.AccountNumber)
                    .HasName("pk_accntNumber")
                    .IsUnique();

                entity.Property(e => e.AccountId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.AccountType)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.IFSC)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.BankId)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.EmpId)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.HasOne(d => d.Bank)
                    .WithMany(p => p.EmpBankAccount)
                    .HasForeignKey(d => d.BankId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_bankId");

                entity.HasOne(d => d.Emp)
                    .WithMany(p => p.EmpBankAccount)
                    .HasForeignKey(d => d.EmpId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_empId1");
            });

            modelBuilder.Entity<EmpUserRole>(entity =>
            {
                entity.HasKey(e => e.EURId)
                     .HasName("pk_eURId"); 

                entity.Property(e => e.EmpId)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.FromDate).HasColumnType("date");

                entity.Property(e => e.Status)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ToDate).HasColumnType("date");

                entity.HasOne(d => d.Emp)
                    .WithMany(p => p.EmpUserRole)
                    .HasForeignKey(d => d.EmpId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_empId3");

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.EmpUserRole)
                    .HasForeignKey(d => d.RoleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_roleId2");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.EmpUserRole)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_userId3");
            });

            modelBuilder.Entity<Employee>(entity =>
            {
                entity.HasKey(e => e.EmpId)
                    .HasName("pk_empId");

                entity.Property(e => e.EmpId)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Email)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Address)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.City)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.EmpName)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Pan)
                    .IsRequired()
                    .HasColumnName("PAN")
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Photo)
                .IsRequired()
                .HasMaxLength(50);

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.Employee)
                    .HasForeignKey(d => d.RoleId)
                    .HasConstraintName("fk_roleId");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Employee)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("fk_userId2");
            });

            modelBuilder.Entity<HolidaysList>(entity =>
            {
                entity.HasKey(e => e.HolidayId)
                    .HasName("pk_holodayId");

                entity.Property(e => e.HolidayId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.HolidayDate).HasColumnType("date");

                entity.Property(e => e.HolidayName)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.HolidayType)
                    .HasMaxLength(20)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Invoice>(entity =>
            {
                entity.HasKey(e => e.InvoiceNumber)
                    .HasName("pk_invoiceNo");

                entity.Property(e => e.InvoiceNumber).ValueGeneratedNever();

                entity.Property(e => e.GlshiftIdId)
                    .IsRequired()
                    .HasColumnName("GLShiftIdId")
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.HolidayId)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.InvoiceDate).HasColumnType("date");

                entity.HasOne(d => d.GlshiftId)
                    .WithMany(p => p.Invoice)
                    .HasForeignKey(d => d.GlshiftIdId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_gshiftId");

                entity.HasOne(d => d.Holiday)
                    .WithMany(p => p.Invoice)
                    .HasForeignKey(d => d.HolidayId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_holidayId");
            });

            modelBuilder.Entity<LeaveApplication>(entity =>
            {
                entity.Property(e => e.LeaveApplicationId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ApprovedBy)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ApprovedStatus)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.EmpId)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.FromDate).HasColumnType("date");

                entity.Property(e => e.LeaveApplicationDate).HasColumnType("date");

                entity.Property(e => e.LtId)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Reason)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.SubstituteEmployeeId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ToDate).HasColumnType("date");

                entity.HasOne(d => d.Emp)
                    .WithMany(p => p.LeaveApplication)
                    .HasForeignKey(d => d.EmpId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_empId4");

                entity.HasOne(d => d.Lt)
                    .WithMany(p => p.LeaveApplication)
                    .HasForeignKey(d => d.LtId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_ltId");
            });

            modelBuilder.Entity<LeaveType>(entity =>
            {
                entity.HasKey(e => e.LtId)
                    .HasName("pk_ltId");

                entity.Property(e => e.LtId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.LeaveTypeName)
                    .HasMaxLength(10)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<PaymentDetails>(entity =>
            {
                entity.HasKey(e => e.TransactionId)
                    .HasName("pk_transactionId");

                entity.Property(e => e.TransactionId).ValueGeneratedNever();

                entity.Property(e => e.BankName)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.PayerName)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.PaymentDate).HasColumnType("date");

                entity.Property(e => e.PaymentMethod)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.PaymentType)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.HasOne(d => d.InvoiceNumberNavigation)
                    .WithMany(p => p.PaymentDetails)
                    .HasForeignKey(d => d.InvoiceNumber)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_invoiceNo");
            });

            modelBuilder.Entity<PricingPlan>(entity =>
            {
                entity.Property(e => e.PricingPlanId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.AgreementDoc).IsRequired();

                entity.Property(e => e.BranchId)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ClientId)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.FromDate).HasColumnType("date");

                entity.Property(e => e.LocationId)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Status)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ToDate).HasColumnType("date");

                entity.HasOne(d => d.Branch)
                    .WithMany(p => p.PricingPlan)
                    .HasForeignKey(d => d.BranchId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_branchId1");

                entity.HasOne(d => d.Client)
                    .WithMany(p => p.PricingPlan)
                    .HasForeignKey(d => d.ClientId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_clientId3");

                entity.HasOne(d => d.Location)
                    .WithMany(p => p.PricingPlan)
                    .HasForeignKey(d => d.LocationId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_locationId");
            });

            modelBuilder.Entity<Roles>(entity =>
            {
                entity.HasKey(e => e.RoleId)
                    .HasName("pk_RoleId");

                entity.HasIndex(e => e.RoleCode)
                    .HasName("uq_RoleCode")
                    .IsUnique();

                entity.HasIndex(e => e.RoleName)
                    .HasName("uq_RoleName")
                    .IsUnique();

                entity.Property(e => e.RoleId).ValueGeneratedNever();

                entity.Property(e => e.RoleCode)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.RoleDescription)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.RoleName)
                    .HasMaxLength(20)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Salary>(entity =>
            {
                entity.Property(e => e.SalaryId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Cca).HasColumnName("CCA");

                entity.Property(e => e.Da).HasColumnName("DA");

                entity.Property(e => e.Fbf)
                    .HasColumnName("FBF")
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.GroupGratuity)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Hra).HasColumnName("HRA");

                entity.Property(e => e.IncoomeTax)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.InsurancePremium)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.Property(e => e.NetSalary)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Pf).HasColumnName("PF");

                entity.Property(e => e.SalaryDate).HasColumnType("date");

                entity.Property(e => e.SalaryForMonthYear)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.SiId)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.HasOne(d => d.Si)
                    .WithMany(p => p.Salary)
                    .HasForeignKey(d => d.SiId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_siId");
            });

            modelBuilder.Entity<ShiftSchedule>(entity =>
            {
                entity.HasKey(e => e.GlshiftId)
                    .HasName("pk_gshiftId");

                entity.Property(e => e.GlshiftId)
                    .HasColumnName("GLShiftId")
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.AttendanceStatus)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.LocationId)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ScheduledDate).HasColumnType("date");

                entity.Property(e => e.ShiftId)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.HasOne(d => d.Location)
                    .WithMany(p => p.ShiftSchedule)
                    .HasForeignKey(d => d.LocationId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_locationId2");

                entity.HasOne(d => d.Shift)
                    .WithMany(p => p.ShiftSchedule)
                    .HasForeignKey(d => d.ShiftId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_shiftId1");
            });

            modelBuilder.Entity<ShiftsLocation>(entity =>
            {
                entity.HasKey(e => e.ShiftsLocationId)
                    .HasName("pk_shiftsLocId");

                entity.Property(e => e.FromDate).HasColumnType("date");

                entity.Property(e => e.LocationId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ShiftId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Status)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ToDate).HasColumnType("date");

                entity.Property(e => e.WeekDay)
                    .HasMaxLength(10)
                    .IsUnicode(false);

                entity.HasOne(d => d.Location)
                    .WithMany(p => p.ShiftsLocation)
                    .HasForeignKey(d => d.LocationId)
                    .HasConstraintName("fk_locationId1");

                entity.HasOne(d => d.Shift)
                    .WithMany(p => p.ShiftsLocation)
                    .HasForeignKey(d => d.ShiftId)
                    .HasConstraintName("fk_shiftId");
            });

            modelBuilder.Entity<Suppliers>(entity =>
            {
                entity.HasKey(e => e.SupplierId)
                    .HasName("pk_supplierId");

                entity.Property(e => e.SupplierId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.City)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.EmailId)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Gstnumber).HasColumnName("GSTNumber");

                entity.Property(e => e.LandMark)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.ProprietorPhoto)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ShopAddress)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ShopName)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.SupplierName)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Website)
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Users>(entity =>
            {
                entity.HasKey(e => e.UserId)
                    .HasName("pk_UserId");

                entity.Property(e => e.UserId).ValueGeneratedNever();

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.UserName)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.UserPassword)
                    .IsRequired()
                    .HasMaxLength(15)
                    .IsUnicode(false);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
