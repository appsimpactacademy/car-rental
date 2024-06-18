import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["status", "acceptButton", "rejectButton"]

  connect() {
    this.csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  }

  accept(event) {
    const bookingId = event.target.dataset.bookingId
    this.updateBookingStatus(bookingId, 'accept')
  }

  reject(event) {
    const bookingId = event.target.dataset.bookingId
    this.updateBookingStatus(bookingId, 'reject')
  }

  updateBookingStatus(bookingId, action) {
    fetch(`/owners/bookings/${bookingId}/${action}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': this.csrfToken
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.status) {
        const statusElement = document.querySelector(`#booking-status-${bookingId}`)
        statusElement.textContent = data.status.charAt(0).toUpperCase() + data.status.slice(1)

        const acceptButton = document.querySelector(`button[data-booking-id="${bookingId}"][data-action="click->bookings#accept"]`)
        const rejectButton = document.querySelector(`button[data-booking-id="${bookingId}"][data-action="click->bookings#reject"]`)

        if (acceptButton) acceptButton.disabled = true
        if (rejectButton) rejectButton.disabled = true
      }
    })
    .catch(error => console.error('Error:', error))
  }
}
