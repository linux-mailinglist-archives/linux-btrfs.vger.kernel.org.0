Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED0EB15245A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 02:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgBEBEI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 20:04:08 -0500
Received: from mout.gmx.net ([212.227.15.19]:56151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbgBEBEI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 20:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580864643;
        bh=kk1L3upxAFrR4J8wCXs7vl5IeAHlWy2hh1dnAlzZ01w=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bEe5z3geXJ1WSUPAILHqQKWKyEUeRNexM1lG9KQ5JUlHaZ36SXqGrYjCgLeffOVJ/
         EYrZWPFQ/iLrkdRllDtSsF5VUOqzbdTrFu0tMKgWhmoQ3yzXd7KoIrBuioCh5aHgIN
         +ifNYArMty8AmPG/ntdQU7qAOpMqqdH85gqkdBlM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1Ycr-1iwgP33IK3-0034hO; Wed, 05
 Feb 2020 02:04:03 +0100
Subject: Re: btrfs balance start -musage=0 / eats drive space
To:     Matt Corallo <linux@bluematt.me>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <526cb529-770c-9279-aad8-7632f07832b8@bluematt.me>
 <CAJCQCtTuKnsQJNKupKbmBxGpkZSqWcYXBD+36v9aT6zZAqmuhg@mail.gmail.com>
 <2353c20b-95c2-2d58-65eb-9d574ff506ee@bluematt.me>
 <615c56b6-4a05-2765-ce34-c6e1992c4c6f@bluematt.me>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <bc23d961-6df3-6bcc-357c-200f68d05f5d@gmx.com>
Date:   Wed, 5 Feb 2020 09:03:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <615c56b6-4a05-2765-ce34-c6e1992c4c6f@bluematt.me>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4S1DBFFWbnjw3x9FvwUWAoVxYAnZMDzH0"
X-Provags-ID: V03:K1:okU+wrKNR5l011m5xWGFzvBsL2GnH0tuPrrhCQpdlA5Fx93DQwG
 WUpePsX/XU54j9J/QNNI3ySyhQlhF5Dg87u6iZzUW3e6mziI/eNMsw/3mTUo4IbStjbK8jn
 B/7nC/N6x/uXLWxLud+C+s+Mf5SVpnEtQcGtq2b/dpmPBB/diofunj6zC3Za+30Woonh2Rm
 8FxQmi44U7WT6pFUc7zew==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UmkrztqfjUY=:/ugGkBudretoS/ZJlNdH2f
 AOOObR1trkSwOZgXUfU6NFMNRXt8HmheQxpktBFs++E9PPj0dkomrC0NLhwtnf0Ts4ZTkQJJR
 mPRMsyIg9loOpEioCeJ1R7F4P9vCCfbLB/N8fiYcV+Y0gR6089TUVCQUpolrvFFqrRF75Jx1y
 sy22r4ZmUptv95ERjboMEjSOwmXshsoQjwAVt7nUMr7aOhjk0VSLR+Q6Q8kzLzwJCjjKz0CzE
 9GazThhWtA99yKxCEaj+Rpfe08iXVYdv/psTg7/Ptld+ixlDYTH0q4lTTXaYX1VDGojJb8soV
 1yqO6UT5glpkY0H/OJ+WDd81le+P7SEe0pAjcsyuLbqcJOjbZ43Q/FUYHguXk61MhwC2SInF0
 pI4VMCAMDqkc6xEafCXIcezuI6kVHcENe5ttvijff0lHUJDlL6gKXVXf9Aq/RlVQhov2Yf8m3
 VWcczy0n52apjjYVltiG5oYERRpaaanKdG43U7qUokhMk93J8N/uo8Ckz21prkn15jAvSlWeV
 Mwznnt4Dv+8Ve8B+SIUR9EY778LmJNA9hMVfiapLewIuCV/udAAzj1es5u0+PMlu3FyG1DP+E
 jZNQkDwaOV/JD9cRIikWz+baCLCrd9c0wJtD2jQNLUnIZCOi8B4Kosq9EUyArVCWp+EZi2XTp
 Y8jH4i09+VAJrnUFHQvviZks/ZQhtR00k2NgVKsFb9CeNTl58L1mE1A9iI4tIjpRXidgNJW4b
 y5re31pCuTBcA8h6zZB1vGP5BL82W5yMG2uWVF2XHJ0nnVN4OYLllU2aavkxhH+g8ihkaS2co
 OhRERLnYQNBwwP4wTuQe5La+AUpw4V4nge9T6lGswvxR/WCIMnG31X01vReDOif7vW27KpEv/
 T0wOTKNTaCTFi9z96xO5PdaPiirs/u+DoaSPFG36ARwyM+zP/G5aHbNCw3HF3oei5ma1W/fNn
 knD5MeGEZW1DQog4PRNZuX00Ev7SstEhSN/DLBgp1ehW5NVcVuLuZRCZKeGge0v2HSDTmUFzr
 yCfO2NMJ14Lh1AvNUE3lPIR6pHTDzn9QEKP+uIzAQKjHtT09cWKlFtre/vpyYZKS8oboytE9w
 8/SI9NYtsmLNTy9W7RR1cNaPqvKcwKlfaGOtQT7+ILeYz33GOtnYEMYF0Id0xSgIB9y9SJCnd
 l6CcKgkOCYl5k4I6tfsTPjylAz2Tr/ixWqE3cAX+Uok5HEx/hibtr1w4TZ59CsGB2w7qIV3j1
 Pje9IaGoL3oLGz/Ye
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4S1DBFFWbnjw3x9FvwUWAoVxYAnZMDzH0
Content-Type: multipart/mixed; boundary="GxX6Nf0BKt6xhx3HfUuPvGijBy2UaFzlJ"

--GxX6Nf0BKt6xhx3HfUuPvGijBy2UaFzlJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/5 =E4=B8=8A=E5=8D=882:17, Matt Corallo wrote:
> This appears to be some kind of race when there are a lot of pending
> metadata writes in flight.
>=20
> I went and unmounted/remounted again (after taking about 30 minutes of
> 5MB/s writes flushing an rsync with a ton of tiny files) and after the
> remount the issue went away again. So I can only presume it is an issue=

> only when there are a million or so tiny files pending write.

Known bug, the upstream fix is d55966c4279b ("btrfs: do not zero
f_bavail if we have available space"), and is backported to stable kernel=
s.

I guess downstream kernels will soon get updated to fix it.

Thanks,
Qu
>=20
> Matt
>=20
> On 2/4/20 3:41 AM, Matt Corallo wrote:
>> Things settled a tiny bit after unmount (see last email for the errors=

>> that generated) and remount, and a balance -mconvert,soft worked:
>>
>> [268093.588482] BTRFS info (device dm-2): balance: start
>> -mconvert=3Draid1,soft -sconvert=3Draid1,soft
>> ...
>> [288405.946776] BTRFS info (device dm-2): balance: ended with status: =
0
>>
>> However, the enospc issue still appears and seems tied to a few of the=

>> previously-allocated metadata blocks:
>>
>> # btrfs balance start -musage=3D0 /bigraid
>> ...
>>
>> [289714.420418] BTRFS info (device dm-2): balance: start -musage=3D0 -=
susage=3D0
>> [289714.508411] BTRFS info (device dm-2): 64 enospc errors during bala=
nce
>> [289714.508413] BTRFS info (device dm-2): balance: ended with status: =
-28
>>
>> # cd /sys/fs/btrfs/e2843f83-aadf-418d-b36b-5642f906808f/allocation/ &&=

>> grep -Tr .
>> metadata/raid1/used_bytes:	255838797824
>> metadata/raid1/total_bytes:	441307889664
>> metadata/disk_used:	511677595648
>> metadata/bytes_pinned:	0
>> metadata/bytes_used:	255838797824
>> metadata/total_bytes_pinned:	999424
>> metadata/disk_total:	882615779328
>> metadata/total_bytes:	441307889664
>> metadata/bytes_reserved:	4227072
>> metadata/bytes_readonly:	65536
>> metadata/bytes_may_use:	433502945280
>> metadata/flags:	4
>> system/raid1/used_bytes:	1474560
>> system/raid1/total_bytes:	33554432
>> system/disk_used:	2949120
>> system/bytes_pinned:	0
>> system/bytes_used:	1474560
>> system/total_bytes_pinned:	0
>> system/disk_total:	67108864
>> system/total_bytes:	33554432
>> system/bytes_reserved:	0
>> system/bytes_readonly:	0
>> system/bytes_may_use:	0
>> system/flags:	2
>> global_rsv_reserved:	536870912
>> data/disk_used:	13645423230976
>> data/bytes_pinned:	0
>> data/bytes_used:	13645423230976
>> data/single/used_bytes:	13645423230976
>> data/single/total_bytes:	13661217226752
>> data/total_bytes_pinned:	0
>> data/disk_total:	13661217226752
>> data/total_bytes:	13661217226752
>> data/bytes_reserved:	117518336
>> data/bytes_readonly:	196608
>> data/bytes_may_use:	15064711168
>> data/flags:	1
>> global_rsv_size:	536870912
>>
>>
>> Somewhat more frightening, this also happens on the system blocks:
>>
>> [288405.946776] BTRFS info (device dm-2): balance: ended with status: =
0
>> [289589.506357] BTRFS info (device dm-2): balance: start -musage=3D5 -=
susage=3D5
>> [289589.905675] BTRFS info (device dm-2): relocating block group
>> 9676759498752 flags system|raid1
>> [289590.807033] BTRFS info (device dm-2): found 89 extents
>> [289591.300212] BTRFS info (device dm-2): 16 enospc errors during bala=
nce
>> [289591.300216] BTRFS info (device dm-2): balance: ended with status: =
-28
>>
>> Matt
>>
>> On 2/3/20 9:40 PM, Chris Murphy wrote:
>>> A developer might find it useful to see this reproduced with mount
>>> option enospc_debug. And soon after enospc the output from:
>>>
>>>  cd /sys/fs/btrfs/UUID/allocation/ && grep -Tr .
>>>
>>> yep, space then dot at the end
>>>


--GxX6Nf0BKt6xhx3HfUuPvGijBy2UaFzlJ--

--4S1DBFFWbnjw3x9FvwUWAoVxYAnZMDzH0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl46FH4ACgkQwj2R86El
/qhx5wf/fw7eddLb6lyvT7hvzdLlFOlVemAZRWFMOmNtx5cnni6eLmMfFUgrBZTl
XelAA5/ADIcEpbymR/jylyHAuJDjTJrwJSghAStfiC5k4HRqv7vC7bUV7IN/YpIB
K8oQtvQmjeNLtFq08LiM3DbSmdmAMdm22R2GBw1E1vIdm3iQHWMeuWjYtfQo09iR
evQhp8PKZpbz3EKZWwelGEMUZ4TVYb0vLa6ikRZMf1Cp+XrBXTGHhLik2tSL39Ls
FiHiocxhCuYEDup9mC6hPrbIhO165fk3jW/5+u6Fh3pQjvBf5VlQDe3iaq8XWl+C
MgbDJBA0gE+oRupDus9D7On7L7Dfvw==
=Wciu
-----END PGP SIGNATURE-----

--4S1DBFFWbnjw3x9FvwUWAoVxYAnZMDzH0--
