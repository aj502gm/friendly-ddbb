--QUERY 1
SELECT COUNT(id) AS vuelosAlemania FROM vuelos WHERE paisorigen = 'Germany' OR paisdestino = 'Germany'
--QUERY 2
SELECT COUNT(id) AS vuelosParaBrasil FROM vuelos WHERE paisdestino = 'Brazil'
--QUERY 3
SELECT numvuelo, horasalida, horallegada, vacantes FROM vuelos WHERE horasalida BETWEEN '02:00:00' AND '05:00:00' AND vacantes > 5
	GROUP BY numvuelo,horasalida,horallegada,vacantes ORDER BY horasalida ASC
--QUERY 4
SELECT ROUND(AVG(vacantes),0) promVacantes FROM vuelos;
--QUERY 5
SELECT id, numvuelo,avionref from vuelos WHERE fechasalida BETWEEN '1-1-2017' AND '12-31-2018' AND paisorigen = 'Japan' AND paisdestino = 'China'
--QUERY 6
SELECT cliente_noPasaporte, vuelos.numVuelo, vuelos.paisDestino  
	FROM (SELECT cliente_noPasaporte,vuelos_numVuelo  FROM reservas WHERE cliente_noPasaporte = 'T69-584485-3') 
		AS vuelos2 INNER JOIN vuelos ON vuelos_numVuelo = vuelos.numVuelo;
		--VERIFICAR COM REMOVER # DE VUELO DUPLICADO
--QUERY 7
SELECT cliente_noPasaporte, conteo FROM
	(SELECT cliente_noPasaporte, COUNT(*) AS conteo FROM reservas GROUP BY cliente_noPasaporte ORDER by COUNT(*) ASC ) as listado
		GROUP BY cliente_noPasaporte, conteo HAVING conteo = 1 --MEJORAR ASPECTO
--QUERY 8
SELECT ROUND(AVG(vacantes)) AS promedioVacantesMexico, paisDestino FROM vuelos 
	GROUP BY paisDestino HAVING paisDestino  = 'Mexico'
--QUERY 9
--SELECT COUNT(*), COUNT(aviones.id), (COUNT(*) / COUNT(aviones.id)) AS promedioVuelos FROM 
	--(SELECT COUNT(*)FROM vuelos GROUP BY id) as cantidadVuelos
--QUERY 10
SELECT nombre, apellido, reservas.vuelos_numVuelo  FROM 
	((SELECT numVuelo FROM vuelos WHERE paisOrigen = 'Nigeria' OR paisDestino = 'Nigeria') as numVuelo 
	 	JOIN reservas ON reservas.vuelos_numVuelo = numVuelo)
			JOIN clientes ON clientes.noPasaporte = reservas.cliente_noPasaporte
--QUERY 11
SELECT nombre, apellido, reservas.vuelos_numVuelo FROM
	(SELECT nombre,apellido,nopasaporte FROM clientes WHERE nombre LIKE 'F%' OR apellido LIKE 'F%') as numPasaporte
		JOIN reservas ON nopasaporte = reservas.cliente_nopasaporte
--QUERY 12
SELECT nombre,apellido, nopasaporte, email FROM clientes WHERE email LIKE '%.gov%'