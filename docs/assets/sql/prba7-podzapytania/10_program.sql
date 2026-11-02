-- Run after 07_views.sql. Execute the entire DO block in pgAdmin Query Tool.
-- This program reads the report and prints a message; it does not reserve a place.
DO $$
DECLARE
    selected_edition text := 'E2';
    available_places bigint;
BEGIN
    SELECT free_places INTO STRICT available_places
    FROM prba7_demo.edition_summary
    WHERE edition_id = selected_edition;

    IF available_places > 0 THEN
        RAISE NOTICE 'Edycja %: wolne miejsca = %', selected_edition, available_places;
    ELSE
        RAISE NOTICE 'Edycja %: brak wolnych miejsc', selected_edition;
    END IF;
END;
$$ LANGUAGE plpgsql;
