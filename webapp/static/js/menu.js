document.addEventListener("DOMContentLoaded", function() {
    const sidebar = document.getElementById('sidebar');
    const mainContent = document.getElementById('main-content');
    const toggleButton = document.getElementById('toggle-btn');
    const subMenus = document.querySelectorAll('.dropdown-btn');

    toggleButton.addEventListener('click', function() {
        toggleSidebar();
    });

    subMenus.forEach(btn => {
        btn.addEventListener('click', function() {
            toggleSubMenu(btn);
        });
    });

    function toggleSidebar() {
        if (sidebar.classList.contains('close')) {
            sidebar.classList.remove('close');
            sidebar.classList.add('open');
        } else {
            sidebar.classList.remove('open');
            sidebar.classList.add('close');
        }
        updateMainContentMargin();
        closeAllSubMenus();
    }

    function updateMainContentMargin() {
        if (sidebar.classList.contains('close')) {
            mainContent.style.marginLeft = 'var(--sidebar-width-collapsed)';
        } else {
            mainContent.style.marginLeft = 'var(--sidebar-width)';
        }
    }

    function toggleSubMenu(button) {
        const subMenu = button.nextElementSibling;
        if (!subMenu.classList.contains('show')) {
            closeAllSubMenus();
        }
        subMenu.classList.toggle('show');
        button.classList.toggle('rotate');
        if (sidebar.classList.contains('close')) {
            sidebar.classList.remove('close');
        }
        updateMainContentMargin();
    }

    function closeAllSubMenus() {
        Array.from(sidebar.getElementsByClassName('show')).forEach(ul => {
            ul.classList.remove('show');
            ul.previousElementSibling.classList.remove('rotate');
        });
    }

    // Inicializa el margen del contenido principal
    updateMainContentMargin();
});