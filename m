Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 778ECAE1C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 03:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390737AbfIJAs6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 20:48:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:38025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390726AbfIJAs6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 20:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568076525;
        bh=ajQEvK5n2Wj6v/3X7lpaJITt+015jiuAXmwig+g1H64=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=I/StXnNE0eyW9AS7kyqByloBB6WBDS0uCJig9D1vCVamWWZKTcdUIfI9y/3Jf8318
         /j4UTJAr4fRF82QMw84E2CAkYVOK/8hTq7cp5as5UBAU4D60wqbJVeDAlqGD04VFAK
         w1csRBhcDNgjkici1Jqj/r7v9bWpkbeXjUvjrXsI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8QS2-1i34UW0OuW-004Vu4; Tue, 10
 Sep 2019 02:48:44 +0200
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     webmaster@zedlx.com
Cc:     linux-btrfs@vger.kernel.org
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <20190909123818.Horde.dbl-yi_cNi8aKDaW_QYXVij@server53.web-hosting.com>
 <ba5f9d6c-aa6c-c9b2-76d2-3ca56606fcc5@gmx.com>
 <20190909200638.Horde.GlzWP3_SqKPkxpAfp05Rsz7@server53.web-hosting.com>
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
Message-ID: <3666d54b-76f7-9eee-4fb6-36c1dcc37fe9@gmx.com>
Date:   Tue, 10 Sep 2019 08:48:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190909200638.Horde.GlzWP3_SqKPkxpAfp05Rsz7@server53.web-hosting.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OInNC36QGf7Puv3lT4VQ40hiWhSh83ABa"
X-Provags-ID: V03:K1:do8EKesjoVhrTcseCCXA/oE2JiKk1upyQvn8EkdU5uXjckUwp9w
 Wren3nOZdx4pw0QHxypChhTjYfVwbspbNF7cyrD7m67AjtR7CEXevDMQzn6uzATuJEbR+OA
 E8eQxx6nBeDeoKl/8/mK5xZjhRM/xhS2wYcoh8nV0kS6Jdz2a1vRY+nK6X8FdD4cM/rq5al
 AJB/Phk//2j8a/N6aILVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:roI7DlhFc28=:XGvUx8AC9+UTJtmr/huOVo
 /I99nWGbiPQa+1lB+kMuGKBSUc2vDBccicCVG7ItdjHQG1CjIDzAqNZFQP21oaotniCnnAOOK
 nFUURY/hxsM0L3THU/6LKNdPNy+TXeCuoTTQBGfeOb7L+e6VKdNfOl8sA4f+vJNt5RsC24qw1
 rYciQXL4WlwflqWKtHLO416XRhUiK7W0BxkNyCYVYyssTdB3/CZffao4xzCO+wWR+tqwL0YND
 Y+pKdVVy+8lQnJ+vDEwt91u9dHvIUw6FJnwmPCHUlxDLHxE5gjUQdbeBJZzi1XATy0WYUI7V3
 vWDV+GSm29pGWB26VEIlGlpzouSA/V87ASLOhv1LjRacSaegItN6KyZ312ObraIjBFcr1Hd9E
 8uiSY3MqhLFUQfEBfY52iI6xmrW60slT/J10Ot3inr4uu0s+goErDMVsU5McLN56ZR0N7bp3K
 gO9hM/u+H/l4Rm3+n0SzOBY7ckAX0COizckVUOtG/+qTkHtOigxE27KUgQ6A7/A/Qvpmh1O1Q
 UJyMdrlPWX40JjKinOaqjMUdS3eI5JysdNW1LME3VmwLsVT1dz4VGDXkFi2azzLdHWq3AnKVh
 n28WbqrecROdFJi1/B2pDvAyczIui27bFRoiGQ8Ed86raf+AMYMNC/zdcwnGy/X+RELIF+Zvl
 haw34+iGZyFBP93gUzqFEcwfKssSxdjwvgAzMeoydjJESya6YmWzvBo7amKOfTrlRfz5RFHh6
 PrlUabD79KuqgOpyl76uZ1UrAgd+tsPFlRRE2Kjp3jDAOFxfNkYeBHXDfdlOjSHo/FjBp3h1D
 pQeJ2Kg7fuosU0+5NXvAKT79Gze3Y/oUbE1MZcIBzXHgP/33qaXxRhr2pJpuoJ0ZX3eP2uZg8
 xbGQjySlfc0RkRLt78DBWWshiZbIw5psW+hjFD35XudJM1HH5TlXT0ygE0WXevWBVKaCIqK6m
 oYtPwL6m7g1AdJY2kkjFEWyFv42m/VNbLuLPlOavWEAiw1yII6SWonBn9zgKJbtGrTVs/R93A
 DXqIC6ynnsu5Sih4J/YnyU/uJQKiVP82cRUvbWO0exC3RBqAmnFL2BlqrT+C6hlzaYcs6818N
 aZ+40ZKjU1h4BcsIPM71nUSyfbU5o6yIWMZVfx2/11OkOBzwBKNc2ZI48nwWDSoGrsgkxEohN
 zEY/E/tEc1ODip/Ux0BeOAoxG04pU46+WhMdTBTkZW67SFJOvhAX4lpXw05YfRhiP/vVH/8rf
 r41zw4i7S4leKR1NJ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OInNC36QGf7Puv3lT4VQ40hiWhSh83ABa
Content-Type: multipart/mixed; boundary="JH4S1eTRodPgeLP1lXC4JpXgzr9IF8pBd"

--JH4S1eTRodPgeLP1lXC4JpXgzr9IF8pBd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/10 =E4=B8=8A=E5=8D=888:06, webmaster@zedlx.com wrote:
>=20
> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>=20
>> On 2019/9/10 =E4=B8=8A=E5=8D=8812:38, webmaster@zedlx.com wrote:
>>>
>>> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>
>>>>>>> 2) Sensible defrag
>>>>>>> The defrag is currently a joke.
>>>>>
>>>>> Maybe there are such cases, but I would say that a vast majority of=

>>>>> users (99,99%) in a vast majority of cases (99,99%) don't want the
>>>>> defrag operation to reduce free disk space.
>>>>>
>>>>>> What's wrong with current file based defrag?
>>>>>> If you want to defrag a subvolume, just iterate through all files.=

>>>>>
>>>>> I repeat: The defrag should not decrease free space. That's the
>>>>> 'normal'
>>>>> expectation.
>>>>
>>>> Since you're talking about btrfs, it's going to do CoW for metadata =
not
>>>> matter whatever, as long as you're going to change anything, btrfs w=
ill
>>>> cause extra space usage.
>>>> (Although the final result may not cause extra used disk space as fr=
eed
>>>> space is as large as newly allocated space, but to maintain CoW, new=
ly
>>>> allocated space can't overlap with old data)
>>>
>>> It is OK for defrag to temporarily decrease free space while defrag
>>> operation is in progress. That's normal.
>>>
>>>> Further more, talking about snapshots with space wasted by extent
>>>> booking, it's definitely possible user want to break the shared
>>>> extents:
>>>>
>>>> Subvol 257, inode 257 has the following file extents:
>>>> (257 EXTENT_DATA 0)
>>>> disk bytenr X len 16M
>>>> offset 0 num_bytes 4k=C2=A0 << Only 4k is referred in the whole 16M =
extent.
>>>>
>>>> Subvol 258, inode 257 has the following file extents:
>>>> (257 EXTENT_DATA 0)
>>>> disk bytenr X len 16M
>>>> offset 0 num_bytes 4K=C2=A0 << Shared with that one in subv 257
>>>> (257 EXTENT_DATA 4K)
>>>> disk bytenr Y len 16M
>>>> offset 0 num_bytes 4K=C2=A0 << Similar case, only 4K of 16M is used.=

>>>>
>>>> In that case, user definitely want to defrag file in subvol 258, as =
if
>>>> that extent at bytenr Y can be freed, we can free up 16M, and
>>>> allocate a
>>>> new 8K extent for subvol 258, ino 257.
>>>> (And will also want to defrag the extent in subvol 257 ino 257 too)
>>>
>>> You are confusing the actual defrag with a separate concern, let's ca=
ll
>>> it 'reserved space optimization'. It is about partially used extents.=

>>> The actual name 'reserved space optimization' doesn't matter, I just
>>> made it up.
>>
>> Then when it's not snapshotted, it's plain defrag.
>>
>> How things go from "reserved space optimization" to "plain defrag" jus=
t
>> because snapshots?
>=20
> I'm not sure that I'm still following you here.
>=20
> I'm just saying that when you have some unused space within an extent
> and you want the defrag to free it up, that is OK, but such thing is no=
t
> the main focus of the defrag operation. So you are giving me some edge
> case here which is half-relevant and it can be easily solved. The exten=
t
> just needs to be split up into pieces, it's nothing special.
>=20
>>> 'reserved space optimization' is usually performed as a part of the
>>> defrag operation, but it doesn't have to be, as the actual defrag is
>>> something separate.
>>>
>>> Yes, 'reserved space optimization' can break up extents.
>>>
>>> 'reserved space optimization' can either decrease or increase the fre=
e
>>> space. If the algorithm determines that more space should be reserved=
,
>>> than free space will decrease. If the algorithm determines that less
>>> space should be reserved, than free space will increase.
>>>
>>> The 'reserved space optimization' can be accomplished such that the f=
ree
>>> space does not decrease, if such behavior is needed.
>>>
>>> Also, the defrag operation can join some extents. In my original
>>> example,
>>> the extents e33 and e34 can be fused into one.
>>
>> Btrfs defrag works by creating new extents containing the old data.
>>
>> So if btrfs decides to defrag, no old extents will be used.
>> It will all be new extents.
>>
>> That's why your proposal is freaking strange here.
>=20
> Ok, but: can the NEW extents still be shared?

Can only be shared by reflink.
Not automatically, so if btrfs decides to defrag, it will not be shared
at all.

> If you had an extent E88
> shared by 4 files in different subvolumes, can it be copied to another
> place and still be shared by the original 4 files?

Not for current btrfs.

> I guess that the
> answer is YES. And, that's the only requirement for a good defrag
> algorithm that doesn't shrink free space.

We may go that direction.

The biggest burden here is, btrfs needs to do expensive full-backref
walk to determine how many files are referring to this extent.
And then change them all to refer to the new extent.

It's feasible if the extent is not shared by many.
E.g the extent only get shared by ~10 or ~50 subvolumes/files.

But what will happen if it's shared by 1000 subvolumes? That would be a
performance burden.
And trust me, we have already experienced such disaster in qgroup,
that's why we want to avoid such case.

Another problem is, what if some of the subvolumes are read-only, should
we touch it or not? (I guess not)
Then the defrag will be not so complete. Bad fragmented extents are
still in RO subvols.

So the devil is still in the detail, again and again.

>=20
> Perhaps the metadata extents need to be unshared. That is OK. But I
> guess that after a typical defrag, the sharing ratio in metadata woudn'=
t
> change much.

Metadata (tree blocks) in btrfs is always get unshared as long as you
modified the tree.
But indeed, the ratio isn't that high.

>=20
>>>> That's why knowledge in btrfs tech details can make a difference.
>>>> Sometimes you may find some ideas are brilliant and why btrfs is not=

>>>> implementing it, but if you understand btrfs to some extent, you wil=
l
>>>> know the answer by yourself.
>>>
>>> Yes, it is true, but what you are posting so far are all 'red
>>> herring'-type arguments. It's just some irrelevant concerns, and you
>>> just got me explaining thinks like I would to a little baby. I don't
>>> know whether I stumbled on some rookie member of btrfs project, or yo=
u
>>> are just lazy and you don't want to think or consider my proposals.
>>
>> Go check my name in git log.
>=20
> I didn't check yet. Ok, let's just try to communicate here, I'm dead
> serious.
>=20
> I can't understand a defrag that substantially decreases free space. I
> mean, each such defrag is a lottery, because you might end up with
> practically unusable file system if the partition fills up.
>=20
> CURRENT DEFRAG IS A LOTTERY!
>=20
> How bad is that?
>

Now you see why btrfs defrag has problem.

On one hand, guys like you don't want to unshare extents. I understand
and it makes sense to some extents. And used to be the default behavior.

On the other hand, btrfs has to CoW extents to do defrag, and we have
extreme cases where we want to defrag shared extents even it's going to
decrease free space.

And I have to admit, my memory made the discussion a little off-topic,
as I still remember some older kernel doesn't touch shared extents at all=
=2E

So here what we could do is: (From easy to hard)
- Introduce an interface to allow defrag not to touch shared extents
  it shouldn't be that difficult compared to other work we are going
  to do.
  At least, user has their choice.

- Introduce different levels for defrag
  Allow btrfs to do some calculation and space usage policy to
  determine if it's a good idea to defrag some shared extents.
  E.g. my extreme case, unshare the extent would make it possible to
  defrag the other subvolume to free a huge amount of space.
  A compromise, let user to choose if they want to sacrifice some space.

- Ultimate super-duper cross subvolume defrag
  Defrag could also automatically change all the referencers.
  That's why we call it ultimate super duper, but as I already mentioned
  it's a big performance problem, and if Ro subvolume is involved, it'll
  go super tricky.


--JH4S1eTRodPgeLP1lXC4JpXgzr9IF8pBd--

--OInNC36QGf7Puv3lT4VQ40hiWhSh83ABa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl128ugACgkQwj2R86El
/qjpAwf/Qvnyt+qRVEnK46zCp9YRuFDldxTslhYRu/jUIBTz140jcjKWSFLexwEh
qg1GCyGwbEi9uacMdh1mt+61dZ0QvIQNP/STLzBgIy4QlGR3goe39obyWO+bOy6t
+psD7dG75vToLuP5yGkdR8t0Rn4DPu32dNNNsyS53QftiRVXBVuPH5urIBOpZeIf
1m47KTMVO5mebClrcAgiJ5iUwt1H34gn09CMGMl13ttH6GjGl8098ekn2bgsCCEh
eT5gxBqCDDG3ANB8KNUIxGwqnYwFrXghhEU079sec00E1KjM8XI1Ws9V1ULN2YTy
cV8ya4SNPgNuidWRJOsPCELGtq9P9g==
=1NEj
-----END PGP SIGNATURE-----

--OInNC36QGf7Puv3lT4VQ40hiWhSh83ABa--
