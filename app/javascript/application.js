// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"

// Simple form enhancements
document.addEventListener('DOMContentLoaded', function () {
    // Auto-focus first input in forms
    const firstInput = document.querySelector('input[type="text"]:not([readonly])');
    if (firstInput) {
        firstInput.focus();
    }
});