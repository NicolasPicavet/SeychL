<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="description" content="SeychL">
        <meta name="author" content="Myriam Grillot, Nicolas Picavet">
        <link rel="stylesheet" href="styles.css?v=1.0">

        <title>SeychL</title>
    </head>
    <body>
        <header id="main-header">
            <h1>SeychL</h1>
        </header>

        <section id="map">
            <h4>Map</h4>
            <?php require("map/map.html"); ?>
        </section>

        <section id="pictures">
            <h4>Pictures</h4>
            <?php require("pictures/pictures.php")?>
        </section>

        <footer id="main-footer"></footer>
    </body>
</html>