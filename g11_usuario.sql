/* SEGUNDO AVANCE BASE DE DATOS - TIENDA DE ROPA -
BRAYNER CASTRO CALDERON



*/

-- Tabla "Clientes"
CREATE TABLE Clientes (
  ID_Cliente NUMBER PRIMARY KEY,
  Nombre VARCHAR2(50),
  Apellido VARCHAR2(50),
  Direccion VARCHAR2(100),
  Telefono VARCHAR2(15),
  CorreoElectronico VARCHAR2(100)
);

-- Tabla "Productos"
CREATE TABLE Productos (
  ID_Producto NUMBER PRIMARY KEY,
  Nombre VARCHAR2(100),
  Descripcion VARCHAR2(200),
  Precio NUMBER,
  Categoria VARCHAR2(50),
  Stock NUMBER
);

-- Tabla "Categorias"
CREATE TABLE Categorias (
  ID_Categoria NUMBER PRIMARY KEY,
  Nombre VARCHAR2(50)
);

-- Tabla "Ventas"
CREATE TABLE Ventas (
  ID_Venta NUMBER PRIMARY KEY,
  ID_Cliente NUMBER,
  Fecha DATE,
  Total NUMBER,
  FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);

-- Tabla "Detalles_Venta"
CREATE TABLE Detalles_Venta (
  ID_Detalle NUMBER PRIMARY KEY,
  ID_Venta NUMBER,
  ID_Producto NUMBER,
  Cantidad NUMBER,
  Precio_Unitario NUMBER,
  FOREIGN KEY (ID_Venta) REFERENCES Ventas(ID_Venta),
  FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);

-- Tabla "Proveedores"
CREATE TABLE Proveedores (
  ID_Proveedor NUMBER PRIMARY KEY,
  Nombre VARCHAR2(100),
  Direccion VARCHAR2(100),
  Telefono VARCHAR2(15)
);

-- Tabla "Inventario"
CREATE TABLE Inventario (
  ID_Inventario NUMBER PRIMARY KEY,
  ID_Producto NUMBER,
  ID_Proveedor NUMBER,
  Fecha_Entrada DATE,
  Cantidad NUMBER,
  FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto),
  FOREIGN KEY (ID_Proveedor) REFERENCES Proveedores(ID_Proveedor)
);

-- CRUD CLIENTES --

CREATE OR REPLACE PROCEDURE CrearCliente(
  p_ID_Cliente IN NUMBER,
  p_Nombre IN VARCHAR2,
  p_Apellido IN VARCHAR2,
  p_Direccion IN VARCHAR2,
  p_Telefono IN VARCHAR2,
  p_CorreoElectronico IN VARCHAR2
) AS
BEGIN
  INSERT INTO Clientes(ID_Cliente, Nombre, Apellido, Direccion, Telefono, CorreoElectronico)
  VALUES (p_ID_Cliente, p_Nombre, p_Apellido, p_Direccion, p_Telefono, p_CorreoElectronico);
  COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE LeerCliente(
  p_ID_Cliente IN NUMBER,
  p_Nombre OUT VARCHAR2,
  p_Apellido OUT VARCHAR2,
  p_Direccion OUT VARCHAR2,
  p_Telefono OUT VARCHAR2,
  p_CorreoElectronico OUT VARCHAR2
) AS
BEGIN
  SELECT Nombre, Apellido, Direccion, Telefono, CorreoElectronico
  INTO p_Nombre, p_Apellido, p_Direccion, p_Telefono, p_CorreoElectronico
  FROM Clientes
  WHERE ID_Cliente = p_ID_Cliente;
END;
/

CREATE OR REPLACE PROCEDURE ActualizarCliente(
  p_ID_Cliente IN NUMBER,
  p_Nombre IN VARCHAR2,
  p_Apellido IN VARCHAR2,
  p_Direccion IN VARCHAR2,
  p_Telefono IN VARCHAR2,
  p_CorreoElectronico IN VARCHAR2
) AS
BEGIN
  UPDATE Clientes
  SET Nombre = p_Nombre,
      Apellido = p_Apellido,
      Direccion = p_Direccion,
      Telefono = p_Telefono,
      CorreoElectronico = p_CorreoElectronico
  WHERE ID_Cliente = p_ID_Cliente;
  COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE EliminarCliente(
  p_ID_Cliente IN NUMBER
) AS
BEGIN
  DELETE FROM Clientes
  WHERE ID_Cliente = p_ID_Cliente;
  COMMIT;
END;
/

-- CRUD PRODUCTO --

CREATE OR REPLACE PROCEDURE CrearProducto(
  p_ID_Producto IN NUMBER,
  p_Nombre IN VARCHAR2,
  p_Descripcion IN VARCHAR2,
  p_Precio IN NUMBER,
  p_Categoria IN VARCHAR2,
  p_Stock IN NUMBER
) AS
BEGIN
  INSERT INTO Productos(ID_Producto, Nombre, Descripcion, Precio, Categoria, Stock)
  VALUES (p_ID_Producto, p_Nombre, p_Descripcion, p_Precio, p_Categoria, p_Stock);
  COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE LeerProducto(
  p_ID_Producto IN NUMBER,
  p_Nombre OUT VARCHAR2,
  p_Descripcion OUT VARCHAR2,
  p_Precio OUT NUMBER,
  p_Categoria OUT VARCHAR2,
  p_Stock OUT NUMBER
) AS
BEGIN
  SELECT Nombre, Descripcion, Precio, Categoria, Stock
  INTO p_Nombre, p_Descripcion, p_Precio, p_Categoria, p_Stock
  FROM Productos
  WHERE ID_Producto = p_ID_Producto;
END;
/
CREATE OR REPLACE PROCEDURE ActualizarProducto(
  p_ID_Producto IN NUMBER,
  p_Nombre IN VARCHAR2,
  p_Descripcion IN VARCHAR2,
  p_Precio IN NUMBER,
  p_Categoria IN VARCHAR2,
  p_Stock IN NUMBER
) AS
BEGIN
  UPDATE Productos
  SET Nombre = p_Nombre,
      Descripcion = p_Descripcion,
      Precio = p_Precio,
      Categoria = p_Categoria,
      Stock = p_Stock
  WHERE ID_Producto = p_ID_Producto;
  COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE EliminarProducto(
  p_ID_Producto IN NUMBER
) AS
BEGIN
  DELETE FROM Productos
  WHERE ID_Producto = p_ID_Producto;
  COMMIT;
END;
/

-- CRUD VENTAS --
CREATE OR REPLACE PROCEDURE CrearVenta(
  p_ID_Venta IN NUMBER,
  p_ID_Cliente IN NUMBER,
  p_Fecha IN DATE,
  p_Total IN NUMBER
) AS
BEGIN
  INSERT INTO Ventas(ID_Venta, ID_Cliente, Fecha, Total)
  VALUES (p_ID_Venta, p_ID_Cliente, p_Fecha, p_Total);
  COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE LeerVenta(
  p_ID_Venta IN NUMBER,
  p_ID_Cliente OUT NUMBER,
  p_Fecha OUT DATE,
  p_Total OUT NUMBER
) AS
BEGIN
  SELECT ID_Cliente, Fecha, Total
  INTO p_ID_Cliente, p_Fecha, p_Total
  FROM Ventas
  WHERE ID_Venta = p_ID_Venta;
END;
/
CREATE OR REPLACE PROCEDURE ActualizarVenta(
  p_ID_Venta IN NUMBER,
  p_ID_Cliente IN NUMBER,
  p_Fecha IN DATE,
  p_Total IN NUMBER
) AS
BEGIN
  UPDATE Ventas
  SET ID_Cliente = p_ID_Cliente,
      Fecha = p_Fecha,
      Total = p_Total
  WHERE ID_Venta = p_ID_Venta;
  COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE EliminarVenta(
  p_ID_Venta IN NUMBER
) AS
BEGIN
  DELETE FROM Ventas
  WHERE ID_Venta = p_ID_Venta;
  COMMIT;
END;
/

-- CRUD DETALLE VENTA --
CREATE OR REPLACE PROCEDURE CrearDetalleVenta(
  p_ID_Detalle IN NUMBER,
  p_ID_Venta IN NUMBER,
  p_ID_Producto IN NUMBER,
  p_Cantidad IN NUMBER,
  p_Precio_Unitario IN NUMBER
) AS
BEGIN
  INSERT INTO Detalles_Venta(ID_Detalle, ID_Venta, ID_Producto, Cantidad, Precio_Unitario)
  VALUES (p_ID_Detalle, p_ID_Venta, p_ID_Producto, p_Cantidad, p_Precio_Unitario);
  COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE LeerDetalleVenta(
  p_ID_Detalle IN NUMBER,
  p_ID_Venta OUT NUMBER,
  p_ID_Producto OUT NUMBER,
  p_Cantidad OUT NUMBER,
  p_Precio_Unitario OUT NUMBER
) AS
BEGIN
  SELECT ID_Venta, ID_Producto, Cantidad, Precio_Unitario
  INTO p_ID_Venta, p_ID_Producto, p_Cantidad, p_Precio_Unitario
  FROM Detalles_Venta
  WHERE ID_Detalle = p_ID_Detalle;
END;
/
CREATE OR REPLACE PROCEDURE ActualizarDetalleVenta(
  p_ID_Detalle IN NUMBER,
  p_ID_Venta IN NUMBER,
  p_ID_Producto IN NUMBER,
  p_Cantidad IN NUMBER,
  p_Precio_Unitario IN NUMBER
) AS
BEGIN
  UPDATE Detalles_Venta
  SET ID_Venta = p_ID_Venta,
      ID_Producto = p_ID_Producto,
      Cantidad = p_Cantidad,
      Precio_Unitario = p_Precio_Unitario
  WHERE ID_Detalle = p_ID_Detalle;
  COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE EliminarDetalleVenta(
  p_ID_Detalle IN NUMBER
) AS
BEGIN
  DELETE FROM Detalles_Venta
  WHERE ID_Detalle = p_ID_Detalle;
  COMMIT;
END;
/

-- CRUD PROVEEDOR --
CREATE OR REPLACE PROCEDURE CrearProveedor(
  p_ID_Proveedor IN NUMBER,
  p_Nombre IN VARCHAR2,
  p_Direccion IN VARCHAR2,
  p_Telefono IN VARCHAR2
) AS
BEGIN
  INSERT INTO Proveedores(ID_Proveedor, Nombre, Direccion, Telefono)
  VALUES (p_ID_Proveedor, p_Nombre, p_Direccion, p_Telefono);
  COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE LeerProveedor(
  p_ID_Proveedor IN NUMBER,
  p_Nombre OUT VARCHAR2,
  p_Direccion OUT VARCHAR2,
  p_Telefono OUT VARCHAR2
) AS
BEGIN
  SELECT Nombre, Direccion, Telefono
  INTO p_Nombre, p_Direccion, p_Telefono
  FROM Proveedores
  WHERE ID_Proveedor = p_ID_Proveedor;
END;
/
CREATE OR REPLACE PROCEDURE ActualizarProveedor(
  p_ID_Proveedor IN NUMBER,
  p_Nombre IN VARCHAR2,
  p_Direccion IN VARCHAR2,
  p_Telefono IN VARCHAR2
) AS
BEGIN
  UPDATE Proveedores
  SET Nombre = p_Nombre,
      Direccion = p_Direccion,
      Telefono = p_Telefono
  WHERE ID_Proveedor = p_ID_Proveedor;
  COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE EliminarProveedor(
  p_ID_Proveedor IN NUMBER
) AS
BEGIN
  DELETE FROM Proveedores
  WHERE ID_Proveedor = p_ID_Proveedor;
  COMMIT;
END;
/

-- CRUD INVENTARIO --
CREATE OR REPLACE PROCEDURE CrearRegistroInventario(
  p_ID_Inventario IN NUMBER,
  p_ID_Producto IN NUMBER,
  p_ID_Proveedor IN NUMBER,
  p_Fecha_Entrada IN DATE,
  p_Cantidad IN NUMBER
) AS
BEGIN
  INSERT INTO Inventario(ID_Inventario, ID_Producto, ID_Proveedor, Fecha_Entrada, Cantidad)
  VALUES (p_ID_Inventario, p_ID_Producto, p_ID_Proveedor, p_Fecha_Entrada, p_Cantidad);
  COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE LeerRegistroInventario(
  p_ID_Inventario IN NUMBER,
  p_ID_Producto OUT NUMBER,
  p_ID_Proveedor OUT NUMBER,
  p_Fecha_Entrada OUT DATE,
  p_Cantidad OUT NUMBER
) AS
BEGIN
  SELECT ID_Producto, ID_Proveedor, Fecha_Entrada, Cantidad
  INTO p_ID_Producto, p_ID_Proveedor, p_Fecha_Entrada, p_Cantidad
  FROM Inventario
  WHERE ID_Inventario = p_ID_Inventario;
END;
/
CREATE OR REPLACE PROCEDURE ActualizarRegistroInventario(
  p_ID_Inventario IN NUMBER,
  p_ID_Producto IN NUMBER,
  p_ID_Proveedor IN NUMBER,
  p_Fecha_Entrada IN DATE,
  p_Cantidad IN NUMBER
) AS
BEGIN
  UPDATE Inventario
  SET ID_Producto = p_ID_Producto,
      ID_Proveedor = p_ID_Proveedor,
      Fecha_Entrada = p_Fecha_Entrada,
      Cantidad = p_Cantidad
  WHERE ID_Inventario = p_ID_Inventario;
  COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE EliminarRegistroInventario(
  p_ID_Inventario IN NUMBER
) AS
BEGIN
  DELETE FROM Inventario
  WHERE ID_Inventario = p_ID_Inventario;
  COMMIT;
END;
/

-- CRUD CATEGORIA --
CREATE OR REPLACE PROCEDURE CrearCategoria(
  p_ID_Categoria IN NUMBER,
  p_Nombre IN VARCHAR2
) AS
BEGIN
  INSERT INTO Categorias(ID_Categoria, Nombre)
  VALUES (p_ID_Categoria, p_Nombre);
  COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE LeerCategoria(
  p_ID_Categoria IN NUMBER,
  p_Nombre OUT VARCHAR2
) AS
BEGIN
  SELECT Nombre
  INTO p_Nombre
  FROM Categorias
  WHERE ID_Categoria = p_ID_Categoria;
END;
/
CREATE OR REPLACE PROCEDURE ActualizarCategoria(
  p_ID_Categoria IN NUMBER,
  p_Nombre IN VARCHAR2
) AS
BEGIN
  UPDATE Categorias
  SET Nombre = p_Nombre
  WHERE ID_Categoria = p_ID_Categoria;
  COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE EliminarCategoria(
  p_ID_Categoria IN NUMBER
) AS
BEGIN
  DELETE FROM Categorias
  WHERE ID_Categoria = p_ID_Categoria;
  COMMIT;
END;
/


-- FUNCIONES --

CREATE OR REPLACE FUNCTION TotalVentasPorCliente(
  p_ID_Cliente IN NUMBER
) RETURN NUMBER AS
  v_TotalVentas NUMBER;
BEGIN
  SELECT SUM(Total)
  INTO v_TotalVentas
  FROM Ventas
  WHERE ID_Cliente = p_ID_Cliente;

  RETURN v_TotalVentas;
END;
/
CREATE OR REPLACE FUNCTION PromedioPreciosPorCategoria(
  p_Categoria IN VARCHAR2
) RETURN NUMBER AS
  v_PromedioPrecio NUMBER;
BEGIN
  SELECT AVG(Precio)
  INTO v_PromedioPrecio
  FROM Productos
  WHERE Categoria = p_Categoria;

  RETURN v_PromedioPrecio;
END;
/
CREATE OR REPLACE FUNCTION CantidadDisponibleProducto(
  p_ID_Producto IN NUMBER
) RETURN NUMBER AS
  v_CantidadDisponible NUMBER;
BEGIN
  SELECT Stock
  INTO v_CantidadDisponible
  FROM Productos
  WHERE ID_Producto = p_ID_Producto;

  RETURN v_CantidadDisponible;
END;
/
CREATE OR REPLACE FUNCTION ObtenerProveedorProducto(
  p_ID_Producto IN NUMBER
) RETURN VARCHAR2 AS
  v_NombreProveedor VARCHAR2(100);
BEGIN
  SELECT Proveedores.Nombre
  INTO v_NombreProveedor
  FROM Proveedores
  INNER JOIN Inventario ON Proveedores.ID_Proveedor = Inventario.ID_Proveedor
  WHERE Inventario.ID_Producto = p_ID_Producto;

  RETURN v_NombreProveedor;
END;
/
CREATE OR REPLACE FUNCTION CalcularSubtotalVenta(
  p_ID_Venta IN NUMBER
) RETURN NUMBER AS
  v_Subtotal NUMBER;
BEGIN
  SELECT SUM(Cantidad * Precio_Unitario)
  INTO v_Subtotal
  FROM Detalles_Venta
  WHERE ID_Venta = p_ID_Venta;

  RETURN v_Subtotal;
END;
/
CREATE OR REPLACE FUNCTION ObtenerClientesPorFecha(
  p_Fecha IN DATE
) RETURN SYS_REFCURSOR AS
  v_Result SYS_REFCURSOR;
BEGIN
  OPEN v_Result FOR
    SELECT Clientes.*
    FROM Clientes
    INNER JOIN Ventas ON Clientes.ID_Cliente = Ventas.ID_Cliente
    WHERE Ventas.Fecha = p_Fecha;

  RETURN v_Result;
END;
/
CREATE OR REPLACE FUNCTION ProductoMasVendido() RETURN VARCHAR2 AS
  v_Producto VARCHAR2(100);
BEGIN
  SELECT Nombre
  INTO v_Producto
  FROM Productos
  WHERE ID_Producto = (
    SELECT ID_Producto
    FROM Detalles_Venta
    GROUP BY ID_Producto
    ORDER BY SUM(Cantidad) DESC
    FETCH FIRST ROW ONLY
  );

  RETURN v_Producto;
END;
/
CREATE OR REPLACE FUNCTION CalcularIngresosPorFecha(
  p_FechaInicio IN DATE,
  p_FechaFin IN DATE
) RETURN NUMBER AS
  v_TotalIngresos NUMBER;
BEGIN
  SELECT SUM(Total)
  INTO v_TotalIngresos
  FROM Ventas
  WHERE Fecha BETWEEN p_FechaInicio AND p_FechaFin;

  RETURN v_TotalIngresos;
END;
/
CREATE OR REPLACE FUNCTION ContarProductosPorCategoria(
  p_Categoria IN VARCHAR2
) RETURN NUMBER AS
  v_CantidadProductos NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_CantidadProductos
  FROM Productos
  WHERE Categoria = p_Categoria;

  RETURN v_CantidadProductos;
END;
/
CREATE OR REPLACE FUNCTION ObtenerProveedoresOrdenados() RETURN SYS_REFCURSOR AS
  v_Result SYS_REFCURSOR;
BEGIN
  OPEN v_Result FOR
    SELECT Proveedores.*
    FROM Proveedores
    INNER JOIN Inventario ON Proveedores.ID_Proveedor = Inventario.ID_Proveedor
    GROUP BY Proveedores.ID_Proveedor, Proveedores.Nombre, Proveedores.Direccion, Proveedores.Telefono
    ORDER BY COUNT(Inventario.ID_Producto) DESC;

  RETURN v_Result;
END;
/
CREATE OR REPLACE FUNCTION ObtenerProductosStockBajo(
  p_CantidadMinima IN NUMBER
) RETURN SYS_REFCURSOR AS
  v_Result SYS_REFCURSOR;
BEGIN
  OPEN v_Result FOR
    SELECT *
    FROM Productos
    WHERE Stock < p_CantidadMinima;

  RETURN v_Result;
END;
/

CREATE OR REPLACE FUNCTION ObtenerNombreCliente(
  p_ID_Cliente IN NUMBER
) RETURN VARCHAR2 AS
  v_NombreCliente VARCHAR2(100);
BEGIN
  SELECT Nombre || ' ' || Apellido
  INTO v_NombreCliente
  FROM Clientes
  WHERE ID_Cliente = p_ID_Cliente;

  RETURN v_NombreCliente;
END;
/

-- CURSORES --

DECLARE
  CURSOR c_clientes IS
    SELECT *
    FROM Clientes;
BEGIN
  FOR cliente IN c_clientes LOOP
    -- Realizar acciones con cada cliente
    DBMS_OUTPUT.PUT_LINE(cliente.ID_Cliente || ' - ' || cliente.Nombre || ' ' || cliente.Apellido);
  END LOOP;
END;
/

DECLARE
  CURSOR c_ventas IS
    SELECT *
    FROM Ventas;
BEGIN
  FOR venta IN c_ventas LOOP
    -- Realizar acciones con cada venta
    DBMS_OUTPUT.PUT_LINE(venta.ID_Venta || ' - ' || venta.Fecha || ' - ' || venta.Total);
  END LOOP;
END;
/
DECLARE
  CURSOR c_detalles_venta (p_ID_Venta NUMBER) IS
    SELECT *
    FROM Detalles_Venta
    WHERE ID_Venta = p_ID_Venta;
  v_ID_Venta NUMBER := 1; -- ID de la venta a consultar
BEGIN
  FOR detalle IN c_detalles_venta(v_ID_Venta) LOOP
    -- Realizar acciones con cada detalle de venta
    DBMS_OUTPUT.PUT_LINE(detalle.ID_Detalle || ' - ' || detalle.Cantidad || ' - ' || detalle.Precio_Unitario);
  END LOOP;
END;
/
DECLARE
  CURSOR c_productos_stock_bajo IS
    SELECT *
    FROM Productos
    WHERE Stock < 10;
BEGIN
  FOR producto IN c_productos_stock_bajo LOOP
    -- Realizar acciones con cada producto
    DBMS_OUTPUT.PUT_LINE(producto.ID_Producto || ' - ' || producto.Nombre || ' - ' || producto.Stock);
  END LOOP;
END;
/
DECLARE
  CURSOR c_proveedores IS
    SELECT *
    FROM Proveedores;
BEGIN
  FOR proveedor IN c_proveedores LOOP
    -- Realizar acciones con cada proveedor
    DBMS_OUTPUT.PUT_LINE(proveedor.ID_Proveedor || ' - ' || proveedor.Nombre || ' - ' || proveedor.Direccion);
  END LOOP;
END;
/
DECLARE
  CURSOR c_categorias_con_cantidad_productos IS
    SELECT c.ID_Categoria, c.Nombre, COUNT(p.ID_Producto) AS CantidadProductos
    FROM Categorias c
    INNER JOIN Productos p ON c.ID_Categoria = p.ID_Categoria
    GROUP BY c.ID_Categoria, c.Nombre;
BEGIN
  FOR categoria IN c_categorias_con_cantidad_productos LOOP
    -- Realizar acciones con cada categoría
    DBMS_OUTPUT.PUT_LINE(categoria.ID_Categoria || ' - ' || categoria.Nombre || ' - ' || categoria.CantidadProductos);
  END LOOP;
END;
/
DECLARE
  CURSOR c_detalles_inventario (p_ID_Producto NUMBER) IS
    SELECT *
    FROM Inventario
    WHERE ID_Producto = p_ID_Producto;
  v_ID_Producto NUMBER := 1; -- ID del producto a consultar
BEGIN
  FOR detalle IN c_detalles_inventario(v_ID_Producto) LOOP
    -- Realizar acciones con cada detalle de inventario
    DBMS_OUTPUT.PUT_LINE(detalle.ID_Inventario || ' - ' || detalle.Fecha_Entrada || ' - ' || detalle.Cantidad);
  END LOOP;
END;
/
DECLARE
  CURSOR c_detalles_venta_por_cliente (p_ID_Cliente NUMBER) IS
    SELECT dv.ID_Detalle, dv.ID_Venta, dv.Cantidad, dv.Precio_Unitario
    FROM Detalles_Venta dv
    INNER JOIN Ventas v ON dv.ID_Venta = v.ID_Venta
    WHERE v.ID_Cliente = p_ID_Cliente;
  v_ID_Cliente NUMBER := 1; -- ID del cliente a consultar
BEGIN
  FOR detalle IN c_detalles_venta_por_cliente(v_ID_Cliente) LOOP
    -- Realizar acciones con cada detalle de venta del cliente
    DBMS_OUTPUT.PUT_LINE(detalle.ID_Detalle || ' - ' || detalle.ID_Venta || ' - ' || detalle.Cantidad || ' - ' || detalle.Precio_Unitario);
  END LOOP;
END;
/

-- TRIGGERS --

CREATE OR REPLACE TRIGGER ControlStockVenta
AFTER INSERT ON Detalles_Venta
FOR EACH ROW
DECLARE
  v_CantidadDisponible NUMBER;
BEGIN
  SELECT Stock
  INTO v_CantidadDisponible
  FROM Productos
  WHERE ID_Producto = :NEW.ID_Producto;

  IF v_CantidadDisponible >= :NEW.Cantidad THEN
    UPDATE Productos
    SET Stock = Stock - :NEW.Cantidad
    WHERE ID_Producto = :NEW.ID_Producto;
  ELSE
    RAISE_APPLICATION_ERROR(-20001, 'No hay suficiente stock disponible');
  END IF;
END;
/
CREATE OR REPLACE TRIGGER ActualizarTotalVenta
AFTER INSERT OR UPDATE ON Detalles_Venta
FOR EACH ROW
BEGIN
  UPDATE Ventas
  SET Total = (
    SELECT SUM(Cantidad * Precio_Unitario)
    FROM Detalles_Venta
    WHERE ID_Venta = :NEW.ID_Venta
  )
  WHERE ID_Venta = :NEW.ID_Venta;
END;
/
CREATE OR REPLACE TRIGGER ValidarTotalVenta
BEFORE DELETE ON Ventas
FOR EACH ROW
DECLARE
  v_TotalVenta NUMBER;
BEGIN
  SELECT Total
  INTO v_TotalVenta
  FROM Ventas
  WHERE ID_Venta = :OLD.ID_Venta;

  IF v_TotalVenta > 1000 THEN
    RAISE_APPLICATION_ERROR(-20002, 'No se puede eliminar la venta porque el total supera los $1000');
  END IF;
END;


-- PAQUETES --

CREATE OR REPLACE PACKAGE Clientes_Pkg AS

  TYPE ClienteRecord IS RECORD(
    ID_Cliente Clientes.ID_Cliente%TYPE,
    Nombre Clientes.Nombre%TYPE,
    Apellido Clientes.Apellido%TYPE,
    CorreoElectronico Clientes.CorreoElectronico%TYPE
  );

  TYPE ClienteList IS TABLE OF ClienteRecord;

  FUNCTION InsertarCliente(p_Nombre IN VARCHAR2, p_Apellido IN VARCHAR2, p_Correo IN VARCHAR2) RETURN NUMBER;

  PROCEDURE ActualizarCliente(p_ID_Cliente IN NUMBER, p_Nombre IN VARCHAR2, p_Apellido IN VARCHAR2, p_Correo IN VARCHAR2);

  PROCEDURE EliminarCliente(p_ID_Cliente IN NUMBER);

  FUNCTION ObtenerClientePorID(p_ID_Cliente IN NUMBER) RETURN ClienteRecord;

  FUNCTION ListarClientes RETURN ClienteList;

END Clientes_Pkg;
/
CREATE OR REPLACE PACKAGE Productos_Pkg AS

  TYPE ProductoRecord IS RECORD(
    ID_Producto Productos.ID_Producto%TYPE,
    Nombre Productos.Nombre%TYPE,
    Precio Productos.Precio%TYPE,
    Stock Productos.Stock%TYPE,
    Categoria Productos.Categoria%TYPE
  );

  TYPE ProductoList IS TABLE OF ProductoRecord;

  FUNCTION InsertarProducto(p_Nombre IN VARCHAR2, p_Precio IN NUMBER, p_Stock IN NUMBER, p_Categoria IN VARCHAR2) RETURN NUMBER;

  PROCEDURE ActualizarProducto(p_ID_Producto IN NUMBER, p_Nombre IN VARCHAR2, p_Precio IN NUMBER, p_Stock IN NUMBER, p_Categoria IN VARCHAR2);

  PROCEDURE EliminarProducto(p_ID_Producto IN NUMBER);

  FUNCTION ObtenerProductoPorID(p_ID_Producto IN NUMBER) RETURN ProductoRecord;

  FUNCTION ListarProductos RETURN ProductoList;

END Productos_Pkg;
/
CREATE OR REPLACE PACKAGE BusquedaEstadisticas_Pkg AS

  FUNCTION TotalVentasPorCliente(p_ID_Cliente IN NUMBER) RETURN NUMBER;

  FUNCTION PromedioPreciosPorCategoria(p_Categoria IN VARCHAR2) RETURN NUMBER;

  FUNCTION CantidadDisponibleProducto(p_ID_Producto IN NUMBER) RETURN NUMBER;

  FUNCTION ObtenerProveedorProducto(p_ID_Producto IN NUMBER) RETURN VARCHAR2;

  FUNCTION CalcularSubtotalVenta(p_ID_Venta IN NUMBER) RETURN NUMBER;

  FUNCTION ObtenerClientesPorFecha(p_Fecha IN DATE) RETURN SYS_REFCURSOR;

  FUNCTION ProductoMasVendido RETURN VARCHAR2;

  FUNCTION CalcularIngresosPorFecha(p_FechaInicio IN DATE, p_FechaFin IN DATE) RETURN NUMBER;

  FUNCTION ContarProductosPorCategoria(p_Categoria IN VARCHAR2) RETURN NUMBER;

  FUNCTION ObtenerProveedoresOrdenados RETURN SYS_REFCURSOR;

END BusquedaEstadisticas_Pkg;
/

CREATE OR REPLACE PACKAGE Ventas_Pkg AS

  TYPE VentaRecord IS RECORD(
    ID_Venta Ventas.ID_Venta%TYPE,
    ID_Cliente Ventas.ID_Cliente%TYPE,
    Fecha Ventas.Fecha%TYPE,
    Total Ventas.Total%TYPE
  );

  TYPE VentaList IS TABLE OF VentaRecord;

  FUNCTION InsertarVenta(p_ID_Cliente IN NUMBER, p_Fecha IN DATE, p_Total IN NUMBER) RETURN NUMBER;

  PROCEDURE ActualizarVenta(p_ID_Venta IN NUMBER, p_ID_Cliente IN NUMBER, p_Fecha IN DATE, p_Total IN NUMBER);

  PROCEDURE EliminarVenta(p_ID_Venta IN NUMBER);

  FUNCTION ObtenerVentaPorID(p_ID_Venta IN NUMBER) RETURN VentaRecord;

  FUNCTION ListarVentas RETURN VentaList;

END Ventas_Pkg;
/
CREATE OR REPLACE PACKAGE Proveedores_Pkg AS

  TYPE ProveedorRecord IS RECORD(
    ID_Proveedor Proveedores.ID_Proveedor%TYPE,
    Nombre Proveedores.Nombre%TYPE,
    Direccion Proveedores.Direccion%TYPE,
    Telefono Proveedores.Telefono%TYPE
  );

  TYPE ProveedorList IS TABLE OF ProveedorRecord;

  FUNCTION InsertarProveedor(p_Nombre IN VARCHAR2, p_Direccion IN VARCHAR2, p_Telefono IN VARCHAR2) RETURN NUMBER;

  PROCEDURE ActualizarProveedor(p_ID_Proveedor IN NUMBER, p_Nombre IN VARCHAR2, p_Direccion IN VARCHAR2, p_Telefono IN VARCHAR2);

  PROCEDURE EliminarProveedor(p_ID_Proveedor IN NUMBER);

  FUNCTION ObtenerProveedorPorID(p_ID_Proveedor IN NUMBER) RETURN ProveedorRecord;

  FUNCTION ListarProveedores RETURN ProveedorList;

END Proveedores_Pkg;
/
alter session set "_ORACLE_SCRIPT"=true;

CREATE USER adming11 identified by 123456;

grant connect, resource, DBA to adming11;



