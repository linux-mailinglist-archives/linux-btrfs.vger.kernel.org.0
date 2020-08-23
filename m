Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6C724ED53
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Aug 2020 15:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgHWN00 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Aug 2020 09:26:26 -0400
Received: from out1.migadu.com ([91.121.223.63]:3734 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgHWN0Z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Aug 2020 09:26:25 -0400
To:     linux-btrfs@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=billdietrich.me;
        s=default; t=1598189179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
        to:to:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
        bh=EXYbplRBozx3VPI4WAViOpDI/RWKGtI4j3Zt4Ctv8OY=;
        b=BV5GW1wBRL1th0QupFqoMjvprWp4RmAWCQB7fvvD0W9AgHkHg1KeNLBExZymcefDbTWH9v
        2tJZrxL5ESyU149s0oNhjXR9nvqU6irWMiZjP7t7i/FFHsQqkPrf3VK45SpUo0nnjQbxrM
        /8Xff6xNwq4cX2g7OoUsYgEqtkn10tM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Bill Dietrich <bill@billdietrich.me>
Subject: Minimum size of Btrfs volume ?
Autocrypt: addr=bill@billdietrich.me; keydata=
 xsDNBF8Yii8BDAC639t0VMAHf2YSJbOlWI37iE3T/AtYX7iyaxrPPRJ7Q4LU6j8DhNfStUJu
 lZx5kqBFaqUPJVvFArWywpm6aM9/vuT64yZde1s0hJoODRSillj3bpd47HwyF0syR1sl+nmm
 74FR3K1xMV6qFbv1M0yjMvLZHQbKfUtjFUOuSnBYWW4MLqhhV1Vj5goOM0Et9nHgrG+wSlnX
 cDFop2yKbLvRZJvJUGvIdWdU190PfLYTurxH3r6pAHRinKzZHaJBiipwcB/AEii70OHPXDNq
 rido9m1dLxHi0aW7UnI7rAyfuTI4PbRbBuk9OE7ZDFqm/yXsnXCkfHkzBvYKUqiMWqaDVN6Q
 xc7AB7oPEzxkPWaUKW/dZ5m0sSBp64LZJTHZ8fPxpkIwrjx8TOUHI5JTqPouIpBAzP2kB2Gs
 SzcvTPpyGTwiPVuHZptY3mFSgmNSqNBRg39norhT8aFyec8L2lvNb/PbA0X7MbQP2m+GgkkS
 0zcUl/gi8gZC/uvXKtJgqOcAEQEAAc0kQmlsbCBEaWV0cmljaCA8YmlsbEBiaWxsZGlldHJp
 Y2gubWU+wsEJBBMBCAAzFiEEJaTUrpB9dqxv81B595DU1xYkgEsFAl8YijACGwMFCwkIBwIG
 FQgJCgsCBRYCAwEAAAoJEPeQ1NcWJIBL+7IMAKsnMlC1sp7wg0WVcVFcMjhJyYzbkN3y6fFl
 nANsIHpUROXWXMIfslMSYeXMRieT7EJhh/r9YNwv+T52E/92DnmPdzHdsALZ+4GFwvX14Ai7
 2/bZRJOYegHDcXsAXAXOp2cCProQmUnGi+i4UJT25vsu0K5T/sQhh6KwsxF+bKW4abjl74qa
 cq194o3Gx1eqUb98Xbkfma14R8OLxV5gxdhCYKpQsIgBOVNzsGHk5JtAwXWAPb/bwgS0OgGS
 vDOELOOm84bsFrHBI4XNmZ7V93CqSvXzCxUyfihdeWOuI2NcZDOEq2C9YnFk0966puMT6yqo
 4JPcgn608McvaGV36r5vPspF+u1cEEcvikMbKd+6DwUKZGCsLxvK3PJjJHsByt8mGlib+7sn
 64Nue4gKWGf70g7IIKGRWQhdeWjLXHfaPFUF5TxWKgRAWM2tmSjyaC0EVUFMq5Jpp7vH0zql
 80YpIogHj2ihNp7h6urs5y8I9yfOmml2UCmYGbUg6HmDpc7AzQRfGIoxAQwAn9Ekw/rbE2qz
 1rsYPDRJ6+gycKYe8kDRI02UI/boh9SA+A9W0YJr38/n7dPDtYs4H1SYQPWUm2MOVmItkoE7
 5bYqxCBTSa2iE1fbBFqT1vKChK5xzD+Fs4Zhmi+ZlpPD0aDOrv9JnllQNRIJUNtBM3jsCKS+
 LaguTahsn1HGjbOE0WA/vSywCtiQwaP/mq6g7tBVxn4IOdbxKHDuXSIyongSXT00z3NHqlgS
 1yPzLPwRVX3V9O6lI6DA88pZG+yv1sONpxS/c7iHQDoQ+19s1WImp/J/wfiuvyLaeq+hAykt
 BaKEIc9FgF+elD3QEYmEJHXCbMg6OdPrUZWFGZY8ZidI92U1D7xs5fSNb23N6NdDL5ayy+Pl
 9ho+eljBFfAdbh5uLnWXcvzJQS2ftI6vVOIrHjteLc2VLF+BvXVBjGazH5vc+vu5W2cloihy
 UGKl9z3KRehtv4NQu2+/jTZFDNsN0F5R6PyS2yPBYlWuuFb6GZRxKSn30Jw7jQkTfiwRABEB
 AAHCwPYEGAEIACAWIQQlpNSukH12rG/zUHn3kNTXFiSASwUCXxiKMwIbDAAKCRD3kNTXFiSA
 S36FC/4yparVyGwyW8GjiB+zFrZ1mQY/LRn8m5+EH03WCp4Ajy4Pde2qgEiWus1/beQcLi/S
 D7Ro2tQyJYv4mJfuhroxCYSZcVBxt12rIKdJLLd47ZQnyJdemQI+Dnk0NIM/6xT7OYpJ3X6n
 LTT9VHrcqdlnSVt6Nsy/F9ehk4PNqu7e5Exe9F1Q176eUT/mrC/Y4m6qnV0X8y8m+QavFA7q
 nrdByhbLmyuExPbtV2B46h4qZsLucHQu3L1424KSC7UVJA2Xo0CF/a7z6ggyyAns7tMk8/1e
 5ambr/uYz09uU/7u9W8OwQP22bHJqd3Cytb4T1EvFN3S2AnfIslAJ/KGInLpyKMKaLWd5x4H
 gOZ0SiCwl86X41QEisAbp5yY7gOsxSXKiuh24LxXGgXO/k7hH7eEE8dvj9QvSLEDN35/Ju6+
 j8PjSajgaNJOiDcql6ByrBiUUiKPATQdaLQjYwxxt4WXstt/B/fXmhXUFNo0gfwVQYJAAIf0
 YzSgk+ywHGgZ8Ns=
Message-ID: <1de8d385-4f63-cf84-2a60-9519e55035bc@billdietrich.me>
Date:   Sun, 23 Aug 2020 15:26:18 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IvG0wEBZGbtNKO4IcMpQVs4t2Z0MiNzEc"
X-Spam-Score: -1.20
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--IvG0wEBZGbtNKO4IcMpQVs4t2Z0MiNzEc
Content-Type: multipart/mixed; boundary="VelYeNcALrT7Ecbh3KIuAilB7AddQAFlI";
 protected-headers="v1"
From: Bill Dietrich <bill@billdietrich.me>
To: linux-btrfs@vger.kernel.org
Message-ID: <1de8d385-4f63-cf84-2a60-9519e55035bc@billdietrich.me>
Subject: Minimum size of Btrfs volume ?

--VelYeNcALrT7Ecbh3KIuAilB7AddQAFlI
Content-Type: multipart/mixed;
 boundary="------------3680D9592C4CC5A9011A0ECC"
Content-Language: en-US

--------------3680D9592C4CC5A9011A0ECC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[Noob here, sorry if I'm doing anything wrong.]

What is the minimum size of a simple single-disk Btrfs volume,
and where is it documented ?=C2=A0 I can't find that info.

I'm told the minimum size is about 109 MB (114294784 bytes).
True ?=C2=A0 Is there any way to get around that, at mkfs-time ?
I'd like to use Btrfs inside a VeraCrypt container, and that's
a fairly big minimum size for that use.

I'm using Btrfs on Ubuntu GNOME 20.04 desktop.

Thanks,

Bill Dietrich
bill@billdietrich.me



-- Email domain proudly hosted at https://migadu.com

--------------3680D9592C4CC5A9011A0ECC
Content-Type: application/pgp-keys;
 name="OpenPGP_0xF790D4D71624804B.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="OpenPGP_0xF790D4D71624804B.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsDNBF8Yii8BDAC639t0VMAHf2YSJbOlWI37iE3T/AtYX7iyaxrPPRJ7Q4LU6j8DhNfStUJul=
Zx5
kqBFaqUPJVvFArWywpm6aM9/vuT64yZde1s0hJoODRSillj3bpd47HwyF0syR1sl+nmm74FR3=
K1x
MV6qFbv1M0yjMvLZHQbKfUtjFUOuSnBYWW4MLqhhV1Vj5goOM0Et9nHgrG+wSlnXcDFop2yKb=
LvR
ZJvJUGvIdWdU190PfLYTurxH3r6pAHRinKzZHaJBiipwcB/AEii70OHPXDNqrido9m1dLxHi0=
aW7
UnI7rAyfuTI4PbRbBuk9OE7ZDFqm/yXsnXCkfHkzBvYKUqiMWqaDVN6Qxc7AB7oPEzxkPWaUK=
W/d
Z5m0sSBp64LZJTHZ8fPxpkIwrjx8TOUHI5JTqPouIpBAzP2kB2GsSzcvTPpyGTwiPVuHZptY3=
mFS
gmNSqNBRg39norhT8aFyec8L2lvNb/PbA0X7MbQP2m+GgkkS0zcUl/gi8gZC/uvXKtJgqOcAE=
QEA
Ac0kQmlsbCBEaWV0cmljaCA8YmlsbEBiaWxsZGlldHJpY2gubWU+wsEJBBMBCAAzFiEEJaTUr=
pB9
dqxv81B595DU1xYkgEsFAl8YijACGwMFCwkIBwIGFQgJCgsCBRYCAwEAAAoJEPeQ1NcWJIBL+=
7IM
AKsnMlC1sp7wg0WVcVFcMjhJyYzbkN3y6fFlnANsIHpUROXWXMIfslMSYeXMRieT7EJhh/r9Y=
Nwv
+T52E/92DnmPdzHdsALZ+4GFwvX14Ai72/bZRJOYegHDcXsAXAXOp2cCProQmUnGi+i4UJT25=
vsu
0K5T/sQhh6KwsxF+bKW4abjl74qacq194o3Gx1eqUb98Xbkfma14R8OLxV5gxdhCYKpQsIgBO=
VNz
sGHk5JtAwXWAPb/bwgS0OgGSvDOELOOm84bsFrHBI4XNmZ7V93CqSvXzCxUyfihdeWOuI2NcZ=
DOE
q2C9YnFk0966puMT6yqo4JPcgn608McvaGV36r5vPspF+u1cEEcvikMbKd+6DwUKZGCsLxvK3=
PJj
JHsByt8mGlib+7sn64Nue4gKWGf70g7IIKGRWQhdeWjLXHfaPFUF5TxWKgRAWM2tmSjyaC0EV=
UFM
q5Jpp7vH0zql80YpIogHj2ihNp7h6urs5y8I9yfOmml2UCmYGbUg6HmDpc7AzQRfGIoxAQwAn=
9Ek
w/rbE2qz1rsYPDRJ6+gycKYe8kDRI02UI/boh9SA+A9W0YJr38/n7dPDtYs4H1SYQPWUm2MOV=
mIt
koE75bYqxCBTSa2iE1fbBFqT1vKChK5xzD+Fs4Zhmi+ZlpPD0aDOrv9JnllQNRIJUNtBM3jsC=
KS+
LaguTahsn1HGjbOE0WA/vSywCtiQwaP/mq6g7tBVxn4IOdbxKHDuXSIyongSXT00z3NHqlgS1=
yPz
LPwRVX3V9O6lI6DA88pZG+yv1sONpxS/c7iHQDoQ+19s1WImp/J/wfiuvyLaeq+hAyktBaKEI=
c9F
gF+elD3QEYmEJHXCbMg6OdPrUZWFGZY8ZidI92U1D7xs5fSNb23N6NdDL5ayy+Pl9ho+eljBF=
fAd
bh5uLnWXcvzJQS2ftI6vVOIrHjteLc2VLF+BvXVBjGazH5vc+vu5W2cloihyUGKl9z3KRehtv=
4NQ
u2+/jTZFDNsN0F5R6PyS2yPBYlWuuFb6GZRxKSn30Jw7jQkTfiwRABEBAAHCwPYEGAEIACAWI=
QQl
pNSukH12rG/zUHn3kNTXFiSASwUCXxiKMwIbDAAKCRD3kNTXFiSAS36FC/4yparVyGwyW8Gji=
B+z
FrZ1mQY/LRn8m5+EH03WCp4Ajy4Pde2qgEiWus1/beQcLi/SD7Ro2tQyJYv4mJfuhroxCYSZc=
VBx
t12rIKdJLLd47ZQnyJdemQI+Dnk0NIM/6xT7OYpJ3X6nLTT9VHrcqdlnSVt6Nsy/F9ehk4PNq=
u7e
5Exe9F1Q176eUT/mrC/Y4m6qnV0X8y8m+QavFA7qnrdByhbLmyuExPbtV2B46h4qZsLucHQu3=
L14
24KSC7UVJA2Xo0CF/a7z6ggyyAns7tMk8/1e5ambr/uYz09uU/7u9W8OwQP22bHJqd3Cytb4T=
1Ev
FN3S2AnfIslAJ/KGInLpyKMKaLWd5x4HgOZ0SiCwl86X41QEisAbp5yY7gOsxSXKiuh24LxXG=
gXO
/k7hH7eEE8dvj9QvSLEDN35/Ju6+j8PjSajgaNJOiDcql6ByrBiUUiKPATQdaLQjYwxxt4WXs=
tt/
B/fXmhXUFNo0gfwVQYJAAIf0YzSgk+ywHGgZ8Ns=3D
=3DQ3fd
-----END PGP PUBLIC KEY BLOCK-----

--------------3680D9592C4CC5A9011A0ECC--

--IvG0wEBZGbtNKO4IcMpQVs4t2Z0MiNzEc
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFqEEJaTUrpB9dqxv81B595DU1xYkgEsFAl9CbnoFAwAAAAAACgkQ95DU1xYkgEsL
Hwv/T78yXHLqUH499OIXmg3L95+cKMtyXUM4uHIEAcCAv6etOn0Kkz2b+BdzqAmHMUdlZ6kKTMGl
H1JnCzS0Ks0Lu/nd9+ETQPksJFtAEGNCRpFPKm5rL7BTP/0QKFjKSu3HiSiiHR+w7JuO9qHNWHUW
9my0xx2fRPSC31hjmyOGVYeM08GgCeMWloLDbf2xsEwHkezTyDXPmaJ1WTRAKvXqiSF5d1s+/gAT
noX1mSc7Z9LOn1fBkMvvgRoccV5zu0gPoJJI8xB8v0KTOHX+lHCsoLoCDGTJOuxShD7p9djcdQme
gogRbSgQP7ql6AEF+jcqybKrqt6x2s3+W5o6D2tEN6l6/I5EggNsGBtwezQmqlWR4uR1LFwYDyrr
BD9hl2juU/vq8ORiteGhaL74v+KXyfpwC7G0ZmmOaXSszMN8lUW6+rq6pMsO6j40VgR0aW0Z893A
r2eV38M5twX6XJguhwmGjnM4EXL87CUy0xIxsEyvXzMDolQeHLAe8nRT5jh/
=D5GB
-----END PGP SIGNATURE-----

--VelYeNcALrT7Ecbh3KIuAilB7AddQAFlI--

--IvG0wEBZGbtNKO4IcMpQVs4t2Z0MiNzEc--
