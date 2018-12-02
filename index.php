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

        <footer id="main-footer"></footer>
    </body>
</html>