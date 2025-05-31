-- Eliminar función de búsqueda por similitud si existe
drop function if exists match_documents
(vector, int, jsonb);

-- Eliminar índice de búsqueda vectorial si existe
drop index if exists documents_embedding_idx;

-- Eliminar tabla de vectores de documentos si existe
drop table if exists documents;

-- Eliminar extensión vector si no la usas para otras tablas
-- drop extension if exists vector;