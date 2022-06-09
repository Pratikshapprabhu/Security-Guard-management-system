import { Component, OnInit } from '@angular/core';
import { LoginService } from '../../login.service';
import { Register } from '../../register';
import { NgForm, FormBuilder, FormGroup, Validators, FormControl } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  data = false;
  userForm: any;
  message: string;
  submitted = false;
  constructor(private router: Router, private formbulider: FormBuilder, private registerService: LoginService) { }

  ngOnInit() {
    this.userForm = this.formbulider.group({
      UserName: ['', [Validators.required]],
      Email: ['', [Validators.email]],
      PhoneNumber: ['', [Validators.required]],
      UserPassword: ['', [Validators.required]],
    });
  }
  get userFormControl() {
    return this.userForm.controls;
  }
  onFormSubmit(_value) {
    const user = this.userForm.value;
    this.Createuser(user);
  }
  Createuser(register: Register) {
    this.registerService.CreateUser(register).subscribe(
      registerStatus => {
        if (registerStatus == 'User details addedd successfully') {
          this.submitted = true;
          this.data = true;
          this.message = 'Data saved Successfully';
          this.router.navigate(['/']);
          this.userForm.reset();
          console.log(this.message);
        }
        else {
          this.submitted = false;
          console.log(this.submitted)
        }      
      });
 }
}
