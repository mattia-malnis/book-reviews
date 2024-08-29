import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails";

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    if (!this.element.open) {
      this.element.showModal();
    }
  }

  // Hide the dialog when the user clicks outside of it
  clickOutside(e) {
    if (e.target === this.element) {
      this.element.close();
    }
  }

  close() {
    this.element.close();
  }

  closeOnSuccess(e) {
    if (e.detail.success) {
      this.close();
    }
  }

  reloadOnSuccess(e) {
    if (e.detail.success) {
      this.close();
      setTimeout(function () {
        Turbo.visit(window.location.href);
      }, 500);
    }
  }
}
