;(function (undefined) {
  var digitNames = ['ศูนย์', 'หนึ่ง', 'สอง', 'สาม', 'สี่', 'ห้า', 'หก', 'เจ็ด', 'แปด', 'เก้า'];
  var unitNames = ['', 'สิบ', 'ร้อย', 'พัน', 'หมื่น', 'แสน', 'ล้าน'];

  function digitnumber(d) {
    return +d;
  }

  function digit2name(d) {
    return digitNames[+d];
  }

  function digitize(n,m) {
    return n.toString().split('').filter(function(c) { return /[0-9]/.test(c); }).map(m);
  }

  function plain(n) {    
    return digitize(n, digit2name).join('');
  }

  function convert(n) {
    return +n>=1e21 ? '' : (function(nn) {
      return nn.length==1 ? digitNames[nn[0]] : nn.reduce(function(a, d, i) {
          var c = (a.l-i-1) % 6;

          a.s += (d == 2 && c == 1) ? 'ยี่' : (d == 1 && c == 0 && a.t) ? 'เอ็ด' : ((d == 1 && c == 1) || d == 0) ? '' : digitNames[d];

          if (c && d) {
            a.s += unitNames[c];             
          }

          if (c == 0 && i != a.l-1) {
            a.s += unitNames[6];
          }      

          if (c == 1) {
            a.t = d != 0;
          }

          return a;
        }, {s:n<0?'ลบ':'',t:false,l:nn.length}).s;

    })(digitize(n, digitnumber));
  }

  function part(n) {
    return (function(m){return{i:(+n>0?m.floor:m.ceil)(+n),f:m.abs(+n)%1}})(Math);
  }

  function baht(n) {
    n=part(n);
    n.f=Math.floor(n.f*100);
    return convert(n.i)+'บาท'+(n.f>0?convert(n.f)+'สตางค์':'');
  }

  function text(n) {
    var p=part(n);
    return convert(p.i)+(p.f>0?'จุด'+plain((+n).toString().split('.').pop()):'');
  }

  var hasModule = (typeof module !== 'undefined' && module && module.exports),
      globalScope = (typeof global !== 'undefined' && (typeof window === 'undefined' || window === global.window)) ? global : this,

      ThaiNum = {
        text: text,
        bahtText: baht
      };


  if (hasModule) {
    module.exports = ThaiNum;
  } else if (typeof define === 'function' && define.amd) {
    define(function (require, exports, module) {
        return ThaiNum;
    });
  } else {
    globalScope.ThaiNum = ThaiNum; 
  }
}).call(this);