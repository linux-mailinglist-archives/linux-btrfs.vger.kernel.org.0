Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFC8AE18C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 01:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbfIIXoz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 19:44:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:57839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbfIIXoy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 19:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568072679;
        bh=OWw1RB14VD1Put2dQqKkV1j+c+NzbDOo19kwS2GMnSA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YR3WALO7xDF/LP4fR00QobFARtbp/uFxdf96kMaycsv8P0v5gQ4w0t3/GJZvaKIRh
         1PWB32+O8qcPSYYFMavvYAaZ94g9wKI2KhoD/8AIvAb/9aX4fI0nnuysNPPA695O7e
         OChaQSTB8sv/nMsk9oZgumi865YnE2F+cyDPFA/s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2V4J-1iGrfd2Cqt-013xHW; Tue, 10
 Sep 2019 01:44:39 +0200
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     webmaster@zedlx.com, linux-btrfs@vger.kernel.org
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <20190909123818.Horde.dbl-yi_cNi8aKDaW_QYXVij@server53.web-hosting.com>
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
Message-ID: <ba5f9d6c-aa6c-c9b2-76d2-3ca56606fcc5@gmx.com>
Date:   Tue, 10 Sep 2019 07:44:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190909123818.Horde.dbl-yi_cNi8aKDaW_QYXVij@server53.web-hosting.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ng5lBzeMsGA87Pr5syGs7tl05Ip7HpUMd"
X-Provags-ID: V03:K1:NgsncNsC00U0j1l6nbpdk5zKp2QC1scTrpTaiiJ0Oxp3qG3J049
 sZpP0HY5ka2P5oUwu+FxDKLH56jJU14HTTMRkk/7ObcDGQhbHUDLlXKIIfMromsjCF8GoGF
 28mQIf3mWezMChiX8C8z5JPWfQtW99fuFq7X8cs2GPpvvtKnrWTbAocEfEBtY3DWV4hMDHq
 xmMKt8hNZGB+Cg2dXGxMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T+Sd+Vg2NSw=:nGkrExqXlNFXXObUlUCXIF
 b0AVThmxG18rPW7lW4HWeFI+v8sCpwgfNW72jCghBCn7BGKlL4uFCk7JmGrOHzSxYS7wGyuJK
 676D+dcHxcNZXxYBHVkCZItVw8xkL1VydJKLNGyyc2FRIXqFkk78ZjfPoTW/QGRJs+0NkolRW
 JcCVYw1amo7FNTD7HyL/1RlGZlh4s8sN1WCrUXUdOmZPJzOQho7i+gb8i51orU0cuBXrJtOup
 9d4xVV5VCgFDdijT07bG2t/s5LsQcS/H1LflYls6ediZLUdntwBEFp+yRxwo1XRNLj8tLY027
 EvgOJRTqLGNLaLvEDrZTY8gdmUOBV3s81x88Uk868nFqLboJ1o3/JFtxTbEqFtHmoeS+Jsqkh
 AL1O7cMelbkw9A78Tn9LfR/x7YiWRliVQkscZAR7Lxom2ySSiSOM5TVql7mBrDiL6wglJZpq0
 5rH4MZmCRZSV5wlbC8CUE9GJzjH9MIFAM/56v1C2Kr8oGGg9d1E2XGfvpdnu9cHSrbXwhSeZc
 qZZMONaQuX6ekjiYrwyP5uRUyYW8R6cEHA9uXEKmU7QZjAt1ho6chvD3uuiiHsZs0z3r6Fzpu
 vbgDRZ06OLU4+6eXo9hli7MXJWPjVyYoidmlsws/LCfGsGYjBs0EMva3hGSCaqV8uaMx72uXh
 A2RbhsDa8Mx0oOzjeZ+asHVqI4d4rb7y/NhLC9tpHIhS6NJbWsmH8zjrHR5HrVd4LDueRRWTb
 7vICGnfDY5XDiPnEB1BsYEpwkFck6AvukVn49gUXzRvPyTFg+DbHi3Jx+70gnQh6IsGN3hz3Q
 WnZw3q4A/p4GjYr/DspF0e/ITxvCHjMsHTgF4wRjd2m88CD8fbOkRmKCQPODVEokSSNlNRJ5D
 Vw1otv0kCcz4WUZMzqi3RzkjzmL0EdDlG+zkUAJA8XS3z5LMObG4Dftowwxkt4tu/d3KdPiZB
 kHcbij+wmm771KBvIvGnk1jz9lBCXi+ptuCs+RVBaz53VSRotPY0zFVI1zgCr+Ui5vPcfUIrc
 T1JaOll1byec2GqLo1n1MLRiV34fHu61T6XbWYVgq+/ZogwcUDuT7ryqdkkqiiS9t4yMF9Pvy
 us8948k2y0d6qxOLRvlnUXbkLqxNKxNisVmaGxhanlcO6VRhkT2BuV2MehTWOvJfVuJxYvSq2
 gpyZgDVsC6c3Cn83SOlLIFvhUMLeelL+6/rOwO+yUZPxyLIq9SI123o+K4049h7nKlNisbXz+
 ZVTeK189UIN5+datf
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ng5lBzeMsGA87Pr5syGs7tl05Ip7HpUMd
Content-Type: multipart/mixed; boundary="0wwyANo3i85Y18V0E18VE3Tai2gywuWxh"

--0wwyANo3i85Y18V0E18VE3Tai2gywuWxh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/10 =E4=B8=8A=E5=8D=8812:38, webmaster@zedlx.com wrote:
>=20
> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>=20
>>>>> 2) Sensible defrag
>>>>> The defrag is currently a joke.
>>>
>>> Maybe there are such cases, but I would say that a vast majority of
>>> users (99,99%) in a vast majority of cases (99,99%) don't want the
>>> defrag operation to reduce free disk space.
>>>
>>>> What's wrong with current file based defrag?
>>>> If you want to defrag a subvolume, just iterate through all files.
>>>
>>> I repeat: The defrag should not decrease free space. That's the 'norm=
al'
>>> expectation.
>>
>> Since you're talking about btrfs, it's going to do CoW for metadata no=
t
>> matter whatever, as long as you're going to change anything, btrfs wil=
l
>> cause extra space usage.
>> (Although the final result may not cause extra used disk space as free=
d
>> space is as large as newly allocated space, but to maintain CoW, newly=

>> allocated space can't overlap with old data)
>=20
> It is OK for defrag to temporarily decrease free space while defrag
> operation is in progress. That's normal.
>=20
>> Further more, talking about snapshots with space wasted by extent
>> booking, it's definitely possible user want to break the shared extent=
s:
>>
>> Subvol 257, inode 257 has the following file extents:
>> (257 EXTENT_DATA 0)
>> disk bytenr X len 16M
>> offset 0 num_bytes 4k=C2=A0 << Only 4k is referred in the whole 16M ex=
tent.
>>
>> Subvol 258, inode 257 has the following file extents:
>> (257 EXTENT_DATA 0)
>> disk bytenr X len 16M
>> offset 0 num_bytes 4K=C2=A0 << Shared with that one in subv 257
>> (257 EXTENT_DATA 4K)
>> disk bytenr Y len 16M
>> offset 0 num_bytes 4K=C2=A0 << Similar case, only 4K of 16M is used.
>>
>> In that case, user definitely want to defrag file in subvol 258, as if=

>> that extent at bytenr Y can be freed, we can free up 16M, and allocate=
 a
>> new 8K extent for subvol 258, ino 257.
>> (And will also want to defrag the extent in subvol 257 ino 257 too)
>=20
> You are confusing the actual defrag with a separate concern, let's call=

> it 'reserved space optimization'. It is about partially used extents.
> The actual name 'reserved space optimization' doesn't matter, I just
> made it up.

Then when it's not snapshotted, it's plain defrag.

How things go from "reserved space optimization" to "plain defrag" just
because snapshots?

>=20
> 'reserved space optimization' is usually performed as a part of the
> defrag operation, but it doesn't have to be, as the actual defrag is
> something separate.
>=20
> Yes, 'reserved space optimization' can break up extents.
>=20
> 'reserved space optimization' can either decrease or increase the free
> space. If the algorithm determines that more space should be reserved,
> than free space will decrease. If the algorithm determines that less
> space should be reserved, than free space will increase.
>=20
> The 'reserved space optimization' can be accomplished such that the fre=
e
> space does not decrease, if such behavior is needed.
>=20
> Also, the defrag operation can join some extents. In my original exampl=
e,
> the extents e33 and e34 can be fused into one.

Btrfs defrag works by creating new extents containing the old data.

So if btrfs decides to defrag, no old extents will be used.
It will all be new extents.

That's why your proposal is freaking strange here.

>=20
>> That's why knowledge in btrfs tech details can make a difference.
>> Sometimes you may find some ideas are brilliant and why btrfs is not
>> implementing it, but if you understand btrfs to some extent, you will
>> know the answer by yourself.
>=20
> Yes, it is true, but what you are posting so far are all 'red
> herring'-type arguments. It's just some irrelevant concerns, and you
> just got me explaining thinks like I would to a little baby. I don't
> know whether I stumbled on some rookie member of btrfs project, or you
> are just lazy and you don't want to think or consider my proposals.

Go check my name in git log.


--0wwyANo3i85Y18V0E18VE3Tai2gywuWxh--

--Ng5lBzeMsGA87Pr5syGs7tl05Ip7HpUMd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl124+MACgkQwj2R86El
/qin4QgAl289rvKE0M6x4XqTdAB5xhTk7kOVRFiJwWfhAJCHP5/2Vq2WROxu6/Dg
ihFP3kG2xdNllcnyBAFaBl6UsGPaxfrk3qceyT50UzVhSfivD7c2zD8Ey2qHftBh
M0EnKtutOVXFTxRN/U8k5HAWaZ17PR5vxuFFpRa5NGIFxhCYi+kc1598zOrTbO1F
lPSYhEHWJRaFRSUJdk5fQdbrJAZ42r8Bda+XPNJkM1yqiDIDo2xQJOl1T4yhVkrE
TwjNcniq2RNAz/QAMv9Mv4QdR2qxeblYwEZB3qI1sXbQG8qi2AnnUk5c5eRYHRGF
1oS972a5mnm21QVhnQlqNpbSCi6oRQ==
=winc
-----END PGP SIGNATURE-----

--Ng5lBzeMsGA87Pr5syGs7tl05Ip7HpUMd--
