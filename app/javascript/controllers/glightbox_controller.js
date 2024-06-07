// app/javascript/controllers/glightbox_controller.js
import { Controller } from "@hotwired/stimulus"
import GLightbox from "glightbox";
export default class extends Controller {
  connect() {
    this.lightbox = GLightbox({
      selector: '.gallery a',
      touchNavigation: true,
      loop: true
    });
  }
}
