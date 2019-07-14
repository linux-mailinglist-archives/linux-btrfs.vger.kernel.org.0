Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B70FB67E6A
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2019 11:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfGNJtY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Jul 2019 05:49:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:39011 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfGNJtX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Jul 2019 05:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563097754;
        bh=a6xhizh7Y/AEQPN3+9zMK4ZGoo7xm7l8rWNAtEGd5F0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YitQUDp3V2w039ChIoj/Ji7T0Jeusk4ZUb4bsbRVq9xkRH97vx1ePIvmzEMm7jDDJ
         3GaDxdM0ZYEn3khKAcap0zOtp8eJ/iuUKoEPeuSuUMhLMymr9qdTECXnSLPS7A/BQL
         wHzpLC4plKa1yB8A4K2/gkQmrJ/fz2oK6pSTpNck=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mf0BM-1iNHO72Z0U-00gXi3; Sun, 14
 Jul 2019 11:49:14 +0200
Subject: Re: [BUG] BTRFS critical corrupt leaf - bisected to 496245cac57e
To:     Alexander Wetzel <alexander.wetzel@web.de>,
        linux-btrfs@vger.kernel.org, wqu@suse.com
References: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>
 <23f33860-9630-2045-483c-f59ebf91b043@gmx.com>
 <057a7561-f691-d7ee-1dea-27acc5ea79cc@web.de>
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
Message-ID: <6e764f38-a8dd-19e2-e885-3d7561479681@gmx.com>
Date:   Sun, 14 Jul 2019 17:49:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <057a7561-f691-d7ee-1dea-27acc5ea79cc@web.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="m1PV1kfhfRiXELv1IYXTmVJc4vHLxcqOw"
X-Provags-ID: V03:K1:cwegQ+n/pi0jyxDRopZJY2gqTw7mPoJLBN0aqjmmowUkhWsZ+If
 axS3NnPG55M4IfYZcekqw/HL3zW//AAnIBXf3bUu6qE2KyO7GVj7+M5DnhU7o2RGA/tww+g
 KgBjcM9imFZClQVWK8ZeT3EpFy/1O3AI+HGXt+stysD/3C6gnzHmsTCxOFA/k7V9d2+1CNC
 PvYvxnlGhLM6YVTr9btLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:P+8XnAcs8fg=:wb2mBeY4jloBYPA11GGcFV
 WReMblKvDUcOD1XxUK4RdT5Ake6ElPaJLPFParnanU63OUcKXY14X+IK5TIutew7EX92X0D+F
 kInXQbeSum+JZBjHGG7GtQ2xFlADWBe3mVXEv0P4uzLbpfxtqYQkiVHnBhkxz54p3OyhFtv8B
 bKFwLx2Hu6lcMy0vPAfBaq1N6TLGXVBi+agySMLanAUu+H9RVljd5S5ssMiKh1NH+BrFjGvGB
 jiZJBDXkm2aeE/RrboXlWB5m1BVdP+bdDs1b+kIhkNxzj2vBPnUrCHDUQ7zRBGyrpWqzzH4vw
 3rnEww7Jy3u+2i2BlU0QlmetnrioP3GnTBRWWc4DgeVWf8Ih7a0mFmATndyNbeZhSkLZQz75f
 fihGvZhkQWG6AAhfAKDNWZBPoQ70RMnDAG6bBOLqYnYDg1gyztc00FJa1AkaU5AinMxq5iMrZ
 rrcf/HIpOcMG660WER0/18g0SM5fpl1AKHKIXB6Hi3geekv0uyMY8q+Jq3i40dJHe1fSN+myl
 5U+1M1Iben3PAayFgJUxSJ3A2D4UWJzPBd20MElXOyu/DGtGcPpHtkfQt+yQeKDtQbhU5Unhg
 bhW4rtbwcDu7Mzg4xGVcTzlCV2TYbG6Y3nozgfrkmpwYjjnnDhDkQnp2olVV0JaFyXSy/hQyy
 ZwYTca3ocgvvhe1Sap0je5yTT73aUTJKAIxJLaFtoW//qcQ5oQ69mfxy2om3ilDBHtQ0ExT8R
 HcpEyFhvylBdebGKtBXW7QT4RHg1suXs8Qg8YM+NV7OuESOL6dx0b/qEzXyY0yX+bldB9tGeV
 /RNYZ24N0PDlyIYOMKCnHw0iBqDIpAN/0egKmmQUV4S1xjqaZx/LNX24SHXEKr2WIvBtNhID/
 mFUIFSBJk7Fnj1Mt7pDfOnANiq3biZkVPXCSmgOO190yNHk5G/eUMax/cuM0qkuQozPA6jI+m
 83FbAs7D57FQgF747+Fi/tYLR8zwzl+wT8RfzTUG4jUegzCrrVhgB/80QlDy9amppRloCFqSg
 FwL3PbVO8r3a7byfxEJxA/bq41MyFYPUaYkox0d2CcWyLzJ8MT9s9hdgYi3/GMuiNSahw38Nn
 0OypOy9KiB0ZV0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m1PV1kfhfRiXELv1IYXTmVJc4vHLxcqOw
Content-Type: multipart/mixed; boundary="o1bhPH5269qhnDhD7TCUDX60uNl4R4335";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Alexander Wetzel <alexander.wetzel@web.de>, linux-btrfs@vger.kernel.org,
 wqu@suse.com
Message-ID: <6e764f38-a8dd-19e2-e885-3d7561479681@gmx.com>
Subject: Re: [BUG] BTRFS critical corrupt leaf - bisected to 496245cac57e
References: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>
 <23f33860-9630-2045-483c-f59ebf91b043@gmx.com>
 <057a7561-f691-d7ee-1dea-27acc5ea79cc@web.de>
In-Reply-To: <057a7561-f691-d7ee-1dea-27acc5ea79cc@web.de>

--o1bhPH5269qhnDhD7TCUDX60uNl4R4335
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/14 =E4=B8=8B=E5=8D=885:25, Alexander Wetzel wrote:
>=20
>>>
>>> filtering for btrfs and removing duplicate lines just shows three uni=
q
>>> error messages:
>>> =C2=A0=C2=A0BTRFS critical (device vda3): corrupt leaf: root=3D300 bl=
ock=3D8645398528
>>> slot=3D4 ino=3D259223, invalid inode generation: has 139737289170944 =
expect
>>> [0, 1425224]
>>> =C2=A0=C2=A0BTRFS critical (device vda3): corrupt leaf: root=3D300 bl=
ock=3D8645398528
>>> slot=3D4 ino=3D259223, invalid inode generation: has 139737289170944 =
expect
>>> [0, 1425225]
>>> =C2=A0=C2=A0BTRFS critical (device vda3): corrupt leaf: root=3D300 bl=
ock=3D8645398528
>>> slot=3D4 ino=3D259223, invalid inode generation: has 139737289170944 =
expect
>>> [0, 1425227]
>>
>> The generation number is 0x7f171f7ba000, I see no reason why it would
>> make any sense.
>>
>> I see no problem rejecting obviously corrupted item.
>>
>> The problem is:
>> - Is that corrupted item?
>> =C2=A0=C2=A0 At least to me, it looks corrupted just from the dmesg.
>>
>> - How and when this happens
>> =C2=A0=C2=A0 Obviously happened on some older kernel.
>> =C2=A0=C2=A0 V5.2 will report such problem before writing corrupted da=
ta back to
>> =C2=A0=C2=A0 disk, at least prevent such problem from happening.
>=20
> It's probably useless information at that point, but the FS was created=

> with a boot image from Debian 8 around Dec 1st 2016 by migrating an als=
o
> freshly created ext4 filesystem to btrfs.

Migrated image could has something unexpected, but according to the
owner id, it's definitely not the converted subvolume. But newly created
subvolume/snapshot.

> I'm pretty sure the migration failed with the newer gentoo kernel
> intended for operation - which was sys-kernel/hardened-sources-4.7.10 -=

> and a used the Debian boot image for that. (I can piece together all
> kernel versions used from wtmp, but the Debian boot kernel would be
> "guess only".)
>=20
> The time stamps like "2016-12-01 21:51:27" in the dump below are
> matching very well to the time I was setting up the system based on the=

> few remaining log evidence I have.

I just did a quick grep and blame for inode transid related code.
The latest direct modification to inode_transid is 6e17d30bfaf4 ("Btrfs:
fill ->last_trans for delayed inode in btrfs_fill_inode."), which is
upstreamed in v4.1.

Furthermore, at that time, we don't have good enough practice for
backport, thus that commit lacks fixes tag, and won't be backported to
most stable branches.
I don't believe Debian backport team would pick this into their kernels,
so if the fs is modified by kernel older than v4.1, then that may be the
cause.

>=20
>> Please provide the following dump:
>> =C2=A0 # btrfs ins dump-tree -b 8645398528 /dev/vda3
>>
>=20
> xar /home/alex # btrfs ins dump-tree -b 8645398528 /dev/vda3
> btrfs-progs v4.19
> leaf 8645398528 items 48 free space 509 generation 1425074 owner 300
> leaf 8645398528 flags 0x1(WRITTEN) backref revision 1
> fs uuid 668c885e-50b9-41d0-a3ce-b653a4d3f87a
> chunk uuid 54c6809b-e261-423f-b4a1-362304e887bd
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 0 key (259222 DIR_ITEM =
2504220146) itemoff 3960 itemsize 35
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (259223 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 8119256875011 data_len 0 name_len 5
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: .keep

If we're checking DIR_ITEM/DIR_INDEX transid, it kernel should fail even
easier.

Those transid makes no sense at all.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 1 key (259222 DIR_INDEX=
 2) itemoff 3925 itemsize 35
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (259223 INODE_ITEM 0) type FILE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 8119256875011 data_len 0 name_len 5
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: .keep
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 2 key (259222 DIR_INDEX=
 3) itemoff 3888 itemsize 37
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (258830 INODE_ITEM 0) type DIR
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 2673440063491 data_len 0 name_len 7
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: portage
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 3 key (259222 DIR_INDEX=
 4) itemoff 3851 itemsize 37
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 location key (3632036 INODE_ITEM 0) type DIR
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 transid 169620 data_len 0 name_len 7
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 name: binpkgs
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 4 key (259223 INODE_ITE=
M 0) itemoff 3691 itemsize 160
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 generation 1 transid 139737289170944 size 0 nbytes 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sequence 139737289225400 flags 0x0(none)

Either the reported transid makes sense.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 atime 1480625487.0 (2016-12-01 21:51:27)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ctime 1480625487.0 (2016-12-01 21:51:27)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mtime 1480015482.0 (2016-11-24 20:24:42)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 otime 0.0 (1970-01-01 01:00:00)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 5 key (259223 INODE_REF=
 259222) itemoff 3676 itemsize 15
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 index 2 namelen 5 name: .keep
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 6 key (259224 INODE_ITE=
M 0) itemoff 3516 itemsize 160
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 generation 1 transid 1733 size 4 nbytes 5

This transid shold be correct.

According to the leaf geneartion, any transid larger than 1425074 should
be incorrect.

So, the are a lot of transid error, not limited to the reported item 4.
There may be so many transid error that most of your tree blocks may get
modified to update the transid.

To fix this, I believe it's possible to reset all these inodes' transid
to leaf transid, but I'm not 100% sure if such fix won't affect things
like send.


I totally understand that the solution I'm going to provide sounds
aweful, but I'd recommend to use a newer enough kernel but without that
check, to copy all the data to another btrfs fs.

It could be more safe than waiting for a btrfs check to repair it.

Thanks,
Qu


--o1bhPH5269qhnDhD7TCUDX60uNl4R4335--

--m1PV1kfhfRiXELv1IYXTmVJc4vHLxcqOw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0q+pUACgkQwj2R86El
/qiSIQf/T5p3P9Tw8VmNWCsIvhbywER+Q3ay/A9NkDUlqAKwnjZX/4aaYMXN0mg2
WeaJkVl4kJIVdE1dPxhK4FItFNY0pHBAGxfmUHG4AKw+T9UEt/GKNi++Ly69JgWE
tZ/sAOksiEtjrTijm3Ha9wM0LIwfFFJQAAinzDjib3oPWNlV+E56WNNzg4hxlugo
NeVi9qD3qerbWVVV8yNt9pPMw4vIBaSAkUUKRpT2HGOX1QVoE1KrctcC7EpdBnGw
9dNmOqJ6WV1lIE8VSEi3rbEZutfVU390k6ijDbbWVTvMSz5DEiiiTHMrL1vRZOGS
BnmbDMEU406KBE16oORmOdfEzADo+w==
=cxAP
-----END PGP SIGNATURE-----

--m1PV1kfhfRiXELv1IYXTmVJc4vHLxcqOw--
