const navbar = document.querySelector('.navbar-lewagon');

window.addEventListener('scroll', function() {
  if (window.scrollY > 0) {
    navbar.classList.add('hidden');
  } else {
    navbar.classList.remove('hidden');
  }
});
