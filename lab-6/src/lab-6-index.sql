/* =========================== ИНДЕКСЫ 1 ============================ */
CREATE INDEX 
    artist_name_index 
ON 
    discogs.artist(NAME);

ALTER TABLE 
    discogs.artist 
DROP INDEX 
    artist_name_index;

EXPLAIN SELECT 
    * 
FROM 
    discogs.artist
WHERE 
    NAME = "Пикник";