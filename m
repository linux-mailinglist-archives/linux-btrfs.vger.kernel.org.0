Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885F050109
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2019 07:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfFXFjz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 01:39:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:33633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFXFjz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 01:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561354790;
        bh=QgtI5f0TBZugS7Ox2TxHL/G5M3XvIfnVPvp9FcGm8f4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DGTYjX3UbbeiajWXZQQszWjBoKf5StMAHF5YoDjiJsKuvohVY2lSe1+ywPsTQT+Fb
         x3wnfA+uXlbNLavWYvPCNB6wlCAb3tPKkTq3MR4ITGzuND+f/IcTDzfKnjQrQLiLiL
         NEx+xPvt3hMNzpnSGaaoUWP2Z+WQoA/DFhRzxyss=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N17UW-1ihfix1p0c-012akY; Mon, 24
 Jun 2019 07:39:50 +0200
Subject: Re: btrfs vs write caching firmware bugs (was: Re: BTRFS recovery not
 possible)
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20190623204523.GC11831@hungrycats.org>
 <f1cfe396-aac7-b670-b8de-f5d3b795acfe@gmx.com>
 <20190624042926.GA11820@hungrycats.org>
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
Message-ID: <c6a0f62c-6bcc-a291-02cd-734da4a5f951@gmx.com>
Date:   Mon, 24 Jun 2019 13:39:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624042926.GA11820@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yqqFT8h6mqsJ59eljhrhL1guaN00oCxy6"
X-Provags-ID: V03:K1:ZKwUzGTvRcRg7guJB3XQ8StlC780nGLJjryzbOh1a3jvmy54UGG
 iorT/gaMGoootHY5Z/vrYFXeuccZQpN0yilylRPq2vKkR8TDhcvo4sNGeDlxEz8srDijI9D
 i8UJu2KH0rQiRVc6k6/jArBTjPM6Egm+x0KAMZiOf5RYB6JDtEjw5jla92/dKHe1oo98ZTp
 WIdMrMrqSzWT41YcpSLlg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yt4HRHjwywQ=:EzQacupyUYu11haLpB4iR1
 GEAChrq2BaFgfIbgZroOVqjJv9ohi8vizQl7EavCEPQl8lwgyoIg1lWd8mMedEyd8a4u0KMF0
 dlBGyRHHymJm+qorjeofrYJVSH3xqXzy1fSs8cbYsKfVZ6k36yc5kW+tBqvfmtItvERcVTo7E
 V8IRB8QBQkBxUBAbsxjUGtGl/JQsqPX/anj+s28ZGHsuKSZ/yKlsIghahzOtGxFJ3UB2pYSDf
 JKfStITY0P9v3LisM3Ecp/OqDcIh5uUfLW6vTNHZviuUh7xcreg0naaAPsrVz/jbPWILY/MIo
 yyV9j5G8XNt5rfhC407Ouw/4aTyJ215EyoWpeDLyYT1YEpqWEAGe5FhyPmpEFB6gblHZU6tnb
 8up7iR5rL+sYYmKw9HB9sfE3HA1Smq8vIohGhCL/5t2Juklx5Ar5enQ+RSDeVGxsHpUXwh6Eo
 D8AkRWzZCKAJ01bDE/JqvA9KpCGnDCl23E1NVdJ9a6th5M3vWiaqOAJGn616OLAYtupOcXcw7
 Ty76KwY9YhtPy7c2rJ2++6JkU4v0u9rFxjiaEgBG+qa6mlynAbCqj/ZyUYFpfW6dentFn+5vt
 QEDwx0peRkVlSIB06v2ETrq+NoAZS9zKn5at78myh/22IdhKSmbvegL5UoTeyTLAma0/I82VU
 Hdu0ryTuIkHmnl05fNkySvzDCeHRoB93nIB/VNijxGl1YiqyIuJCcJEJZ1UaxM5JBPtsJdKq+
 u25xrAZp1gwLVH2r5B3GpUzmKBKyD/iHdW/p0XGKr8h78ScSd+ZV9fiS4LjcYUn1QaWvW3YNz
 R3ehXqc4xWcLTBRSDtLOZLxpPm1lhZmhPBK5GkIa3vGl4Nd8P2/UTVR+cdTsWNB13vzGEm6e4
 RjIJVcvqvRrKWcmO+l1rI0ig1pFeu+BCHYYFOphWZRoYceEj9a9OGJkYOrK5D64fZs3MpAxA/
 I9csZqs98wfuc4ihwUmW/rgegOJSC6w0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yqqFT8h6mqsJ59eljhrhL1guaN00oCxy6
Content-Type: multipart/mixed; boundary="ZFXHqJunegP1LKOgBl34UTPRD50GeDhSW";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <c6a0f62c-6bcc-a291-02cd-734da4a5f951@gmx.com>
Subject: Re: btrfs vs write caching firmware bugs (was: Re: BTRFS recovery not
 possible)
References: <20190623204523.GC11831@hungrycats.org>
 <f1cfe396-aac7-b670-b8de-f5d3b795acfe@gmx.com>
 <20190624042926.GA11820@hungrycats.org>
In-Reply-To: <20190624042926.GA11820@hungrycats.org>

--ZFXHqJunegP1LKOgBl34UTPRD50GeDhSW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/24 =E4=B8=8B=E5=8D=8812:29, Zygo Blaxell wrote:
[...]
>=20
>> Btrfs is relying more the hardware to implement barrier/flush properly=
,
>> or CoW can be easily ruined.
>> If the firmware is only tested (if tested) against such fs, it may be
>> the problem of the vendor.
> [...]
>>> WD Green and Black are low-cost consumer hard drives under $250.
>>> One drive of each size in both product ranges comes to a total price
>>> of around $1200 on Amazon.  Lots of end users will have these drives,=

>>> and some of them will want to use btrfs, but some of the drives appar=
ently
>>> do not have working write caching.  We should at least know which one=
s
>>> those are, maybe make a kernel blacklist to disable the write caching=

>>> feature on some firmware versions by default.
>>
>> To me, the problem isn't for anyone to test these drivers, but how
>> convincing the test methodology is and how accessible the test device
>> would be.
>>
>> Your statistic has a lot of weight, but it takes you years and tons of=

>> disks to expose it, not something can be reproduced easily.
>>
>> On the other hand, if we're going to reproduce power failure quickly a=
nd
>> reliably in a lab enivronment, then how?
>> Software based SATA power cutoff? Or hardware controllable SATA power =
cable?
>=20
> You might be overthinking this a bit.  Software-controlled switched
> PDUs (or if you're a DIY enthusiast, some PowerSwitch Tails and a
> Raspberry Pi) can turn the AC power on and off on a test box.  Get a
> cheap desktop machine, put as many different drives into it as it can
> hold, start writing test patterns, kill mains power to the whole thing,=

> power it back up, analyze the data that is now present on disk, log the=

> result over the network, repeat.  This is the most accurate simulation,=

> since it replicates all the things that happen during a typical end-use=
r's
> power failure, only much more often.

To me, this is not as good as expected methodology.
It simulates the most common real world power loss case, but I'd say
it's less reliable in pinning down the incorrect behavior.
(And extra time wasted on POST, booting into OS and things like that)

My idea is, some SBC based controller controlling the power cable of the
disk.
And another system (or the same SBC if it supports SATA) doing regular
workload, with dm-log-writes recording every write operations.
Then kill the power to the disk.

Then compare the data on-disk against dm-log-writes to see how the data
differs.

=46rom the view point of end user, this is definitely overkilled, but at
least to me, this could proof how bad the firmware is, leaving no excuse
for the vendor to dodge the bullet, and maybe do them a favor by pinning
down the sequence leading to corruption.

Although there are a lot of untested things which can go wrong:
- How kernel handles unresponsible disk?
- Will dm-log-writes record and handle error correctly?
- Is there anything special SATA controller will do?

But at least this is going to be a very interesting project.
I already have a rockpro64 SBC with SATA PCIE card, just need to craft
an GPIO controlled switch to kill SATA power.

>  Hopefully all the hardware involved
> is designed to handle this situation already.  A standard office PC is
> theoretically designed for 1000 cycles (200 working days over 5 years)
> and should be able to test 60 drives (6 SATA ports, 10 sets of drives
> tested 100 cycles each).  The hardware is all standard equipment in any=

> IT department.
>=20
> You only need special-purpose hardware if the general-purpose stuff
> is failing in ways that aren't interesting (e.g. host RAM is corrupted
> during writes so the drive writes garbage, or the power supply breaks
> before 1000 cycles).  Some people build elaborate hard disk torture
> rigs that mess with input voltages, control temperature and vibration,
> etc. to try to replicate the effects effects of aging, but these setups=

> aren't representative of typical end-user environments and the results
> will only be interesting to hardware makers.
>=20
> We expect most drives to work and it seems that they do most of the
> time--it is the drives that fail most frequently that are interesting.
> The drives that fail most frequently are also the easiest to identify
> in testing--by definition, they will reproduce failures faster than
> the others.
>=20
> Even if there is an intermittent firmware bug that only appears under
> rare conditions, if it happens with lower probability than drive hardwa=
re
> failure then it's not particularly important.  The target hardware fail=
ure
> rate for hard drives is 0.1% over the warranty period according to the
> specs for many models.  If one drive's hardware is going to fail
> with p < 0.001, then maybe the firmware bug makes it lose data at p =3D=

> 0.00075 instead of p =3D 0.00050.  Users won't care about this--they'll=

> use RAID to contain the damage, or just accept the failure risks of a
> single-disk system.  Filesystem failures that occur after the drive has=

> degraded to the point of being unusable are not interesting at all.
>=20
>> And how to make sure it's the flush/fua not implemented properly?
>=20
> Is it necessary?  The drive could write garbage on the disk, or write
> correct data to the wrong physical location, when the voltage drops at
> the wrong time.  The drive electronics/firmware are supposed to impleme=
nt
> measures to prevent that, and who knows whether they try, and whether
> they are successful?  The data corruption that results from the above
> events is technically not a flush/fua failure, since it's not a write
> reordering or a premature command completion notification to the host,
> but it's still data corruption on power failure.
>=20
> Drives can fail in multiple ways, and it's hard (even for hard disk
> engineering teams) to really know what is going on while the power supp=
ly
> goes out of spec.  To an end user, it doesn't matter why the drive fail=
s,
> only that it does fail.  Once you have *enough* drives, some of them
> are always failing, and it just becomes a question of balancing the
> different risks and mitigation costs (i.e. pick a drive that doesn't
> fail so much, and a filesystem that tolerates the failure modes that
> happen to average or better drives, and maybe use RAID1 with a mix of
> drive vendors to avoid having both mirrors hit by a common firmware bug=
).
>=20
> To make sure btrfs is using flush/fua correctly, log the sequence of bl=
ock
> writes and fua/flush commands, then replay that sequence one operation
> at a time, and make sure the filesystem correctly recovers after each
> operation.  That doessn't need or even want hardware, though--it's bett=
er
> work for a VM that can operate on block-level snapshots of the filesyst=
em.

That's already what we're doing, dm-log-writes.
And we failed to expose major problems.

All the fsync related bugs, like what Filipe is always fixing, can't be
easily exposed by random workload even with dm-log-writes.
Most of these bugs needs special corner case to hit, but IIRC so far no
transid problem is caused by it.

But anyway, thanks for your info, we see some hope in pinning down the
problem.

Thanks,
Qu


--ZFXHqJunegP1LKOgBl34UTPRD50GeDhSW--

--yqqFT8h6mqsJ59eljhrhL1guaN00oCxy6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0QYhsACgkQwj2R86El
/qjlfgf+MqVBx6OvxnvrPdYzIrwKybWoVrH/i7nAyoZoDzwyT+XNqNGZrweSOELO
P/DYQAeUDRGSsI/3TKev/OADfW8pcFdGw+ro1uEOl/EVdnfEegQbhPF/t26CVZQ2
z/umzcwosm3A2KAcgqXsViWs/08C11S2aNVXqzcIbEucNlqqmaSUd4vYwF2aZRFT
ezalji9gDgZWwyoSB5VfsxU/fQizWzWliRfL94SKrXMpmE1v2DYazxboDPKD88wC
YLkFgIkVu0eMGr2bXWJy0CPGQHYNKWaTci1o6MFj/YaFBu1JXUd+E9LbdCT20Gg0
C4UtXJRx0mYrqIisa/bUi7zlwckTqA==
=Dj91
-----END PGP SIGNATURE-----

--yqqFT8h6mqsJ59eljhrhL1guaN00oCxy6--
