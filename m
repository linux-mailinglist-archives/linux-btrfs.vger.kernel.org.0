Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFD937250E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 05:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfGXDFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 23:05:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:51793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfGXDFP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 23:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563937506;
        bh=vwiMf5EZjJLulz8xuQ8eFC4WMTEdd+hOPfC7bIZr6tY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=C55XSAfxtanmP7p8j1ppXgEymNxQPqinB3bdciuInEYqsx2QALxX9piWuia34h6/z
         dD3ERwKflSDi0FkZ6FMcDlWy7wxgY6PqjVRKh7Dmu/jImsVKudv7MPb8nFbBtjf91p
         FqWrfbdbblOckrkaFf1OCOc/uOfrYuyAziOeqxLw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M26r3-1hs2Sx02X3-002Yaa; Wed, 24
 Jul 2019 05:05:06 +0200
Subject: Re: [PATCH 0/3 RESEND Rebased] readmirror feature
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20190626083402.1895-1-anand.jain@oracle.com>
 <dfd817fd-f832-6c27-8bcd-e1df9141e110@gmx.com>
 <209E99E4-8859-47CD-8826-2493FBEA0407@oracle.com>
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
Message-ID: <be68e6ea-00bc-b750-25e1-9c584b99308f@gmx.com>
Date:   Wed, 24 Jul 2019 11:05:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <209E99E4-8859-47CD-8826-2493FBEA0407@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qHhUSPbFO4oslu88hXQxjIqw5jaxtCTbl"
X-Provags-ID: V03:K1:e+ht6dOZx6/0P8h4fg4bGT1t4bVQ0TtDfCda+v5cdu79BDm3KdT
 m3E4036NAdjQH7IEAaCvGzoUKRn95cXhlcW/jLVXotfffDJXFuExmogRz4uVO23lwy96Sul
 ZkcKgnhBOeJtrnGjdDwIfgidcxLLERi46McGr/sqNwmQ2bxXuV7FDpsJ0UmfuD/pY4oW+ur
 yRwuadyChoX7iH523PFqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nP8dL1qD4os=:dPHA+b83pAtOvOL/GaGk7S
 /MgrRsg+4lcmBAPYe/r5mdOjuJ3fNfj6f743N9L9JQ9Iw60YafKrvUodQbm7IYcgRuFhVAuIk
 jMqHhBO2st8zjtimvZahlTfPCxaxbMTv+YbTi0fgi3U9XhllyjR5ILJfnjmRpUZC+/Ouna/dt
 tiXhaAhvNo1Mu+9BaRFd4VBHwNyGFWz+8pt/HVBRltANAzu6FSdda0pS8kR+Se7gd8U4I4Lyk
 4u5XeLQCBevbtomKGPxxrAdD+zn4L479keBA09rKNBBB0hsuJVZYcT14KpfsyqL+WCSwNFaol
 05v9G9EJZ+7bbquhk8mXFPnKRjeNH4nykK6vnqOsmayY6VfDhsqd1gCinDjKrxOxGkxnk/mVP
 xW0CrxUAUWTfqctRj5yRAcF/XMH7pcpeEmliWHBbYRSV3cjQiV0ZrzltzihYcHgex9vs3kZSP
 4cSS0Ehdqc5uAqQV2MjfTtaoPqCNd5Om4o99b2mDsALpoHXL30KwvtsWrxpI9wNS4N/5sd/A1
 Z1iZKzIgbA1KAs+9VSAmlo+oG1Qlt9FOlvkGn/GrzQ19BVzmBwJ70QhQ366yu2t2+fup59D++
 OuPPHExsTrXdphLACKShP4IHQhDHp0Abctnz56gCLn1BOiNTTQQY+aLMY3lWSOcJ7OKACbaGf
 I+Go1vQNXsAxrngAfuv8imdLX4TZ/Bgaeh3PwbxiatNXsh4Rkr0VMR9HQa3KrZaCqQQ6SzET1
 SwNIjRWlYf/NZtN2XntqZc1twIWiO0wcWxV/FI97os6tzFs2oX/Vn8s7BWoo582O/pnnrUmM+
 78++9WOAX/hDzQv0+bN1QMfEw66pI3t0vqJMBffg+JSD2pmAO4Wd3yil3vw94GSv1a9+hYmMK
 1lnS1688bwI82KZVJ8qN9rSjc5cId8elUE/Rds29N+HSy6/PoaHmyn2peLEy0AoD5I5AdBCtu
 0HH2sNPfCi97+yKw9NDyicab6/1xVGjNWLnFtjPC5WLDw8s6aumyAro2/wU0SyHRlE756Cgp6
 U/ZwWMnJ9RErsG8y/yJiNytrgVPHxDG+bj3PbYFUYm3zzeHCVGi6RZSypFvtl2AtfD5oXwd2B
 voouJFgzpcFykk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qHhUSPbFO4oslu88hXQxjIqw5jaxtCTbl
Content-Type: multipart/mixed; boundary="LLRSjcxfB7rZUPnTqp40gWe9FWuzqRo4Y";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <be68e6ea-00bc-b750-25e1-9c584b99308f@gmx.com>
Subject: Re: [PATCH 0/3 RESEND Rebased] readmirror feature
References: <20190626083402.1895-1-anand.jain@oracle.com>
 <dfd817fd-f832-6c27-8bcd-e1df9141e110@gmx.com>
 <209E99E4-8859-47CD-8826-2493FBEA0407@oracle.com>
In-Reply-To: <209E99E4-8859-47CD-8826-2493FBEA0407@oracle.com>

--LLRSjcxfB7rZUPnTqp40gWe9FWuzqRo4Y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/24 =E4=B8=8A=E5=8D=8810:26, Anand Jain wrote:
>=20
>=20
>> On 24 Jul 2019, at 8:20 AM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2019/6/26 =E4=B8=8B=E5=8D=884:33, Anand Jain wrote:
>>> These patches are tested to be working fine.
>>>
>>> Function call chain  __btrfs_map_block()->find_live_mirror() uses
>>> thread pid to determine the %mirror_num when the mirror_num=3D0.
>>>
>>> This patch introduces a framework so that we can add policies to dete=
rmine
>>> the %mirror_num. And adds the devid as the readmirror policy.
>>>
>>> The property is stored as an extented attributes of root inode
>>> (BTRFS_FS_TREE_OBJECTID).
>>
>> This doesn't look right to me.
>>
>> As readmirror should work at chunk layer, putting it into root tree
>> doesn't follow the layer separation of btrfs.
>>
>> And furthermore, this breaks the XATTR schema. Normally we only have
>> XATTR item after an INODE item, not a ROOT_ITEM.
>>
>> Is the on-disk format already accepted or still under design stage?
>>
>=20
>  I mentioned about the storage for this new property in the RFC patch, =
as I knew there will be some surprises.
>=20
>  The advantage of using the XATTR on the ROOT_ITEM is there is no on-di=
sk format update nor there is any new KEY, albeit it deviates from the tr=
aditional way of using the xattr. Also, this approach don=E2=80=99t need =
an ioctl, as things work using the existing get/set xattr interface.
>=20
>  The other way I had in mind was to introduce a new Key in the dev-tree=
 such as
>=20
>     (BTRFS_READMIRROR_OBJECTID, BTRFS_PERSISTENT_ITEM_KEY, devid)

I'd say, this is more generic.
If one day we have some more features, we can just add new objectid for i=
t.
And to my point of view, it's easier to validate than some floating
XATTR in root tree, especially for tree checker.

The only minor comment for this key is the offset and where the tree it
belongs to.

If the readmirror policy is global, I'd prefer to put it into root tree
and set the key offset to 0.

If the policy is per-chunk, it would be more easier to understand by
putting it into chunk tree, and use chunk bytenr as key offset.

If the policy is per-device, then your current key looks pretty good to m=
e.
>=20
>  Again the interface can be ioctl or the get/set xattr. If we have to u=
se the xattr then irrespective which inode is used we would anyway store =
it in the dev-tree using the above key.

The prop interface can be enhanced, as we have filesystem level prop
already, I see no reason why it can't handle things in other trees.

Thanks,
Qu

>=20
>  This is still open for changes, the idea is to get a long lasting flex=
ible design, so comments are welcome.
>=20
> Thanks, Anand
>=20
>=20
>> Thanks,
>> Qu
>>
>>> User provided devid list is validated against the fs_devices::dev_lis=
t.
>>>
>>> For example:
>>>   Usage:
>>>     btrfs property set <mnt> readmirror devid<n>[,<m>...]
>>>     btrfs property set <mnt> readmirror ""
>>>
>>>   mkfs.btrfs -fq -draid1 -mraid1 /dev/sd[b-d] && mount /dev/sdb /btrf=
s
>>>   btrfs prop set /btrfs readmirror devid1,2
>>>   btrfs prop get /btrfs readmirror
>>>    readmirror=3Ddevid1,2
>>>   getfattr -n btrfs.readmirror --absolute-names /btrfs
>>>    btrfs.readmirror=3D"devid1,2"
>>>   btrfs prop set /btrfs readmirror ""
>>>   getfattr -n btrfs.readmirror --absolute-names /btrfs
>>>    /btrfs: btrfs.readmirror: No such attribute
>>>   btrfs prop get /btrfs readmirror
>>>
>>> RFC->v1:
>>>  Drops pid as one of the readmirror policy choices and as usual remai=
ns
>>>  as default. And when the devid is reset the readmirror policy falls =
back
>>>  to pid.
>>>  Drops the mount -o readmirror idea, it can be added at a later point=
 of
>>>  time.
>>>  Property now accepts more than 1 devid as readmirror device. As show=
n
>>>  in the example above.
>>>
>>> Anand Jain (3):
>>>  btrfs: add inode pointer to prop_handler::validate()
>>>  btrfs: add readmirror property framework
>>>  btrfs: add readmirror devid property
>>>
>>> fs/btrfs/props.c   | 120 +++++++++++++++++++++++++++++++++++++++++++-=
-
>>> fs/btrfs/props.h   |   4 +-
>>> fs/btrfs/volumes.c |  25 +++++++++-
>>> fs/btrfs/volumes.h |   8 +++
>>> fs/btrfs/xattr.c   |   2 +-
>>> 5 files changed, 150 insertions(+), 9 deletions(-)
>>>
>>
>=20


--LLRSjcxfB7rZUPnTqp40gWe9FWuzqRo4Y--

--qHhUSPbFO4oslu88hXQxjIqw5jaxtCTbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl03yt0ACgkQwj2R86El
/qheoQf+NRBfWdshi3Wkq/CsCS2NAvMdwEkNx1nCZAvAsORl6SoMFYRPz2V+WDp7
0VX9WvFEkLJVQFAxqAr055aLUBB60M5gh7a6ALduAFouRNzl0weOnSGfxgCkFl9n
4OPS4Lt9UlrEO8YZhEtJuQFA9ImInbxxwJJOOytYrsJeoo4L7J2PVgiMZ7V/tUvl
ORpEwqWkbZzj1muE+xgxz1d0fGnctDO/F28wg+bkASR9u7HZOBXwvydV3ktV25MN
ps6TwDX5QclhBmW1ITERQlBtvjgNLSoSq6oHYclNoFf1VYbEkLsUigMXUlfPpSr2
jPVfq3+/eot9aWkjP48os0lVIKYmeQ==
=7ICA
-----END PGP SIGNATURE-----

--qHhUSPbFO4oslu88hXQxjIqw5jaxtCTbl--
