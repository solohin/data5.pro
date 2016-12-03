<?php
/**
 * Created by solohin.i@gmail.com.
 * http://data5.pro
 * https://www.upwork.com/freelancers/~0110e79b44736be7ab
 * Date: 03/12/16
 * Time: 08:33
 */

preg_match_all(
    '#\bhttps?://[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|/))#',
    file_get_contents('http://solohin.tilda.ws/page456205.html'),
    $match
);

$linksArr = array_unique($match[0]);
sort($linksArr);
$links = implode("\n", $linksArr);
file_put_contents('links.txt', $links);
