<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="description" content="SeychL">
        <meta name="author" content="Myriam Grillot, Nicolas Picavet">
        <link rel="stylesheet" href="styles.css?v=1.0">

        <title>SeychL</title>

        <script>
            var sequencesFiles = {};
            var sequencePaths = {};
            var currentSequenceKey;
            var currentPictureKey;

            var lightboxOpen;

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

            function openLightbox(sequenceKey, pictureKey) {
                if(sequencePaths[sequenceKey] && sequencesFiles[sequenceKey][pictureKey]) {

                    currentSequenceKey = sequenceKey;
                    currentPictureKey = pictureKey;

                    filePath = sequencePaths[sequenceKey] + '/' + sequencesFiles[sequenceKey][pictureKey];

                    lightbox = document.getElementById("lightbox");
                    lightboxImg = document.getElementById("lightbox-img");
                    lightboxVideo = document.getElementById("lightbox-video");
                    lightboxVideoSrc = document.getElementById("lightbox-video-source");

                    if(!lightbox.classList.contains("lightbox-opened"))
                        lightbox.classList.add("lightbox-opened");

                    lightboxVideoSrc.removeAttribute("src");
                    lightboxImg.removeAttribute("src");

                    if(sequencesFiles[sequenceKey][pictureKey].includes('.MP4')) {
                        lightboxVideoSrc.src = filePath;
                        lightboxVideo.load();
                    }
                    else {
                        lightboxImg.src = filePath;
                    }

                    lightboxOpen = true;
                } else {
                    closeLightbox();
                }
            }
            function closeLightbox() {
                document.getElementById("lightbox").classList.remove("lightbox-opened");
                lightboxOpen = false;
            }
            function previousPictureLightbox() {
                openLightbox(currentSequenceKey, parseInt(currentPictureKey) - 1);
            }
            function nextPictureLightbox() {
                openLightbox(currentSequenceKey, parseInt(currentPictureKey) + 1);
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
                <div id="lightbox-previous" class="lightbox-navigation" onclick="previousPictureLightbox()"></div>
                <img id="lightbox-img"/>
                <video id="lightbox-video" controls>
                    <source id="lightbox-video-source" type="video/mp4">
                    Your browser does not support HTML5 video.
                </video>
                <div id="lightbox-next" class="lightbox-navigation" onclick="nextPictureLightbox()"></div>
            </div>
        </section>

        <footer id="main-footer"></footer>

        <script>
            window.addEventListener("keydown", function(event) {
                if(lightboxOpen) {
                    event.preventDefault();
                    switch(event.key) {
                        case "ArrowLeft":
                            previousPictureLightbox();
                            break;
                        case "ArrowRight":
                            nextPictureLightbox();
                            break;
                        case "Escape":
                            closeLightbox();
                            break;
                    }
                }
            }); 
        </script>
    </body>
</html>