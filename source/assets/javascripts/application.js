(function () {
  'use strict';

  var root = document.documentElement;
  var toggle = document.querySelector('[data-theme-toggle]');

  function currentTheme() {
    return root.getAttribute('data-theme') ||
      (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
  }

  function applyTheme(theme) {
    root.setAttribute('data-theme', theme);
    if (toggle) {
      toggle.setAttribute('aria-pressed', String(theme === 'dark'));
    }
  }

  applyTheme(currentTheme());

  if (toggle) {
    toggle.addEventListener('click', function () {
      var next = currentTheme() === 'dark' ? 'light' : 'dark';
      try {
        localStorage.setItem('theme', next);
      } catch (e) {
        /* storage unavailable — ignore */
      }
      applyTheme(next);
    });
  }

  var header = document.querySelector('.header');
  var navToggle = document.querySelector('[data-nav-toggle]');

  if (header && navToggle) {
    var setNav = function (open) {
      header.classList.toggle('is-open', open);
      navToggle.setAttribute('aria-expanded', String(open));
    };

    navToggle.addEventListener('click', function () {
      setNav(!header.classList.contains('is-open'));
    });

    header.querySelectorAll('.header__nav a').forEach(function (link) {
      link.addEventListener('click', function () {
        setNav(false);
      });
    });

    document.addEventListener('keydown', function (event) {
      if (event.key === 'Escape' && header.classList.contains('is-open')) {
        setNav(false);
        navToggle.focus();
      }
    });

    document.addEventListener('click', function (event) {
      if (header.classList.contains('is-open') && !header.contains(event.target)) {
        setNav(false);
      }
    });

    window.addEventListener('resize', function () {
      if (window.innerWidth > 767) {
        setNav(false);
      }
    });
  }
})();
