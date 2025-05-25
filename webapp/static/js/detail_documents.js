/**
 * Módulo para la visualización de documentos con datos JSON
 */
const DocumentViewer = {
    /**
     * Inicializa el visor de documentos
     * @param {Object} options - Opciones de configuración
     */
    init: function(options = {}) {
        document.addEventListener('DOMContentLoaded', () => {
            const jsonViewer = document.getElementById('jsonViewer');
            if (!jsonViewer) return;
            
            try {
                // Obtener datos JSON pasados desde la plantilla
                if (options.jsonData) {
                    jsonViewer.innerHTML = this.formatJsonWithSyntaxHighlighting(options.jsonData);
                } else {
                    jsonViewer.innerHTML = "No hay datos estructurados disponibles";
                }
            } catch (e) {
                console.error("Error al procesar JSON:", e);
                jsonViewer.innerHTML = `Error al cargar los datos JSON: ${e.message}`;
            }
        });
    },
    
    /**
     * Formatea JSON con resaltado de sintaxis
     * @param {String|Object} jsonString - Datos JSON a formatear
     * @returns {String} HTML con sintaxis resaltada
     */
    formatJsonWithSyntaxHighlighting: function(jsonString) {
        try {
            // Si es string, intentar parsear
            let jsonObj;
            if (typeof jsonString === 'string') {
                try {
                    jsonObj = JSON.parse(jsonString);
                } catch (e) {
                    // Si falla el parsing, mostramos el texto plano
                    return jsonString;
                }
            } else {
                jsonObj = jsonString;
            }
            
            const json = JSON.stringify(jsonObj, null, 4);
            
            return json.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function (match) {
                let cls = 'json-number';
                if (/^"/.test(match)) {
                    if (/:$/.test(match)) {
                        cls = 'json-key';
                    } else {
                        cls = 'json-string';
                    }
                } else if (/true|false/.test(match)) {
                    cls = 'json-boolean';
                } else if (/null/.test(match)) {
                    cls = 'json-null';
                }
                return '<span class="' + cls + '">' + match + '</span>';
            });
        } catch (e) {
            console.error("Error al formatear JSON:", e);
            return "Error al procesar los datos JSON: " + e.message;
        }
    }
};