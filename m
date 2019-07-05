Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8705FEF0
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 02:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfGEAGX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 20:06:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:48841 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbfGEAGX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jul 2019 20:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562285177;
        bh=RUPtVeHDTIsthoATkLL2PO6h37ooscnQfWi/3iXxcfo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Fp8wnxOBqngU2HHIwn02m9IcmjWRvJYcUhHKVc2NaO89UY/uD8urGkDh3epcsmi9S
         aTJntRyfjw5Ffo6sZRZr66GZnfs1bDUEDZ2lupfywPdG/w9Yh8xq2GkplLP4kkvxO/
         O4mHNxP4+yhIox5ORa8yTMoCIbS4NXD7Pu03mqwI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Lwarz-1ialYF47X5-018MB0; Fri, 05
 Jul 2019 02:06:17 +0200
Subject: Re: repeatable(ish) corrupt leaf filesystem splat on 5.1.x
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20190704210323.GK11831@hungrycats.org>
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
Message-ID: <89b27a4e-8074-9e07-f98f-fc7f25d78ca1@gmx.com>
Date:   Fri, 5 Jul 2019 08:06:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190704210323.GK11831@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rPoTQPlmJrDrBQ55wPxIb2hmTVv8AALvb"
X-Provags-ID: V03:K1:omvp0S3+9EVdFZcBMOaAXWnTVn8lDRJ1NYnuM8ReSnfW05wK0JL
 cXylUPmd4a5xnxm3OfkStxvnZ6wS0HmDiQ2dPw56hDTUwr37RF/aoj21tcpVNC6NPiyDUdR
 xUfqvHc2eeTqNiQ/excbQy0NWDpXlzyyUqHl1iO/B3PjPplTwS1Lu1xuUV7vcZXhN5/RyHr
 uR/QhPOK+kUSExtCDn54w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eCp/akJc6fU=:dFP84Ly/lKUuzhMwmixLDZ
 2QbzxH0yiDk/1eDmWczV+KOBPU5t/dbgBySzqADDs0vabra4O7H9dLvkpMYDoSFHydZEh1VOw
 92hKulP4FMElzfOP4kB1CBTRYZgH4olsWHC9gTe0KuawJJ3v7sjgIvKbGtzeM2r4lUyJioAL+
 lyN1mJgAHyimx5XFdx+K7HbmTMuyDVwJsy3pjYd1lUyzTh5eTeJxFQAx1VciBSoHmvHK3WTdU
 LwUA61iY80qNuLhv13GzEX9UUCD58FgIBwYVC8iQYIKFjxe8ZO7KS1nsZCbEYKkZfLv+LKQ4O
 z9pZVsoWzRDlVL+Zu/vCxNNq58mbc4m13NLDub2Xp9CUc4m1dYWLc2wWja1+A9XaHN/FvM8LT
 CDeHQR96BTPf3v/V71p4vmgZDM69FikzoYB/p0lB1WRl3E0kFwzMm8UuHMWbLSMZ0sShZ2e2o
 AVMakYMxhrW+AFzNKlEvYbM4tHbqhHsqjOuX3/yVGRydJi/Hb/SUhvxwYOuVL9JMpnrGq/noy
 +i9lbMy0MqQjfbQJhNqZve+0tlzam7gKZSeAU4UyjR7erBYVC6Ucvv9MrNOAfW2fAu9WKwRP2
 FReeXjxuBrvXY4KBYpUeq1b2wvLMawz8WbGLRXSOVdAaXd9BqPFaEZbx3cP8uaxIXmOpevK0t
 CVmohU7fd+S9gQpbWEFyiIXanmxftKSGIhssx9Enh4Ez4e4lXXnjP+UXRl8fjVkTSRqwWzsT2
 ZhUXB+3BLTOfjjemEYqPaGheFfsqmRacMABLcwpBkrcgCMjJVI/kd3H6eTT7LtqnN1p5/k8rq
 OPgZj7Oz0aMGVp0JJ9lOc0/4RcV7Wv0mSqBS6Gj2yY9p/0+/iP2PtHOV8NkUT9Cs9gGnpCIwP
 5hZtxa4ojMs+fIy2GwS5YGlu1+KICGss8qCznYnRFeHvSHDtSkUKzl7IXD2ssHyQGI51GOgPV
 UVSkUjS0S8RsvLwhicbNe3YM9EN6F8mnSkGrSpoa875H9TfgTmw+3GOhK2IGpZIBMlqJzAK9x
 2bSGgw+kH3rINLWEQT7+gA2fpLqUrtLum5QCrOILXN6dhB46qYkoLwbUIYBKZpO4ZmysqdvtP
 gQJR4JiOYYqbNs=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rPoTQPlmJrDrBQ55wPxIb2hmTVv8AALvb
Content-Type: multipart/mixed; boundary="QjF1WOH2EzylW1JzALUuRasKwRlv4IguC";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, linux-btrfs@vger.kernel.org
Message-ID: <89b27a4e-8074-9e07-f98f-fc7f25d78ca1@gmx.com>
Subject: Re: repeatable(ish) corrupt leaf filesystem splat on 5.1.x
References: <20190704210323.GK11831@hungrycats.org>
In-Reply-To: <20190704210323.GK11831@hungrycats.org>

--QjF1WOH2EzylW1JzALUuRasKwRlv4IguC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/5 =E4=B8=8A=E5=8D=885:03, Zygo Blaxell wrote:
> I've seen this twice in 3 days after releasing 5.1.x kernels from the
> test lab:
>=20
> 5.1.15 on 2xSATA RAID1 SSD, during a balance:
>=20
> 	[48714.200014][ T3498] BTRFS critical (device dm-21): corrupt leaf: ro=
ot=3D2 block=3D117776711680 slot=3D57, unexpected item end, have 10953475=
5 expect 12632
> 	[48714.200381][ T3498] BTRFS critical (device dm-21): corrupt leaf: ro=
ot=3D2 block=3D117776711680 slot=3D57, unexpected item end, have 10953475=
5 expect 12632
> 	[48714.200399][ T9749] BTRFS: error (device dm-21) in __btrfs_free_ext=
ent:7109: errno=3D-5 IO failure
> 	[48714.200401][ T9749] BTRFS info (device dm-21): forced readonly
> 	[48714.200405][ T9749] BTRFS: error (device dm-21) in btrfs_run_delaye=
d_refs:3008: errno=3D-5 IO failure
> 	[48714.200419][ T9749] BTRFS info (device dm-21): found 359 extents
> 	[48714.200442][ T9749] BTRFS info (device dm-21): 1 enospc errors duri=
ng balance
> 	[48714.200445][ T9749] BTRFS info (device dm-21): balance: ended with =
status: -30
>=20
> and 5.1.9 on 1xNVME, a few hours after some /proc NULL pointer derefere=
nce
> bugs:
>=20
> 	[89244.144505][ T7009] BTRFS critical (device dm-4): corrupt leaf: roo=
t=3D2 block=3D1854946361344 slot=3D32, unexpected item end, have 13352227=
03 expect 15056
> 	[89244.144822][ T7009] BTRFS critical (device dm-4): corrupt leaf: roo=
t=3D2 block=3D1854946361344 slot=3D32, unexpected item end, have 13352227=
03 expect 15056
> 	[89244.144832][ T2403] BTRFS: error (device dm-4) in btrfs_run_delayed=
_refs:3008: errno=3D-5 IO failure
> 	[89244.144836][ T2403] BTRFS info (device dm-4): forced readonly
>=20
> The machines had been upgraded from 5.0.x to 5.1.x for less than 24
> hours each.

All in btrfs_run_delayed_refs() when updating extent tree.

The new check is to prevent btrfs receiving corrupted data, thus it
happens at tree read time, where there should be no race.
And that check has been there for a while, v4.15 should be the first
kernel version with such check.

So it doesn't look like false alert but some real corruption.

Would you please provide the tree dump of the related tree blocks?

>=20
> The 5.1.9 machine had crashed (on 5.0.15) before, but a scrub had passe=
d
> while running 5.1.9 after the crash.  The filesystem failure occurred
> 20 hours later.  There were some other NULL pointer deferences in that
> uptime, so maybe 5.1.9 is just a generally buggy kernel that nobody
> should ever run.  I expect better from 5.1.15, though, which had no
> unusual events reported in the 8 hours between its post-reboot scrub
> and the filesystem failure.

BTW, would you like to spend some extra time on v5.2-rc kernel?
In v5.2 kernel, we have extra write time tree checker (and makes read
time tree checker a little faster).
Current read time only checker is not good enough to expose the cause of
the coorruption and prevent it.

With v5.2, if the bug is still there, we could at least prevent the
corruption before it's too late.

>=20
> I have several other machines running 5.1.x kernels that have not yet h=
ad
> such a failure--including all of my test machines, which don't seem to =
hit
> this issue after 25+ days of stress-testing.  Most of the test machines=

> are using rotating disks, a few are running SSD+HDD with lvmcache.
>=20
> One correlation that may be interesting:  both of the failing filesyste=
ms
> had 1MB unallocated on all disks; all of the non-failing filesystems ha=
ve
> 1GB or more unallocated on all disks.  I was running the balance on the=

> first filesystem to try to free up some unallocated space.  The second
> filesystem died without any help from me.
>=20
> It turns out that 'btrfs check --repair' can fix these!  First time
> I've ever seen check --repair fix a broken filesystem.  A few files are=

> damaged, but the filesystem is read-write again and still working so fa=
r
> (on a 5.0.21 kernel) .

Maybe one won't believe, btrfs check has leaf re-order and item offset
repair from the very beginning, but I'm not sure how reliable it is.

Thanks,
Qu

>=20


--QjF1WOH2EzylW1JzALUuRasKwRlv4IguC--

--rPoTQPlmJrDrBQ55wPxIb2hmTVv8AALvb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0elHUACgkQwj2R86El
/qjzFAf9FthpEQ6r1GYLp2Cn704t/I8GDUa+ASa5W3KtFFKjh4GluZd1eo08O/iT
lliDrMN1UtUQiztPuDnzoDnsU3oMHVmUgYy//ktzMJakp7U06czD4UAaSLbkcH3G
TjhRdQTAXcDYHGxTsbJYt+Sp5ht/bEJp8RNXJslsGe4uWUYu2DyOKqn8Pn7ZdMXl
qJ+bmZdv97TkeVLGiqI1o4LQYVf0GZOsTFO2iOX8DnVwCdHtS0Lc2sH5Yz0UZqMQ
NRdWhwNVxFsau1kzxOU43pZpBYj65YI5lzYTXqr48D1VRZLyM8fe9OPjohgI0V38
AObawcan+3ITzvOy3f0Qs9rOnbl81w==
=z5yT
-----END PGP SIGNATURE-----

--rPoTQPlmJrDrBQ55wPxIb2hmTVv8AALvb--
