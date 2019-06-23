Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C46E24FB47
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2019 13:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfFWL3o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jun 2019 07:29:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:60633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbfFWL3o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jun 2019 07:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561289382;
        bh=jlt+gCyCxzRcH12Q2hGrOUW6+OlKch8oWKW0OE38wKc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZtCL8fW95Ewn7VaoytuWHgWeqkFJCG7JGYjg0jWRLUlI9+b4Jz3iQ59ajuQNg5c6a
         ysE77cqKLnG9xpvRMwfjlwXK8aBszribXJ999buDdpf3HZiU6m7TM6vySBGyaLka4e
         aql56mCq5XIs9D9KcMK8/u3TbXyL1WVN4wy1xGlw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MMShK-1hfaWZ0n5a-008GbM; Sun, 23
 Jun 2019 13:29:42 +0200
Subject: Re: Confused by btrfs quota group accounting
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <eeb418d8-13a1-39c3-c6d1-dd5a2127abc9@gmail.com>
 <669a0428-0517-a10e-c658-c8137463450a@gmx.com>
 <cec540b7-f1c1-93f2-adb0-5f0155215e73@gmx.com>
 <7ecc3db3-7af7-f3cb-e23f-04c20f47dd8c@gmail.com>
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
Message-ID: <2c0e3d7e-9b7d-dde8-c4f3-2ca89071efbf@gmx.com>
Date:   Sun, 23 Jun 2019 19:29:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <7ecc3db3-7af7-f3cb-e23f-04c20f47dd8c@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CZhlcLlo9B9YdBUZV4SUntyPzw1mYhnLj"
X-Provags-ID: V03:K1:t81c97CHzzfGJqvFFh8jhVI6uJo86pV1lH3iJ7JqOuMfEwHovs+
 WUOoHLVl05FNszE7K/GDOtXKBwH0Fch+f3MLXosRICSNpSMqyF1YSQ+uEA4SScWtGmHcAoM
 v7dJzkPjUs5adP+ZrLFODqdGNUcjs3QkIo0Dc9Urx/+5Gorh0JqF9UyVwL5fNweBTB04EUK
 JzOsTYZS1Z1llYzPN1PBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nar6f/aDoJ4=:Oq6Qv9vVkoxRrjCSj9EJjp
 QCbyygsH+LzlnjD7xbZYydB39Q+VS8s0VqE8l6+LlUSSecDzLHFJ6feV19rYTx8brTh+BnQoq
 GgSBl/uXBm+p8d91aEkB86pbkPiuXbugnGPWWFzoZvyvl04mt7Wcxxf7s77DJM/rDRtgBk0i1
 fLlIF0NL5LddTC9JXueRdABcV3H2UYVQfCO7oGl+yJq6Sn8BxgNsmFhnda1v8Qxxak0nkfBon
 9pcB6fRrDkpYKgH6a9vVOMetoxMpWh6wIACONsJQFwaIgLGBQJ7IFvpVA68Tylo/I7hpsgtnY
 hckaWDI1QxZoDADduVGkB9oEx3cuPYsaufXOt/QRd8X6vAkBhmahczk6skqW2QsNnYp9sdiuK
 wXZAV+/Wk4lvmoTCfM+IF+Jg29tdeeGXjLgiG6QCMYVoUFWb3BgR4oMtSjBJKvYuJPcDgUSDt
 twW7NKPGRPjTEDM7YpeshXVsLtJWjIXeO3+GncvjRlORBOEPsvYW9BfEmObPe7jbVeJMG/9iO
 GGy6NJt/Ae0x/lgJaKE8R22tVeWTTogtuciYJo/jEL5k3Gpq3A/P90M9a1PGXpaGJQ2+8kAz8
 HLDbsTb7nucKrJtPYaPEGUbe3UVdS7oVwt+SJYyjGdGzlKGuXkfYNv7/rtMTSCztLxTIa5mlD
 oP9fzu5tlYXtkwp+/RGa+ad0KnbXDd+/+fSsVT9agDCRH9n6uAP800Gi0hcDaXqjT4vN/jne1
 ICDdfjaHlA5o4fjqSc5F8TlSY6yh7ZHuHejvTyiN/Ylvxl2Pw6qpZ8RdblOjpZMhhM3E+F/d6
 Z8VmzYfiRc7QFUSU2J5iyCARrLIKJDU6oOghpZFiIh0lnBxue5psHI2pNpMZIuBIAZRIBLPe+
 aHlNjftUIiocE2TaSqJwZbDIpyiKXVEGLPIaD9/Ld+AjIMW5FE35UE0HmlGMBV4LZupf4aVWb
 XerovDUkv4YgOOzEcQlNkNnKWDXA7XHM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CZhlcLlo9B9YdBUZV4SUntyPzw1mYhnLj
Content-Type: multipart/mixed; boundary="XtcxW3vaURCIDTS9THXMLf9v4hDi0u6J0";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Andrei Borzenkov <arvidjaar@gmail.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <2c0e3d7e-9b7d-dde8-c4f3-2ca89071efbf@gmx.com>
Subject: Re: Confused by btrfs quota group accounting
References: <eeb418d8-13a1-39c3-c6d1-dd5a2127abc9@gmail.com>
 <669a0428-0517-a10e-c658-c8137463450a@gmx.com>
 <cec540b7-f1c1-93f2-adb0-5f0155215e73@gmx.com>
 <7ecc3db3-7af7-f3cb-e23f-04c20f47dd8c@gmail.com>
In-Reply-To: <7ecc3db3-7af7-f3cb-e23f-04c20f47dd8c@gmail.com>

--XtcxW3vaURCIDTS9THXMLf9v4hDi0u6J0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/23 =E4=B8=8B=E5=8D=886:15, Andrei Borzenkov wrote:
[snip]
>> If the last command reports qgroup mismatch, then it means qgroup is
>> indeed incorrect.
>>
>=20
> no error reported.

Then it's not a bug, and should be caused by btrfs extent booking behavio=
r.

> 10:/home/bor # btrfs ins dump-tree -t 258 /dev/vdb
> btrfs-progs v5.1
> file tree key (258 ROOT_ITEM 0)
> 	item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
> 		index 2 namelen 4 name: file

The inode we care about.

> 	item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
> 		generation 11 type 1 (regular)
> 		extent data disk byte 1291976704 nr 46137344
> 		extent data offset 0 nr 46137344 ram 46137344

44 MiB extent, this should be exclusive for the subvol 258.

> 	item 7 key (257 EXTENT_DATA 46137344) itemoff 15763 itemsize 53
> 		generation 11 type 1 (regular)
> 		extent data disk byte 1338114048 nr 45875200
> 		extent data offset 0 nr 45875200 ram 45875200

Another 43.75 Mib extent, also exclusive for 258.

> 	item 8 key (257 EXTENT_DATA 92012544) itemoff 15710 itemsize 53
> 		generation 11 type 1 (regular)
> 		extent data disk byte 314966016 nr 262144
> 		extent data offset 0 nr 262144 ram 262144

Another 0.25MiB extent. Also exclusive.

> 	item 9 key (257 EXTENT_DATA 92274688) itemoff 15657 itemsize 53
> 		generation 11 type 1 (regular)
> 		extent data disk byte 315228160 nr 12582912
> 		extent data offset 0 nr 12582912 ram 12582912

Another 12.0 MiB extent, also exclusive.


BTW, so many fragmented extents, this normally means your system has
very high memory pressure or lack of memory, or lack of on-disk space.
Above 100MiB should be in one large extent, not split into so many small
ones.

So 258 have 100 MiB extents exclusive. No problem so far.

> 	item 10 key (257 EXTENT_DATA 104857600) itemoff 15604 itemsize 53
> 		generation 9 type 1 (regular)
> 		extent data disk byte 227016704 nr 43515904
> 		extent data offset 15728640 nr 27787264 ram 43515904

=46rom this extents on, data extent at 227016704 (len 41.5M) are all
shared with another extent.

You can just search the bytenr 227016704, which also shows up in subvol 2=
65.

[snip]

> file tree key (263 ROOT_ITEM 10)
> 	item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
> 		index 2 namelen 4 name: file

Starts from here, that's the inode we care.

> 	item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
> 		generation 9 type 1 (regular)
> 		extent data disk byte 137887744 nr 43778048
> 		extent data offset 0 nr 43778048 ram 43778048

Exclusive, 41.75 MiB.

> 	item 7 key (257 EXTENT_DATA 43778048) itemoff 15763 itemsize 53
> 		generation 9 type 1 (regular)
> 		extent data disk byte 181665792 nr 1310720
> 		extent data offset 0 nr 1310720 ram 1310720

Exclusive 1.25MiB.

> 	item 8 key (257 EXTENT_DATA 45088768) itemoff 15710 itemsize 53
> 		generation 9 type 1 (regular)
> 		extent data disk byte 182976512 nr 43778048
> 		extent data offset 0 nr 43778048 ram 43778048

Exclusive, 41.76 NiB.

> 	item 9 key (257 EXTENT_DATA 88866816) itemoff 15657 itemsize 53
> 		generation 9 type 1 (regular)
> 		extent data disk byte 226754560 nr 262144
> 		extent data offset 0 nr 262144 ram 262144
> 		extent compression 0 (none)

This data extent get shared between subvol 258 and 263.
The difference is, subvol 258 only shared part of the extent, while 263
are using the full extent.
Btrfs qgroup calculates exclusive based on extents, not bytes, so even
only part of the extent get shared, it's still counted as shared.

So for subvol 263, your exclusive is 41.75 + 1.25 + 41.76 =3D 84.75 MiB.


In short, due to qgroup works at extents level, not bytes level, you'll
find strange behavior.

E.g. For my previous script, if on a system with enough free memory, if
you only writes 100 MiB, which is smaller than data extent size limit
(128MiB), only one subvolume will get 100MiB exclusive while the other
one has no exclusive (except the 16K leaf).

But if you're writing 128MiB, just at the extent size limit, then both
subvolume will have 128MiB exclusive.

Thanks,
Qu


> 	item 10 key (257 EXTENT_DATA 89128960) itemoff 15604 itemsize 53
> 		generation 9 type 1 (regular)
> 		extent data disk byte 227016704 nr 43515904
> 		extent data offset 0 nr 43515904 ram 43515904
> 		extent compression 0 (none)
[snip]

>=20
>> Also, I see your subvolume id is not continuous, did you created/remov=
ed
>> some other subvolumes during your test?
>>
>=20
> No. At least on this filesystem. I have recreated it several times, but=

> since the last mkfs these were the only two subvolumes I created myself=
=2E
>=20


--XtcxW3vaURCIDTS9THXMLf9v4hDi0u6J0--

--CZhlcLlo9B9YdBUZV4SUntyPzw1mYhnLj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0PYqEACgkQwj2R86El
/qhx5gf/Z2yN0EKNLahbS+DO1Hn1CIodxaPP2Ygh1LTZl9cbAAsCMQp3Hx2O/QQe
B5Z3PdQMlUkL10vbY1W2jFpf01JpBcvTN6kdVhUrVMOd+NS8vs/SwWHEvPlfFLXX
JZp/P5iAQlLl2RMO5t2sCdGIqflNYLnfLJtRuf8n0uMfu5uciIXj0ZIbuSBp1JhU
mmj5s61rz6rVOHRQogmyS36c+02AxmNVDR5E3xi2HJzGppVAHFZoi+3l57WXvsJM
190F6446+4kWjL6tpo2jvIceyDPn4HtZ5T5KtXX2rxW0+it9OQZ0oXZc0GEvazeG
7eLmivYyISsmltUvc7yEFX/LyIXt4Q==
=JFoN
-----END PGP SIGNATURE-----

--CZhlcLlo9B9YdBUZV4SUntyPzw1mYhnLj--
