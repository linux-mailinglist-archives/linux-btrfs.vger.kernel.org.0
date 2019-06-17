Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6034798D
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2019 06:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfFQEye (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jun 2019 00:54:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:45711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfFQEye (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jun 2019 00:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560747267;
        bh=M06ccIiJEm6omYPXs8GlJIZXG6XuNR2/oi5f7WDbxPg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=eEB4mLz9uRz4E5y+Ld1HVo+vyx6lYTjduwJ/Fy3NiL7EW28fCK3urLRs3oE+grS27
         a0pa/5GDAqg9afxl/XMZhcGgJAEQ4f2mziPnz5LMTQvMz+rhF2n3L8DkvfL213z5qG
         9d/wXCB7huHb1H24N7Heb2O4gjkJoBl8jJX+B1CY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0M7Xi3-1iWC4E3F2t-00xLPI; Mon, 17
 Jun 2019 06:54:26 +0200
Subject: Re: raid6 fails to mount after disk failure with unclean shutdown
To:     "Paulsen, Alexander" <alexander@paulsen.at>,
        linux-btrfs@vger.kernel.org
References: <CAKTMA7ZgoOB65h3PXqK+0Ffsxefd5hDj=zWEN7UkekPWNk6amw@mail.gmail.com>
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
Message-ID: <e6873ca5-5dc3-ae67-99f3-a9b044dddcfa@gmx.com>
Date:   Mon, 17 Jun 2019 12:54:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAKTMA7ZgoOB65h3PXqK+0Ffsxefd5hDj=zWEN7UkekPWNk6amw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Be0hKRHKxSJIw5j6fUUgHrdJpOg3eLL4p"
X-Provags-ID: V03:K1:BJiYC1Mu8nCcHB4j8sqtTANiGjAbhSSxbTFWIM1BhHCbbjU0cmx
 5JJN0HXkEQkmUkBXPoXQ11+UW1Uq5zHbxHgBh/bfOxkg9shRGO9WJQzJrwu+s/abMyNJPwr
 0T1+eAOmYUmJvLGFbYGK+XPohSTnDW2Kdw74Jg+ukYOGioEhnKkxbZOTMGYlyZ93/ebN52z
 Ktxeo3c4Mb6sjqZnvD3cw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pfuljIzpMGs=:/DlsjbH+GROf46jJ3r7eE8
 ZwjKo/UgNuYoewkT3PQgvjG8HU/YTxKHUz+0gPNZ+bwinqaW0Ev/+TF48eshYBND+hN2nvlte
 ayDT5r+umJmfi8eCfMNGFGmTBdqB56sqorm3DKnNtTzLX5TeXVIWHvB2QliFbIbwcaIAw6Dcc
 1NYrPPeuetrFGqM6iqrwOrNQYlatmIs4Uu/Tlawv2yHYvjlSL0R98BAYf4VESiYv+5eMCsuJc
 lvTjvv95MQxhCe5+p/S4nZoMcCH5sAptPHn0rPfOToYrb7qW0f4D1L7XOk6NEMRx7mtxjhICz
 Nu4LEL6hXGAS70KZAv1prdwbIpJ8glr5KzXUe024LpHwpLQngjmI3TAHQCWIMacBqsHb5dWDG
 dlj/Yqdg2/VkP5vnjKpx6XcVD7nib0afN2WRPzteLSzu82YvfhcuqK+1hqnZmwBCfVYY2sV18
 Y1uAlzvciTAWsWYkaLyuKNwuHnhhRSRE68d3v+xq4CEMHzuSJ3BnYRFNr5xv9eIal80iYW0h3
 VHo4At2C3uCd0yRt7XI4zoU8i+DRDDMQsTt3Rmrq5vwQ4/ZnV8H8PZ31VF16jWOsZ21eENVBB
 RQxVC/ynKMi4iwr56vmuJ8qk5AKaSJiolSKIncLBs+sdCZRDRUTQgXc4U93sL8kFUdTAIE8eh
 Dy4N+QHKdwNZYy3MToLd/u83XnxVVyJKz0xx6j6RgezvGBxI/8pE5R/7qSv61xVq6PEjKlftF
 OhbtlKr3h2h7cJG9Qi69VcMtyfj3D+BOmHGK55+gbdgr67Wq80AuESJkrvxAboV/meg7x15ee
 hjnGzZqHFtmzXiJEKB2wqP4DBFGKMqqVZsFpvw7CfcAYxUI4s3/pNLyGa0fepdZPNflYw7eKx
 YHHnKqn3cDK2kePW5eWZbATtju8gjP64ZB1PcmeF0hwhKhjU9DMbiS2rYscJuBMel3ODKJRtu
 mj0AHjcj3KfYs9kJa+evYjqOXqrsz2e4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Be0hKRHKxSJIw5j6fUUgHrdJpOg3eLL4p
Content-Type: multipart/mixed; boundary="vaG4aBweTgtTm118a8ybERBr3aZThtkVV";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: "Paulsen, Alexander" <alexander@paulsen.at>, linux-btrfs@vger.kernel.org
Message-ID: <e6873ca5-5dc3-ae67-99f3-a9b044dddcfa@gmx.com>
Subject: Re: raid6 fails to mount after disk failure with unclean shutdown
References: <CAKTMA7ZgoOB65h3PXqK+0Ffsxefd5hDj=zWEN7UkekPWNk6amw@mail.gmail.com>
In-Reply-To: <CAKTMA7ZgoOB65h3PXqK+0Ffsxefd5hDj=zWEN7UkekPWNk6amw@mail.gmail.com>

--vaG4aBweTgtTm118a8ybERBr3aZThtkVV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/15 =E4=B8=8B=E5=8D=882:21, Paulsen, Alexander wrote:
> My raid6 fails to mount after a disk failure with unclean shutdown
>=20
> From other posts I understand that if there is a still working chunk
> root I could still get some data back
> I have the really important data in backups, but most of my holiday
> photos/videos are only on the array, so I'm happy about any partial
> data that you could help me restore
>=20
> I've listed below the output of what I've tried so far below
>=20
> Hope you can help
>=20
> Regards,
> Alexander
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> uname -a
> Linux fileserver 4.19.44-gentoo #1 SMP Thu May 30 18:05:14 CEST 2019
> x86_64 Intel(R) Atom(TM) CPU C2550 @ 2.40GHz GenuineIntel GNU/Linux
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> btrfs --version
> btrfs-progs v5.1
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> btrfs fi show
> warning, device 5 is missing
> warning, device 5 is missing

Already missing one device, this means now raid6 can only tolerant one
device corruption.

> checksum verify failed on 24535404544000 found B267AF82 wanted 3AA9B87A=

> checksum verify failed on 24535404544000 found 76ED7CB0 wanted 8F0CFD32=

> checksum verify failed on 24535404544000 found 76ED7CB0 wanted 8F0CFD32=

> bad tree block 24535404544000, bytenr mismatch, want=3D24535404544000,
> have=3D2218124645305391268
> Couldn't read chunk tree

This means the corruption happens at chunk tree, which is needed to
bootstrap and a very critical tree.

Could you get that missing device back and try again before trying any
other recovery?

> Label: 'storageraid'  uuid: 3d64f87e-ad07-4699-b1b8-3f7641e06a40
>         Total devices 7 FS bytes used 6.33TiB
>         devid    1 size 3.64TiB used 1.29TiB path /dev/sdd
>         devid    2 size 3.64TiB used 1.29TiB path /dev/sde
>         devid    3 size 3.64TiB used 1.29TiB path /dev/sdc
>         devid    4 size 2.73TiB used 1.29TiB path /dev/sdh
>         devid    6 size 2.73TiB used 1.29TiB path /dev/sdg
>         devid    7 size 2.73TiB used 1.29TiB path /dev/sdf
>         *** Some devices missing
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> btrfs-find-root /dev/sdc

If you want to use find-root, you at least need to use "-o 3" option.

That would be a pretty good start point.

Since chunk recovery doesn't work at all, your remaining recovery method
would be something like:
1. btrfs-find-root -o 3 /dev/sdc
   Get the bytenr of possible chunk roots.
2. btrfs check --chunk-root <bytenr> /dev/sdc
   To see if you can get pass the "Couldn't read chunk tree" error.
3. If you get a good chunk bytenr, either pass it to btrfs-restore or
   modify superblocks to allow kernel to mount it.

Thanks,
Qu

> warning, device 5 is missing
> warning, device 5 is missing
> Couldn't read chunk tree
> ERROR: open ctree failed
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> btrfs check /dev/sdc
> Opening filesystem to check...
> warning, device 5 is missing
> warning, device 5 is missing
> checksum verify failed on 24535404544000 found B267AF82 wanted 3AA9B87A=

> checksum verify failed on 24535404544000 found 76ED7CB0 wanted 8F0CFD32=

> checksum verify failed on 24535404544000 found 76ED7CB0 wanted 8F0CFD32=

> bad tree block 24535404544000, bytenr mismatch, want=3D24535404544000,
> have=3D2218124645305391268
> Couldn't read chunk tree
> ERROR: cannot open file system
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> mount -o ro,degraded,recovery /dev/sdc /media/storageraid/
> mount: /media/storageraid: wrong fs type, bad option, bad superblock
> on /dev/sdc, missing codepage or helper program, or other error.
>=20
> [14387.814655] BTRFS info (device sdd): allowing degraded mounts
> [14387.814660] BTRFS warning (device sdd): 'recovery' is deprecated,
> use 'usebackuproot' instead
> [14387.814662] BTRFS info (device sdd): trying to use backup root at mo=
unt time
> [14387.814663] BTRFS info (device sdd): disk space caching is enabled
> [14387.814665] BTRFS info (device sdd): has skinny extents
> [14387.815969] BTRFS warning (device sdd): devid 5 uuid
> 19311aa5-8c43-4451-9a5a-dca5232433ee is missing
> [14388.061497] BTRFS warning (device sdd): devid 5 uuid
> 19311aa5-8c43-4451-9a5a-dca5232433ee is missing
> [14388.232021] BTRFS error (device sdd): bad tree block start, want
> 23698850185216 have 0
> [14388.232360] BTRFS error (device sdd): bad tree block start, want
> 23698850185216 have 0
> [14388.252358] BTRFS error (device sdd): bad tree block start, want
> 23698850185216 have 0
> [14388.272443] BTRFS error (device sdd): bad tree block start, want
> 23698850185216 have 0
> [14388.309782] BTRFS error (device sdd): bad tree block start, want
> 23698850185216 have 0
> [14388.329857] BTRFS error (device sdd): bad tree block start, want
> 23698850185216 have 0
> [14388.349639] BTRFS error (device sdd): bad tree block start, want
> 23698850185216 have 0
> [14388.349982] BTRFS error (device sdd): bad tree block start, want
> 23698850185216 have 0
> [14388.354073] BTRFS error (device sdd): bad tree block start, want
> 23698850185216 have 0
> [14388.374161] BTRFS error (device sdd): bad tree block start, want
> 23698850185216 have 0
> [14388.771856] BTRFS error (device sdd): open_ctree failed
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> btrfs rescue chunk-recover -v /dev/sdc
> All Devices:
>         Device: id =3D 6, name =3D /dev/sdg
>         Device: id =3D 4, name =3D /dev/sdh
>         Device: id =3D 2, name =3D /dev/sde
>         Device: id =3D 7, name =3D /dev/sdf
>         Device: id =3D 1, name =3D /dev/sdd
>         Device: id =3D 3, name =3D /dev/sdc
>=20
> Scanning: 109959925760 in dev0, 81973956608 in dev1, 122966462464 in
> dev2, 102231920640 in dev3, 123404374016 in dev4, 119399600128 in
> dev5Segmentation fault
>=20
> [13286.275585] btrfs[7207]: segfault at 7f124fb40799 ip
> 000056380b12dd98 sp 00007f11db7fdc10 error 4 in
> btrfs[56380b0c9000+d3000]
> [13286.275595] Code: 48 8d 14 92 49 89 f6 41 55 48 8d 14 92 49 89 fd
> 41 54 55 53 48 8d 64 24 f8 8b 9c 17 f6 00 00 00 bf 01 00 00 00 48 8d
> 6c 18 65 <0f> b7 75 2c 49 89 f7 48 c1 e6 05 48 81 c6 a8 00 00 00 e8 11
> e9 fa
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> btrfs rescue super-recover -v /dev/sdc
> All Devices:
>         Device: id =3D 6, name =3D /dev/sdg
>         Device: id =3D 4, name =3D /dev/sdh
>         Device: id =3D 2, name =3D /dev/sde
>         Device: id =3D 7, name =3D /dev/sdf
>         Device: id =3D 1, name =3D /dev/sdd
>         Device: id =3D 3, name =3D /dev/sdc
>=20
> Before Recovering:
>         [All good supers]:
>                 device name =3D /dev/sdg
>                 superblock bytenr =3D 65536
>=20
>                 device name =3D /dev/sdg
>                 superblock bytenr =3D 67108864
>=20
>                 device name =3D /dev/sdg
>                 superblock bytenr =3D 274877906944
>=20
>                 device name =3D /dev/sdh
>                 superblock bytenr =3D 65536
>=20
>                 device name =3D /dev/sdh
>                 superblock bytenr =3D 67108864
>=20
>                 device name =3D /dev/sdh
>                 superblock bytenr =3D 274877906944
>=20
>                 device name =3D /dev/sde
>                 superblock bytenr =3D 65536
>=20
>                 device name =3D /dev/sde
>                 superblock bytenr =3D 67108864
>=20
>                 device name =3D /dev/sde
>                 superblock bytenr =3D 274877906944
>=20
>                 device name =3D /dev/sdf
>                 superblock bytenr =3D 65536
>=20
>                 device name =3D /dev/sdf
>                 superblock bytenr =3D 67108864
>=20
>                 device name =3D /dev/sdf
>                 superblock bytenr =3D 274877906944
>=20
>                 device name =3D /dev/sdd
>                 superblock bytenr =3D 65536
>=20
>                 device name =3D /dev/sdd
>                 superblock bytenr =3D 67108864
>=20
>                 device name =3D /dev/sdd
>                 superblock bytenr =3D 274877906944
>=20
>                 device name =3D /dev/sdc
>                 superblock bytenr =3D 65536
>=20
>                 device name =3D /dev/sdc
>                 superblock bytenr =3D 67108864
>=20
>                 device name =3D /dev/sdc
>                 superblock bytenr =3D 274877906944
>=20
>         [All bad supers]:
>=20
> All supers are valid, no need to recover
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> btrfs inspect-internal dump-super -f -a /dev/sdc
> superblock: bytenr=3D65536, device=3D/dev/sdc
> ---------------------------------------------------------
> csum_type               0 (crc32c)
> csum_size               4
> csum                    0x2e19b950 [match]
> bytenr                  65536
> flags                   0x1
>                         ( WRITTEN )
> magic                   _BHRfS_M [match]
> fsid                    3d64f87e-ad07-4699-b1b8-3f7641e06a40
> metadata_uuid           3d64f87e-ad07-4699-b1b8-3f7641e06a40
> label                   storageraid
> generation              106736
> root                    24113334845440
> sys_array_size          578
> chunk_root_generation   102377
> root_level              1
> chunk_root              24675241885696
> chunk_root_level        1
> log_root                0
> log_root_transid        0
> log_root_level          0
> total_bytes             24004733018112
> bytes_used              6955368067072
> sectorsize              4096
> nodesize                16384
> leafsize (deprecated)   16384
> stripesize              4096
> root_dir                6
> num_devices             7
> compat_flags            0x0
> compat_ro_flags         0x0
> incompat_flags          0x1e9
>                         ( MIXED_BACKREF |
>                           COMPRESS_LZO |
>                           BIG_METADATA |
>                           EXTENDED_IREF |
>                           RAID56 |
>                           SKINNY_METADATA )
> cache_generation        106736
> uuid_tree_generation    106736
> dev_item.uuid           47b75b3c-d5fa-467b-baa3-8d655334dd54
> dev_item.fsid           3d64f87e-ad07-4699-b1b8-3f7641e06a40 [match]
> dev_item.type           0
> dev_item.total_bytes    4000787030016
> dev_item.bytes_used     1416768782336
> dev_item.io_align       4096
> dev_item.io_width       4096
> dev_item.sector_size    4096
> dev_item.devid          3
> dev_item.dev_group      0
> dev_item.seek_speed     0
> dev_item.bandwidth      0
> dev_item.generation     0
> sys_chunk_array[2048]:
>         item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 24535403790336)
>                 length 83886080 owner 2 stripe_len 65536 type SYSTEM|RA=
ID6
>                 io_align 65536 io_width 65536 sector_size 4096
>                 num_stripes 7 sub_stripes 1
>                         stripe 0 devid 3 offset 152908595200
>                         dev_uuid 47b75b3c-d5fa-467b-baa3-8d655334dd54
>                         stripe 1 devid 2 offset 3230662656
>                         dev_uuid 7365879e-fec3-4f58-b592-ee5d266f6311
>                         stripe 2 devid 1 offset 3250585600
>                         dev_uuid e5a1ef35-39f3-49fe-b462-08ad165d6a8b
>                         stripe 3 devid 5 offset 2369598259200
>                         dev_uuid 19311aa5-8c43-4451-9a5a-dca5232433ee
>                         stripe 4 devid 4 offset 2369598259200
>                         dev_uuid 2999ef12-9a84-4eb1-b78b-f13318741fec
>                         stripe 5 devid 6 offset 2369598259200
>                         dev_uuid 79cafe3d-e51f-432b-ba00-6c3354092e91
>                         stripe 6 devid 7 offset 2369598259200
>                         dev_uuid e94c7ab3-c05a-49b3-866e-3c69b2094159
>         item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 24675241885696)
>                 length 83886080 owner 2 stripe_len 65536 type SYSTEM|RA=
ID6
>                 io_align 65536 io_width 65536 sector_size 4096
>                 num_stripes 7 sub_stripes 1
>                         stripe 0 devid 2 offset 3247439872
>                         dev_uuid 7365879e-fec3-4f58-b592-ee5d266f6311
>                         stripe 1 devid 3 offset 152690491392
>                         dev_uuid 47b75b3c-d5fa-467b-baa3-8d655334dd54
>                         stripe 2 devid 1 offset 3267362816
>                         dev_uuid e5a1ef35-39f3-49fe-b462-08ad165d6a8b
>                         stripe 3 devid 5 offset 1395026558976
>                         dev_uuid 19311aa5-8c43-4451-9a5a-dca5232433ee
>                         stripe 4 devid 7 offset 1395026558976
>                         dev_uuid e94c7ab3-c05a-49b3-866e-3c69b2094159
>                         stripe 5 devid 4 offset 1395026558976
>                         dev_uuid 2999ef12-9a84-4eb1-b78b-f13318741fec
>                         stripe 6 devid 6 offset 1395026558976
>                         dev_uuid 79cafe3d-e51f-432b-ba00-6c3354092e91
> backup_roots[4]:
>         backup 0:
>                 backup_tree_root:       24113327718400  gen: 106733    =
 level: 1
>                 backup_chunk_root:      24675241885696  gen: 102377    =
 level: 1
>                 backup_extent_root:     24113327734784  gen: 106733    =
 level: 2
>                 backup_fs_root:         14085070520320  gen: 102373    =
 level: 3
>                 backup_dev_root:        24113327833088  gen: 106733    =
 level: 1
>                 backup_csum_root:       24113327931392  gen: 106733    =
 level: 3
>                 backup_total_bytes:     24004733018112
>                 backup_bytes_used:      6955368067072
>                 backup_num_devices:     7
>=20
>         backup 1:
>                 backup_tree_root:       24113330208768  gen: 106734    =
 level: 1
>                 backup_chunk_root:      24675241885696  gen: 102377    =
 level: 1
>                 backup_extent_root:     24113330438144  gen: 106734    =
 level: 2
>                 backup_fs_root:         14085070520320  gen: 102373    =
 level: 3
>                 backup_dev_root:        24113330814976  gen: 106734    =
 level: 1
>                 backup_csum_root:       24113331830784  gen: 106734    =
 level: 3
>                 backup_total_bytes:     24004733018112
>                 backup_bytes_used:      6955368067072
>                 backup_num_devices:     7
>=20
>         backup 2:
>                 backup_tree_root:       24113332600832  gen: 106735    =
 level: 1
>                 backup_chunk_root:      24675241885696  gen: 102377    =
 level: 1
>                 backup_extent_root:     24113332617216  gen: 106735    =
 level: 2
>                 backup_fs_root:         14085070520320  gen: 102373    =
 level: 3
>                 backup_dev_root:        24113333010432  gen: 106735    =
 level: 1
>                 backup_csum_root:       24113333403648  gen: 106735    =
 level: 3
>                 backup_total_bytes:     24004733018112
>                 backup_bytes_used:      6955368067072
>                 backup_num_devices:     7
>=20
>         backup 3:
>                 backup_tree_root:       24113334845440  gen: 106736    =
 level: 1
>                 backup_chunk_root:      24675241885696  gen: 102377    =
 level: 1
>                 backup_extent_root:     24113334927360  gen: 106736    =
 level: 2
>                 backup_fs_root:         14085070520320  gen: 102373    =
 level: 3
>                 backup_dev_root:        24113335107584  gen: 106736    =
 level: 1
>                 backup_csum_root:       24113339006976  gen: 106736    =
 level: 3
>                 backup_total_bytes:     24004733018112
>                 backup_bytes_used:      6955368067072
>                 backup_num_devices:     7
>=20
>=20
> superblock: bytenr=3D67108864, device=3D/dev/sdc
> ---------------------------------------------------------
> csum_type               0 (crc32c)
> csum_size               4
> csum                    0x8e78919e [match]
> bytenr                  67108864
> flags                   0x1
>                         ( WRITTEN )
> magic                   _BHRfS_M [match]
> fsid                    3d64f87e-ad07-4699-b1b8-3f7641e06a40
> metadata_uuid           3d64f87e-ad07-4699-b1b8-3f7641e06a40
> label                   storageraid
> generation              106736
> root                    24113334845440
> sys_array_size          578
> chunk_root_generation   102377
> root_level              1
> chunk_root              24675241885696
> chunk_root_level        1
> log_root                0
> log_root_transid        0
> log_root_level          0
> total_bytes             24004733018112
> bytes_used              6955368067072
> sectorsize              4096
> nodesize                16384
> leafsize (deprecated)   16384
> stripesize              4096
> root_dir                6
> num_devices             7
> compat_flags            0x0
> compat_ro_flags         0x0
> incompat_flags          0x1e9
>                         ( MIXED_BACKREF |
>                           COMPRESS_LZO |
>                           BIG_METADATA |
>                           EXTENDED_IREF |
>                           RAID56 |
>                           SKINNY_METADATA )
> cache_generation        106736
> uuid_tree_generation    106736
> dev_item.uuid           47b75b3c-d5fa-467b-baa3-8d655334dd54
> dev_item.fsid           3d64f87e-ad07-4699-b1b8-3f7641e06a40 [match]
> dev_item.type           0
> dev_item.total_bytes    4000787030016
> dev_item.bytes_used     1416768782336
> dev_item.io_align       4096
> dev_item.io_width       4096
> dev_item.sector_size    4096
> dev_item.devid          3
> dev_item.dev_group      0
> dev_item.seek_speed     0
> dev_item.bandwidth      0
> dev_item.generation     0
> sys_chunk_array[2048]:
>         item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 24535403790336)
>                 length 83886080 owner 2 stripe_len 65536 type SYSTEM|RA=
ID6
>                 io_align 65536 io_width 65536 sector_size 4096
>                 num_stripes 7 sub_stripes 1
>                         stripe 0 devid 3 offset 152908595200
>                         dev_uuid 47b75b3c-d5fa-467b-baa3-8d655334dd54
>                         stripe 1 devid 2 offset 3230662656
>                         dev_uuid 7365879e-fec3-4f58-b592-ee5d266f6311
>                         stripe 2 devid 1 offset 3250585600
>                         dev_uuid e5a1ef35-39f3-49fe-b462-08ad165d6a8b
>                         stripe 3 devid 5 offset 2369598259200
>                         dev_uuid 19311aa5-8c43-4451-9a5a-dca5232433ee
>                         stripe 4 devid 4 offset 2369598259200
>                         dev_uuid 2999ef12-9a84-4eb1-b78b-f13318741fec
>                         stripe 5 devid 6 offset 2369598259200
>                         dev_uuid 79cafe3d-e51f-432b-ba00-6c3354092e91
>                         stripe 6 devid 7 offset 2369598259200
>                         dev_uuid e94c7ab3-c05a-49b3-866e-3c69b2094159
>         item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 24675241885696)
>                 length 83886080 owner 2 stripe_len 65536 type SYSTEM|RA=
ID6
>                 io_align 65536 io_width 65536 sector_size 4096
>                 num_stripes 7 sub_stripes 1
>                         stripe 0 devid 2 offset 3247439872
>                         dev_uuid 7365879e-fec3-4f58-b592-ee5d266f6311
>                         stripe 1 devid 3 offset 152690491392
>                         dev_uuid 47b75b3c-d5fa-467b-baa3-8d655334dd54
>                         stripe 2 devid 1 offset 3267362816
>                         dev_uuid e5a1ef35-39f3-49fe-b462-08ad165d6a8b
>                         stripe 3 devid 5 offset 1395026558976
>                         dev_uuid 19311aa5-8c43-4451-9a5a-dca5232433ee
>                         stripe 4 devid 7 offset 1395026558976
>                         dev_uuid e94c7ab3-c05a-49b3-866e-3c69b2094159
>                         stripe 5 devid 4 offset 1395026558976
>                         dev_uuid 2999ef12-9a84-4eb1-b78b-f13318741fec
>                         stripe 6 devid 6 offset 1395026558976
>                         dev_uuid 79cafe3d-e51f-432b-ba00-6c3354092e91
> backup_roots[4]:
>         backup 0:
>                 backup_tree_root:       24113327718400  gen: 106733    =
 level: 1
>                 backup_chunk_root:      24675241885696  gen: 102377    =
 level: 1
>                 backup_extent_root:     24113327734784  gen: 106733    =
 level: 2
>                 backup_fs_root:         14085070520320  gen: 102373    =
 level: 3
>                 backup_dev_root:        24113327833088  gen: 106733    =
 level: 1
>                 backup_csum_root:       24113327931392  gen: 106733    =
 level: 3
>                 backup_total_bytes:     24004733018112
>                 backup_bytes_used:      6955368067072
>                 backup_num_devices:     7
>=20
>         backup 1:
>                 backup_tree_root:       24113330208768  gen: 106734    =
 level: 1
>                 backup_chunk_root:      24675241885696  gen: 102377    =
 level: 1
>                 backup_extent_root:     24113330438144  gen: 106734    =
 level: 2
>                 backup_fs_root:         14085070520320  gen: 102373    =
 level: 3
>                 backup_dev_root:        24113330814976  gen: 106734    =
 level: 1
>                 backup_csum_root:       24113331830784  gen: 106734    =
 level: 3
>                 backup_total_bytes:     24004733018112
>                 backup_bytes_used:      6955368067072
>                 backup_num_devices:     7
>=20
>         backup 2:
>                 backup_tree_root:       24113332600832  gen: 106735    =
 level: 1
>                 backup_chunk_root:      24675241885696  gen: 102377    =
 level: 1
>                 backup_extent_root:     24113332617216  gen: 106735    =
 level: 2
>                 backup_fs_root:         14085070520320  gen: 102373    =
 level: 3
>                 backup_dev_root:        24113333010432  gen: 106735    =
 level: 1
>                 backup_csum_root:       24113333403648  gen: 106735    =
 level: 3
>                 backup_total_bytes:     24004733018112
>                 backup_bytes_used:      6955368067072
>                 backup_num_devices:     7
>=20
>         backup 3:
>                 backup_tree_root:       24113334845440  gen: 106736    =
 level: 1
>                 backup_chunk_root:      24675241885696  gen: 102377    =
 level: 1
>                 backup_extent_root:     24113334927360  gen: 106736    =
 level: 2
>                 backup_fs_root:         14085070520320  gen: 102373    =
 level: 3
>                 backup_dev_root:        24113335107584  gen: 106736    =
 level: 1
>                 backup_csum_root:       24113339006976  gen: 106736    =
 level: 3
>                 backup_total_bytes:     24004733018112
>                 backup_bytes_used:      6955368067072
>                 backup_num_devices:     7
>=20
>=20
> superblock: bytenr=3D274877906944, device=3D/dev/sdc
> ---------------------------------------------------------
> csum_type               0 (crc32c)
> csum_size               4
> csum                    0x73ffc7af [match]
> bytenr                  274877906944
> flags                   0x1
>                         ( WRITTEN )
> magic                   _BHRfS_M [match]
> fsid                    3d64f87e-ad07-4699-b1b8-3f7641e06a40
> metadata_uuid           3d64f87e-ad07-4699-b1b8-3f7641e06a40
> label                   storageraid
> generation              106736
> root                    24113334845440
> sys_array_size          578
> chunk_root_generation   102377
> root_level              1
> chunk_root              24675241885696
> chunk_root_level        1
> log_root                0
> log_root_transid        0
> log_root_level          0
> total_bytes             24004733018112
> bytes_used              6955368067072
> sectorsize              4096
> nodesize                16384
> leafsize (deprecated)   16384
> stripesize              4096
> root_dir                6
> num_devices             7
> compat_flags            0x0
> compat_ro_flags         0x0
> incompat_flags          0x1e9
>                         ( MIXED_BACKREF |
>                           COMPRESS_LZO |
>                           BIG_METADATA |
>                           EXTENDED_IREF |
>                           RAID56 |
>                           SKINNY_METADATA )
> cache_generation        106736
> uuid_tree_generation    106736
> dev_item.uuid           47b75b3c-d5fa-467b-baa3-8d655334dd54
> dev_item.fsid           3d64f87e-ad07-4699-b1b8-3f7641e06a40 [match]
> dev_item.type           0
> dev_item.total_bytes    4000787030016
> dev_item.bytes_used     1416768782336
> dev_item.io_align       4096
> dev_item.io_width       4096
> dev_item.sector_size    4096
> dev_item.devid          3
> dev_item.dev_group      0
> dev_item.seek_speed     0
> dev_item.bandwidth      0
> dev_item.generation     0
> sys_chunk_array[2048]:
>         item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 24535403790336)
>                 length 83886080 owner 2 stripe_len 65536 type SYSTEM|RA=
ID6
>                 io_align 65536 io_width 65536 sector_size 4096
>                 num_stripes 7 sub_stripes 1
>                         stripe 0 devid 3 offset 152908595200
>                         dev_uuid 47b75b3c-d5fa-467b-baa3-8d655334dd54
>                         stripe 1 devid 2 offset 3230662656
>                         dev_uuid 7365879e-fec3-4f58-b592-ee5d266f6311
>                         stripe 2 devid 1 offset 3250585600
>                         dev_uuid e5a1ef35-39f3-49fe-b462-08ad165d6a8b
>                         stripe 3 devid 5 offset 2369598259200
>                         dev_uuid 19311aa5-8c43-4451-9a5a-dca5232433ee
>                         stripe 4 devid 4 offset 2369598259200
>                         dev_uuid 2999ef12-9a84-4eb1-b78b-f13318741fec
>                         stripe 5 devid 6 offset 2369598259200
>                         dev_uuid 79cafe3d-e51f-432b-ba00-6c3354092e91
>                         stripe 6 devid 7 offset 2369598259200
>                         dev_uuid e94c7ab3-c05a-49b3-866e-3c69b2094159
>         item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 24675241885696)
>                 length 83886080 owner 2 stripe_len 65536 type SYSTEM|RA=
ID6
>                 io_align 65536 io_width 65536 sector_size 4096
>                 num_stripes 7 sub_stripes 1
>                         stripe 0 devid 2 offset 3247439872
>                         dev_uuid 7365879e-fec3-4f58-b592-ee5d266f6311
>                         stripe 1 devid 3 offset 152690491392
>                         dev_uuid 47b75b3c-d5fa-467b-baa3-8d655334dd54
>                         stripe 2 devid 1 offset 3267362816
>                         dev_uuid e5a1ef35-39f3-49fe-b462-08ad165d6a8b
>                         stripe 3 devid 5 offset 1395026558976
>                         dev_uuid 19311aa5-8c43-4451-9a5a-dca5232433ee
>                         stripe 4 devid 7 offset 1395026558976
>                         dev_uuid e94c7ab3-c05a-49b3-866e-3c69b2094159
>                         stripe 5 devid 4 offset 1395026558976
>                         dev_uuid 2999ef12-9a84-4eb1-b78b-f13318741fec
>                         stripe 6 devid 6 offset 1395026558976
>                         dev_uuid 79cafe3d-e51f-432b-ba00-6c3354092e91
> backup_roots[4]:
>         backup 0:
>                 backup_tree_root:       24113327718400  gen: 106733    =
 level: 1
>                 backup_chunk_root:      24675241885696  gen: 102377    =
 level: 1
>                 backup_extent_root:     24113327734784  gen: 106733    =
 level: 2
>                 backup_fs_root:         14085070520320  gen: 102373    =
 level: 3
>                 backup_dev_root:        24113327833088  gen: 106733    =
 level: 1
>                 backup_csum_root:       24113327931392  gen: 106733    =
 level: 3
>                 backup_total_bytes:     24004733018112
>                 backup_bytes_used:      6955368067072
>                 backup_num_devices:     7
>=20
>         backup 1:
>                 backup_tree_root:       24113330208768  gen: 106734    =
 level: 1
>                 backup_chunk_root:      24675241885696  gen: 102377    =
 level: 1
>                 backup_extent_root:     24113330438144  gen: 106734    =
 level: 2
>                 backup_fs_root:         14085070520320  gen: 102373    =
 level: 3
>                 backup_dev_root:        24113330814976  gen: 106734    =
 level: 1
>                 backup_csum_root:       24113331830784  gen: 106734    =
 level: 3
>                 backup_total_bytes:     24004733018112
>                 backup_bytes_used:      6955368067072
>                 backup_num_devices:     7
>=20
>         backup 2:
>                 backup_tree_root:       24113332600832  gen: 106735    =
 level: 1
>                 backup_chunk_root:      24675241885696  gen: 102377    =
 level: 1
>                 backup_extent_root:     24113332617216  gen: 106735    =
 level: 2
>                 backup_fs_root:         14085070520320  gen: 102373    =
 level: 3
>                 backup_dev_root:        24113333010432  gen: 106735    =
 level: 1
>                 backup_csum_root:       24113333403648  gen: 106735    =
 level: 3
>                 backup_total_bytes:     24004733018112
>                 backup_bytes_used:      6955368067072
>                 backup_num_devices:     7
>=20
>         backup 3:
>                 backup_tree_root:       24113334845440  gen: 106736    =
 level: 1
>                 backup_chunk_root:      24675241885696  gen: 102377    =
 level: 1
>                 backup_extent_root:     24113334927360  gen: 106736    =
 level: 2
>                 backup_fs_root:         14085070520320  gen: 102373    =
 level: 3
>                 backup_dev_root:        24113335107584  gen: 106736    =
 level: 1
>                 backup_csum_root:       24113339006976  gen: 106736    =
 level: 3
>                 backup_total_bytes:     24004733018112
>                 backup_bytes_used:      6955368067072
>                 backup_num_devices:     7
>=20


--vaG4aBweTgtTm118a8ybERBr3aZThtkVV--

--Be0hKRHKxSJIw5j6fUUgHrdJpOg3eLL4p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0HHP0ACgkQwj2R86El
/qho0Qf/XFflIPtSaA06pIO0aOkWEcqq5fnEM7ATUTsOj0pFC/5ZZBtRT4eV+Tnq
WkoFrLFAWmW0wMseHke05cYPu4+LNYqiJu4YhHGTlL1/VJ5O7Jo9Fwnxi/qTVaay
XZBV34XGx1mzele0favvvkIa7JeJpMy1/o5yi8W2azhE8AQnFTu/QCefrhqTFZqO
bsaO1tzsyPMqvCLgTXx7+s53O4Y0SgSZq+x6YQO7jX9TPupHl+4u/LGmfauk4Wx/
10h2c/6ngyl9/K3fnW6sxbBWfc68KUnPxtJGdILpO5MOfSOfS3aK1lhHJScwvUgI
U8ldnlxhkzZck3IrWYfafLn7G5dpww==
=zS8p
-----END PGP SIGNATURE-----

--Be0hKRHKxSJIw5j6fUUgHrdJpOg3eLL4p--
