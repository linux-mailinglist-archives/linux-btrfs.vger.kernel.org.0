Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4D621EB04
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jul 2020 10:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgGNIKC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 04:10:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:54623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgGNIKB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 04:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594714198;
        bh=TJMbDy9C6YJc1goJlJpxqPJv3on/yg/zilsg7MwZ+L8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=bpnjj5jXxig7gRZJZhKsmG9LVrfjYCt9qg9vpfijxQB8euZ0/NaxWWh8dHUZZhWN6
         JPAn4QQnfR3Zd5J6AQ0MXAUdfQ3WHeAYEzMnKCWAUoNfD1i40XMUnGUVN1cPbkOgLo
         TLGay/lXvbowz9zQnrryZXHP2XqoKVzrgWdsyJ88=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7b2T-1jw61I1AOj-0082h2; Tue, 14
 Jul 2020 10:09:57 +0200
Subject: Re: "missing data block" when converting ext4 to btrfs
To:     Christian Zangl <coralllama@gmail.com>, linux-btrfs@vger.kernel.org
References: <90fff9c0-36c5-d45c-d19b-01294fc93b1e@gmail.com>
 <763ee221-92fa-a84c-db8e-9d05e88bab0c@gmx.com>
 <09c51964-9762-a7a7-02c3-ac398790ff0d@gmail.com>
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
Message-ID: <b49c8f68-5897-7bc1-21d5-03125e798a76@gmx.com>
Date:   Tue, 14 Jul 2020 16:09:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <09c51964-9762-a7a7-02c3-ac398790ff0d@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QdhPtGIGDiGCoFxmn5YJ6spsAkyPI0kFh"
X-Provags-ID: V03:K1:UbwIa6tzckEZTYu0TvOADFifg/rEkm471/sOPKK+msCR0Q3ezOz
 EG3Dz4Wp6Wkos8Bu9jQHPcUrAe+G+fF+vM/vX7cpFaQ+uN26TSLCrW8Ezh9ZTB0icsxNvjt
 VBeqSFq3t4Z1HNRGkleh++8Dudxm9KdKHZfdly53+tvbYZm9vQDOIXEAW31VFndqOqL4O9A
 iqIUdCabwkvqO91ph+CBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kHkPPNjrqn8=:ctEcM2k5Yib9ISg8Z+xrXF
 FYnBjMv+tipwghbWM0MtT1YlLQVCEy8Zj6f+m3es3p4kTbsgza5Ci+iGn5YMqSrjvDus+IjUU
 FNgAbTphSk0IInS9B2h3FUH7vP+InihBO+37ARbjlptwqGAOS40MYzaOt5DSNrPlNEEDFKFvC
 AruoKH+G8n192mIqp4/wf1hxaSzQT13xj716wLBODgq4NOC+H84329QYWUPtXsgceKA7pty0V
 HRWGcDonYeJKGs9qA12IR3Gq06f70+/1ToHltHaYHQ/zlqk2g5xUZkvRp5RppNAKqvmO9tQ0c
 VRbCeKk1vOC4wO2EgZaYBNZVi5Xxg1GTEyaGiKhrmG2sgSOcYE4kNL7lk35ILZCss1YobYu8u
 GQWbyukvOdqcgvSAlPi7fEzwmY9Zvnz9IlOtUwdSz9LLkNhGXLgx2/gx7kPR5jwL5mbb5DTg7
 SkDeRTrhHUGoLzYB1m33AvQ3StyUfToakhMgsIF9/8acvmdXbNCkojXvxsgn3qFIhc8yZ6CeH
 3NYj5WpcY+3+PLGM8ZIUhyWO1HiGFkifqqOtklelRTpsgHTFrehDSBIKYUMIOyC+A837cGrCx
 pihbOG8zKmVVr15OS0ov1x/xABZ/QkDRW6V5N12xIMGp6LhBDBOY91sX9bukFhOXemnXjuzd5
 NepMr9oSpD/0ZD+8qbl5wQpORgrvaC+7HrCJvSX+rRnqGSkJQjhlLOYWL8fRy/tNJUGLtr7rx
 G5viyxU3WknBw9lvDIyQAec1IqjoRrJBsHE2OlSTe4iDmbkF7Qh+klPB1Kpia1MZvBUwvqu0Z
 OrpWz6GUviFMkcWq3l+UL/7tZPGdDAli6ReH/HS/gTD2/w1U7Y+9MTr1lw0ZxMyDCsRtP/War
 aPmtq8JVcEixrlwFcMn1dnl/0iY9saOPDfM/8jbeyiRGdEX/bNsX9vRuwruBGaquPIlDmKHvi
 hbEjGNYQf9svos0WnLl7BGXpi9yyt7PAi2D6sU0rDeOZ/4hTIQMUvgNj+GUnoqCYe03AzODXL
 CIVwjTmTCloiDGUOaRSq/FIcaAiM6qvzeMFcPcCYWYRZLjrUJfUkIVLOx/87NVz5U/ZggR7Xx
 4tZmNpL/c/ieQWBajqmaTJK3WkYoAJL6II9BliE5MWeotNyFnkiby9KQMXnzwHpAgkwbNzOTJ
 JWisfA6Mbr4iJ12aqtRCQAhIXzgPE3TbS9ep6T2z44/fhbD0FDkwf8ux4oYg7EaHvXfRUzjH2
 Ee844Y0L9vXuHRQqh3yQ8JEJnG8/B6/zJJ1wlNg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QdhPtGIGDiGCoFxmn5YJ6spsAkyPI0kFh
Content-Type: multipart/mixed; boundary="DxWQpQp2W0hYPuVgaSnwSbyuhLtFbFO2Y"

--DxWQpQp2W0hYPuVgaSnwSbyuhLtFbFO2Y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/14 =E4=B8=8B=E5=8D=883:58, Christian Zangl wrote:
> On 2020-07-14 08:10, Qu Wenruo wrote:
>>
>>
>> On 2020/7/14 =E4=B8=8A=E5=8D=883:46, Christian Zangl wrote:
>>> I am on a test VM where I am trying to convert a second disk to btrfs=
=2E
>>>
>>> The conversion fails with the error missing data block for bytenr
>>> 1048576 (see below).
>>>
>>> I couldn't find any information about the error. What can I do to fix=

>>> this?
>>>
>>> $ fsck -f /dev/sdb1
>>> fsck from util-linux 2.35.2
>>> e2fsck 1.45.6 (20-Mar-2020)
>>> Pass 1: Checking inodes, blocks, and sizes
>>> Pass 2: Checking directory structure
>>> Pass 3: Checking directory connectivity
>>> Pass 4: Checking reference counts
>>> Pass 5: Checking group summary information
>>> /dev/sdb1: 150510/4194304 files (0.5% non-contiguous), 2726652/167772=
16
>>> blocks
>>>
>>> $ btrfs-convert /dev/sdb1
>>> create btrfs filesystem:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blocksize: 4096
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nodesize:=C2=A0 1638=
4
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 features:=C2=A0 extr=
ef, skinny-metadata (default)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checksum:=C2=A0 crc3=
2c
>>> creating ext2 image file
>>> ERROR: missing data block for bytenr 1048576
>>> ERROR: failed to create ext2_saved/image: -2
>>> WARNING: an error occurred during conversion, filesystem is partially=

>>> created but not finalized and not mountable
>>
>> Can btrfs-convert -r rollback the fs?
>=20
> No:
>=20
> $ sudo btrfs-convert -r /dev/sdb1
> No valid Btrfs found on /dev/sdb1
> ERROR: unable to open ctree
> ERROR: rollback failed
>=20
> If I do `fsck -f /dev/sdb1` I get lots of errors:
>=20
> t-arch:~$ sudo fsck -f /dev/sdb1
> fsck from util-linux 2.35.2
> e2fsck 1.45.6 (20-Mar-2020)
> Resize inode not valid.=C2=A0 Recreate<y>? yes
> Pass 1: Checking inodes, blocks, and sizes
> Deleted inode 3681 has zero dtime.=C2=A0 Fix<y>? yes
> Inodes that were part of a corrupted orphan linked list found.=C2=A0 Fi=
x<y>? yes
> Inode 3744 was part of the orphaned inode list.=C2=A0 FIXED.
> Deleted inode 3745 has zero dtime.=C2=A0 Fix<y>? yes
> Inode 3747 has INLINE_DATA_FL flag on filesystem without inline data
> support.
> Clear<y>? yes
> Inode 3748 was part of the orphaned inode list.=C2=A0 FIXED.
> Inode 3748 has a extra size (6144) which is invalid
> Fix<y>? yes
> Inode 3751 is in use, but has dtime set.=C2=A0 Fix<y>? yes
> Inode 3751 has imagic flag set.=C2=A0 Clear<y>? yes
> Inode 3752 was part of the orphaned inode list.=C2=A0 FIXED.
> Inode 3753 was part of the orphaned inode list.=C2=A0 FIXED.
> Inode 3754 is in use, but has dtime set.=C2=A0 Fix<y>? yes
> Inode 3755 was part of the orphaned inode list.=C2=A0 FIXED.
> Inode 3755 has imagic flag set.=C2=A0 Clear ('a' enables 'yes' to all) =
<y>? yes
> Deleted inode 3801 has zero dtime.=C2=A0 Fix ('a' enables 'yes' to all)=
 <y>?
> ...

This sounds like the cause.

As btrfs completely rely on the used space reported from ext*, and if
the fs is corrupted, then a lot of things can go wrong.

>=20
>> If you can rollback, would you provide the ext4 fs image?
>=20
> You mean the vmdk from VMware? I do have a backup.

Would you mind to run e2fsck on the backup first to see if that's the
problem?

If the fixed fs can not pass btrfs-convert still, would you mind to send
the fs image?

Thanks,
Qu

>=20
> Thanks!
>=20
> Christian
>=20
>>
>> Thanks,
>> Qu
>>
>>>
>>> $ uname -a
>>> Linux t-arch 5.7.7-arch1-1 #1 SMP PREEMPT Wed, 01 Jul 2020 14:53:16
>>> +0000 x86_64 GNU/Linux
>>>
>>> $ btrfs --version
>>> btrfs-progs v5.7
>>
>=20


--DxWQpQp2W0hYPuVgaSnwSbyuhLtFbFO2Y--

--QdhPtGIGDiGCoFxmn5YJ6spsAkyPI0kFh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8NaFIACgkQwj2R86El
/qi5Fgf8CGdOxlEgPYUq9PscVFnL4KC39pbl0a1LuOdHAfq8L6eokWg8PehOB2PM
SG2OAguHaP/xr/q0NZiosJFk++P/+RN6Y1WJ/sTdmWSD8RYhIZcMAFBLUz1KVUJ0
XctNwa0pPhaa5llDtcIljst0+wKd96qyz4jrhbleifD3qtxBZ/LctX2hxO4Gyok/
BJ03jod8OgGVVLrglPTdcouXPMqjAFTWRBI305DeZl/M3c7JC4o4HfvYX+9+hkJz
SJvUPeyV0fvlDpdGXBe8bzsE5jqs7JAbE16oYrv3bjYsMe2rH4p/KjS3XfP38+Wu
DYZszZhxZzWbrP8IQl3D5/cnYPFcXA==
=6PIu
-----END PGP SIGNATURE-----

--QdhPtGIGDiGCoFxmn5YJ6spsAkyPI0kFh--
