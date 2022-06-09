import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { HttpHeaders } from '@angular/common/http';
import { from, Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { IEmployee } from '../Interface/employee';

@Injectable({
  providedIn: 'root'
})
export class EmployeeService {

  constructor(private http: HttpClient) { }

  addEmployee(
    empname: string,
    email: string,
    address: string,
    city: string,
    pincode: number,
    pan: string,
    adharnumber: bigint,
    photo: string,
    roleid: number
  ): Observable<string> {
    var userObj: IEmployee;
    userObj = { Empname: empname, Email: email, Address: address, City: city, Pincode: pincode, Pan: pan, Adharnumber: adharnumber, Photo: photo, RoleId: roleid };
    console.log(userObj);
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json',
        'Charset': 'UTF-8'
      })
    };
    return this.http.post<string>(`https://localhost:44312/api/addEmployee?empName=${empname}&email=${email}&address=${address}&city=${city}&pincode=${pincode}&Pan=${pan}&adharnumber=${adharnumber}&photo=${photo}&roleId=${roleid}` ,httpOptions).pipe(catchError(this.errorHandler));
  }

  errorHandler(error: HttpErrorResponse) {
    console.error(error);
    return throwError(error.message || "Server Error");
  }
}
