// app/javascript/controllers/datepicker_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Initialize datepicker on the element with id 'datepicker'
    $('.datepicker').datepicker({
      dateFormat: 'dd-mm-yy',
      minDate: 0 // Disable past dates (0 means today and future dates only)
    });
  }
}
