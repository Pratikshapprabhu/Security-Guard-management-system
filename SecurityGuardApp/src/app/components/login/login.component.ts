import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { LoginService } from '../../login.service';
import { FormsModule, NgForm } from '@angular/forms';
import { Message } from '@angular/compiler/src/i18n/i18n_ast';
import { NavbarComponent } from '../navbar/navbar.component';
@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {
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
         
          this.router.navigate(['/']);
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
