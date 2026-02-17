USE movies;

-- Drop the table if it exists
DROP TABLE IF EXISTS genre;

-- Create the genre table
CREATE TABLE genre
(
    genre VARCHAR(512),
    g_code VARCHAR(512)
);

-- Insert data into the genre table
INSERT INTO genre (genre, g_code) VALUES
    ('Action', 'G01'),
    ('Adventure', 'G02'),
    ('Animation', 'G03'),
    ('Biography', 'G04'),
    ('Comedy', 'G05'),
    ('Crime', 'G06'),
    ('Documentary', 'G07'),
    ('Drama', 'G08'),
    ('Family', 'G09'),
    ('Fantasy', 'G10'),
    ('Horror', 'G11'),
    ('Music', 'G12'),
    ('Musical', 'G13'),
    ('Mystery', 'G14'),
    ('Romance', 'G15'),
    ('Sci-Fi', 'G16'),
    ('Thriller', 'G17'),
    ('Western', 'G18'),
    ('History', 'G19'),
    ('Sport', 'G20'),
    ('War', 'G21'),
    ('(blank)', 'G22'),
    ('Film-Noir', 'G23'),
    ('News', 'G24'),
    ('Short', 'G25');