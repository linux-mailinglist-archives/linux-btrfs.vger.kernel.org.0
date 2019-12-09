Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD9E116502
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 03:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfLICUl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 21:20:41 -0500
Received: from mout.gmx.net ([212.227.17.21]:33371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfLICUl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Dec 2019 21:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575858038;
        bh=cjc157EJZ2nPR6g8gLNj5aPQtyArosetiRjhITkUJQs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=D5PCy+q99ZvOv1DtP5ScyVraCdY0z4mn8WxXUS/qyUZZ9ROuV2u6x243pBc5hXeHV
         zR4nNT9P8jnMyHMdwPdemMkdxUMU/L7elKlWQeRSWIoCzGJ/TgqTlQuhX1COnUUZc2
         kauJuxaZCX7p66iRgg7pmD2EzbLsuJVULGe933Hc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEUz4-1iY3qR1wHy-00Fxo1; Mon, 09
 Dec 2019 03:20:38 +0100
Subject: Re: Unable to remove directory entry
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Mike Gilbert <floppymaster@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
 <5eae7d6d-a462-53f4-df0c-3b273426e2b2@gmx.com>
 <CAJ0EP40Wj59=CevVnn1rjxoc4CtGqbRjKFBSbU8BsrSjRC48ng@mail.gmail.com>
 <6c3454b9-cc23-d22b-c3a7-59697add9b88@gmx.com>
 <CAJ0EP40a6DpTu1YmMtBezun58pfFXhWwYEXpnnGLkup0OvLQPw@mail.gmail.com>
 <ae3289dd-c1f0-3aa8-dfbb-240ec4952b6e@gmx.com>
 <CAJ0EP40UUPe9VrF1x8mxnEhFxiTzgC9DkQZB684UuMF1571D+Q@mail.gmail.com>
 <d954ccdb-ac9a-1209-130c-e3b34e4a7a45@gmx.com>
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
Message-ID: <5506e5de-a9f8-4830-8172-c07343da4218@gmx.com>
Date:   Mon, 9 Dec 2019 10:20:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d954ccdb-ac9a-1209-130c-e3b34e4a7a45@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Uel3ZGhOIGFrXaDirquhMRSJ8NciPS3Jv"
X-Provags-ID: V03:K1:5l8yam/q4a6hWLhNgnKVoj9yvVxvNBzZbPnYJXHsLghXEF7B7nB
 enmMqB6khmaUz7c6O6qp6qZZqOmR7VtYON2sqtzto7mKu+ISUJGGTYJszanORbnvev00UUv
 C79bOjeVp+y3aMfKfCrsxvUN3llLdIoRguJV7LW5HkMcm/63pJq3DCDzhamH6ArvBQX2C1P
 /YACRPfc7ubKWMfRZVNqw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UiYg1h54Q6E=:nbSIKLPjCs0D+9qLx59gpi
 rRP06mlgrdwJubHXCVFjQrzFrfFQJDLHKnX98AbubQ6ot+8c+czMOF18vqTyIYUXxjsPpQGZG
 QPcS84Vi9t4i9Yn0mpm0wX/IzKRaIK7GA0lTdFbro/XdABkK9Z+2DIR28oV/n4iXpR+DYvxVc
 WjC6dJAjtx3SSFP1cDO2jawnD6Ax09UwYMmyT/JDMonyD+Xx/A7bx7dMrzqOoV3aZlBwq2XU6
 35u2Q9vOVfPCfHrT4FhdkrQKQjoeewYrhG8PjZ8H8PGTot9rR/fLksKAbd9O93f/RS1RJJg1B
 B1oB6Ji9xn/itDuKIwYmH/Ez7YaQR7n4eg6cSvLcafzXvkUE9xtJxoC4u2vaWW/kp+M2eUvI6
 DWs93M3y1zH2B093QuPLNtwFPObqbZQ9uLvabRPaTsxURe+KuYDD/ihAE7jfVvfbXYce5skbR
 /BqgRVYl62di/2lfX7JwKo1Wbv0Ve6bsxmpP6LLawXY0gviXKd61vOPYyU631I3kc7XJ7Sjby
 p5Rszr8Uu8v6WuRFqDsgNI1ogpv2Fd1NjYLndFk3w4fy7HdffRb73/i8297uZYNuBZ3c6ooUA
 53brEvhJ/A28D6olGr7uaqFcGLTCA9LYU6dTM3Uvifo4i2cpbXJ9FyRrzEPmozqGMMxV8To2F
 Ds+Z2puqtH1jpGCUKorDBlzUOeAiXKBKR91xYk/oTmSvP5kI2zcsPXElvHnQdzSjL2YKlZDsM
 JkaOXzui1GX/Xl2f6UjIftTcAR3kJWgPrQpzxFYKqQQ0TbW4fKQzm8fEZEQ/lle/1p49vYiIi
 Ab0EEV+7PiS3HnWbVayB5gh7T3kaOsBYg6T/4qw5wAZ0YzBk3/bQC5PxX16YPZebPa/JoRqwC
 sa2SXz/LjEF52cbrnQIUXxj/AXjGo21iGOYt5H6ufeCiLGWNf9cOek94FWZctWB7cUgNLzqmo
 nN8GI9j/1Z1XKjlEAR4cAm28t6meKlFASulMwi6hvYLhRQ7OucbAtuElscYRWS2b/CqL88h+8
 XExTZLsv0oDnwxvffOzlBot8Wq4sudRV03Badsz6pRwJWcaiA39XWw+dN6AK9hhyllj3qZxVV
 hD1rvXrkY7QmWeHwmIimK/JfK/0iQA5/V0MZj4RB5/Lw7nOEk8JimkY3RzZkrJrts2JMMRyny
 R61RdbPkWAk+czbiEKNfw6cwByQTgI3RPnwbJVdxql+m2SKf51YDXeRpL3Rlgfrd1qzHLLT/k
 kEjFXo6c0L7bz7TzCD+YLif68uuQIKSb0NoUbtfYkH6nWhSJurJhc+BIwmu4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Uel3ZGhOIGFrXaDirquhMRSJ8NciPS3Jv
Content-Type: multipart/mixed; boundary="BfUVUgaWcEzsGdpne3WloJ3DxZy4T7lFC"

--BfUVUgaWcEzsGdpne3WloJ3DxZy4T7lFC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/9 =E4=B8=8A=E5=8D=8810:05, Qu Wenruo wrote:
>=20
>=20
> On 2019/12/9 =E4=B8=8A=E5=8D=889:51, Mike Gilbert wrote:
> [...]
>>
>> Here you go.
>>
>> I ran this while the filesystem was mounted; if you need it to be run
>> while offline, I'll have to fire up a livecd.
> The info is good enough, no need to go livecd.
>=20
>> --
>>        item 6 key (4065004 INODE_ITEM 0) itemoff 15158 itemsize 160
>>                generation 21397 transid 21397 size 12261 nbytes 12288
>>                block group 0 mode 100644 links 1 uid 250 gid 250 rdev =
0
>>                sequence 23 flags 0x0(none)
>>                atime 1565546668.383680243 (2019-08-11 14:04:28)
>>                ctime 1565546668.383680243 (2019-08-11 14:04:28)
>>                mtime 1565546668.383680243 (2019-08-11 14:04:28)
>>                otime 1565546668.336681213 (2019-08-11 14:04:28)
>>        item 7 key (4065004 INODE_REF 486836) itemoff 15104 itemsize 54=

>>                index 13905 namelen 44 name:
>> 0390cb341d248c589c419007da68b2-7351.manifest
>=20
> That inode exists and is good.
>=20
>>        item 8 key (4065004 EXTENT_DATA 0) itemoff 15051 itemsize 53
>>                generation 21397 type 1 (regular)
>>                extent data disk byte 6288928768 nr 12288
>>                extent data offset 0 nr 12288 ram 12288
>>                extent compression 0 (none)
>>        item 9 key (4210974 INODE_ITEM 0) itemoff 14891 itemsize 160
>>        item 63 key (486836 DIR_INDEX 13905) itemoff 6199 itemsize 74
>>                location key (4065004 INODE_ITEM 0) type FILE
>>                transid 21397 data_len 0 name_len 44
>>                name: 0390cb341d248c589c419007da68b2-7351.manifest
>=20
> Good parent dir index.
>=20
>> leaf 533498265600 items 128 free space 6682 generation 176439 owner FS=
_TREE
>> leaf 533498265600 flags 0x1(WRITTEN) backref revision 1
>> fs uuid 5e9dcab6-036d-40f1-8b40-24ab4c062bf6
>> chunk uuid 0be705de-5d3b-4c23-979e-d7aaad224cfb
>>        item 62 key (486836 DIR_ITEM 2543451757) itemoff 6273 itemsize =
74
>>                location key (4065004 INODE_ITEM 1073741824) type FILE
>>                transid 21397 data_len 0 name_len 44
>>                name: 0390cb341d248c589c419007da68b2-7351.manifest
>=20
> This is the problem, bad parent dir hash.
>=20
> The key should be (4065004 INODE_ITEM 0). The 1073741824 (0x40000000) i=
s
> completely garbage.
>=20
> That garbage looks like a bit flip at runtime.
> It's recommended to check your memory.
>=20
> I'll add extra tree-check checks, so that such runtime problem can be
> detected before corrupted data reach disk.
>=20
>=20
> For repair, I'll craft a special btrfs-progs for you to handle it, as
> that should be the safest way.
> Please wait for another 15min for that tool.

Here is the special branch for you:
https://github.com/adam900710/btrfs-progs/tree/dirty_fix_for_mike

After compile, you can use btrfs-corrupt-block (I know it's a bad name)
to repair your fs (must be unmounted):

# ./btrfs-corrupt-block -X /dev/sda3

If anything wrong happened, your fs should be kept untouched.
If repaired successfully, there should be no output.

Thanks,
Qu

>=20
> Thanks,
> Qu
>=20
>=20
>>        item 63 key (486836 DIR_INDEX 13905) itemoff 6199 itemsize 74
>>                location key (4065004 INODE_ITEM 0) type FILE
>>                transid 21397 data_len 0 name_len 44
>>                name: 0390cb341d248c589c419007da68b2-7351.manifest
>> parent transid verify failed on 629293056 wanted 177041 found 177044
>> parent transid verify failed on 629293056 wanted 177041 found 177044
>> Ignoring transid failure
>>
>=20


--BfUVUgaWcEzsGdpne3WloJ3DxZy4T7lFC--

--Uel3ZGhOIGFrXaDirquhMRSJ8NciPS3Jv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3tr3EACgkQwj2R86El
/qhz1Af+MCgPc3HAktZ1zUKI28BzQ/2hKifom9rNtjbwkuyEhfI48f4gTaUWhOeo
txxVzbIwPHWTkOGW95517Ty0FZGg5jX/nMAQUIE7s3dWYcXyRt0argS3l6SULaYF
Vpg/CaWkAJ3kHVG/wD24r/rVgaArSFOeX7eKZpUVT/bwRCdrqT8ZWvKQ2vMhmDvv
Ncbtv56ps62MeKD1BC4/rRmBs/osRaG68Iwwq2EHAmberbyB2Ihw6AHrRMNy4AL2
GSEwGqL/fQCTU8d14j+gBMbkoI/IZDtstJZi6HR44pGl/lmb2726fxLby1rMbiT0
jnzASFifr1pnSqja90+Sqo56FTvesA==
=cUUc
-----END PGP SIGNATURE-----

--Uel3ZGhOIGFrXaDirquhMRSJ8NciPS3Jv--
