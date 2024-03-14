// app_24.sh
// app_25.sh
function de_2_base64(link_2_url){
	var de_2_link = link_2_url.replace(new RegExp('_',"g"), '/').replace(new RegExp('-',"g"), '+');
	var patt1=/[^A-Za-z0-9+\/\=:]+/;
	var de_2_link_tmp = String(de_2_link.match(patt1));
	if(String(de_2_link_tmp) == "null"){
		return Base64.decode(de_2_link);
	}else{
		return link_2_url;
	}
}

function link_d(link_url){
link_protocol_d = "";
link_name_d = "";
link_remote_host_d="";
link_method_d="";
link_input="";
link_wget="";

var link = link_url;
if(link.indexOf('#') == 0){
	link_protocol_d = '#';
	return ;
}
if(link.indexOf('🔗') != -1){
	link_wget="🔗";
}
if(link.indexOf('ss://') != -1){
	if(link.indexOf('vmess://') == -1 && link.indexOf('vless://') == -1){
		link_protocol_d = 'ss';
		var decodeLink1 = link.split('ss://');
		var link = decodeLink1[1].replace('ss://', '');
		link_input = 'ss://' + link;
		var link = de_2_base64(link); // 链接2次解码
		if(link.indexOf('#') != -1){
			var decodeLink1 = link.split('#');
			link_name_d = decodeURIComponent(decodeLink1[1]);
			var decodeLink = decodeLink1[0]
		}else{
			var decodeLink = link;
		}
		var decodeLink = de_2_base64(decodeLink); // 链接2次解码
		var patt1=/@.+:/;
		var patt2=/[^@].+[^:]/;
		link_remote_host_d = String(String(decodeLink.match(patt1)).match(patt2));
		var patt1=/^[^@]+/;
		link_methodpassword = String(String(decodeLink.match(patt1)));
		if(link_methodpassword.indexOf(':') == -1){
			var link_methodpassword = de_2_base64(link_methodpassword); // 链接2次解码
		}
		if(link_methodpassword.indexOf(':') != -1){
			link_method_d = link_methodpassword.split(':')[0];
		}
		if (String(link_name_d) == "" || String(link_name_d) == "undefined" || String(link_name_d) == "null"){
			link_name_d = "♯" + link_remote_host_d;
		}
	}
}

if(link.indexOf('ssr://') != -1){
	link_protocol_d = 'ssr';
	var decodeLink1 = link.split('ssr://');
	var link = decodeLink1[1].replace('ssr://', '');
	link_input = 'ssr://' + link;
	var link = de_2_base64(link); // 链接2次解码
	var patt1=/.+[:]+[0-9]+/;
	var patt2=/.+:/;
	var patt3=/.+[^:]/;
	link_remote_host_d = String(String(String(link.match(patt1)).match(patt2)).match(patt3));
	var patt3=/remarks\=[^\&]+/;
	var ex_remarks=String(link.match(patt3));
	if (String(ex_remarks) != "" && String(ex_remarks) != "undefined" && String(ex_remarks) != "null"){
		link_name_d = Base64.decode(ex_remarks.split('=')[1]);
	}else{
		link_name_d = '♯' + link_remote_host_d;
	}
}
if(link.indexOf('vmess://') != -1){
	link_protocol_d = 'vmess';
	var decodeLink1 = link.split('vmess://');
	var link = decodeLink1[1].replace('vmess://', '');
	link_input = 'vmess://' + link;
	var link = de_2_base64(link); // 链接2次解码
	try {
		var link_obj = JSON.parse(link);
		link_remote_host_d = link_obj.add;
		if (String(link_obj.ps) != "" && String(link_obj.ps) != "undefined" && String(link_obj.ps) != "null"){
			link_name_d = link_obj.ps;
		}else{
			if (String(link_obj.remark) != "" && String(link_obj.remark) != "undefined" && String(link_obj.remark) != "null"){
				link_name_d = link_obj.remark;
			}else{
				link_name_d = '♯' + link_remote_host_d;
			}
		}
	} catch(err) {
		link_protocol_d = 'vless_vmess';
		link = link_input;
	}
}
if(link.indexOf('vless://') != -1 || link_protocol_d == "vless_vmess"){
	link_protocol_d = '';
	if(link.indexOf('vless://') != -1){
		link_protocol_d = 'vless';
		var decodeLink1 = link.split('vless://');
		var link = decodeLink1[1].replace('vless://', '');
		link_input = 'vless://' + link;
	}
	if(link.indexOf('vmess://') != -1){
		link_protocol_d = 'vmess';
		var decodeLink1 = link.split('vmess://');
		var link = decodeLink1[1].replace('vmess://', '');
		link_input = 'vmess://' + link;
	}
	var link = de_2_base64(link); // 链接2次解码
	if(link.indexOf('#') != -1){
		var decodeLink1 = link.split('#');
		link_name_d = decodeURIComponent(decodeLink1[1]);
		var decodeLink = decodeLink1[0]
	}else{
		var decodeLink = link;
	}
	var patt1=/@.+:/;
	var patt2=/[^@].+[^:]/;
	link_remote_host_d = String(String(decodeLink.match(patt1)).match(patt2));
	if (String(link_name_d) == "" || String(link_name_d) == "undefined" || String(link_name_d) == "null"){
		link_name_d = "♯" + link_remote_host_d;
	}
}

if(link.indexOf('trojan://') != -1){
	link_protocol_d = 'trojan';
	var decodeLink1 = link.split('trojan://');
	var link = decodeLink1[1].replace('trojan://', '');
	link_input = 'trojan://' + link;
	var link = de_2_base64(link); // 链接2次解码
	if(link.indexOf('#') != -1){
		var decodeLink1 = link.split('#');
		link_name_d = decodeURIComponent(decodeLink1[1]);
		var decodeLink = decodeLink1[0]
	}else{
		var decodeLink = link;
	}
	var decodeLink = de_2_base64(decodeLink); // 链接2次解码
	var patt1=/@.+:/;
	var patt2=/[^@].+[^:]/;
	link_remote_host_d = String(String(decodeLink.match(patt1)).match(patt2));
	if (String(link_remote_host_d) == "" || String(link_remote_host_d) == "undefined" || String(link_remote_host_d) == "null"){
		patt1=/@[^#\?]+/;
		patt2=/[^@].+/;
		link_remote_host_d = String(String(decodeLink.match(patt1)).match(patt2));
	}
	if (String(link_name_d) == "" || String(link_name_d) == "undefined" || String(link_name_d) == "null"){
		link_name_d = "♯" + link_remote_host_d;
	}
}

}

function decodeUnicode(str){
	str = str.replace(/\\/g, "%");
	return unescape(str);
}

;(function (global, factory) {
    typeof exports === 'object' && typeof module !== 'undefined'
        ? module.exports = factory(global)
        : typeof define === 'function' && define.amd
        ? define(factory) : factory(global)
}((
    typeof self !== 'undefined' ? self
        : typeof window !== 'undefined' ? window
        : typeof global !== 'undefined' ? global
: this
), function(global) {
    'use strict';
    // existing version for noConflict()
    global = global || {};
    var _Base64 = global.Base64;
    var version = "2.5.2";
    // if node.js and NOT React Native, we use Buffer
    var buffer;
    if (typeof module !== 'undefined' && module.exports) {
        try {
            buffer = eval("require('buffer').Buffer");
        } catch (err) {
            buffer = undefined;
        }
    }
    // constants
    var b64chars
        = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
    var b64tab = function(bin) {
        var t = {};
        for (var i = 0, l = bin.length; i < l; i++) t[bin.charAt(i)] = i;
        return t;
    }(b64chars);
    var fromCharCode = String.fromCharCode;
    // encoder stuff
    var cb_utob = function(c) {
        if (c.length < 2) {
            var cc = c.charCodeAt(0);
            return cc < 0x80 ? c
                : cc < 0x800 ? (fromCharCode(0xc0 | (cc >>> 6))
                                + fromCharCode(0x80 | (cc & 0x3f)))
                : (fromCharCode(0xe0 | ((cc >>> 12) & 0x0f))
                    + fromCharCode(0x80 | ((cc >>>  6) & 0x3f))
                    + fromCharCode(0x80 | ( cc         & 0x3f)));
        } else {
            var cc = 0x10000
                + (c.charCodeAt(0) - 0xD800) * 0x400
                + (c.charCodeAt(1) - 0xDC00);
            return (fromCharCode(0xf0 | ((cc >>> 18) & 0x07))
                    + fromCharCode(0x80 | ((cc >>> 12) & 0x3f))
                    + fromCharCode(0x80 | ((cc >>>  6) & 0x3f))
                    + fromCharCode(0x80 | ( cc         & 0x3f)));
        }
    };
    var re_utob = /[\uD800-\uDBFF][\uDC00-\uDFFFF]|[^\x00-\x7F]/g;
    var utob = function(u) {
        return u.replace(re_utob, cb_utob);
    };
    var cb_encode = function(ccc) {
        var padlen = [0, 2, 1][ccc.length % 3],
        ord = ccc.charCodeAt(0) << 16
            | ((ccc.length > 1 ? ccc.charCodeAt(1) : 0) << 8)
            | ((ccc.length > 2 ? ccc.charCodeAt(2) : 0)),
        chars = [
            b64chars.charAt( ord >>> 18),
            b64chars.charAt((ord >>> 12) & 63),
            padlen >= 2 ? '=' : b64chars.charAt((ord >>> 6) & 63),
            padlen >= 1 ? '=' : b64chars.charAt(ord & 63)
        ];
        return chars.join('');
    };
    var btoa = global.btoa ? function(b) {
        return global.btoa(b);
    } : function(b) {
        return b.replace(/[\s\S]{1,3}/g, cb_encode);
    };
    var _encode = function(u) {
        var isUint8Array = Object.prototype.toString.call(u) === '[object Uint8Array]';
        return isUint8Array ? u.toString('base64')
            : btoa(utob(String(u)));
    }
    var encode = function(u, urisafe) {
        return !urisafe
            ? _encode(u)
            : _encode(String(u)).replace(/[+\/]/g, function(m0) {
                return m0 == '+' ? '-' : '_';
            }).replace(/=/g, '');
    };
    var encodeURI = function(u) { return encode(u, true) };
    // decoder stuff
    var re_btou = /[\xC0-\xDF][\x80-\xBF]|[\xE0-\xEF][\x80-\xBF]{2}|[\xF0-\xF7][\x80-\xBF]{3}/g;
    var cb_btou = function(cccc) {
        switch(cccc.length) {
        case 4:
            var cp = ((0x07 & cccc.charCodeAt(0)) << 18)
                |    ((0x3f & cccc.charCodeAt(1)) << 12)
                |    ((0x3f & cccc.charCodeAt(2)) <<  6)
                |     (0x3f & cccc.charCodeAt(3)),
            offset = cp - 0x10000;
            return (fromCharCode((offset  >>> 10) + 0xD800)
                    + fromCharCode((offset & 0x3FF) + 0xDC00));
        case 3:
            return fromCharCode(
                ((0x0f & cccc.charCodeAt(0)) << 12)
                    | ((0x3f & cccc.charCodeAt(1)) << 6)
                    |  (0x3f & cccc.charCodeAt(2))
            );
        default:
            return  fromCharCode(
                ((0x1f & cccc.charCodeAt(0)) << 6)
                    |  (0x3f & cccc.charCodeAt(1))
            );
        }
    };
    var btou = function(b) {
        return b.replace(re_btou, cb_btou);
    };
    var cb_decode = function(cccc) {
        var len = cccc.length,
        padlen = len % 4,
        n = (len > 0 ? b64tab[cccc.charAt(0)] << 18 : 0)
            | (len > 1 ? b64tab[cccc.charAt(1)] << 12 : 0)
            | (len > 2 ? b64tab[cccc.charAt(2)] <<  6 : 0)
            | (len > 3 ? b64tab[cccc.charAt(3)]       : 0),
        chars = [
            fromCharCode( n >>> 16),
            fromCharCode((n >>>  8) & 0xff),
            fromCharCode( n         & 0xff)
        ];
        chars.length -= [0, 0, 2, 1][padlen];
        return chars.join('');
    };
    var _atob = function(a){
        return a.replace(/\S{1,4}/g, cb_decode);
    };
    var atob = function(a) {
        return _atob(String(a).replace(/[^A-Za-z0-9\+\/]/g, ''));
    };
    var _decode = buffer ?
        buffer.from && Uint8Array && buffer.from !== Uint8Array.from
        ? function(a) {
            return (a.constructor === buffer.constructor
                    ? a : buffer.from(a, 'base64')).toString();
        }
        : function(a) {
            return (a.constructor === buffer.constructor
                    ? a : new buffer(a, 'base64')).toString();
        }
        : function(a) { return btou(_atob(a)) };
    var decode = function(a){
        return _decode(
            String(a).replace(/[-_]/g, function(m0) { return m0 == '-' ? '+' : '/' })
                .replace(/[^A-Za-z0-9\+\/]/g, '')
        );
    };
    var noConflict = function() {
        var Base64 = global.Base64;
        global.Base64 = _Base64;
        return Base64;
    };
    // export Base64
    global.Base64 = {
        VERSION: version,
        atob: atob,
        btoa: btoa,
        fromBase64: decode,
        toBase64: encode,
        utob: utob,
        encode: encode,
        encodeURI: encodeURI,
        btou: btou,
        decode: decode,
        noConflict: noConflict,
        __buffer__: buffer
    };
    // if ES5 is available, make Base64.extendString() available
    if (typeof Object.defineProperty === 'function') {
        var noEnum = function(v){
            return {value:v,enumerable:false,writable:true,configurable:true};
        };
        global.Base64.extendString = function () {
            Object.defineProperty(
                String.prototype, 'fromBase64', noEnum(function () {
                    return decode(this)
                }));
            Object.defineProperty(
                String.prototype, 'toBase64', noEnum(function (urisafe) {
                    return encode(this, urisafe)
                }));
            Object.defineProperty(
                String.prototype, 'toBase64URI', noEnum(function () {
                    return encode(this, true)
                }));
        };
    }
    //
    // export Base64 to the namespace
    //
    if (global['Meteor']) { // Meteor.js
        Base64 = global.Base64;
    }
    // module.exports and AMD are mutually exclusive.
    // module.exports has precedence.
    if (typeof module !== 'undefined' && module.exports) {
        module.exports.Base64 = global.Base64;
    }
    else if (typeof define === 'function' && define.amd) {
        // AMD. Register as an anonymous module.
        define([], function(){ return global.Base64 });
    }
    // that's it!
    return {Base64: global.Base64}
}));