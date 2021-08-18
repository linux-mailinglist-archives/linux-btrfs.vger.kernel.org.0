Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFF03EFA23
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 07:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbhHRFes (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 01:34:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:42425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237839AbhHRFer (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 01:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629264850;
        bh=7Hp/6ngMXHnGLPZOgAWzhNLPD0aQzm4cSa+5QacxLPo=;
        h=X-UI-Sender-Class:From:To:References:Subject:Date:In-Reply-To;
        b=k/rJhqvzMzruXOb4apT1rboBsr1wMOxHVg6mLpBHJwya3F8lLjzXhFpPtH1Udj5fY
         QVgJ3iQG1WEQt+O2ycSQgOGW8lR/UC+UCM2hFu/hD8aNDL6PTLM1ezMu5wT3eICei0
         DulVNJRDZvwDjZvCRGAxLQuA50OG+T+US9FsbByQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DJl-1mDCLU2IO5-003bAP; Wed, 18
 Aug 2021 07:34:10 +0200
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     dsterba@suse.cz, Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
References: <20210809182613.4466-1-mpdesouza@suse.com>
 <20210817132419.GK5047@twin.jikos.cz>
 <04abaf84-12e3-3983-dee4-a5073ec786f1@gmx.com>
Subject: Re: [PATCH] btrfs-progs: Drop the type check in
 init_alloc_chunk_ctl_policy_regular
Message-ID: <663a1ce1-09e5-e0dd-e957-98984818b64d@gmx.com>
Date:   Wed, 18 Aug 2021 13:34:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <04abaf84-12e3-3983-dee4-a5073ec786f1@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y2yVj3aecoBCwYy0R0GhPEqE1yfO7vDmalgTHgTYoLn1dcL2HFu
 b2xooaD/EPGGD5i7zuQKu1bT0km5lsgKZ8uicv+zmq0WdIjzS5ckMXXFozxqaFSEzdlVzEr
 IwYYxN9BX0FYsuoawm6QTkTYZEkSXrJopy7YioHr3YSMle/9eH3Zkyox6otTqHKUCvM5P2S
 +UXMVJL2r7E1QNmvV3Twg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sdACVQ6IM5A=:2Zk/F18qEvTyqYEUHDSNTf
 pdNAHQoJfgFm3R2LuP6XIj6hKmRlV8x2O4y13W2FMuy5g+6+VtpJrwjZfTvJpA+ccY+IqUWx9
 ZQUEVt4BnggZ+LrcmI3dF6hynLv70OgkKbMmaVKwOsQfMRFYLsaBu+Yo5ciHn7SE6lBZpxxX/
 grv0ZEpdaezu6huKOivP9VmLzlHGp0vKI6OfAj9O7zC6AIOH6XjeKHXYS4AhPoN5IFUi0q8x6
 RgmkT3ygdOBQ1smdvCvPsBbEiQZS4ZC3cRXV1D5b77cmba/QNuOK2LIcb2QXhF7lDTNyGjtky
 ciK2xIeeTEs/BZpKbycW1JVRLlSO7GQorKHWsIAewshvxviemG8zl4PBVxqs9xz9xIgalyGfz
 9rc3rNoWA6J7Vs6kQ4gG5sUKyz+6hAK/5hEMbT4hFmPQyAaDdRH1Z/xPm0d+piXxxUv1jsakW
 XKABWDqAKpvp18O6W3m777NlCFsRoBIc0nXZ3dRJy5NSm23q6tai04ZrG39tqj2UW3U/qTO4H
 OtrsOZGundNe+gQjVLvr2OCxAz3iifaQH/Zv43JzKlphMxtxv/K+0hz6XNVTRKwyAMYTSBbXJ
 YgUvwjUvk2FndTqkpPkTNPYR8Fv6SP6JsSM33vyaKmJAmBmd8uQuEQdH3jdo8RmmR/BK/4edu
 vgdxtKhhlZL05WMUrEgonNrWok2Omi4zxXYlB52yjruhQCKY5u4gvuvkGKhUkUEfc5sxX8mdT
 mFlM6mAHF4Zb47CZYI2uj0Tn5PQaF67sTBklAFbLZKbGjwSjOTKndNJ+/uZxHdDN26yEfpAYD
 4h6ho2XrNnImT9CW3SZb2nQo4rogPRAK8ZPiPKpwmoCfO1UU+qHiOrkkD0W8jNljHX6sgAqEv
 7vrmi9l8Rvf+syO8vXm+ksre2VNG5vzEZctY4THZLKY3gRpZRARSve3DSBfkemkOr2+95S1BK
 vcbkObZS/huTlNAt+OSx7eLkxjg9CNykR5f00pRewkplQNvM0muMJTD4gjiLaFhEOU7ZSik9h
 DiWTBF6HrfulnKJgGXaMRezkUybszB+svxomNgzz8YvtjOmz+XJPw/KbxTzg3nQ39pfCa06c9
 y7f1oZjdRgp7U3LE4gZP63C9if/PRTE113pYCgCQoRV9qLfghgDokdZOQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/18 =E4=B8=8B=E5=8D=881:17, Qu Wenruo wrote:
>
>
> On 2021/8/17 =E4=B8=8B=E5=8D=889:24, David Sterba wrote:
>> On Mon, Aug 09, 2021 at 03:26:13PM -0300, Marcos Paulo de Souza wrote:
>>> [PROBLEM]
>>> Our documentation says that a DATA block group can have up to 1G of
>>> size, or the at most 10% of the filesystem size. Currently, by default=
,
>>> mkfs.btrfs is creating an initial DATA block group of 8M of size,
>>> regardless of the filesystem size. It happens because we check for the
>>> ctl->type in init_alloc_chunk_ctl_policy_regular to be one of the
>>> BTRFS_BLOCK_GROUP_PROFILE_MASK bits, which is not the case for SINGLE
>>> (default) DATA block group:
>>>
>>> $ mkfs.btrfs -f /storage/btrfs.disk
>>> btrfs-progs v4.19.1
>>> See http://btrfs.wiki.kernel.org for more information.
>>>
>>> Label:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (null)
>>> UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 39e3492f-41f2-4bd7-8c25-93032606b9fe
>>> Node size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16384
>>> Sector size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096
>>> Filesystem size:=C2=A0=C2=A0=C2=A0 55.00GiB
>>> Block group profiles:
>>> =C2=A0=C2=A0 Data:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 single=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 8.00MiB
>>> =C2=A0=C2=A0 Metadata:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 DUP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1.00GiB
>>> =C2=A0=C2=A0 System:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 DUP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.00MiB
>>> SSD detected:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>>> Incompat features:=C2=A0 extref, skinny-metadata
>>> Number of devices:=C2=A0 1
>>> Devices:
>>> =C2=A0=C2=A0=C2=A0 ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SIZE=
=C2=A0 PATH
>>> =C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0 55.00GiB=C2=A0 /storage/b=
trfs.disk
>>>
>>> In this case, for single data profile, it should create a data block
>>> group of 1G, since the filesystem if bigger than 50G.
>>>
>>> [FIX]
>>> Remove the check for BTRFS_BLOCK_GROUP_PROFILE_MASK in
>>> init_alloc_chunk_ctl_policy_regular function. The ctl->stripe_size is
>>> later on assigned to ctl.num_bytes, which is used by
>>> btrfs_make_block_group to create the block group.
>>>
>>> By removing the check we allow the code to always configure the correc=
t
>>> stripe_size regardless of the PROFILE, looking on the block group TYPE=
.
>>>
>>> With the fix applied, it now created the BG correctly:
>>>
>>> $ ./mkfs.btrfs -f /storage/btrfs.disk
>>> btrfs-progs v5.10.1
>>> See http://btrfs.wiki.kernel.org for more information.
>>>
>>> Label:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (null)
>>> UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 5145e343-5639-462d-82ee-3eb75dc41c31
>>> Node size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16384
>>> Sector size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096
>>> Filesystem size:=C2=A0=C2=A0=C2=A0 55.00GiB
>>> Block group profiles:
>>> =C2=A0=C2=A0 Data:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 single=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 1.00GiB
>>> =C2=A0=C2=A0 Metadata:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 DUP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1.00GiB
>>> =C2=A0=C2=A0 System:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 DUP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.00MiB
>>> SSD detected:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>>> Zoned device:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>>> Incompat features:=C2=A0 extref, skinny-metadata
>>> Runtime features:
>>> Checksum:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
crc32c
>>> Number of devices:=C2=A0 1
>>> Devices:
>>> =C2=A0=C2=A0=C2=A0 ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SIZE=
=C2=A0 PATH
>>> =C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0 55.00GiB=C2=A0 /storage/b=
trfs.disk
>>>
>>> Using a disk >50G it creates a 1G single data block group. Another
>>> example:
>>>
>>> $ ./mkfs.btrfs -f /storage/btrfs2.disk
>>> btrfs-progs v5.10.1
>>> See http://btrfs.wiki.kernel.org for more information.
>>>
>>> Label:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (null)
>>> UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 c0910857-e512-4e76-9efa-50a475aafc87
>>> Node size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16384
>>> Sector size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096
>>> Filesystem size:=C2=A0=C2=A0=C2=A0 5.00GiB
>>> Block group profiles:
>>> =C2=A0=C2=A0 Data:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 single=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 512.00MiB
>>> =C2=A0=C2=A0 Metadata:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 DUP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 256.00MiB
>>> =C2=A0=C2=A0 System:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 DUP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.00MiB
>>> SSD detected:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>>> Zoned device:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>>> Incompat features:=C2=A0 extref, skinny-metadata
>>> Runtime features:
>>> Checksum:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
crc32c
>>> Number of devices:=C2=A0 1
>>> Devices:
>>> =C2=A0=C2=A0=C2=A0 ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SIZE=
=C2=A0 PATH
>>> =C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0 5.00GiB=C2=A0 /stor=
age/btrfs2.disk
>>>
>>> The code now created a single data block group of 512M, which is exact=
ly
>>> 10% of the size of the filesystem, which is 5G in this case.
>>>
>>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>>> ---
>>>
>>> =C2=A0 This change mimics what the kernel currently does, which is set=
 the
>>> stripe_size
>>> =C2=A0 regardless of the profile. Any thoughts on it? Thanks!
>>
>> Makes sense to unify that, it works well for the large sizes. Please
>> write tests that verify that the chunk sizes are correct after mkfs on
>> various device sizes. Patch added to devel, thanks.
>>
>
> It in fact makes fsck/025 to fail, bisection points to this patch
> surprisingly.
>
> Now "mkfs.btrfs -f" on a 128M file will just fail.
>
> This looks like a big problem to me though...

The cause here is that, we changed the minimal stripe size for SINGLE
profile.

The old code for profile SINGLE will not go through any of the type
specific limits, and falls back to use the default limits, which has
only 1MiB minimal stripe limit.

While the new code changes the minimal stripe length to 64MiB.

Furthermore, currently mkfs using default profiles will lead to the
following chunk layout:

   Data:             single            8.00MiB
   Metadata:         DUP              32.00MiB
   System:           DUP               8.00MiB

This means, System + Metadata will eat up 80MiB already (40MiB x2 caused
by DUP profile). leaving only 48 MiB space left for data, which is
smaller than the 64MiB minimal stripe requirement.

In fact, this behavior is still not the same as kernel, as kernel can
create 16MiB SINGLE data chunk without any problem, so the 64MiB limit
is not correct either.

Since we're here, I hope we can work on the initial chunk size with
better flexibility, not creating too large metadata chunk which easily
eat up half of the space.

Thanks,
Qu
>
> Thanks,
> Qu
