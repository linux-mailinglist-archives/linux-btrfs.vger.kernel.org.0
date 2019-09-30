Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67C0C1AC9
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 06:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbfI3Exc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 00:53:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:53595 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfI3Exc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 00:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569819209;
        bh=uvyfxLxJfU84zAWU7gib1iXytigY0xfrzzQHgU6f/DM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KsT1zcXQ/440cBdExWrU5BFevXD85A3RMcqRPlgHiCGbIEurLHKl1eYZ2Tw/PfoaR
         dMQtOVPureVhazxSLlQB70Wo0BGZbMkz5ApklTXfWjKf7UI/xmlzkdNQb4XamcV6Lq
         NO8nJhLy/mJaKHQag9mnZ2BLqlyKHlpgQGpEi7rg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp9Y-1ieDNL1JgC-00YD5y; Mon, 30
 Sep 2019 06:53:29 +0200
Subject: Re: Btrfs partition mount error
To:     Andrey Ivanov <andrey-ivanov-ml@yandex.ru>,
        linux-btrfs@vger.kernel.org
References: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <85cb7aff-5fa4-c7f7-c277-04069954d7fe@gmx.com>
Date:   Mon, 30 Sep 2019 12:53:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9l3rshsWyuFZX6IUUSUVoTNvg4j52xghJ"
X-Provags-ID: V03:K1:EilJtlXN0u+uG2FuU025RQm7MD0S61ClnVEVQ/gT6u9NjOQKBg7
 3WEVJOb0smvvACBjuan78o3GAx7hWxaYjwNkvydCWYWwhG1ny6VgVEpa2ZbTogfdzoh+wwC
 q2TU5Qb+Ab+4Le5nL7ZpmzobJ3+NMpkmqsdfqgAn5RhCEaZQLiLPT2t1Fb2hevc1sBJ2thv
 1lUFgwcHTBzoDfmQ4VjDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s65Gb5lqVx0=:0FXcOkbTOc/AKsEfxk9/Zl
 cEwjg37dX2LjZd5yeQxZePRR+8Iyz753t5InbYSZTHqik8ArkZzXQk+/h1pYZ/7up6qRt6JQ2
 /0s5bJra4zZTJ9oI4otx9sWX863klfxDk3gbBa0MpDzg9biIOsghIOYfAXF49w09FEPDeA4uT
 HsCHy9lSaKPrvgivGs1+3ecMFvbJoVREK8haW0y/H00kweHTbngKfQUEL6bUbZ4PQ3rOUCiEN
 5+iuJTa80fT6QiKSm/xzdjXncFg/iExXleELlBnI0mvgdcpx5kv6TyBw+CtKL8x0qxp5BtBvz
 v1ZtWsfKf8fTot3x92zuFt46zIdWNz6D0jIsytZN34ZjfzJA6pjPfszUAMeHmJoYWwQI3NIKC
 9RmeD5roorqpmvQMq8LTbvpzMoLPsOqNVI39WOVJlCyB9N8r2v5xGpPRkS6woqXqUNEW89l+l
 TnIHDsL7qs9vr2ZlRLsbe3vpTc+dAu8rXB3thUC7Cf3sWHQuCilpxU35wD/YpHCYtxvZVDXAF
 Qrta7Xns6axPLOjpwLgv5y8PdQOElTpTGHVNQL9/n3zGXyMxRTzLBfDJWDREHTA86+XnXTJ6/
 9cLePnFgrF6XZ5y47lswEWlUwiJ6p7dtTIXhKUgmVlJIQ/TLHebp1dZxHcNthKSb4WUE08dXY
 qqWG/4YaZEmiOX+/XYqXbyS1xzpnIVNDUS4vOITtK48Bq1eKp5am4QvIFnAZ1fmpPXmjagkIF
 XBIDkvJcNlPPEjFeqD+pg5D8MttHKQ8YAe7FA0ORnQJGdejytFjsiadzMeuVOoR3JKZaLPy7c
 rlhxPFF6LNJcYVPzSCOKDBZZL60fXBiPNdm20v3DasZn8UqeA5I3yVUJUJnkaycfutyYzsTob
 Vp6Fj/+uc9q0SETA0vi7TrH8vyTtGmcXISTVBo4IIZSRQ4Jshq/ObOtSXF0XPlN/l3ehTMTh7
 tNJlwNUXrcTvqSiFHQx8EPiYTYTCgwiWACLl1wiT5UvuzuhKQ365ETL7KPql2N7AWwE+51bO2
 iqxPCoVo4jj0XzCdTuTVhBjdyp0rDxsnOnxbhsyN2RW7pb+3EGj34QKL0r4evAwzFMypzm5Q1
 vWurhunN6EILvpstUGdXtu8RFlAAigSttLewxNEybz74VmXR5kBkmtvRShE5CebnoaTFxmxLN
 2u7InZKyp30I6yf2eh13YDULfH01xLLhPTHawjzzAXs5v6Q1m//LY2Omu0P0CqZCZZBbYZonp
 ivfPGW/DMiuzIfki+74GESd8QSYDCTF2gW9/+zK4Dly0189R/gkF4iZq+xmA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9l3rshsWyuFZX6IUUSUVoTNvg4j52xghJ
Content-Type: multipart/mixed; boundary="esreS3bBjqEGlWdq0WpACIgS1RngZsWN7"

--esreS3bBjqEGlWdq0WpACIgS1RngZsWN7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/30 =E4=B8=8A=E5=8D=8811:44, Andrey Ivanov wrote:
>=20
> During work I had experienced problems with access to files on the btfs=

> partition.
> I rebooted the computer and after that the partition did not mount.
>=20
> # mount /dev/sdc1 /data
> mount: /data: wrong fs type, bad option, bad superblock on /dev/sdc1,
> missing codepage or helper program, or other error.
>=20
>=20
> I think the logical structure of partition is corrupted.
> Can it be restored somehow?
>=20
>=20
> System info:
>=20
> # uname -a
> Linux tux64 4.19.72-gentoo #1 SMP Sun Sep 15 12:27:44 MSK 2019 x86_64
> Intel(R) Core(TM) i3-2100 CPU @ 3.10GHz GenuineIntel GNU/Linux
>=20
> # btrfs --version
> btrfs-progs v4.19
>=20
> # btrfs fi show
> Label: none=C2=A0 uuid: a942b8da-e92d-4348-8de9-ded1e5e095ad
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes use=
d 101.56GiB
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 si=
ze 465.01GiB used 105.01GiB path /dev/sda4
>=20
> Label: none=C2=A0 uuid: 62164480-0c5e-45da-807b-33f8bfe76ecf
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes use=
d 1.36TiB
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 si=
ze 2.70TiB used 1.38TiB path /dev/sdc1
>=20
>=20
> dmesg.log attached

[[PROBLEM]]
It's invalid DIR_ITEM, as the dmesg shows:

[   49.479561] BTRFS critical (device sda4): corrupt leaf: root=3D5
block=3D134079905792 slot=3D0 ino=3D843063, dir item with invalid data le=
n,
have 256 expect 0


[[DETAILED REASON]]
In btrfs, DIR_ITEM DIR_INDEX and XATTR_ITEM shares the same
btrfs_dir_item structure.

However DIR_ITEM and DIR_INDEX should only use namelen, only XATTR_ITEM
uses data_len.
Btrfs detects such anomaly and refuse to read the offending tree block,
which leads to this mount failure.

[[POSSIBLE CAUSE]]
Normally it should be some older FS got mounted by older kernels, which
sometimes didn't completely follow btrfs on-disk schema.


[[EXTRA INFO]]
Please provide the following dump of that tree block by:
# btrfs ins dump-tree -b 134079905792 /dev/sda4

We need such info to further confirm the problem.

Please note that this dump will contain filenames, feel free to filter
sensitive filenames.

[[WORKAROUND]]
As a workaround, you could try to mount the fs with 4.15 kernel, which
doesn't have the enhanced sanity check while should be still sane enough.=


Then find the directory with inode number 843063, copy all its contents
to a new directory, then remove the old directory.

Thanks,
Qu


--esreS3bBjqEGlWdq0WpACIgS1RngZsWN7--

--9l3rshsWyuFZX6IUUSUVoTNvg4j52xghJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2RikEACgkQwj2R86El
/qib4gf+KfHfU7Fxafe1aKuFHsIe/rV0ZgQGbR9CRqLz6tQfkJDF7BpsrY4xBgnc
+hyesL66b83290FJZv0F1k2xpg6foehFrE2qMHhZLkU1R+5gvnX3cz0WA3Js9Z3U
rl7KQajkV+P84fEJus4pRLrkekYMGMo1t8Eo7WFjpWTod8Wdd4Bkvg6MZvdhHbfe
S406Soj/h+ccOCkAqMOTnQ4jLuaANdah0vz0nrPVD8Z4tSbimi9X7hChaWjRIkCU
ARq0mr/lA4B1mmnd94OZSdvsoRJpoZxdKflsmO/Dr/D7oqHL9u9S/Cz7/SK/nTYG
wn79Wo1P6USJEGJCck1k5+gQfDjbsQ==
=XLNh
-----END PGP SIGNATURE-----

--9l3rshsWyuFZX6IUUSUVoTNvg4j52xghJ--
