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
    
        if($files) {
            foreach($files as $key => $value) {
                if($value != '.' || $value != '..') {
                    echo '
                    <div class="picture">
                        <div class="picture-img-container">
                            <img src="'.$directory_url.'/'.$value.'"/>
                        </div>
                        <div class="picture-name">'.$value.'</div>
                    </div>
                    ';
                }
            }
        }
        echo '
        </div>
        ';
    }

    ?>
</section>