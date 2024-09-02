import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="flash-notification"
export default class extends Controller {
  connect() {
    this.timeout = setTimeout(() => {
      this.element.remove();
    }, 5000);
  }

  close() {
    clearTimeout(this.timeout);
    this.element.remove();
  }
}
