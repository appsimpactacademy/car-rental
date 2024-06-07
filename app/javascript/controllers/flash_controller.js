// app/javascript/controllers/flash_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.classList.add('fade-out');
      setTimeout(() => {
        this.element.remove();
      }, 500); // Match this duration with the CSS transition duration
    }, 3000); // Change this to adjust the auto-hide duration (3000ms = 3 seconds)
  }
}
