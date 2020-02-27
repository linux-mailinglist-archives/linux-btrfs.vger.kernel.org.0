Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F80717127F
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 09:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgB0I0D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 03:26:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:43289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbgB0I0C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 03:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582791960;
        bh=9jqWe9QprVPw7Mn+lQulO2O0SINGFitZsSbA5mUb5AA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JaOnxHFFisRZ+tOFztCymcISQL7bmBnBkVVweNDOG9qDvOd+kTKmjos4MBnGfFmpd
         Y+srR2340jxxnvelK8gHT+vWWJ57A4A89pBSJ/5tJM4OS8l4LRlVBYrWKFAJOryEk/
         FAXObHZU27yhGk2dmtmQzUf7FnBPI7sZwbqLMuTk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6sn1-1jTVqC37vj-018Jcy; Thu, 27
 Feb 2020 09:26:00 +0100
Subject: Re: corrupt leaf
To:     4e868df3 <4e868df3@gmail.com>, linux-btrfs@vger.kernel.org
References: <CADq=pg=g47zrfKiqGFUHOJg8=+bdSGQeawihKcVcp_BahzPT+Q@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <587446db-5168-d91d-c1fa-c7bef48959d9@gmx.com>
Date:   Thu, 27 Feb 2020 16:25:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CADq=pg=g47zrfKiqGFUHOJg8=+bdSGQeawihKcVcp_BahzPT+Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jLl4yywjUU0rZLmhRODuvCEDl3wIJIakv"
X-Provags-ID: V03:K1:nJx1IbEdTSY5NAIwghPfuVPlp1kVG9cMWUfMsrm3nS+EzHzN9qz
 ++4aGvKqcPeIaBQN35Np++JJQRFQ4gOAbaX3hMEucH8M3CtqfLTzsNI3MSKngZR1kz2x2bb
 RdP3T5EQv7jv6247Tw+X5Ji+J5q3r4QYVYr6Hp/h8USyPrJ3DZqc/FvYzL6pBGs3eB+VlGu
 tY/cIDQqSMu7XVpvb79Lw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:a0jkKsTwL5w=:ObFG+xDjtkqbIPO83LrgAF
 1VpYDpjBDN2zoAQQlMHk+U/krSIUItziHzRaam2YpvLy4Q0bjPhBXSGIJ4fvZLZQU4VncELIo
 lRVHo/w/B46/oD1GPbrLDUM4/hKRJ4z9m2AHM3fg7ovSTlSEmFsJRHwhzblZcUv0hii0GzoNd
 Hi+2avEVTmTqfR6dJVKxpT5C5of+JEy+5xo/221LH9Fbdbo82yoXBJTFfvxvtqsqbIW6D84Hw
 Ie0QyNJhdaQtHv+PbqOKoQ2KneYmjmTr4vYK08hVAkAwyQYRYPWa7H1o1V11stkFWF/rDPKqa
 bRxoXi8VJERdGGsRNGAkySAKEXx12Bwn2QQN2bs4cRXKFjA7kcSNXkXcgr6nLcCM3E0ZlBBaA
 /5yJErCrj1eikpND2m2c1odwNdF2+jD2w3zhd2+kCw/kWKoN5LzfhBlCeyFuTFxKghJ3xQToK
 z+pMElMmS/PUwjabuOuihZIKdblFvNeQrCBI4iloGzpVqwWInp+0VSOrHLfV/8gWKvv7KFlbJ
 i+MuMgilZkQl/mwoTXckKfPId6X5drQYnlGZsJmD8Mha08KX9saD6GE3HtGqSLR/UaxRbGi5j
 3qFeaREMH8GRnUNOQ8SBqiu555wkjASrm82HfzmpyOZex3JtYh4G9GoICMX3JYH00y6eeukNC
 J7f4TkKavm4QyT1sw/6v2nu8f1Gddk5p8G1+SKuq3+AYfTl3h1T9797sk/BXu0vyrNfeC+gau
 hG/YQ4HbtBd2JL88XPk1mf8KfIjSM9n0KxloL+fTEFiprW+05okemURaXeHb0P6nJ0ArYRLzR
 QqsMiaa5mxcV53W9b7SUkwvzYdAx5b9Dt5QSMk9w/p9gMQSMVozULoCw/v0H+1sK9DyfRwb4K
 KUxDLXJEI4PFzgVHir5dPk4yAN5YtlDwxvGSJ+HM6K9yAjiaZyF7yQdwo4xLjWo26H6eS8EF3
 smn9JMMf+OA2g6DnUegpeAMGSDgEoMK7oxXdYR1Asp+30YwX9D1TGaNeGvaABwnndXNPE2QT6
 d+2uM/fLvvkpQ5nYAX+IXJObMcGSqPozFBrxuFBiJiDoNc/yFpa0Hn9hrvyYzeGZvuAZ5ufWv
 b0CeBFHUko7toVStsrciYn2mWiXEyj/WteXi9vyIDOfmbc8F0JynAd7rXOIuGXxPWd4NQb81U
 nazO1kdNmFSYqYa3tL6qoD6iWzdtGwFH12YIXs9t1a/2AcvWIYBbPYVraUGvo8DqQNmUOEzXY
 E5sTOiccRwvplRVxw
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jLl4yywjUU0rZLmhRODuvCEDl3wIJIakv
Content-Type: multipart/mixed; boundary="lQJrOBVpC3nYQjZzweOxh9eI3RUJl7Yen"

--lQJrOBVpC3nYQjZzweOxh9eI3RUJl7Yen
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/27 =E4=B8=8B=E5=8D=881:59, 4e868df3 wrote:
> I updated kernels recently and now am getting a corrupt leaf error.
> The drives decrypt and mount, and I can touch a file briefly until the
> mount switches over to read-only mode. Extended SMART tests show all 6
> of my drives have a healthy status. I have a backup of the data. The
> array is configured as RAID10. As the BTRFS filesystem remains
> accessible / read-only, I am able to take an additional backup. What
> is the best way to recover from this error?
>=20

> [  130.395696] BTRFS critical (device dm-0): corrupt leaf: root=3D7
block=3D2533706842112 slot=3D5, csum end range (68761223168) goes beyond =
the
start range (68761178112) of the next csum item
> [  130.395829] BTRFS error (device dm-0): block=3D2533706842112 read
time tree block corruption detected

This is not something caused by a powerloss, but more likely an older
kernel, or memory corruption.

Please provide the following command dump:
# btrfs ins dump-tree -b 2533706842112 /dev/dm-0

Furthermore, btrfs check output would be appreciated to ensure that's
the only corruption.

But from the generation mismatch, it looks like there are transid
mismatch error, which could be a bigger problem than your corrupted csum
tree.

Thanks,
Qu



--lQJrOBVpC3nYQjZzweOxh9eI3RUJl7Yen--

--jLl4yywjUU0rZLmhRODuvCEDl3wIJIakv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5XfRQACgkQwj2R86El
/qgzhgf/RWs8cSgXKPLlKSQv7vLbW8VR8sGKTcHpGLXCsv22t9NnBXTQAd+vxVqG
66sxxy8Novq2g+UmR4DHuEnZaw8QaylYQ4Rb+6lyMumLZucOH6NKF5HhGsZnf0gH
WKkMBfzU/RurxcJWAr4Wc8xnkxihei+OEuQory4SJgvmzsn+6CB8HedUdLCdoWYk
6WP0fPsOkH6IdXYLzVLhy8o3Nz8wmF4gSg1f/DnExBbmlcxtz3bv2c6ai9OIJZl5
apVbi44CR4nb6itm0fmhjFFJ10+R3vERP1UTwusrA7i+DCgHOjRsN78dVPXVLgaa
tckPV/iJjIW6PIXd6LqlJaOuJ+ZfUQ==
=Zqjw
-----END PGP SIGNATURE-----

--jLl4yywjUU0rZLmhRODuvCEDl3wIJIakv--
