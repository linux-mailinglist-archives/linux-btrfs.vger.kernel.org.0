Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26EA422330
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 12:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfERK1K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 May 2019 06:27:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:49545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbfERK1J (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 May 2019 06:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558175225;
        bh=iwQp4ugGy5S8OViCOC6rFxddHJZ5IEGxoCzQkk54OyA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TF1P8O2e0Etl2afgnuLHFvCdHkU8wzrs6KwGNYQJ+I5KPkgbLD1BXNZvNfj9a4C6q
         /Y3CA/b0GnJ5dGH7PpTBAW0KGTattAuoWfGERogOjJ0mhUXmFLacqLI6JZSRMBSoRG
         d5Y+IxWFTBhZHHMoMAGwIyjm5cjALo+ggEsjrlzo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MpDNl-1gst6e4AiF-00qifn; Sat, 18
 May 2019 12:27:05 +0200
Subject: Re: Massive filesystem corruption after balance + fstrim on Linux
 5.1.2
To:     =?UTF-8?Q?Michael_La=c3=9f?= <bevan@bi-co.net>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <297da4cbe20235080205719805b08810@bi-co.net>
 <CAJCQCtR-uo9fgs66pBMEoYX_xAye=O-L8kiMwyAdFjPS5T4+CA@mail.gmail.com>
 <8C31D41C-9608-4A65-B543-8ABCC0B907A0@bi-co.net>
 <CAJCQCtTZWXUgUDh8vn0BFeEbAdKToDSVYYw4Q0bt0rECQr9nxQ@mail.gmail.com>
 <AD966642-1043-468D-BABF-8FC9AF514D36@bi-co.net>
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
Message-ID: <158a3491-e4d2-d905-7f58-11a15bddcd70@gmx.com>
Date:   Sat, 18 May 2019 18:26:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <AD966642-1043-468D-BABF-8FC9AF514D36@bi-co.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PUZjnjQPZBENQ83S8VdzxwLhgwZgZ0RSe"
X-Provags-ID: V03:K1:5CG3itTQQ4nt7WzNNCO/94vC74nIfN9UUSStk1sDqH+3NI78TsY
 inP+2d0/d14EVXlP6xlsJDy09HBYpL7zHoI/UmgeHzFZj8tdqy5BYDNeX54JACD/exiF2+C
 uWWj6zMCETTXSWJWlSPS44n4JVc9exVTPSlbi/1+YNvYk20y0i1dWoFsCYwP2LRrT2jph88
 yV4WWF8yFNiECOPU1H8yA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xDsG+JBZrQQ=:Z8hZeD78sIhGBJjzkCS1Uf
 i9BW3ajz0S9TBOuxCVnOKbZ7cs4ImDvU1D+SrwDD8czmjrXNORZZjMoKPMuT7nrLIcxHMHYyA
 iWG377DR+A/pq5PKBDzEudMHm7P3BalEcRRwtbmoGnEzcaYfibMomzo3zkwkCg7h0axdWt7zV
 fMn1NboqBGQQCoLXEesaTp/KtHAlAMLOJMAXupbAFbdeYjJkfJQ80Sf7K0yYodOzy7JJStFTj
 2glBA9QigN1tL0hjGFYy0bAY+mbUNbH9XE6DhJDrGCE/FLuqDCaRi2wo0zgL4nf4Ufzk16xhl
 fHGh7/DdA2T37wovnKrRHxsbOSt1ttNdj6n62JH662vfzOnKPj7683sJudKQrhHQqxa2WqYP/
 T9FTODfNUFnbePfX+iYGXk5xZzJoxs2iAUnK9oJ3gSWFm3pRIc4zd0wsAMvVcFYfIABe4XcQY
 32+w5IzN7Qa2Bj2/7I8ed6JXZd9YT3LgSW75LYV3Iq/ZFKiwPCNj0ut2NRVVdXydRWR926zwM
 nBA+6l0OH2X8ypoF76NWfLfr5r5dJI1MRdxFH71fcuxuW++dY3M/KZDPjHNdULrGc9pSwqNcf
 vCJUSXDnReiLhODxhSQx/spa3btWhCqwen+0NX/NERMmzlWSodI2K7uuWKiO5aStyZI8o7Opp
 4ccCM01gOLh0tzbAtLTytFIY1bVTr+GGsyVFrbuWZt7M1MZQgAyv9w0Qbp81AH3Y9cp05hUw1
 C6Ztz+di6lHwEqATiAhZM5eK3XVW1UwFM7LIDBSI/hD6gwfw0Fi9Y4bTM/mFEILWWImBV5q4m
 2aigrMjtPLIfXKywJJ95/Lj4iZnambdw0pzbVT9q1d8ZHFrWI7v5dc+8DPqMJ8nWcBliky4ZV
 E7WYFrYyQeeW6bMJiCx8oXOgjblcwV1TBorq3M7qFFzmlYo6vppwP+iXySq18LgyidWSUCBF/
 xshgWthlEkgInopZGgGBPGpclc8A9yTU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PUZjnjQPZBENQ83S8VdzxwLhgwZgZ0RSe
Content-Type: multipart/mixed; boundary="0U9r2ahJEceOP57SsOE9DglOJXYQvz7kO";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: =?UTF-8?Q?Michael_La=c3=9f?= <bevan@bi-co.net>,
 Chris Murphy <lists@colorremedies.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <158a3491-e4d2-d905-7f58-11a15bddcd70@gmx.com>
Subject: Re: Massive filesystem corruption after balance + fstrim on Linux
 5.1.2
References: <297da4cbe20235080205719805b08810@bi-co.net>
 <CAJCQCtR-uo9fgs66pBMEoYX_xAye=O-L8kiMwyAdFjPS5T4+CA@mail.gmail.com>
 <8C31D41C-9608-4A65-B543-8ABCC0B907A0@bi-co.net>
 <CAJCQCtTZWXUgUDh8vn0BFeEbAdKToDSVYYw4Q0bt0rECQr9nxQ@mail.gmail.com>
 <AD966642-1043-468D-BABF-8FC9AF514D36@bi-co.net>
In-Reply-To: <AD966642-1043-468D-BABF-8FC9AF514D36@bi-co.net>

--0U9r2ahJEceOP57SsOE9DglOJXYQvz7kO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/18 =E4=B8=8B=E5=8D=885:18, Michael La=C3=9F wrote:
>=20
>> Am 18.05.2019 um 06:09 schrieb Chris Murphy <lists@colorremedies.com>:=

>>
>> On Fri, May 17, 2019 at 11:37 AM Michael La=C3=9F <bevan@bi-co.net> wr=
ote:
>>>
>>>
>>> I tried to reproduce this issue: I recreated the btrfs file system, s=
et up a minimal system and issued fstrim again. It printed the following =
error message:
>>>
>>> fstrim: /: FITRIM ioctl failed: Input/output error
>>
>> Huh. Any kernel message at the same time? I would expect any fstrim
>> user space error message to also have a kernel message. Any i/o error
>> suggests some kind of storage stack failure - which could be hardware
>> or software, you can't know without seeing the kernel messages.
>=20
> I missed that. The kernel messages are:
>=20
> attempt to access beyond end of device
> sda1: rw=3D16387, want=3D252755893, limit=3D250067632
> BTRFS warning (device dm-5): failed to trim 1 device(s), last error -5
>=20
> Here are some more information on the partitions and LVM physical segme=
nts:
>=20
> fdisk -l /dev/sda:
>=20
> Device     Boot Start       End   Sectors   Size Id Type
> /dev/sda1  *     2048 250069679 250067632 119.2G 8e Linux LVM
>=20
> pvdisplay -m:
>=20
>   --- Physical volume ---
>   PV Name               /dev/sda1
>   VG Name               vg_system
>   PV Size               119.24 GiB / not usable <22.34 MiB
>   Allocatable           yes (but full)
>   PE Size               32.00 MiB
>   Total PE              3815
>   Free PE               0
>   Allocated PE          3815
>   PV UUID               mqCLFy-iDnt-NfdC-lfSv-Maor-V1Ih-RlG8lP
>   =20
>   --- Physical Segments ---
>   Physical extent 0 to 1248:
>     Logical volume	/dev/vg_system/btrfs
>     Logical extents	2231 to 3479
>   Physical extent 1249 to 1728:
>     Logical volume	/dev/vg_system/btrfs
>     Logical extents	640 to 1119
>   Physical extent 1729 to 1760:
>     Logical volume	/dev/vg_system/grml-images
>     Logical extents	0 to 31
>   Physical extent 1761 to 2016:
>     Logical volume	/dev/vg_system/swap
>     Logical extents	0 to 255
>   Physical extent 2017 to 2047:
>     Logical volume	/dev/vg_system/btrfs
>     Logical extents	3480 to 3510
>   Physical extent 2048 to 2687:
>     Logical volume	/dev/vg_system/btrfs
>     Logical extents	0 to 639
>   Physical extent 2688 to 3007:
>     Logical volume	/dev/vg_system/btrfs
>     Logical extents	1911 to 2230
>   Physical extent 3008 to 3320:
>     Logical volume	/dev/vg_system/btrfs
>     Logical extents	1120 to 1432
>   Physical extent 3321 to 3336:
>     Logical volume	/dev/vg_system/boot
>     Logical extents	0 to 15
>   Physical extent 3337 to 3814:
>     Logical volume	/dev/vg_system/btrfs
>     Logical extents	1433 to 1910
>   =20
>=20
> Would btrfs even be able to accidentally trim parts of other LVs or doe=
s this clearly hint towards a LVM/dm issue?

I can't speak sure, but (at least for latest kernel) btrfs has a lot of
extra mount time self check, including chunk stripe check against
underlying device, thus the possibility shouldn't be that high for btrfs.=


> Is there an easy way to somehow trace the trim through the different la=
yers so one can see where it goes wrong?

Sure, you could use dm-log-writes.
It will record all read/write (including trim) for later replay.

So in your case, you can build the storage stack like:

Btrfs
<dm-log-writes>
LUKS/dmcrypt
LVM
MBR partition
Samsung SSD

Then replay the log (using src/log-write/replay-log in fstests) with
verbose output, you can verify every trim operation against the dmcrypt
device size.

If all trim are fine, then move the dm-log-writes a layer lower, until
you find which layer is causing the problem.

Thanks,
Qu
>=20
> Cheers,
> Michael
>=20
> PS: Current state of bisection: It looks like the error was introduced =
somewhere between b5dd0c658c31b469ccff1b637e5124851e7a4a1c and v5.1.
>=20


--0U9r2ahJEceOP57SsOE9DglOJXYQvz7kO--

--PUZjnjQPZBENQ83S8VdzxwLhgwZgZ0RSe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzf3fMACgkQwj2R86El
/qjMqgf+OFifbXIcn9trwnDjXkBHo+89YETFFs7CURgoy+KSfhsVMddcma10kFAb
Q/kSFB7Q5j6e438WUkIdY9XiUeQ/5hOjMzqTVT+IguS5x9PbX0tm0QMnqDpsdseA
m/W0DRs0zWoTqa3M1txuuWObZolRgpaVdkBwj/QwllmzwFLvZ1lgllSXuoUVdDDl
7iXKy7TZVRL1ZT519kFB+n7ggBnq446oXKkTWp4miNTgOBzs+kEn3SEmCFS4Ui81
7X2DUVEXYBBOmK0Y1sBEw68xAo3rgbuo0yf1mnC/saKuAvECQZXvRIjMqpZ9WdHi
9x82FZExScBXkWDGIDGy393MG8OIqw==
=69G2
-----END PGP SIGNATURE-----

--PUZjnjQPZBENQ83S8VdzxwLhgwZgZ0RSe--
