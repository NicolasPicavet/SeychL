<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="description" content="SeychL">
        <meta name="author" content="Myriam Grillot, Nicolas Picavet">
        <link rel="stylesheet" href="styles.css?v=1.0">

        <title>SeychL</title>

        <script>
            function selectSequence() {
                var selected_sequence = document.getElementById("sequence-select").value;
                var current_selected_sequence = document.getElementById("sequence-selected");
                if (current_selected_sequence != null) {
                    current_selected_sequence.id = "";
                }
                var sequences = document.getElementsByClassName("sequence");
                for(var i = 0; i < sequences.length; i++) {
                    if(i == selected_sequence - 1) {
                        sequences[i].id = "sequence-selected";
                    }
                }
            }

            function openLightbox(pictureSrc) {
                document.getElementById("lightbox").classList.add("lightbox-opened");
                document.getElementById("lightbox-img").src = pictureSrc;
            }
            function closeLightbox() {
                document.getElementById("lightbox").classList.remove("lightbox-opened");
            }
        </script>
    </head>
    <body>
        <header id="main-header"></header>

        <section id="map">
            <iframe src="map/map.html"></iframe>
        </section>

        <section id="pictures">
            <?php require("pictures/pictures.php")?>
        </section>

        <section id="lightbox">
            <div id="lightbox-close" onclick="closeLightbox()"></div>
            <div id="lightbox-img-container">
                <img id="lightbox-img"/>
            </div>
        </section>

        <footer id="main-footer"></footer>
    </body>
</html>