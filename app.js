// rotation du header au défilement
const headerEl = document.querySelector('header');
function handleHeaderScroll(){
  if (window.scrollY > 40) {
    headerEl.classList.add('scrolled');
  } else {
    headerEl.classList.remove('scrolled');
  }
}
window.addEventListener('scroll', handleHeaderScroll);
handleHeaderScroll();

// menu hamburger sur mobile
const menuToggle = document.getElementById('menu-toggle');
const headerRight = document.getElementById('header-right');
if (menuToggle && headerRight) {
  menuToggle.addEventListener('click', () => {
    menuToggle.classList.toggle('open');
    headerRight.classList.toggle('open');
  });
  // referme le menu si on clique un lien/bouton à l'intérieur
  headerRight.querySelectorAll('a, button').forEach(el => {
    el.addEventListener('click', () => {
      menuToggle.classList.remove('open');
      headerRight.classList.remove('open');
    });
  });
  // referme le menu si on clique en dehors
  document.addEventListener('click', (e) => {
    if (!headerEl.contains(e.target)) {
      menuToggle.classList.remove('open');
      headerRight.classList.remove('open');
    }
  });
}
