/* function for get count registers */
CREATE FUNCTION counter_registers() RETURN INTEGER AS $$
DECLARE
	counter INTEGER;	
BEGIN
 SELECT COUNT(*) INTO counter FROM employer;
 RETURN counter;
END;
$$ LANGUAGE plpgsql;


/* function for insert or update */
CREATE OR REPLACE FUNCTION insert_update(isAdd BOOLEAN, i VARCHAR, f VARCHAR, l VARCHAR, e VARCHAR, h INTEGER, a BOOLEAN) RETURNS VOID AS $$
BEGIN
	IF isAdd THEN
		INSERT INTO employer (id,firstname,lastname,email,hours,active) VALUES (i,(INITCAP(TRANSLATE(f, 'áéíóú', 'aeiou'))),(INITCAP(TRANSLATE(l, 'áéíóú', 'aeiou'))),e,h,a);
	ELSE
		UPDATE employer SET firstname=(INITCAP(TRANSLATE(f, 'áéíóú', 'aeiou'))), lastname=(INITCAP(TRANSLATE(l, 'áéíóú', 'aeiou'))), email=e, hours=h, active=a WHERE id=i;
	END IF;
END;
$$ LANGUAGE plpgsql;

/* Disable users for hours less than 8 */
CREATE OR REPLACE FUNCTION disable_users_for_hours() RETURNS SETOF employer_type AS $$
BEGIN
	UPDATE employer SET active=False WHERE hours < 8;
	RETURN QUERY SELECT id,firstname,lastname,email,hours,CAST(CASE WHEN active=true THEN 'Activado' ELSE 'Desactivado' END AS VARCHAR(60)) AS active FROM employer WHERE id LIKE '%%' ORDER BY id ASC;
END;
$$ LANGUAGE plpgsql;

/* Drop functions */
CREATE OR REPLACE FUNCTION drop_functions(tableName VARCHAR) RETURNS VOID AS $$
DECLARE
  deleteQry TEXT;
BEGIN
	deleteQry := format('DROP FUNCTION %I()', lower(tableName));
	EXECUTE deleteQry;
END;
$$ LANGUAGE plpgsql;

/* Create a type */
CREATE TYPE employer_type AS (id VARCHAR, firstname VARCHAR, lastname VARCHAR, email VARCHAR, hours INTEGER, active VARCHAR);

