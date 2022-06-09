import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { LoginService } from '../../login.service';
import { FormsModule, NgForm } from '@angular/forms';
@Component({
  selector: 'app-adminlogin',
  templateUrl: './adminlogin.component.html',
  styleUrls: ['./adminlogin.component.css']
})
export class AdminloginComponent implements OnInit {
  status: string;
  errorMsg: string;
  msg: string;
  showDiv: boolean = false;
  constructor(private LoginService: LoginService, private router: Router) { }
  submitLoginForm(form: NgForm) {
    this.LoginService.validateCredentials(form.value.Email, form.value.Password).subscribe(
      responseLoginStatus => {
        this.status = responseLoginStatus;
        console.log(this.status);
        if (this.status.toLowerCase() != "invalid credentials") {
          sessionStorage.setItem('userName', form.value.Email);
          sessionStorage.setItem('userRole', this.status);

          this.router.navigate(['/admindashboard']);
        }
        else {
          this.msg = this.status + ". Try again with valid credentials.";
          console.log(this.msg);
        }
      },
      responseLoginError => {
        this.errorMsg = responseLoginError;
      },
    );
  }
  ngOnInit() {
  }
}
