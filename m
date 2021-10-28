Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B5D43DBB2
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 09:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhJ1HMz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 03:12:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:48437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhJ1HMz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 03:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635405015;
        bh=Aeofu8hFB0LgNNZ+WzDqTsPgvNFTLAFOV2sxqd1mbIo=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=Fut+9upLNCg50I4xdrT1gm9E3oF5gHJF1CefesMbdbKUOWF0gEOXoRP0pMWSNeLos
         0KoXJYea4+rNdWOqs9IpPSw0mMMoVv/hjKB/YOkEM9+vCpP196cns6C++rTn54QMyY
         tBichwlrkfZG4wG9WNEsj9yD05M82Ntd+PZoVM78=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjS54-1n3nzQ3N1e-00kyeX; Thu, 28
 Oct 2021 09:10:15 +0200
Message-ID: <10908a2e-30bb-1960-60fd-c225191be7c3@gmx.com>
Date:   Thu, 28 Oct 2021 15:10:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211027052859.44507-1-wqu@suse.com>
 <20211027052859.44507-3-wqu@suse.com>
 <514d1330-6af8-4d48-fef6-f2732d7f186d@oracle.com>
 <f229e88f-5483-9f2d-00eb-9da45f9bca4e@gmx.com>
 <91627cd8-279b-30a1-7e10-adb43f5a2027@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
In-Reply-To: <91627cd8-279b-30a1-7e10-adb43f5a2027@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZIsSjZNUWhGfHB1B2Nj2G8az7KcyMBQ4nLxQ05vN7PSSWkFFabL
 v8hjMvl2RdZrFcRKmJIYKKLJ9U79LZMZYq7QvmA3umcYA0hujFa3SIGdbc+F4DqYJc+gOQ+
 1ZfgQTt45WQcnlgqfcT/WyCMg81EwRpNxkk2WBvYD7E18O5mE8buwCoB4A0c6a1BgG4tZOZ
 v/1PGxcN+6hRdfUeXZVHw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xGvbpfe/ogE=:khiXmLRCPfH6KJaNXi8mTH
 ppwBQWsvmeucabD1/9Lo1YYGK+adrFZGOTqzs5DIos1gpDjit/hh6Yl/EX5pLJpTIuUwo576z
 uKgOyJkjlEMWVkiRNN7/kR4oWu+QP/INQSmj3RXmEAS8e5KIvALEUwrGRoTPMzPDY09UrXDS9
 g92X5ul1hrAwY0u29PH6Dbk7avRZdca+voLLWGiRW4Ec5Elo4LJY56OPCE7UjjeR9PyREnPuC
 nW0v4bNT+goHwH+y/6lKNp3Lf4dMWau1hGCHDdTMwkxuOKNsoPyQLMDMxft4jHi33WKPHNW7r
 0spCyvOsjR7h/Zrsofob5HMOhi+cqCfeYn6I/XcXGttr30JM59Eo3ZuzV+qV4eGLM9l7Km3ZM
 ctN72pICTTjveimxShaInLzFn3oLyM3UGhBAsX/j99zHHRW4b02FC/vr1KMKA9uiWv4B2nFWu
 JXOI5jCe+ng5eESYEgD8PdE/aExm9y0rtK7iLsXdZnkuAHmbf9kc3lTFexQ5wJYu38bNZp+Om
 BYB4ptMXnZC35R32IZ6X+yo/6eFmReZnklG3SwSxlzlid9T9X7u7XcPZtgXH7+VEBIyS/KrdN
 k3IIzMlqmJpf44sek6UZDCPo5ZJyZvlHGVC9hUKb4y6WwPHieEjlk/P34RVQ6dSkZyanvmFKL
 NZsIsYP0yjEGJ3234SCpBr28MPY5MbazJrrI3MzG5cPg4JlEQnRLElRi59R9TXEdP3sIU8vnI
 RQiDy1GZ3xBoQhMzq49Sb+YFCJoUzUCyYN2eywSOvJNTVmyJQwqqgcoGIvP55+Gt8K7i5CSrC
 0GaQeVxAZXm2jqCbsTSp0c7UMaBjYynEbrR/Mac1S9/pD9f+2CKg+yFQRvkLLyXXIV9TDa6+h
 NlRr8sIMNCAgOEZgmGX7j5kDzWlpQz8yzx/nj5SBJ5Ed33FVWF3DEu1gugE7mVpf/E9KkrBxr
 HB19g9AVpMxpAaAY9bomPOmE7xAo29IE1l1dVwthygUCIE9AU9ht/a01lYgKtQWs0wN7nHh0D
 oKOAYK1coJnhk7ih9KAu/+/Dx6be8kwypWlkt1hSpZ7z9TlqNSk+B1aBgJZSkHzxnAVn4nHMB
 D32ysfuBYfoxJE=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/28 09:04, Anand Jain wrote:
>
>
> On 27/10/2021 18:41, Qu Wenruo wrote:
>>
>>
>> On 2021/10/27 17:23, Anand Jain wrote:
>>> On 27/10/2021 13:28, Qu Wenruo wrote:
>>>> In function btrfs_bg_flags_to_raid_index(), we use quite some if () t=
o
>>>> convert the BTRFS_BLOCK_GROUP_* bits to a index number.
>>>>
>>>> But the truth is, there is really no such need for so many branches a=
t
>>>> all.
>>>> Since all BTRFS_BLOCK_GROUP_* flags are just one single bit set insid=
e
>>>> BTRFS_BLOCK_GROUP_PROFILES_MASK, we can easily use ilog2() to calcula=
te
>>>> their values.
>>>>
>>>> Only one fixed offset is needed to make the index sequential (the
>>>> lowest profile bit starts at ilog2(1 << 3) while we have 0 reserved f=
or
>>>> SINGLE).
>>>>
>>>> Even with that calculation involved (one if(), one ilog2(), one minus=
),
>>>> it should still be way faster than the if () branches, and now it is
>>>> definitely small enough to be inlined.
>>>>
>>>
>>> =C2=A0=C2=A0Why not just use reverse static index similar to
>>>
>>> const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] =3D=
 {
>>> <snip>
>>> }
>>
>> Sorry, I didn't get the point.
>>
>> Mind to share more details?
>>
>
> Something like
>
> /* Must match with the order of BTRFS_BLOCK_GROUP_XYZ */
> +enum btrfs_raid_types {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID0,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID1,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_RAID_DUP,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID10,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID5,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID6,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID1C3,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID1C4,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_RAID_SINGLE,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_NR_RAID_TYPES

OK I got your point.

But the point here is, I don't want to enum btrfs_raid_types to hide the
value and rely on us to make it in proper order.

Thus that's why my version have all the ilog2() values.

And in that case, it's just a difference between the shift value and
where we put RAID_SINGLE.

> +};
>
> btrfs_bg_flags_to_raid_index(u64 flags)
> {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>  =C2=A0=C2=A0=C2=A0=C2=A0flags =3D flags & BTRFS_BLOCK_GROUP_PROFILE_MAS=
K;
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ilog2(flags);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D 0)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return=C2=A0 BTRFS_RAID_SINGLE;

In fact, ilog2(0) behavior is undefined, and should be avoided.

In this case, we still need to check if (flags =3D=3D 0), and just change
the shift value.

Thanks,
Qu

>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret - 3;
> }
>
> Should work. No?
>
> Thanks, Anand
>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks, Anand
>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> =C2=A0 fs/btrfs/space-info.h |=C2=A0 2 ++
>>>> =C2=A0 fs/btrfs/volumes.c=C2=A0=C2=A0=C2=A0 | 26 --------------------=
------
>>>> =C2=A0 fs/btrfs/volumes.h=C2=A0=C2=A0=C2=A0 | 42 ++++++++++++++++++++=
++++++++++++----------
>>>> =C2=A0 3 files changed, 34 insertions(+), 36 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
>>>> index cb5056472e79..5a0686ab9679 100644
>>>> --- a/fs/btrfs/space-info.h
>>>> +++ b/fs/btrfs/space-info.h
>>>> @@ -3,6 +3,8 @@
>>>> =C2=A0 #ifndef BTRFS_SPACE_INFO_H
>>>> =C2=A0 #define BTRFS_SPACE_INFO_H
>>>> +#include "volumes.h"
>>>> +
>>>> =C2=A0 struct btrfs_space_info {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spinlock_t lock;
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index a8ea3f88c4db..94a3dfe709e8 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -154,32 +154,6 @@ const struct btrfs_raid_attr
>>>> btrfs_raid_array[BTRFS_NR_RAID_TYPES] =3D {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>>> =C2=A0 };
>>>> -/*
>>>> - * Convert block group flags (BTRFS_BLOCK_GROUP_*) to
>>>> btrfs_raid_types, which
>>>> - * can be used as index to access btrfs_raid_array[].
>>>> - */
>>>> -enum btrfs_raid_types __attribute_const__
>>>> btrfs_bg_flags_to_raid_index(u64 flags)
>>>> -{
>>>> -=C2=A0=C2=A0=C2=A0 if (flags & BTRFS_BLOCK_GROUP_RAID10)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_RAID10;
>>>> -=C2=A0=C2=A0=C2=A0 else if (flags & BTRFS_BLOCK_GROUP_RAID1)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_RAID1;
>>>> -=C2=A0=C2=A0=C2=A0 else if (flags & BTRFS_BLOCK_GROUP_RAID1C3)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_RAID1C3=
;
>>>> -=C2=A0=C2=A0=C2=A0 else if (flags & BTRFS_BLOCK_GROUP_RAID1C4)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_RAID1C4=
;
>>>> -=C2=A0=C2=A0=C2=A0 else if (flags & BTRFS_BLOCK_GROUP_DUP)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_DUP;
>>>> -=C2=A0=C2=A0=C2=A0 else if (flags & BTRFS_BLOCK_GROUP_RAID0)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_RAID0;
>>>> -=C2=A0=C2=A0=C2=A0 else if (flags & BTRFS_BLOCK_GROUP_RAID5)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_RAID5;
>>>> -=C2=A0=C2=A0=C2=A0 else if (flags & BTRFS_BLOCK_GROUP_RAID6)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_RAID6;
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SI=
NGLE */
>>>> -}
>>>> -
>>>> =C2=A0 const char *btrfs_bg_type_to_raid_name(u64 flags)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const int index =3D btrfs_bg_flags_to_=
raid_index(flags);
>>>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>>>> index e0c374a7c30b..7038c6cee39a 100644
>>>> --- a/fs/btrfs/volumes.h
>>>> +++ b/fs/btrfs/volumes.h
>>>> @@ -17,19 +17,42 @@ extern struct mutex uuid_mutex;
>>>> =C2=A0 #define BTRFS_STRIPE_LEN=C2=A0=C2=A0=C2=A0 SZ_64K
>>>> +/*
>>>> + * Here we use ilog2(BTRFS_BLOCK_GROUP_*) to convert the profile
>>>> bits to
>>>> + * an index.
>>>> + * We reserve 0 for BTRFS_RAID_SINGLE, while the lowest profile,
>>>> ilog2(RAID0),
>>>> + * is 3, thus we need this shift to make all index numbers sequentia=
l.
>>>> + */
>>>> +#define BTRFS_RAID_SHIFT=C2=A0=C2=A0=C2=A0 (ilog2(BTRFS_BLOCK_GROUP_=
RAID0) - 1)
>>>> +
>>>> =C2=A0 enum btrfs_raid_types {
>>>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID10,
>>>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID1,
>>>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_DUP,
>>>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID0,
>>>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_SINGLE,
>>>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID5,
>>>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID6,
>>>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID1C3,
>>>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID1C4,
>>>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_SINGLE=C2=A0 =3D 0,
>>>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID0=C2=A0=C2=A0 =3D ilog2(BTRFS_BLOC=
K_GROUP_RAID0 >>
>>>> BTRFS_RAID_SHIFT),
>>>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID1=C2=A0=C2=A0 =3D ilog2(BTRFS_BLOC=
K_GROUP_RAID1 >>
>>>> BTRFS_RAID_SHIFT),
>>>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_DUP=C2=A0=C2=A0=C2=A0=C2=A0 =3D ilog2(=
BTRFS_BLOCK_GROUP_DUP >>
>>>> BTRFS_RAID_SHIFT),
>>>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID10=C2=A0 =3D ilog2(BTRFS_BLOCK_GRO=
UP_RAID10 >>
>>>> BTRFS_RAID_SHIFT),
>>>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID5=C2=A0=C2=A0 =3D ilog2(BTRFS_BLOC=
K_GROUP_RAID5 >>
>>>> BTRFS_RAID_SHIFT),
>>>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID6=C2=A0=C2=A0 =3D ilog2(BTRFS_BLOC=
K_GROUP_RAID6 >>
>>>> BTRFS_RAID_SHIFT),
>>>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID1C3 =3D ilog2(BTRFS_BLOCK_GROUP_RA=
ID1C3 >>
>>>> BTRFS_RAID_SHIFT),
>>>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID1C4 =3D ilog2(BTRFS_BLOCK_GROUP_RA=
ID1C4 >>
>>>> BTRFS_RAID_SHIFT),
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_NR_RAID_TYPES
>>>> =C2=A0 };
>>>
>>>
>>>> +/*
>>>> + * Convert block group flags (BTRFS_BLOCK_GROUP_*) to
>>>> btrfs_raid_types, which
>>>> + * can be used as index to access btrfs_raid_array[].
>>>> + */
>>>> +static inline enum btrfs_raid_types __attribute_const__
>>>> +btrfs_bg_flags_to_raid_index(u64 flags)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 u64 profile =3D flags & BTRFS_BLOCK_GROUP_PROFILE=
_MASK;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (!profile)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_SINGLE;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return ilog2(profile >> BTRFS_RAID_SHIFT);
>>>> +}
>>>> +
>>>> =C2=A0 struct btrfs_io_geometry {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* remaining bytes before crossing a s=
tripe */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 len;
>>>> @@ -646,7 +669,6 @@ void btrfs_scratch_superblocks(struct
>>>> btrfs_fs_info *fs_info,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct block_device *b=
dev,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *device_pat=
h);
>>>> -enum btrfs_raid_types __attribute_const__
>>>> btrfs_bg_flags_to_raid_index(u64 flags);
>>>> =C2=A0 int btrfs_bg_type_to_factor(u64 flags);
>>>> =C2=A0 const char *btrfs_bg_type_to_raid_name(u64 flags);
>>>> =C2=A0 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
>>>>
>>>
