import { Controller } from "@hotwired/stimulus";
export default class extends Controller {
  static targets = ["emailPasswordField", "phoneNumberLogin", "phoneNumberLoginButton"];

  connect() {
    this.phoneNumberLoginButtonTarget.onclick = this.toggleLogin.bind(this);
  }

  toggleLogin(event) {
    event.preventDefault();
    this.emailPasswordFieldTarget.style.display = "none";
    this.phoneNumberLoginTarget.style.display = "block";
    this.phoneNumberLoginButtonTarget.style.display = "none";
  }
}
