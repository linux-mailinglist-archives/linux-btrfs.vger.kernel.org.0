Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F3AA7C1E
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 08:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfIDG5a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 02:57:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:58947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfIDG5a (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Sep 2019 02:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567580246;
        bh=6OhOchEqANoVBf26rJD2yHhM/4jvMdxvyBcDnEFpf/M=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=g41Bpa/UUCzP0sjFkjF8eWJUH5SB2UsCmMsgkEDsRWhSczDLqXv20NwTyMTCqY3Hi
         K00FcIfROIRKS/CAKi+Gt26J5OnkLeLSWHlrRT1t2RrTr53Yvxu0nFvRahtQs0y21E
         61Nw8G8bsdJQbY29Welp7AH5HDgdcaSzJNL8uUvw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MN748-1i7dDY128e-006dMT; Wed, 04
 Sep 2019 08:57:26 +0200
Subject: Re: btrfs and checksum
To:     Jorge Fernandez Monteagudo <jorgefm@cirsa.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <AM6PR10MB3399AD2694BEC12D6C262309A1B80@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
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
Message-ID: <65c7e396-f1bf-0a71-d5d4-fb10cc7187a9@gmx.com>
Date:   Wed, 4 Sep 2019 14:57:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <AM6PR10MB3399AD2694BEC12D6C262309A1B80@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Lma5YYBHIJh7xo1Q2EXJrNJKpQjvZmIDf"
X-Provags-ID: V03:K1:MFVu329Vqoup7hHoTzDHtokzB1+3Hxtln+m4/nHih0LD2juTkDS
 0Op6NWO4NCQv58TdfpGOkjUtU3taGMFTj8Abgq9xX3dwKJinhkGrn32FNlCNXVkZKnMLoHu
 Q6HPE4KmIRmWRj+azd9DKAv3Y45ODDzWgVssuZOqKfHiBqnV64utTnoOHZhuURBZkK4Nv+u
 LfOs8rEbjFoDoO+Zb80DQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BiecvE87sHM=:xg9HwECInzZGa6Bej8llPQ
 L/wxWA9ODwukW6qUKuR2JDJoRYHQqtk6WRuLGfdZeqU4rXucqSJczs2S10GlPJeHxCJ8LKzyj
 Mxr5ND0OS/ju2wi97pLj9K+q7MuYnzbmNvVf9Vv6SSqtNXQL75xqXCzVipPXRO8Kjcg4tyt7k
 YR5FTxAdL8+AzCemUAM9QU8G5/FqEMzSsKlW4E9VpeIre+itacUc/wc9afoSzqE2/qVnM8t3x
 jWaRMtRCj2MZMEaYwUdkpTFPIEcw7PvbmEMX4JSsEKtttSbM+vTWyNvz3xSJXu7HU1CspLI2l
 F4Sg/qwgHFtlVmU88DgyVItQSu5OQosXX+LYGUBJ1/XExUuKeoyupjEpnceqpIqDe75OXbD5R
 iQ9FwvrBtV94Vkfoet8U8MAMTdpPk0YoogJpyf64BDJ56bXDV8LBpA3kYpjhOWIK9OKTYy0zT
 /c89e65cipEIskz1Wcuw5BJY6uBP9Nug8DFJzQ8zVSE7zLj5fl7gYhgmkAsL5l/eqgyk3cCXD
 T+1sn/3Ib7zPacGXgijzQGDCbXtYZvz6tZEmfKLakRcBPjjdUAxhrdN3IZOnkhVjxhD22sVsE
 rh3nGscG7GwU7KHpzSeWE9w0BMHfdhjeQg47r7owH8zE4uiw8XK6zVZ3iDVVlXd3JyIljW0H9
 noH4cRrqtxe4FYHKPNYzbH0B4tWnz5rx9RQdOIKTeLakKLtiEVFzKr9Pd0RL9kVTM5MMS3ot2
 Ccp2Kc6eWVtVlVm7HLU1bAanD4gIYk2PA95XbBI2b8VbfmKQF5amCHB8wFCwCpNb+leaIIwMC
 kn2vj6vkCktKeOiB2o41mrPpDtaMnU/lz8vJJ+1TEtjHF8mfDBQE5nKpHN9TGCA2AMHwcos0T
 bVnkfdyBl+kPfQbQFevCPY94gdi7X3I7VlRZ1j0mg9NcZvQWujvQ/pcNNFKViVxCEO47SzuFj
 I6bDUZny/YiSKLH04wRCM+BcX/V+rV0g+5FspgWmxtZnKvQT86TwwkfnI/EwD6iRxrTKK3yQQ
 h1sWgLVbHtOTl/Kp5Ws8I1htrTWzmkO1erH7sdo1POLbNcsBkPHknuT/whpClpoGqBcUUQV6x
 7VdEPeWXLvAhT53xNcQyhPaCfmrMg/Wdgly1Vg4hvJPeZXZgf9uMjM3cuicdEn0439R5IGUYi
 vlaGbuAFyxdZrEd+5KHgbmgpvTmzzhV3gt0SZRidfiSOwl1A==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lma5YYBHIJh7xo1Q2EXJrNJKpQjvZmIDf
Content-Type: multipart/mixed; boundary="qHZijFjaCdKJTjvZzU1LC8KiEV4dkZmvI";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <65c7e396-f1bf-0a71-d5d4-fb10cc7187a9@gmx.com>
Subject: Re: btrfs and checksum
References: <AM6PR10MB3399AD2694BEC12D6C262309A1B80@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM6PR10MB3399AD2694BEC12D6C262309A1B80@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>

--qHZijFjaCdKJTjvZzU1LC8KiEV4dkZmvI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/4 =E4=B8=8B=E5=8D=882:08, Jorge Fernandez Monteagudo wrote:
> Hi Qu, thanks for answering!
>=20
>> RO of the ext4, and still get corruption? Definitely looks like a
>> hardware problem to me.
>=20
> It's a weird error, because rebooting the machine the previous error di=
sapears and the file could be read ok, then we know that the info in disk=
 is ok. Then, the suspects list grows up: disk, RAM memory, kernel error =
(block layer?, filesystem layer?).... It's not a frequent bug so it's dif=
ficult to debug it.

I'd say, other than trying migrating to btrfs, it's better to locate the
problem.

Without a concrete cause, migrating to btrfs may also have some weird
behavior.

Thanks,
Qu

>=20
>=20
>> For btrfs, as long as you're using data csum (default), btrfs can dete=
ct
>> such corruption.
>>
>> For v5.2 kernel, btrfs can even detects some easy to expose memory
>> corruption.
>>
>> But please keep in mind that, due to the fact btrfs (at least least
>> version) is very picky about corrupted on-disk data or memory, if you
>> find something wrong, you need to check dmesg to see what's going wron=
g.
>>
>> Furthermore, if your ssd is not reliable, especially when it lies abou=
t
>> FLUSH/FUA, btrfs can be easier to be corrupted, as btrfs completely
>> relies on FLUSH/FUA and metadata COW to ensure its safety against
>> powerloss, it's way easier to get corrupted if FLUSH/FUA is not
>> implemented corrected.
>>
>> (On the other hand, btrfs is more robust against data corruption, so a=
s
>> long as your SSD is OK, you may find a better experience using btrfs)
>=20
> Then, it's advised to change the ext4 to btrfs or it's better to change=
 the ISO packages filesytem to btrfs?


>=20
> Thanks!
> Jorge
>=20


--qHZijFjaCdKJTjvZzU1LC8KiEV4dkZmvI--

--Lma5YYBHIJh7xo1Q2EXJrNJKpQjvZmIDf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1vYE8ACgkQwj2R86El
/qj0TQf/QJYkpEBXzw6xD248WiwUBCsgKLxWO9DeWCwE5e6ZdQz9OswEaBuX8aCv
xjk2Oc9yUoKWd8Nsz7w8aq2MPCXFrnt3vhYrnKkyEEumZeyPZYy3A/+AQ/yuG7al
k+X+tPaYmjJSX6n1oG4rzM4SMO/3+VDl1K9vMnhCPSAOQAJxUx9sPDhZgUTAxSXL
zmu8AtqBYopSq30jYmVRhd7xnGoPAUYt8xmXXCiBI5nkbi/2tXAFEyh0gm3tAQaG
Fp6TUOf6r3oiPped/1HvVsRXKQAkaM5tvpLSZg13IaueKnVggmrsF5lxy1CY2caL
zsM5e+euFku5Au2y+KNaDh1BhQbwhA==
=Amrq
-----END PGP SIGNATURE-----

--Lma5YYBHIJh7xo1Q2EXJrNJKpQjvZmIDf--
