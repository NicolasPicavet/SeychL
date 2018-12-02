<header id="pictures-header">

</header>
<section id="pictures-content">
    <?php
    $seq=1;
    $directory = __DIR__.'/seq'.$seq;
    $directory_url = 'pictures/seq'.$seq;
    $files = array_diff(scandir($directory), array('..', '.'));

    if($files) {
        foreach($files as $key => $value) {
            if($value != '.' || $value != '..') {
                echo '
                <div class="picture">
                    <div>'.$value.'</div>
                    <img src="'.$directory_url.'/'.$value.'"/>
                </div>
                ';
            }
        }
    }

    ?>
</section>