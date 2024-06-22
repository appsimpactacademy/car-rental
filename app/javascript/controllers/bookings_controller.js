// app/javascript/controllers/bookings_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["status"]
  
  connect() {
    console.log("Bookings controller connected")
  }

  accept(event) {
    this.updateStatus(event, "accept")
  }

  reject(event) {
    this.updateStatus(event, "reject")
  }

  updateStatus(event, action) {
    const bookingId = event.target.dataset.bookingId

    fetch(`/owners/bookings/${bookingId}/${action}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.message) {
        const newStatus = action === "accept" ? "Accepted" : "Rejected"
        this.statusTargets.forEach(element => {
          if (element.dataset.bookingId === bookingId) {
            element.textContent = newStatus
          }
        })
      }
    })
  }
}
