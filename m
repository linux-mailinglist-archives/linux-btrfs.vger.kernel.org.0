Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50F315253F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 04:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgBEDZu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 22:25:50 -0500
Received: from mout.gmx.net ([212.227.15.15]:47711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbgBEDZu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 22:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580873145;
        bh=fUTfiRz5S3dhuN6ARnJAZhLzC/c8+CtfPTjyRYl+qIE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Uu1C/pkCY7yJn7Mginzy6E1/R4cmKJ90Zwn2F0TwXmodDzvgBBkzGiaAnoKirTRuF
         YWrULy1tgwD7qcjxf6YBY5tqFAYZH4n9M8wMjcj5ZEAGrubuL2aMPp8wnGuXPD8ANa
         NbQUN/AhL3Mo3kmP1qeN6JYR0n0VLXFgkKDvhqCk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2f5Z-1ixoPP1o5P-004ASh; Wed, 05
 Feb 2020 04:25:45 +0100
Subject: Re: btrfs balance start -musage=0 / eats drive space
To:     Matt Corallo <linux@bluematt.me>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <526cb529-770c-9279-aad8-7632f07832b8@bluematt.me>
 <CAJCQCtTuKnsQJNKupKbmBxGpkZSqWcYXBD+36v9aT6zZAqmuhg@mail.gmail.com>
 <2353c20b-95c2-2d58-65eb-9d574ff506ee@bluematt.me>
 <615c56b6-4a05-2765-ce34-c6e1992c4c6f@bluematt.me>
 <bc23d961-6df3-6bcc-357c-200f68d05f5d@gmx.com>
 <8b51da8d-1060-a207-b542-26afe5023561@bluematt.me>
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
Message-ID: <1e5081a4-96d5-6066-dffa-52dc7cd5c242@gmx.com>
Date:   Wed, 5 Feb 2020 11:25:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <8b51da8d-1060-a207-b542-26afe5023561@bluematt.me>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KIwwD64PrFC4KWWBoSNnEJzOOG6MZnBwO"
X-Provags-ID: V03:K1:Mjy61iWjOdVdvROn2CL3JQum9Gi89MXdCwdtXle/oIbriE9AbBm
 mZDQFmP5jwYkrkR6AH1IglpP7XHFw7em1TFWoDQ08uEwarAa9dvda9/4bQNnmBlLz6f8379
 LxsxE3WBGvAFW/bnyoiugnL/d+rkEkGaCG4VMgRwUZI9ysqR9/APjfxeMrB7KTkTA7Nzlgp
 1OQwPBrRNKjMT2ngeBz1Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SbvlS2mx+7Q=:Zz57gz0ZVHSq5eIxvHtk0G
 WHYgXgGRH4PUZ7USJ41jBPAcOTV1Wh2PNcMOl9/RTIsHXWk9p8W/0YgpuG1kMC3HOzj+gumxB
 rePDGR7rBBLnDJzrer0OFWfXwyB083a8DaAFQbMidlueR2k0WRfvvHR7gjxGqjc9AtVk2VMWj
 ikQiYbl97wDDoMNfT9aJ05uUc213EdOaL2ewz+ajsVOxJCevT2UEWBtrGW2BBO1i8EKo+PMEw
 nLqyfaO5fRsJsXVziNeMXVcnQDnSTnShcYTGKRmfzBUpC0jz8+Uz7e3XVyBqGH1SxNVZd8CKr
 sF4Qw1eMndfBjDKTTD0yIy2CutFGZvwKrVStKmmRhG2lD382QHX+aW0zqTJqDmzRC+F7Y3oKR
 /2493cEuxDM2YCy6ggJUaf9fcSqzlV3TLVv4QrCROCc7/I6l8QZ8jpQhicQ6Yq/UvVdTAtyKC
 VlvYu/pRWja6z+Q2vZ/6eIkRXCUSA3exMxW54uiCg/nXLOaOsmqoVf5wWLM6/lWgvzXiw8ZmV
 G3S9SCP9QZoAmIqe6MTZ8Qn6y1I5QSx+Tpfk5mFvNYw0UqSNiRJ6HfEx2TO33F8K1NsGei4H5
 sXAB1cO5u8Lchu4SSb2PlTSCxhUCuyXiOfeXZr+fFCwFlrBxKfoI1ggBD7+8X5pR306PNapDY
 KVw883Zs5D2wvpaYtFmSgdkh2VzDL+Bz3KhR8EeN/ydk8LTxFHC1UKnEYLRZzZFxzqpBFbx6A
 v/YtPoKK1RGvt+dNKvc4O/cEq09BHX14cNpzNCtKTdybbxEqf+fYQrv0chuyO8tC0yucB38rC
 wkZ0U5Z7P21mPhafZfZxDTihCXa1g6IoKfbKPjZRcEXupUIhOy4iJCKAJzcFQjUaByLi7aAK/
 9z+ZbuGOn9pgzjVPikHr9VGg6qToSa13SkZi/9ppts/5tgSccws93jZj780Iu6WqHJQ4MX39A
 7nQ5JViUuqOTD2SMdKVnXJq71UrbGRwXCnCGsa22cEJvyOhYcREtHfo6dTIAEph+vuU02BlZS
 PwYPovXHj36FMxCpZd0pJJxAOHgPl+/QhRUcpTjOuYtgThVO/9NkZLC/YuitKlSa7oGpCiU9S
 YATnDn70VPACypZIYzPlUBV+t6iIwVNXkmMU7G9/vyUURiwXrRjpZchA29YL+iybEHVlbcimy
 KkSTA2Dz27PJm20wPrgW/1J+2zcbtRrEZ0GFzqnH22oEyWmoAZVO7ZvCCGzdY4f48BBEvPOrl
 G1Ra8N8dd45fqaUuV
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KIwwD64PrFC4KWWBoSNnEJzOOG6MZnBwO
Content-Type: multipart/mixed; boundary="KJvBo3Ik0qpMw69XiTs5hlA68RlOPzttY"

--KJvBo3Ik0qpMw69XiTs5hlA68RlOPzttY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/5 =E4=B8=8A=E5=8D=8811:18, Matt Corallo wrote:
> Hmm? My understanding is that that issue was only visible via stat
> calls, not in actual behavior. In this case, if you have a lot of
> in-flight writes from write cache balance will fail after allocating
> blocks (so I guess balance relies on stat()?)
>=20
> Also, this is all on a kernel with your previous patch "btrfs: super:
> Make btrfs_statfs() work with metadata over-commiting" applied.

Oh, sorry, misread some thing.

Then it's going to be fixed by a patchset:
https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D229013

It's relocation space calculation going too paranoid.

Thanks,
Qu
>=20
> Thanks,
> Matt
>=20
> On 2/5/20 1:03 AM, Qu Wenruo wrote:
>>
>>
>> On 2020/2/5 =E4=B8=8A=E5=8D=882:17, Matt Corallo wrote:
>>> This appears to be some kind of race when there are a lot of pending
>>> metadata writes in flight.
>>>
>>> I went and unmounted/remounted again (after taking about 30 minutes o=
f
>>> 5MB/s writes flushing an rsync with a ton of tiny files) and after th=
e
>>> remount the issue went away again. So I can only presume it is an iss=
ue
>>> only when there are a million or so tiny files pending write.
>>
>> Known bug, the upstream fix is d55966c4279b ("btrfs: do not zero
>> f_bavail if we have available space"), and is backported to stable ker=
nels.
>>
>> I guess downstream kernels will soon get updated to fix it.
>>
>> Thanks,
>> Qu
>>>
>>> Matt
>>>
>>> On 2/4/20 3:41 AM, Matt Corallo wrote:
>>>> Things settled a tiny bit after unmount (see last email for the erro=
rs
>>>> that generated) and remount, and a balance -mconvert,soft worked:
>>>>
>>>> [268093.588482] BTRFS info (device dm-2): balance: start
>>>> -mconvert=3Draid1,soft -sconvert=3Draid1,soft
>>>> ...
>>>> [288405.946776] BTRFS info (device dm-2): balance: ended with status=
: 0
>>>>
>>>> However, the enospc issue still appears and seems tied to a few of t=
he
>>>> previously-allocated metadata blocks:
>>>>
>>>> # btrfs balance start -musage=3D0 /bigraid
>>>> ...
>>>>
>>>> [289714.420418] BTRFS info (device dm-2): balance: start -musage=3D0=
 -susage=3D0
>>>> [289714.508411] BTRFS info (device dm-2): 64 enospc errors during ba=
lance
>>>> [289714.508413] BTRFS info (device dm-2): balance: ended with status=
: -28
>>>>
>>>> # cd /sys/fs/btrfs/e2843f83-aadf-418d-b36b-5642f906808f/allocation/ =
&&
>>>> grep -Tr .
>>>> metadata/raid1/used_bytes:	255838797824
>>>> metadata/raid1/total_bytes:	441307889664
>>>> metadata/disk_used:	511677595648
>>>> metadata/bytes_pinned:	0
>>>> metadata/bytes_used:	255838797824
>>>> metadata/total_bytes_pinned:	999424
>>>> metadata/disk_total:	882615779328
>>>> metadata/total_bytes:	441307889664
>>>> metadata/bytes_reserved:	4227072
>>>> metadata/bytes_readonly:	65536
>>>> metadata/bytes_may_use:	433502945280
>>>> metadata/flags:	4
>>>> system/raid1/used_bytes:	1474560
>>>> system/raid1/total_bytes:	33554432
>>>> system/disk_used:	2949120
>>>> system/bytes_pinned:	0
>>>> system/bytes_used:	1474560
>>>> system/total_bytes_pinned:	0
>>>> system/disk_total:	67108864
>>>> system/total_bytes:	33554432
>>>> system/bytes_reserved:	0
>>>> system/bytes_readonly:	0
>>>> system/bytes_may_use:	0
>>>> system/flags:	2
>>>> global_rsv_reserved:	536870912
>>>> data/disk_used:	13645423230976
>>>> data/bytes_pinned:	0
>>>> data/bytes_used:	13645423230976
>>>> data/single/used_bytes:	13645423230976
>>>> data/single/total_bytes:	13661217226752
>>>> data/total_bytes_pinned:	0
>>>> data/disk_total:	13661217226752
>>>> data/total_bytes:	13661217226752
>>>> data/bytes_reserved:	117518336
>>>> data/bytes_readonly:	196608
>>>> data/bytes_may_use:	15064711168
>>>> data/flags:	1
>>>> global_rsv_size:	536870912
>>>>
>>>>
>>>> Somewhat more frightening, this also happens on the system blocks:
>>>>
>>>> [288405.946776] BTRFS info (device dm-2): balance: ended with status=
: 0
>>>> [289589.506357] BTRFS info (device dm-2): balance: start -musage=3D5=
 -susage=3D5
>>>> [289589.905675] BTRFS info (device dm-2): relocating block group
>>>> 9676759498752 flags system|raid1
>>>> [289590.807033] BTRFS info (device dm-2): found 89 extents
>>>> [289591.300212] BTRFS info (device dm-2): 16 enospc errors during ba=
lance
>>>> [289591.300216] BTRFS info (device dm-2): balance: ended with status=
: -28
>>>>
>>>> Matt
>>>>
>>>> On 2/3/20 9:40 PM, Chris Murphy wrote:
>>>>> A developer might find it useful to see this reproduced with mount
>>>>> option enospc_debug. And soon after enospc the output from:
>>>>>
>>>>>  cd /sys/fs/btrfs/UUID/allocation/ && grep -Tr .
>>>>>
>>>>> yep, space then dot at the end
>>>>>
>>


--KJvBo3Ik0qpMw69XiTs5hlA68RlOPzttY--

--KIwwD64PrFC4KWWBoSNnEJzOOG6MZnBwO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl46NbMACgkQwj2R86El
/qhDDwf/YkxMc7F1UaqGW7z/OOQJjs4p1lRg/6mEnLJ6cN84pllr9EZLa4x1dmd1
8pDpHFlV4LtdCvCmjdQqEJNBGiltk88Vp0SvhzbnZz9HJBrE/+In/JhwDDxyyPJ3
4GJ4y4ZwpJp3GwYOBgfCjNiU5VsN4QFxoL1HAAfW5ZbAh2/wgOSDbAfINuvZrB0n
oNvHF4u8Ha8kiSJluQd6/whQXf/ISxzZd7Ee6XqTPSg4khDvsijVPLRN9z9RbvaZ
SHocf/j0T5sB0a2I3w8pykNli6al5hSPSEqlmY3NH22bugOiyx8/ZpDEd6h23mGa
qEcGxYhvr1JGBinrpGfMWsbXLMPkng==
=J+rr
-----END PGP SIGNATURE-----

--KIwwD64PrFC4KWWBoSNnEJzOOG6MZnBwO--
