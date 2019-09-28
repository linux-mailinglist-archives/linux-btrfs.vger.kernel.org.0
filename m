Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C61C4C1276
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Sep 2019 01:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfI1Xh3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Sep 2019 19:37:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:37497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728666AbfI1Xh2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Sep 2019 19:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569713844;
        bh=umzh0R8RoZZLQ+/zFxw412eJbUCDCSL1qB9b9O2yLz8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=dBVehGuL6pNpoUnLg5R0zi2HomTspkSiCBeYgFDeXkBWthoAcNkN4HdGERLEkblRK
         KpF9Azdf69RMQpGLi0nf6wZkvPLG/5N72cStiyL2TNgsv7mkX4oCpmi90ux2SAtz9Q
         cDY3ayFt2DEEoVDcNO8gJ2aSOWOHJcEYv4LM6xME=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCsU6-1iN7hb1C88-008u46; Sun, 29
 Sep 2019 01:37:23 +0200
Subject: Re: while (1) in btrfs_relocate_block_group didn't end
To:     Cebtenzzre <cebtenzzre@gmail.com>, linux-btrfs@vger.kernel.org
References: <ef805fda2976d3b89b80204f8d119a9342176bae.camel@gmail.com>
 <6476e5f02a4bdf26c8f342db11f6dc1675c94394.camel@gmail.com>
 <d19eb085373417fb13f5ec3c634224ecefa9dca2.camel@gmail.com>
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
Message-ID: <0b9207ba-384e-d51c-cce0-832d85964fa9@gmx.com>
Date:   Sun, 29 Sep 2019 07:37:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <d19eb085373417fb13f5ec3c634224ecefa9dca2.camel@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UIsLXdGCliFO0Bki4MLOZhwU3I32Atq74"
X-Provags-ID: V03:K1:08hhrLT+meRf66Ov6BAdDiF6B0bCziSgriJdW3q/J8thDIcOoWY
 y1N2QdIb9AE53HA3+dWiQd+uLac7nrLgPUF3H+EuWVc1RRKEupa+1GBQ/vKFCyTb7ngYAJD
 TJgJarX5duz4KUQF/Rkmucp31UUzH+I6ta/62xNFF0BiosjoRIdi99pAdqPpTlUp9TGYqb/
 5OIm1Rs0BAx5Jj0Ooi53w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:W113+MhDOZk=:RqIVHLfHGZfF7G/gjsgGa/
 LCetQ9LdCRzX0pjqXQfaI32OkyPrv3KU6G6o8oU6SebxRN4MQXpXODD7xoz13mZZ+x4j40gAx
 uc3ZWiBP4i9g7dGCzToUBJWix9MmKg1iGEpjdYh6NTRnM1sg4STnzSQOaj5SAU7Du+GyyVVH0
 toFyYtltUyoF6WTkaO6z/mZemQ/OnUL4gnC6tU1FSnRMgkenXtH9iwFDbCtC7/cZR4LUi9QL8
 My4U6npUnivSOILpotMQYtz4kpsnEE/gfo5n0MiRur9fXGzld2Tv8hn2KrfI32XJaKn9WaD00
 kntPywN0+excH273T0jxF2AYmH1YuxhwUqd+39DwZZIwEH7thALhnRXMi9kCm7/uCbkFDg2Zf
 okvPZTl6aVtN7zRiUu3cXqzjPgB8R+FaIyozmzToiDL3N7kIiqd+Vlft6qnEan20Em5H16p+D
 R6TnEPwyq42y+MLxE0plV/43JPVMiZElWrheFJq6uxgimeN2Ha0/zD+gW38iv7mv8mbjKHd1f
 LL67SxRpEYtzHBtFdyX1wESCAboTQPClocPiV2OApkfWwbBkJ1tBxL1x4c9QBcdA0m7fHyjLP
 PafyXLI9tJ7K30zAt7HvtzHqg5TlK3R+ZqCd2rMCL1VhQMaCeWoVtrcwmFuISm3n/qf3LdWZk
 q/8tCkrtCibuscc0OXgRL9iR9ujscoTbsMZDPdCehNYMSS2MdAB0M3EHqNkvjko5+DydcTDbO
 BKhBdJp3iNmm8m8vm472TOEmdaM0nFdHdKH4jo3wSOMu4CG+7sU3AO7zLFhf/3wy/1kQX9VGs
 lwts7UmGRbD1zijXv7FFmpW0Yx6KTeqa0EN6fdVTS438118iF5BnJHjMChwQTc4OE2p+hqKpI
 /5Q12w7HWxo1zGcllJNVjd7fiKgjTLC+4iBi+aawbiXWUo3+tseQQ2Om61aEQEi8+kxpFHxqG
 rFnwHiCW/myq32l6rMF7T0Q9QW2QMjqhigdab3mB/7aESmBkS1OO02hV2zD2bOPysTHOpAGhS
 /Fr1Vo2cTqX7hffAMJIKj3oMISYYAwx11GmViKRoAVSZUYPQ+KW3LU++d0hNuEfPxDk84FLxQ
 tsHITRbUum8oQRPFYR5Q1sg5YoPmsTebTvkmWCepJJztWoWCm08NF959FUX+02muXaS7iWCod
 WQAEwZcgUQ3KGXDueXu6AcTQN52Kd578ph6ugOxvEvxxURb5v1I/EOnWIazkXmB5bC4VhAG5O
 IUwyAPe55Ah5CKb3iSRCETAp0RTTUGXc5jqf+2IvC8pTnX+/OXWzW+Nz89AM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UIsLXdGCliFO0Bki4MLOZhwU3I32Atq74
Content-Type: multipart/mixed; boundary="dW133Sqj9MKmK0NufKr0PmLdBoCpQs98F"

--dW133Sqj9MKmK0NufKr0PmLdBoCpQs98F
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/29 =E4=B8=8A=E5=8D=882:36, Cebtenzzre wrote:
> On Mon, 2019-09-16 at 17:20 -0400, Cebtenzzre wrote:
>> On Sat, 2019-09-14 at 17:36 -0400, Cebtenzzre wrote:
>>> Hi,
>>>
>>> I started a balance of one block group, and I saw this in dmesg:
>>>
>>> BTRFS info (device sdi1): balance: start -dvrange=3D2236714319872..22=
36714319873
>>> BTRFS info (device sdi1): relocating block group 2236714319872 flags =
data|raid0
>>> BTRFS info (device sdi1): found 1 extents
>>> BTRFS info (device sdi1): found 1 extents
>>> BTRFS info (device sdi1): found 1 extents
>>> BTRFS info (device sdi1): found 1 extents
>>> BTRFS info (device sdi1): found 1 extents
>>>
>>> [...]
>>>
>>> I am using Arch Linux with kernel version 5.2.14-arch2, and I specifi=
ed
>>> "slub_debug=3DP,kmalloc-2k" in the kernel cmdline to detect and prote=
ct
>>> against a use-after-free that I found when I had KASAN enabled. Would=

>>> that kernel parameter result in a silent retry if it hit the use-afte=
r-
>>> free?
>>
>> Please disregard the quoted message. This behavior does appear to be a=

>> result of using the slub_debug option instead of KASAN. It is not
>> directly caused by BTRFS.
>=20
> Actually, I just reproduced this behavior without slub_debug in the
> cmdline, on Linux 5.3.0 with "[PATCH] btrfs: relocation: Fix KASAN
> report about use-after-free due to dead reloc tree cleanup race" (
> https://patchwork.kernel.org/patch/11153729/) applied.
>=20
> So, this issue is still relevant and possible to trigger, though under
> different conditions (different volume, kernel version, and cmdline).
>=20

That patch is not to solve the while loop problem, so we still need some
extra info for this problem.

Is the problem always reproducible on that fs or still with some randomne=
ss?

And, can you still reproduce it with v5.1/v5.2?

Thanks,
Qu


--dW133Sqj9MKmK0NufKr0PmLdBoCpQs98F--

--UIsLXdGCliFO0Bki4MLOZhwU3I32Atq74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2P7q8ACgkQwj2R86El
/qjaWQgAgcBQ1KTIkaTRs1eoPnVa5FqnAe7m274dEou1iNrsztirMtSWu+R+WIhy
lOCdBj38kAS9BpNH8aIhbjXya00HS4YV1m00mKguFJ6Ogeu4IKO2j5V6jJh6dv5F
S8XzrJQfnQcpD2jyYbk/s9xKeJe7GdhJIVFqmqjQO//uSfO4sSvppFtQTJRXXkNq
1qZvPPtZiIUPYS0AQy7uDXy3J+Gzc+tXHiTv7FesGNJbe8mqvUSGH+pkS4hT6WC8
04Fdqv7CXDDV2PhrSYoFBX4j1x5SGjb7hF+3bEsh4a04N9ct+8Sk3a/22mFyMdvc
hfEs1kA8vAWtSynuyz9tgy698labbg==
=9n8s
-----END PGP SIGNATURE-----

--UIsLXdGCliFO0Bki4MLOZhwU3I32Atq74--
