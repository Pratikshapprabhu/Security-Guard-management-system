import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent implements OnInit{
  buttonStatus: string = "Login";
  loginStatus: boolean = true;
  constructor(private router: Router) { }

  logout() {
    console.log("cleared");
    if (sessionStorage.getItem("userName") != null) {
      sessionStorage.clear();
     
      this.router.navigate(['/']);
    }
    else {
      console.log("Login First");
    }
  }

  checkLogin() {
    if (sessionStorage.getItem("userName") != null) {
      this.buttonStatus = "Logout";
      this.loginStatus = false;
    }
    else {
      this.buttonStatus = "Login";
    }

  }

  ngOnInit() {
    this.checkLogin();
  }
}
