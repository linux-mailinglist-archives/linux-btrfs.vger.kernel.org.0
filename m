Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F151287D7
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 07:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfLUGe3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 01:34:29 -0500
Received: from mout.gmx.net ([212.227.17.20]:57739 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfLUGe2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 01:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576910066;
        bh=jwev40Gv/6UYxEwqOtggB/sNUaaM286mD8HIyRlLtjA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DEiE6lSvid6fw6yg/W3lE2N85Vtla7C8z48oIJIexb0esZG/Gvzz2jB9+H11G6Awx
         LWqA+HVrsrpopDyjfXPpmNfRfqunIMtyY0s22WkIFMP6MuusuV9fs9LLI5PTr338bq
         6XULCE4/fb7H3oUsD9uZqbCxTa00eAOKk56fnGN4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbRjt-1i6jcW2paL-00bpVE; Sat, 21
 Dec 2019 07:34:26 +0100
Subject: Re: dump tree always shows compression level 3, zstd
To:     Chris Murphy <chris@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTcaSy+sm9JayVWXYu1fe7QXyWMmhCbJKwQs3Fuuzy15g@mail.gmail.com>
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
Message-ID: <6eaa5006-038c-c543-f714-279998168476@gmx.com>
Date:   Sat, 21 Dec 2019 14:34:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTcaSy+sm9JayVWXYu1fe7QXyWMmhCbJKwQs3Fuuzy15g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1ybb6Lq5J2JVsicCmjBwEvDXYyByD6x2y"
X-Provags-ID: V03:K1:YTN9moWedNTubjfrwWi5GbWnOSGlrbvq8xyzPhxWaPWYg4Re4Aa
 v1ElWes+Yb9Y+zOpPSGKjdYP07VR0U+ycRpWC9bRoNFR+Pjd1ymVipo/QJ1+rZRL6KEt7Bt
 zEEG6IbTajadnGlLxBOldTwdEGPvjKv8QdEB4xrJDXo/oC4+eBzlNNkcbv67HiNr3rsT48J
 8p/Qp0r3t2xc4k6bJe5aQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RIXWqSGuL7k=:/DEHl1CStvMgeT9lKaq7+z
 GbEFuWipQItbNsvNNOJq0iAW+oNYAh19uPBP2NtgpRSfndKzPHHoRYgv+smxIqH9TNwcOrbyD
 gXm/Ud04ikATsKnO/Oa/Sef84SgwMYS3XuFdGC/dfsToqxuXJ6XAH8N2kpl8sWp7b4kS/Nc4q
 tHrO7RCoEa86HxjKGolAvwy1hRtdTM50L/6sFFyYnWOUh/h65T2xSOMpE3+5Mu8sXHB9+eU4f
 uBBdzZBJdjS74mmWl5QiS6hMYqiHIQ3/vg0vb3BFF4AY/CbK3aP0ZZS5hsPgBSm2I+2kSKhj4
 jG1KV4G1PQtAFh6DYXLjN5Tp2nqXV3ANdpuZvgjRL97y1orHz7JQ/ywb/GNjBLq461oTcvMKp
 QZYJQQ0dRxHaoqAlcBf7i2+6JraOU1PmD+264+QXT6PDKJp5qS4fgcdsWe6KldDDvW89JdtyQ
 UOYAHYE0PGYN07EsMy4ltIEEsTpPQ9dSgVBBNCiIW1pg6ZXzBd9Yxwrw0FGEfpyhdteHrpoH6
 GqR51tg5PfsWl2G46wjcHBqFmJA1xyauLeT2RNQVZBKvGTDkdO7ksozob5/yV0e2dBa7sDdZh
 YOyN1ainOLdOrUncMPG30+TepPDM2ruzZO2qm214Fv0gQ3JnzKE8B/Gef/5rqkP/0mCDTneiR
 chiAsgkkdd1C7eBepHKNRwi0duBMeKhmaFCYDdbar0hyaVmf56h1rnPvB5ONpTh/zMxwEzDoP
 u5Zh/iX1DJbeQKP4bCBeukijnglDTk68Nu6TtdbHAYi5Ju4Ylh7i860tqLaTXRSUPUGEbBSaw
 arfn+iC4mZKi1lrdGg5AfoUtsZ0yY0iU+Xn+hwd/+eOKHzcE6VsUk9QqRPWdpYTZhL1l8llm3
 G/D/MlELO41/skEjRn4NmYfQiGrzurN0EYbyGvh90tSImG61m8+oruwSL5tEyHmsJmBukVA5R
 kxJLQdAdGYXkH6hsPYT3kKE0Lt4Lo6UIo/YqJOpFLxt4m4ywZvgrkGR02eF0GIm32zPiPxDja
 Yak0TJswJyTsaZDbIwogAnu5nPxP1mVjTbCY/j+mLP4HeOZkihIK18DTZe4XPKF1bpYHma8uc
 Bp4exzW9dHv0t5EcRc7vWYwVZtaPXhNy4RJ2Bc4moheymKXhL3cvYseSn7TQ6K1ui1IQtWM5n
 K082IWd2I2xD5bylFYP0vP1wHEJNtUUOQw1fGSF+r/Gh1Q3Ekxm+nxSuSuzyYtycXXM2eX8mo
 UeOwikh/oRRjr7HVNxBthg0Ylu537MVAhnHqWJ7li9GTAq19ffF6+t8BzLQ8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1ybb6Lq5J2JVsicCmjBwEvDXYyByD6x2y
Content-Type: multipart/mixed; boundary="JF2swssYkwebBbRUPgqqDaxAEB6z2BHzV"

--JF2swssYkwebBbRUPgqqDaxAEB6z2BHzV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/21 =E4=B8=8B=E5=8D=882:27, Chris Murphy wrote:
> kernel 5.4.5
> btrfs-progs 5.4
>=20
> test file is linux.tar (not compressed), it's the only file on the
> file system in each case
>=20
> /dev/sda5        53G  2.8G   50G   6% /mnt     none
> /dev/sda5        53G  2.2G   50G   5% /mnt     zstd 1
> /dev/sda5        53G  2.1G   50G   4% /mnt     zstd 15
>=20
>=20
> mount and dmesg both show the value for the level I've set; but btrfs
> insp dump-t shows extents always have compression 3.
>=20
>=20
> [47567.500812] BTRFS info (device sda5): use zstd compression, level 1
>=20
>     item 14 key (328583 EXTENT_DATA 2060582912) itemoff 15488 itemsize =
53
>         generation 51 type 1 (regular)
>         extent data disk byte 6461308928 nr 20480
>         extent data offset 0 nr 131072 ram 131072
>         extent compression 3 (zstd)

This number is not compression level, but compression algorithm.

typedef enum {
        BTRFS_COMPRESS_NONE  =3D 0,
        BTRFS_COMPRESS_ZLIB  =3D 1,
        BTRFS_COMPRESS_LZO   =3D 2,
        BTRFS_COMPRESS_ZSTD  =3D 3,
        BTRFS_COMPRESS_TYPES =3D 3,
        BTRFS_COMPRESS_LAST  =3D 4,
} btrfs_compression_type;

Level is not recorded in that field.

Thanks,
Qu

>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> [47793.161246] BTRFS info (device sda5): use zstd compression, level 15=
        =E2=94=82
>=20
>     item 170 key (328584 EXTENT_DATA 2735341568) itemoff 7220 itemsize =
53
>         generation 54 type 1 (regular)
>         extent data disk byte 2168475648 nr 24576
>         extent data offset 0 nr 131072 ram 131072
>         extent compression 3 (zstd)
>=20
>=20
> I'd expect a bigger difference between level 1 and 15, so I'm a little
> suspicious that it really is always using level 3. But it's also
> possible that it's just a bug with inspect always reporting level 3.
> The rate of the level 15 copy is slower.
>=20


--JF2swssYkwebBbRUPgqqDaxAEB6z2BHzV--

--1ybb6Lq5J2JVsicCmjBwEvDXYyByD6x2y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl39vO8ACgkQwj2R86El
/qgYHAf+M9c1KxjKFBslQqmTFinFvKwTJ4D7jG+PhpP0ojBZl5K+jPojJHr70d52
ZkkwrOBsaj+r7EvOhiFuj5OvcCyNSGZ/zKWNgNafpIN1P3J4B21uaF5gxXrnM8XG
08E91iYnpjNI2qUpOV985+ck1U8bt57GRjoa9O8u//HzbSqXeuPYO6WLuOZTU+qB
p/42e/mMKF6lAXrmaoZiwViMUC5TrvcmOA83D2kFy7ho3KBMs193FZb6Y+lFg5Hv
aiTKo6bMj87bsgcs2YOjRnY18NGQ4lLwXJIZkxGFapyXtrAtXteXOkkIA/SXccqo
GRQ1MrA+wLNCVpYGLsvk49jaA0gyaA==
=8K0o
-----END PGP SIGNATURE-----

--1ybb6Lq5J2JVsicCmjBwEvDXYyByD6x2y--
