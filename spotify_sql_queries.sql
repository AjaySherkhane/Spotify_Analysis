--Advanced SQl Project -- Spotify Dataset

DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
	artist VARCHAR(255),
	track VARCHAR(255),
	album VARCHAR(255),
	album_type VARCHAR(50),
	danceability FLOAT,
	energy FLOAT,
	loudness FLOAT,
	speechiness FLOAT,
	acousticness FLOAT,
	instrumentalness FLOAT,
	liveness FLOAT,
	Valence FLOAT,
	tempo FLOAT,
	duration_min FLOAT,
	title VARCHAR(255),
	channel VARCHAR(255),
	views FLOAT,
	likes BIGINT,
	comments BIGINT,
	licensed BOOLEAN,
	official_video BOOLEAN,
	stream BIGINT,
	energyLiveness FLOAT,
	most_playedon VARCHAR(50)
);

--Exploratory Data Analysis

SELECT COUNT (*) FROM spotify

SELECT COUNT(DISTINCT artist) FROM spotify

SELECT COUNT(DISTINCT album) FROM spotify

SELECT DISTINCT album_type FROM spotify;

SELECT
	MAX(duration_min),
	MIN(duration_min),
	AVG(duration_min)
FROM spotify;

-- Delete the records with 0 duration_mins

SELECT
*
FROM spotify
WHERE duration_min = 0;

DELETE FROM spotify
WHERE duration_min = 0;

SELECT
	most_playedon,
	COUNT(*) AS total_count
FROM spotify
GROUP BY 1

SELECT
	COUNT(duration_min) as  total_count
FROM spotify
WHERE duration_min < 5

SELECT
	distinct track
FROM spotify
WHERE duration_min > 30

SELECT
	track,
	COUNT(*)
FROM spotify
GROUP BY 1
HAVING COUNT(*) > 5
ORDER BY 2 desc 

SELECT DISTINCT channel FROM spotify;

--Data Analysis - Easy Category

-- Retrieve the names of all tracks that have more than 1 billion streams.

SELECT * FROM spotify

SELECT
	track
FROM spotify
WHERE stream > 1000000000

--List all albums along with their respective artists.

SELECT
	DISTINCT album,
	artist
FROM spotify

--Get the total number of comments for tracks where licensed = TRUE.

SELECT
	COUNT(comments) as Total_count
FROM spotify
WHERE licensed = 'true'

-- Find all tracks that belong to the album type single.

SELECT
	track
FROM spotify
WHERE album_type = 'single'

-- Count the total number of tracks by each artist.

SELECT
	artist,
	COUNT(track)
FROM spotify
GROUP BY 1

-- Medium Level Analysis

--Calculate the average danceability of tracks in each album.

SELECT * FROM spotify;

SELECT
	album,
	AVG(danceability) AS avg_danceability
FROM spotify
GROUP BY 1
ORDER BY 2 DESC

SELECT avg(danceability) FROM spotify;--0.620162038655788

-- Find the top 5 tracks with the highest energy values.

SELECT
	track,
	MAX(energy) AS energy_value
FROM spotify
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--List all tracks along with their views and likes where official_video = TRUE.

SELECT
	track,
	SUM(views) AS total_views,
	SUM(likes) AS total_likes
FROM spotify
WHERE official_video = 'true'
GROUP BY 1

-- For each album, calculate the total views of all associated tracks.

SELECT
	album,
	track,
	sum(views) as total_views
FROM spotify
GROUP BY 1,2
ORDER BY 3 DESC

--Retrieve the track names that have been streamed on Spotify more than YouTube.

SELECT
	track
FROM
(
SELECT
	track,
	--most_playedon,
	COALESCE(SUM((CASE WHEN most_playedon = 'Spotify' THEN stream END)),0) AS streamedon_Spotify,
	COALESCE(SUM((CASE WHEN most_playedon = 'Youtube' THEN stream END)),0) AS streamedon_Youtube
FROM spotify
GROUP BY 1
) AS t1
WHERE streamedon_Spotify > streamedon_Youtube
AND streamedon_Youtube <> 0

-- Advance Analysis

--Find the top 3 most-viewed tracks for each artist using window functions.

SELECT
	artist,
	track
FROM
(
SELECT
	artist,
	track,
	SUM(views),
	DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC) AS rnk
FROM spotify
GROUP BY 1,2
ORDER BY 1,3
) t1
WHERE rnk <= 3

--Write a query to find tracks where the liveness score is above the average.

SELECT
	track,
	liveness
FROM spotify
WHERE liveness >
(
SELECT
	AVG(liveness) AS avg_score
FROM spotify
)
ORDER BY liveness DESC

--Find tracks where the energy-to-liveness ratio is greater than 1.2.

SELECT
	track,
	(energy/liveness) as ratio
FROM spotify
WHERE (energy/liveness) > 1.2
ORDER BY 2 asc

--Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

WITH CTE
AS
(
SELECT
	track,
	views,
	likes,
	SUM(likes) OVER(ORDER BY views DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as  Cum_likes_total
FROM spotify
GROUP BY 1,2,3
)
SELECT
	track,
	likes,
	Cum_likes_total
FROM CTE

--Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.


WITH CTE
AS
(
SELECT
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as lowest_energy
FROM spotify
GROUP BY 1
)
SELECT
	album,
	highest_energy - lowest_energy AS diff
FROM CTE
ORDER BY 2 desc










