<?php

include __DIR__.'/../vendor/autoload.php';

use Vittee\ThaiNum\ThaiNum;

var_dump(ThaiNum::text(1234.00002));
var_dump(ThaiNum::bahtText(1234.21000000));
var_dump(ThaiNum::bahtText(-6974321.756890000));