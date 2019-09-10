Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F343BAE21B
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 03:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfIJBtH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 21:49:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:40739 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbfIJBtH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 21:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568080131;
        bh=XDK7pebtOcIBdJx2djJPWCJ9PGs3sJqzEe33peyAszU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jR5YdtUsOLnKy35ls2hfvA+hZLvKcWk54HaN/8YFp1szLBfsN7E3pcykD2RaezgT+
         xd6Prwm2NltLgGjtNZc8vXdAMG9eNLG3N7W9b/E/XJPjf6Z/YpdvyakymTwJiCo32g
         WwtTjCfHZe66F1wSQUxHfQRKun6efB5OGAT9VBt4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKbkC-1hr5Q64B5A-00KuFm; Tue, 10
 Sep 2019 03:48:51 +0200
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
 <3666d54b-76f7-9eee-4fb6-36c1dcc37fe9@gmx.com>
 <20190909212434.Horde.S2TAotDdK47dqQU5ejS2402@server53.web-hosting.com>
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
Message-ID: <3978da3b-bb62-4995-bc46-785446d59265@gmx.com>
Date:   Tue, 10 Sep 2019 09:48:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190909212434.Horde.S2TAotDdK47dqQU5ejS2402@server53.web-hosting.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dC91C11Gg0xyZ39gucXnf6E0ULPSf2ebt"
X-Provags-ID: V03:K1:VmNnmKVi8tN0qv0zZAx2CpZAh4KPJHZL0J84nHIjLJBS2MRsbwF
 xvKZSNb49yjltCy335JlMG0H2No8J50KdfGVaFEfc5BDJY/QoKrNy7aFcOVDEIC5tGP5cHu
 fRcLCKSiJywJOafvnaIrYX4jODWCMGhzuIfHkr/lsH6U9RQpVWHBo6bXKc+8f9sMEp9xQiU
 ybGKAvtAkc/TfZdocpAqA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pGqlxu1Yl4I=:IfB8XbCWIQGOLjkH2IfrEJ
 FG+W3CWPgi/l81ukMYKMrTjZwHYYDeenTpqHvxvjf2mn9jYDnW4Lg8RRMJ5okeSpqHJ72v4os
 1leillBpjT5XkJvCXmkWFqf1WiuvVGYrYmzBjawyRLZbf2Y45C1SJwFU6YWOVBtAfWNizBVV3
 QFHiX/TDCDY/fAHWyA1H7mZycVguA6SheePXAdP6HXcae0Ek2nKXZPMNLstvecF3jQpS4fVFD
 r5rGeOuQrdoval2toaag18hRTB30G/tgn1rP7p79nr9VYBDamV1grUGMB3JJEmzf8vrjNn4qO
 Fz+fxLcofTJBFQLjcFdcsGXGF+6lmKg6E8G3rZdDXmEMhwes8jZTnazHFH1FclK2w8OXC14el
 /5Hr33HYTJJxgiIewTsMcsFhxUfY834Qo+cp2q5qm0q5q6ycXOuUYuuCjP15X9zPsGr+T4BhW
 JDkZ+luc09iL7DgkhTbDfTWGCqUqsZmT4EkF9HzmvozKcisqpK6B815fb2rI2CNRn3FVi4H2B
 X65ptnL67eYZucYzL013mv+YKt1W3qyZYrtAeoQaUBOoYZucB4Pr300NbErxzHj+vgRZ6WvbC
 3VfTqMbYhNLv/A78t2GpeQf6nUUQHtK0n5Bjb9R4xvjQYU9XOzg6IL79eCEFYIoxI6BsrlWBN
 +VupU36CykiodXoItLzQsHRF11/j5Nqv6Su2BpB67cVJY1VHYTs0AOBuCKhPDkAaFQ/KGddrh
 QwRnGd70B7f9vr0Rr5eKpD288DmNqcAogihoKPFehka0NpQhiBxHMWvJx7mF4Ht4GCXtudS5D
 Sl6BZoUW4Nt0GR1GXz+Kfsb5ab9u97O2g88LKaLgZYFHw2zgwHk1W6yU507xJ8ke7x2XPHcdQ
 eTl8R2p/NNyikDQwfzOygyI8wt4m0/RrVanMv+pNRlg/3re6FG0EUH8DtMVnVNzZYf04ezLWC
 3mbKnANhvAeA4j6+EfMlsyq5cxsdgizAp9rcR+e6tjP1dcxu8dOoH3vHTXNQj9Ts0Y3dgf5Py
 n0djl15fUNlleHTVC9MmtRfXrQHadzIe+C4VO9l5VxhGqBH0D1jhISejevewwbCM02h24ewNS
 RLVKFXZiWdtiLxPuDM4RislyZ/32FnV/g1VjptQHpGyBGqlkNyTwNxP2JiW/AZyRQ0vE0dV3T
 pQX+zfdiDiAs8Ty1Dd7O6P+rTE7mK0gOK2eFAFApIZ9KLSoe/aXJn7LPE7r5PMcVTy1G6gJag
 WDX93NBUewiZ73C+E
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dC91C11Gg0xyZ39gucXnf6E0ULPSf2ebt
Content-Type: multipart/mixed; boundary="DGb1R16KNiNULWmKPtyaHBR6JYtkVORMX"

--DGb1R16KNiNULWmKPtyaHBR6JYtkVORMX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/10 =E4=B8=8A=E5=8D=889:24, webmaster@zedlx.com wrote:
>=20
> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>=20
>>>> Btrfs defrag works by creating new extents containing the old data.
>>>>
>>>> So if btrfs decides to defrag, no old extents will be used.
>>>> It will all be new extents.
>>>>
>>>> That's why your proposal is freaking strange here.
>>>
>>> Ok, but: can the NEW extents still be shared?
>>
>> Can only be shared by reflink.
>> Not automatically, so if btrfs decides to defrag, it will not be share=
d
>> at all.
>>
>>> If you had an extent E88
>>> shared by 4 files in different subvolumes, can it be copied to anothe=
r
>>> place and still be shared by the original 4 files?
>>
>> Not for current btrfs.
>>
>>> I guess that the
>>> answer is YES. And, that's the only requirement for a good defrag
>>> algorithm that doesn't shrink free space.
>>
>> We may go that direction.
>>
>> The biggest burden here is, btrfs needs to do expensive full-backref
>> walk to determine how many files are referring to this extent.
>> And then change them all to refer to the new extent.
>=20
> YES! That! Exactly THAT. That is what needs to be done.
>=20
> I mean, you just create an (perhaps associative) array which links an
> extent (the array index contains the extent ID) to all the files that
> reference that extent.

You're exactly in the pitfall of btrfs backref walk.

For btrfs, it's definitely not an easy work to do backref walk.
btrfs uses hidden backref, that means, under most case, one extent
shared by 1000 snapshots, in extent tree (shows the backref) it can
completely be possible to only have one ref, for the initial subvolume.

For btrfs, you need to walk up the tree to find how it's shared.

It has to be done like that, that's why we call it backref-*walk*.

E.g
          A (subvol 257)     B (Subvol 258, snapshot of 257)
          |    \        /    |
          |        X         |
          |    /        \    |
          C                  D
         / \                / \
        E   F              G   H

In extent tree, E is only referred by subvol 257.
While C has two referencers, 257 and 258.

So in reality, you need to:
1) Do a tree search from subvol 257
   You got a path, E -> C -> A
2) Check each node to see if it's shared.
   E is only referred by C, no extra referencer.
   C is refered by two new tree blocks, A and B.
   A is refered by subvol 257.
   B is refered by subvol 258.
   So E is shared by 257 and 258.

Now, you see how things would go mad, for each extent you must go that
way to determine the real owner of each extent, not to mention we can
have at most 8 levels, tree blocks at level 0~7 can all be shared.

If it's shared by 1000 subvolumes, hope you had a good day then.

>=20
> To initialize it, you do one single walk through the entire b-tree.
>=20
> Than the data you require can be retrieved in an instant.

In an instant, think again after reading above backref walk things.

>=20
>> It's feasible if the extent is not shared by many.
>> E.g the extent only get shared by ~10 or ~50 subvolumes/files.
>>
>> But what will happen if it's shared by 1000 subvolumes? That would be =
a
>> performance burden.
>> And trust me, we have already experienced such disaster in qgroup,
>> that's why we want to avoid such case.
>=20
> Um, I don't quite get where this 'performance burden' is comming from.

That's why I'd say you need to understand btrfs tech details.

> If you mean that moving a single extent requires rewriting a lot of
> b-trees, than perhaps it could be solved by moving extents in bigger
> batches. So, fo example, you move(create new) extents, but you do that
> for 100 megabytes of extents at the time, then you update the b-trees.
> So then, there would be much less b-tree writes to disk.
>=20
> Also, if the defrag detects 1000 subvolumes, it can warn the user.
>=20
> By the way, isn't the current recommendation to stay below 100
> subvolumes?. So if defrag can do 100 subvolumes, that is great. The
> defrag doesn't need to do 1000. If there are 1000 subvolumes, than the
> user should delete most of them before doing defrag.
>=20
>> Another problem is, what if some of the subvolumes are read-only, shou=
ld
>> we touch it or not? (I guess not)
>=20
> I guess YES. Except if the user overrides it with some switch.
>=20
>> Then the defrag will be not so complete. Bad fragmented extents are
>> still in RO subvols.
>=20
> Let the user choose!
>=20
>> So the devil is still in the detail, again and again.
>=20
> Ok, let's flesh out some details.
>=20
>>> I can't understand a defrag that substantially decreases free space. =
I
>>> mean, each such defrag is a lottery, because you might end up with
>>> practically unusable file system if the partition fills up.
>>>
>>> CURRENT DEFRAG IS A LOTTERY!
>>>
>>> How bad is that?
>>>
>>
>> Now you see why btrfs defrag has problem.
>>
>> On one hand, guys like you don't want to unshare extents. I understand=

>> and it makes sense to some extents. And used to be the default behavio=
r.
>>
>> On the other hand, btrfs has to CoW extents to do defrag, and we have
>> extreme cases where we want to defrag shared extents even it's going t=
o
>> decrease free space.
>>
>> And I have to admit, my memory made the discussion a little off-topic,=

>> as I still remember some older kernel doesn't touch shared extents at
>> all.
>>
>> So here what we could do is: (From easy to hard)
>> - Introduce an interface to allow defrag not to touch shared extents
>> =C2=A0 it shouldn't be that difficult compared to other work we are go=
ing
>> =C2=A0 to do.
>> =C2=A0 At least, user has their choice.
>=20
> That defrag wouldn't acomplish much. You can call it defrag, but it is
> more like nothing happens.

If one subvolume is not shared by snapshots or reflinks at all, I'd say
that's exactly what user want.

>=20
>> - Introduce different levels for defrag
>> =C2=A0 Allow btrfs to do some calculation and space usage policy to
>> =C2=A0 determine if it's a good idea to defrag some shared extents.
>> =C2=A0 E.g. my extreme case, unshare the extent would make it possible=
 to
>> =C2=A0 defrag the other subvolume to free a huge amount of space.
>> =C2=A0 A compromise, let user to choose if they want to sacrifice some=
 space.
>=20
> Meh. You can always defrag one chosen subvolume perfectly, without
> unsharing any file extents.

If the subvolume is shared by another snapshot, you always need to face
the decision whether to unshare.
It's unavoidable.

It's only whether if it's worthy to unshare.

> So, since it can be done perfectly without unsharing, why unshare at al=
l?

No, you can't.

Go check my initial "red-herring" case.

>=20
>> - Ultimate super-duper cross subvolume defrag
>> =C2=A0 Defrag could also automatically change all the referencers.
>> =C2=A0 That's why we call it ultimate super duper, but as I already me=
ntioned
>> =C2=A0 it's a big performance problem, and if Ro subvolume is involved=
, it'll
>> =C2=A0 go super tricky.
>=20
> Yes, that is what's needed. I don't really see where the big problem is=
=2E
> I mean, it is just a defrag, like any other. Nothing special.
> The usual defrag algorithm is somewhat complicated, but I don't see why=

> this one is much worse.
>=20
> OK, if RO subvolumes are tricky, than exclude them for the time being.
> So later, after many years, maybe someone will add the code for this
> tricky RO case.


--DGb1R16KNiNULWmKPtyaHBR6JYtkVORMX--

--dC91C11Gg0xyZ39gucXnf6E0ULPSf2ebt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl13AP8ACgkQwj2R86El
/qikPQf9FZAS0vSOUGXOXyW8cN2qN8sdL55a7ODR9ysxYRjI7kD3Vwe/5bjqs05N
QN+7AHV+XWUpu0YfKK6qn49x4z7VCgVWM7V++tuL2ki5VNa2YDk++x9jsQyX01UN
r9vT1JIUs4NBHqwuxI8OKCxDYIipdf9xQ+daFJilCb/VyODTipoO6aGXGkt+V8JS
daS7SHNJnm0SpURtpPZq2OcviocWv3ni54Rvojd6gci8Rr15FtlzvZ5iAuxED+bV
hXx0L41FhQk1bx7y6JOYo9zUHjYrAg8CudmZPRxUGxI1SS33zk/W36WDcBxiTMHu
FItTIcS5mCqVwPNNksbdvWzmUQGc2Q==
=A8Hz
-----END PGP SIGNATURE-----

--dC91C11Gg0xyZ39gucXnf6E0ULPSf2ebt--
