<?php 
namespace Vittee\ThaiNum;

class ThaiNum {
	private static $digitNames = ['ศูนย์', 'หนึ่ง', 'สอง', 'สาม', 'สี่', 'ห้า', 'หก', 'เจ็ด', 'แปด', 'เก้า'];
	private static $unitNames = ['', 'สิบ', 'ร้อย', 'พัน', 'หมื่น', 'แสน', 'ล้าน'];

	private static function digitize($n, callable $m = null) {
		if (!is_string($n)) {
			$n = number_format($n, 0, '.', '');
		}

		$n = array_filter(str_split($n), function($d) { return (bool) preg_match('/[0-9]/', $d); });
		return is_callable($m) ? array_map($m, $n) : $n;
	}

	private static function plain($n) {
		return implode(self::digitize($n, function($d) { return self::$digitNames[(int) $d]; }));
	}

	private static function convert($n) {
		if ((float) $n >= 1e21) {
			return '';
		}

		$nn = self::digitize($n, function($d) { return (int) $d; });

		if (count($nn) == 1) {
			return ($n<0?'ลบ':'').self::$digitNames[$nn[0]];
		}

		$nn = array_reduce($nn, function($a, $d) {
			$c = ($a->l-$a->i-1) % 6;

			if ($d == 2 && $c == 1) {
				$a->s .= 'ยี่';
			} else if ($d == 1 && $c == 0 && $a->t) {
				$a->s .= 'เอ็ด';
			} else if (($d != 1 || $c != 1) && ($d != 0)) {
				$a->s .= self::$digitNames[$d];
			}

			if ($c && $d) {
				$a->s .= self::$unitNames[$c];
			}

			if ($c == 0 && $a->i != $a->l-1) {
				$a->s .= self::$unitNames[6];
			}

			if ($c == 1) {
				$a->t = $d != 0;
			}

			$a->i++;
			return $a;
		}, (object) ['t'=>false, 'i'=>0, 'l'=>count($nn), 's'=>$n<0?'ลบ':'']);

		return $nn->s;
	}

	private static function part($n) {
		$n = (float) $n;
		$i = ($n>0) ? floor($n) : ceil($n);
		$f = abs($n) - abs($i);

		return (object) ['i'=>$i, 'f'=>$f];
	}

	public static function bahtText($n) {
		$n = self::part($n);
		$n->f = floor($n->f*100);
		return self::convert($n->i).'บาท'.($n->f>0?self::convert($n->f).'สตางค์':'');
	}

	public static function text($n) {
	    $p = self::part($n);
	    $fp = explode('.', (string) $n, 2);
	    return self::convert($p->i).($p->f>0?'จุด'.self::plain(end($fp)):'');
	}
}