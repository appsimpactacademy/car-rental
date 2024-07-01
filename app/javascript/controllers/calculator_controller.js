// app/javascript/controllers/calculator_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["distanceKm", "tripType", "result"]

  connect() {
    console.log("CalculatorController connected")
  }

  calculate(event) {
    event.preventDefault()

    const tripType = this.tripTypeTargets.find(input => input.checked).value
    const distanceKm = parseInt(this.distanceKmTarget.value, 10)
    const basePrice = parseFloat(this.data.get("basePrice"))
    const pricePerKm = parseFloat(this.data.get("pricePerKm"))

    let estimatedAmount = 0

    if (tripType === 'one_way') {
      estimatedAmount = basePrice + (distanceKm * pricePerKm)
    } else if (tripType === 'two_way') {
      estimatedAmount = basePrice + (distanceKm * pricePerKm * 2)
    }

    this.resultTarget.innerHTML = `
      <div class="alert alert-success mt-3" id="estimateAlert">
        <p class="mb-0">Estimated Amount: Rs. ${estimatedAmount.toFixed(2)}</p>
      </div>
    `

    setTimeout(() => {
      const alert = document.getElementById('estimateAlert')
      if (alert) {
        alert.remove()
      }
    }, 5000) // hide the alert after 5 seconds
  }
}
