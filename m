Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A936A7BA06
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2019 08:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfGaG6S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Jul 2019 02:58:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:49855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbfGaG6Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Jul 2019 02:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564556288;
        bh=7U4w2Jr2ENv3S9lH0F9LY2460WXVPOhBdodljpknsAY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=N9o/RdbEBI8Z2J/QoAzuw4ZS63X1i7LxuOWmM3GA7OcH1ED9zByN5LWQswPhxUWrB
         AErphU36hF/YjVYxoKRHnEA1D1wsZG5/uJ3z2FMzLilv3p5zZxk4CzKDCemC/3y1qc
         CKXoTUrqGJO+APGmOvP0/tLupY/kfevOUFgp3S4A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOzOm-1hirhr1shY-00PPZv; Wed, 31
 Jul 2019 08:58:08 +0200
Subject: Re: [PATCH] btrfs: Allow more disks missing for RAID10
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190718062749.11276-1-wqu@suse.com>
 <20190725183741.GX2868@twin.jikos.cz>
 <a835760e-be9d-cfd9-d8c3-c316f34ec20f@gmx.com>
 <20190726103902.GZ2868@twin.jikos.cz>
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
Message-ID: <052a23bb-428d-3249-d8cb-b508ebca0b62@gmx.com>
Date:   Wed, 31 Jul 2019 14:58:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726103902.GZ2868@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VgPshRbJHuXnbYX7MKKZYNeLAmiLiM9V4"
X-Provags-ID: V03:K1:rpEp9rlZB70gmYKE1Wo0ru1Nolp6EHtLK7xvgrrRxrsGX4xjmms
 XJUO4DrftZfR87kZqtg/zlq1k6E0pw4qgyaOIjrp58DsKVC1C8cFE015ZVNQRMNIx/8lUhG
 Uu8Zznqr2o9a26PZaAK2y6qtJqdSxPx8sEAVIfyXXQnAOy1/pCD/BFOODENaSo1NaZ/KSxU
 4Wz1rqjR/FOSx87vkg4JA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iHLSD6Q+SsE=:d5pyKZce0Z5+3Eoblk/1Op
 K4gQ8aO7f+dXO1VI8MhJ77aRgrl0I7O8mBhkDlo8rGr80bmZllHWC9iqopwM+3mwvHamQ0NGg
 gwE7rnXer1ZDKiWctgLEFonxUMRwKSBG6hVhkK+WGoZnTaUxultDcxOv9KPVexqGdGXQ/gFg9
 vdJENYuYPTyUTDTVm0unWL4qrAzFl+X5dmEX9B91B6zVdCtdTYW4Ua+c7RCd8XKrLuggG7zMF
 KbVlWg+NcPowHGazLrrYqqG9SyXwnB5pk3LronAzrhTRaR52xK+IJyWi8GzFaSANWmc1RnvXI
 5IxXVgjFLndw6tHhsYoWmUGRoYG4QMOejN63pnX9NMGXzX82ax/jIWHkdbC4WxGD14mBW09Rq
 gFD12novVSOP7lc0fb+AysGVFQhKttYzDDWNS7B7QqNe5hfbWFopcISk82pcHCc3YPny+eFiL
 xc3aZgcCZns91nRHGdQVkbTuSkbTy45RNee4pjk/Z8YZ0nduiuZkEs3I6eAIj8D9cqnzvCK4B
 7RygMKCryy8azW827deW1ZHFl4p5QdDGhrHvmahRYNpm85cAK9YBDQAVDIz0463v+TpE5euXj
 n5aeEAAKHjthL0qmigGoE472IgZeI5sXvGKbZWlR31+DYlW+WOBC0ifKNgWHePeKbK5wfLKep
 ew/rTvK4jcKuOmVn98obY3mA8UL8qySMWRLvcCbd1l9Wgs9hdWWS+4uqcfA4JH+gUiiMshblG
 SCG9JYTN85nx2/lgc2LQrCqXbjV8T1UqylQmFWrqLe1I8jzbgThvo/QFbbW79Zg9MJNPQvNSL
 DU2UQt6nYx6rxQ9qZjMvndNrhWF6fAjWiCdPpWNVgVS8EF69gkLCUkkest82i3CQwjkJLakLT
 Ysa4otMNUAK/wBEPXtyvJlBtwHxZi5ZU3RsQiA9tukdDhukedmjbcP6dQKCGhPEC0KcDRkhlh
 O+FkBZ1BWNg4PPJlD/zI2FYqPtqmDl2X1U2H2wWDzUc4N72WYEU25k5Ocn5aKOybDVSFdDTrc
 9JDZ8AtfiD6BDbu8Adg9PJxk61OgrFmM0wSoV6Gc3H0y/wTGS1EhS9uhxwoWWwohMRxEKbHiO
 3kn0SGGz5Y3FhU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VgPshRbJHuXnbYX7MKKZYNeLAmiLiM9V4
Content-Type: multipart/mixed; boundary="wwQ2CWrKxcLZIwqZuBfltPv1EmBU2pD10";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <052a23bb-428d-3249-d8cb-b508ebca0b62@gmx.com>
Subject: Re: [PATCH] btrfs: Allow more disks missing for RAID10
References: <20190718062749.11276-1-wqu@suse.com>
 <20190725183741.GX2868@twin.jikos.cz>
 <a835760e-be9d-cfd9-d8c3-c316f34ec20f@gmx.com>
 <20190726103902.GZ2868@twin.jikos.cz>
In-Reply-To: <20190726103902.GZ2868@twin.jikos.cz>

--wwQ2CWrKxcLZIwqZuBfltPv1EmBU2pD10
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/26 =E4=B8=8B=E5=8D=886:39, David Sterba wrote:
> On Fri, Jul 26, 2019 at 07:41:41AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2019/7/26 =E4=B8=8A=E5=8D=882:37, David Sterba wrote:
>>> On Thu, Jul 18, 2019 at 02:27:49PM +0800, Qu Wenruo wrote:
>>>> RAID10 can accept as much as half of its disks to be missing, as lon=
g as
>>>> each sub stripe still has a good mirror.
>>>
>>> Can you please make a test case for that?
>>
>> Fstests one or btrfs-progs one?
>=20
> For fstests.

OK, that test case in fact exposed a long-existing bug, we can't create
degraded chunks.

So if we're replacing the missing devices on a 4 disk RAID10 btrfs, we
will hit ENOSPC as we can't find 4 devices to fulfill a new chunk.
And it will finally trigger transaction abort.

Please discard this patch until we solve that problem.

Thanks,
Qu

>=20
>>> I think the number of devices that can be lost can be higher than a h=
alf
>>> in some extreme cases: one device has copies of all stripes, 2nd copy=

>>> can be scattered randomly on the other devices, but that's highly
>>> unlikely to happen.
>>>
>>> On average it's same as raid1, but the more exact check can potential=
ly
>>> utilize the stripe layout.
>>>
>> That will be at extent level, to me it's an internal level violation,
>> far from what we want to improve.
>=20
> Ah I don't mean to go the extent level, as you implemented it is enough=

> and an improvement.
>=20


--wwQ2CWrKxcLZIwqZuBfltPv1EmBU2pD10--

--VgPshRbJHuXnbYX7MKKZYNeLAmiLiM9V4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1BO/oACgkQwj2R86El
/qh0ewf+PvEkF1yN7s0PSzpFeaLnUDY5DsfDseO1gWOzOlK6a9TSh538DMXyLkoe
pJFlh8fRP5naViF86PfSXJNHu/x3uCkj1BHz2gBEVp3QrPBheMk8LDyGCVrv/bg0
ZCkbtuBPhjEFx+FOU/ONQfuxovmbLQTcinzAz92MbjTLxxiP82uF2DLT4WkjUUuX
Scr2kcliBIbkWVxQaBETFH9EpehZe5TznVznukMMsBWfSNh5bdkhozN5UvPpEJPT
wIi6qmr2Gf/A7bARuUlCH3aVNiEzfUISsdFBtOVq+7J6wffeWbrb86vMUs1UxaQ1
7e3XgwgqvrO5PjLWxSHP+kMgvAGvrw==
=di48
-----END PGP SIGNATURE-----

--VgPshRbJHuXnbYX7MKKZYNeLAmiLiM9V4--
