-- =============================================================================
-- SCRIPT COMPLETO DE GRUPOS Y MÓDULOS PARA DOCUMENTACIÓN CHILENA
-- =============================================================================
-- Este script crea una estructura completa de clasificación documental
-- adaptada a las necesidades específicas del contexto chileno, cubriendo
-- todas las áreas documentales relevantes para empresas, personas y entidades.
-- =============================================================================

-- Limpiar datos existentes (opcional - usar con precaución)
-- DELETE FROM webapp_modulo;
-- DELETE FROM webapp_grupo;
-- ALTER SEQUENCE webapp_grupo_id_seq RESTART WITH 1;
-- ALTER SEQUENCE webapp_modulo_id_seq RESTART WITH 1;

-- =============================================================================
-- 1. DOCUMENTOS TRIBUTARIOS Y SII
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Documentos Tributarios', 'Documentación relacionada con obligaciones fiscales ante el SII y otras entidades', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Formulario 29', 'Declaración mensual y pago simultáneo de impuestos (IVA, PPM, etc.)', id, true FROM webapp_grupo WHERE nombre = 'Documentos Tributarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Formulario 22', 'Declaración anual de impuesto a la renta', id, true FROM webapp_grupo WHERE nombre = 'Documentos Tributarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Formulario 50', 'Declaración y pago de impuestos por rentas del Art. 42 N°2 y retención Art. 48', id, true FROM webapp_grupo WHERE nombre = 'Documentos Tributarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Formulario 1879', 'Declaración jurada anual sobre retenciones efectuadas a contribuyentes de primera categoría', id, true FROM webapp_grupo WHERE nombre = 'Documentos Tributarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Formulario 1887', 'Declaración jurada anual sobre rentas del Art. 42 N°1 (sueldos), otros', id, true FROM webapp_grupo WHERE nombre = 'Documentos Tributarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificado 29', 'Certificado sobre pensiones o jubilaciones y otras rentas similares', id, true FROM webapp_grupo WHERE nombre = 'Documentos Tributarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificado 1', 'Certificado de honorarios', id, true FROM webapp_grupo WHERE nombre = 'Documentos Tributarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificado 3', 'Certificado de situación tributaria de dividendos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Tributarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificado 6', 'Certificado de sueldos para impuesto anual a la renta', id, true FROM webapp_grupo WHERE nombre = 'Documentos Tributarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de IVA', 'Certificados de IVA de compras y ventas para fiscalización', id, true FROM webapp_grupo WHERE nombre = 'Documentos Tributarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contribuciones', 'Comprobantes de pago de impuesto territorial', id, true FROM webapp_grupo WHERE nombre = 'Documentos Tributarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Patentes Municipales', 'Pagos de patente comercial municipal', id, true FROM webapp_grupo WHERE nombre = 'Documentos Tributarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Inicio de Actividades', 'Documentación de inicio de actividades ante el SII', id, true FROM webapp_grupo WHERE nombre = 'Documentos Tributarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Término de Giro', 'Documentación de término de actividades ante el SII', id, true FROM webapp_grupo WHERE nombre = 'Documentos Tributarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Rut Empresa', 'Documentación de RUT e identificación tributaria', id, true FROM webapp_grupo WHERE nombre = 'Documentos Tributarios';

-- =============================================================================
-- 2. DOCUMENTOS COMERCIALES Y FACTURACIÓN ELECTRÓNICA
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Documentos Comerciales', 'Documentación relacionada con operaciones comerciales, ventas y facturación electrónica', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Facturas Electrónicas', 'Facturas emitidas mediante el sistema de facturación electrónica del SII', id, true FROM webapp_grupo WHERE nombre = 'Documentos Comerciales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Facturas de Compra', 'Facturas recibidas por adquisiciones de bienes o servicios', id, true FROM webapp_grupo WHERE nombre = 'Documentos Comerciales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Facturas de Exportación', 'Facturas por ventas al exterior', id, true FROM webapp_grupo WHERE nombre = 'Documentos Comerciales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Facturas No Afectas/Exentas', 'Facturas por operaciones exentas o no afectas a IVA', id, true FROM webapp_grupo WHERE nombre = 'Documentos Comerciales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Boletas Electrónicas', 'Boletas emitidas mediante el sistema de facturación electrónica', id, true FROM webapp_grupo WHERE nombre = 'Documentos Comerciales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Boletas de Honorarios', 'Boletas por prestación de servicios profesionales', id, true FROM webapp_grupo WHERE nombre = 'Documentos Comerciales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Guías de Despacho', 'Documentos que respaldan el traslado de mercancías', id, true FROM webapp_grupo WHERE nombre = 'Documentos Comerciales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Notas de Crédito', 'Documentos para correcciones o devoluciones de facturas', id, true FROM webapp_grupo WHERE nombre = 'Documentos Comerciales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Notas de Débito', 'Documentos para aumentos en el valor de facturas', id, true FROM webapp_grupo WHERE nombre = 'Documentos Comerciales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Órdenes de Compra', 'Documentos formales de solicitud de compra', id, true FROM webapp_grupo WHERE nombre = 'Documentos Comerciales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Cotizaciones', 'Documentos formales de oferta comercial', id, true FROM webapp_grupo WHERE nombre = 'Documentos Comerciales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contratos Comerciales', 'Acuerdos formales de compraventa', id, true FROM webapp_grupo WHERE nombre = 'Documentos Comerciales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Libros de Compra-Venta', 'Registros oficiales de operaciones comerciales', id, true FROM webapp_grupo WHERE nombre = 'Documentos Comerciales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Informes de Ventas', 'Reportes periódicos de actividad comercial', id, true FROM webapp_grupo WHERE nombre = 'Documentos Comerciales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'DTE Recibidos', 'Documentos tributarios electrónicos recibidos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Comerciales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'DTE Emitidos', 'Documentos tributarios electrónicos emitidos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Comerciales';

-- =============================================================================
-- 3. DOCUMENTOS LABORALES Y PREVISIONALES
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Documentos Laborales', 'Documentación relacionada con relaciones laborales, contratos y cumplimiento previsional', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contratos de Trabajo', 'Contratos formales de relación laboral', id, true FROM webapp_grupo WHERE nombre = 'Documentos Laborales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Anexos de Contrato', 'Modificaciones y adendas a contratos laborales', id, true FROM webapp_grupo WHERE nombre = 'Documentos Laborales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Finiquitos', 'Documentos de término de relación laboral', id, true FROM webapp_grupo WHERE nombre = 'Documentos Laborales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Liquidaciones de Sueldo', 'Comprobantes mensuales de remuneraciones', id, true FROM webapp_grupo WHERE nombre = 'Documentos Laborales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Planillas de Cotizaciones', 'Documentos de pago de cotizaciones previsionales (Previred)', id, true FROM webapp_grupo WHERE nombre = 'Documentos Laborales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados AFP', 'Certificados de afiliación y cotizaciones de AFP', id, true FROM webapp_grupo WHERE nombre = 'Documentos Laborales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados Isapre/Fonasa', 'Documentación de afiliación y cotizaciones de salud', id, true FROM webapp_grupo WHERE nombre = 'Documentos Laborales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados Laborales', 'Certificados de antigüedad, renta y otros', id, true FROM webapp_grupo WHERE nombre = 'Documentos Laborales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Reglamento Interno', 'Reglamento interno de orden, higiene y seguridad', id, true FROM webapp_grupo WHERE nombre = 'Documentos Laborales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contratos Especiales', 'Contratos part-time, teletrabajo, etc.', id, true FROM webapp_grupo WHERE nombre = 'Documentos Laborales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Acuerdos COVID-19', 'Acuerdos de suspensión o reducción por Ley de Protección al Empleo', id, true FROM webapp_grupo WHERE nombre = 'Documentos Laborales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Libro de Remuneraciones', 'Registro oficial de pagos de remuneraciones', id, true FROM webapp_grupo WHERE nombre = 'Documentos Laborales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Documentos de Capacitación', 'Certificados y respaldos de capacitaciones SENCE', id, true FROM webapp_grupo WHERE nombre = 'Documentos Laborales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Accidentes', 'Documentación de accidentes laborales y licencias', id, true FROM webapp_grupo WHERE nombre = 'Documentos Laborales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Registro de Asistencia', 'Documentos de control de asistencia laboral', id, true FROM webapp_grupo WHERE nombre = 'Documentos Laborales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados Sindicales', 'Documentación relacionada con actividad sindical', id, true FROM webapp_grupo WHERE nombre = 'Documentos Laborales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Permisos y Vacaciones', 'Documentos de solicitud y autorización de ausencias', id, true FROM webapp_grupo WHERE nombre = 'Documentos Laborales';

-- =============================================================================
-- 4. DOCUMENTOS LEGALES Y NOTARIALES
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Documentos Legales', 'Documentación jurídica, notarial y contratos formales', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Escrituras Públicas', 'Instrumentos públicos autorizados ante notario', id, true FROM webapp_grupo WHERE nombre = 'Documentos Legales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Poderes Notariales', 'Documentos de representación legal ante notario', id, true FROM webapp_grupo WHERE nombre = 'Documentos Legales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Poderes Judiciales', 'Mandatos para representación en juicios', id, true FROM webapp_grupo WHERE nombre = 'Documentos Legales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contratos Civiles', 'Acuerdos formales entre particulares', id, true FROM webapp_grupo WHERE nombre = 'Documentos Legales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Testamentos', 'Disposiciones de última voluntad', id, true FROM webapp_grupo WHERE nombre = 'Documentos Legales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Demandas', 'Documentos de inicio de acciones judiciales', id, true FROM webapp_grupo WHERE nombre = 'Documentos Legales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Sentencias', 'Resoluciones judiciales definitivas', id, true FROM webapp_grupo WHERE nombre = 'Documentos Legales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Escritos Judiciales', 'Presentaciones en procesos judiciales', id, true FROM webapp_grupo WHERE nombre = 'Documentos Legales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Recursos Judiciales', 'Apelaciones y otros recursos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Legales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Notificaciones', 'Comunicaciones formales de procesos legales', id, true FROM webapp_grupo WHERE nombre = 'Documentos Legales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Acuerdos Extrajudiciales', 'Transacciones y avenimientos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Legales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Dictámenes y Consultas', 'Opiniones legales formales', id, true FROM webapp_grupo WHERE nombre = 'Documentos Legales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contratos de Arrendamiento', 'Acuerdos de arriendo de bienes', id, true FROM webapp_grupo WHERE nombre = 'Documentos Legales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Prendas e Hipotecas', 'Documentos de garantías reales', id, true FROM webapp_grupo WHERE nombre = 'Documentos Legales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Propiedad Intelectual', 'Patentes, marcas y derechos de autor', id, true FROM webapp_grupo WHERE nombre = 'Documentos Legales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Actas de Comparecencia', 'Constancias notariales de hechos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Legales';

-- =============================================================================
-- 5. DOCUMENTOS BANCARIOS Y FINANCIEROS
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Documentos Bancarios', 'Documentación relacionada con operaciones bancarias y financieras', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Estados de Cuenta', 'Reportes periódicos de movimientos bancarios', id, true FROM webapp_grupo WHERE nombre = 'Documentos Bancarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Cartolas Bancarias', 'Extractos oficiales de movimientos de cuenta', id, true FROM webapp_grupo WHERE nombre = 'Documentos Bancarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Comprobantes de Transferencia', 'Respaldos de transferencias electrónicas', id, true FROM webapp_grupo WHERE nombre = 'Documentos Bancarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Comprobantes de Depósito', 'Documentos de ingreso de fondos a cuentas', id, true FROM webapp_grupo WHERE nombre = 'Documentos Bancarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Comprobantes de Giro', 'Documentos de retiro de fondos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Bancarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Pagarés', 'Documentos de crédito y obligaciones de pago', id, true FROM webapp_grupo WHERE nombre = 'Documentos Bancarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contratos de Crédito', 'Documentos formales de préstamos bancarios', id, true FROM webapp_grupo WHERE nombre = 'Documentos Bancarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contratos de Cuenta', 'Acuerdos de apertura y condiciones de cuentas', id, true FROM webapp_grupo WHERE nombre = 'Documentos Bancarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Tarjetas de Crédito', 'Estados de cuenta y comprobantes de tarjetas', id, true FROM webapp_grupo WHERE nombre = 'Documentos Bancarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Tarjetas de Débito', 'Documentación relacionada con tarjetas de débito', id, true FROM webapp_grupo WHERE nombre = 'Documentos Bancarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Cheques', 'Copias y respaldos de cheques emitidos/recibidos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Bancarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Letras de Cambio', 'Instrumentos de crédito y cambio', id, true FROM webapp_grupo WHERE nombre = 'Documentos Bancarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contratos de Leasing', 'Acuerdos de arrendamiento con opción de compra', id, true FROM webapp_grupo WHERE nombre = 'Documentos Bancarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contratos de Factoring', 'Documentos de cesión de créditos comerciales', id, true FROM webapp_grupo WHERE nombre = 'Documentos Bancarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Boletas de Garantía', 'Documentos de garantía bancaria para contratos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Bancarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Mandatos Bancarios', 'Autorizaciones para operaciones automáticas', id, true FROM webapp_grupo WHERE nombre = 'Documentos Bancarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Inversiones', 'Documentación de depósitos a plazo y fondos mutuos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Bancarios';

-- =============================================================================
-- 6. DOCUMENTOS INMOBILIARIOS Y BIENES RAÍCES
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Documentos Inmobiliarios', 'Documentación relacionada con propiedades, terrenos y bienes raíces', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Escrituras de Compraventa', 'Contratos de transferencia de dominio de propiedades', id, true FROM webapp_grupo WHERE nombre = 'Documentos Inmobiliarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contratos de Arriendo', 'Acuerdos formales de arrendamiento inmobiliario', id, true FROM webapp_grupo WHERE nombre = 'Documentos Inmobiliarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Dominio', 'Certificados de propiedad del Conservador de Bienes Raíces', id, true FROM webapp_grupo WHERE nombre = 'Documentos Inmobiliarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Hipotecas', 'Certificados de gravámenes y prohibiciones', id, true FROM webapp_grupo WHERE nombre = 'Documentos Inmobiliarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Avalúo Fiscal', 'Documentos de tasación oficial del SII', id, true FROM webapp_grupo WHERE nombre = 'Documentos Inmobiliarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Tasaciones Comerciales', 'Informes de valoración de mercado de propiedades', id, true FROM webapp_grupo WHERE nombre = 'Documentos Inmobiliarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Planos de Propiedad', 'Planos arquitectónicos y de loteo', id, true FROM webapp_grupo WHERE nombre = 'Documentos Inmobiliarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Permisos de Edificación', 'Autorizaciones municipales para construcción', id, true FROM webapp_grupo WHERE nombre = 'Documentos Inmobiliarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Recepciones Finales', 'Certificados municipales de término de obras', id, true FROM webapp_grupo WHERE nombre = 'Documentos Inmobiliarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Informaciones Previas', 'Documentos municipales sobre normativa aplicable', id, true FROM webapp_grupo WHERE nombre = 'Documentos Inmobiliarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Reglamentos de Copropiedad', 'Normativa interna de comunidades de edificios', id, true FROM webapp_grupo WHERE nombre = 'Documentos Inmobiliarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Actas de Asamblea', 'Registros de reuniones de comunidades', id, true FROM webapp_grupo WHERE nombre = 'Documentos Inmobiliarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Promesas de Compraventa', 'Acuerdos preliminares de transacción inmobiliaria', id, true FROM webapp_grupo WHERE nombre = 'Documentos Inmobiliarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Estudios de Título', 'Informes legales sobre situación de propiedades', id, true FROM webapp_grupo WHERE nombre = 'Documentos Inmobiliarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contratos de Corretaje', 'Acuerdos con corredores de propiedades', id, true FROM webapp_grupo WHERE nombre = 'Documentos Inmobiliarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados DOM', 'Documentos de la Dirección de Obras Municipales', id, true FROM webapp_grupo WHERE nombre = 'Documentos Inmobiliarios';

-- =============================================================================
-- 7. DOCUMENTOS PERSONALES E IDENTIFICACIÓN
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Documentos Personales', 'Documentación de identificación personal y certificados individuales', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Cédula de Identidad', 'Documento nacional de identificación personal', id, true FROM webapp_grupo WHERE nombre = 'Documentos Personales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Pasaporte', 'Documento de viaje internacional', id, true FROM webapp_grupo WHERE nombre = 'Documentos Personales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificado de Nacimiento', 'Documento oficial de registro de nacimiento', id, true FROM webapp_grupo WHERE nombre = 'Documentos Personales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificado de Matrimonio', 'Documento oficial de registro matrimonial', id, true FROM webapp_grupo WHERE nombre = 'Documentos Personales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificado de Defunción', 'Documento oficial de registro de fallecimiento', id, true FROM webapp_grupo WHERE nombre = 'Documentos Personales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Licencia de Conducir', 'Permiso oficial para conducir vehículos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Personales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificado de Antecedentes', 'Documento oficial sobre antecedentes penales', id, true FROM webapp_grupo WHERE nombre = 'Documentos Personales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificado de Residencia', 'Documento que acredita domicilio habitual', id, true FROM webapp_grupo WHERE nombre = 'Documentos Personales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificado de Situación Militar', 'Documento de situación respecto al servicio militar', id, true FROM webapp_grupo WHERE nombre = 'Documentos Personales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Credencial Electoral', 'Documento para ejercer derecho a voto', id, true FROM webapp_grupo WHERE nombre = 'Documentos Personales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificado de Viajes', 'Registro oficial de entradas y salidas del país', id, true FROM webapp_grupo WHERE nombre = 'Documentos Personales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Posesiones Efectivas', 'Documentos de herencia y sucesiones', id, true FROM webapp_grupo WHERE nombre = 'Documentos Personales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificado de Discapacidad', 'Documento oficial de calificación de discapacidad', id, true FROM webapp_grupo WHERE nombre = 'Documentos Personales';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Credenciales de Salud', 'Tarjetas de identificación para sistemas de salud', id, true FROM webapp_grupo WHERE nombre = 'Documentos Personales';

-- =============================================================================
-- 8. DOCUMENTOS EDUCATIVOS Y ACADÉMICOS
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Documentos Educativos', 'Documentación relacionada con formación académica y certificaciones educativas', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Estudio', 'Documentos oficiales de estudios realizados', id, true FROM webapp_grupo WHERE nombre = 'Documentos Educativos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Títulos Profesionales', 'Diplomas y credenciales de titulación superior', id, true FROM webapp_grupo WHERE nombre = 'Documentos Educativos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Concentraciones de Notas', 'Registros detallados de calificaciones académicas', id, true FROM webapp_grupo WHERE nombre = 'Documentos Educativos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Licencia de Enseñanza Media', 'Certificado de finalización de educación secundaria', id, true FROM webapp_grupo WHERE nombre = 'Documentos Educativos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Diplomas', 'Certificados de culminación de programas académicos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Educativos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Matrículas', 'Comprobantes de inscripción en instituciones educativas', id, true FROM webapp_grupo WHERE nombre = 'Documentos Educativos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Ranking', 'Documentos de posición relativa en promoción académica', id, true FROM webapp_grupo WHERE nombre = 'Documentos Educativos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados PSU/PTU', 'Resultados de pruebas de selección universitaria', id, true FROM webapp_grupo WHERE nombre = 'Documentos Educativos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Convalidaciones', 'Documentos de reconocimiento de estudios previos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Educativos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Becas y Créditos', 'Documentación de beneficios estudiantiles', id, true FROM webapp_grupo WHERE nombre = 'Documentos Educativos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados SENCE', 'Documentos de capacitación laboral certificada', id, true FROM webapp_grupo WHERE nombre = 'Documentos Educativos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Idiomas', 'Acreditaciones de competencia en lenguas extranjeras', id, true FROM webapp_grupo WHERE nombre = 'Documentos Educativos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Reconocimiento de Títulos', 'Documentos de validación de estudios extranjeros', id, true FROM webapp_grupo WHERE nombre = 'Documentos Educativos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Programas de Estudio', 'Documentación detallada de contenidos académicos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Educativos';

-- =============================================================================
-- 9. DOCUMENTOS MÉDICOS Y DE SALUD
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Documentos Médicos', 'Documentación relacionada con atención sanitaria y salud', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Licencias Médicas', 'Certificados de reposo laboral por enfermedad', id, true FROM webapp_grupo WHERE nombre = 'Documentos Médicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Recetas Médicas', 'Prescripciones profesionales de medicamentos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Médicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Resultados de Exámenes', 'Informes de análisis clínicos y de laboratorio', id, true FROM webapp_grupo WHERE nombre = 'Documentos Médicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Informes Médicos', 'Reportes profesionales sobre condiciones de salud', id, true FROM webapp_grupo WHERE nombre = 'Documentos Médicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Epicrisis', 'Resúmenes clínicos de hospitalizaciones', id, true FROM webapp_grupo WHERE nombre = 'Documentos Médicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados Médicos', 'Constancias profesionales sobre estado de salud', id, true FROM webapp_grupo WHERE nombre = 'Documentos Médicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Bonos y Reembolsos', 'Documentación de pago y cobertura de prestaciones', id, true FROM webapp_grupo WHERE nombre = 'Documentos Médicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Carné de Vacunas', 'Registro oficial de inmunizaciones', id, true FROM webapp_grupo WHERE nombre = 'Documentos Médicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Órdenes Médicas', 'Solicitudes profesionales de exámenes o procedimientos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Médicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Historia Clínica', 'Registro cronológico de atenciones de salud', id, true FROM webapp_grupo WHERE nombre = 'Documentos Médicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados GES/AUGE', 'Documentación de garantías explícitas en salud', id, true FROM webapp_grupo WHERE nombre = 'Documentos Médicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Nacimiento Médico', 'Documentos clínicos de nacimiento', id, true FROM webapp_grupo WHERE nombre = 'Documentos Médicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Defunción Médico', 'Documentos clínicos de fallecimiento', id, true FROM webapp_grupo WHERE nombre = 'Documentos Médicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Consentimientos Informados', 'Autorizaciones para procedimientos médicos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Médicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Informes Radiológicos', 'Reportes de estudios de imágenes', id, true FROM webapp_grupo WHERE nombre = 'Documentos Médicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Derivaciones', 'Referencias entre profesionales médicos', id, true FROM webapp_grupo WHERE nombre = 'Documentos Médicos';

-- =============================================================================
-- 10. DOCUMENTOS SOCIETARIOS Y CORPORATIVOS
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Documentos Societarios', 'Documentación relacionada con constitución y operación de sociedades', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Escritura de Constitución', 'Documento fundacional de una sociedad', id, true FROM webapp_grupo WHERE nombre = 'Documentos Societarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Estatutos Sociales', 'Reglas internas de funcionamiento de la sociedad', id, true FROM webapp_grupo WHERE nombre = 'Documentos Societarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Modificaciones Societarias', 'Cambios en la estructura o funcionamiento social', id, true FROM webapp_grupo WHERE nombre = 'Documentos Societarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Extractos Legales', 'Publicaciones en Diario Oficial', id, true FROM webapp_grupo WHERE nombre = 'Documentos Societarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Inscripciones Registrales', 'Registros en Conservador de Bienes Raíces', id, true FROM webapp_grupo WHERE nombre = 'Documentos Societarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Actas de Directorio', 'Registros de sesiones del órgano directivo', id, true FROM webapp_grupo WHERE nombre = 'Documentos Societarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Actas de Junta de Accionistas', 'Registros de asambleas de propietarios', id, true FROM webapp_grupo WHERE nombre = 'Documentos Societarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Poderes Corporativos', 'Delegaciones formales de facultades', id, true FROM webapp_grupo WHERE nombre = 'Documentos Societarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Vigencia', 'Documentos de existencia legal actualizada', id, true FROM webapp_grupo WHERE nombre = 'Documentos Societarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Libros Sociales', 'Registros oficiales de accionistas y otros', id, true FROM webapp_grupo WHERE nombre = 'Documentos Societarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Transformaciones', 'Cambios de tipo societario', id, true FROM webapp_grupo WHERE nombre = 'Documentos Societarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Fusiones y Divisiones', 'Documentos de reorganización empresarial', id, true FROM webapp_grupo WHERE nombre = 'Documentos Societarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Disoluciones', 'Documentación de término de sociedades', id, true FROM webapp_grupo WHERE nombre = 'Documentos Societarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contratos de Confidencialidad', 'Acuerdos de reserva de información', id, true FROM webapp_grupo WHERE nombre = 'Documentos Societarios';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Informes Corporativos', 'Reportes oficiales sobre operación social', id, true FROM webapp_grupo WHERE nombre = 'Documentos Societarios';

-- =============================================================================
-- 11. DOCUMENTOS DE COMERCIO EXTERIOR
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Comercio Exterior', 'Documentación relacionada con importaciones, exportaciones y aduanas', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Declaración de Ingreso (DIN)', 'Documento aduanero para importaciones', id, true FROM webapp_grupo WHERE nombre = 'Comercio Exterior';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Declaración de Exportación (DUS)', 'Documento aduanero para exportaciones', id, true FROM webapp_grupo WHERE nombre = 'Comercio Exterior';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Conocimiento de Embarque (B/L)', 'Documento de transporte marítimo internacional', id, true FROM webapp_grupo WHERE nombre = 'Comercio Exterior';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Guía Aérea (AWB)', 'Documento de transporte aéreo internacional', id, true FROM webapp_grupo WHERE nombre = 'Comercio Exterior';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Factura Comercial Internacional', 'Documento comercial para transacciones internacionales', id, true FROM webapp_grupo WHERE nombre = 'Comercio Exterior';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Packing List', 'Lista detallada de contenido de embarques', id, true FROM webapp_grupo WHERE nombre = 'Comercio Exterior';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Origen', 'Documentos que acreditan procedencia de mercancías', id, true FROM webapp_grupo WHERE nombre = 'Comercio Exterior';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados Fitosanitarios', 'Documentos sanitarios para productos vegetales', id, true FROM webapp_grupo WHERE nombre = 'Comercio Exterior';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados Zoosanitarios', 'Documentos sanitarios para productos animales', id, true FROM webapp_grupo WHERE nombre = 'Comercio Exterior';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Cartas de Crédito', 'Instrumentos bancarios para comercio internacional', id, true FROM webapp_grupo WHERE nombre = 'Comercio Exterior';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Manifiestos de Carga', 'Documentos de declaración de carga completa', id, true FROM webapp_grupo WHERE nombre = 'Comercio Exterior';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Pólizas de Seguro', 'Documentos de cobertura para transporte internacional', id, true FROM webapp_grupo WHERE nombre = 'Comercio Exterior';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Documentos ISPM-15', 'Certificaciones para embalajes de madera', id, true FROM webapp_grupo WHERE nombre = 'Comercio Exterior';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Resoluciones Aduaneras', 'Decisiones oficiales de la autoridad aduanera', id, true FROM webapp_grupo WHERE nombre = 'Comercio Exterior';

-- =============================================================================
-- 12. DOCUMENTOS DE SEGUROS Y PREVISIÓN
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Seguros y Previsión', 'Documentación relacionada con pólizas, coberturas y previsión social', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Pólizas de Seguro General', 'Contratos de cobertura de riesgos generales', id, true FROM webapp_grupo WHERE nombre = 'Seguros y Previsión';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Pólizas de Vida', 'Contratos de seguro de vida', id, true FROM webapp_grupo WHERE nombre = 'Seguros y Previsión';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Pólizas de Salud', 'Contratos de seguro complementario de salud', id, true FROM webapp_grupo WHERE nombre = 'Seguros y Previsión';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Cobertura', 'Documentos que acreditan protección vigente', id, true FROM webapp_grupo WHERE nombre = 'Seguros y Previsión';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Denuncios de Siniestro', 'Reportes formales de eventos cubiertos', id, true FROM webapp_grupo WHERE nombre = 'Seguros y Previsión';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Liquidaciones de Siniestro', 'Documentos de resolución de reclamos', id, true FROM webapp_grupo WHERE nombre = 'Seguros y Previsión';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de AFP', 'Documentos de afiliación y cotizaciones previsionales', id, true FROM webapp_grupo WHERE nombre = 'Seguros y Previsión';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de APV', 'Documentos de ahorro previsional voluntario', id, true FROM webapp_grupo WHERE nombre = 'Seguros y Previsión';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Documentos de Pensión', 'Certificados y liquidaciones de pensiones', id, true FROM webapp_grupo WHERE nombre = 'Seguros y Previsión';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Isapre', 'Documentos de afiliación a instituciones de salud', id, true FROM webapp_grupo WHERE nombre = 'Seguros y Previsión';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Fonasa', 'Documentos de afiliación al sistema público de salud', id, true FROM webapp_grupo WHERE nombre = 'Seguros y Previsión';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Mutualidades', 'Documentos de afiliación a sistemas de seguridad laboral', id, true FROM webapp_grupo WHERE nombre = 'Seguros y Previsión';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Seguro de Cesantía', 'Documentos de afiliación y beneficios por desempleo', id, true FROM webapp_grupo WHERE nombre = 'Seguros y Previsión';

-- =============================================================================
-- 13. DOCUMENTOS DE SERVICIOS BÁSICOS Y MUNICIPALES
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Servicios Básicos', 'Documentación relacionada con suministros esenciales y servicios municipales', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Boletas de Electricidad', 'Facturas de consumo eléctrico', id, true FROM webapp_grupo WHERE nombre = 'Servicios Básicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Boletas de Agua', 'Facturas de consumo de agua potable', id, true FROM webapp_grupo WHERE nombre = 'Servicios Básicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Boletas de Gas', 'Facturas de consumo de gas', id, true FROM webapp_grupo WHERE nombre = 'Servicios Básicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Boletas de Internet/TV', 'Facturas de servicios de telecomunicaciones', id, true FROM webapp_grupo WHERE nombre = 'Servicios Básicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Boletas de Telefonía', 'Facturas de servicios telefónicos', id, true FROM webapp_grupo WHERE nombre = 'Servicios Básicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contribuciones', 'Comprobantes de impuesto territorial', id, true FROM webapp_grupo WHERE nombre = 'Servicios Básicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Patentes Municipales', 'Documentos de pago de patentes comerciales', id, true FROM webapp_grupo WHERE nombre = 'Servicios Básicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Permisos Municipales', 'Autorizaciones para actividades específicas', id, true FROM webapp_grupo WHERE nombre = 'Servicios Básicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Derechos de Aseo', 'Comprobantes de pago por servicios de recolección', id, true FROM webapp_grupo WHERE nombre = 'Servicios Básicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados Municipales', 'Documentos oficiales emitidos por municipalidades', id, true FROM webapp_grupo WHERE nombre = 'Servicios Básicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Permisos de Circulación', 'Documentos de autorización vehicular anual', id, true FROM webapp_grupo WHERE nombre = 'Servicios Básicos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contratos de Servicios', 'Acuerdos formales con proveedores de servicios', id, true FROM webapp_grupo WHERE nombre = 'Servicios Básicos';

-- =============================================================================
-- 14. DOCUMENTOS DE RECURSOS HUMANOS
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Recursos Humanos', 'Documentación relacionada con gestión de personal y capital humano', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Currículum Vitae', 'Documentos de presentación profesional', id, true FROM webapp_grupo WHERE nombre = 'Recursos Humanos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Evaluaciones de Desempeño', 'Registros de evaluación laboral periódica', id, true FROM webapp_grupo WHERE nombre = 'Recursos Humanos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Perfiles de Cargo', 'Descripciones formales de funciones laborales', id, true FROM webapp_grupo WHERE nombre = 'Recursos Humanos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Manuales de Procedimientos', 'Guías de procesos organizacionales', id, true FROM webapp_grupo WHERE nombre = 'Recursos Humanos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Políticas Internas', 'Normativas formales de la organización', id, true FROM webapp_grupo WHERE nombre = 'Recursos Humanos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Planes de Capacitación', 'Programas de formación para el personal', id, true FROM webapp_grupo WHERE nombre = 'Recursos Humanos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Capacitación', 'Acreditaciones de formación completada', id, true FROM webapp_grupo WHERE nombre = 'Recursos Humanos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Registro de Vacaciones', 'Control de periodos de descanso legal', id, true FROM webapp_grupo WHERE nombre = 'Recursos Humanos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Comunicaciones Internas', 'Memorandos y circulares organizacionales', id, true FROM webapp_grupo WHERE nombre = 'Recursos Humanos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Expedientes de Personal', 'Archivos completos de trabajadores', id, true FROM webapp_grupo WHERE nombre = 'Recursos Humanos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contratos con Proveedores RRHH', 'Acuerdos con consultoras y servicios externos', id, true FROM webapp_grupo WHERE nombre = 'Recursos Humanos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Acuerdos de Confidencialidad', 'Compromisos de reserva de información', id, true FROM webapp_grupo WHERE nombre = 'Recursos Humanos';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Documentos de Inducción', 'Material de orientación para nuevos empleados', id, true FROM webapp_grupo WHERE nombre = 'Recursos Humanos';

-- =============================================================================
-- 15. DOCUMENTOS CONTABLES Y FINANCIEROS
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Contabilidad y Finanzas', 'Documentación relacionada con registros contables y gestión financiera', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Libros Contables', 'Registros oficiales de contabilidad', id, true FROM webapp_grupo WHERE nombre = 'Contabilidad y Finanzas';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Balances', 'Estados de situación financiera', id, true FROM webapp_grupo WHERE nombre = 'Contabilidad y Finanzas';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Estados de Resultados', 'Informes de pérdidas y ganancias', id, true FROM webapp_grupo WHERE nombre = 'Contabilidad y Finanzas';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Flujos de Caja', 'Reportes de movimientos de efectivo', id, true FROM webapp_grupo WHERE nombre = 'Contabilidad y Finanzas';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Presupuestos', 'Proyecciones financieras formales', id, true FROM webapp_grupo WHERE nombre = 'Contabilidad y Finanzas';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Libros de Honorarios', 'Registros de pagos a prestadores de servicios', id, true FROM webapp_grupo WHERE nombre = 'Contabilidad y Finanzas';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Libros de Remuneraciones', 'Registros de pagos a trabajadores', id, true FROM webapp_grupo WHERE nombre = 'Contabilidad y Finanzas';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Informes de Auditoría', 'Reportes de revisión contable independiente', id, true FROM webapp_grupo WHERE nombre = 'Contabilidad y Finanzas';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Declaraciones Juradas', 'Documentos tributarios informativos', id, true FROM webapp_grupo WHERE nombre = 'Contabilidad y Finanzas';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Plan de Cuentas', 'Estructura de clasificación contable', id, true FROM webapp_grupo WHERE nombre = 'Contabilidad y Finanzas';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Comprobantes Contables', 'Documentos de respaldo de asientos', id, true FROM webapp_grupo WHERE nombre = 'Contabilidad y Finanzas';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Informes Financieros', 'Reportes analíticos de situación económica', id, true FROM webapp_grupo WHERE nombre = 'Contabilidad y Finanzas';

-- =============================================================================
-- 16. DOCUMENTOS DE VEHÍCULOS Y TRANSPORTE
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Vehículos y Transporte', 'Documentación relacionada con vehículos, transportes y movilidad', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Permisos de Circulación', 'Autorizaciones municipales anuales', id, true FROM webapp_grupo WHERE nombre = 'Vehículos y Transporte';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Revisiones Técnicas', 'Certificados de inspección vehicular', id, true FROM webapp_grupo WHERE nombre = 'Vehículos y Transporte';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'SOAP', 'Seguros obligatorios de accidentes personales', id, true FROM webapp_grupo WHERE nombre = 'Vehículos y Transporte';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Seguros Vehiculares', 'Pólizas de cobertura para vehículos', id, true FROM webapp_grupo WHERE nombre = 'Vehículos y Transporte';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Homologación', 'Documentos de conformidad técnica', id, true FROM webapp_grupo WHERE nombre = 'Vehículos y Transporte';

-- =============================================================================
-- 17. DOCUMENTOS DE RESTAURANTES Y GASTRONOMÍA
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Restaurantes y Gastronomía', 'Documentación específica para restaurantes, cafeterías y servicios de alimentación', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Carta de Comidas', 'Menú oficial del local', id, true FROM webapp_grupo WHERE nombre = 'Restaurantes y Gastronomía';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Carta de Bebidas', 'Listado de bebidas y licores ofrecidos', id, true FROM webapp_grupo WHERE nombre = 'Restaurantes y Gastronomía';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Permiso Sanitario', 'Autorización sanitaria para funcionamiento', id, true FROM webapp_grupo WHERE nombre = 'Restaurantes y Gastronomía';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificado de Manipulación de Alimentos', 'Certificados individuales del personal', id, true FROM webapp_grupo WHERE nombre = 'Restaurantes y Gastronomía';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Libro de Reclamos', 'Registro obligatorio de reclamos de clientes', id, true FROM webapp_grupo WHERE nombre = 'Restaurantes y Gastronomía';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Control de Temperaturas', 'Registros de temperaturas de cámaras y alimentos', id, true FROM webapp_grupo WHERE nombre = 'Restaurantes y Gastronomía';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Control de Plagas', 'Registros y certificados de fumigación', id, true FROM webapp_grupo WHERE nombre = 'Restaurantes y Gastronomía';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Horarios de Atención', 'Documento oficial de horarios del local', id, true FROM webapp_grupo WHERE nombre = 'Restaurantes y Gastronomía';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contrato con Proveedores de Insumos', 'Acuerdos con proveedores de alimentos y bebidas', id, true FROM webapp_grupo WHERE nombre = 'Restaurantes y Gastronomía';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Origen de Alimentos', 'Documentos que acreditan la procedencia de los insumos', id, true FROM webapp_grupo WHERE nombre = 'Restaurantes y Gastronomía';

-- =============================================================================
-- 18. DOCUMENTOS DE COMERCIO MINORISTA Y RETAIL
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Comercio Minorista', 'Documentación específica para tiendas, almacenes y comercio al detalle', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Libro de Reclamos', 'Registro obligatorio de reclamos de clientes', id, true FROM webapp_grupo WHERE nombre = 'Comercio Minorista';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Permiso de Funcionamiento', 'Autorización municipal para operar', id, true FROM webapp_grupo WHERE nombre = 'Comercio Minorista';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Libro de Inventario', 'Registro de existencias y stock', id, true FROM webapp_grupo WHERE nombre = 'Comercio Minorista';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contratos con Proveedores', 'Acuerdos comerciales con proveedores', id, true FROM webapp_grupo WHERE nombre = 'Comercio Minorista';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Garantía', 'Documentos de garantía de productos vendidos', id, true FROM webapp_grupo WHERE nombre = 'Comercio Minorista';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Horarios de Atención', 'Documento oficial de horarios del local', id, true FROM webapp_grupo WHERE nombre = 'Comercio Minorista';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Seguridad', 'Documentos de cumplimiento de normas de seguridad', id, true FROM webapp_grupo WHERE nombre = 'Comercio Minorista';

-- =============================================================================
-- 19. DOCUMENTOS DE HOTELERÍA Y TURISMO
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Hotelería y Turismo', 'Documentación para hoteles, hostales, agencias y servicios turísticos', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Registro de Huéspedes', 'Libro de registro de pasajeros', id, true FROM webapp_grupo WHERE nombre = 'Hotelería y Turismo';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Permiso de Funcionamiento', 'Autorización municipal para operar', id, true FROM webapp_grupo WHERE nombre = 'Hotelería y Turismo';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificado Sernatur', 'Inscripción en el registro nacional de prestadores turísticos', id, true FROM webapp_grupo WHERE nombre = 'Hotelería y Turismo';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Libro de Reclamos', 'Registro obligatorio de reclamos de clientes', id, true FROM webapp_grupo WHERE nombre = 'Hotelería y Turismo';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contratos con Agencias', 'Acuerdos con agencias de viaje y tour operadores', id, true FROM webapp_grupo WHERE nombre = 'Hotelería y Turismo';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Seguridad', 'Documentos de cumplimiento de normas de seguridad', id, true FROM webapp_grupo WHERE nombre = 'Hotelería y Turismo';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Horarios de Atención', 'Documento oficial de horarios del establecimiento', id, true FROM webapp_grupo WHERE nombre = 'Hotelería y Turismo';

-- =============================================================================
-- 20. DOCUMENTOS DE TRANSPORTE Y LOGÍSTICA
-- =============================================================================
INSERT INTO webapp_grupo (nombre, descripcion, activo) VALUES
('Transporte y Logística', 'Documentación para empresas de transporte de carga y pasajeros', true);

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Permiso de Circulación', 'Autorización municipal anual para vehículos', id, true FROM webapp_grupo WHERE nombre = 'Transporte y Logística';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificado de Inscripción en el Registro Nacional de Transporte', 'Documento del Ministerio de Transportes', id, true FROM webapp_grupo WHERE nombre = 'Transporte y Logística';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Contrato de Flete', 'Acuerdos de transporte de carga', id, true FROM webapp_grupo WHERE nombre = 'Transporte y Logística';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Libro de Ruta', 'Registro de viajes y recorridos', id, true FROM webapp_grupo WHERE nombre = 'Transporte y Logística';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Revisión Técnica', 'Documentos de inspección vehicular', id, true FROM webapp_grupo WHERE nombre = 'Transporte y Logística';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Certificados de Seguro', 'Pólizas de seguro de carga y pasajeros', id, true FROM webapp_grupo WHERE nombre = 'Transporte y Logística';

INSERT INTO webapp_modulo (nombre, descripcion, grupo_id, activo)
SELECT 'Libro de Reclamos', 'Registro obligatorio de reclamos de clientes', id, true FROM webapp_grupo WHERE nombre = 'Transporte y Logística';