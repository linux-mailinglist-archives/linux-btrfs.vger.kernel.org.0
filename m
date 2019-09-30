Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7E9C1FA2
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 12:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfI3K5z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 06:57:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:60265 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfI3K5z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 06:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569841073;
        bh=nfj0J0uRbpdGelH84blgdpkSB4rrFQNrcvubQer7VFk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XUfNC5lZO5wXmSGb4IzvS7e6jOD4GyyHqOZzjO+SFuuDXukPstw+znpv2mHSDEJww
         lEaeyYJZcjxWoShZRg2G9Q4+/L1wUm7tIOn80Frcf5adOyFlOeyXemct8XzORLPjmw
         0CJyeeSvi1qQd+HIYzMgGGSVibO56JfMkbIyf5S4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWAOW-1idZv83MTq-00XZgu; Mon, 30
 Sep 2019 12:57:53 +0200
Subject: Re: Btrfs partition mount error
To:     Andrey Ivanov <andrey-ivanov-ml@yandex.ru>,
        linux-btrfs@vger.kernel.org
References: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
 <85cb7aff-5fa4-c7f7-c277-04069954d7fe@gmx.com>
 <170d6f2f-65aa-3437-be21-61ac8499460b@yandex.ru>
 <4be73e38-c8b1-8220-1e5a-c0a1287df61d@gmx.com>
 <31560d49-0d03-1e26-bb55-755a4365dce7@yandex.ru>
 <70eaf85f-751a-f540-7fde-bb489a0bb528@gmx.com>
 <e5383397-3556-1c9c-7483-79ad6d74de49@yandex.ru>
 <c9d71bdd-7fe2-faaf-23c0-ede163c1d04a@gmx.com>
 <c3ecfeb9-2900-3406-4d92-e40021753310@yandex.ru>
 <1ca0434b-3ae6-bbbe-efd3-06cab9089782@gmx.com>
 <fb259ee2-c9e2-f44d-ce5b-b3f688565c28@yandex.ru>
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
Message-ID: <bf5265b7-96a1-5f98-07f8-947b981ac364@gmx.com>
Date:   Mon, 30 Sep 2019 18:57:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <fb259ee2-c9e2-f44d-ce5b-b3f688565c28@yandex.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j6uSyM4JdsJzTugxuMQYQuEXc2eC16cHB"
X-Provags-ID: V03:K1:UnapwYDOJajfigHljFFs50dpLb9GZwVAJeQniK6ygqRiTeqLvit
 R1yzSZ1q05QzMlwBXUSnwcZUz4ZsoQF5rfXl13/5LWWG7bcDPT09DyQNMPCuypj4Xrtgq/u
 rXNQfcSFCdDQZ1SBPh9ManHUIJQRef6LRVatDz4Seczch4cbNmc7ACJ8DeszZ31/EltJX6f
 IoXP9LlpoqBP1IX+w8gSw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AnO9MZmf7fo=:fmAy6YzmdMTE8usliHn2cD
 +YHicPbAHJkiH8BP9TGIXJ/7WEl/z6PvWTadcGjSw1UKY3qLxILhZzw0ZLGaG+FvbOMGkQVSS
 GJaLJms7V/C+8ulnRXZb2P0qB+MHOKzXPgJGEpNyJt9Bj4/JOUXFg2Ctbb85v+QDSMKkKxfkt
 5JA2K/dX25bwUtojOF0mh8PgDbbR976R7WDVRHyJGaDhdhsjDdE7vAQ3zX66Ap4HqpzQDrFuc
 A0w89/T5i36daWx0VuCL25eAyVhWppa1d8hRp6UioKFwf9LBmoLPdvZc82IUmxmwq/lCMGrEm
 WPfLOGLPH9WhZimEtzycx98WcyU56rPI7+/OC38MxHjCxmRgT8yIB5LRtRaobShHWhQn2q2pA
 bzuE4r2u0hIg5Yit1UTPz1OAHXOJK3PJuVlCtZDwLE/SnuJFe0SgWxYG1hIuyxltsxkyfWQ3Q
 tR6Z6jbfoUsfd7olUKIqmgdWpXmBdaYGVbEOIY9/AjXoXLKN23e2xOjp9gMca4fL7SlR/Dg4n
 sT3KJlUSguQ5RFTlIKH4/ZgmlC8+WNTYvAhCCY+CHREPTTsMOVQkQK3d0rkmRR316O3r5tWO0
 Ii2C8j5Fe2S4D48TLRHvVbx92Ycpkjl+qYZ5M32et8HtH+K5KL4L/LJqXVY1+JbVJFC2B8jO7
 2AxOAGD3sWJ/jfWeWvE3fa5oI2WFpzf3xHHbQZjPSobThNP5b4U6bLGlUcvMFrWxoWTpS6yP1
 8A4GWSXeSsNhXtADf51yzSncBn2ZElxxy+1rGhjRAKuE6PWHoIiJ/q6lCSfrA8pfKdGBcBeNB
 G9j+zu4O/c1BhbztM8O6hdubG9Iciw1yyZIv7/N/B/SCeIfiOm1fjxpEQEo1stCdEHOq4S6ac
 HjmRoKsgXlKOHGR3RXB53fcNPzdULgJ6yIQ6WnyyomSjFJbxXWKWu9Hc4wC/VPUYWV6ZiCZhq
 LU/70K/EWpV9Lbf7/1ko0nMGeBJKgjiP5ySNNhau8BNcp9YITHM0D/q0S2Z+V8wTE1LApKxem
 zwc3mbGEZskqT4pFS1pTl4O+asKSAsI2V963EAbvlYhB1HYpVpP8aj58acqUYBcbewOCN7SCr
 7JkHKsrAA73ObZqEEe6q4uHwZ413VsLZ9KVeOZmQTEPyByAL/2UOkdjNYu0HGciwmZAVhcC8w
 z+WyAtktziD+HoMey5oV5K+N7PZv/gdJ6aROsYVL5WXhXxXwnpDHyTbgip6ZEfWOhfJX14Uo7
 61MEB0Z5F425PHBWoXopkhdyqOJQmhIDrbXQxGf4uNu2dfUo9NzIkTIeF04c=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j6uSyM4JdsJzTugxuMQYQuEXc2eC16cHB
Content-Type: multipart/mixed; boundary="pKQkI81CFA210DjgYVF7uqZrAMBD2HyOX"

--pKQkI81CFA210DjgYVF7uqZrAMBD2HyOX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/30 =E4=B8=8B=E5=8D=886:23, Andrey Ivanov wrote:
> On 30.09.2019 13:10, Qu Wenruo wrote:
>>> I had built and run it:
>>>
>>> # /home/andrey/devel/src/btrfs/btrfs-progs-dirty_fix/btrfs-corrupt-bl=
ock
>>> -X /dev/sdc1
>>> incorrect offsets 15223 15287
>>> Open ctree failed
>>
>> That branch updated to skip the item offset check completely.
>>
>> But please keep in mind that, that check itself still makes sense, so
>> please use the original "btrfs check" to check the fs.
>=20
> # /home/andrey/devel/src/btrfs/btrfs-progs-dirty_fix/btrfs-corrupt-bloc=
k
> -X /dev/sdc1
> key (613019873280 EXTENT_ITEM 1048576)slot end outside of leaf
> 1073755934 > 16283
> Open ctree failed

This means there are more corruptions in just that one leaf.

It's really hard to fix them one by one manually.

I'd recommend to go btrfs-restore or use this patchset:
https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D170715

Then mount with ro,rescue=3Dskipbg.

Either way, the bitflip is way beyond my imagination.

Thanks,
Qu

>=20
> # btrfs check /dev/sdc1
> Opening filesystem to check...
> incorrect offsets 15223 15287
> ERROR: cannot open file system


--pKQkI81CFA210DjgYVF7uqZrAMBD2HyOX--

--j6uSyM4JdsJzTugxuMQYQuEXc2eC16cHB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2R360ACgkQwj2R86El
/qgW0gf/XDkQsOWmkNUJiVpWmgoy8KX2l1hfdRE7jOznXyjHAorLg+2VZ7tbg3k1
aSwgrgyQxE5FBS041wt33byyCT+PhsBRJfTA/O7Az3XtwZRpNT64Io7LvchE3yA2
1/Z4vRa+nDQen3oApYwd5nNUkPkrPOIq8CJ4rUIXserASi3ihuuOf5tv0QpXSLYZ
3TDC4jdc9MQDOSTfqEWP2LKTOooX1iHRnO53xf6xTYB/CN8YslW7URzeuQShWUOl
pizzujotMOUndeMXaun6g8FlcXqVa3ULrj8NhkamfWjOWFOymd4fpQyetmQDqCwx
SjoK0FnJ8VLBXBVsU0GmSVfbEaIjvw==
=G0fk
-----END PGP SIGNATURE-----

--j6uSyM4JdsJzTugxuMQYQuEXc2eC16cHB--
