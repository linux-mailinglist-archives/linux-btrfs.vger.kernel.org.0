Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2833543C7D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 12:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbhJ0Knh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 06:43:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:42773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232122AbhJ0Kng (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 06:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635331264;
        bh=Z232Wi9QCd6jYJOyTKxWTI8RYxvZJ7RUA71kpNqb37o=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=WXiHtMt5ArfbKn4dvsjlD1V1rRAcHIRBpURB38ksmTeWl8iqcbdks7xjyesx6LDp1
         +DthWQBR6JuY3dva+AzaG1RoWNi8oXh6wWQa1mJ/Ob8DoyYA8eC3bcEosnm4LeSRJ2
         w3q5Vp9V38A63VNyRzErtsi7CQzwtfbkI8hYuup4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEV3I-1mQoH40O7e-00G3aB; Wed, 27
 Oct 2021 12:41:04 +0200
Message-ID: <f229e88f-5483-9f2d-00eb-9da45f9bca4e@gmx.com>
Date:   Wed, 27 Oct 2021 18:41:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211027052859.44507-1-wqu@suse.com>
 <20211027052859.44507-3-wqu@suse.com>
 <514d1330-6af8-4d48-fef6-f2732d7f186d@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <514d1330-6af8-4d48-fef6-f2732d7f186d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F/yDVpOmZSp0ZFV10Z3EgkvO+lF2ADAF9yuNyTgI+TBJZVtI33W
 NX3LhUwd0bWq6BShX/1xubeI0lHHYGNN2LDjb9DEJora6cyEiuTDgw+jZzZPc8TglwvN6Nk
 gie7Mp9QOI4swDE+I4AayfAri6hzWtJZ0CrRNu4uyk5Iguc02oPGWbRi54pRBxVvElc9jMR
 VYX48cPmnfPKFYo13tR1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X3CSwMyKVNE=:/QXF3cw5cOF1c3fVmueuV9
 qcmhY3ZzOVG/4YzwxXx/1b92OW52kCYAscCEFK5tSjAJZh0HznJuZieKDvcbPPFBQmXQWJuj7
 CLHaKUjbHezJW9GLXVysIJBKK6X2TFVjKKC9foNCM2I/0qBkHg+90A22k6DvpaYqUqKeJ5OUT
 ToWBfa5Q2UinHaQpz3fDOcdHVZ6qwBBQ+BFjfxhs8AWlf4UoTwT+nqHFwZrfwoFvGwgR2k8cf
 poM29q0CNs7HYy5PpTeJlUrEXxSRgKR+cIof3yOrA3LRTOskrRSCTqKfhN5tF6CQqWgZpQXjq
 e8RbyOtYPcjVytcdfWGNYxzMxNnH5b+i8X/XIePZTPUqlbm3K5ygDBvW3TxGWa3YAyqzlaWxe
 Vm9+eZr+YYqVOQnyHyq0yuDDYnh+Am8lyFH3ET+FOqZj8kc0NOtY0qlaE0nn9FUD7f6VhoYzG
 tjgh+fdFjKCyxCKFyvOBSJ5poFg7EnFI/dqPgWxFUBNAG7FJ660J8XGRm/zNHrLQldI2qrcz6
 usmaTAY7SPunxH+hgG6/v70NkXfBSc8xunzZaTjd+OYNilFEalueP4gVX0wbPXsoKwfKGgmyG
 T96Q24MSI50YUF3g4Che/HBGoekrnKIlPTceIZWJIBd2RsV/u3Ax59BqTP0xEp2Faqe5bZLn+
 N+D27clUsmk1Tu0bWZMfwxD++SAz4yF05L7zvhRHVquSUftfep958xCJs2kQVn7O7nVFZiWub
 eaHQtOCG5dgv3un98ZvlnyLC15BJ5UFjUwNO1lcWxHVsZ4ns2p9bQrF+AeWH4Qnu4tqhjUX/2
 mcmAgZzR848c3wUzpxXxTjPcrmVFFWAFrLE7NxDEAMMvH7/o0+3InzYvHeJJJ6Wn9p58fb6lr
 ih8xNzhDxwTSIqyZlMVgIMTSKOW2vkgTXSDHQEGAcUmfYKBQrGAHsPJXaHETuEqp/qTb/sn6g
 oF0Xa8CNDcI9UN1PTQbJN1P/ZJLfPV2nOx5DZKZEFohtbrgr4hTIDXjRucfGuWGiOWWkmUsal
 ey1+oN1kCdI0fBC+3v3WeYWltDhtjIInv8YvdMYM9jsZrMNCJbI4PguoHwdkp/zZSLt4tN8Ef
 wTmQqmsTJsn1p0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/27 17:23, Anand Jain wrote:
> On 27/10/2021 13:28, Qu Wenruo wrote:
>> In function btrfs_bg_flags_to_raid_index(), we use quite some if () to
>> convert the BTRFS_BLOCK_GROUP_* bits to a index number.
>>
>> But the truth is, there is really no such need for so many branches at
>> all.
>> Since all BTRFS_BLOCK_GROUP_* flags are just one single bit set inside
>> BTRFS_BLOCK_GROUP_PROFILES_MASK, we can easily use ilog2() to calculate
>> their values.
>>
>> Only one fixed offset is needed to make the index sequential (the
>> lowest profile bit starts at ilog2(1 << 3) while we have 0 reserved for
>> SINGLE).
>>
>> Even with that calculation involved (one if(), one ilog2(), one minus),
>> it should still be way faster than the if () branches, and now it is
>> definitely small enough to be inlined.
>>
>
>  =C2=A0Why not just use reverse static index similar to
>
> const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] =3D {
> <snip>
> }

Sorry, I didn't get the point.

Mind to share more details?

Thanks,
Qu

>
> Thanks, Anand
>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/space-info.h |=C2=A0 2 ++
>> =C2=A0 fs/btrfs/volumes.c=C2=A0=C2=A0=C2=A0 | 26 ----------------------=
----
>> =C2=A0 fs/btrfs/volumes.h=C2=A0=C2=A0=C2=A0 | 42 ++++++++++++++++++++++=
++++++++++----------
>> =C2=A0 3 files changed, 34 insertions(+), 36 deletions(-)
>>
>> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
>> index cb5056472e79..5a0686ab9679 100644
>> --- a/fs/btrfs/space-info.h
>> +++ b/fs/btrfs/space-info.h
>> @@ -3,6 +3,8 @@
>> =C2=A0 #ifndef BTRFS_SPACE_INFO_H
>> =C2=A0 #define BTRFS_SPACE_INFO_H
>> +#include "volumes.h"
>> +
>> =C2=A0 struct btrfs_space_info {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spinlock_t lock;
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index a8ea3f88c4db..94a3dfe709e8 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -154,32 +154,6 @@ const struct btrfs_raid_attr
>> btrfs_raid_array[BTRFS_NR_RAID_TYPES] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> =C2=A0 };
>> -/*
>> - * Convert block group flags (BTRFS_BLOCK_GROUP_*) to
>> btrfs_raid_types, which
>> - * can be used as index to access btrfs_raid_array[].
>> - */
>> -enum btrfs_raid_types __attribute_const__
>> btrfs_bg_flags_to_raid_index(u64 flags)
>> -{
>> -=C2=A0=C2=A0=C2=A0 if (flags & BTRFS_BLOCK_GROUP_RAID10)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_RAID10;
>> -=C2=A0=C2=A0=C2=A0 else if (flags & BTRFS_BLOCK_GROUP_RAID1)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_RAID1;
>> -=C2=A0=C2=A0=C2=A0 else if (flags & BTRFS_BLOCK_GROUP_RAID1C3)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_RAID1C3;
>> -=C2=A0=C2=A0=C2=A0 else if (flags & BTRFS_BLOCK_GROUP_RAID1C4)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_RAID1C4;
>> -=C2=A0=C2=A0=C2=A0 else if (flags & BTRFS_BLOCK_GROUP_DUP)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_DUP;
>> -=C2=A0=C2=A0=C2=A0 else if (flags & BTRFS_BLOCK_GROUP_RAID0)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_RAID0;
>> -=C2=A0=C2=A0=C2=A0 else if (flags & BTRFS_BLOCK_GROUP_RAID5)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_RAID5;
>> -=C2=A0=C2=A0=C2=A0 else if (flags & BTRFS_BLOCK_GROUP_RAID6)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_RAID6;
>> -
>> -=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SING=
LE */
>> -}
>> -
>> =C2=A0 const char *btrfs_bg_type_to_raid_name(u64 flags)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const int index =3D btrfs_bg_flags_to_ra=
id_index(flags);
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index e0c374a7c30b..7038c6cee39a 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -17,19 +17,42 @@ extern struct mutex uuid_mutex;
>> =C2=A0 #define BTRFS_STRIPE_LEN=C2=A0=C2=A0=C2=A0 SZ_64K
>> +/*
>> + * Here we use ilog2(BTRFS_BLOCK_GROUP_*) to convert the profile bits =
to
>> + * an index.
>> + * We reserve 0 for BTRFS_RAID_SINGLE, while the lowest profile,
>> ilog2(RAID0),
>> + * is 3, thus we need this shift to make all index numbers sequential.
>> + */
>> +#define BTRFS_RAID_SHIFT=C2=A0=C2=A0=C2=A0 (ilog2(BTRFS_BLOCK_GROUP_RA=
ID0) - 1)
>> +
>> =C2=A0 enum btrfs_raid_types {
>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID10,
>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID1,
>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_DUP,
>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID0,
>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_SINGLE,
>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID5,
>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID6,
>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID1C3,
>> -=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID1C4,
>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_SINGLE=C2=A0 =3D 0,
>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID0=C2=A0=C2=A0 =3D ilog2(BTRFS_BLOCK_=
GROUP_RAID0 >>
>> BTRFS_RAID_SHIFT),
>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID1=C2=A0=C2=A0 =3D ilog2(BTRFS_BLOCK_=
GROUP_RAID1 >>
>> BTRFS_RAID_SHIFT),
>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_DUP=C2=A0=C2=A0=C2=A0=C2=A0 =3D ilog2(BT=
RFS_BLOCK_GROUP_DUP >>
>> BTRFS_RAID_SHIFT),
>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID10=C2=A0 =3D ilog2(BTRFS_BLOCK_GROUP=
_RAID10 >>
>> BTRFS_RAID_SHIFT),
>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID5=C2=A0=C2=A0 =3D ilog2(BTRFS_BLOCK_=
GROUP_RAID5 >>
>> BTRFS_RAID_SHIFT),
>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID6=C2=A0=C2=A0 =3D ilog2(BTRFS_BLOCK_=
GROUP_RAID6 >>
>> BTRFS_RAID_SHIFT),
>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID1C3 =3D ilog2(BTRFS_BLOCK_GROUP_RAID=
1C3 >>
>> BTRFS_RAID_SHIFT),
>> +=C2=A0=C2=A0=C2=A0 BTRFS_RAID_RAID1C4 =3D ilog2(BTRFS_BLOCK_GROUP_RAID=
1C4 >>
>> BTRFS_RAID_SHIFT),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_NR_RAID_TYPES
>> =C2=A0 };
>
>
>> +/*
>> + * Convert block group flags (BTRFS_BLOCK_GROUP_*) to
>> btrfs_raid_types, which
>> + * can be used as index to access btrfs_raid_array[].
>> + */
>> +static inline enum btrfs_raid_types __attribute_const__
>> +btrfs_bg_flags_to_raid_index(u64 flags)
>> +{
>> +=C2=A0=C2=A0=C2=A0 u64 profile =3D flags & BTRFS_BLOCK_GROUP_PROFILE_M=
ASK;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!profile)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return BTRFS_RAID_SINGLE;
>> +
>> +=C2=A0=C2=A0=C2=A0 return ilog2(profile >> BTRFS_RAID_SHIFT);
>> +}
>> +
>> =C2=A0 struct btrfs_io_geometry {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* remaining bytes before crossing a str=
ipe */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 len;
>> @@ -646,7 +669,6 @@ void btrfs_scratch_superblocks(struct
>> btrfs_fs_info *fs_info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct block_device *b=
dev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *device_pat=
h);
>> -enum btrfs_raid_types __attribute_const__
>> btrfs_bg_flags_to_raid_index(u64 flags);
>> =C2=A0 int btrfs_bg_type_to_factor(u64 flags);
>> =C2=A0 const char *btrfs_bg_type_to_raid_name(u64 flags);
>> =C2=A0 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
>>
>
