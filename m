Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C28C96DDC
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 01:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfHTXj0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 19:39:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:45155 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfHTXjZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 19:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566344363;
        bh=0Ub6qgfZge2tyQkLG+Z2dBIRpSeZvbwLN6DGl3Qe6FE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Mof+/05Og1QtbbyTGAzPfktqZKtpqXlwu0lrLrWR+RWVFgrN1Lyj5e8LL9GfCPV1Y
         4OiMlIsLiK//5TimPKIhlLV4CKKpWL0RvYE9Rl2zcrUTsT087v4OZG29SdeoL0Ovn3
         EpKZPM9OtCyQaBt/KdD8SJgUjpJbTfcA0S8Nn4Uk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8GMk-1iMCXy20Om-01497I; Wed, 21
 Aug 2019 01:39:23 +0200
Subject: Re: BTRFS unable to mount after one failed disk in RAID 1
To:     Daniel Clarke <dan@e-dan.co.uk>, linux-btrfs@vger.kernel.org
References: <CAP-b2nNHVnfDyC2-F2pWtwUgjZxcqfwqYvNcBmknd5ZHauWoUw@mail.gmail.com>
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
Message-ID: <cafc855e-b030-83ff-2984-dfb45a36d1b3@gmx.com>
Date:   Wed, 21 Aug 2019 07:39:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAP-b2nNHVnfDyC2-F2pWtwUgjZxcqfwqYvNcBmknd5ZHauWoUw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="luF8TudM5ptxoLeFfT6vVfHegkleRDqxn"
X-Provags-ID: V03:K1:bke6U9tyWTohgszDooIVa/WGjhliCH5EBEmbtfZd9JASOmcYh33
 rfxzNropdlFQJjjDOza894d76TCN6goT/etRmWXnMUAIAr34Azj0YrgkVrN7iyiJDiJnQiK
 InuV411MgKBf9gtiDUCthbck5WE6aWyeBOGpAbU1P3h+dOchAF3cXmUyuV58tKosHkAcKbm
 fJ9h7XXdZm2Tl20nqhUeg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pPUurIkVJ/o=:PriukUKp97XUuQhQlt7uqA
 liAYBMhnGqdRR1ksFSgLOT+YLCGGSSb60/VpHLUrJk1XM61F2Fj7BRkLJYMH6D2oIolBTiGEG
 i5ajlL4dQ7BgPWaIjd1o7NcOjh9un7NCPAXuCPJDoxKbgz/jo5daLqYKlnK47qt1dgk5x85CO
 5xK2GvWeHBVKOZbr06KAKXqqeSuSuIprcvB1pZXbLTycG+j5FzYThAjB8/ISizHx0K5nGlxYa
 3kDgCHeIC+T2FZJPye87+Ls0kNDIBPYH9sn0V5+dtgyy6LLu/eB7HHKqO6ozH/8uxSwhewGbY
 fZ5Afe/CZY6iFU81ypeUSLub4pq5FWCqGMathi0FGfmH4dlbO6C/aXerj5HaOR9kMPhQtlbwR
 svA/WL0mpAEa+R3lH3en8K0ChgTVhh/uPIxIz3fZL8uUT56nRD9PR8SJhZKFgeZ+Y0NXxNQGN
 CvEZZixKPyaucmKW8HH4CxWKOzsVz5Zz/GTJGxw+/pvoSyrX2Vhq6BkMAYKnVAoc1c2pVrqg7
 AU5rvDkc0vVnWB6eK8zpVzs0q9PhgXkkks4HbnFM4SKD68lRI4ISronAjEqil7S7BitX+S3Xq
 4ixWzHCWXA7eIBYzBGfOAh9pHA1296YwPzkZTufxThfcBQKqcS5O2rXaz08H8uSmlXjwS2la9
 yMzWg1tcwpUX2RN8WstzG55Am2Qmnq/Z5pJAX9SkiQomtjqvlCF7mP7Djg/shaodl6E0RNVx/
 FhAOeHkNx1uvEXO5N7L5OJuzFIFE6I69ON1tgwYW8C6h5CHyBlmPoom5u8tTv6qEX0Y2nI8sL
 d4x+APJkZ9VxrIDdNIW+eGbOn3LwV8XU7xyJGMUReDDQ8NU9ClHPuNK3c4kURzVsInaVEc2kC
 YUi41nq0M47R+4+LdTfE3pNGeQRGw48NJ8JZG0lPG2SCKkWIDijbT7GwTOD7Om+7UCH0tXB70
 FK45G33dFi/10ynDrlW2vlPB8mtCzvajCUD2sXJtHPm9pDxUz1auVV5MHxn2tv0UBqqT/N26T
 2RTO7HqSnfTFQcvSYxQ0cWlYqFhbBa45hji/nITKiofpLuNsbRexC6+pFl3SmIpeNtdGGtn+E
 C58h4kA+DBNl0vy7oxQMCiyTCfd1YxVBGERZdA1gX+hl4N/CcXBgPkgyg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--luF8TudM5ptxoLeFfT6vVfHegkleRDqxn
Content-Type: multipart/mixed; boundary="HOv6mAO7AxLRox6P8egCva8c1bx91nc7B";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Daniel Clarke <dan@e-dan.co.uk>, linux-btrfs@vger.kernel.org
Message-ID: <cafc855e-b030-83ff-2984-dfb45a36d1b3@gmx.com>
Subject: Re: BTRFS unable to mount after one failed disk in RAID 1
References: <CAP-b2nNHVnfDyC2-F2pWtwUgjZxcqfwqYvNcBmknd5ZHauWoUw@mail.gmail.com>
In-Reply-To: <CAP-b2nNHVnfDyC2-F2pWtwUgjZxcqfwqYvNcBmknd5ZHauWoUw@mail.gmail.com>

--HOv6mAO7AxLRox6P8egCva8c1bx91nc7B
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/21 =E4=B8=8A=E5=8D=883:42, Daniel Clarke wrote:
> Hi,
>=20
> I'm having some trouble recovering my data after a single disk has
> failed in a raid1 two disk setup.
>=20
> The original setup:
> mkfs.btrfs -L MASTER /dev/sdb1
> mount -o compress=3Dzstd,noatime /dev/sdb1 /mnt/master
> btrfs subvolume create /mnt/master/home
> btrfs device add /dev/sdc1 /mnt/master
> btrfs balance start -dconvert=3Draid1 -mconvert=3Draid1 /mnt/master
>=20
> Mount after in fstab:
>=20
> UUID=3D70a651ab-4837-4891-9099-a6c8a52aa40f /mnt/master     btrfs
> defaults,noatime,compress=3Dzstd 0      0
>=20
> Was working fine for about 8 months, however I found the filesystem
> went to read only,

Dmesg of that please.

And there is a known bug that an aborted transaction can cause race and
corrupt the fs.
Please provide the kernel version of that RO event.

> and after a restart, would not mount at all. A
> failed disk seems to be the cause.

Dmesg of the first mount failure please.
It's hard to say just by the little info we get.

>=20
> I'm trying to get the files off the other disk, but it will not mount.
>=20
> Some info:
> ~$ blkid /dev/sdc1
> /dev/sdc1: LABEL=3D"MASTER" UUID=3D"70a651ab-4837-4891-9099-a6c8a52aa40=
f"
> UUID_SUB=3D"150986ba-521c-4eb0-85ec-9435edecaf2a" TYPE=3D"btrfs"
> PARTUUID=3D"50a736da-aba8-224a-8e82-f1322ede466f"
>=20
> ~$ btrfs --version
> btrfs-progs v4.15.1

Too old, too dangerous, especially considering older btrfs-progs can
cause further corruption if it hits some BUG_ON() or abort trans.
>=20
> ~$ btrfs fi show
> warning, device 2 is missing
> bytenr mismatch, want=3D1057828618240, have=3D0
> Label: 'MASTER'  uuid: 70a651ab-4837-4891-9099-a6c8a52aa40f
> Total devices 2 FS bytes used 1001.59GiB
> devid    1 size 1.82TiB used 1003.03GiB path /dev/sdc1
> *** Some devices missing
>=20
> Things I've tried:
>=20
> ~$ mount -t btrfs -o ro,usebackuproot,compress=3Dzstd /dev/sdc1 /mnt/ma=
indisk
> mount: /mnt/maindisk: wrong fs type, bad option, bad superblock on
> /dev/sdc1, missing codepage or helper program, or other error.

You're using RO, it already means btrfs will try its best to mount
unless vital tree blocks are missing.

>=20
> In dmesg:
> [ 4044.456472] BTRFS info (device sdc1): trying to use backup root at m=
ount time
> [ 4044.456478] BTRFS info (device sdc1): use zstd compression, level 0
> [ 4044.456481] BTRFS info (device sdc1): disk space caching is enabled
> [ 4044.456482] BTRFS info (device sdc1): has skinny extents
> [ 4044.802419] BTRFS error (device sdc1): devid 2 uuid
> a3889c61-07b3-4165-bc37-e9918e41ea8d is missing
> [ 4044.802426] BTRFS error (device sdc1): failed to read chunk tree: -2=


And that's the case, chunk tree blocks are missing.

Please provide the following dump:

# btrfs ins dump-super -FfA /dev/sdc1

> [ 4044.863400] BTRFS error (device sdc1): open_ctree failed
>=20
> Pretty much the same thing with other mount options, with same
> messages in dmesg.
>=20
> ~$ btrfs check --init-extent-tree /dev/sdc1

Why you're doing so?! It's already mentioned --init-extent-tree is UNSAFE=
!

> warning, device 2 is missing
> Checking filesystem on /dev/sdc1
> UUID: 70a651ab-4837-4891-9099-a6c8a52aa40f
> Creating a new extent tree
> bytenr mismatch, want=3D1058577645568, have=3D0
> Error reading tree block
> error pinning down used bytes
> ERROR: attempt to start transaction over already running one

Transaction get aborted, exactly the situation where fs can get further
corrupted.

The only good news is, we shouldn't have written much data as it's
happening in tree pinning down process, so no further damage.

> extent buffer leak: start 1768503115776 len 16384
>=20
> ~$ btrfs rescue super-recover -v /dev/sdc1
> All Devices:
> Device: id =3D 1, name =3D /dev/sdc1
>=20
> Before Recovering:
> [All good supers]:
> device name =3D /dev/sdc1
> superblock bytenr =3D 65536
>=20
> device name =3D /dev/sdc1
> superblock bytenr =3D 67108864
>=20
> device name =3D /dev/sdc1
> superblock bytenr =3D 274877906944
>=20
> [All bad supers]:
>=20
> All supers are valid, no need to recover
>=20
>=20
> ~$ sudo btrfs restore -mxs /dev/sdc1 /mnt/ssd1/
> warning, device 2 is missing
> bytenr mismatch, want=3D1057828618240, have=3D0
> Could not open root, trying backup super
> warning, device 2 is missing
> bytenr mismatch, want=3D1057828618240, have=3D0
> Could not open root, trying backup super
> warning, device 2 is missing
> bytenr mismatch, want=3D1057828618240, have=3D0
> Could not open root, trying backup super
>=20
> ~$ btrfs check /dev/sdc1
> warning, device 2 is missing
> bytenr mismatch, want=3D1057828618240, have=3D0
> ERROR: cannot open file system
>=20
> ~$ btrfs rescue zero-log /dev/sdc1
> warning, device 2 is missing
> bytenr mismatch, want=3D1057828618240, have=3D0
> ERROR: could not open ctree
>=20
> I'm only interested in getting it read-only mounted so I can copy
> somewhere else. Any ideas you have are welcome!

It looks like some metadata tree blocks are still not in RAID1 mode.
Needs that ins dump-super output to confirm.

Thanks,
Qu

>=20
> Many Thanks,
>=20
> Daniel Clarke
>=20


--HOv6mAO7AxLRox6P8egCva8c1bx91nc7B--

--luF8TudM5ptxoLeFfT6vVfHegkleRDqxn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1chKcACgkQwj2R86El
/qikcgf8CILHlPiFFoIHfmODpzJXe8g5S3ahy+o3VB1ZUqY8SdnsTbqzGMWQYZFa
vmrMdLwZRZqCuIauo8xR/XmBQB735jy+/DM7lGu2grgcYxm1E//dxqsjcdpgUePg
S3zcg9EOKEBCIcjbiSep9rf21ZfeBvbS2tmpV+GSCfCm2c0kl35BChWRDkR1916M
0O2EipvbGuWnyrEEIgerR3SPA38wDyMNh/Xz0DK5d+yfaH9xRv7aSQSzcTba2gym
EJ/FqNdTI8BVcadUz8CMpEJalKwKPwUQoVwopNoZOsn7jnCGUGaoOTQsUhW3YEJs
H1jbiuOrxR9zQ7TLXuxwyphgtksNDA==
=LAuN
-----END PGP SIGNATURE-----

--luF8TudM5ptxoLeFfT6vVfHegkleRDqxn--
