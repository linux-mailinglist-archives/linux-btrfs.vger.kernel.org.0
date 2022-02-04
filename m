Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F07B4A9449
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 08:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348566AbiBDHIn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 02:08:43 -0500
Received: from mout.gmx.net ([212.227.15.19]:45381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348137AbiBDHIm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Feb 2022 02:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643958516;
        bh=81zUKicd/YFm5DpH895TMKcsYTQwp8HnXdkjyuQLSFo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=eMbb52jYY0uOP6XORHdqIE50T44FNnRQnwzgL6Ur2pzbI0Id8WH+MwuOkdEjwUuWF
         BO0Yr/JX0tw52QJxtcFnZbpQOtH+rrOBJGKE9mhjxxLrHlYqet1WTwfBs5RPdHQD38
         B+cn+hr0GP0HGS4Xp1xmy207owHvfy/U0ONicXPI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mt79P-1mMxju1PtR-00tXn8; Fri, 04
 Feb 2022 08:08:36 +0100
Message-ID: <f20aa7d5-c226-34c7-0712-402ee92802e3@gmx.com>
Date:   Fri, 4 Feb 2022 15:08:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 4/4] btrfs: defrag: allow defrag_one_cluster() to large
 extent which is not a target
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1643357469.git.wqu@suse.com>
 <fce83045d775e59ab8a6746e5ad09c474a0c90a2.1643357469.git.wqu@suse.com>
 <YfwTUlD3okcrD4Zw@debian9.Home>
 <26a4cefb-0cb9-c49b-0cea-880dff7a57a4@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <26a4cefb-0cb9-c49b-0cea-880dff7a57a4@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ALOmFyuSuV/RrbUKaRYxU7uy9WJsQD6oHam+3FRsTG6tf5tgdqu
 VxJzNxm8O/xOJj8yycMB9GFwmEZ3u+VvDyBadACdU3eIA10+t9uzvvTsrcnjDsgYoaaMTKO
 7z8IiA9P4VPemHYE2M9J0tdN3tkqSTxnz6fal7qHS7jNKm4Zm4h5pxDTJ4s1Z+pbitqj/mg
 sNpMElpgo16yofq3fViFQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RKzUGPW1Kxs=:hw7WFxjwgPxgZhXAFb2St0
 DR+h/YK1jthAqsaGJa0nJ91ba70kqE692SJkPYeK5P1nUIOfP01XqPUQljLNbN0/rCLUxXU3v
 AWJ2Osnc041UFzyc5AvEWJ/g8l1eXNoPlIl5YFmgp5cF1h5Xi1IIDlhTkcI7WzMXv+dRUjxuv
 XuS2c6z1SPvmw8appPUrKd79CRlNnjGjdCxPGZwMbR/rMC4A9fT9n2BTP3kJ+TEUOBcHilI37
 eLe0JvEnoWVEFBmPvk1BxeaCYcVvbHtDphqrwrAocfWv3tPQFTx7z3wFMu6KjFSwEav6343d3
 1qmrpsQif9dRSWyzV1aD2AyGNwnlNiaWhha2v1ITsVAMOTfwyXTTRPXACWQDtiEuM7jE7tzJc
 5snn1GSk+K2h7HNm8kv6n2iseRlogdqfDjgH0YjOTlaOMaH9v1u6udiSdaMSqebZlq7auQFGn
 lWTa5FgJO290umTC/CJ/wy83eg38uQMwct1wckGZzuy7mkWYE5I+ansWly6pCRawu5fK7XdRM
 HlzBR8IN7r/CXwDP3CqrRnhPmf4OX/jXKA7kWcl3F2r+X2+bDTD4uNbEj1DFUQt+T82r6ntYs
 2Mq8LoKXqNJHWNWdOnQivX4JIZ61JvNmTIsBjGWATM9gMo7bhCXMUZUlwi2te2az/3WiqYNAH
 7J7WWP6kHrZ1/QkBoX9iD9JYygxOUKErWNpDOSfHlfnrsz4xHX9LewJe+fwQVjH8Qb3wMFx3v
 JAwinEpuvjD+Ou3T2r58pIp2uQHjg54PNSatR6q7ymgnT97kUxPBPWobnXRiMImUwzlWvW3C/
 ICsE4TopCNrJyWWSDnb0oAc/pl82XlJruqdIauABwqtdivAiYEHzigJK9dSEK2SRmhYTssU9l
 ZsBu5Ml1U6TT2GR9Cu1vxicomMhQvX2ZU2nCXdw47Kh6BL9MyVkGKVOOG0kNH0NW+2ZEnmZ4t
 6ttQZa6fK0zdVrr+J7ts9KsP1rnYAs7NW3YjzjkreFC5pdH0c5cp5LgLCdWy306BxhavSqSsW
 ZFgX1rPP8bN03C+h7db/6Oai7C/6UXVVizapoE1ulCNE2mehgJy4b47b/VXCTP/PpYMoiyhhK
 JsS9U1zVLeckjk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/4 08:39, Qu Wenruo wrote:
>
>
> On 2022/2/4 01:39, Filipe Manana wrote:
>> On Fri, Jan 28, 2022 at 04:12:58PM +0800, Qu Wenruo wrote:
>>> In the rework of btrfs_defrag_file(), we always call
>>> defrag_one_cluster() and increase the offset by cluster size, which is
>>> only 256K.
>>>
>>> But there are cases where we have a large extent (e.g. 128M) which
>>> doesn't need to be defragged at all.
>>>
>>> Before the refactor, we can directly skip the range, but now we have t=
o
>>> scan that extent map again and again until the cluster moves after the
>>> non-target extent.
>>>
>>> Fix the problem by allow defrag_one_cluster() to increase
>>> btrfs_defrag_ctrl::last_scanned to the end of an extent, if and only i=
f
>>> the last extent of the cluster is not a target.
>>>
>>> The test script looks like this:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0mkfs.btrfs -f $dev > /dev/null
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0mount $dev $mnt
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0# As btrfs ioctl uses 32M as extent_threshold
>>> =C2=A0=C2=A0=C2=A0=C2=A0xfs_io -f -c "pwrite 0 64M" $mnt/file1
>>> =C2=A0=C2=A0=C2=A0=C2=A0sync
>>> =C2=A0=C2=A0=C2=A0=C2=A0# Some fragemented range to defrag
>>> =C2=A0=C2=A0=C2=A0=C2=A0xfs_io -s -c "pwrite 65548k 4k" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -c "pwrite 6554=
4k 4k" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -c "pwrite 6554=
0k 4k" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -c "pwrite 6553=
6k 4k" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $mnt/file1
>>> =C2=A0=C2=A0=C2=A0=C2=A0sync
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0echo "=3D=3D=3D before =3D=3D=3D"
>>> =C2=A0=C2=A0=C2=A0=C2=A0xfs_io -c "fiemap -v" $mnt/file1
>>> =C2=A0=C2=A0=C2=A0=C2=A0echo "=3D=3D=3D after =3D=3D=3D"
>>> =C2=A0=C2=A0=C2=A0=C2=A0btrfs fi defrag $mnt/file1
>>> =C2=A0=C2=A0=C2=A0=C2=A0sync
>>> =C2=A0=C2=A0=C2=A0=C2=A0xfs_io -c "fiemap -v" $mnt/file1
>>> =C2=A0=C2=A0=C2=A0=C2=A0umount $mnt
>>>
>>> With extra ftrace put into defrag_one_cluster(), before the patch it
>>> would result tons of loops:
>>>
>>> (As defrag_one_cluster() is inlined, the function name is its caller)
>>>
>>> =C2=A0=C2=A0 btrfs-126062=C2=A0 [005] .....=C2=A0 4682.816026: btrfs_d=
efrag_file:
>>> r/i=3D5/257 start=3D0 len=3D262144
>>> =C2=A0=C2=A0 btrfs-126062=C2=A0 [005] .....=C2=A0 4682.816027: btrfs_d=
efrag_file:
>>> r/i=3D5/257 start=3D262144 len=3D262144
>>> =C2=A0=C2=A0 btrfs-126062=C2=A0 [005] .....=C2=A0 4682.816028: btrfs_d=
efrag_file:
>>> r/i=3D5/257 start=3D524288 len=3D262144
>>> =C2=A0=C2=A0 btrfs-126062=C2=A0 [005] .....=C2=A0 4682.816028: btrfs_d=
efrag_file:
>>> r/i=3D5/257 start=3D786432 len=3D262144
>>> =C2=A0=C2=A0 btrfs-126062=C2=A0 [005] .....=C2=A0 4682.816028: btrfs_d=
efrag_file:
>>> r/i=3D5/257 start=3D1048576 len=3D262144
>>> =C2=A0=C2=A0 ...
>>> =C2=A0=C2=A0 btrfs-126062=C2=A0 [005] .....=C2=A0 4682.816043: btrfs_d=
efrag_file:
>>> r/i=3D5/257 start=3D67108864 len=3D262144
>>>
>>> But with this patch there will be just one loop, then directly to the
>>> end of the extent:
>>>
>>> =C2=A0=C2=A0 btrfs-130471=C2=A0 [014] .....=C2=A0 5434.029558: defrag_=
one_cluster:
>>> r/i=3D5/257 start=3D0 len=3D262144
>>> =C2=A0=C2=A0 btrfs-130471=C2=A0 [014] .....=C2=A0 5434.029559: defrag_=
one_cluster:
>>> r/i=3D5/257 start=3D67108864 len=3D16384
>>
>> Did you also measure how much time was spent before and after?
>> It would be interesting to have it here in case you have measured it.
>> If you don't have it, then it's fine.
>
> I don't have the exact time spent.
>
> But the trace contains the timestamp, and even with the old behavior,
> the time spent before defragging the last cluster is pretty tiny, only
> 17ns.

My bad, it's 17us, which is already somewhat time consuming...

>
>>
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> =C2=A0 fs/btrfs/ioctl.c | 26 +++++++++++++++++++++-----
>>> =C2=A0 1 file changed, 21 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>> index 67ba934be99e..592a542164a4 100644
>>> --- a/fs/btrfs/ioctl.c
>>> +++ b/fs/btrfs/ioctl.c
>>> @@ -1197,10 +1197,11 @@ struct defrag_target_range {
>>> =C2=A0=C2=A0 */
>>> =C2=A0 static int defrag_collect_targets(struct btrfs_inode *inode,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct btrfs_defrag_ct=
rl *ctrl,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 start, u32 len, bool locked,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head *target_list)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 start, u32 len, u64 *last_scanned_re=
t,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool locked, struct list_head *target_li=
st)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool do_compress =3D ctrl->flags & BTRF=
S_DEFRAG_RANGE_COMPRESS;
>>> +=C2=A0=C2=A0=C2=A0 bool last_target =3D false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 cur =3D start;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>
>>> @@ -1210,6 +1211,7 @@ static int defrag_collect_targets(struct
>>> btrfs_inode *inode,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool next_merge=
able =3D true;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 range_len;
>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_target =3D false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 em =3D defrag_l=
ookup_extent(&inode->vfs_inode, cur, locked);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!em)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>>> @@ -1259,6 +1261,7 @@ static int defrag_collect_targets(struct
>>> btrfs_inode *inode,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0 add:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_target =3D true;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 range_len =3D m=
in(extent_map_end(em), start + len) - cur;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This on=
e is a good target, check if it can be merged into
>>> @@ -1302,6 +1305,17 @@ static int defrag_collect_targets(struct
>>> btrfs_inode *inode,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 kfree(entry);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (!ret && last_scanned_ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the last extent=
 is not a target, the caller can skip to
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the end of that ex=
tent.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Otherwise, we can =
only go the end of the spcified range.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!last_target)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *l=
ast_scanned_ret =3D cur;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *l=
ast_scanned_ret =3D start + len;
>>
>> Might be just me, but I found the name "last_target" a bit harder to
>> decipher. Something like "last_is_target" seems more clear to me, as
>> it indicates if the last extent we found was a target for defrag.
>
> Indeed sounds better.
>
>>
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>>
>>> @@ -1405,7 +1419,7 @@ static int defrag_one_range(struct btrfs_inode
>>> *inode,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * And this time we have extent lo=
cked already, pass @locked =3D
>>> true
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * so that we won't relock the ext=
ent range and cause deadlock.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0 ret =3D defrag_collect_targets(inode, ctrl, start,=
 len, true,
>>> +=C2=A0=C2=A0=C2=A0 ret =3D defrag_collect_targets(inode, ctrl, start,=
 len, NULL, true,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &target_li=
st);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto unlock_ext=
ent;
>>> @@ -1448,6 +1462,7 @@ static int defrag_one_cluster(struct
>>> btrfs_inode *inode,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_defrag_ctrl *ct=
rl, u32 len)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const u32 sectorsize =3D inode->root->f=
s_info->sectorsize;
>>> +=C2=A0=C2=A0=C2=A0 u64 last_scanned;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct defrag_target_range *entry;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct defrag_target_range *tmp;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LIST_HEAD(target_list);
>>> @@ -1455,7 +1470,7 @@ static int defrag_one_cluster(struct
>>> btrfs_inode *inode,
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUILD_BUG_ON(!IS_ALIGNED(CLUSTER_SIZE, =
PAGE_SIZE));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D defrag_collect_targets(inode, c=
trl, ctrl->last_scanned, len,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false, &target_list);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &last_scanned, false, =
&target_list);
>>
>> So I would revert the logic here.
>> What I mean is, to pass a non-NULL pointer *last_scanned_ret to
>> defrag_collect_targets()
>> when it's called at defrag_one_range(), and then here, at
>> defrag_one_cluster(), pass it NULL
>> instead.
>
> The main reason to pass it to defrag_one_cluster() call site but not
> defrag_one_range() one is to reduce the parameter for defrag_one_range()=
.
>
>>
>> The reason is simple and I think makes more sense:
>>
>> 1) defrag_one_cluster() does a first call to defrag_collect_targets()
>> to scan
>> =C2=A0=C2=A0=C2=A0 for the extents maps in a range without locking the =
range in the
>> inode's
>> =C2=A0=C2=A0=C2=A0 iotree;
>>
>> 2) Then for each range it collects, we call defrag_one_range(). That wi=
ll
>> =C2=A0=C2=A0=C2=A0 lock the range in the io tree and then call again
>> defrag_collect_targets(),
>> =C2=A0=C2=A0=C2=A0 this time extent maps may have changed (due to concu=
rrent mmap
>> writes, etc).
>> =C2=A0=C2=A0=C2=A0 So it's this second time that we can have an accurat=
e value for
>> =C2=A0=C2=A0=C2=A0 *last_scanned_ret
>
> One of the design is to not use so accurate values for accounting
> (again, to pass less parameters down the chain), thus things like
> btrfs_defrag_ctrl::sectors_defragged is not that accurate.
>
> But since you mentioned, I guess I can update them to the most accurate
> accounting, especially after the btrfs_defrag_ctrl refactor, there is
> already less parameters to pass around.
>
> Thanks,
> Qu
>
>>
>> That would deal with the case where first pass considered a range for
>> defrag, but then in the second pass we skipped a subrange because in th=
e
>> meanwhile, before we locked the range in the io tree, it got a large
>> extent.
>>
>> Thanks.
>>
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>
>>> @@ -1496,6 +1511,8 @@ static int defrag_one_cluster(struct
>>> btrfs_inode *inode,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del_init(&=
entry->list);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(entry);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (!ret)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctrl->last_scanned =3D las=
t_scanned;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>>
>>> @@ -1624,7 +1641,6 @@ int btrfs_defrag_file(struct inode *inode,
>>> struct file_ra_state *ra,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_inode_unl=
ock(inode, 0);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctrl->last_scanned =3D clu=
ster_end + 1;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret > 0) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ret =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>>> --
>>> 2.34.1
>>>
