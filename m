Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C79B156FC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 08:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgBJHDf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 02:03:35 -0500
Received: from mout.gmx.net ([212.227.15.18]:57777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgBJHDf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 02:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581318213;
        bh=dR6OjSf5uzXElXAfLoRWsnIW98Fb1mUryCzpE4TMjAs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MK6wP2tyA9BwJ3Rw+Epsr+lt5X0qOXOkA55R4liq00veNlSULiykUcy7OVHAIaKdQ
         IpJia/Z2eRkKhNU3yusiS7pTItPezHp7tHlZYxExIYbO5BqfI7DmIS4VGBzWkhQYIU
         8jehRvBR8fc86Bo4fKDlZBjEzJKawpz3UutzdaEA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJVDW-1ilj913v20-00JsIj; Mon, 10
 Feb 2020 08:03:32 +0100
Subject: Re: How to Fix 'Error: could not find extent items for root 257'?
To:     Chiung-Ming Huang <photon3108@gmail.com>
Cc:     Btrfs <linux-btrfs@vger.kernel.org>
References: <CAEOGEKHSFCNMpSpNTOxrkDgW_7v5oJzU5rBUSgYZoB8eVZjV_A@mail.gmail.com>
 <6cea6393-1bb0-505e-b311-bff4a818c71b@gmx.com>
 <CAEOGEKHf9F0VM=au-42MwD63_V8RwtqiskV0LsGpq-c=J_qyPg@mail.gmail.com>
 <f2ad6b4f-b011-8954-77e1-5162c84f7c1f@gmx.com>
 <CAEOGEKHEeENOdmxgxCZ+76yc2zjaJLdsbQD9ywLTC-OcgMBpBA@mail.gmail.com>
 <b92465bc-bc92-aa86-ad54-900fce10d514@gmx.com>
 <CAEOGEKGsMgT5EAdU74GG=0WbzJx81oAXM0p_0rFhZ4vFmbM3Zg@mail.gmail.com>
 <efb830f0-9990-efba-aead-60cef00ab3cb@gmx.com>
 <CAEOGEKGgA7-3CsjYhgZJdZjzHPJNQ9xZETjjZwAoNh_efeetAA@mail.gmail.com>
 <49cc4e6d-07c0-aea0-e753-6a6262e4dedb@gmx.com>
 <CAEOGEKHARKKSYMEU5kbswA7-PjxT9xAOomktG32h9RS6aYUVjA@mail.gmail.com>
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
Message-ID: <8d8be3c5-e186-d1d5-c270-da22c61f1495@gmx.com>
Date:   Mon, 10 Feb 2020 15:03:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAEOGEKHARKKSYMEU5kbswA7-PjxT9xAOomktG32h9RS6aYUVjA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZD2z2FCDceqqLShZ6dIBc0plEm1Q19ksi"
X-Provags-ID: V03:K1:OwuqOqd6xO13dF5umk2DxreZ4AUi+5rw2FGP4SKCRhCqxZnt8VD
 5Jd35RkdJeOEaYKkfUrGzu8SzfHwKumnYcNlPeZcS2OCsQKrVIQyq29VZHWX9MCg7sJ57MG
 qDxXHguWuZmQLhbXMJtHPl2sE0bTBm+ZdQdUUfDSvkK1mEcBHhLtpUU35gvE8lWz2nVDqZc
 iTbSLPrz5RhI2pg4zGT3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YmLfkRCdGos=:ztJXLuOqYsT6vJ8x0SRi2x
 ao2Xndz8kmH5LDj9hzUQu0c8vR69Bub70j7Oe4m+1SSuRjphRnVXT5+cgfYwAKX3tCtOHWg/F
 gh+2KYRpnwfL8WAASYeV+pnJUtkhz/matzQX1x1P42gdmvXww78swziF65MbQD6FM6HmSUL7E
 FkYbebm4/8C1judT77AvrKUcLDN6NpT+P1X5LB++RiYhddjxjNlvmA8FuJvA/eMsxZ9uxpjrg
 2YlZ2DbgceVVG4LKwpFwzOaEQBjSAbOiLBI1Ew9BuJQoDvPgc5i2V1lPD4Y3GQu1Vw7PDkQlc
 q2axaHWlAyRa3RwNmRcSE15YZVZSKaM9iIzRp9ijkmpKkqBcBVsytZy1gw4rUYvKOBHZcU0Ny
 mImKc3FqZDLe5RsA74QtLgPLEE0CmTjpLMMZ60QbpA6PbEygE6ruYnaR8aGJhJD6ookhtOBAO
 GSYVooC16aTDyotMmgBREZvirC/jMT+UFAmC4len+DeRk6jguKqN4/b9BloZ+Fed7Q/6IbxOD
 yvSkCO91WDQ4DE/8qZVwkIM3zOAU4LPFnYkRfyKPGz+mMmGs2+dVSUVRDiKRkvNRcBsv+xRUG
 AQwXHdU9i0XZpLIzT+jqowJGA/srhgQ5Y4JmG8smrmpg3JxlhHGnf6b72IbFFTE7i23a1yTZU
 eO28jMy9ffU9MsSnGnsKl4cUiRbkDWGDkm0b257FJv6KL3j9UxD3I5C+0Ox0b3ovoTEwMjmHM
 4xYZPEx+tUgZX2bCCKxCkVm6n/+C/739x/PwLkQC+w7CugOctgkmYkUR/QMBh92hWioe1FO+U
 gcd1l+Rj5WlwoHRWZofV4qvGC+9hZQGHDsnd3i/CoSURnQEQtXWdNi6TT5QrbDo5EmWJvqalf
 XtvWFY3KvphXzYsN4+s8DFyiIYdlf4e+lFiS9mBdE6M77Z9DkNtB44qxThn/qdCEB0NWfYK5s
 Ms5HrzcmfUBJuB1JTh+JwxChbig0aWm4I7c797deCwaBpSJvrMWoV3adlariEUtvxMiXHxQSh
 6yzIysQZzn5UgcC3MIHigHFUjxRyW1qRTRIXG7FhTl5g+ElnVLfrI5tLGLrtFKPEjATwUlolI
 fE9E4iwwFU2VVdAMVQdy86Hc4DcrTtdoW9QHqPFKb5gH8aP6WrQapRxJAdkNufuKmAe3Up5pW
 A5hfw9SLBeI2j+Yqfsc6UOpf8Qefvhlgzq3+XlJAE0d5m64S1OGDpHKzCqCq8u4d4InqY67UD
 wWeR6mtR6FEZLR7BW
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZD2z2FCDceqqLShZ6dIBc0plEm1Q19ksi
Content-Type: multipart/mixed; boundary="FEslNSlsiQoxIRk5Rmucad92IDNrOmOpm"

--FEslNSlsiQoxIRk5Rmucad92IDNrOmOpm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/10 =E4=B8=8B=E5=8D=882:50, Chiung-Ming Huang wrote:
> Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=887=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:16=E5=AF=AB=E9=81=93=EF=BC=9A=

>>
>>
>>
>> On 2020/2/7 =E4=B8=8B=E5=8D=882:16, Chiung-Ming Huang wrote:
>>> Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=887=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8812:00=E5=AF=AB=E9=81=93=EF=
=BC=9A
>>>>
>>>> All these subvolumes had a missing root dir. That's not good either.=

>>>> I guess btrfs-restore is your last chance, or RO mount with my
>>>> rescue=3Dskipbg patchset:
>>>> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D1707=
15
>>>>
>>>
>>> Is it possible to use original disks to keep the restored data safely=
?
>>> I would like
>>> to restore the data of /dev/bcache3 to the new btrfs RAID0 at the fir=
st and then
>>> add it to the new btrfs RAID0. Does `btrfs restore` need metadata or =
something
>>> in /dev/bcache3 to restore /dev/bcache2 and /dev/bcache4?
>>
>> Devid 1 (bcache 2) seems OK to be missing, as all its data and metadat=
a
>> are in RAID1.
>>
>> But it's strongly recommended to test without wiping bcache2, to make
>> sure btrfs-restore can salvage enough data, then wipeing bcache2.
>>
>> Thanks,
>> Qu
>=20
> Is it possible to shrink the size of bcache2 btrfs without making
> everything worse?
> I need more disk space but I still need bcache2 itself.

That is kinda possible, but please keep in mind that, even in the best
case, it still needs to write some (very small amount) metadata into the
fs, thus I can't ensure it won't make things worse, or even possible
without falling back to RO.

You need to dump the device extent tree, to determine the where the last
dev extent is for each device, then shrink to that size.

Some example here:

# btrfs ins dump-tree -t dev /dev/nvme/btrfs
=2E..

        item 6 key (1 DEV_EXTENT 2169503744) itemoff 15955 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 2169503744 length 1073741=
824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000

Here for the key, 1 means devid 1, 2169503744 means where the device
extent starts at. 1073741824 is the length of the device extent.

In above case, the device with devid 1 can be resized to 2169503744 +
1073741824, without relocating any data/metadata.

# time btrfs fi resize 1:3243245568 /mnt/btrfs/
Resize '/mnt/btrfs/' of '1:3243245568'

real    0m0.013s
user    0m0.006s
sys     0m0.004s

And the dump-tree shows the same last device extent:
=2E..
        item 6 key (1 DEV_EXTENT 2169503744) itemoff 15955 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 2169503744 length 1073741=
824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000

(Maybe it's a good time to implement some like fast shrink for btrfs-prog=
s)

Of course, after resizing btrfs, you still need to resize bcache, but
that's not related to btrfs (and I am not familiar with bcache either).

Thanks,
Qu

>=20
> Regards,
> Chiung-Ming Huang
>=20
>=20
>>>
>>> /dev/bcache2, ID: 1
>>>    Device size:             9.09TiB
>>>    Device slack:              0.00B
>>>    Data,RAID1:              3.93TiB
>>>    Metadata,RAID1:          2.00GiB
>>>    System,RAID1:           32.00MiB
>>>    Unallocated:             5.16TiB
>>>
>>> /dev/bcache3, ID: 3
>>>    Device size:             2.73TiB
>>>    Device slack:              0.00B
>>>    Data,single:           378.00GiB
>>>    Data,RAID1:            355.00GiB
>>>    Metadata,single:         2.00GiB
>>>    Metadata,RAID1:         11.00GiB
>>>    Unallocated:             2.00TiB
>>>
>>> /dev/bcache4, ID: 5
>>>    Device size:             9.09TiB
>>>    Device slack:              0.00B
>>>    Data,single:             2.93TiB
>>>    Data,RAID1:              4.15TiB
>>>    Metadata,single:         6.00GiB
>>>    Metadata,RAID1:         11.00GiB
>>>    System,RAID1:           32.00MiB
>>>    Unallocated:             2.00TiB
>>>
>>> Regards,
>>> Chiung-Ming Huang
>>>
>>


--FEslNSlsiQoxIRk5Rmucad92IDNrOmOpm--

--ZD2z2FCDceqqLShZ6dIBc0plEm1Q19ksi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5BAEAACgkQwj2R86El
/qi/jgf/YwIsaDjTxi9JLG6hc/kcOlOdZUfe2XuewcT+tWEBpRKMJpuBIpoBEQOi
iFdchRkMFxUgXnTJ3X70BQ40U3T8UepK370pTFzi6j8Av5tBGlcEhRKiYUno6Sjp
sx0lCmvG5Z9zUorhqDTth22g0/1d251swEKXXP3SPsur1bDY8NYzb1KUONh/tucx
U657EP8mjGAOCDndyIq/P30O9/+whMwSgsiVQNf4Btgtqup/EbVUmB2FYaHr41L2
gmXCqVw48NgahXowhFnf78ZnFwU4ODBGK7hLHJnOa47qBHPQgwI/DHnf7UvkM+6A
f9VpQTJeGMde6l0xPDEi15vXNnkF/Q==
=QXwA
-----END PGP SIGNATURE-----

--ZD2z2FCDceqqLShZ6dIBc0plEm1Q19ksi--
