import { Component, ElementRef } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AxiosService } from '../axios.service';
import { Router } from '@angular/router';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';

@Component({
	selector: 'app-login',
	templateUrl: './login.component.html',
	styleUrls: ['./login.component.css'],
})
export class LoginComponent {

	showError = false;
	errorMessage = '';
	isPasswordVisible = false;
	loginForm: FormGroup;

	constructor(private formBuilder: FormBuilder, private el: ElementRef, private axiosService: AxiosService, private router: Router, private http: HttpClient){
		this.loginForm = this.formBuilder.group({
			email: [
				'',
				[
					Validators.required,
					Validators.pattern(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/)
				]
			],
			password: [
				'',
				[
					Validators.required,
				]
			],
		})
	}

	togglePasswordVisibility() {
		const input = this.el.nativeElement.querySelector('#pwd') as HTMLInputElement;
		this.isPasswordVisible = !this.isPasswordVisible;
		input.type = this.isPasswordVisible ? 'text' : 'password';
	}

	PasswordForgotten() {
		this.router.navigate(['/forgot-password']);
	}

	Register() {
		this.router.navigate(['/register']);
	}

	onSubmit() {

		console.log("submitted");

		if (this.loginForm.valid) {
			console.log("sending login request");
			const formData = new FormData();
			formData.append('username', this.loginForm.get('email')?.value);
			formData.append('password', this.loginForm.get('password')?.value);

			this.http.post<any>('https://127.0.0.1:8443/api/auth/login', formData)
			// this.http.post<any>('<PROT>://<IP>:<PORT>/api/auth/login', formData)
			.subscribe(data => {
				console.log(data.email);
				window.localStorage.setItem("email", data.email);
				this.router.navigate(['/2FA-login']);
			},
			(error: HttpErrorResponse) => {
				this.showError = true;
				this.errorMessage = 'An error occurred during login:', error;
				console.error('An error occurred during login:', error);
			});

			// console.log("sending login request");
			// this.axiosService.request2(
			// 	"POST",
			// 	"/api/auth/login",
			// 	{
			// 	username: this.loginForm.get('email')?.value,
			// 	password: this.loginForm.get('password')?.value
			// 	}
			// 	).then(response => {
			// 		console.log(response.data.email);
			// 		window.localStorage.setItem("email", response.data.email);
			// 		this.router.navigate(['/2FA-login']);
			// 	  })
			// 	  .catch(error => {
			// 		this.showError = true;
			// 		this.errorMessage = 'An error occurred during login:', error;
			// 		console.error('An error occurred during login:', error);
			// 	  })

		} else {
			// Dati inseriti errati
		}
	}
}
