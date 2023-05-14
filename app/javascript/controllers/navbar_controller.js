import { Controller } from 'stimulus';

export default class extends Controller {
  static values = {
    offsetTop: Number
  }

  initialize() {
    this.offsetTop = this.offsetTopValue;
    this.lastScrollY = window.scrollY;
    this.navbar = this.element;
  }

  connect() {
    window.addEventListener('scroll', this.handleScroll.bind(this));
  }

  disconnect() {
    window.removeEventListener('scroll', this.handleScroll.bind(this));
  }

  handleScroll() {
    const currentScrollY = window.scrollY;
    const scrollDirection = currentScrollY > this.lastScrollY ? 'down' : 'up';

    if (scrollDirection === 'down' && currentScrollY > this.offsetTop) {
      this.navbar.classList.add('hidden');
    } else if (scrollDirection === 'up') {
      this.navbar.classList.remove('hidden');
    }

    this.lastScrollY = currentScrollY;
  }

  get offsetTopValue() {
    return this.hasOffsetTopValue ? this.offsetTopValue : 0;
  }
}
