/* =========================== ИНДЕКСЫ 1 ============================ */
CREATE INDEX 
    artist_name_index 
    ON discogs.artist(NAME);

ALTER TABLE 
    discogs.artist 
DROP INDEX 
    artist_name_index;

EXPLAIN SELECT 
    * 
FROM 
    discogs.artist
WHERE 
    NAME = 'Пикник';
    
/* =========================== ИНДЕКСЫ 2 ============================ */
CREATE INDEX 
    group_main_artist_id_index 
    ON discogs.group(MAIN_ARTIST_ID);

ALTER TABLE 
    discogs.group 
DROP INDEX 
    group_main_artist_id_index;
    
EXPLAIN SELECT 
    artist.* 
FROM 
    discogs.artist
JOIN 
    discogs.group 
    ON artist.ARTIST_ID = discogs.group.GROUP_ARTIST_ID
JOIN 
    discogs.artist AS band 
    ON discogs.group.MAIN_ARTIST_ID = band.ARTIST_ID
WHERE 
    band.NAME = 'Пикник';
    
/* =========================== ИНДЕКСЫ 3 ============================ */
SET SESSION        wait_timeout = 600;
SET SESSION interactive_timeout = 600;

CREATE INDEX 
    release_title_realeased_index 
    ON discogs.release(TITLE);
    
ALTER TABLE 
    discogs.release 
DROP INDEX 
    release_title_realeased_index;

CREATE INDEX 
    release_artist_artist_id_index 
    ON discogs.release_artist(ARTIST_ID);
    
ALTER TABLE 
    discogs.release_artist 
DROP INDEX 
    release_artist_artist_id_index;

EXPLAIN SELECT 
    artist.NAME, 
    TITLE, 
    RELEASED 
FROM 
    discogs.release
JOIN 
    discogs.release_artist 
    ON discogs.release_artist.RELEASE_ID = discogs.release.RELEASE_ID
JOIN 
    discogs.artist
    ON discogs.artist.ARTIST_ID = discogs.release_artist.ARTIST_ID
WHERE 
    artist.NAME = 'Пикник' 
ORDER BY 
    RELEASED DESC;


/* =========================== ИНДЕКСЫ 4 ============================ */
CREATE INDEX 
    style_release_id_index 
    ON discogs.style(RELEASE_ID);
    
ALTER TABLE 
    discogs.style 
DROP INDEX 
    style_release_id_index;
    
CREATE INDEX 
    release_is_main_release_released_index ON 
    discogs.release(IS_MAIN_RELEASE, RELEASED);
    
ALTER TABLE 
    discogs.release 
DROP INDEX 
    release_is_main_release_released_index;

EXPLAIN SELECT 
    discogs.release.*, 
    STYLE_NAME 
FROM 
    discogs.release
JOIN 
    discogs.style 
    ON discogs.release.RELEASE_ID = discogs.style.RELEASE_ID
WHERE 
    YEAR(RELEASED) = 2005
    AND IS_MAIN_RELEASE = 1;