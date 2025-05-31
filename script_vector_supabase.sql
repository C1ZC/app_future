-- Habilitar extensión vector (si no está habilitada)
create extension if not exists vector;

-- Crear tabla para vectores de documentos
create table if not exists documents (
  id bigserial primary key,
  document_id uuid references webapp_documento(id), -- Relación con Django
  content text, -- contenido del documento
  metadata jsonb, -- metadatos como grupo, módulo, etc.
  embedding vector(1536) --  (cambiar si usa embedings de 768 dimensiones )
);

-- Crear índice para búsqueda vectorial
create index on documents using ivfflat (embedding vector_cosine_ops) with (lists = 100);

-- Función para búsqueda por similitud
create or replace function match_documents (
  query_embedding vector(1536), -- (cambiar si usa embedings de 768 dimensiones)
  match_count int default 10,
  filter jsonb DEFAULT '{}'
) returns table (
  id bigint,
  document_id uuid,
  content text,
  metadata jsonb,
  similarity float
)
language plpgsql
as $$
#variable_conflict use_column
begin
  return query
  select
    id,
    document_id,
    content,
    metadata,
    1 - (documents.embedding <=> query_embedding) as similarity
  from documents
  where metadata @> filter
  order by documents.embedding <=> query_embedding
  limit match_count;
end;
$$;