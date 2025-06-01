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
-- 1. DOCUMENTOS TRIBUTARIOS Y SII (Actualización de esquema_json)
-- =============================================================================
-- Formulario 29
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Formulario29": {
      "PeriodoTributario": {
        "Anio": "YYYY",
        "Mes": "MM"
      },
      "DatosContribuyente": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social"
      },
      "ResumenImpuestos": {
        "IVA_DebitoFiscal": 0,
        "IVA_CreditoFiscal": 0,
        "PPM_Obligatorio": 0,
        "PPM_Voluntario": 0,
        "RetencionesNetas": 0,
        "TotalATributar": 0,
        "TotalAPagar": 0
      },
      "DetalleIVA": {
        "VentasAfectas": 0,
        "VentasExentas": 0,
        "ComprasAfectas": 0,
        "ComprasExentas": 0,
        "CreditoImportaciones": 0
      }
    }
  }
}' WHERE nombre = 'Formulario 29';

-- Formulario 22
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Formulario22": {
      "AnioTributario": "YYYY",
      "DatosContribuyente": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social",
        "ActividadPrincipal": "Descripción de la actividad"
      },
      "ResumenRentas": {
        "TotalRentaBruta": 0,
        "TotalRentaNetaGlobal": 0,
        "CreditosContraImpuesto": 0,
        "TotalImpuestoDeterminado": 0,
        "PPM_PagadoAnio": 0,
        "RemanentePPM": 0,
        "ImpuestoFinalAPagar": 0,
        "DevolucionSolicitada": 0
      },
      "InformacionAdicional": {
        "CodigoActividadSII": "",
        "TipoDeclaracion": "Original/Rectificatoria"
      }
    }
  }
}' WHERE nombre = 'Formulario 22';

-- Formulario 50
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Formulario50": {
      "PeriodoTributario": {
        "Anio": "YYYY",
        "Mes": "MM"
      },
      "DatosContribuyente": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social"
      },
      "ImpuestosEspecificos": {
        "ImpuestoRentasArt42N2": 0,
        "RetencionArt48": 0,
        "ImpuestoUnicoTrabajadores": 0,
        "OtrosImpuestos": 0,
        "TotalAPagar": 0
      }
    }
  }
}' WHERE nombre = 'Formulario 50';

-- Formulario 1879
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Formulario1879": {
      "AnioTributario": "YYYY",
      "DatosDeclarante": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social"
      },
      "BeneficiariosRetenciones": [
        {
          "RutBeneficiario": "XXXXXXXX-X",
          "NombreBeneficiario": "Nombre completo",
          "MontoBrutoPagado": 0,
          "MontoRetenido": 0
        }
      ]
    }
  }
}' WHERE nombre = 'Formulario 1879';

-- Formulario 1887
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Formulario1887": {
      "AnioTributario": "YYYY",
      "DatosDeclarante": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social"
      },
      "TrabajadoresSueldos": [
        {
          "RutTrabajador": "XXXXXXXX-X",
          "NombreTrabajador": "Nombre completo",
          "RentaBruta": 0,
          "ImpuestoUnicoRetenido": 0,
          "CotizacionesPrevisionales": 0
        }
      ]
    }
  }
}' WHERE nombre = 'Formulario 1887';

-- Certificado 29
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Certificado29": {
      "Anio": "YYYY",
      "Mes": "MM",
      "DatosContribuyente": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social"
      },
      "DetalleImpuestos": {
        "IVA_Pagado": 0,
        "PPM_Pagado": 0,
        "RetencionesPagadas": 0
      }
    }
  }
}' WHERE nombre = 'Certificado 29';

-- Certificado 1 (Honorarios)
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "CertificadoHonorarios": {
      "AnioComercial": "YYYY",
      "DatosEmisor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social"
      },
      "DatosReceptor": {
        "Rut": "XXXXXXXX-X",
        "Nombre": "Nombre Completo"
      },
      "DetalleHonorarios": {
        "MontoBrutoHonorarios": 0,
        "MontoRetencionImpuesto": 0,
        "MontoLiquidoPagado": 0,
        "FechaEmision": "YYYY-MM-DD"
      }
    }
  }
}' WHERE nombre = 'Certificado 1';

-- Certificado 3 (Dividendos)
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "CertificadoDividendos": {
      "AnioTributario": "YYYY",
      "DatosEmisorEmpresa": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social de la Empresa"
      },
      "DatosPerceptorDividendos": {
        "Rut": "XXXXXXXX-X",
        "Nombre": "Nombre Completo del Accionista"
      },
      "DetalleDividendos": {
        "MontoDividendoBruto": 0,
        "MontoCreditoImpuestoPrimeraCategoria": 0,
        "MontoRetenidoAdicional": 0
      },
      "FechaEmision": "YYYY-MM-DD"
    }
  }
}' WHERE nombre = 'Certificado 3';

-- Certificado 6 (Sueldos)
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "CertificadoSueldos": {
      "AnioTributario": "YYYY",
      "DatosEmpleador": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social del Empleador"
      },
      "DatosTrabajador": {
        "Rut": "XXXXXXXX-X",
        "NombreCompleto": "Nombre Completo del Trabajador"
      },
      "Remuneraciones": {
        "RentaBrutaTotalAnual": 0,
        "ImpuestoUnicoRetenidoAnual": 0,
        "CotizacionesPrevisionalesObligatorias": 0,
        "CotizacionesSaludObligatorias": 0
      },
      "FechaEmision": "YYYY-MM-DD"
    }
  }
}' WHERE nombre = 'Certificado 6';

-- Certificados de IVA
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "CertificadoIVA": {
      "TipoCertificado": "Compras/Ventas",
      "Periodo": {
        "Anio": "YYYY",
        "Mes": "MM"
      },
      "DatosContribuyente": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social"
      },
      "ResumenIVA": {
        "TotalNeto": 0,
        "TotalIVA": 0,
        "TotalDocumentos": 0,
        "DetalleDocumentos": [
          {
            "TipoDocumento": "Factura/Boleta",
            "Folio": "12345",
            "FechaEmision": "YYYY-MM-DD",
            "MontoNeto": 0,
            "MontoIVA": 0
          }
        ]
      }
    }
  }
}' WHERE nombre = 'Certificados de IVA';

-- Contribuciones
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ComprobanteContribuciones": {
      "Anio": "YYYY",
      "RolPropiedad": "XXXX-YY",
      "DireccionPropiedad": "Calle, Número, Comuna",
      "PeriodoPago": "Cuota 1/2/3/4",
      "MontoAPagar": 0,
      "MontoPagado": 0,
      "FechaVencimiento": "YYYY-MM-DD",
      "FechaPago": "YYYY-MM-DD",
      "ComprobanteNumero": "ABC12345"
    }
  }
}' WHERE nombre = 'Contribuciones';

-- Patentes Municipales
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ComprobantePatenteMunicipal": {
      "Anio": "YYYY",
      "TipoPatente": "Comercial/Profesional/Industrial",
      "RazonSocialEmpresa": "Nombre o Razón Social",
      "RutEmpresa": "XXXXXXXX-X",
      "DireccionLocal": "Calle, Número, Comuna",
      "PeriodoPago": "Primer Semestre/Segundo Semestre",
      "MontoAPagar": 0,
      "MontoPagado": 0,
      "FechaVencimiento": "YYYY-MM-DD",
      "FechaPago": "YYYY-MM-DD",
      "NumeroComprobante": "MUN-XYZ-789"
    }
  }
}' WHERE nombre = 'Patentes Municipales';

-- Inicio de Actividades
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "InicioActividadesSII": {
      "FechaInicioActividades": "YYYY-MM-DD",
      "RutContribuyente": "XXXXXXXX-X",
      "RazonSocial": "Nombre o Razón Social",
      "ActividadEconomicaPrincipal": {
        "CodigoSII": "XXXXXX",
        "Descripcion": "Descripción de la actividad"
      },
      "CapitalInicial": 0,
      "DireccionComercial": "Calle, Número, Oficina/Departamento, Comuna, Ciudad",
      "TipoContribuyente": "Persona Natural/Persona Jurídica",
      "FechaTimbreElectronico": "YYYY-MM-DD HH:MM:SS"
    }
  }
}' WHERE nombre = 'Inicio de Actividades';

-- Término de Giro
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "TerminoGiroSII": {
      "FechaTerminoGiro": "YYYY-MM-DD",
      "RutContribuyente": "XXXXXXXX-X",
      "RazonSocial": "Nombre o Razón Social",
      "MotivoTermino": "Cierre/Venta/Fusión",
      "DeclaracionesPendientes": "Si/No",
      "IVA_Final": 0,
      "ImpuestoRenta_Final": 0,
      "ComprobanteSolicitudNumero": "TG-XXXXXX",
      "FechaTimbreElectronico": "YYYY-MM-DD HH:MM:SS"
    }
  }
}' WHERE nombre = 'Término de Giro';

-- Rut Empresa
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "RutEmpresa": {
      "Rut": "XXXXXXXX-X",
      "RazonSocial": "Nombre o Razón Social",
      "TipoContribuyente": "Persona Natural/Persona Jurídica",
      "FechaInicioActividades": "YYYY-MM-DD",
      "ActividadesEconomicas": [
        {
          "CodigoSII": "XXXXXX",
          "Descripcion": "Descripción de la actividad",
          "Principal": true
        }
      ],
      "DireccionComercial": "Calle, Número, Oficina/Departamento, Comuna, Ciudad",
      "Telefono": "+569 XXXXXXXX",
      "Email": "correo@ejemplo.com",
      "EstadoRut": "Activo/Inactivo"
    }
  }
}' WHERE nombre = 'Rut Empresa';

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
-- 2. DOCUMENTOS COMERCIALES Y FACTURACIÓN ELECTRÓNICA (Actualización de esquema_json)
-- =============================================================================

-- Facturas Electrónicas (Emisión)
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "FacturaElectronica": {
      "TipoDocumento": "Factura Electrónica",
      "Folio": "XXXX",
      "FechaEmision": "YYYY-MM-DD",
      "DatosEmisor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Emisor",
        "Giro": "Giro Comercial",
        "Direccion": "Dirección Emisor"
      },
      "DatosReceptor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Receptor",
        "Giro": "Giro Comercial Receptor",
        "Direccion": "Dirección Receptor",
        "CorreoElectronico": "correo@receptor.com"
      },
      "DetalleItems": [
        {
          "NroLinea": 1,
          "CodigoProducto": "COD123",
          "Descripcion": "Descripción del producto/servicio",
          "Cantidad": 1,
          "PrecioUnitario": 1000,
          "MontoTotalLinea": 1000
        }
      ],
      "Totales": {
        "MontoNeto": 0,
        "MontoExento": 0,
        "MontoIVA": 0,
        "MontoTotal": 0
      },
      "CondicionesPago": "Contado/Crédito",
      "ReferenciaDocumentos": [
        {
          "TipoDocumentoReferencia": "Guía de Despacho",
          "FolioReferencia": "YYYY",
          "FechaReferencia": "YYYY-MM-DD"
        }
      ]
    }
  }
}' WHERE nombre = 'Facturas Electrónicas';

-- Facturas de Compra (Recepción)
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "FacturaCompra": {
      "TipoDocumento": "Factura de Compra",
      "Folio": "XXXX",
      "FechaEmision": "YYYY-MM-DD",
      "DatosEmisor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Proveedor"
      },
      "DatosReceptor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Empresa"
      },
      "DetalleItems": [
        {
          "NroLinea": 1,
          "Descripcion": "Descripción del producto/servicio comprado",
          "Cantidad": 1,
          "PrecioUnitario": 500,
          "MontoTotalLinea": 500
        }
      ],
      "Totales": {
        "MontoNeto": 0,
        "MontoIVA": 0,
        "MontoTotal": 0
      },
      "EstadoRecepcion": "Recibida/Aceptada/Rechazada",
      "FechaRecepcionSistema": "YYYY-MM-DD HH:MM:SS"
    }
  }
}' WHERE nombre = 'Facturas de Compra';

-- Facturas de Exportación
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "FacturaExportacion": {
      "TipoDocumento": "Factura de Exportación",
      "Folio": "EXXXXX",
      "FechaEmision": "YYYY-MM-DD",
      "DatosEmisor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Exportador"
      },
      "DatosReceptorExtranjero": {
        "Identificacion": "ID_EXTRANJERO",
        "NombreRazonSocial": "Nombre o Razón Social Cliente Extranjero",
        "Direccion": "Dirección Cliente Extranjero",
        "Pais": "País Cliente"
      },
      "DetalleItems": [
        {
          "NroLinea": 1,
          "Descripcion": "Descripción del producto exportado",
          "Cantidad": 1,
          "PrecioUnitarioUSD": 100,
          "MontoTotalLineaUSD": 100
        }
      ],
      "Totales": {
        "MontoTotalUSD": 0,
        "MontoTotalCLP": 0,
        "TipoCambio": 0
      },
      "Incoterm": "FOB/CIF/etc.",
      "ViaTransporte": "Marítima/Aérea/Terrestre",
      "ReferenciaOrdenCompra": "PO-XYZ"
    }
  }
}' WHERE nombre = 'Facturas de Exportación';

-- Facturas No Afectas/Exentas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "FacturaNoAfectaExenta": {
      "TipoDocumento": "Factura No Afecta o Exenta",
      "Folio": "EXXXXX",
      "FechaEmision": "YYYY-MM-DD",
      "DatosEmisor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Emisor"
      },
      "DatosReceptor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Receptor"
      },
      "DetalleItems": [
        {
          "NroLinea": 1,
          "Descripcion": "Descripción del servicio/producto exento",
          "Cantidad": 1,
          "PrecioUnitario": 1000,
          "MontoTotalLinea": 1000
        }
      ],
      "Totales": {
        "MontoTotalExento": 0
      },
      "GlosaExencion": "Descripción de la razón de exención o no afectación"
    }
  }
}' WHERE nombre = 'Facturas No Afectas/Exentas';

-- Boletas Electrónicas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "BoletaElectronica": {
      "TipoDocumento": "Boleta Electrónica",
      "Folio": "BXXXX",
      "FechaEmision": "YYYY-MM-DD",
      "HoraEmision": "HH:MM:SS",
      "DatosEmisor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Emisor"
      },
      "MontoTotal": 0,
      "DetalleItems": [
        {
          "NroLinea": 1,
          "Descripcion": "Descripción del producto/servicio",
          "Cantidad": 1,
          "MontoUnitario": 500,
          "MontoTotalLinea": 500
        }
      ],
      "MedioPago": "Efectivo/Tarjeta/Transferencia"
    }
  }
}' WHERE nombre = 'Boletas Electrónicas';

-- Boletas de Honorarios
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "BoletaHonorarios": {
      "TipoDocumento": "Boleta de Honorarios",
      "Folio": "HXXXX",
      "FechaEmision": "YYYY-MM-DD",
      "DatosEmisor": {
        "Rut": "XXXXXXXX-X",
        "NombreCompleto": "Nombre Completo Prestador",
        "ActividadEconomica": "Profesión u Oficio"
      },
      "DatosReceptor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Contratante"
      },
      "MontoBrutoHonorarios": 0,
      "MontoRetencion": 0,
      "PorcentajeRetencion": 0,
      "MontoLiquidoAPagar": 0,
      "GlosaServicio": "Descripción detallada del servicio prestado",
      "IndicaRetencion": "Sí/No"
    }
  }
}' WHERE nombre = 'Boletas de Honorarios';

-- Guías de Despacho
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "GuiaDespacho": {
      "TipoDocumento": "Guía de Despacho",
      "Folio": "GXXXX",
      "FechaEmision": "YYYY-MM-DD",
      "DatosEmisor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Emisor"
      },
      "DatosReceptor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Receptor"
      },
      "TipoTraslado": "Venta/Consignación/TrasladoInterno/etc.",
      "Origen": "Dirección de Origen",
      "Destino": "Dirección de Destino",
      "Transportista": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Transportista",
        "PatenteVehiculo": "AA-BB-CC"
      },
      "DetalleItems": [
        {
          "NroLinea": 1,
          "CodigoProducto": "PROD1",
          "Descripcion": "Descripción del producto",
          "Cantidad": 10,
          "UnidadMedida": "Unidades"
        }
      ],
      "ReferenciaDocumentoOrigen": {
        "Tipo": "Orden de Compra",
        "Folio": "OC-12345"
      }
    }
  }
}' WHERE nombre = 'Guías de Despacho';

-- Notas de Crédito
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "NotaCredito": {
      "TipoDocumento": "Nota de Crédito",
      "Folio": "NCXXXX",
      "FechaEmision": "YYYY-MM-DD",
      "DatosEmisor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Emisor"
      },
      "DatosReceptor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Receptor"
      },
      "DocumentoModificado": {
        "TipoDocumento": "Factura Electrónica",
        "Folio": "FXXXX",
        "FechaEmision": "YYYY-MM-DD"
      },
      "TipoCorrecion": "Anulación/Devolución/Descuento",
      "RazonCorrecion": "Motivo de la corrección",
      "DetalleAjuste": [
        {
          "NroLinea": 1,
          "Descripcion": "Ajuste por producto defectuoso",
          "CantidadAjustada": 1,
          "MontoAjusteUnitario": 100,
          "MontoTotalAjusteLinea": 100
        }
      ],
      "TotalesAjuste": {
        "MontoNetoAjuste": 0,
        "MontoIVAAjuste": 0,
        "MontoTotalAjuste": 0
      }
    }
  }
}' WHERE nombre = 'Notas de Crédito';

-- Notas de Débito
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "NotaDebito": {
      "TipoDocumento": "Nota de Débito",
      "Folio": "NDXXXX",
      "FechaEmision": "YYYY-MM-DD",
      "DatosEmisor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Emisor"
      },
      "DatosReceptor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Receptor"
      },
      "DocumentoModificado": {
        "TipoDocumento": "Factura Electrónica",
        "Folio": "FYYYY",
        "FechaEmision": "YYYY-MM-DD"
      },
      "RazonAumento": "Intereses/Gastos de cobranza/Error en facturación",
      "DetalleAumento": [
        {
          "NroLinea": 1,
          "Descripcion": "Intereses por atraso",
          "MontoAumentoUnitario": 50,
          "MontoTotalAumentoLinea": 50
        }
      ],
      "TotalesAumento": {
        "MontoNetoAumento": 0,
        "MontoIVAAumento": 0,
        "MontoTotalAumento": 0
      }
    }
  }
}' WHERE nombre = 'Notas de Débito';

-- Órdenes de Compra
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "OrdenCompra": {
      "NumeroOC": "OC-YYYY-MM-DD-XXXX",
      "FechaEmision": "YYYY-MM-DD",
      "DatosComprador": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Comprador",
        "Direccion": "Dirección Comprador"
      },
      "DatosProveedor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Proveedor",
        "Direccion": "Dirección Proveedor"
      },
      "DetalleItems": [
        {
          "NroLinea": 1,
          "CodigoProducto": "SKU001",
          "Descripcion": "Nombre del producto/servicio",
          "Cantidad": 5,
          "PrecioUnitario": 200,
          "MontoTotalLinea": 1000
        }
      ],
      "Subtotal": 0,
      "IVA": 0,
      "Total": 0,
      "CondicionesEntrega": "Plazo de entrega",
      "CondicionesPago": "Forma de pago",
      "EstadoOC": "Pendiente/Emitida/Aprobada/Rechazada"
    }
  }
}' WHERE nombre = 'Órdenes de Compra';

-- Cotizaciones
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Cotizacion": {
      "NumeroCotizacion": "COT-YYYY-MM-DD-XXXX",
      "FechaEmision": "YYYY-MM-DD",
      "FechaValidezHasta": "YYYY-MM-DD",
      "DatosEmisor": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Emisor"
      },
      "DatosCliente": {
        "NombreContacto": "Nombre del Contacto",
        "RazonSocial": "Nombre o Razón Social Cliente",
        "CorreoElectronico": "cliente@ejemplo.com",
        "Telefono": "+569 XXXXXXXX"
      },
      "DetalleItems": [
        {
          "NroLinea": 1,
          "Descripcion": "Descripción del producto/servicio cotizado",
          "Cantidad": 1,
          "PrecioUnitario": 1500,
          "MontoTotalLinea": 1500
        }
      ],
      "Subtotal": 0,
      "IVA": 0,
      "TotalEstimado": 0,
      "Observaciones": "Condiciones especiales de la cotización."
    }
  }
}' WHERE nombre = 'Cotizaciones';

-- Contratos Comerciales
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ContratoComercial": {
      "NumeroContrato": "CONT-YYYY-XXXX",
      "FechaContrato": "YYYY-MM-DD",
      "PartesContratantes": [
        {
          "Rol": "Vendedor",
          "Rut": "XXXXXXXX-X",
          "RazonSocial": "Nombre o Razón Social Vendedor",
          "RepresentanteLegal": "Nombre Representante Legal"
        },
        {
          "Rol": "Comprador",
          "Rut": "XXXXXXXX-X",
          "RazonSocial": "Nombre o Razón Social Comprador",
          "RepresentanteLegal": "Nombre Representante Legal"
        }
      ],
      "ObjetoContrato": "Descripción breve del objeto del contrato (ej. Compraventa de bienes, Prestación de servicios)",
      "ClausulasPrincipales": [
        {"Titulo": "Precio y Condiciones de Pago", "Contenido": "Detalle del precio y formas de pago."},
        {"Titulo": "Plazo de Entrega/Ejecución", "Contenido": "Fechas y plazos."},
        {"Titulo": "Condiciones de Garantía", "Contenido": "Cobertura de garantía."}
      ],
      "DuracionContrato": "DesdeYYYY-MM-DD hastaYYYY-MM-DD / Indefinido",
      "ValorTotalEstimado": 0,
      "EstadoContrato": "Vigente/Finalizado/Rescindido",
      "ArchivosAdjuntos": ["ruta/al/pdf_contrato.pdf"]
    }
  }
}' WHERE nombre = 'Contratos Comerciales';

-- Libros de Compra-Venta
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "LibroCompraVenta": {
      "TipoLibro": "Compras/Ventas",
      "Periodo": {
        "Anio": "YYYY",
        "Mes": "MM"
      },
      "DatosContribuyente": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social"
      },
      "ResumenPeriodo": {
        "TotalDocumentos": 0,
        "TotalNeto": 0,
        "TotalIVA": 0,
        "TotalExento": 0,
        "TotalImponible": 0
      },
      "DetalleDocumentos": [
        {
          "TipoDTE": "Factura/Boleta",
          "Folio": "XXXX",
          "FechaEmision": "YYYY-MM-DD",
          "RutContraparte": "XXXXXXXX-X",
          "MontoNeto": 0,
          "MontoIVA": 0,
          "MontoTotal": 0
        }
      ]
    }
  }
}' WHERE nombre = 'Libros de Compra-Venta';

-- Informes de Ventas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "InformeVentas": {
      "TipoInforme": "Diario/Semanal/Mensual/Anual",
      "PeriodoInforme": {
        "FechaInicio": "YYYY-MM-DD",
        "FechaFin": "YYYY-MM-DD"
      },
      "DatosEmpresa": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social"
      },
      "ResumenVentas": {
        "TotalVentasNetas": 0,
        "TotalIVA": 0,
        "TotalVentasBrutas": 0,
        "CantidadDocumentosEmitidos": 0,
        "VentasPorProductoTop5": [
          {"Producto": "Producto A", "MontoVenta": 0},
          {"Producto": "Producto B", "MontoVenta": 0}
        ],
        "VentasPorClienteTop5": [
          {"Cliente": "Cliente X", "MontoVenta": 0},
          {"Cliente": "Cliente Y", "MontoVenta": 0}
        ]
      },
      "MetasVentas": {
        "MetaPeriodo": 0,
        "PorcentajeCumplimiento": 0
      }
    }
  }
}' WHERE nombre = 'Informes de Ventas';

-- DTE Recibidos
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "DTERecibido": {
      "TipoDTE": "Factura/Nota de Crédito/Guía de Despacho",
      "Folio": "XXXX",
      "RutEmisor": "XXXXXXXX-X",
      "RazonSocialEmisor": "Nombre o Razón Social Emisor",
      "FechaEmision": "YYYY-MM-DD",
      "MontoTotal": 0,
      "EstadoRecepcionSII": "Aceptado/Rechazado/RecibidoConReparo",
      "FechaRecepcionSistema": "YYYY-MM-DD HH:MM:SS",
      "LinkPDF": "url_al_pdf_dte_recibido"
    }
  }
}' WHERE nombre = 'DTE Recibidos';

-- DTE Emitidos
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "DTEEmitido": {
      "TipoDTE": "Factura/Boleta/Guía de Despacho",
      "Folio": "XXXX",
      "RutReceptor": "XXXXXXXX-X",
      "RazonSocialReceptor": "Nombre o Razón Social Receptor",
      "FechaEmision": "YYYY-MM-DD",
      "MontoTotal": 0,
      "EstadoEnvioSII": "Enviado/Aceptado/Rechazado",
      "FechaAcuseReciboSII": "YYYY-MM-DD HH:MM:SS",
      "LinkPDF": "url_al_pdf_dte_emitido",
      "LinkXML": "url_al_xml_dte_emitido"
    }
  }
}' WHERE nombre = 'DTE Emitidos';

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
-- 3. DOCUMENTOS LABORALES Y PREVISIONALES (Actualización de esquema_json)
-- =============================================================================

-- Contratos de Trabajo
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ContratoTrabajo": {
      "TipoContrato": "Indefinido/Plazo Fijo/Por Obra",
      "NumeroContrato": "CT-YYYY-XXXX",
      "FechaInicio": "YYYY-MM-DD",
      "DatosEmpleador": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Empleador",
        "Direccion": "Dirección Empleador"
      },
      "DatosTrabajador": {
        "Rut": "XXXXXXXX-X",
        "NombreCompleto": "Nombre Completo Trabajador",
        "Nacionalidad": "Chilena/Extranjera",
        "FechaNacimiento": "YYYY-MM-DD",
        "Direccion": "Dirección Trabajador"
      },
      "Cargo": "Cargo del Trabajador",
      "SueldoBase": 0,
      "Jornada": "Completa/Parcial",
      "HorasSemanales": 45,
      "AnexosAsociados": ["ANEXO-001", "ANEXO-002"]
    }
  }
}' WHERE nombre = 'Contratos de Trabajo';

-- Anexos de Contrato
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "AnexoContrato": {
      "NumeroAnexo": "ANEXO-XXXX",
      "FechaAnexo": "YYYY-MM-DD",
      "ReferenciaContrato": {
        "NumeroContrato": "CT-YYYY-XXXX",
        "FechaContrato": "YYYY-MM-DD"
      },
      "DatosTrabajador": {
        "Rut": "XXXXXXXX-X",
        "NombreCompleto": "Nombre Completo Trabajador"
      },
      "TipoModificacion": "Cambio de Cargo/Aumento de Sueldo/Jornada/Dirección",
      "DetalleModificacion": "Descripción detallada del cambio o adenda.",
      "SueldoBaseNuevo": 0
    }
  }
}' WHERE nombre = 'Anexos de Contrato';

-- Finiquitos
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Finiquito": {
      "NumeroFiniquito": "FQN-XXXX",
      "FechaEmision": "YYYY-MM-DD",
      "DatosEmpleador": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Empleador"
      },
      "DatosTrabajador": {
        "Rut": "XXXXXXXX-X",
        "NombreCompleto": "Nombre Completo Trabajador",
        "FechaIngreso": "YYYY-MM-DD",
        "FechaEgreso": "YYYY-MM-DD"
      },
      "CausalTermino": "Artículo y letra de la causal",
      "DetallePagos": {
        "IndemnizacionAniosServicio": 0,
        "IndemnizacionSustitutivaAvisoPrevio": 0,
        "VacacionesPendientes": 0,
        "OtrosHaberes": 0,
        "TotalHaberes": 0,
        "Descuentos": 0,
        "TotalLiquidoAPagar": 0
      },
      "FechaRatificacion": "YYYY-MM-DD",
      "NotariaOIT": "Nombre Notaría o IT"
    }
  }
}' WHERE nombre = 'Finiquitos';

-- Liquidaciones de Sueldo
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "LiquidacionSueldo": {
      "Periodo": {
        "Anio": "YYYY",
        "Mes": "MM"
      },
      "FechaEmision": "YYYY-MM-DD",
      "DatosEmpleador": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Empleador"
      },
      "DatosTrabajador": {
        "Rut": "XXXXXXXX-X",
        "NombreCompleto": "Nombre Completo Trabajador",
        "Cargo": "Cargo",
        "SueldoBase": 0
      },
      "HaberesImponibles": [
        {"Concepto": "Sueldo Base", "Monto": 0},
        {"Concepto": "Horas Extra", "Monto": 0}
      ],
      "HaberesNoImponibles": [
        {"Concepto": "Movilización", "Monto": 0},
        {"Concepto": "Colación", "Monto": 0}
      ],
      "TotalHaberes": 0,
      "DescuentosLegales": {
        "AFP": 0,
        "Salud": 0,
        "SeguroCesantia": 0,
        "ImpuestoUnico": 0
      },
      "OtrosDescuentos": [
        {"Concepto": "Anticipo", "Monto": 0}
      ],
      "TotalDescuentos": 0,
      "LiquidoAPagar": 0
    }
  }
}' WHERE nombre = 'Liquidaciones de Sueldo';

-- Planillas de Cotizaciones (Previred)
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "PlanillaCotizaciones": {
      "PeriodoRemuneracion": {
        "Anio": "YYYY",
        "Mes": "MM"
      },
      "FechaPago": "YYYY-MM-DD",
      "DatosEmpleador": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Empleador"
      },
      "TipoPlanilla": "Normal/Complementaria/Retroactiva",
      "TotalTrabajadoresDeclarados": 0,
      "TotalCotizacionesPagadas": 0,
      "DetalleCotizacionesTrabajador": [
        {
          "RutTrabajador": "XXXXXXXX-X",
          "NombreCompleto": "Nombre Completo",
          "MontoImponible": 0,
          "CotizacionAFP": 0,
          "CotizacionSalud": 0,
          "CotizacionSeguroCesantia": 0
        }
      ],
      "IdentificadorPrevired": "ID_PREVIRED_XXXX"
    }
  }
}' WHERE nombre = 'Planillas de Cotizaciones';

-- Certificados AFP
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "CertificadoAFP": {
      "TipoCertificado": "Afiliación/Cotizaciones/Saldo",
      "FechaEmision": "YYYY-MM-DD",
      "DatosTrabajador": {
        "Rut": "XXXXXXXX-X",
        "NombreCompleto": "Nombre Completo Trabajador"
      },
      "DatosAFP": {
        "NombreAFP": "Habitat/Capital/Cuprum/etc.",
        "NumeroAfiliado": "AFILIADO-XXXXX"
      },
      "InformacionEspecifica": {
        "FechaAfiliacion": "YYYY-MM-DD",
        "SaldoCuentaObligatoria": 0,
        "PeriodosCotizados": [
          {"Anio": "YYYY", "Mes": "MM", "MontoCotizado": 0}
        ]
      }
    }
  }
}' WHERE nombre = 'Certificados AFP';

-- Certificados Isapre/Fonasa
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "CertificadoSalud": {
      "TipoCertificado": "Afiliación/Cotizaciones",
      "InstitucionSalud": "Isapre/Fonasa",
      "FechaEmision": "YYYY-MM-DD",
      "DatosTrabajador": {
        "Rut": "XXXXXXXX-X",
        "NombreCompleto": "Nombre Completo Trabajador"
      },
      "DatosInstitucion": {
        "Nombre": "Nombre Isapre/Fonasa",
        "PlanSalud": "Nombre del Plan/Libre Elección",
        "MontoCotizacionMensual": 0
      },
      "InformacionEspecifica": {
        "FechaAfiliacion": "YYYY-MM-DD",
        "CargasDeclaradas": 0,
        "BeneficiariosAdicionales": []
      }
    }
  }
}' WHERE nombre = 'Certificados Isapre/Fonasa';

-- Certificados Laborales
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "CertificadoLaboral": {
      "TipoCertificado": "Antigüedad/Renta/Trabajo General",
      "FechaEmision": "YYYY-MM-DD",
      "DatosEmpleador": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Empleador"
      },
      "DatosTrabajador": {
        "Rut": "XXXXXXXX-X",
        "NombreCompleto": "Nombre Completo Trabajador"
      },
      "Cargo": "Cargo",
      "FechaIngreso": "YYYY-MM-DD",
      "AntiguedadAnios": 0,
      "RentaPromedioMensual": 0,
      "Observaciones": "Texto del certificado, si aplica."
    }
  }
}' WHERE nombre = 'Certificados Laborales';

-- Reglamento Interno
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ReglamentoInterno": {
      "NombreDocumento": "Reglamento Interno de Orden, Higiene y Seguridad",
      "FechaAprobacion": "YYYY-MM-DD",
      "FechaVigencia": "YYYY-MM-DD",
      "Version": "1.0",
      "DatosEmpresa": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Empresa"
      },
      "ClausulasPrincipales": [
        {"Titulo": "Jornada de Trabajo", "Resumen": "Horarios y descansos."},
        {"Titulo": "Faltas y Sanciones", "Resumen": "Tipificación y consecuencias."},
        {"Titulo": "Medidas de Higiene y Seguridad", "Resumen": "Normas de prevención de riesgos."}
      ],
      "ArchivosAdjuntos": ["ruta/al/pdf_reglamento.pdf"]
    }
  }
}' WHERE nombre = 'Reglamento Interno';

-- Contratos Especiales (ej. Part-time, Teletrabajo)
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ContratoEspecial": {
      "TipoContrato": "Part-Time/Teletrabajo/Servicios Transitorios",
      "NumeroContrato": "CE-YYYY-XXXX",
      "FechaInicio": "YYYY-MM-DD",
      "DatosEmpleador": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Empleador"
      },
      "DatosTrabajador": {
        "Rut": "XXXXXXXX-X",
        "NombreCompleto": "Nombre Completo Trabajador"
      },
      "Cargo": "Cargo del Trabajador",
      "JornadaEspecifica": "Descripción de la jornada (ej. 30 horas semanales)",
      "ModalidadTrabajo": "Presencial/Remoto/Híbrido",
      "CondicionesEspeciales": "Cláusulas específicas del tipo de contrato."
    }
  }
}' WHERE nombre = 'Contratos Especiales';

-- Acuerdos COVID-19 (Ley de Protección al Empleo)
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "AcuerdoCOVID19": {
      "TipoAcuerdo": "Suspensión Contrato/Reducción Jornada",
      "NumeroAcuerdo": "AC-COVID-XXXX",
      "FechaAcuerdo": "YYYY-MM-DD",
      "PeriodoVigencia": {
        "FechaInicio": "YYYY-MM-DD",
        "FechaFin": "YYYY-MM-DD"
      },
      "DatosEmpleador": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Empleador"
      },
      "DatosTrabajador": {
        "Rut": "XXXXXXXX-X",
        "NombreCompleto": "Nombre Completo Trabajador"
      },
      "BeneficioAsociado": "Seguro de Cesantía/Subsidio Estatal",
      "PorcentajeReduccionJornada": 0,
      "MontoComplementoEmpresa": 0
    }
  }
}' WHERE nombre = 'Acuerdos COVID-19';

-- Libro de Remuneraciones
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "LibroRemuneraciones": {
      "Periodo": {
        "Anio": "YYYY",
        "Mes": "MM"
      },
      "DatosEmpresa": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Empresa"
      },
      "TotalTrabajadores": 0,
      "TotalRemuneracionesBrutas": 0,
      "TotalDescuentosLegales": 0,
      "TotalLiquidoPagado": 0,
      "DetalleTrabajadores": [
        {
          "RutTrabajador": "XXXXXXXX-X",
          "NombreCompleto": "Nombre Completo",
          "RemuneracionBruta": 0,
          "TotalDescuentos": 0,
          "LiquidoAPagar": 0
        }
      ]
    }
  }
}' WHERE nombre = 'Libro de Remuneraciones';

-- Documentos de Capacitación
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "DocumentoCapacitacion": {
      "TipoDocumento": "Certificado SENCE/Plan de Capacitación",
      "NombreCurso": "Nombre del Curso de Capacitación",
      "InstitucionCapacitadora": "Nombre Institución",
      "FechaInicio": "YYYY-MM-DD",
      "FechaFin": "YYYY-MM-DD",
      "DuracionHoras": 0,
      "Participante": {
        "Rut": "XXXXXXXX-X",
        "NombreCompleto": "Nombre Completo Trabajador"
      },
      "CostoCapacitacion": 0,
      "FinanciamientoSENCE": "Si/No"
    }
  }
}' WHERE nombre = 'Documentos de Capacitación';

-- Certificados de Accidentes (Laborales)
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "CertificadoAccidenteLaboral": {
      "TipoDocumento": "Declaración Individual de Accidente (DIA)/Licencia Médica",
      "NumeroCaso": "ACC-XXXX-YYYY",
      "FechaAccidente": "YYYY-MM-DD",
      "HoraAccidente": "HH:MM",
      "DatosTrabajador": {
        "Rut": "XXXXXXXX-X",
        "NombreCompleto": "Nombre Completo Trabajador"
      },
      "DatosEmpleador": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Empleador"
      },
      "TipoAccidente": "Laboral/De Trayecto/Enfermedad Profesional",
      "LugarAccidente": "Dirección o descripción",
      "DescripcionAccidente": "Breve descripción de cómo ocurrió el accidente.",
      "DiasLicencia": 0,
      "FechaInicioLicencia": "YYYY-MM-DD",
      "Mutualidad": "ACHS/IST/Mutual de Seguridad"
    }
  }
}' WHERE nombre = 'Certificados de Accidentes';

-- Registro de Asistencia
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "RegistroAsistencia": {
      "TipoRegistro": "Libro de Asistencia/Reloj Control/Sistema Biométrico",
      "Periodo": {
        "Anio": "YYYY",
        "Mes": "MM"
      },
      "DatosEmpresa": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Empresa"
      },
      "DatosTrabajador": {
        "Rut": "XXXXXXXX-X",
        "NombreCompleto": "Nombre Completo Trabajador"
      },
      "DetalleDiario": [
        {
          "Fecha": "YYYY-MM-DD",
          "HoraEntrada": "HH:MM",
          "HoraSalida": "HH:MM",
          "HorasTrabajadas": 0,
          "AusenciaTipo": "Permiso/Licencia/Vacaciones",
          "Observaciones": ""
        }
      ]
    }
  }
}' WHERE nombre = 'Registro de Asistencia';

-- Certificados Sindicales
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "CertificadoSindical": {
      "TipoCertificado": "Afiliación/Directorio/Cuotas Sindicales",
      "FechaEmision": "YYYY-MM-DD",
      "DatosSindicato": {
        "Rut": "XXXXXXXX-X",
        "RazonSocial": "Nombre o Razón Social Sindicato",
        "RolUnicoSindical": "RUS-XXXX"
      },
      "DatosTrabajador": {
        "Rut": "XXXXXXXX-X",
        "NombreCompleto": "Nombre Completo Trabajador"
      },
      "FechaAfiliacion": "YYYY-MM-DD",
      "MontoCuotaSindical": 0,
      "PeriodoCuota": "Mensual/Anual"
    }
  }
}' WHERE nombre = 'Certificados Sindicales';

-- Permisos y Vacaciones
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "PermisoVacacion": {
      "TipoDocumento": "Solicitud de Permiso/Solicitud de Vacaciones/Autorización",
      "NumeroSolicitud": "PV-XXXX",
      "FechaSolicitud": "YYYY-MM-DD",
      "DatosTrabajador": {
        "Rut": "XXXXXXXX-X",
        "NombreCompleto": "Nombre Completo Trabajador"
      },
      "PeriodoSolicitado": {
        "FechaInicio": "YYYY-MM-DD",
        "FechaFin": "YYYY-MM-DD",
        "DiasSolicitados": 0
      },
      "EstadoSolicitud": "Pendiente/Aprobada/Rechazada",
      "FechaAprobacionRechazo": "YYYY-MM-DD",
      "ResponsableAutorizacion": "Nombre Superior/RRHH",
      "SaldoDiasVacaciones": 0,
      "Observaciones": "Motivo del permiso, si aplica."
    }
  }
}' WHERE nombre = 'Permisos y Vacaciones';

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
-- 4. DOCUMENTOS LEGALES Y NOTARIALES (Actualización de esquema_json)
-- =============================================================================

-- Escrituras Públicas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "EscrituraPublica": {
      "NumeroRepertorio": "XXXX-YYYY",
      "FechaEscritura": "YYYY-MM-DD",
      "Notaria": {
        "Nombre": "Nombre Notaría",
        "Ciudad": "Santiago",
        "Oficio": "Oficio del Notario"
      },
      "PartesIntervinientes": [
        {
          "TipoParticipacion": "Vendedor/Comprador/Otorgante",
          "NombreCompletoRazonSocial": "Nombre Completo o Razón Social",
          "Rut": "XXXXXXXX-X",
          "RepresentanteLegal": "Nombre Representante"
        }
      ],
      "ObjetoEscritura": "Compraventa/Constitución Sociedad/Hipoteca",
      "ResumenContenido": "Breve descripción del acto jurídico.",
      "MontoInvolucrado": 0,
      "ArchivosAdjuntos": ["ruta/al/pdf_escritura.pdf"]
    }
  }
}' WHERE nombre = 'Escrituras Públicas';

-- Poderes Notariales
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "PoderNotarial": {
      "NumeroRepertorio": "XXXX-YYYY",
      "FechaEmision": "YYYY-MM-DD",
      "Notaria": {
        "Nombre": "Nombre Notaría",
        "Ciudad": "Santiago"
      },
      "Otorgante": {
        "NombreCompletoRazonSocial": "Nombre Completo o Razón Social",
        "Rut": "XXXXXXXX-X"
      },
      "Apoderado": {
        "NombreCompletoRazonSocial": "Nombre Completo Apoderado",
        "Rut": "XXXXXXXX-X"
      },
      "TipoPoder": "General/Especial",
      "FacultadesOtorgadas": ["Administración de bienes", "Venta de propiedades", "Trámites bancarios"],
      "Vigencia": "Indefinida/DesdeYYYY-MM-DD hastaYYYY-MM-DD"
    }
  }
}' WHERE nombre = 'Poderes Notariales';

-- Poderes Judiciales
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "PoderJudicial": {
      "NumeroCausaRol": "RIT XXXXX-YYYY",
      "Tribunal": "Nombre Tribunal",
      "FechaOtorgamiento": "YYYY-MM-DD",
      "Otorgante": {
        "NombreCompletoRazonSocial": "Nombre Completo o Razón Social",
        "Rut": "XXXXXXXX-X"
      },
      "AbogadoApoderado": {
        "NombreCompleto": "Nombre Abogado",
        "Rut": "XXXXXXXX-X",
        "Patrocinio": "Si/No"
      },
      "ObjetoPoder": "Representación en juicio ordinario/ejecutivo",
      "FacultadesEspecificas": ["Cobrar", "Percibir", "Transigir"],
      "ArchivosAdjuntos": ["ruta/al/pdf_poder_judicial.pdf"]
    }
  }
}' WHERE nombre = 'Poderes Judiciales';

-- Contratos Civiles
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ContratoCivil": {
      "TipoContrato": "Compraventa/Permuta/Arrendamiento/Mutuo",
      "FechaContrato": "YYYY-MM-DD",
      "Partes": [
        {
          "Rol": "Parte 1",
          "NombreCompletoRazonSocial": "Nombre o Razón Social Parte 1",
          "Rut": "XXXXXXXX-X"
        },
        {
          "Rol": "Parte 2",
          "NombreCompletoRazonSocial": "Nombre o Razón Social Parte 2",
          "Rut": "XXXXXXXX-X"
        }
      ],
      "ObjetoContrato": "Descripción breve del objeto (ej. Venta de inmueble)",
      "ClausulasRelevantes": ["Precio", "Condiciones de pago", "Plazo"],
      "Monto": 0,
      "Estado": "Vigente/Finalizado/Rescindido"
    }
  }
}' WHERE nombre = 'Contratos Civiles';

-- Testamentos
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Testamento": {
      "FechaOtorgamiento": "YYYY-MM-DD",
      "TipoTestamento": "Abierto/Cerrado",
      "Testador": {
        "NombreCompleto": "Nombre Completo Testador",
        "Rut": "XXXXXXXX-X",
        "EstadoCivil": "Estado Civil"
      },
      "Notaria": {
        "Nombre": "Nombre Notaría",
        "Ciudad": "Santiago"
      },
      "HerederosLegatarios": [
        {"Nombre": "Nombre Heredero/Legatario", "Rut": "XXXXXXXX-X", "Tipo": "Heredero/Legatario", "BienAsignado": "Descripción del bien"}
      ],
      "AlbaceaDesignado": {"Nombre": "Nombre Albacea", "Rut": "XXXXXXXX-X"},
      "Observaciones": "Instrucciones especiales o condiciones."
    }
  }
}' WHERE nombre = 'Testamentos';

-- Demandas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Demanda": {
      "TipoAccionLegal": "Cobro de pesos/Divorcio/Incumplimiento de contrato",
      "FechaPresentacion": "YYYY-MM-DD",
      "Tribunal": "Nombre Tribunal",
      "RolCausa": "RIT XXXXX-YYYY",
      "Demandante": {
        "NombreCompletoRazonSocial": "Nombre o Razón Social Demandante",
        "Rut": "XXXXXXXX-X",
        "Abogado": "Nombre Abogado Demandante"
      },
      "Demandado": {
        "NombreCompletoRazonSocial": "Nombre o Razón Social Demandado",
        "Rut": "XXXXXXXX-X"
      },
      "Materia": "Descripción breve de la materia de la demanda.",
      "EstadoActual": "Presentada/Notificada/En Tramitación",
      "ArchivosAdjuntos": ["ruta/al/pdf_demanda.pdf"]
    }
  }
}' WHERE nombre = 'Demandas';

-- Sentencias
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Sentencia": {
      "TipoSentencia": "Definitiva/Interlocutoria",
      "RolCausa": "RIT XXXXX-YYYY",
      "Tribunal": "Nombre Tribunal",
      "FechaSentencia": "YYYY-MM-DD",
      "PartesCausa": {
        "Demandante": "Nombre o Razón Social Demandante",
        "Demandado": "Nombre o Razón Social Demandado"
      },
      "FalloResumen": "Resumen de la decisión del tribunal (Ej. Acoge demanda, Rechaza demanda)",
      "MontoCondena": 0,
      "EstadoRecursos": "Sin recursos/Apelación pendiente",
      "ArchivosAdjuntos": ["ruta/al/pdf_sentencia.pdf"]
    }
  }
}' WHERE nombre = 'Sentencias';

-- Escritos Judiciales
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "EscritoJudicial": {
      "TipoEscrito": "Contestación/Rebeldía/Medida Precautoria",
      "FechaPresentacion": "YYYY-MM-DD",
      "RolCausa": "RIT XXXXX-YYYY",
      "Tribunal": "Nombre Tribunal",
      "AbogadoPresenta": {
        "NombreCompleto": "Nombre Abogado",
        "Rut": "XXXXXXXX-X"
      },
      "Materia": "Materia del escrito (ej. Presenta prueba, Solicita suspensión)",
      "EstadoEnCausa": "Agregado/Resuelto",
      "ArchivosAdjuntos": ["ruta/al/pdf_escrito.pdf"]
    }
  }
}' WHERE nombre = 'Escritos Judiciales';

-- Recursos Judiciales
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "RecursoJudicial": {
      "TipoRecurso": "Apelación/Casación/Queja",
      "FechaPresentacion": "YYYY-MM-DD",
      "RolCausaOrigen": "RIT XXXXX-YYYY",
      "TribunalOrigen": "Tribunal que dictó la resolución",
      "TribunalConoceRecurso": "Corte de Apelaciones/Corte Suprema",
      "ResolucionImpugnada": "Tipo de resolución (ej. 'Sentencia definitiva')",
      "FundamentosRecurso": "Breve descripción de los fundamentos.",
      "EstadoRecurso": "En tramitación/Resuelto"
    }
  }
}' WHERE nombre = 'Recursos Judiciales';

-- Notificaciones
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "NotificacionLegal": {
      "TipoNotificacion": "Personal/Por Cédula/Estado Diario/Electrónica",
      "FechaNotificacion": "YYYY-MM-DD",
      "RolCausa": "RIT XXXXX-YYYY",
      "TribunalOrigen": "Nombre Tribunal",
      "ParteNotificada": {
        "NombreCompletoRazonSocial": "Nombre o Razón Social Notificado",
        "Rut": "XXXXXXXX-X"
      },
      "DocumentoNotificado": "Tipo y breve descripción del documento notificado (ej. Demanda, Sentencia)",
      "Observaciones": "Datos del receptor, dirección, etc."
    }
  }
}' WHERE nombre = 'Notificaciones';

-- Acuerdos Extrajudiciales
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "AcuerdoExtrajudicial": {
      "TipoAcuerdo": "Transacción/Avenimiento/Mediación",
      "FechaAcuerdo": "YYYY-MM-DD",
      "PartesInvolucradas": [
        {
          "NombreCompletoRazonSocial": "Nombre o Razón Social Parte 1",
          "Rut": "XXXXXXXX-X"
        },
        {
          "NombreCompletoRazonSocial": "Nombre o Razón Social Parte 2",
          "Rut": "XXXXXXXX-X"
        }
      ],
      "ObjetoAcuerdo": "Resolución de conflicto por...",
      "MontoAcordado": 0,
      "CondicionesAcuerdo": "Detalle de los compromisos adquiridos.",
      "EstadoCumplimiento": "Cumplido/Pendiente/Incumplido"
    }
  }
}' WHERE nombre = 'Acuerdos Extrajudiciales';

-- Dictámenes y Consultas (Legales)
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "DictamenConsultaLegal": {
      "TipoDocumento": "Dictamen/Informe en Derecho/Consulta",
      "EntidadEmisora": "Nombre Abogado/Estudio Jurídico/Organismo Público",
      "FechaEmision": "YYYY-MM-DD",
      "Materia": "Materia legal consultada (ej. Interpretación Art. X de Ley Y)",
      "Consultante": {
        "NombreCompletoRazonSocial": "Nombre o Razón Social Consultante",
        "Rut": "XXXXXXXX-X"
      },
      "ResumenConclusion": "Breve resumen de la opinión o conclusión legal.",
      "ArchivosAdjuntos": ["ruta/al/pdf_dictamen.pdf"]
    }
  }
}' WHERE nombre = 'Dictámenes y Consultas';

-- Contratos de Arrendamiento
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ContratoArrendamiento": {
      "FechaContrato": "YYYY-MM-DD",
      "Arrendador": {
        "NombreCompletoRazonSocial": "Nombre o Razón Social Arrendador",
        "Rut": "XXXXXXXX-X"
      },
      "Arrendatario": {
        "NombreCompletoRazonSocial": "Nombre o Razón Social Arrendatario",
        "Rut": "XXXXXXXX-X"
      },
      "TipoBien": "Inmueble/Vehículo/Mueble",
      "DireccionBien": "Dirección del inmueble/Identificación vehículo",
      "MontoArriendoMensual": 0,
      "MontoGarantia": 0,
      "DuracionMeses": 0,
      "FechaInicioArriendo": "YYYY-MM-DD",
      "FechaTerminoArriendo": "YYYY-MM-DD",
      "ClausulasEspeciales": ["Renovación automática", "Responsabilidades por reparaciones"]
    }
  }
}' WHERE nombre = 'Contratos de Arrendamiento';

-- Prendas e Hipotecas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "PrendaHipotecas": {
      "TipoGarantia": "Prenda/Hipoteca",
      "FechaConstitucion": "YYYY-MM-DD",
      "Deudor": {
        "NombreCompletoRazonSocial": "Nombre o Razón Social Deudor",
        "Rut": "XXXXXXXX-X"
      },
      "Acreedor": {
        "NombreCompletoRazonSocial": "Nombre o Razón Social Acreedor",
        "Rut": "XXXXXXXX-X"
      },
      "BienGravado": {
        "TipoBien": "Inmueble/Vehículo/Maquinaria",
        "Identificador": "Rol/Patente/Número Serie",
        "DireccionUbicacion": "Dirección (si aplica)"
      },
      "MontoGarantizado": 0,
      "RegistroConservador": {
        "Conservador": "Conservador de Bienes Raíces/Registro Civil",
        "Foja": "XXXX",
        "Numero": "YYYY",
        "Anio": "ZZZZ"
      },
      "Estado": "Vigente/Alzada"
    }
  }
}' WHERE nombre = 'Prendas e Hipotecas';

-- Propiedad Intelectual
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "PropiedadIntelectual": {
      "TipoDerecho": "Patente/Marca/Derecho de Autor/Modelo de Utilidad",
      "NumeroRegistro": "REG-XXXX-YYYY",
      "FechaSolicitud": "YYYY-MM-DD",
      "FechaConcesion": "YYYY-MM-DD",
      "Titular": {
        "NombreCompletoRazonSocial": "Nombre o Razón Social Titular",
        "Rut": "XXXXXXXX-X"
      },
      "Descripcion": "Descripción del objeto de propiedad intelectual (ej. Patente de invención X, Marca Y)",
      "VigenciaHasta": "YYYY-MM-DD",
      "InstitucionRegistro": "INAPI/Departamento Derechos Intelectuales"
    }
  }
}' WHERE nombre = 'Propiedad Intelectual';

-- Actas de Comparecencia
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ActaComparecencia": {
      "NumeroRepertorio": "XXXX-YYYY",
      "FechaActa": "YYYY-MM-DD",
      "Notaria": {
        "Nombre": "Nombre Notaría",
        "Ciudad": "Santiago"
      },
      "Compareciente": {
        "NombreCompletoRazonSocial": "Nombre Completo o Razón Social Compareciente",
        "Rut": "XXXXXXXX-X"
      },
      "HechoPresenciadoCertificado": "Constancia de firma/Declaración jurada simple/Reunión de directorio",
      "Observaciones": "Breve descripción de lo sucedido o declarado."
    }
  }
}' WHERE nombre = 'Actas de Comparecencia';

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
-- 5. DOCUMENTOS BANCARIOS Y FINANCIEROS (Actualización de esquema_json)
-- =============================================================================

-- Estados de Cuenta / Cartolas Bancarias (Fusionados por similitud)
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "EstadoCartolaBancaria": {
      "TipoDocumento": "Estado de Cuenta/Cartola Bancaria",
      "NumeroCuenta": "XXXX-XXXX-XXXX-XXXX",
      "Banco": "Nombre del Banco",
      "TitularCuenta": {
        "NombreRazonSocial": "Nombre o Razón Social",
        "Rut": "XXXXXXXX-X"
      },
      "Periodo": {
        "FechaInicio": "YYYY-MM-DD",
        "FechaFin": "YYYY-MM-DD"
      },
      "SaldoInicial": 0,
      "SaldoFinal": 0,
      "Moneda": "CLP/USD",
      "Movimientos": [
        {
          "Fecha": "YYYY-MM-DD",
          "Descripcion": "Descripción del movimiento",
          "Referencia": "Nro. Comprobante/Transacción",
          "MontoCargo": 0,
          "MontoAbono": 0,
          "SaldoPostMovimiento": 0
        }
      ],
      "TotalCargosPeriodo": 0,
      "TotalAbonosPeriodo": 0
    }
  }
}' WHERE nombre IN ('Estados de Cuenta', 'Cartolas Bancarias');

-- Comprobantes de Transferencia
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ComprobanteTransferencia": {
      "TipoDocumento": "Comprobante de Transferencia",
      "NumeroOperacion": "TRF-XXXX-YYYY",
      "FechaHora": "YYYY-MM-DD HH:MM:SS",
      "MontoTransferido": 0,
      "Moneda": "CLP/USD",
      "CuentaOrigen": {
        "Banco": "Banco Origen",
        "NumeroCuenta": "XXXXX",
        "Titular": "Nombre Titular Origen",
        "Rut": "XXXXXXXX-X"
      },
      "CuentaDestino": {
        "Banco": "Banco Destino",
        "NumeroCuenta": "YYYYY",
        "Titular": "Nombre Titular Destino",
        "Rut": "XXXXXXXX-X"
      },
      "Concepto": "Glosa de la transferencia"
    }
  }
}' WHERE nombre = 'Comprobantes de Transferencia';

-- Comprobantes de Depósito
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ComprobanteDeposito": {
      "TipoDocumento": "Comprobante de Depósito",
      "NumeroOperacion": "DEP-XXXX-YYYY",
      "FechaHora": "YYYY-MM-DD HH:MM:SS",
      "MontoDepositado": 0,
      "Moneda": "CLP/USD",
      "CuentaDestino": {
        "Banco": "Banco Destino",
        "NumeroCuenta": "XXXXX",
        "Titular": "Nombre Titular Cuenta"
      },
      "TipoDeposito": "Efectivo/Cheque/Vale Vista",
      "Depositante": {
        "Nombre": "Nombre del Depositante (opcional)",
        "Rut": "XXXXXXXX-X (opcional)"
      },
      "SucursalDeposito": "Nombre Sucursal/Cajero"
    }
  }
}' WHERE nombre = 'Comprobantes de Depósito';

-- Comprobantes de Giro
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ComprobanteGiro": {
      "TipoDocumento": "Comprobante de Giro",
      "NumeroOperacion": "GIR-XXXX-YYYY",
      "FechaHora": "YYYY-MM-DD HH:MM:SS",
      "MontoGirado": 0,
      "Moneda": "CLP/USD",
      "CuentaOrigen": {
        "Banco": "Banco Origen",
        "NumeroCuenta": "XXXXX",
        "Titular": "Nombre Titular Cuenta"
      },
      "TipoGiro": "Retiro Cajero/Giro por Caja/Cheque",
      "SucursalGiro": "Nombre Sucursal/Cajero"
    }
  }
}' WHERE nombre = 'Comprobantes de Giro';

-- Pagarés
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Pagare": {
      "NumeroPagare": "PAG-XXXX",
      "FechaEmision": "YYYY-MM-DD",
      "MontoCapital": 0,
      "Moneda": "CLP/UF/USD",
      "Deudor": {
        "NombreRazonSocial": "Nombre o Razón Social Deudor",
        "Rut": "XXXXXXXX-X",
        "Direccion": "Dirección Deudor"
      },
      "Acreedor": {
        "NombreRazonSocial": "Nombre o Razón Social Acreedor",
        "Rut": "XXXXXXXX-X"
      },
      "FechaVencimiento": "YYYY-MM-DD",
      "TasaInteresAnual": 0,
      "Cuotas": 0,
      "MontoCuota": 0,
      "Estado": "Vigente/Pagado/Moroso"
    }
  }
}' WHERE nombre = 'Pagarés';

-- Contratos de Crédito
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ContratoCredito": {
      "NumeroContrato": "CRD-XXXX-YYYY",
      "FechaContrato": "YYYY-MM-DD",
      "InstitucionFinanciera": "Nombre del Banco/Institución",
      "TipoCredito": "Consumo/Hipotecario/Automotriz/Comercial",
      "TitularCredito": {
        "NombreRazonSocial": "Nombre o Razón Social Titular",
        "Rut": "XXXXXXXX-X"
      },
      "MontoCreditoAprobado": 0,
      "Moneda": "CLP/UF/USD",
      "TasaInteresAnual": 0,
      "PlazoMeses": 0,
      "MontoCuotaMensual": 0,
      "FechaPrimerVencimiento": "YYYY-MM-DD",
      "Garantias": ["Prenda/Hipoteca/Aval"],
      "Estado": "Vigente/Pagado/Castigado"
    }
  }
}' WHERE nombre = 'Contratos de Crédito';

-- Contratos de Cuenta
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ContratoCuentaBancaria": {
      "NumeroContrato": "CTA-XXXX-YYYY",
      "FechaApertura": "YYYY-MM-DD",
      "Banco": "Nombre del Banco",
      "TipoCuenta": "Corriente/Ahorro/Vista",
      "TitularCuenta": {
        "NombreRazonSocial": "Nombre o Razón Social Titular",
        "Rut": "XXXXXXXX-X",
        "Direccion": "Dirección Titular"
      },
      "CondicionesEspeciales": "Beneficios/Comisiones/Sobregiro",
      "Estado": "Activa/Cerrada"
    }
  }
}' WHERE nombre = 'Contratos de Cuenta';

-- Tarjetas de Crédito (Estado de Cuenta)
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "TarjetaCredito": {
      "TipoDocumento": "Estado de Cuenta Tarjeta de Crédito",
      "NumeroTarjetaUltimos4Digitos": "XXXX",
      "BancoEmisor": "Nombre del Banco",
      "TitularTarjeta": {
        "NombreCompleto": "Nombre Completo Titular",
        "Rut": "XXXXXXXX-X"
      },
      "PeriodoFacturacion": {
        "FechaInicio": "YYYY-MM-DD",
        "FechaFin": "YYYY-MM-DD"
      },
      "FechaVencimientoPago": "YYYY-MM-DD",
      "SaldoAnterior": 0,
      "AvancesPeriodo": 0,
      "ComprasPeriodo": 0,
      "PagosPeriodo": 0,
      "CargosIntereses": 0,
      "SaldoActual": 0,
      "MontoMinimoPago": 0,
      "CupoNacional": 0,
      "CupoInternacional": 0,
      "MovimientosPeriodo": [
        {
          "Fecha": "YYYY-MM-DD",
          "Comercio": "Nombre del Comercio",
          "Monto": 0,
          "Tipo": "Compra/Avance/Pago"
        }
      ]
    }
  }
}' WHERE nombre = 'Tarjetas de Crédito';

-- Tarjetas de Débito (Documentación relacionada)
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "TarjetaDebito": {
      "TipoDocumento": "Documentación Tarjeta de Débito",
      "NumeroTarjetaUltimos4Digitos": "XXXX",
      "BancoEmisor": "Nombre del Banco",
      "TitularTarjeta": {
        "NombreCompleto": "Nombre Completo Titular",
        "Rut": "XXXXXXXX-X"
      },
      "CuentaAsociada": "Numero de Cuenta Asociada",
      "FechaEmision": "YYYY-MM-DD",
      "FechaVencimiento": "YYYY-MM-DD",
      "Observaciones": "Condiciones de uso, límites."
    }
  }
}' WHERE nombre = 'Tarjetas de Débito';

-- Cheques
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Cheque": {
      "TipoDocumento": "Cheque",
      "NumeroCheque": "XXXXXX",
      "FechaEmision": "YYYY-MM-DD",
      "MontoNumerico": 0,
      "MontoEscrito": "Monto en letras",
      "Girador": {
        "NombreRazonSocial": "Nombre o Razón Social Girador",
        "Rut": "XXXXXXXX-X",
        "NumeroCuenta": "XXXXX"
      },
      "Beneficiario": {
        "NombreRazonSocial": "Nombre o Razón Social Beneficiario",
        "Rut": "XXXXXXXX-X"
      },
      "BancoEmisor": "Nombre del Banco",
      "Estado": "Emitido/Cobrado/Depositado/Protestado"
    }
  }
}' WHERE nombre = 'Cheques';

-- Letras de Cambio
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "LetraCambio": {
      "TipoDocumento": "Letra de Cambio",
      "NumeroLetra": "LC-XXXX",
      "FechaEmision": "YYYY-MM-DD",
      "MontoCapital": 0,
      "Moneda": "CLP/USD",
      "Girador": {
        "NombreRazonSocial": "Nombre o Razón Social Girador",
        "Rut": "XXXXXXXX-X"
      },
      "Girado": {
        "NombreRazonSocial": "Nombre o Razón Social Girado",
        "Rut": "XXXXXXXX-X"
      },
      "Beneficiario": {
        "NombreRazonSocial": "Nombre o Razón Social Beneficiario",
        "Rut": "XXXXXXXX-X"
      },
      "FechaVencimiento": "YYYY-MM-DD",
      "Estado": "Vigente/Pagada/Protestada"
    }
  }
}' WHERE nombre = 'Letras de Cambio';

-- Contratos de Leasing
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ContratoLeasing": {
      "NumeroContrato": "LSG-XXXX-YYYY",
      "FechaContrato": "YYYY-MM-DD",
      "ArrendadorFinanciero": {
        "NombreRazonSocial": "Nombre o Razón Social Entidad Leasing",
        "Rut": "XXXXXXXX-X"
      },
      "Arrendatario": {
        "NombreRazonSocial": "Nombre o Razón Social Arrendatario",
        "Rut": "XXXXXXXX-X"
      },
      "BienObjetoLeasing": {
        "TipoBien": "Vehículo/Maquinaria/Inmueble",
        "Identificador": "Patente/Número Serie/Rol",
        "ValorAdquisicion": 0
      },
      "MontoCuotaMensual": 0,
      "PlazoMeses": 0,
      "ValorOpcionCompra": 0,
      "FechaTerminoContrato": "YYYY-MM-DD",
      "Estado": "Vigente/Finalizado/Incumplido"
    }
  }
}' WHERE nombre = 'Contratos de Leasing';

-- Contratos de Factoring
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ContratoFactoring": {
      "NumeroContrato": "FCT-XXXX-YYYY",
      "FechaContrato": "YYYY-MM-DD",
      "EmpresaFactoring": {
        "NombreRazonSocial": "Nombre o Razón Social Empresa Factoring",
        "Rut": "XXXXXXXX-X"
      },
      "ClienteFactoring": {
        "NombreRazonSocial": "Nombre o Razón Social Cliente",
        "Rut": "XXXXXXXX-X"
      },
      "TipoFactoring": "Con/Sin recurso",
      "MontoLineaCredito": 0,
      "ComisionFactoring": 0,
      "AnticipoPromedio": 0,
      "DocumentosCedidos": [
        {"TipoDocumento": "Factura Electrónica", "Folio": "FXXXX", "Monto": 0, "FechaVencimiento": "YYYY-MM-DD"}
      ]
    }
  }
}' WHERE nombre = 'Contratos de Factoring';

-- Boletas de Garantía
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "BoletaGarantia": {
      "TipoDocumento": "Boleta de Garantía",
      "NumeroBoleta": "BG-XXXX-YYYY",
      "FechaEmision": "YYYY-MM-DD",
      "BancoEmisor": "Nombre del Banco Emisor",
      "MontoGarantizado": 0,
      "Moneda": "CLP/USD",
      "Tomador": {
        "NombreRazonSocial": "Nombre o Razón Social Tomador",
        "Rut": "XXXXXXXX-X"
      },
      "Beneficiario": {
        "NombreRazonSocial": "Nombre o Razón Social Beneficiario",
        "Rut": "XXXXXXXX-X"
      },
      "ObjetoGarantia": "Cumplimiento de contrato/Seriedad de la oferta",
      "FechaVencimiento": "YYYY-MM-DD",
      "Estado": "Vigente/Liberada/Cobrada"
    }
  }
}' WHERE nombre = 'Boletas de Garantía';

-- Mandatos Bancarios
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "MandatoBancario": {
      "TipoMandato": "Pago Automático/Administración de Cuenta",
      "FechaEmision": "YYYY-MM-DD",
      "Mandante": {
        "NombreRazonSocial": "Nombre o Razón Social Mandante",
        "Rut": "XXXXXXXX-X"
      },
      "Mandatario": {
        "NombreRazonSocial": "Nombre o Razón Social Mandatario (ej. Banco)",
        "Rut": "XXXXXXXX-X"
      },
      "NumeroCuentaAsociada": "XXXXX",
      "FacultadesOtorgadas": ["Pagar servicios", "Invertir", "Transferir"],
      "MontoMaximoAutorizado": 0,
      "Vigencia": "Indefinida/Hasta YYYY-MM-DD"
    }
  }
}' WHERE nombre = 'Mandatos Bancarios';

-- Inversiones (Depósitos a Plazo y Fondos Mutuos)
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Inversion": {
      "TipoInversion": "Depósito a Plazo/Fondo Mutuo/Acciones",
      "NumeroOperacion": "INV-XXXX-YYYY",
      "FechaConstitucion": "YYYY-MM-DD",
      "InstitucionFinanciera": "Nombre del Banco/Corredora",
      "TitularInversion": {
        "NombreRazonSocial": "Nombre o Razón Social Titular",
        "Rut": "XXXXXXXX-X"
      },
      "MontoInvertido": 0,
      "Moneda": "CLP/USD",
      "InformacionEspecifica": {
        "PlazoDias": 0,
        "TasaInteresAnual": 0,
        "FechaVencimiento": "YYYY-MM-DD",
        "RentabilidadAcumulada": 0,
        "ValorCuota": 0,
        "NumeroCuotas": 0
      },
      "Estado": "Activa/Rescatada/Vencida"
    }
  }
}' WHERE nombre = 'Inversiones';

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
-- 6. DOCUMENTOS INMOBILIARIOS Y BIENES RAÍCES (Actualización de esquema_json)
-- =============================================================================

-- Escrituras de Compraventa
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "EscrituraCompraventa": {
      "TipoDocumento": "Escritura de Compraventa",
      "NumeroRepertorio": "XXXX-YYYY",
      "FechaEscritura": "YYYY-MM-DD",
      "Notaria": {
        "Nombre": "Nombre Notaría",
        "Comuna": "Comuna Notaría"
      },
      "Vendedor": {
        "NombreRazonSocial": "Nombre o Razón Social Vendedor",
        "Rut": "XXXXXXXX-X"
      },
      "Comprador": {
        "NombreRazonSocial": "Nombre o Razón Social Comprador",
        "Rut": "XXXXXXXX-X"
      },
      "Propiedad": {
        "TipoInmueble": "Casa/Departamento/Terreno/Oficina",
        "Direccion": "Calle #Numero, Comuna, Ciudad",
        "RolAvaluo": "XXX-YY",
        "MetrosCuadradosConstruidos": 0,
        "MetrosCuadradosTerreno": 0
      },
      "PrecioVenta": 0,
      "Moneda": "CLP/UF/USD",
      "InscripcionCBR": {
        "Foja": "XXXX",
        "Numero": "YYYY",
        "Año": "ZZZZ",
        "Conservador": "Nombre Conservador de Bienes Raíces"
      },
      "ArchivosAdjuntos": ["ruta/al/pdf_escritura.pdf"]
    }
  }
}' WHERE nombre = 'Escrituras de Compraventa';

-- Contratos de Arriendo
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ContratoArriendo": {
      "TipoDocumento": "Contrato de Arrendamiento",
      "NumeroContrato": "ARRI-XXXX-YYYY",
      "FechaContrato": "YYYY-MM-DD",
      "Arrendador": {
        "NombreRazonSocial": "Nombre o Razón Social Arrendador",
        "Rut": "XXXXXXXX-X"
      },
      "Arrendatario": {
        "NombreRazonSocial": "Nombre o Razón Social Arrendatario",
        "Rut": "XXXXXXXX-X"
      },
      "PropiedadArrendada": {
        "TipoInmueble": "Casa/Departamento/Oficina",
        "Direccion": "Calle #Numero, Comuna, Ciudad",
        "RolAvaluo": "XXX-YY"
      },
      "MontoArriendoMensual": 0,
      "Moneda": "CLP/UF",
      "MontoGarantia": 0,
      "DuracionMeses": 12,
      "FechaInicioArriendo": "YYYY-MM-DD",
      "FechaTerminoArriendo": "YYYY-MM-DD",
      "CondicionesEspeciales": "Renovación automática, Mantención"
    }
  }
}' WHERE nombre = 'Contratos de Arriendo';

-- Certificados de Dominio
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "CertificadoDominio": {
      "TipoDocumento": "Certificado de Dominio Vigente",
      "NumeroCertificado": "CBR-DOM-XXXX",
      "FechaEmision": "YYYY-MM-DD",
      "Conservador": {
        "Nombre": "Nombre Conservador de Bienes Raíces",
        "Comuna": "Comuna Conservador"
      },
      "Propiedad": {
        "Direccion": "Calle #Numero, Comuna, Ciudad",
        "RolAvaluo": "XXX-YY"
      },
      "InscripcionOriginal": {
        "Foja": "XXXX",
        "Numero": "YYYY",
        "Año": "ZZZZ"
      },
      "ActualPropietario": {
        "NombreRazonSocial": "Nombre o Razón Social Propietario",
        "Rut": "XXXXXXXX-X"
      },
      "EstadoGravamenes": "Sin gravámenes/Con gravámenes (ver Certificado Hipotecas)"
    }
  }
}' WHERE nombre = 'Certificados de Dominio';

-- Certificados de Hipotecas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "CertificadoHipotecas": {
      "TipoDocumento": "Certificado de Hipotecas y Gravámenes",
      "NumeroCertificado": "CBR-HIP-XXXX",
      "FechaEmision": "YYYY-MM-DD",
      "Conservador": {
        "Nombre": "Nombre Conservador de Bienes Raíces",
        "Comuna": "Comuna Conservador"
      },
      "Propiedad": {
        "Direccion": "Calle #Numero, Comuna, Ciudad",
        "RolAvaluo": "XXX-YY"
      },
      "Gravamenes": [
        {
          "TipoGravamen": "Hipoteca/Servidumbre/Prohibición",
          "Beneficiario": "Nombre o Razón Social Beneficiario",
          "MontoAsociado": 0,
          "FechaInscripcion": "YYYY-MM-DD",
          "Foja": "XXXX",
          "Numero": "YYYY",
          "Año": "ZZZZ"
        }
      ],
      "EstadoPropiedad": "Libre de gravámenes/Con gravámenes indicados"
    }
  }
}' WHERE nombre = 'Certificados de Hipotecas';

-- Certificados de Avalúo Fiscal
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "CertificadoAvaluoFiscal": {
      "TipoDocumento": "Certificado de Avalúo Fiscal",
      "NumeroCertificado": "SII-AVAL-XXXX",
      "FechaEmision": "YYYY-MM-DD",
      "Emisor": "Servicio de Impuestos Internos (SII)",
      "Propiedad": {
        "Direccion": "Calle #Numero, Comuna, Ciudad",
        "RolAvaluo": "XXX-YY"
      },
      "AvaluoFiscalVigente": 0,
      "AvaluoFiscalTerreno": 0,
      "AvaluoFiscalConstrucciones": 0,
      "FechaVigenciaAvaluo": "YYYY-MM-DD"
    }
  }
}' WHERE nombre = 'Certificados de Avalúo Fiscal';

-- Tasaciones Comerciales
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "TasacionComercial": {
      "TipoDocumento": "Informe de Tasación Comercial",
      "NumeroInforme": "TAS-XXXX-YYYY",
      "FechaTasacion": "YYYY-MM-DD",
      "Tasador": {
        "Nombre": "Nombre del Tasador",
        "Rut": "XXXXXXXX-X",
        "EmpresaTasadora": "Nombre Empresa Tasadora"
      },
      "PropiedadTasada": {
        "Direccion": "Calle #Numero, Comuna, Ciudad",
        "RolAvaluo": "XXX-YY",
        "SuperficieTerrenoM2": 0,
        "SuperficieConstruidaM2": 0
      },
      "ValorTasacionComercial": 0,
      "Moneda": "UF/CLP",
      "Observaciones": "Factores considerados: ubicación, estado, accesibilidad."
    }
  }
}' WHERE nombre = 'Tasaciones Comerciales';

-- Planos de Propiedad
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "PlanoPropiedad": {
      "TipoDocumento": "Plano Arquitectónico/Loteo/Ubicación",
      "NombrePlano": "Nombre del Plano (ej. Planta Primer Piso)",
      "FechaEmision": "YYYY-MM-DD",
      "ArquitectoResponsable": "Nombre Arquitecto",
      "NumeroRegistroColegio": "XXXXX",
      "PropiedadAsociada": {
        "Direccion": "Calle #Numero, Comuna, Ciudad",
        "RolAvaluo": "XXX-YY"
      },
      "Escala": "1:50/1:100",
      "DetalleContenido": "Distribución, cotas, instalaciones",
      "ArchivosAdjuntos": ["ruta/al/pdf_plano.pdf", "ruta/al/dwg_plano.dwg"]
    }
  }
}' WHERE nombre = 'Planos de Propiedad';

-- Permisos de Edificación
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "PermisoEdificacion": {
      "TipoDocumento": "Permiso de Edificación",
      "NumeroExpedienteDOM": "PED-XXXX-YYYY",
      "FechaEmision": "YYYY-MM-DD",
      "Municipalidad": {
        "Nombre": "Municipalidad de Comuna",
        "DireccionObras": "Dirección D.O.M."
      },
      "PropietarioProyecto": {
        "NombreRazonSocial": "Nombre o Razón Social Propietario",
        "Rut": "XXXXXXXX-X"
      },
      "DireccionObra": "Calle #Numero, Comuna, Ciudad",
      "TipoObra": "Obra Nueva/Ampliación/Modificación",
      "SuperficieAutorizadaM2": 0,
      "VigenciaHasta": "YYYY-MM-DD",
      "Estado": "Vigente/Caducado/Obra Iniciada"
    }
  }
}' WHERE nombre = 'Permisos de Edificación';

-- Recepciones Finales
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "RecepcionFinal": {
      "TipoDocumento": "Certificado de Recepción Final",
      "NumeroCertificadoDOM": "REF-XXXX-YYYY",
      "FechaEmision": "YYYY-MM-DD",
      "Municipalidad": {
        "Nombre": "Municipalidad de Comuna"
      },
      "PropietarioObra": {
        "NombreRazonSocial": "Nombre o Razón Social Propietario",
        "Rut": "XXXXXXXX-X"
      },
      "DireccionObra": "Calle #Numero, Comuna, Ciudad",
      "PermisoEdificacionAsociado": "PED-XXXX-YYYY",
      "SuperficieRecepcionadaM2": 0,
      "Observaciones": "La obra cumple con normativa."
    }
  }
}' WHERE nombre = 'Recepciones Finales';

-- Certificados de Informaciones Previas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "CertificadoInformacionesPrevias": {
      "TipoDocumento": "Certificado de Informaciones Previas (CIP)",
      "NumeroCertificadoDOM": "CIP-XXXX-YYYY",
      "FechaEmision": "YYYY-MM-DD",
      "Municipalidad": {
        "Nombre": "Municipalidad de Comuna"
      },
      "DireccionPropiedad": "Calle #Numero, Comuna, Ciudad",
      "RolAvaluo": "XXX-YY",
      "ZonaUsoSuelo": "Zona Residencial/Comercial",
      "CoeficienteConstructibilidad": 0,
      "CoeficienteOcupacionSuelo": 0,
      "AlturaMaximaEdificacion": "Metros/Pisos",
      "Afectaciones": ["Expropiación", "Utilidad Pública (si aplica)"]
    }
  }
}' WHERE nombre = 'Certificados de Informaciones Previas';

-- Reglamentos de Copropiedad
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ReglamentoCopropiedad": {
      "TipoDocumento": "Reglamento de Copropiedad",
      "FechaAprobacion": "YYYY-MM-DD",
      "NombreComunidad": "Nombre Edificio/Condominio",
      "DireccionComunidad": "Calle #Numero, Comuna, Ciudad",
      "NumeroInscripcionCBRS": "XXXX-YYYY (Registro de Copropiedad)",
      "NormasPrincipales": [
        {"Titulo": "Uso de Bienes Comunes", "Resumen": "Reglas de uso de piscina, quinchos."},
        {"Titulo": "Gastos Comunes", "Resumen": "Forma de cálculo y cobro."},
        {"Titulo": "Mascotas", "Resumen": "Permiso o prohibición de mascotas."}
      ],
      "AdministradorActual": {
        "NombreRazonSocial": "Nombre o Razón Social Administrador",
        "Rut": "XXXXXXXX-X"
      },
      "ArchivosAdjuntos": ["ruta/al/pdf_reglamento_copropiedad.pdf"]
    }
  }
}' WHERE nombre = 'Reglamentos de Copropiedad';

-- Actas de Asamblea
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ActaAsamblea": {
      "TipoAsamblea": "Ordinaria/Extraordinaria",
      "FechaAsamblea": "YYYY-MM-DD",
      "HoraInicio": "HH:MM",
      "NombreComunidad": "Nombre Edificio/Condominio",
      "NumeroSesion": "XXXX",
      "QuorumPresente": "Número de asistentes/Porcentaje",
      "TemasTratados": ["Aprobación de gastos comunes", "Elección de comité"],
      "AcuerdosTomados": [
        {"Tema": "Remodelación Fachada", "Acuerdo": "Aprobada remodelación con presupuesto X."}
      ],
      "ProximaAsambleaFecha": "YYYY-MM-DD",
      "ArchivosAdjuntos": ["ruta/al/pdf_acta.pdf"]
    }
  }
}' WHERE nombre = 'Actas de Asamblea';

-- Promesas de Compraventa
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "PromesaCompraventa": {
      "TipoDocumento": "Promesa de Compraventa",
      "FechaPromesa": "YYYY-MM-DD",
      "PromitenteVendedor": {
        "NombreRazonSocial": "Nombre o Razón Social Promitente Vendedor",
        "Rut": "XXXXXXXX-X"
      },
      "PromitenteComprador": {
        "NombreRazonSocial": "Nombre o Razón Social Promitente Comprador",
        "Rut": "XXXXXXXX-X"
      },
      "PropiedadObjeto": {
        "Direccion": "Calle #Numero, Comuna, Ciudad",
        "RolAvaluo": "XXX-YY"
      },
      "PrecioAcordado": 0,
      "Moneda": "CLP/UF",
      "MontoPie": 0,
      "FechaMaximaEscrituracion": "YYYY-MM-DD",
      "CondicionesResolutorias": "Obtención de crédito, Estudio de títulos conforme."
    }
  }
}' WHERE nombre = 'Promesas de Compraventa';

-- Estudios de Título
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "EstudioTitulo": {
      "TipoDocumento": "Informe de Estudio de Títulos",
      "FechaInforme": "YYYY-MM-DD",
      "AbogadoResponsable": {
        "NombreCompleto": "Nombre Abogado",
        "Rut": "XXXXXXXX-X"
      },
      "PropiedadEstudiada": {
        "Direccion": "Calle #Numero, Comuna, Ciudad",
        "RolAvaluo": "XXX-YY"
      },
      "PeriodoEstudiadoAnios": 10,
      "Conclusiones": "Títulos conforme/Con observaciones/Con reparos",
      "Observaciones": "Detalle de los hallazgos (ej. Existencia de servidumbre).",
      "ArchivosAdjuntos": ["ruta/al/pdf_estudio_titulos.pdf"]
    }
  }
}' WHERE nombre = 'Estudios de Título';

-- Contratos de Corretaje
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "ContratoCorretaje": {
      "TipoDocumento": "Contrato de Corretaje de Propiedades",
      "NumeroContrato": "CORR-XXXX-YYYY",
      "FechaContrato": "YYYY-MM-DD",
      "Propietario": {
        "NombreRazonSocial": "Nombre o Razón Social Propietario",
        "Rut": "XXXXXXXX-X"
      },
      "CorredorPropiedades": {
        "NombreRazonSocial": "Nombre o Razón Social Corredor",
        "Rut": "XXXXXXXX-X",
        "NumeroRegistroACOP": "XXXXX"
      },
      "PropiedadEncargada": {
        "Direccion": "Calle #Numero, Comuna, Ciudad",
        "RolAvaluo": "XXX-YY",
        "TipoOperacion": "Venta/Arriendo"
      },
      "ComisionCorretajePorcentaje": 0,
      "PlazoContratoMeses": 6,
      "Exclusividad": "Si/No"
    }
  }
}' WHERE nombre = 'Contratos de Corretaje';

-- Certificados DOM (Dirección de Obras Municipales) - General
-- Nota: Ya existen Permisos de Edificación, Recepciones Finales y CIPs que son Certificados DOM específicos.
-- Este esquema sería para certificados DOM más generales o solicitudes.
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "CertificadoDOM": {
      "TipoDocumento": "Certificado DOM (General)",
      "NumeroSolicitud": "DOM-SOL-XXXX-YYYY",
      "FechaEmision": "YYYY-MM-DD",
      "Municipalidad": {
        "Nombre": "Municipalidad de Comuna"
      },
      "Solicitante": {
        "NombreRazonSocial": "Nombre o Razón Social Solicitante",
        "Rut": "XXXXXXXX-X"
      },
      "PropiedadAsociada": {
        "Direccion": "Calle #Numero, Comuna, Ciudad",
        "RolAvaluo": "XXX-YY"
      },
      "MateriaSolicitud": "Factibilidad de Construcción/Línea Oficial/Número",
      "Respuesta": "Descripción de la respuesta o información entregada."
    }
  }
}' WHERE nombre = 'Certificados DOM';

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
-- Script para actualizar esquema_json en webapp_modulo con formato legible
-- =============================================================================

-- Cédula de Identidad
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Cédula de Identidad",
    "Datos_Personales": {
      "Nombres": "",
      "Apellidos": "",
      "Numero_Documento": "",
      "Fecha_Nacimiento": "",
      "Nacionalidad": "",
      "Sexo": "",
      "Estado_Civil": ""
    },
    "Datos_Emision": {
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Lugar_Emision": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Cédula de Identidad';

-- Pasaporte
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Pasaporte",
    "Datos_Personales": {
      "Nombres": "",
      "Apellidos": "",
      "Numero_Pasaporte": "",
      "Fecha_Nacimiento": "",
      "Nacionalidad": "",
      "Sexo": "",
      "Lugar_Nacimiento": ""
    },
    "Datos_Emision": {
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Autoridad_Emisora": "",
      "Lugar_Emision": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Pasaporte';

-- Certificado de Nacimiento
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Nacimiento",
    "Datos_Persona_Nacida": {
      "Nombres": "",
      "Apellidos": "",
      "Fecha_Nacimiento": "",
      "Lugar_Nacimiento": "",
      "Sexo": ""
    },
    "Datos_Padres": {
      "Nombre_Madre": "",
      "Nombre_Padre": ""
    },
    "Datos_Registro": {
      "Fecha_Registro": "",
      "Numero_Inscripcion": "",
      "Oficina_Registro": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificado de Nacimiento';

-- Certificado de Matrimonio
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Matrimonio",
    "Datos_Conyuges": {
      "Nombre_Conyuge_1": "",
      "Numero_Documento_Conyuge_1": "",
      "Nombre_Conyuge_2": "",
      "Numero_Documento_Conyuge_2": ""
    },
    "Datos_Matrimonio": {
      "Fecha_Matrimonio": "",
      "Lugar_Matrimonio": "",
      "Regimen_Matrimonial": ""
    },
    "Datos_Registro": {
      "Fecha_Registro": "",
      "Numero_Inscripcion": "",
      "Oficina_Registro": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificado de Matrimonio';

-- Certificado de Defunción
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Defunción",
    "Datos_Persona_Fallecida": {
      "Nombres": "",
      "Apellidos": "",
      "Numero_Documento": "",
      "Fecha_Nacimiento": "",
      "Fecha_Defuncion": "",
      "Lugar_Defuncion": "",
      "Causa_Defuncion": ""
    },
    "Datos_Registro": {
      "Fecha_Registro": "",
      "Numero_Inscripcion": "",
      "Oficina_Registro": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificado de Defunción';

-- Licencia de Conducir
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Licencia de Conducir",
    "Datos_Conductor": {
      "Nombres": "",
      "Apellidos": "",
      "Numero_Licencia": "",
      "Fecha_Nacimiento": "",
      "Tipo_Licencia": "",
      "Restricciones": ""
    },
    "Datos_Emision": {
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Autoridad_Emisora": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Licencia de Conducir';

-- Certificado de Antecedentes
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Antecedentes",
    "Datos_Persona": {
      "Nombres": "",
      "Apellidos": "",
      "Numero_Documento": "",
      "Fecha_Nacimiento": ""
    },
    "Detalle_Antecedentes": {
      "Tiene_Antecedentes": "",
      "Detalle_Sentencias": [],
      "Fecha_Emision_Certificado": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificado de Antecedentes';

-- Certificado de Residencia
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Residencia",
    "Datos_Persona": {
      "Nombres": "",
      "Apellidos": "",
      "Numero_Documento": ""
    },
    "Datos_Residencia": {
      "Direccion_Completa": "",
      "Comuna": "",
      "Region": "",
      "Fecha_Inicio_Residencia": "",
      "Tiempo_Residencia": ""
    },
    "Datos_Emision": {
      "Fecha_Emision": "",
      "Autoridad_Emisora": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificado de Residencia';

-- Certificado de Situación Militar
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Situación Militar",
    "Datos_Persona": {
      "Nombres": "",
      "Apellidos": "",
      "Numero_Documento": "",
      "Fecha_Nacimiento": ""
    },
    "Detalle_Situacion_Militar": {
      "Estado_Militar": "",
      "Clase_Militar": "",
      "Fecha_Acreditacion": ""
    },
    "Datos_Emision": {
      "Fecha_Emision": "",
      "Autoridad_Emisora": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificado de Situación Militar';

-- Credencial Electoral
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Credencial Electoral",
    "Datos_Elector": {
      "Nombres": "",
      "Apellidos": "",
      "Numero_Documento": "",
      "Fecha_Nacimiento": "",
      "Circunscripcion_Electoral": "",
      "Mesa_Electoral": ""
    },
    "Datos_Emision": {
      "Fecha_Emision": "",
      "Fecha_Vencimiento": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Credencial Electoral';

-- Certificado de Viajes
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Viajes",
    "Datos_Persona": {
      "Nombres": "",
      "Apellidos": "",
      "Numero_Pasaporte": ""
    },
    "Detalle_Viajes": [
      {
        "Fecha_Entrada": "",
        "Fecha_Salida": "",
        "Pais_Origen": "",
        "Pais_Destino": "",
        "Motivo_Viaje": ""
      }
    ],
    "Datos_Emision": {
      "Fecha_Emision": "",
      "Autoridad_Emisora": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificado de Viajes';

-- Posesiones Efectivas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Posesiones Efectivas",
    "Datos_Causante": {
      "Nombres": "",
      "Apellidos": "",
      "Numero_Documento": "",
      "Fecha_Defuncion": ""
    },
    "Herederos_Legales": [
      {
        "Nombres": "",
        "Apellidos": "",
        "Numero_Documento": "",
        "Parentesco": "",
        "Porcentaje_Herencia": ""
      }
    ],
    "Bienes_Asociados": [
      {
        "Tipo_Bien": "",
        "Descripcion": "",
        "Valor_Estimado": ""
      }
    ],
    "Datos_Registro": {
      "Numero_Inscripcion": "",
      "Fecha_Inscripcion": "",
      "Oficina_Registro": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Posesiones Efectivas';

-- Certificado de Discapacidad
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Discapacidad",
    "Datos_Persona": {
      "Nombres": "",
      "Apellidos": "",
      "Numero_Documento": "",
      "Fecha_Nacimiento": ""
    },
    "Detalle_Discapacidad": {
      "Tipo_Discapacidad": "",
      "Grado_Discapacidad": "",
      "Fecha_Calificacion": "",
      "Vigencia_Certificado": ""
    },
    "Datos_Emision": {
      "Fecha_Emision": "",
      "Autoridad_Emisora": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificado de Discapacidad';

-- Credenciales de Salud
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Credenciales de Salud",
    "Datos_Beneficiario": {
      "Nombres": "",
      "Apellidos": "",
      "Numero_Documento": "",
      "Fecha_Nacimiento": ""
    },
    "Detalle_Credencial": {
      "Numero_Credencial": "",
      "Institucion_Salud": "",
      "Tipo_Cobertura": "",
      "Fecha_Vencimiento": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Credenciales de Salud';

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
-- Script para actualizar esquema_json en webapp_modulo - Documentos Educativos
-- =============================================================================

-- Certificados de Estudio
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Estudio",
    "Datos_Estudiante": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": "",
      "Fecha_Nacimiento": ""
    },
    "Datos_Estudio": {
      "Nivel_Educativo": "Ej: Enseñanza Básica/Media/Superior",
      "Nombre_Curso_Carrera": "",
      "Institucion_Educativa": "",
      "Periodo_Academico": "Ej: 2020-2021",
      "Estado_Academico": "Ej: Aprobado/Cursando"
    },
    "Datos_Emision": {
      "Fecha_Emision": "",
      "Autoridad_Emisora": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificados de Estudio';

-- Títulos Profesionales
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Título Profesional",
    "Datos_Profesional": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": "",
      "Fecha_Nacimiento": ""
    },
    "Datos_Titulo": {
      "Nombre_Titulo": "",
      "Institucion_Educativa": "",
      "Fecha_Titulacion": "",
      "Numero_Registro": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Títulos Profesionales';

-- Concentraciones de Notas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Concentración de Notas",
    "Datos_Estudiante": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": "",
      "Fecha_Nacimiento": ""
    },
    "Datos_Academicos": {
      "Institucion_Educativa": "",
      "Carrera_Programa": "",
      "Periodo_Academico": "Ej: 2020-2021 / Semestre Primavera 2021",
      "Promedio_General": "",
      "Asignaturas": [
        {
          "Nombre_Asignatura": "",
          "Codigo_Asignatura": "",
          "Calificacion": "",
          "Creditos": ""
        }
      ]
    },
    "Datos_Emision": {
      "Fecha_Emision": "",
      "Autoridad_Emisora": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Concentraciones de Notas';

-- Licencia de Enseñanza Media
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Licencia de Enseñanza Media",
    "Datos_Estudiante": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": "",
      "Fecha_Nacimiento": ""
    },
    "Datos_Educacion_Media": {
      "Establecimiento_Educacional": "",
      "Año_Egreso": "",
      "Modalidad_Educativa": "Ej: Científico-Humanista/Técnico-Profesional"
    },
    "Datos_Emision": {
      "Fecha_Emision": "",
      "Autoridad_Emisora": "Ej: Ministerio de Educación"
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Licencia de Enseñanza Media';

-- Diplomas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Diploma",
    "Datos_Beneficiario": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": ""
    },
    "Datos_Diploma": {
      "Nombre_Programa": "Ej: Postgrado en Gestión de Proyectos",
      "Institucion_Educativa": "",
      "Fecha_Obtencion": "",
      "Duracion_Programa": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Diplomas';

-- Matrículas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Matrícula",
    "Datos_Estudiante": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": ""
    },
    "Datos_Matricula": {
      "Institucion_Educativa": "",
      "Carrera_Programa": "",
      "Periodo_Academico": "Ej: Semestre Primavera 2025",
      "Estado_Matricula": "Ej: Vigente/Inactiva",
      "Arancel_Matricula": {
        "Monto": "",
        "Moneda": ""
      }
    },
    "Datos_Emision": {
      "Fecha_Emision": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Matrículas';

-- Certificados de Ranking
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Ranking",
    "Datos_Estudiante": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": ""
    },
    "Datos_Ranking": {
      "Institucion_Educativa": "",
      "Carrera_Programa": "",
      "Generacion_Egreso": "Ej: 2025",
      "Posicion_Ranking": "Ej: 5 de 100",
      "Porcentaje_Superior": "Ej: 5%"
    },
    "Datos_Emision": {
      "Fecha_Emision": "",
      "Autoridad_Emisora": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificados de Ranking';

-- Certificados PSU/PTU
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado PSU/PTU",
    "Datos_Estudiante": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": ""
    },
    "Resultados_Pruebas": {
      "Año_Rendicion": "",
      "Puntaje_Lenguaje": "",
      "Puntaje_Matematicas": "",
      "Puntaje_Historia": "",
      "Puntaje_Ciencias": "",
      "Puntaje_Promedio": ""
    },
    "Datos_Emision": {
      "Fecha_Emision": "",
      "Autoridad_Emisora": "Ej: DEMRE"
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificados PSU/PTU';

-- Convalidaciones
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Convalidación",
    "Datos_Estudiante": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": ""
    },
    "Detalle_Convalidacion": {
      "Institucion_Origen": "",
      "Institucion_Destino": "",
      "Asignaturas_Convalidadas": [
        {
          "Nombre_Asignatura_Origen": "",
          "Nombre_Asignatura_Convalidada": "",
          "Calificacion_Origen": "",
          "Creditos_Convalidados": ""
        }
      ],
      "Fecha_Convalidacion": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Convalidaciones';

-- Becas y Créditos
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Beca o Crédito",
    "Datos_Estudiante": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": ""
    },
    "Detalle_Beneficio": {
      "Nombre_Beca_Credito": "",
      "Tipo_Beneficio": "Ej: Beca/Crédito",
      "Monto_Asignado": "",
      "Moneda": "",
      "Periodo_Vigencia": "Ej: 2025-2026",
      "Institucion_Otorgante": ""
    },
    "Datos_Emision": {
      "Fecha_Emision": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Becas y Créditos';

-- Certificados SENCE
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado SENCE",
    "Datos_Participante": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": ""
    },
    "Datos_Capacitacion": {
      "Nombre_Curso_Programa": "",
      "Codigo_SENCE": "",
      "Organismo_Ejecutor": "",
      "Fecha_Inicio": "",
      "Fecha_Termino": "",
      "Horas_Duracion": ""
    },
    "Datos_Emision": {
      "Fecha_Emision": "",
      "Autoridad_Emisora": "SENCE"
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificados SENCE';

-- Certificados de Idiomas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Idiomas",
    "Datos_Persona": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": ""
    },
    "Detalle_Certificacion": {
      "Idioma_Certificado": "",
      "Nivel_Alcanzado": "Ej: B2/C1/C2 (Marco Común Europeo)",
      "Tipo_Examen": "Ej: TOEFL/IELTS/DELE",
      "Puntaje_Obtenido": "",
      "Fecha_Examen": "",
      "Centro_Examinador": ""
    },
    "Datos_Emision": {
      "Fecha_Emision": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificados de Idiomas';

-- Reconocimiento de Títulos
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Reconocimiento de Títulos",
    "Datos_Persona": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": ""
    },
    "Detalle_Reconocimiento": {
      "Pais_Origen_Titulo": "",
      "Institucion_Origen": "",
      "Nombre_Titulo_Origen": "",
      "Pais_Reconocimiento": "",
      "Institucion_Reconocimiento": "",
      "Nombre_Titulo_Reconocido": "",
      "Fecha_Reconocimiento": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Reconocimiento de Títulos';

-- Programas de Estudio
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Programa de Estudio",
    "Datos_Programa": {
      "Nombre_Programa_Carrera": "",
      "Institucion_Educativa": "",
      "Nivel_Academico": "Ej: Pregrado/Postgrado",
      "Duracion_Semestres": "",
      "Total_Creditos": ""
    },
    "Contenido_Academico": {
      "Objetivos_Generales": [],
      "Malla_Curricular_URL": "",
      "Perfiles": {
        "Perfil_Ingreso": "",
        "Perfil_Egreso": ""
      }
    },
    "Datos_Emision": {
      "Fecha_Emision": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Programas de Estudio';

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
-- Script para actualizar esquema_json en webapp_modulo - Documentos Médicos
-- =============================================================================

-- Licencias Médicas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Licencia Médica",
    "Datos_Paciente": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": "",
      "Fecha_Nacimiento": ""
    },
    "Datos_Licencia": {
      "Numero_Licencia": "",
      "Tipo_Licencia": "Ej: Común/Maternal/Enfermedad del hijo/accidente del trabajo",
      "Diagnostico_CIE10": "",
      "Fecha_Inicio_Reposo": "",
      "Fecha_Termino_Reposo": "",
      "Dias_Reposo": "",
      "Modalidad_Reposo": "Ej: Total/Parcial"
    },
    "Datos_Emisor": {
      "Nombre_Medico": "",
      "Rut_Medico": "",
      "Especialidad": "",
      "Centro_Medico": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Licencias Médicas';

-- Recetas Médicas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Receta Médica",
    "Datos_Paciente": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": ""
    },
    "Datos_Prescripcion": {
      "Fecha_Emision": "",
      "Medicamentos": [
        {
          "Nombre_Medicamento": "",
          "Dosis": "",
          "Frecuencia": "",
          "Duracion_Tratamiento": "",
          "Via_Administracion": ""
        }
      ],
      "Indicaciones_Adicionales": ""
    },
    "Datos_Medico": {
      "Nombre_Medico": "",
      "Rut_Medico": "",
      "Especialidad": "",
      "Centro_Medico": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Recetas Médicas';

-- Resultados de Exámenes
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Resultado de Examen",
    "Datos_Paciente": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": "",
      "Fecha_Nacimiento": ""
    },
    "Datos_Examen": {
      "Nombre_Examen": "",
      "Tipo_Examen": "Ej: Laboratorio/Imagenología/Funcional",
      "Fecha_Toma_Muestra": "",
      "Fecha_Resultado": "",
      "Laboratorio_Clinica": ""
    },
    "Resultados": [
      {
        "Parametro": "",
        "Valor_Obtenido": "",
        "Unidad": "",
        "Rango_Referencia": "",
        "Interpretacion": ""
      }
    ],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Resultados de Exámenes';

-- Informes Médicos
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Informe Médico",
    "Datos_Paciente": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": "",
      "Fecha_Nacimiento": ""
    },
    "Datos_Informe": {
      "Fecha_Informe": "",
      "Especialidad_Medica": "",
      "Motivo_Consulta_Derivacion": "",
      "Anamnesis": "",
      "Examen_Fisico": "",
      "Diagnostico": [
        {
          "CIE10": "",
          "Descripcion": ""
        }
      ],
      "Plan_Tratamiento": "",
      "Pronostico": ""
    },
    "Datos_Medico": {
      "Nombre_Medico": "",
      "Rut_Medico": "",
      "Centro_Medico": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Informes Médicos';

-- Epicrisis
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Epicrisis",
    "Datos_Paciente": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": "",
      "Fecha_Nacimiento": ""
    },
    "Datos_Hospitalizacion": {
      "Fecha_Ingreso": "",
      "Fecha_Egreso": "",
      "Diagnostico_Ingreso_CIE10": "",
      "Diagnostico_Egreso_CIE10": "",
      "Servicio_Clinico": "",
      "Medico_Tratante": "",
      "Resumen_Evolucion": "",
      "Procedimientos_Realizados": [],
      "Complicaciones": "",
      "Indicaciones_Alta": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Epicrisis';

-- Certificados Médicos
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado Médico",
    "Datos_Paciente": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": ""
    },
    "Datos_Certificado": {
      "Fecha_Emision": "",
      "Motivo_Certificado": "Ej: Aptitud física/Salud compatible con estudios/Libre de enfermedad contagiosa",
      "Estado_Salud_Declarado": "",
      "Periodo_Validez": ""
    },
    "Datos_Medico": {
      "Nombre_Medico": "",
      "Rut_Medico": "",
      "Especialidad": "",
      "Centro_Medico": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificados Médicos';

-- Bonos y Reembolsos
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Bono o Reembolso",
    "Datos_Beneficiario": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": ""
    },
    "Datos_Prestacion": {
      "Fecha_Prestacion": "",
      "Nombre_Prestacion": "",
      "Codigo_Prestacion": "",
      "Monto_Total": "",
      "Monto_Cubierto_Seguro": "",
      "Monto_Reembolsado": "",
      "Monto_Diferencia_Pagada": "",
      "Institucion_Salud": "Ej: Clínica/Centro Médico/Laboratorio"
    },
    "Datos_Seguro": {
      "Nombre_Aseguradora_Isapre": "",
      "Numero_Poliza_Beneficio": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Bonos y Reembolsos';

-- Carné de Vacunas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Carné de Vacunas",
    "Datos_Paciente": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": "",
      "Fecha_Nacimiento": ""
    },
    "Historial_Vacunas": [
      {
        "Nombre_Vacuna": "",
        "Fecha_Administracion": "",
        "Dosis": "",
        "Lote": "",
        "Centro_Vacunacion": ""
      }
    ],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Carné de Vacunas';

-- Órdenes Médicas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Orden Médica",
    "Datos_Paciente": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": ""
    },
    "Datos_Orden": {
      "Fecha_Emision": "",
      "Tipo_Solicitud": "Ej: Examen/Procedimiento/Interconsulta",
      "Detalle_Solicitud": "",
      "Justificacion_Clinica": ""
    },
    "Datos_Medico": {
      "Nombre_Medico": "",
      "Rut_Medico": "",
      "Especialidad": "",
      "Centro_Medico": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Órdenes Médicas';

-- Historia Clínica
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Historia Clínica",
    "Datos_Paciente": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": "",
      "Fecha_Nacimiento": ""
    },
    "Antecedentes_Medicos": {
      "Alergias": [],
      "Enfermedades_Cronicas": [],
      "Cirugias_Previas": [],
      "Medicamentos_Habituales": []
    },
    "Atenciones_Recientes": [
      {
        "Fecha_Atencion": "",
        "Motivo_Consulta": "",
        "Diagnostico": "",
        "Tratamiento": "",
        "Medico_Tratante": "",
        "Centro_Atencion": ""
      }
    ],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Historia Clínica';

-- Certificados GES/AUGE
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado GES/AUGE",
    "Datos_Paciente": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": ""
    },
    "Detalle_GES": {
      "Patologia_GES": "",
      "Fecha_Diagnostico": "",
      "Estado_Patologia": "",
      "Prestador_Asociado": "",
      "Fecha_Activacion_Garantia": ""
    },
    "Datos_Emision": {
      "Fecha_Emision": "",
      "Autoridad_Emisora": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificados GES/AUGE';

-- Certificados de Nacimiento Médico
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Nacimiento Médico",
    "Datos_Recien_Nacido": {
      "Nombres": "",
      "Apellidos": "",
      "Fecha_Nacimiento": "",
      "Hora_Nacimiento": "",
      "Sexo": "",
      "Peso": "",
      "Talla": "",
      "Tipo_Parto": ""
    },
    "Datos_Madre": {
      "Nombre_Madre": "",
      "Rut_Madre": ""
    },
    "Datos_Padre": {
      "Nombre_Padre": "",
      "Rut_Padre": ""
    },
    "Datos_Medico_Asistente": {
      "Nombre_Medico": "",
      "Rut_Medico": ""
    },
    "Lugar_Nacimiento": {
      "Nombre_Establecimiento": "",
      "Direccion": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificados de Nacimiento Médico';

-- Certificados de Defunción Médico
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Defunción Médico",
    "Datos_Fallecido": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": "",
      "Fecha_Nacimiento": "",
      "Fecha_Defuncion": "",
      "Hora_Defuncion": "",
      "Lugar_Defuncion": ""
    },
    "Causa_Defuncion": {
      "Causa_Directa": "",
      "Causas_Contribuyentes": [],
      "Diagnostico_CIE10": ""
    },
    "Datos_Medico_Certificador": {
      "Nombre_Medico": "",
      "Rut_Medico": "",
      "Centro_Medico": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificados de Defunción Médico';

-- Consentimientos Informados
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Consentimiento Informado",
    "Datos_Paciente": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": ""
    },
    "Datos_Procedimiento": {
      "Nombre_Procedimiento": "",
      "Fecha_Propuesta": "",
      "Descripcion_Procedimiento": "",
      "Riesgos_Beneficios": "",
      "Alternativas_Tratamiento": ""
    },
    "Datos_Consentimiento": {
      "Fecha_Firma": "",
      "Testigo_Presente": "",
      "Declara_Comprension": "Sí/No",
      "Autorizacion_Firma": "Sí/No"
    },
    "Datos_Medico_Informa": {
      "Nombre_Medico": "",
      "Rut_Medico": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Consentimientos Informados';

-- Informes Radiológicos
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Informe Radiológico",
    "Datos_Paciente": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": ""
    },
    "Datos_Estudio": {
      "Tipo_Examen_Imagen": "Ej: Radiografía/Ecografía/Tomografía/Resonancia",
      "Region_Anatomica": "",
      "Fecha_Realizacion": "",
      "Centro_Radiologico": ""
    },
    "Resultados_Informe": {
      "Hallazgos_Clave": "",
      "Impresion_Diagnostica": "",
      "Comparacion_Estudios_Previos": ""
    },
    "Datos_Radiologo": {
      "Nombre_Radiologo": "",
      "Rut_Radiologo": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Informes Radiológicos';

-- Derivaciones
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Derivación",
    "Datos_Paciente": {
      "Nombres": "",
      "Apellidos": "",
      "Rut": ""
    },
    "Datos_Derivacion": {
      "Fecha_Derivacion": "",
      "Motivo_Derivacion": "",
      "Especialidad_Solicitada": "",
      "Diagnostico_Principal": "",
      "Resumen_Clinico": ""
    },
    "Medico_Remitente": {
      "Nombre_Medico": "",
      "Rut_Medico": "",
      "Centro_Medico": ""
    },
    "Medico_Destinatario": {
      "Nombre_Medico_Esperado": "",
      "Centro_Destino": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Derivaciones';

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
-- Script para actualizar esquema_json en webapp_modulo - Documentos Societarios
-- =============================================================================

-- Escritura de Constitución
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Escritura de Constitución",
    "Datos_Sociedad": {
      "Nombre_Razon_Social": "",
      "Rut_Sociedad": "",
      "Tipo_Sociedad": "Ej: SpA/Ltda./SA",
      "Fecha_Constitucion": "YYYY-MM-DD",
      "Domicilio_Social": "Calle #Numero, Comuna, Ciudad, País",
      "Objeto_Social": "Descripción breve del giro"
    },
    "Socios_Accionistas": [
      {
        "Nombre_Razon_Social": "",
        "Rut": "",
        "Aporte_Capital": "",
        "Porcentaje_Participacion": ""
      }
    ],
    "Administracion": {
      "Tipo_Administracion": "Ej: Administrador único/Directorio",
      "Representante_Legal_Nombre": "",
      "Representante_Legal_Rut": ""
    },
    "Datos_Notaria_Registro": {
      "Nombre_Notaria": "",
      "Fecha_Escritura_Publica": "YYYY-MM-DD",
      "Numero_Repertorio": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Escritura de Constitución';

-- Estatutos Sociales
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Estatutos Sociales",
    "Datos_Sociedad": {
      "Nombre_Razon_Social": "",
      "Rut_Sociedad": ""
    },
    "Reglas_Internas": {
      "Capital_Social": "",
      "Division_Acciones_Cuotas": "Ej: Número y valor de acciones/cuotas",
      "Juntas_Directorios": "Reglas de citación y quórum",
      "Distribucion_Utilidades_Perdidas": "",
      "Duracion_Sociedad": ""
    },
    "Datos_Modificacion": {
      "Fecha_Ultima_Modificacion": "YYYY-MM-DD",
      "Numero_Repertorio_Ultima_Modificacion": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Estatutos Sociales';

-- Modificaciones Societarias
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Modificación Societaria",
    "Datos_Sociedad": {
      "Nombre_Razon_Social": "",
      "Rut_Sociedad": ""
    },
    "Tipo_Modificacion": "Ej: Cambio de razón social/Cambio de domicilio/Aumento de capital/Cambio de socios/Cambio de objeto",
    "Fecha_Modificacion": "YYYY-MM-DD",
    "Descripcion_Modificacion": "Detalle de los cambios realizados",
    "Documento_Soporte": {
      "Tipo_Documento": "Ej: Escritura Pública",
      "Fecha_Documento": "YYYY-MM-DD",
      "Numero_Repertorio": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Modificaciones Societarias';

-- Extractos Legales
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Extracto Legal",
    "Datos_Sociedad": {
      "Nombre_Razon_Social": "",
      "Rut_Sociedad": ""
    },
    "Detalle_Publicacion": {
      "Fecha_Publicacion": "YYYY-MM-DD",
      "Diario_Oficial_Numero": "",
      "Materia_Publicada": "Ej: Constitución de sociedad/Modificación de estatutos/Extracto de acta",
      "URL_Diario_Oficial": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Extractos Legales';

-- Inscripciones Registrales
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Inscripción Registral",
    "Datos_Sociedad": {
      "Nombre_Razon_Social": "",
      "Rut_Sociedad": ""
    },
    "Detalle_Inscripcion": {
      "Tipo_Registro": "Ej: Conservador de Bienes Raíces/Registro de Comercio",
      "Lugar_Registro": "Comuna/Ciudad",
      "Fecha_Inscripcion": "YYYY-MM-DD",
      "Numero_Fojas": "",
      "Numero_Numero": "",
      "Año_Registro": ""
    },
    "Documento_Referencia": {
      "Tipo_Documento_Origen": "Ej: Escritura de Constitución/Modificación",
      "Fecha_Documento_Origen": "YYYY-MM-DD"
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Inscripciones Registrales';

-- Actas de Directorio
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Acta de Directorio",
    "Datos_Sociedad": {
      "Nombre_Razon_Social": "",
      "Rut_Sociedad": ""
    },
    "Datos_Acta": {
      "Numero_Acta": "",
      "Fecha_Sesion": "YYYY-MM-DD",
      "Tipo_Sesion": "Ej: Ordinaria/Extraordinaria",
      "Quorum_Presente": "Ej: % de Directores",
      "Directores_Presentes": [],
      "Acuerdos_Tomados": [],
      "Temas_Tratados": []
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Actas de Directorio';

-- Actas de Junta de Accionistas
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Acta de Junta de Accionistas",
    "Datos_Sociedad": {
      "Nombre_Razon_Social": "",
      "Rut_Sociedad": ""
    },
    "Datos_Acta": {
      "Numero_Acta": "",
      "Fecha_Sesion": "YYYY-MM-DD",
      "Tipo_Sesion": "Ej: Ordinaria/Extraordinaria",
      "Quorum_Presente": "Ej: % de acciones con derecho a voto",
      "Accionistas_Presentes_Representados": [],
      "Acuerdos_Tomados": [],
      "Temas_Tratados": []
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Actas de Junta de Accionistas';

-- Poderes Corporativos
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Poder Corporativo",
    "Datos_Sociedad": {
      "Nombre_Razon_Social": "",
      "Rut_Sociedad": ""
    },
    "Datos_Apoderado": {
      "Nombre_Completo": "",
      "Rut": "",
      "Nacionalidad": ""
    },
    "Detalle_Poder": {
      "Tipo_Poder": "Ej: General/Especial",
      "Facultades_Otorgadas": [],
      "Vigencia_Poder": "Ej: Indefinido/Fecha de término",
      "Fecha_Otorgamiento": "YYYY-MM-DD"
    },
    "Datos_Notaria": {
      "Nombre_Notaria": "",
      "Numero_Repertorio": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Poderes Corporativos';

-- Certificados de Vigencia
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Vigencia",
    "Datos_Sociedad": {
      "Nombre_Razon_Social": "",
      "Rut_Sociedad": ""
    },
    "Detalle_Vigencia": {
      "Autoridad_Emisora": "Ej: Registro de Comercio/Servicio de Registro Civil e Identificación",
      "Fecha_Emision": "YYYY-MM-DD",
      "Estado_Vigencia": "Ej: Vigente/Disuelta",
      "Numero_Certificado": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Certificados de Vigencia';

-- Libros Sociales
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Libros Sociales",
    "Datos_Sociedad": {
      "Nombre_Razon_Social": "",
      "Rut_Sociedad": ""
    },
    "Tipo_Libro": "Ej: Libro de Accionistas/Libro de Actas de Directorio/Libro de Actas de Junta",
    "Detalle_Registros": [
      {
        "Fecha_Registro": "YYYY-MM-DD",
        "Numero_Folio": "",
        "Descripcion_Asiento": ""
      }
    ],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Libros Sociales';

-- Transformaciones
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Transformación Societaria",
    "Datos_Sociedad_Original": {
      "Nombre_Razon_Social": "",
      "Rut_Sociedad": "",
      "Tipo_Sociedad_Original": ""
    },
    "Datos_Sociedad_Nueva": {
      "Tipo_Sociedad_Transformada": "",
      "Nombre_Razon_Social_Nueva": ""
    },
    "Fecha_Transformacion": "YYYY-MM-DD",
    "Documento_Soporte": {
      "Tipo_Documento": "Ej: Escritura Pública",
      "Fecha_Documento": "YYYY-MM-DD",
      "Numero_Repertorio": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Transformaciones';

-- Fusiones y Divisiones
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Fusión o División",
    "Tipo_Operacion": "Ej: Fusión por creación/Fusión por incorporación/División",
    "Sociedades_Involucradas": [
      {
        "Nombre_Razon_Social": "",
        "Rut_Sociedad": "",
        "Rol_En_Operacion": "Ej: Absorbente/Absorbida/Sociedad Resultante/Sociedad Dividida"
      }
    ],
    "Fecha_Acuerdo": "YYYY-MM-DD",
    "Fecha_Efectiva_Operacion": "YYYY-MM-DD",
    "Documento_Soporte": {
      "Tipo_Documento": "Ej: Escritura Pública de Fusión/División",
      "Fecha_Documento": "YYYY-MM-DD",
      "Numero_Repertorio": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Fusiones y Divisiones';

-- Disoluciones
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Disolución Societaria",
    "Datos_Sociedad": {
      "Nombre_Razon_Social": "",
      "Rut_Sociedad": "",
      "Tipo_Sociedad": ""
    },
    "Fecha_Acuerdo_Disolucion": "YYYY-MM-DD",
    "Causa_Disolucion": "Ej: Término de plazo/Acuerdo de socios/Liquidación",
    "Fecha_Termino_Existencia": "YYYY-MM-DD",
    "Datos_Liquidador": {
      "Nombre_Completo": "",
      "Rut": ""
    },
    "Documento_Soporte": {
      "Tipo_Documento": "Ej: Escritura Pública de Disolución",
      "Fecha_Documento": "YYYY-MM-DD",
      "Numero_Repertorio": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Disoluciones';

-- Contratos de Confidencialidad
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Contrato de Confidencialidad",
    "Partes_Involucradas": [
      {
        "Nombre_Razon_Social": "",
        "Rut": "",
        "Rol": "Ej: Parte Reveladora/Parte Receptora"
      }
    ],
    "Detalle_Contrato": {
      "Fecha_Firma": "YYYY-MM-DD",
      "Objeto_Confidencialidad": "Descripción de la información protegida",
      "Duracion_Acuerdo": "Ej: 5 años/Indefinido",
      "Jurisdiccion": "Ej: Santiago, Chile"
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Contratos de Confidencialidad';

-- Informes Corporativos
UPDATE webapp_modulo SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Informe Corporativo",
    "Datos_Sociedad": {
      "Nombre_Razon_Social": "",
      "Rut_Sociedad": ""
    },
    "Tipo_Informe": "Ej: Anual/Gestión/Financiero/Sostenibilidad",
    "Periodo_Reportado": "Ej: Año Fiscal 2024",
    "Fecha_Emision_Informe": "YYYY-MM-DD",
    "Contenido_Principal": "Resumen ejecutivo del informe",
    "URL_Acceso_Informe": "Si aplica, enlace al informe completo",
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}' WHERE nombre = 'Informes Corporativos';

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
-- Actualización de esquemas JSON para Documentos de Comercio Exterior
-- =============================================================================

-- Declaración de Ingreso (DIN)
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Declaración de Ingreso (DIN)",
    "Datos_Generales": {
      "Numero_DIN": "",
      "Fecha_Aceptacion": "",
      "Aduana_Ingreso": ""
    },
    "Importador": {
      "Razon_Social": "",
      "RUT": "",
      "Direccion": ""
    },
    "Proveedor_Origen": {
      "Nombre": "",
      "Pais": ""
    },
    "Detalle_Mercancias": [
      {
        "Item": "",
        "Descripcion": "",
        "Cantidad": "",
        "Unidad_Medida": "",
        "Valor_CIF_USD": "",
        "Partida_Arancelaria": ""
      }
    ],
    "Valores_Aduaneros": {
      "Valor_FOB_USD": "",
      "Flete_USD": "",
      "Seguro_USD": "",
      "Total_CIF_USD": "",
      "Derechos_Aduaneros_CLP": "",
      "IVA_CLP": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Declaración de Ingreso (DIN)';

-- Declaración de Exportación (DUS)
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Declaración de Exportación (DUS)",
    "Datos_Generales": {
      "Numero_DUS": "",
      "Fecha_Aceptacion": "",
      "Aduana_Salida": ""
    },
    "Exportador": {
      "Razon_Social": "",
      "RUT": "",
      "Direccion": ""
    },
    "Comprador_Destino": {
      "Nombre": "",
      "Pais": ""
    },
    "Detalle_Mercancias": [
      {
        "Item": "",
        "Descripcion": "",
        "Cantidad": "",
        "Unidad_Medida": "",
        "Valor_FOB_USD": "",
        "Partida_Arancelaria": ""
      }
    ],
    "Incoterm": "",
    "Puerto_Embarque": "",
    "Puerto_Desembarque": "",
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Declaración de Exportación (DUS)';

-- Conocimiento de Embarque (B/L)
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Conocimiento de Embarque (B/L)",
    "Datos_Generales": {
      "Numero_BL": "",
      "Fecha_Emision": ""
    },
    "Shipper": {
      "Nombre": "",
      "Direccion": ""
    },
    "Consignee": {
      "Nombre": "",
      "Direccion": ""
    },
    "Notify_Party": {
      "Nombre": "",
      "Direccion": ""
    },
    "Informacion_Transporte": {
      "Nave": "",
      "Numero_Viaje": "",
      "Puerto_Carga": "",
      "Puerto_Descarga": ""
    },
    "Detalle_Carga": {
      "Descripcion_Mercancia": "",
      "Cantidad_Bultos": "",
      "Peso_Bruto_KG": "",
      "Volumen_CBM": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Conocimiento de Embarque (B/L)';

-- Guía Aérea (AWB)
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Guía Aérea (AWB)",
    "Datos_Generales": {
      "Numero_AWB": "",
      "Fecha_Emision": ""
    },
    "Shipper": {
      "Nombre": "",
      "Direccion": ""
    },
    "Consignee": {
      "Nombre": "",
      "Direccion": ""
    },
    "Informacion_Transporte": {
      "Aerolinea": "",
      "Numero_Vuelo": "",
      "Aeropuerto_Origen": "",
      "Aeropuerto_Destino": ""
    },
    "Detalle_Carga": {
      "Descripcion_Mercancia": "",
      "Cantidad_Piezas": "",
      "Peso_Bruto_KG": "",
      "Peso_Cobrable_KG": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Guía Aérea (AWB)';

-- Factura Comercial Internacional
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Factura Comercial Internacional",
    "Datos_Generales": {
      "Numero_Factura": "",
      "Fecha_Emision": ""
    },
    "Vendedor": {
      "Razon_Social": "",
      "Direccion": "",
      "Pais": ""
    },
    "Comprador": {
      "Razon_Social": "",
      "Direccion": "",
      "Pais": ""
    },
    "Detalle_Productos": [
      {
        "Descripcion": "",
        "Cantidad": "",
        "Precio_Unitario": "",
        "Monto_Total": "",
        "Moneda": "",
        "Partida_Arancelaria": ""
      }
    ],
    "Totales_Financieros": {
      "Subtotal": "",
      "Total_Factura": "",
      "Moneda_Total": ""
    },
    "Condiciones_Comerciales": {
      "Condiciones_Pago": "",
      "Incoterm": "",
      "Puerto_Carga": "",
      "Puerto_Descarga": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Factura Comercial Internacional';

-- Packing List
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Packing List",
    "Datos_Generales": {
      "Numero_Packing_List": "",
      "Referencia_Factura": "",
      "Fecha_Emision": ""
    },
    "Remitente": {
      "Nombre": "",
      "Direccion": ""
    },
    "Destinatario": {
      "Nombre": "",
      "Direccion": ""
    },
    "Detalle_Bultos": [
      {
        "Numero_Bulto": "",
        "Tipo_Bulto": "",
        "Contenido": "",
        "Cantidad_Piezas": "",
        "Peso_Neto_KG": "",
        "Peso_Bruto_KG": "",
        "Dimensiones_CM": {
          "Largo": "",
          "Ancho": "",
          "Alto": ""
        }
      }
    ],
    "Resumen_Carga": {
      "Total_Bultos": "",
      "Peso_Neto_Total_KG": "",
      "Peso_Bruto_Total_KG": "",
      "Volumen_Total_CBM": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Packing List';

-- Certificados de Origen
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Origen",
    "Datos_Generales": {
      "Numero_Certificado": "",
      "Fecha_Emision": "",
      "Entidad_Emisora": ""
    },
    "Exportador": {
      "Nombre": "",
      "Direccion": ""
    },
    "Importador": {
      "Nombre": "",
      "Direccion": ""
    },
    "Informacion_Origen": {
      "Pais_Origen": "",
      "Pais_Destino": "",
      "Criterio_Origen": ""
    },
    "Descripcion_Mercancias": "",
    "Referencias": {
      "Referencia_Factura": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados de Origen';

-- Certificados Fitosanitarios
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado Fitosanitario",
    "Datos_Generales": {
      "Numero_Certificado": "",
      "Fecha_Emision": "",
      "Autoridad_Emisora": ""
    },
    "Exportador": {
      "Nombre": "",
      "Direccion": ""
    },
    "Importador": {
      "Nombre": "",
      "Direccion": ""
    },
    "Informacion_Producto": {
      "Pais_Origen": "",
      "Pais_Destino": "",
      "Descripcion_Productos_Vegetales": "",
      "Cantidad": "",
      "Tratamiento_Aplicado": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados Fitosanitarios';

-- Certificados Zoosanitarios
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado Zoosanitario",
    "Datos_Generales": {
      "Numero_Certificado": "",
      "Fecha_Emision": "",
      "Autoridad_Emisora": ""
    },
    "Exportador": {
      "Nombre": "",
      "Direccion": ""
    },
    "Importador": {
      "Nombre": "",
      "Direccion": ""
    },
    "Informacion_Producto": {
      "Pais_Origen": "",
      "Pais_Destino": "",
      "Descripcion_Productos_Animales": "",
      "Cantidad": "",
      "Especie": "",
      "Tratamiento_Aplicado": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados Zoosanitarios';

-- Cartas de Crédito
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Carta de Crédito",
    "Datos_Generales": {
      "Numero_Carta_Credito": "",
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Monto_Maximo": "",
      "Moneda": ""
    },
    "Bancos": {
      "Banco_Emisor": {
        "Nombre": "",
        "SWIFT": ""
      },
      "Banco_Beneficiario": {
        "Nombre": "",
        "SWIFT": ""
      }
    },
    "Partes_Involucradas": {
      "Beneficiario": {
        "Nombre": "",
        "Direccion": ""
      },
      "Solicitante": {
        "Nombre": "",
        "Direccion": ""
      }
    },
    "Terminos_Comerciales": {
      "Descripcion_Mercancias": "",
      "Incoterm": "",
      "Documentos_Requeridos": []
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Cartas de Crédito';

-- Manifiestos de Carga
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Manifiesto de Carga",
    "Datos_Generales": {
      "Numero_Manifiesto": "",
      "Fecha_Emision": ""
    },
    "Transportista": {
      "Nombre": "",
      "RUT": ""
    },
    "Informacion_Transporte": {
      "Medio_Transporte": "",
      "Numero_Identificacion_Transporte": "",
      "Puerto_Carga": "",
      "Puerto_Descarga": ""
    },
    "Listado_Documentos_Transporte": [
      {
        "Numero_Documento": "",
        "Tipo_Documento": "",
        "Cantidad_Bultos": "",
        "Peso_KG": ""
      }
    ],
    "Resumen_Carga": {
      "Total_Bultos": "",
      "Total_Peso_KG": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Manifiestos de Carga';

-- Pólizas de Seguro
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Póliza de Seguro",
    "Datos_Generales": {
      "Numero_Poliza": "",
      "Fecha_Emision": "",
      "Valor_Asegurado": "",
      "Moneda": ""
    },
    "Partes_Involucradas": {
      "Aseguradora": {
        "Nombre": "",
        "Direccion": ""
      },
      "Tomador_Seguro": {
        "Nombre": "",
        "Direccion": ""
      },
      "Beneficiario_Seguro": {
        "Nombre": "",
        "Direccion": ""
      }
    },
    "Cobertura": {
      "Periodo_Cobertura": {
        "Inicio": "",
        "Fin": ""
      },
      "Mercancia_Asegurada": "",
      "Cobertura_Geografica": "",
      "Condiciones_Especiales": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Pólizas de Seguro';

-- Documentos ISPM-15
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificación ISPM-15",
    "Datos_Generales": {
      "Numero_Certificacion": "",
      "Fecha_Emision": "",
      "Entidad_Emisora": ""
    },
    "Informacion_Tratamiento": {
      "Empresa_Tratamiento": {
        "Nombre": "",
        "Codigo_Registro": ""
      },
      "Tipo_Embalaje_Madera": "",
      "Metodo_Tratamiento": ""
    },
    "Informacion_Envio": {
      "Ubicacion_Mercancia": "",
      "Referencia_Envio": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Documentos ISPM-15';

-- Resoluciones Aduaneras
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Resolución Aduanera",
    "Datos_Generales": {
      "Numero_Resolucion": "",
      "Fecha_Emision": "",
      "Autoridad_Emisora": "Servicio Nacional de Aduanas",
      "Tipo_Resolucion": ""
    },
    "Informacion_Afectado": {
      "RUT_Afectado": "",
      "Nombre_Afectado": ""
    },
    "Contenido_Resolucion": {
      "Descripcion_Resumen": "",
      "Disposicion_Legal": "",
      "Estado_Resolucion": ""
    },
    "Referencias": {
      "Referencia_Documento_Original": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Resoluciones Aduaneras';

-- ========================================================================
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
-- Actualización de esquemas JSON para Documentos de Seguros y Previsión
-- =============================================================================

-- Pólizas de Seguro General
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Póliza de Seguro General",
    "Datos_Poliza": {
      "Numero_Poliza": "",
      "Tipo_Cobertura": "",
      "Fecha_Emision": "",
      "Fecha_Inicio_Vigencia": "",
      "Fecha_Fin_Vigencia": "",
      "Prima_Anual": "",
      "Moneda": ""
    },
    "Aseguradora": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Direccion": ""
    },
    "Asegurado": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Direccion": ""
    },
    "Bienes_Asegurados": [
      {
        "Tipo_Bien": "",
        "Descripcion": "",
        "Valor_Asegurado": ""
      }
    ],
    "Condiciones_Particulares": {
      "Deducible": "",
      "Coberturas_Adicionales": [],
      "Exclusiones": []
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Pólizas de Seguro General';

-- Pólizas de Vida
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Póliza de Vida",
    "Datos_Poliza": {
      "Numero_Poliza": "",
      "Tipo_Producto": "Seguro de Vida",
      "Fecha_Emision": "",
      "Fecha_Inicio_Vigencia": "",
      "Fecha_Fin_Vigencia": "",
      "Monto_Capital_Asegurado": "",
      "Moneda": "",
      "Prima_Periodica": "",
      "Frecuencia_Pago": ""
    },
    "Aseguradora": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Direccion": ""
    },
    "Asegurado": {
      "Nombres": "",
      "Apellidos": "",
      "RUT": "",
      "Fecha_Nacimiento": ""
    },
    "Beneficiarios": [
      {
        "Nombres": "",
        "Apellidos": "",
        "RUT": "",
        "Parentesco": "",
        "Porcentaje": ""
      }
    ],
    "Condiciones_Particulares": {
      "Beneficios_Adicionales": [],
      "Exclusiones": []
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Pólizas de Vida';

-- Pólizas de Salud
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Póliza de Salud",
    "Datos_Poliza": {
      "Numero_Poliza": "",
      "Tipo_Producto": "Seguro Complementario de Salud",
      "Fecha_Emision": "",
      "Fecha_Inicio_Vigencia": "",
      "Fecha_Fin_Vigencia": "",
      "Plan_Salud": "",
      "Prima_Mensual": "",
      "Moneda": ""
    },
    "Aseguradora": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Direccion": ""
    },
    "Contratante": {
      "Nombre_Razon_Social": "",
      "RUT": ""
    },
    "Asegurados": [
      {
        "Nombres": "",
        "Apellidos": "",
        "RUT": "",
        "Fecha_Nacimiento": "",
        "Parentesco": ""
      }
    ],
    "Coberturas": {
      "Hospitalarias": "",
      "Ambulatorias": "",
      "Farmacia": "",
      "Dental": "",
      "Topes_Anuales": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Pólizas de Salud';

-- Certificados de Cobertura
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Cobertura",
    "Datos_Certificado": {
      "Numero_Certificado": "",
      "Fecha_Emision": "",
      "Tipo_Seguro": "",
      "Numero_Poliza_Asociada": "",
      "Estado_Cobertura": ""
    },
    "Aseguradora": {
      "Nombre_Razon_Social": "",
      "RUT": ""
    },
    "Asegurado": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Periodo_Cobertura": {
        "Inicio": "",
        "Fin": ""
      }
    },
    "Alcance_Cobertura": {
      "Descripcion_Cobertura_Principal": "",
      "Limites_Montos_Cubiertos": "",
      "Deducibles": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados de Cobertura';

-- Denuncios de Siniestro
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Denuncio de Siniestro",
    "Datos_Siniestro": {
      "Numero_Denuncio": "",
      "Fecha_Denuncio": "",
      "Fecha_Ocurrencia_Siniestro": "",
      "Lugar_Ocurrencia": "",
      "Tipo_Siniestro": "",
      "Descripcion_Hechos": ""
    },
    "Poliza_Afectada": {
      "Numero_Poliza": "",
      "Tipo_Seguro": "",
      "Aseguradora": ""
    },
    "Afectado": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Contacto": ""
    },
    "Daños_Estimados": {
      "Descripcion_Daños": "",
      "Valor_Estimado_CLP": ""
    },
    "Informacion_Adicional": {
      "Documentos_Adjuntos": [],
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Denuncios de Siniestro';

-- Liquidaciones de Siniestro
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Liquidación de Siniestro",
    "Datos_Liquidacion": {
      "Numero_Liquidacion": "",
      "Fecha_Liquidacion": "",
      "Numero_Denuncio_Asociado": "",
      "Estado_Liquidacion": ""
    },
    "Poliza_Involucrada": {
      "Numero_Poliza": "",
      "Aseguradora": ""
    },
    "Asegurado_Beneficiario": {
      "Nombre_Razon_Social": "",
      "RUT": ""
    },
    "Detalle_Indemnizacion": {
      "Monto_Bruto_Indemnizacion": "",
      "Deducibles_Aplicados": "",
      "Monto_Liquido_A_Pagar": "",
      "Moneda": "",
      "Fecha_Pago_Estimada": ""
    },
    "Fundamento_Liquidacion": {
      "Articulos_Poliza": [],
      "Consideraciones_Tecnicas": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Liquidaciones de Siniestro';

-- Certificados de AFP
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de AFP",
    "Datos_Certificado": {
      "Tipo_Certificado": "",
      "Fecha_Emision": ""
    },
    "Afiliado": {
      "Nombres": "",
      "Apellidos": "",
      "RUT": "",
      "Fecha_Nacimiento": ""
    },
    "AFP": {
      "Nombre_AFP": "",
      "Numero_Afiliado": ""
    },
    "Informacion_Previsional": {
      "Fecha_Afiliacion": "",
      "Tipo_Fondo": "",
      "Saldo_Total_CLP": "",
      "Cotizaciones_Periodo": [
        {
          "Mes_Año": "",
          "Monto_Cotizado_CLP": ""
        }
      ]
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados de AFP';

-- Certificados de APV
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de APV",
    "Datos_Certificado": {
      "Numero_Certificado": "",
      "Fecha_Emision": "",
      "Tipo_APV": ""
    },
    "Cotizante": {
      "Nombres": "",
      "Apellidos": "",
      "RUT": ""
    },
    "Institucion_Financiera": {
      "Nombre_Institucion": "",
      "RUT": ""
    },
    "Informacion_APV": {
      "Numero_Contrato": "",
      "Fecha_Inicio_Contrato": "",
      "Saldo_Acumulado_CLP": "",
      "Aportes_Periodo": [
        {
          "Mes_Año": "",
          "Monto_Aportado_CLP": ""
        }
      ],
      "Beneficio_Tributario": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados de APV';

-- Documentos de Pensión
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Documento de Pensión",
    "Datos_Generales": {
      "Tipo_Documento_Pension": "",
      "Fecha_Emision": ""
    },
    "Pensionado": {
      "Nombres": "",
      "Apellidos": "",
      "RUT": "",
      "Fecha_Nacimiento": ""
    },
    "Institucion_Pagadora": {
      "Nombre": "",
      "RUT": ""
    },
    "Informacion_Pension": {
      "Tipo_Pension": "",
      "Monto_Bruto_CLP": "",
      "Descuentos_CLP": {
        "Salud": "",
        "Otros": ""
      },
      "Monto_Liquido_CLP": "",
      "Fecha_Ultimo_Pago": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Documentos de Pensión';

-- Certificados de Isapre
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Isapre",
    "Datos_Certificado": {
      "Numero_Certificado": "",
      "Fecha_Emision": ""
    },
    "Afiliado_Titular": {
      "Nombres": "",
      "Apellidos": "",
      "RUT": ""
    },
    "Isapre": {
      "Nombre_Isapre": "",
      "RUT": ""
    },
    "Plan_Salud_Contratado": {
      "Nombre_Plan": "",
      "Codigo_Plan": "",
      "UF_Base": "",
      "Porcentaje_Cotizacion": ""
    },
    "Beneficiarios_Cargas": [
      {
        "Nombres": "",
        "Apellidos": "",
        "RUT": "",
        "Parentesco": ""
      }
    ],
    "Periodo_Vigencia": {
      "Inicio": "",
      "Fin": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados de Isapre';

-- Certificados de Fonasa
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Fonasa",
    "Datos_Certificado": {
      "Numero_Certificado": "",
      "Fecha_Emision": ""
    },
    "Afiliado": {
      "Nombres": "",
      "Apellidos": "",
      "RUT": "",
      "Fecha_Nacimiento": ""
    },
    "Datos_Afiliacion_Fonasa": {
      "Tramo_Fonasa": "",
      "Estado_Afiliacion": "",
      "Fecha_Afiliacion": ""
    },
    "Beneficiarios_Cargas": [
      {
        "Nombres": "",
        "Apellidos": "",
        "RUT": "",
        "Parentesco": ""
      }
    ],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados de Fonasa';

-- Certificados de Mutualidades
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Mutualidad",
    "Datos_Certificado": {
      "Numero_Certificado": "",
      "Fecha_Emision": ""
    },
    "Empresa_Afiliada": {
      "Razon_Social": "",
      "RUT": "",
      "Direccion": ""
    },
    "Mutualidad": {
      "Nombre_Mutualidad": "",
      "RUT": ""
    },
    "Informacion_Afiliacion": {
      "Numero_Patronal": "",
      "Fecha_Afiliacion": "",
      "Cobertura_Principal": "Seguro de Accidentes del Trabajo y Enfermedades Profesionales"
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados de Mutualidades';

-- Certificados de Seguro de Cesantía
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Seguro de Cesantía",
    "Datos_Certificado": {
      "Numero_Certificado": "",
      "Fecha_Emision": ""
    },
    "Afiliado": {
      "Nombres": "",
      "Apellidos": "",
      "RUT": ""
    },
    "AFC": {
      "Nombre_Institucion": "Administradora de Fondo de Cesantía (AFC)",
      "Numero_Afiliado": ""
    },
    "Informacion_Cesantia": {
      "Fecha_Afiliacion": "",
      "Saldo_Fondo_Solidario_CLP": "",
      "Saldo_Cuenta_Individual_CLP": "",
      "Cotizaciones_Registradas": []
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados de Seguro de Cesantía';

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
-- Update JSON schemas for Basic and Municipal Services Documents
-- =============================================================================

-- Boletas de Electricidad
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Boleta de Electricidad",
    "Datos_Emisor": {
      "Nombre_Empresa": "",
      "RUT_Empresa": ""
    },
    "Datos_Cliente": {
      "Nombre_Cliente": "",
      "RUT_Cliente": "",
      "Direccion_Suministro": "",
      "Numero_Cliente": ""
    },
    "Detalle_Consumo": {
      "Numero_Boleta": "",
      "Periodo_Facturacion": "",
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Lectura_Anterior_kWh": "",
      "Lectura_Actual_kWh": "",
      "Consumo_kWh": "",
      "Monto_Total_CLP": "",
      "Estado_Pago": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Boletas de Electricidad';

-- Boletas de Agua
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Boleta de Agua",
    "Datos_Emisor": {
      "Nombre_Empresa": "",
      "RUT_Empresa": ""
    },
    "Datos_Cliente": {
      "Nombre_Cliente": "",
      "RUT_Cliente": "",
      "Direccion_Suministro": "",
      "Numero_Cliente": ""
    },
    "Detalle_Consumo": {
      "Numero_Boleta": "",
      "Periodo_Facturacion": "",
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Lectura_Anterior_m3": "",
      "Lectura_Actual_m3": "",
      "Consumo_m3": "",
      "Monto_Total_CLP": "",
      "Estado_Pago": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Boletas de Agua';

-- Boletas de Gas
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Boleta de Gas",
    "Datos_Emisor": {
      "Nombre_Empresa": "",
      "RUT_Empresa": ""
    },
    "Datos_Cliente": {
      "Nombre_Cliente": "",
      "RUT_Cliente": "",
      "Direccion_Suministro": "",
      "Numero_Cliente": ""
    },
    "Detalle_Consumo": {
      "Numero_Boleta": "",
      "Periodo_Facturacion": "",
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Lectura_Anterior_m3": "",
      "Lectura_Actual_m3": "",
      "Consumo_m3": "",
      "Monto_Total_CLP": "",
      "Estado_Pago": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Boletas de Gas';

-- Boletas de Internet/TV
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Boleta de Internet/TV",
    "Datos_Emisor": {
      "Nombre_Empresa": "",
      "RUT_Empresa": ""
    },
    "Datos_Cliente": {
      "Nombre_Cliente": "",
      "RUT_Cliente": "",
      "Direccion_Suministro": "",
      "Numero_Cliente": ""
    },
    "Detalle_Servicio": {
      "Numero_Boleta": "",
      "Periodo_Facturacion": "",
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Plan_Contratado": "",
      "Monto_Total_CLP": "",
      "Estado_Pago": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Boletas de Internet/TV';

-- Boletas de Telefonía
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Boleta de Telefonía",
    "Datos_Emisor": {
      "Nombre_Empresa": "",
      "RUT_Empresa": ""
    },
    "Datos_Cliente": {
      "Nombre_Cliente": "",
      "RUT_Cliente": "",
      "Direccion_Suministro": "",
      "Numero_Cliente": ""
    },
    "Detalle_Servicio": {
      "Numero_Boleta": "",
      "Periodo_Facturacion": "",
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Numero_Telefono": "",
      "Plan_Contratado": "",
      "Monto_Total_CLP": "",
      "Estado_Pago": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Boletas de Telefonía';

-- Contribuciones
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Comprobante de Contribuciones",
    "Datos_Emisor": {
      "Nombre_Entidad": "Servicio de Impuestos Internos",
      "RUT_Entidad": "60.910.000-0"
    },
    "Datos_Propiedad": {
      "Rol_Avaluo": "",
      "Direccion_Propiedad": "",
      "Comuna": "",
      "Propietario": {
        "Nombre_Razon_Social": "",
        "RUT": ""
      }
    },
    "Detalle_Pago": {
      "Numero_Cuota": "",
      "Año_Tributario": "",
      "Fecha_Vencimiento": "",
      "Monto_Cuota_CLP": "",
      "Total_Adeudado_CLP": "",
      "Estado_Pago": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Contribuciones';

-- Patentes Municipales
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Patente Municipal",
    "Datos_Emisor": {
      "Nombre_Municipalidad": "",
      "RUT_Municipalidad": ""
    },
    "Datos_Contribuyente": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Direccion_Comercial": ""
    },
    "Detalle_Patente": {
      "Numero_Patente": "",
      "Tipo_Patente": "",
      "Giro_Actividad": "",
      "Periodo_Vigencia": "",
      "Monto_Pago_CLP": "",
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Estado_Pago": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Patentes Municipales';

-- Permisos Municipales
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Permiso Municipal",
    "Datos_Emisor": {
      "Nombre_Municipalidad": "",
      "RUT_Municipalidad": ""
    },
    "Datos_Solicitante": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Direccion": ""
    },
    "Detalle_Permiso": {
      "Numero_Permiso": "",
      "Tipo_Permiso": "",
      "Descripcion_Actividad_Permitida": "",
      "Fecha_Otorgamiento": "",
      "Fecha_Vencimiento": "",
      "Monto_Derechos_CLP": "",
      "Condiciones_Especiales": []
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Permisos Municipales';

-- Derechos de Aseo
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Comprobante de Derechos de Aseo",
    "Datos_Emisor": {
      "Nombre_Municipalidad": "",
      "RUT_Municipalidad": ""
    },
    "Datos_Propiedad": {
      "Direccion_Propiedad": "",
      "Rol_Avaluo": "",
      "Propietario": {
        "Nombre_Razon_Social": "",
        "RUT": ""
      }
    },
    "Detalle_Pago": {
      "Periodo_Facturacion": "",
      "Numero_Cuota": "",
      "Fecha_Vencimiento": "",
      "Monto_Total_CLP": "",
      "Estado_Pago": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Derechos de Aseo';

-- Certificados Municipales
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado Municipal",
    "Datos_Emisor": {
      "Nombre_Municipalidad": "",
      "RUT_Municipalidad": ""
    },
    "Datos_Solicitante": {
      "Nombre_Razon_Social": "",
      "RUT": ""
    },
    "Detalle_Certificado": {
      "Tipo_Certificado": "",
      "Numero_Certificado": "",
      "Fecha_Emision": "",
      "Contenido_Certificado": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados Municipales';

-- Permisos de Circulación
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Permiso de Circulación",
    "Datos_Emisor": {
      "Nombre_Municipalidad": "",
      "RUT_Municipalidad": ""
    },
    "Datos_Vehiculo": {
      "Tipo_Vehiculo": "",
      "Patente": "",
      "Marca": "",
      "Modelo": "",
      "Año": "",
      "Numero_Motor": "",
      "Numero_Chasis": ""
    },
    "Datos_Propietario": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Direccion": ""
    },
    "Detalle_Permiso": {
      "Año_Vigencia": "",
      "Monto_Pago_CLP": "",
      "Fecha_Vencimiento": "",
      "Estado_Pago": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Permisos de Circulación';

-- Contratos de Servicios
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Contrato de Servicios",
    "Datos_Contrato": {
      "Numero_Contrato": "",
      "Fecha_Celebracion": "",
      "Tipo_Servicio": "",
      "Periodo_Contrato": {
        "Inicio": "",
        "Fin": ""
      }
    },
    "Proveedor_Servicio": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Direccion": ""
    },
    "Cliente": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Direccion": ""
    },
    "Clausulas_Principales": {
      "Descripcion_Servicio": "",
      "Tarifa_Monto_CLP": "",
      "Condiciones_Pago": "",
      "Condiciones_Renovacion": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Contratos de Servicios';

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
-- Update JSON schemas for Human Resources Documents
-- =============================================================================

-- Currículum Vitae
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Currículum Vitae",
    "Datos_Personales": {
      "Nombres": "",
      "Apellidos": "",
      "RUT": "",
      "Fecha_Nacimiento": "",
      "Nacionalidad": "",
      "Email": "",
      "Telefono": "",
      "Direccion": ""
    },
    "Experiencia_Laboral": [
      {
        "Cargo": "",
        "Empresa": "",
        "Fecha_Inicio": "",
        "Fecha_Fin": "",
        "Funciones_Logros": []
      }
    ],
    "Educacion": [
      {
        "Titulo": "",
        "Institucion": "",
        "Fecha_Inicio": "",
        "Fecha_Fin": ""
      }
    ],
    "Habilidades": [],
    "Idiomas": [
      {
        "Idioma": "",
        "Nivel": ""
      }
    ],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Currículum Vitae';

-- Evaluaciones de Desempeño
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Evaluación de Desempeño",
    "Datos_Generales": {
      "Periodo_Evaluacion": "",
      "Fecha_Evaluacion": "",
      "Tipo_Evaluacion": ""
    },
    "Empleado": {
      "Nombres": "",
      "Apellidos": "",
      "RUT": "",
      "Cargo": "",
      "Departamento": ""
    },
    "Evaluador": {
      "Nombres": "",
      "Apellidos": "",
      "Cargo": ""
    },
    "Areas_Evaluadas": [
      {
        "Area": "",
        "Puntaje_Calificacion": "",
        "Comentarios": ""
      }
    ],
    "Fortalezas": [],
    "Areas_Mejora": [],
    "Plan_Accion": {
      "Objetivos": [],
      "Fechas_Seguimiento": []
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Evaluaciones de Desempeño';

-- Perfiles de Cargo
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Perfil de Cargo",
    "Identificacion_Cargo": {
      "Nombre_Cargo": "",
      "Departamento": "",
      "Reporta_A": "",
      "Numero_Vacantes": ""
    },
    "Objetivo_Cargo": "",
    "Funciones_Principales": [],
    "Requisitos": {
      "Educacion": [],
      "Experiencia": "",
      "Habilidades_Tecnicas": [],
      "Habilidades_Blandas": []
    },
    "Condiciones_Laborales": {
      "Tipo_Contrato": "",
      "Jornada_Laboral": "",
      "Lugar_Trabajo": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Perfiles de Cargo';

-- Manuales de Procedimientos
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Manual de Procedimientos",
    "Datos_Generales": {
      "Titulo_Manual": "",
      "Codigo_Manual": "",
      "Version": "",
      "Fecha_Emision": "",
      "Fecha_Ultima_Revision": ""
    },
    "Alcance": "",
    "Responsables": [],
    "Lista_Procedimientos": [
      {
        "Nombre_Procedimiento": "",
        "Codigo_Procedimiento": "",
        "Descripcion_Breve": ""
      }
    ],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Manuales de Procedimientos';

-- Políticas Internas
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Política Interna",
    "Datos_Generales": {
      "Titulo_Politica": "",
      "Codigo_Politica": "",
      "Version": "",
      "Fecha_Emision": "",
      "Fecha_Ultima_Revision": ""
    },
    "Objetivo_Politica": "",
    "Alcance": "",
    "Cuerpo_Politica": "",
    "Responsabilidades": [],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Políticas Internas';

-- Planes de Capacitación
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Plan de Capacitación",
    "Datos_Plan": {
      "Nombre_Plan": "",
      "Año_Periodo": "",
      "Fecha_Elaboracion": ""
    },
    "Objetivo_General": "",
    "Poblacion_Objetivo": {
      "Departamentos": [],
      "Cargos": []
    },
    "Actividades_Capacitacion": [
      {
        "Nombre_Curso_Taller": "",
        "Modalidad": "",
        "Duracion_Horas": "",
        "Proveedor_Capacitacion": "",
        "Fechas_Programadas": []
      }
    ],
    "Presupuesto_Asignado": {
      "Monto_CLP": "",
      "Moneda": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Planes de Capacitación';

-- Certificados de Capacitación
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Capacitación",
    "Datos_Certificado": {
      "Numero_Certificado": "",
      "Fecha_Emision": "",
      "Nombre_Curso": "",
      "Duracion_Horas": "",
      "Fecha_Inicio_Curso": "",
      "Fecha_Fin_Curso": ""
    },
    "Participante": {
      "Nombres": "",
      "Apellidos": "",
      "RUT": "",
      "Empresa": ""
    },
    "Institucion_Capacitadora": {
      "Nombre": "",
      "RUT": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados de Capacitación';

-- Registro de Vacaciones
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Registro de Vacaciones",
    "Datos_Generales": {
      "Año_Registro": ""
    },
    "Empleado": {
      "Nombres": "",
      "Apellidos": "",
      "RUT": "",
      "Fecha_Ingreso": ""
    },
    "Detalle_Vacaciones": [
      {
        "Periodo_Correspondiente": "",
        "Dias_Disponibles": "",
        "Dias_Tomados": "",
        "Saldo_Dias": "",
        "Fechas_Tomadas": []
      }
    ],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Registro de Vacaciones';

-- Comunicaciones Internas
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Comunicación Interna",
    "Datos_Generales": {
      "Tipo_Comunicacion": "",
      "Numero_Comunicacion": "",
      "Fecha_Emision": "",
      "Asunto": ""
    },
    "Remitente": {
      "Area_Departamento": "",
      "Nombre_Autor": ""
    },
    "Destinatarios": {
      "Grupos_Empleados": [],
      "Departamentos": []
    },
    "Contenido_Resumen": "",
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Comunicaciones Internas';

-- Expedientes de Personal
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Expediente de Personal",
    "Datos_Empleado": {
      "Nombres": "",
      "Apellidos": "",
      "RUT": "",
      "Fecha_Nacimiento": "",
      "Nacionalidad": "",
      "Fecha_Ingreso": "",
      "Cargo_Actual": "",
      "Departamento": "",
      "Estado_Laboral": ""
    },
    "Documentos_Adjuntos": [
      {
        "Tipo_Documento_Adjunto": "",
        "Fecha_Documento": "",
        "Descripcion": ""
      }
    ],
    "Historial_Laboral": [
      {
        "Cargo": "",
        "Fecha_Inicio": "",
        "Fecha_Fin": "",
        "Observaciones": ""
      }
    ],
    "Informacion_Contacto": {
      "Email_Corporativo": "",
      "Telefono_Corporativo": "",
      "Contacto_Emergencia": {
        "Nombre": "",
        "Telefono": "",
        "Parentesco": ""
      }
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Expedientes de Personal';

-- Contratos con Proveedores RRHH
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Contrato con Proveedor RRHH",
    "Datos_Contrato": {
      "Numero_Contrato": "",
      "Fecha_Celebracion": "",
      "Servicio_Contratado": "",
      "Periodo_Vigencia": {
        "Inicio": "",
        "Fin": ""
      },
      "Monto_Total_CLP": "",
      "Moneda": ""
    },
    "Empresa_Contratante": {
      "Nombre_Razon_Social": "",
      "RUT": ""
    },
    "Proveedor_RRHH": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Direccion": "",
      "Contacto": ""
    },
    "Clausulas_Especificas": [],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Contratos con Proveedores RRHH';

-- Acuerdos de Confidencialidad
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Acuerdo de Confidencialidad (NDA)",
    "Datos_Acuerdo": {
      "Numero_Acuerdo": "",
      "Fecha_Acuerdo": "",
      "Partes_Involucradas": []
    },
    "Parte_Reveladora": {
      "Nombre_Razon_Social": "",
      "RUT": ""
    },
    "Parte_Receptora": {
      "Nombre_Razon_Social": "",
      "RUT": ""
    },
    "Informacion_Confidencial_Definicion": "",
    "Vigencia_Acuerdo": "",
    "Clausulas_Penales": "",
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Acuerdos de Confidencialidad';

-- Documentos de Inducción
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Documento de Inducción",
    "Datos_Generales": {
      "Titulo_Documento": "",
      "Version": "",
      "Fecha_Emision": "",
      "Dirigido_A": ""
    },
    "Contenido_Induccion": {
      "Bienvenida_Empresa": "",
      "Vision_Mision_Valores": "",
      "Organigrama": "",
      "Beneficios_Corporativos": [],
      "Politicas_Clave": [],
      "Recursos_Utiles": []
    },
    "Informacion_Contacto_RRHH": {
      "Nombre": "",
      "Email": "",
      "Telefono": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Documentos de Inducción';

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
-- Update JSON schemas for Accounting and Financial Documents
-- =============================================================================

-- Libros Contables
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Libro Contable",
    "Datos_Empresa": {
      "Razon_Social": "",
      "RUT": ""
    },
    "Datos_Libro": {
      "Nombre_Libro": "",
      "Tipo_Libro": "",
      "Periodo_Contable": "",
      "Folio_Inicial": "",
      "Folio_Final": ""
    },
    "Detalle_Movimientos": [
      {
        "Fecha": "",
        "Numero_Asiento": "",
        "Glosa": "",
        "Cuenta_Debe": "",
        "Monto_Debe": "",
        "Cuenta_Haber": "",
        "Monto_Haber": ""
      }
    ],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Libros Contables';

-- Balances
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Balance",
    "Datos_Empresa": {
      "Razon_Social": "",
      "RUT": ""
    },
    "Datos_Balance": {
      "Fecha_Corte": "",
      "Tipo_Balance": "General",
      "Moneda": ""
    },
    "Activos": {
      "Activo_Circulante": [
        {
          "Cuenta": "",
          "Monto": ""
        }
      ],
      "Activo_No_Circulante": [
        {
          "Cuenta": "",
          "Monto": ""
        }
      ],
      "Total_Activos": ""
    },
    "Pasivos_Patrimonio": {
      "Pasivo_Circulante": [
        {
          "Cuenta": "",
          "Monto": ""
        }
      ],
      "Pasivo_No_Circulante": [
        {
          "Cuenta": "",
          "Monto": ""
        }
      ],
      "Patrimonio": [
        {
          "Cuenta": "",
          "Monto": ""
        }
      ],
      "Total_Pasivos_Patrimonio": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Balances';

-- Estados de Resultados
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Estado de Resultados",
    "Datos_Empresa": {
      "Razon_Social": "",
      "RUT": ""
    },
    "Datos_Estado": {
      "Periodo_Informe": "",
      "Fecha_Emision": "",
      "Moneda": ""
    },
    "Ingresos": [
      {
        "Concepto": "",
        "Monto": ""
      }
    ],
    "Costos": [
      {
        "Concepto": "",
        "Monto": ""
      }
    ],
    "Gastos_Operacionales": [
      {
        "Concepto": "",
        "Monto": ""
      }
    ],
    "Resultados": {
      "Utilidad_Bruta": "",
      "Utilidad_Operacional": "",
      "Utilidad_Antes_Impuestos": "",
      "Impuesto_a_la_Renta": "",
      "Utilidad_Neta": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Estados de Resultados';

-- Flujos de Caja
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Flujo de Caja",
    "Datos_Empresa": {
      "Razon_Social": "",
      "RUT": ""
    },
    "Datos_Flujo": {
      "Periodo_Informe": "",
      "Fecha_Emision": "",
      "Moneda": ""
    },
    "Actividades_Operacion": [
      {
        "Concepto": "",
        "Monto": ""
      }
    ],
    "Actividades_Inversion": [
      {
        "Concepto": "",
        "Monto": ""
      }
    ],
    "Actividades_Financiamiento": [
      {
        "Concepto": "",
        "Monto": ""
      }
    ],
    "Resumen_Flujo": {
      "Flujo_Neto_Periodo": "",
      "Saldo_Inicial_Caja": "",
      "Saldo_Final_Caja": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Flujos de Caja';

-- Presupuestos
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Presupuesto",
    "Datos_Empresa": {
      "Razon_Social": "",
      "RUT": ""
    },
    "Datos_Presupuesto": {
      "Año_Presupuestado": "",
      "Fecha_Elaboracion": "",
      "Moneda": ""
    },
    "Presupuesto_Ingresos": [
      {
        "Concepto": "",
        "Monto_Estimado": ""
      }
    ],
    "Presupuesto_Gastos": [
      {
        "Concepto": "",
        "Monto_Estimado": ""
      }
    ],
    "Presupuesto_Inversiones": [
      {
        "Concepto": "",
        "Monto_Estimado": ""
      }
    ],
    "Resumen_Presupuesto": {
      "Total_Ingresos_Estimados": "",
      "Total_Gastos_Estimados": "",
      "Resultado_Estimado": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Presupuestos';

-- Libros de Honorarios
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Libro de Honorarios",
    "Datos_Empresa": {
      "Razon_Social": "",
      "RUT": ""
    },
    "Datos_Libro": {
      "Periodo_Registro": "",
      "Fecha_Emision": ""
    },
    "Detalle_Honorarios": [
      {
        "Numero_Boleta": "",
        "Fecha_Emision_Boleta": "",
        "Rut_Emisor": "",
        "Nombre_Emisor": "",
        "Monto_Bruto_CLP": "",
        "Monto_Retencion_CLP": "",
        "Monto_Liquido_CLP": ""
      }
    ],
    "Totales": {
      "Total_Bruto_Periodo": "",
      "Total_Retenciones_Periodo": "",
      "Total_Liquido_Periodo": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Libros de Honorarios';

-- Libros de Remuneraciones
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Libro de Remuneraciones",
    "Datos_Empresa": {
      "Razon_Social": "",
      "RUT": ""
    },
    "Datos_Libro": {
      "Mes_Año": "",
      "Fecha_Emision": ""
    },
    "Detalle_Remuneraciones": [
      {
        "RUT_Empleado": "",
        "Nombre_Empleado": "",
        "Sueldo_Base_CLP": "",
        "Bonificaciones_CLP": "",
        "Descuentos_Legales_CLP": "",
        "Monto_Liquido_CLP": ""
      }
    ],
    "Totales": {
      "Total_Sueldos_Base": "",
      "Total_Bonificaciones": "",
      "Total_Descuentos": "",
      "Total_Liquido_a_Pagar": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Libros de Remuneraciones';

-- Informes de Auditoría
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Informe de Auditoría",
    "Datos_Generales": {
      "Numero_Informe": "",
      "Fecha_Emision": "",
      "Periodo_Auditado": ""
    },
    "Entidad_Auditada": {
      "Razon_Social": "",
      "RUT": ""
    },
    "Firma_Auditora": {
      "Nombre_Firma": "",
      "RUT": "",
      "Socio_Auditor": ""
    },
    "Opinion_Auditoria": {
      "Tipo_Opinion": "",
      "Fundamentacion": ""
    },
    "Hallazgos_Recomendaciones": [
      {
        "Hallazgo": "",
        "Riesgo_Asociado": "",
        "Recomendacion": ""
      }
    ],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Informes de Auditoría';

-- Declaraciones Juradas
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Declaración Jurada",
    "Datos_Generales": {
      "Tipo_Declaracion_Jurada": "",
      "Año_Tributario": "",
      "Fecha_Presentacion": ""
    },
    "Declarante": {
      "Razon_Social": "",
      "RUT": ""
    },
    "Informacion_Declarada": {},
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Declaraciones Juradas';

-- Plan de Cuentas
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Plan de Cuentas",
    "Datos_Empresa": {
      "Razon_Social": "",
      "RUT": ""
    },
    "Datos_Plan": {
      "Version": "",
      "Fecha_Creacion": "",
      "Fecha_Ultima_Modificacion": ""
    },
    "Cuentas": [
      {
        "Codigo_Cuenta": "",
        "Nombre_Cuenta": "",
        "Tipo_Cuenta": "",
        "Naturaleza_Saldo": ""
      }
    ],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Plan de Cuentas';

-- Comprobantes Contables
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Comprobante Contable",
    "Datos_Comprobante": {
      "Numero_Comprobante": "",
      "Fecha_Comprobante": "",
      "Tipo_Comprobante": "",
      "Glosa_General": ""
    },
    "Asientos_Contables": [
      {
        "Cuenta": "",
        "Debe": "",
        "Haber": "",
        "Glosa_Detalle": ""
      }
    ],
    "Documentos_Asociados": [
      {
        "Tipo_Documento": "",
        "Numero_Documento": "",
        "Fecha_Documento": ""
      }
    ],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Comprobantes Contables';

-- Informes Financieros
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Informe Financiero",
    "Datos_Empresa": {
      "Razon_Social": "",
      "RUT": ""
    },
    "Datos_Informe": {
      "Titulo_Informe": "",
      "Periodo_Reportado": "",
      "Fecha_Emision": "",
      "Moneda": ""
    },
    "Componentes_Principales": [
      {
        "Nombre_Componente": "",
        "Resumen_Ejecutivo": ""
      }
    ],
    "Analisis_Financiero": {
      "Liquidez": "",
      "Rentabilidad": "",
      "Endeudamiento": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Informes Financieros';

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
-- Update JSON schemas for Vehicle and Transportation Documents
-- =============================================================================

-- Permisos de Circulación
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Permiso de Circulación",
    "Datos_Vehiculo": {
      "Patente": "",
      "Marca": "",
      "Modelo": "",
      "Año": "",
      "Numero_Chasis": "",
      "Tipo_Vehiculo": ""
    },
    "Datos_Propietario": {
      "Nombre_Completo": "",
      "RUT": "",
      "Direccion": ""
    },
    "Detalle_Permiso": {
      "Año_Vigencia": "",
      "Monto_Pagado_CLP": "",
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Municipalidad_Emisora": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Permisos de Circulación';

-- Revisiones Técnicas
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Revisión Técnica",
    "Datos_Vehiculo": {
      "Patente": "",
      "Marca": "",
      "Modelo": "",
      "Año": "",
      "Tipo_Vehiculo": ""
    },
    "Datos_Revision": {
      "Numero_Certificado": "",
      "Planta_Revision_Tecnica": "",
      "Fecha_Revision": "",
      "Fecha_Vencimiento": "",
      "Resultado_Revision": "Aprobada / Rechazada / Rechazada con observaciones",
      "Kilometraje": ""
    },
    "Observaciones_Tecnicas": [],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Revisiones Técnicas';

-- SOAP
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "SOAP (Seguro Obligatorio de Accidentes Personales)",
    "Datos_Vehiculo": {
      "Patente": "",
      "Marca": "",
      "Modelo": "",
      "Año": ""
    },
    "Datos_Poliza": {
      "Numero_Poliza": "",
      "Aseguradora": "",
      "Periodo_Vigencia": {
        "Inicio": "",
        "Fin": ""
      },
      "Monto_Prima_CLP": ""
    },
    "Datos_Propietario": {
      "Nombre_Completo": "",
      "RUT": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'SOAP';

-- Seguros Vehiculares
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Póliza de Seguro Vehicular",
    "Datos_Vehiculo": {
      "Patente": "",
      "Marca": "",
      "Modelo": "",
      "Año": "",
      "Numero_Motor": "",
      "Numero_Chasis": ""
    },
    "Datos_Poliza": {
      "Numero_Poliza": "",
      "Aseguradora": "",
      "Tipo_Seguro": "Responsabilidad Civil / Daños Propios / Cobertura Completa",
      "Fecha_Emision": "",
      "Fecha_Inicio_Vigencia": "",
      "Fecha_Fin_Vigencia": "",
      "Prima_Anual_CLP": "",
      "Deducible_CLP": ""
    },
    "Datos_Asegurado": {
      "Nombre_Completo": "",
      "RUT": "",
      "Direccion": ""
    },
    "Coberturas": [],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Seguros Vehiculares';

-- Certificados de Homologación
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Homologación",
    "Datos_Vehiculo": {
      "Marca": "",
      "Modelo": "",
      "Año_Modelo": "",
      "Tipo_Vehiculo": "",
      "Numero_Serie_VIN": ""
    },
    "Datos_Certificado": {
      "Numero_Certificado": "",
      "Fecha_Emision": "",
      "Autoridad_Emisora": "",
      "Normativa_Aplicada": ""
    },
    "Especificaciones_Tecnicas_Homologadas": {
      "Emisiones_CO2_gr_km": "",
      "Consumo_Combustible_km_l": "",
      "Nivel_Ruido_dB": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados de Homologación';

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
-- Update JSON schemas for Restaurants and Gastronomy Documents
-- =============================================================================

-- Carta de Comidas
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Carta de Comidas",
    "Datos_Establecimiento": {
      "Nombre_Local": "",
      "RUT_Local": "",
      "Direccion_Local": ""
    },
    "Detalle_Menu": [
      {
        "Categoria": "",
        "Platos": [
          {
            "Nombre_Plato": "",
            "Descripcion": "",
            "Precio_CLP": "",
            "Alergenos": [],
            "Vegetariano_Vegano": false
          }
        ]
      }
    ],
    "Informacion_Adicional": {
      "Fecha_Creacion_Menu": "",
      "Fecha_Ultima_Revision": "",
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Carta de Comidas';

-- Carta de Bebidas
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Carta de Bebidas",
    "Datos_Establecimiento": {
      "Nombre_Local": "",
      "RUT_Local": "",
      "Direccion_Local": ""
    },
    "Detalle_Menu_Bebidas": [
      {
        "Categoria": "",
        "Bebidas": [
          {
            "Nombre_Bebida": "",
            "Tipo_Bebida": "",
            "Precio_CLP": "",
            "Volumen_ml_o_cc": "",
            "Graduacion_Alcoholica": ""
          }
        ]
      }
    ],
    "Informacion_Adicional": {
      "Fecha_Creacion_Menu": "",
      "Fecha_Ultima_Revision": "",
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Carta de Bebidas';

-- Permiso Sanitario
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Permiso Sanitario",
    "Datos_Establecimiento": {
      "Nombre_Local": "",
      "Razon_Social": "",
      "RUT_Local": "",
      "Direccion_Local": "",
      "Tipo_Establecimiento": ""
    },
    "Detalle_Permiso": {
      "Numero_Permiso_Sanitario": "",
      "Autoridad_Sanitaria_Emisora": "",
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Alcance_Permiso": ""
    },
    "Informacion_Adicional": {
      "Condiciones_Especiales": [],
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Permiso Sanitario';

-- Certificado de Manipulación de Alimentos
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Manipulación de Alimentos",
    "Datos_Manipulador": {
      "Nombre_Completo": "",
      "RUT": ""
    },
    "Detalle_Certificado": {
      "Numero_Certificado": "",
      "Institucion_Emisora": "",
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Tipo_Curso_Capacitacion": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificado de Manipulación de Alimentos';

-- Libro de Reclamos
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Libro de Reclamos",
    "Datos_Establecimiento": {
      "Nombre_Local": "",
      "RUT_Local": "",
      "Direccion_Local": ""
    },
    "Detalle_Registro": [
      {
        "Numero_Reclamo": "",
        "Fecha_Reclamo": "",
        "Datos_Cliente": {
          "Nombre": "",
          "RUT_o_ID": "",
          "Contacto": ""
        },
        "Descripcion_Reclamo": "",
        "Acciones_Tomadas": "",
        "Fecha_Resolucion": "",
        "Estado_Reclamo": "Pendiente / Resuelto / Cerrado"
      }
    ],
    "Informacion_Adicional": {
      "Periodo_Cubre": "",
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Libro de Reclamos';

-- Control de Temperaturas
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Registro de Control de Temperaturas",
    "Datos_Establecimiento": {
      "Nombre_Local": "",
      "RUT_Local": ""
    },
    "Puntos_Control": [
      {
        "Ubicacion_Equipo": "",
        "Tipo_Equipo_Alimento": "",
        "Registros": [
          {
            "Fecha_Hora": "",
            "Temperatura_Celsius": "",
            "Responsable": "",
            "Accion_Correctiva_si_aplica": ""
          }
        ]
      }
    ],
    "Informacion_Adicional": {
      "Periodo_Registro": "",
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Control de Temperaturas';

-- Control de Plagas
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Registro de Control de Plagas",
    "Datos_Establecimiento": {
      "Nombre_Local": "",
      "RUT_Local": ""
    },
    "Empresa_Controladora": {
      "Nombre_Empresa": "",
      "RUT_Empresa": "",
      "Contacto": ""
    },
    "Detalle_Controles": [
      {
        "Fecha_Servicio": "",
        "Tipo_Servicio": "",
        "Areas_Tratadas": [],
        "Productos_Utilizados": [],
        "Certificado_Asociado": "",
        "Proxima_Fecha_Programada": ""
      }
    ],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Control de Plagas';

-- Horarios de Atención
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Horarios de Atención",
    "Datos_Establecimiento": {
      "Nombre_Local": "",
      "RUT_Local": "",
      "Direccion_Local": ""
    },
    "Horarios_Detallados": [
      {
        "Dia_Semana": "Lunes",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Martes",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Miércoles",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Jueves",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Viernes",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Sábado",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Domingo",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      }
    ],
    "Informacion_Adicional": {
      "Fechas_Especiales_Feriados": [],
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Horarios de Atención';

-- Contrato con Proveedores de Insumos
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Contrato con Proveedor de Insumos",
    "Datos_Contrato": {
      "Numero_Contrato": "",
      "Fecha_Celebracion": "",
      "Tipo_Insumo": "",
      "Periodo_Vigencia": {
        "Inicio": "",
        "Fin": ""
      }
    },
    "Restaurante": {
      "Nombre_Local": "",
      "RUT_Local": ""
    },
    "Proveedor": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Contacto": ""
    },
    "Condiciones_Comerciales": {
      "Precios": "",
      "Forma_Pago": "",
      "Plazos_Entrega": ""
    },
    "Informacion_Adicional": {
      "Clausulas_Especiales": [],
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Contrato con Proveedores de Insumos';

-- Certificados de Origen de Alimentos
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Origen de Alimentos",
    "Datos_Producto": {
      "Nombre_Producto": "",
      "Categoria_Alimento": "",
      "Lote_Serie": "",
      "Fecha_Elaboracion_Empaque": ""
    },
    "Origen": {
      "Pais_Origen": "",
      "Region_Origen": "",
      "Productor_Emisor": {
        "Nombre_Razon_Social": "",
        "RUT": ""
      }
    },
    "Detalle_Certificacion": {
      "Numero_Certificado": "",
      "Organismo_Certificador": "",
      "Fecha_Emision": "",
      "Estandares_Cumplidos": []
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados de Origen de Alimentos';

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
-- Update JSON schemas for Retail and Minor Commerce Documents
-- =============================================================================

-- Libro de Reclamos
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Libro de Reclamos",
    "Datos_Establecimiento": {
      "Nombre_Comercio": "",
      "RUT_Comercio": "",
      "Direccion_Comercio": ""
    },
    "Detalle_Registro": [
      {
        "Numero_Reclamo": "",
        "Fecha_Reclamo": "",
        "Datos_Cliente": {
          "Nombre": "",
          "RUT_o_ID": "",
          "Contacto": ""
        },
        "Descripcion_Reclamo": "",
        "Acciones_Tomadas": "",
        "Fecha_Resolucion": "",
        "Estado_Reclamo": "Pendiente / Resuelto / Cerrado"
      }
    ],
    "Informacion_Adicional": {
      "Periodo_Cubre": "",
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Libro de Reclamos';

-- Permiso de Funcionamiento
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Permiso de Funcionamiento Municipal",
    "Datos_Establecimiento": {
      "Nombre_Comercio": "",
      "Razon_Social": "",
      "RUT_Comercio": "",
      "Direccion_Comercio": "",
      "Tipo_Actividad_Comercial": ""
    },
    "Detalle_Permiso": {
      "Numero_Permiso": "",
      "Municipalidad_Emisora": "",
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Condiciones_Especiales": []
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Permiso de Funcionamiento';

-- Libro de Inventario
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Libro de Inventario",
    "Datos_Establecimiento": {
      "Nombre_Comercio": "",
      "RUT_Comercio": ""
    },
    "Detalle_Inventario": [
      {
        "Fecha_Inventario": "",
        "Periodo_Inventario": "",
        "Items_Inventariados": [
          {
            "Codigo_Producto": "",
            "Nombre_Producto": "",
            "Cantidad_Existencia": "",
            "Unidad_Medida": "",
            "Costo_Unitario_CLP": "",
            "Valor_Total_CLP": ""
          }
        ],
        "Valor_Total_Inventario_CLP": ""
      }
    ],
    "Informacion_Adicional": {
      "Responsable_Inventario": "",
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Libro de Inventario';

-- Contratos con Proveedores
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Contrato con Proveedor",
    "Datos_Contrato": {
      "Numero_Contrato": "",
      "Fecha_Celebracion": "",
      "Objeto_Contrato": "",
      "Periodo_Vigencia": {
        "Inicio": "",
        "Fin": ""
      }
    },
    "Comercio_Minorista": {
      "Nombre_Razon_Social": "",
      "RUT": ""
    },
    "Proveedor": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Contacto": ""
    },
    "Condiciones_Comerciales": {
      "Productos_Servicios_Contratados": [],
      "Precios": "",
      "Forma_Pago": "",
      "Plazos_Entrega": ""
    },
    "Informacion_Adicional": {
      "Clausulas_Especiales": [],
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Contratos con Proveedores';

-- Certificados de Garantía
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Garantía",
    "Datos_Producto": {
      "Nombre_Producto": "",
      "Marca": "",
      "Modelo": "",
      "Numero_Serie": "",
      "Fecha_Compra": "",
      "Precio_Compra_CLP": ""
    },
    "Datos_Vendedor": {
      "Nombre_Comercio": "",
      "RUT_Comercio": ""
    },
    "Datos_Cliente": {
      "Nombre_Completo": "",
      "RUT": "",
      "Contacto": ""
    },
    "Detalle_Garantia": {
      "Periodo_Garantia_Meses": "",
      "Tipo_Garantia": "Fabricante / Tienda",
      "Condiciones_Exclusiones": []
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados de Garantía';

-- Horarios de Atención
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Horarios de Atención",
    "Datos_Establecimiento": {
      "Nombre_Comercio": "",
      "RUT_Comercio": "",
      "Direccion_Comercio": ""
    },
    "Horarios_Detallados": [
      {
        "Dia_Semana": "Lunes",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Martes",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Miércoles",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Jueves",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Viernes",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Sábado",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Domingo",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      }
    ],
    "Informacion_Adicional": {
      "Fechas_Especiales_Feriados": [],
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Horarios de Atención';

-- Certificados de Seguridad
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Seguridad",
    "Datos_Establecimiento": {
      "Nombre_Comercio": "",
      "RUT_Comercio": "",
      "Direccion_Comercio": ""
    },
    "Detalle_Certificado": {
      "Tipo_Certificado": "",
      "Numero_Certificado": "",
      "Autoridad_Emisora": "",
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Normas_Cumplidas": []
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados de Seguridad';

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
-- Update JSON schemas for Hospitality and Tourism Documents
-- =============================================================================

-- Registro de Huéspedes
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Registro de Huéspedes",
    "Datos_Establecimiento": {
      "Nombre_Establecimiento": "",
      "RUT_Establecimiento": "",
      "Tipo_Establecimiento": ""
    },
    "Huespedes_Registrados": [
      {
        "Numero_Registro": "",
        "Fecha_Ingreso": "",
        "Fecha_Salida_Estimada": "",
        "Fecha_Salida_Real": "",
        "Datos_Huesped_Principal": {
          "Nombre_Completo": "",
          "RUT_o_Pasaporte": "",
          "Nacionalidad": "",
          "Email": "",
          "Telefono": ""
        },
        "Acompañantes": [],
        "Numero_Habitacion_Servicio": "",
        "Tarifa_Pagada_CLP": "",
        "Observaciones_Estadia": ""
      }
    ],
    "Informacion_Adicional": {
      "Periodo_Registro": "",
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Registro de Huéspedes';

-- Permiso de Funcionamiento
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Permiso de Funcionamiento Municipal",
    "Datos_Establecimiento": {
      "Nombre_Establecimiento": "",
      "Razon_Social": "",
      "RUT_Establecimiento": "",
      "Direccion_Establecimiento": "",
      "Tipo_Actividad_Principal": ""
    },
    "Detalle_Permiso": {
      "Numero_Permiso": "",
      "Municipalidad_Emisora": "",
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Condiciones_Especiales": []
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Permiso de Funcionamiento';

-- Certificado Sernatur
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado Sernatur",
    "Datos_Prestador_Turistico": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Direccion": "",
      "Tipo_Servicio_Turistico": ""
    },
    "Detalle_Certificado": {
      "Numero_Registro_Sernatur": "",
      "Fecha_Inscripcion": "",
      "Fecha_Vencimiento": "",
      "Categorizacion_Sernatur": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificado Sernatur';

-- Libro de Reclamos
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Libro de Reclamos",
    "Datos_Establecimiento": {
      "Nombre_Establecimiento": "",
      "RUT_Establecimiento": "",
      "Direccion_Establecimiento": ""
    },
    "Detalle_Registro": [
      {
        "Numero_Reclamo": "",
        "Fecha_Reclamo": "",
        "Datos_Cliente": {
          "Nombre": "",
          "RUT_o_ID": "",
          "Contacto": ""
        },
        "Descripcion_Reclamo": "",
        "Acciones_Tomadas": "",
        "Fecha_Resolucion": "",
        "Estado_Reclamo": "Pendiente / Resuelto / Cerrado"
      }
    ],
    "Informacion_Adicional": {
      "Periodo_Cubre": "",
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Libro de Reclamos';

-- Contratos con Agencias
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Contrato con Agencia de Viajes/Tour Operador",
    "Datos_Contrato": {
      "Numero_Contrato": "",
      "Fecha_Celebracion": "",
      "Objeto_Contrato": "",
      "Periodo_Vigencia": {
        "Inicio": "",
        "Fin": ""
      }
    },
    "Prestador_Servicio": {
      "Nombre_Establecimiento": "",
      "RUT_Establecimiento": ""
    },
    "Agencia_Tour_Operador": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Contacto": ""
    },
    "Condiciones_Comerciales": {
      "Servicios_Acordados": [],
      "Comisiones_Tarifas": "",
      "Forma_Pago": "",
      "Clausulas_Cancelacion": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Contratos con Agencias';

-- Certificados de Seguridad
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Seguridad",
    "Datos_Establecimiento": {
      "Nombre_Establecimiento": "",
      "RUT_Establecimiento": "",
      "Direccion_Establecimiento": ""
    },
    "Detalle_Certificado": {
      "Tipo_Certificado": "",
      "Numero_Certificado": "",
      "Autoridad_Emisora": "",
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Normas_Cumplidas": []
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados de Seguridad';

-- Horarios de Atención
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Horarios de Atención",
    "Datos_Establecimiento": {
      "Nombre_Establecimiento": "",
      "RUT_Establecimiento": "",
      "Direccion_Establecimiento": ""
    },
    "Horarios_Detallados": [
      {
        "Dia_Semana": "Lunes",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Martes",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Miércoles",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Jueves",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Viernes",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Sábado",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      },
      {
        "Dia_Semana": "Domingo",
        "Horario_Apertura": "",
        "Horario_Cierre": "",
        "Cerrado": false
      }
    ],
    "Informacion_Adicional": {
      "Fechas_Especiales_Feriados": [],
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Horarios de Atención';

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

-- =============================================================================
-- Update JSON schemas for Transportation and Logistics Documents
-- =============================================================================

-- Permiso de Circulación
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Permiso de Circulación",
    "Datos_Vehiculo": {
      "Patente": "",
      "Marca": "",
      "Modelo": "",
      "Año": "",
      "Tipo_Vehiculo": "Carga / Pasajeros / Otros",
      "Numero_Motor": "",
      "Numero_Chasis": ""
    },
    "Datos_Propietario": {
      "Nombre_Razon_Social": "",
      "RUT": ""
    },
    "Detalle_Permiso": {
      "Año_Vigencia": "",
      "Monto_Pagado_CLP": "",
      "Fecha_Emision": "",
      "Fecha_Vencimiento": "",
      "Municipalidad_Emisora": ""
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Permiso de Circulación';

-- Certificado de Inscripción en el Registro Nacional de Transporte
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Inscripción en el Registro Nacional de Transporte",
    "Datos_Empresa": {
      "Razon_Social": "",
      "RUT": "",
      "Direccion": ""
    },
    "Detalle_Certificado": {
      "Numero_Registro": "",
      "Autoridad_Emisora": "Ministerio de Transportes y Telecomunicaciones",
      "Fecha_Inscripcion": "",
      "Fecha_Vencimiento": "",
      "Tipo_Transporte_Registrado": "Carga / Pasajeros / Mixto",
      "Vehiculos_Asociados": [
        {"Patente": "", "Tipo_Vehiculo": ""}
      ]
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificado de Inscripción en el Registro Nacional de Transporte';

-- Contrato de Flete
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Contrato de Flete",
    "Datos_Contrato": {
      "Numero_Contrato": "",
      "Fecha_Celebracion": "",
      "Tipo_Flete": "Nacional / Internacional / Urbano",
      "Periodo_Vigencia": {
        "Inicio": "",
        "Fin": ""
      }
    },
    "Parte_Contratante": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Contacto": ""
    },
    "Empresa_Transportista": {
      "Nombre_Razon_Social": "",
      "RUT": "",
      "Contacto": ""
    },
    "Detalle_Servicio": {
      "Origen": "",
      "Destino": "",
      "Tipo_Carga": "",
      "Volumen_Peso": "",
      "Condiciones_Entrega": ""
    },
    "Condiciones_Economicas": {
      "Monto_Flete_CLP": "",
      "Forma_Pago": ""
    },
    "Informacion_Adicional": {
      "Clausulas_Especiales": [],
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Contrato de Flete';

-- Libro de Ruta
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Libro de Ruta",
    "Datos_Vehiculo": {
      "Patente": "",
      "Marca": "",
      "Modelo": ""
    },
    "Datos_Conductor": {
      "Nombre_Completo": "",
      "RUT": "",
      "Licencia_Conducir": ""
    },
    "Registro_Viajes": [
      {
        "Fecha_Viaje": "",
        "Hora_Salida": "",
        "Origen": "",
        "Destino": "",
        "Kilometraje_Inicio": "",
        "Kilometraje_Fin": "",
        "Carga_Transportada_Pasajeros": "",
        "Observaciones_Viaje": ""
      }
    ],
    "Informacion_Adicional": {
      "Periodo_Cubre": "",
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Libro de Ruta';

-- Certificados de Revisión Técnica
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Revisión Técnica",
    "Datos_Vehiculo": {
      "Patente": "",
      "Marca": "",
      "Modelo": "",
      "Año": "",
      "Tipo_Vehiculo": ""
    },
    "Datos_Revision": {
      "Numero_Certificado": "",
      "Planta_Revision_Tecnica": "",
      "Fecha_Revision": "",
      "Fecha_Vencimiento": "",
      "Resultado_Revision": "Aprobada / Rechazada / Rechazada con observaciones",
      "Kilometraje_Revision": ""
    },
    "Observaciones_Tecnicas": [],
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados de Revisión Técnica';

-- Certificados de Seguro
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Certificado de Seguro (Carga / Pasajeros)",
    "Datos_Poliza": {
      "Numero_Poliza": "",
      "Aseguradora": "",
      "Tipo_Seguro": "Responsabilidad Civil / Carga / Pasajeros",
      "Fecha_Emision": "",
      "Fecha_Inicio_Vigencia": "",
      "Fecha_Fin_Vigencia": "",
      "Monto_Prima_CLP": "",
      "Cobertura_CLP": ""
    },
    "Datos_Asegurado": {
      "Nombre_Razon_Social": "",
      "RUT": ""
    },
    "Detalle_Cobertura": {
      "Riesgos_Cubiertos": [],
      "Exclusiones": [],
      "Vehiculos_Asociados": [
        {"Patente": "", "Tipo_Vehiculo": ""}
      ]
    },
    "Informacion_Adicional": {
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Certificados de Seguro';

-- Libro de Reclamos
UPDATE webapp_modulo
SET esquema_json = '{
  "json_data": {
    "Tipo_Documento": "Libro de Reclamos",
    "Datos_Empresa": {
      "Nombre_Empresa": "",
      "RUT_Empresa": "",
      "Direccion_Oficina": ""
    },
    "Detalle_Registro": [
      {
        "Numero_Reclamo": "",
        "Fecha_Reclamo": "",
        "Datos_Cliente": {
          "Nombre": "",
          "RUT_o_ID": "",
          "Contacto": ""
        },
        "Descripcion_Reclamo": "",
        "Servicio_Afectado": "",
        "Acciones_Tomadas": "",
        "Fecha_Resolucion": "",
        "Estado_Reclamo": "Pendiente / Resuelto / Cerrado"
      }
    ],
    "Informacion_Adicional": {
      "Periodo_Cubre": "",
      "Observaciones": ""
    }
  }
}'
WHERE nombre = 'Libro de Reclamos';