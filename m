Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABD1572361
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 02:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfGXAUW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 20:20:22 -0400
Received: from mout.gmx.net ([212.227.17.20]:42903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbfGXAUW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 20:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563927613;
        bh=qoc6rbYq8aJE4X4IIRHs6g8TY3lJh5bdusVFCPQpMe4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=krFoNwtZz7mPKRRc2nfYJIuwfqMF0jAl0lvK27/bKFywdA4HzWRRwAtMXGW0y7Juo
         sD7wMWD54SYkAzJno3mAzKQgI8i4CzkIHpSkfmWUHDrhiVILsACqq9jKfDyS372EqS
         ePWxHJRGPha4znSyAJh7CUGj7kWd73iA+N+otN84=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQeA2-1i1iH43czG-00NfIp; Wed, 24
 Jul 2019 02:20:13 +0200
Subject: Re: [PATCH 0/3 RESEND Rebased] readmirror feature
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20190626083402.1895-1-anand.jain@oracle.com>
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
Message-ID: <dfd817fd-f832-6c27-8bcd-e1df9141e110@gmx.com>
Date:   Wed, 24 Jul 2019 08:20:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190626083402.1895-1-anand.jain@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SNrQoPlU5FV5K1Ulk4VuL4lXMsXgmpiES"
X-Provags-ID: V03:K1:oMTwWihuOae9Ifub4NKzhn+M4zPLlSOAlwdOqy2vUIG9XJi0262
 MHgHp5jfFMJ3cBlDo16Q6pKkRbzfPkD5RvK4vXwYTcs1IDzoXBvcF0cybp+LIH0CpVa20+7
 twXoih8rVLbwVuZql6JYDAdlEyPHn8PaffMWmce89O/zB9FP/4TpkaRBPb/bBL+e0tP6R+T
 ywF+REDM5r8vHlHBa4WaQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4ZiwLtm8O1k=:Wfg967R6+bIuPZwI36JDbF
 svHyqHD7OHlIgnRxbRpcu+GZ/J8ZzcnPbNF3JrTJ+bGyWZOb39NmvFd+Q9ypH6IjgT34ILLbe
 oLNpDxe90FqaGR1CjJnWBefXUCbIZPrWY3Pro9+9adAq7kr+V+3cFMV/fA3lqILohJ6m3CqVq
 c4+AswkwOU6HbdtFgoHZc5+TcsmaAnruYVogOPmK7plstb3d/9hF8bho7qCac2ZJJA26ysmGb
 SKWGRWJZ+GAeoTmNPpXg3Rc+jk/8ebdlKAHGGklx61lj+7bIGLd3H75gWXaD5CL3PbQA+283e
 EVoZ3pMad/g2HlIyITNKeQdZMc8L4ELxaJUaWJDlsplenDTvIBcUFdmTeQv9e149L4eLrhvFI
 0dSG7JP5z1nXmRWfSsQDgeshJd1hw9NKawbE73NqC5OspkyRqyrWZmSUwx4D/AXUwWS7iOdTR
 dN32NhqdnTRdrws4ZcGv5DJLV9QXRMtwjAMjxbnXgbsNOZTc9UM4bEwDptQfPj5hfineWM+Pz
 XpS7h9DdVK8CrjqtQforfj3BZwY5nGa7LxytW73dAQPzI7/hV6G1UyISISEb1zP79IxkMkhgd
 KXWx+3pQHLlYoe5sb/bP238R/eEVNx9QB2+Xl5eMhK+suiifh7wlEQlYMg/F1w83XwPHB7hhr
 nwkItDJFA4vHSvRx7s0UWe0mAtafEzMU5cxVaofSJXoqgzqn0TYggGObsv4zatWOX5tSCNd56
 blzXwcmrEn8l+HXaDZUf3seIgdHWebb/fwhoHCfX0UYhDE4UJYrtWLbaFnMc8JFSK91UJQuJR
 Alibx48dsvjucJYOk5jDGfiMKRLVq5NYTxPqksX8BdOH8zy0rc2CnaW95w93cQVMnCPlGSa0C
 RkqqDpCXnSBlItzh7DIC6EnuYRz4KcLLA+HbbaNcj3pP8q4TAPsyFOqRUGvxSnks44x00RSjI
 17r2pjfy67pA/l4sLIWYpIxJiQgbMIpgqnAQiXYiKjCghtdXezq2X4g4D44Lucn43um9xm4xB
 XD0Uuxrgtq3oRa52Czc3anXOwGXGZrPghhoJXP0Pug0hO9KLDDCrWa8IqoOk0bcf6bGXsAUxf
 gt0LKEMtjI2RaA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SNrQoPlU5FV5K1Ulk4VuL4lXMsXgmpiES
Content-Type: multipart/mixed; boundary="PwI96wrUrNAmkyjVogipBlJJpCWOMwryh";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Message-ID: <dfd817fd-f832-6c27-8bcd-e1df9141e110@gmx.com>
Subject: Re: [PATCH 0/3 RESEND Rebased] readmirror feature
References: <20190626083402.1895-1-anand.jain@oracle.com>
In-Reply-To: <20190626083402.1895-1-anand.jain@oracle.com>

--PwI96wrUrNAmkyjVogipBlJJpCWOMwryh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/26 =E4=B8=8B=E5=8D=884:33, Anand Jain wrote:
> These patches are tested to be working fine.
>=20
> Function call chain  __btrfs_map_block()->find_live_mirror() uses
> thread pid to determine the %mirror_num when the mirror_num=3D0.
>=20
> This patch introduces a framework so that we can add policies to determ=
ine
> the %mirror_num. And adds the devid as the readmirror policy.
>=20
> The property is stored as an extented attributes of root inode
> (BTRFS_FS_TREE_OBJECTID).

This doesn't look right to me.

As readmirror should work at chunk layer, putting it into root tree
doesn't follow the layer separation of btrfs.

And furthermore, this breaks the XATTR schema. Normally we only have
XATTR item after an INODE item, not a ROOT_ITEM.

Is the on-disk format already accepted or still under design stage?

Thanks,
Qu

> User provided devid list is validated against the fs_devices::dev_list.=

>=20
>  For example:
>    Usage:
>      btrfs property set <mnt> readmirror devid<n>[,<m>...]
>      btrfs property set <mnt> readmirror ""
>=20
>    mkfs.btrfs -fq -draid1 -mraid1 /dev/sd[b-d] && mount /dev/sdb /btrfs=

>    btrfs prop set /btrfs readmirror devid1,2
>    btrfs prop get /btrfs readmirror
>     readmirror=3Ddevid1,2
>    getfattr -n btrfs.readmirror --absolute-names /btrfs
>     btrfs.readmirror=3D"devid1,2"
>    btrfs prop set /btrfs readmirror ""
>    getfattr -n btrfs.readmirror --absolute-names /btrfs
>     /btrfs: btrfs.readmirror: No such attribute
>    btrfs prop get /btrfs readmirror
>=20
> RFC->v1:
>   Drops pid as one of the readmirror policy choices and as usual remain=
s
>   as default. And when the devid is reset the readmirror policy falls b=
ack
>   to pid.
>   Drops the mount -o readmirror idea, it can be added at a later point =
of
>   time.
>   Property now accepts more than 1 devid as readmirror device. As shown=

>   in the example above.
>=20
> Anand Jain (3):
>   btrfs: add inode pointer to prop_handler::validate()
>   btrfs: add readmirror property framework
>   btrfs: add readmirror devid property
>=20
>  fs/btrfs/props.c   | 120 +++++++++++++++++++++++++++++++++++++++++++--=

>  fs/btrfs/props.h   |   4 +-
>  fs/btrfs/volumes.c |  25 +++++++++-
>  fs/btrfs/volumes.h |   8 +++
>  fs/btrfs/xattr.c   |   2 +-
>  5 files changed, 150 insertions(+), 9 deletions(-)
>=20


--PwI96wrUrNAmkyjVogipBlJJpCWOMwryh--

--SNrQoPlU5FV5K1Ulk4VuL4lXMsXgmpiES
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl03pDkACgkQwj2R86El
/qhxSwgAiFiRhsTLEGOl4VDEl/ytxZ51RACJdnvVtXe98VP7ydtEMBP+hJoKIJcs
DxOt9cPUT/1Ekq+jI8Dtwc6TlA1GWCtM3uRjdFkQF5d8IOSyfh8LiiNA0HpIpe3F
s1aJljHEr1mMM4dViDvsuDOyJ6ls6u1rAr0F06NaIpLZdDdLTFYQ0HFwA3j0gG3O
t5F+eAIooYN1EIQyA/HbfFOfqljAJ09tMdYm3p4+7mq7nC07UFVbLOH5xMgq7uWo
lZpGTnO1lVAbTnckocZ4XEoP8pNfZ4a19xNERXB4hiE5ONPOZ0b5RLaqKT/a+ZP8
e7Xk9iV7/xDLPy7vNnPy283YqR6ozA==
=e29K
-----END PGP SIGNATURE-----

--SNrQoPlU5FV5K1Ulk4VuL4lXMsXgmpiES--
