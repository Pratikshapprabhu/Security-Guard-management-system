import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { EmployeeService } from '../../service/employee.service';
import { FormsModule, NgForm } from '@angular/forms';

@Component({
  selector: 'app-employee',
  templateUrl: './employee.component.html',
  styleUrls: ['./employee.component.css']
})
export class EmployeeComponent implements OnInit {
  status: string;
  constructor(private EmployeeService: EmployeeService, private router: Router) { }
  submitEmployee(form: NgForm) {
    this.EmployeeService.addEmployee(
      form.value.empname,
      form.value.email,
      form.value.address,
      form.value.city,
      form.value.pincode,
      form.value.pan,
      form.value.adharnumber,
      form.value.photo,
      form.value.roleid
    ).subscribe(
      responseAddStatus => {
        this.status = responseAddStatus;
        console.log(this.status);
        this.router.navigate(['/']);
      }
    )
  }
  ngOnInit(): void {
  }

}
