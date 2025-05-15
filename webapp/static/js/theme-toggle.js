document.addEventListener('DOMContentLoaded', (event) => {
    const themeToggleBtn = document.getElementById("theme-toggle");
    const lightIcon = themeToggleBtn.querySelector('svg:first-child');
    const darkIcon = themeToggleBtn.querySelector('svg:last-child');
    const currentTheme = localStorage.getItem('theme') ? localStorage.getItem('theme') : null;

    const applyTheme = (theme) => {
        document.documentElement.setAttribute('data-theme', theme);
        localStorage.setItem('theme', theme);
        if(theme === 'dark') {
            lightIcon.style.display = 'none';
            darkIcon.style.display = 'block';
            // themeToggleBtn.innerText = "Cambiar a tema claro";  // Opción si quieres texto en el botón
        } else {
            lightIcon.style.display = 'block';
            darkIcon.style.display = 'none';
            // themeToggleBtn.innerText = "Cambiar a tema oscuro";  // Opción si quieres texto en el botón
        }
    };

    if(currentTheme) {
        applyTheme(currentTheme);
    } else {
        // Si no hay tema seleccionado, aplicamos el tema claro por defecto
        applyTheme('light');
    }

    themeToggleBtn.addEventListener('click', () => {
        let theme = document.documentElement.getAttribute('data-theme');
        const newTheme = theme === 'dark' ? 'light' : 'dark';
        applyTheme(newTheme);
    });
});
