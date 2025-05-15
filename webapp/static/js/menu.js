document.addEventListener("DOMContentLoaded", function() {
    const sidebar = document.getElementById('sidebar');
    sidebar.classList.add('close');
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
            toggleButton.classList.add('rotate');
        } else {
            sidebar.classList.remove('open');
            sidebar.classList.add('close');
            toggleButton.classList.remove('rotate');
        }
        closeAllSubMenus();
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
            toggleButton.classList.remove('rotate');
        }
    }

    function closeAllSubMenus() {
        Array.from(sidebar.getElementsByClassName('show')).forEach(ul => {
            ul.classList.remove('show');
            ul.previousElementSibling.classList.remove('rotate');
        });
    }
});
