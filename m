Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 505CC8E7E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 11:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbfHOJNA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 05:13:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:46241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730073AbfHOJNA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 05:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565860377;
        bh=3+5z2iZ0bw7dy9enS1R84JsYsik2gXSEJTpNBuTdsR0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Eu+Gdmc93GCLjEGpYmn2k4OGY96lVAyYBBq3nPni52PiCOzRc2cu8rDJS4Q/8O/ya
         S/BVbIKZeBraZYljF9Z2KdL06lArrw3tMsXwXzgRt+0nwJPHfNZW2iVpHrQfojtfG7
         AnfiP2WTU5jSYZAj1inDBaAlR3u5TFxasLlV7jKQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXGr8-1hmhdu3neY-00YjGC; Thu, 15
 Aug 2019 11:12:57 +0200
Subject: Re: btrfs corruption: invalid mode: has 00 expect valid S_IF* bit(s)
To:     Jim Geo <dim.geo@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAD9MmSeJGKx456sLLnMBUh3Jfq5nJMYMgAgeXAz5JpZZM9wZzA@mail.gmail.com>
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
Message-ID: <126cf86b-d99c-b092-b20a-e6c3031e3675@gmx.com>
Date:   Thu, 15 Aug 2019 17:12:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD9MmSeJGKx456sLLnMBUh3Jfq5nJMYMgAgeXAz5JpZZM9wZzA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mZmbhmM1ReezkSMvdDydOt8VKTjIyK7CC"
X-Provags-ID: V03:K1:8pmfJG2jtXbLIUN73uh87KS8EzKJPSXgTimiTA4kEbMzYesrie2
 EmMks+2FbpcwfZrS4mUSOhr6aZoNAQf8/FHeLyzu645lJryXElVl0oxhaXwNI37bNfN+p+y
 u053QHBn5PZus7NH/ctJGi1CYCB6iWH79Z/Gpr1gLvVAC6HxoEJhnemXADXsDCDXBHpy7Ou
 8MsA6n2ZnXhtnuiXh0soA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:D3RRhFkiBdM=:vzMPTzzg7A3+bsx/ijc6Ip
 rDwIUNk8VXFu/EScrHJzRKiJTEcQFdrJMjfyaDuSw4MAWfD5yZjNkx5wwh596HuRiLQH6405O
 xLLpc+6hDPmrx7riXzfxQ4cQjP9SZYdE2P0EAaQP8zDhuTiFpa7fOUTVsK0ZfbD25uZpUAsoe
 d7qjd0RCWdS+Zidsh6eUoztGToElzCotje0ekQSK7ALm+cv/OhvVlcD5/Ot9hFFMiasRqR7oV
 3LM1aCTJvZzHlKSHQ7X/ib/40Kdx2pXTGSS4RBEjB/PUGv60To4z7++4FP1p1rZtM+54DPwVu
 e+w8CUVklxXH3V4fqJGUk5f6A3G9MVE1wDtap9coA1dbtDBLrkRnmYqK3COa4bEHdAJxWSZ9M
 0Wa7QVPo4JoyfnCbDDjkCtVlc67g+Z4Mx6QuaF6INgjUL4WIdGXVL+u3yefzazSufgujHPOCy
 5Bk8csU8C3GoSNOO9Y0TFScbtrbRjOTJpfnhBQ7OVrEAPQXz1SkJnpCBS+6YESQFfWEUvEKOt
 1dTS4fuX99Vy4Y0xddRWZJhXrLw7sSzRCgXjMWiggngSEWwp6oeDHljJk29DR/MPgH+Vbstt4
 SOyP7DoD1BV/CKEXvP1+GPDS+wRI2LK4vLtAvea3dkiK39JCXP1Swv2bxdVophSNx1yYFpd5F
 yX+ppcYrd7DOT7QggjLd0RHnjjAKTxTY5krC+TjI5Eyp76N4Iv088u4ltd4Zf1J4JlAkPFRCc
 hBy5Aia3EV+Zvtp6HWxHONIGNwG8SH0NBvVpgSGDclmeYEJCB5XFl2dh6zCYl/LQBGzriiylX
 3AMtJCJvqzae+JKJmwSFZwDr270njTp/csAWv0B/WUS8NcTn45e1GmfOo9zN0IcYMljniKQR2
 ykH4zEb8sPfMCEOMGGMn91Okrvnbij2nCBwWcleFMzW2QJFKTPPq0JnqcZaJc3qVLi3P0/8p7
 s1KGL/3GxXwc7xCn064RyKkQJV9PxuStDC8a7CKxEZN9LD4KfEIFAUlB5FU0uOtuQ0WkIvgdZ
 DiPrSSXoK//v4iJ+mFHKXkAMWGQ3B0RTG4ThTHlpQPp9oMyDUrlhYAOBoz62itvV2yknORikD
 /2Ev+90MsOcF8wS1BILnxBasrmUM5/pVF3fJaU3boiUTn6T/75IsAgxgA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mZmbhmM1ReezkSMvdDydOt8VKTjIyK7CC
Content-Type: multipart/mixed; boundary="qPm04kkW5xo0Kkgh81gCwz2pF6h69yiCP";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jim Geo <dim.geo@gmail.com>, linux-btrfs@vger.kernel.org
Message-ID: <126cf86b-d99c-b092-b20a-e6c3031e3675@gmx.com>
Subject: Re: btrfs corruption: invalid mode: has 00 expect valid S_IF* bit(s)
References: <CAD9MmSeJGKx456sLLnMBUh3Jfq5nJMYMgAgeXAz5JpZZM9wZzA@mail.gmail.com>
In-Reply-To: <CAD9MmSeJGKx456sLLnMBUh3Jfq5nJMYMgAgeXAz5JpZZM9wZzA@mail.gmail.com>

--qPm04kkW5xo0Kkgh81gCwz2pF6h69yiCP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/15 =E4=B8=8B=E5=8D=884:39, Jim Geo wrote:
> Hello,
>=20
> my  /home folder is on a single device btrfs partition.
> When I ls a directory, I get these messages on ls:
> ls: cannot access 'file1' : Input/output error
> ls: cannot access 'file2' : Input/output error
> ls: cannot access 'file3' : Input/output error
>=20
> and dmesg says:
> [31209.938486] BTRFS critical (device sdd1): corrupt leaf: root=3D5
> block=3D859701248 slot=3D93 ino=3D5830829, invalid mode: has 00 expect =
valid
> S_IF* bit(s)

Please provide the dump of that tree blocks.

# btrfs ins dump-tree -b 859701248 /dev/sdd1

It looks like that tree block has something wrong with it.
Thus kernel reject to accept the data.

[...]
>=20
> I scrubbed the filesystem but no errors were detected/fixed.

Scrub mostly only verify checksum, doesn't care about the data in the
tree blocks.

>=20
> btrfs scrub status /home:
> scrub status for myuuid
>         scrub started at Thu Aug 15 02:24:42 2019 and finished after 03=
:55:12
>         total bytes scrubbed: 2.05TiB with 0 errors
>=20
>  uname -a:
> Linux gentoo 5.2.8-ck #1 SMP PREEMPT Wed Aug 14 20:44:33 EEST 2019
> x86_64 Intel(R) Core(TM) i5-4460 CPU @ 3.20GHz GenuineIntel GNU/Linux
>=20
> btrfs --version:
> btrfs-progs v4.19
>=20
> btrfs fi show:
> Label: 'home_btrfs'  uuid:-------
>         Total devices 1 FS bytes used 2.04TiB
>         devid    1 size 2.13TiB used 2.13TiB path /dev/sdd1
>=20
> btrfs fi df /home:
> Data, single: total=3D2.12TiB, used=3D2.04TiB
> System, DUP: total=3D64.00MiB, used=3D256.00KiB
> Metadata, DUP: total=3D7.00GiB, used=3D4.48GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>=20
> btrfs device stats /home:
> [/dev/sdd1].write_io_errs    4
> [/dev/sdd1].read_io_errs     3
> [/dev/sdd1].flush_io_errs    0
> [/dev/sdd1].corruption_errs  0
> [/dev/sdd1].generation_errs  0
>=20
> mount options:
> /dev/sdd1 on /home type btrfs
> (rw,relatime,space_cache,autodefrag,subvolid=3D5,subvol=3D/)
>=20
> How can I fix this corruption? How can I detect if more
> files/directories are affected?

Affected inode number is 5830829. But I need to above mentioned dump to
make sure if it's not a false alert.

If it's truely corrupted by whatever the reason, you'd
better check your memory, as it looks like a bit flip.

Thanks,
Qu
>=20
> Kind Regards,
> Jim
>=20


--qPm04kkW5xo0Kkgh81gCwz2pF6h69yiCP--

--mZmbhmM1ReezkSMvdDydOt8VKTjIyK7CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1VIhUACgkQwj2R86El
/qi/Awf9G8KmYPZiM/4acnzbaHYRl7K8J7ISyPSSCRTJQmUyQTT91z1xkQuSXbyj
3g6EDGB2yjI98/JpddJUFRaa1KGfnoVh3mWaGK+deAfgHdVQbL3D4aRNd4DVBSX+
9AwljlTbPLaa4Wiktl6dze6w/c/iRmSKw7f4XIf6UIuUoAQYLAZWdU2mAReKpZhk
hytYaQNCMrgLZ4P8d7IYu9jFHeVHYVAs8IWDJQYxVKrla5bfnrZ0/oZ8SxCZBe7w
KwjAwSH9bwjtB2J8WHJlpBwuOHgOmRd6GMFaHdhMZNeDCszrXrLS//EguUWvHHrB
FoEPddUAXlrOakgPZlextCVn4GvgTg==
=lql8
-----END PGP SIGNATURE-----

--mZmbhmM1ReezkSMvdDydOt8VKTjIyK7CC--
