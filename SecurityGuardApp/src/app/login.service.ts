import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { HttpHeaders } from '@angular/common/http';
import { from, Observable, throwError } from 'rxjs';
import { Register } from "./register";
import { catchError } from 'rxjs/operators';
import { IUser } from './Interface/user';
@Injectable({
  providedIn: 'root'
})


export class LoginService {
  constructor(private http: HttpClient) { }
  validateCredentials(id: string, password: string): Observable<string> {
    var userObj: IUser;
    userObj = { Email: id, UserPassword: password, UserName: null, PhoneNumber: null };
    console.log(userObj);
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json',
        'Charset':'UTF-8'
      })
    };
    return this.http.post<string>(`https://localhost:44312/api/login?Email=${id}&UserPassword=${password}`, httpOptions).pipe(catchError(this.errorHandler));
  }

  CreateUser(register: Register): Observable<string> {
    const httpOptions = { headers: new HttpHeaders({ 'Content-Type': 'application/json' }) };
    console.log(register.PhoneNumber);
    return this.http.post<string>(`https://localhost:44312/api/register?Email=${register.Email}&UserPassword=${register.UserPassword}&UserName=${register.UserName}&PhoneNumber=${register.PhoneNumber}`, httpOptions)
  }

  errorHandler(error: HttpErrorResponse) {
    console.error(error);
    return throwError(error.message || "Server Error");
  }
}
