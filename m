Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6A774FAAF
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2019 09:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfFWHzr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jun 2019 03:55:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:41605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfFWHzr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jun 2019 03:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561276543;
        bh=jgz7OvCFhxykIGd2USz4u5Y3TUlgKlD/nALk8dKMFTo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YpkbjJOOJ/cSVNyn+FCDYXARIUWnzaT0yz8ITnMI6ANYfb93Mp45p9V0ceuS7TGVy
         FFZ7+Rim4SuazhqSZtYCct+TJZbLzN+R8yY/KMva/hft8fM3WIZHq3LN30Gln8Rqdf
         hPQae3GZ2at7FNJkp0mTooWpz1lWVAuys0bcqAbg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MS5Dm-1i2eKC1udW-00TFee; Sun, 23
 Jun 2019 09:55:43 +0200
Subject: Re: Confused by btrfs quota group accounting
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <eeb418d8-13a1-39c3-c6d1-dd5a2127abc9@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <669a0428-0517-a10e-c658-c8137463450a@gmx.com>
Date:   Sun, 23 Jun 2019 15:55:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <eeb418d8-13a1-39c3-c6d1-dd5a2127abc9@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="noYV1mK5w6qZAuJVjwdouvfmliFmJ68L7"
X-Provags-ID: V03:K1:ZDKBbDC9AqWHSMLeEGg2PqDTYHdsAE6oTQdV7nSQjhdXi3WXLys
 mVIXpzB4X9nK1xOEtYuVPBCPnanSo0CZZtCSDAo4RGpEU7BWzoftzuZA15RKLwz/rk2f6A0
 UtEZq45FE9tlWTY0Gbt9Kq8L3ybbJbsDOjvykQF02BX2gHH9figawSAwvFJeTcpBf98IQC1
 JWn11NTSRbFSgD6XVzD4Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qafSXPfQjO4=:smVbNUdKRnksxHYjxSjIOA
 RUDsCElEwTq6CiBeCdnXOOnDGavKIvvxiG1YsFBtqG3PK/rnB+fi9kKNeS/n4Csebi7Nd2WX9
 xdhu37h82qeD+W4xgOX2SrMPhX9P+QV3k1knwp/F/LkaVKlHG8GBWZAGQZpnkjSXg1hKEMDfm
 iQAfa5B6zI1i3fd1fCYltKvwJw/Jr0FbFWySsm9sCqJVUpqsvcCckMpRJbQ1MYQnTSMVso4T6
 CI0HJbXH3g/KDieqIypl6FaxVoqjpDxSK8dy5fkuFnxmslyVj2q1nFZ6Lf7xlM9btdR+DGyLf
 y0ePSJLBH4e/gkxciOvn6P1SzY3mczWtJS3EKjH0GfQX2xtQ46xXrDl86C6eXFwaBryBUeIaa
 Sw5cean17vAE9zslUhu+K4/DQuEL2uAnKJpg0Hym4oeGOqiiHkkaS1fr1yybpDoWzS1IaOtFl
 54jSaDNtDk5qedkHTlYCgc4Ny08Ko/8Os3u1Kemb3USNilBASbfgAaQ/QcVLZqEZW9ixM2ZbC
 QG8WJWCexXlGJ38n7VhCv88+oA6WuP+xlIwf5Y7rPRTXFMy258x3JfmjKayE40YW0hYggoBrO
 AE25IPfYBxr15nWaQJv6DiDHJAumVFbc38wP7A6mJcxN+Op7P6VzMCDRbbxDcbiqMNhI7A3uf
 7DCJI1Ijgn3loKvRqKrF1ePwK6gajqtPzhqrUobNXRWumd6Wgdq+Fh/4S5wrWEnuRc4ezZ841
 9k3mfiWUoNyyagbEXdH+9uxm26wjALaxy7KIefYbbA9hD+l80fQjg6atnJUjuhnbyha2PTffY
 QEd0e2UmpXlCkX5vRvURPTGOxkaqPQQcH5atM4WhOBGyHRONKjVEtTSHSaBQeEMww+ZMorz3L
 J1izyMo3ufujH3cAMKMypBX0Nfqe2n6Ynsc/g13NAVByqf/zbyVluumEeudagCqnt59C1Jyx9
 VrpazxqLL+ez+MSHAAlA5MfalmCD3vmI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--noYV1mK5w6qZAuJVjwdouvfmliFmJ68L7
Content-Type: multipart/mixed; boundary="8KJTEJQSgaS942EZA3y1ymFpDd82IOl2K";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Andrei Borzenkov <arvidjaar@gmail.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <669a0428-0517-a10e-c658-c8137463450a@gmx.com>
Subject: Re: Confused by btrfs quota group accounting
References: <eeb418d8-13a1-39c3-c6d1-dd5a2127abc9@gmail.com>
In-Reply-To: <eeb418d8-13a1-39c3-c6d1-dd5a2127abc9@gmail.com>

--8KJTEJQSgaS942EZA3y1ymFpDd82IOl2K
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/22 =E4=B8=8B=E5=8D=8811:11, Andrei Borzenkov wrote:
[snip]
>=20
> 10:/mnt # dd if=3D/dev/urandom of=3Dtest/file bs=3D1M count=3D100 seek=3D=
0
> conv=3Dnotrunc
> 100+0 records in
> 100+0 records out
> 104857600 bytes (105 MB, 100 MiB) copied, 0.685532 s, 153 MB/s
> 10:/mnt # sync
> 10:/mnt # btrfs qgroup show .
> qgroupid         rfer         excl
> --------         ----         ----
> 0/5          16.00KiB     16.00KiB
> 0/258         1.01GiB    100.02MiB
> 0/263         1.00GiB     85.02MiB

Sorry, I can't really reproduce it.

5.1.12 kernel, using the following script:
---
#!/bin/bash

dev=3D"/dev/data/btrfs"
mnt=3D"/mnt/btrfs"

umount $dev &> /dev/null
mkfs.btrfs -f $dev > /dev/null

mount $dev $mnt
btrfs sub create $mnt/subv1
btrfs quota enable $mnt
btrfs quota rescan -w $mnt

xfs_io -f -c "pwrite 0 1G" $mnt/subv1/file1
sync
btrfs sub snapshot $mnt/subv1 $mnt/subv2
sync
btrfs qgroup show -prce $mnt

xfs_io -c "pwrite 0 100m" $mnt/subv1/file1
sync
btrfs qgroup show -prce $mnt
---

The result is:
---
Create subvolume '/mnt/btrfs/subv1'
wrote 1073741824/1073741824 bytes at offset 0
1 GiB, 262144 ops; 0.5902 sec (1.694 GiB/sec and 444134.2107 ops/sec)
Create a snapshot of '/mnt/btrfs/subv1' in '/mnt/btrfs/subv2'
qgroupid         rfer         excl     max_rfer     max_excl parent  chil=
d
--------         ----         ----     --------     -------- ------  ----=
-
0/5          16.00KiB     16.00KiB         none         none ---     ---
0/256         1.00GiB     16.00KiB         none         none ---     ---
0/259         1.00GiB     16.00KiB         none         none ---     ---
wrote 104857600/104857600 bytes at offset 0
100 MiB, 25600 ops; 0.0694 sec (1.406 GiB/sec and 368652.9766 ops/sec)
qgroupid         rfer         excl     max_rfer     max_excl parent  chil=
d
--------         ----         ----     --------     -------- ------  ----=
-
0/5          16.00KiB     16.00KiB         none         none ---     ---
0/256         1.10GiB    100.02MiB         none         none ---     ---
0/259         1.00GiB     16.00KiB         none         none ---     ---
---

> 10:/mnt # filefrag -v test/file
> Filesystem type is: 9123683e
> File size of test/file is 1073741824 (262144 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: f=
lags:
>    0:        0..   22463:     315424..    337887:  22464:

There is a initial 10.9MiB extent, I'm not sure how it's created.

>    1:    22464..   25599:      76896..     80031:   3136:     337888:

Also here comes another 1.5MiB extent.

=46rom the result of the fiemap, it's definitely not 100MiB written.
Only 12.5M written.

The fiemap result doesn't match with your dd command.

Any clue how this happened?

Thanks,
Qu

>    2:    25600..   43135:      59264..     76799:  17536:      80032: s=
hared
>    3:    43136..   97279:      86048..    140191:  54144:      76800: s=
hared
>    4:    97280..  151551:     143392..    197663:  54272:     140192: s=
hared
>    5:   151552..  207359:     200736..    256543:  55808:     197664: s=
hared
>    6:   207360..  262143:     258080..    312863:  54784:     256544:
> last,shared,eof
> test/file: 7 extents found
> 10:/mnt # filefrag -v snap1/file
> Filesystem type is: 9123683e
> File size of snap1/file is 1073741824 (262144 blocks of 4096 bytes)
>  ext:     logical_offset:        physical_offset: length:   expected: f=
lags:
>    0:        0..   43135:      33664..     76799:  43136:
>    1:    43136..   97279:      86048..    140191:  54144:      76800: s=
hared
>    2:    97280..  151551:     143392..    197663:  54272:     140192: s=
hared
>    3:   151552..  207359:     200736..    256543:  55808:     197664: s=
hared
>    4:   207360..  262143:     258080..    312863:  54784:     256544:
> last,shared,eof
> snap1/file: 5 extents found
>=20
>=20
> Oops. Where 85MiB exclusive usage in snapshot comes from? I would expec=
t
> one of
>=20
> - 0 exclusive, because original first extent is still referenced by tes=
t
> (even though partially), so if qgroup counts physical space usage, snap=
1
> effectively refers to the same physical extents as test.
>=20
> - 100MiB exclusive if qgroup counts logical space consumption, because
> snapshot now has 100MiB different data.
>=20
> But 85MiB? It does not match any observed value. Judging by 1.01GiB of
> referenced space for subvolume test, qrgoup counts physical usage, at
> which point snapshot exclusive space consumption remains 0.
>=20


--8KJTEJQSgaS942EZA3y1ymFpDd82IOl2K--

--noYV1mK5w6qZAuJVjwdouvfmliFmJ68L7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0PMHsACgkQwj2R86El
/qgGDwf/Z6UmIQKOAhNBguz/03Y9sg5f9fkP7+14ETbFW1oM21u47Y+ek8Q8ydxG
oyH6Au34uRpLVfSVw4hGTAfVF2x9m7GW5TNHZiT88QFzK5zB3LqNukeeJ/uMaeGR
APEAl+bYNPOgRL2aGX3Ly5Er0D/7/F3iG8AISA78kvXpcUpXTzl47OgTvxQH87UF
drS0fHkCcHJm3eKSHXCA16ymRL6KsNP7YrvUYVMiEL6qaYdytu1/8r8UL4XpXi6Y
CV66w1M5clBo0ktyfNmwt8DAcDk7Modovdua1D3y30lEbC1fONl+xN73X38nXGfF
msjkojy00fMqZ3P4I0+A9HZlqR2J6A==
=1VnO
-----END PGP SIGNATURE-----

--noYV1mK5w6qZAuJVjwdouvfmliFmJ68L7--
