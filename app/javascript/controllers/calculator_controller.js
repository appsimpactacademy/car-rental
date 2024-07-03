// app/javascript/controllers/calculator_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["distanceKm", "tripType", "result", "startDate", "endDate", "startTime", "endTime"]
  static values = { basePrice: Number, pricePerKm: Number }

  connect() {
    console.log("CalculatorController connected")
  }

  calculate(event) {
    event.preventDefault()

    const tripType = this.tripTypeTargets.find(input => input.checked).value
    const distanceKm = parseInt(this.distanceKmTarget.value, 10)
    const basePrice = parseFloat(this.element.dataset.calculatorBasePrice)
    const pricePerKm = parseFloat(this.element.dataset.calculatorPricePerKm)
    const startDate = this.startDateTarget.value
    const startTime = this.startTimeTarget.value
    const endDate = this.endDateTarget.value
    const endTime = this.endTimeTarget.value

    // Convert date format to YYYY-MM-DD
    const formattedStartDate = startDate.split('-').reverse().join('-')
    const formattedEndDate = endDate.split('-').reverse().join('-')

    // Combine date and time strings to create valid Date objects
    const startDateTimeString = `${formattedStartDate}T${startTime}:00`
    const endDateTimeString = `${formattedEndDate}T${endTime}:00`
    const startDateTime = new Date(startDateTimeString)
    const endDateTime = new Date(endDateTimeString)

    if (isNaN(startDateTime.getTime()) || isNaN(endDateTime.getTime())) {
      this.resultTarget.innerHTML = `
        <div class="alert alert-danger mt-3" id="estimateAlert">
          <p class="mb-0">Please provide valid date and time inputs.</p>
        </div>
      `
      return
    }

    // Calculate the total number of days
    const timeDifference = endDateTime.getTime() - startDateTime.getTime()
    const totalDays = Math.ceil(timeDifference / (1000 * 3600 * 24))
    console.log(totalDays);

    let adjustedBasePrice = basePrice
    if (totalDays > 0) {
      adjustedBasePrice = basePrice * totalDays
    }

    let estimatedAmount = 0
    if (tripType === 'one_way') {
      estimatedAmount = adjustedBasePrice + (distanceKm * pricePerKm)
    } else if (tripType === 'two_way') {
      estimatedAmount = adjustedBasePrice + (distanceKm * pricePerKm * 2)
    }

    this.resultTarget.innerHTML = `
      <div class="alert alert-success mt-3" id="estimateAlert">
        <p class="mb-0">Estimated Amount: Rs. ${estimatedAmount.toFixed(2)}</p>
      </div>
    `
  }
}
