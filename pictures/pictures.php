<header id="pictures-header">
    <?php
    $sequences = 3;

    echo '
    <select onchange="selectSequence()" id="sequence-select">
    ';
    for($seq = 1; $seq <= $sequences; $seq++) {
        echo '
        <option value="'.$seq.'">'.$seq.'</option>
        ';
    }
    echo '
    </select>
    ';
    ?>
</header>
<section id="pictures-content">
    <?php
    for($seq = 1; $seq <= $sequences; $seq++) {
        echo '
        <div class="sequence"
        ';
        if($seq == 1) {
            echo '
            id="sequence-selected"
            ';
        }
        echo '
        >
        ';
        $directory = __DIR__.'/seq'.$seq;
        $directory_url = 'pictures/seq'.$seq;
        $files = array_diff(scandir($directory), array('..', '.'));

        ?>

        <script type="text/javascript">
            sequencesFiles[<?php echo $seq; ?>] = <?php echo json_encode($files); ?>;
            sequencePaths[<?php echo $seq; ?>] = <?php echo json_encode($directory_url); ?>;
        </script>

        <?php
    
        if($files) {
            foreach($files as $key => $value) {
                echo '
                <div class="picture" onclick="openLightbox(\''.$seq.'\',\''.$key.'\')">
                    <div class="picture-img-container">
                        <img src="'.$directory_url.'/'.$value.'"/>
                    </div>
                    <div class="picture-name">'.$value.'</div>
                </div>
                ';
            }
        }
        echo '
        </div>
        ';
    }

    ?>
</section>