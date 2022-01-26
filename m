Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E50449D66F
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 00:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbiAZX5q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 18:57:46 -0500
Received: from mout.gmx.net ([212.227.17.22]:53723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232270AbiAZX5n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 18:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643241456;
        bh=ixT7rgId1g+lRFCWrSO4k73IH45JcsphHQ1IpGajOhU=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=hjUP1a0NoIG6jQ3LL1/IzgScDhPOnvieX4GMt+pU9FdEkJt1crOUGDebIt4fiG8Er
         sadyE7saAyPu7bqqW3I2OoEo39N11vP/RXjQFW13fnME90/tPh/9wdaq6Y5eOUH10h
         K5+SSL+xCKFcVtQpInox7li/2JIf6H4Ou4qszM0I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfHAB-1mbaD61TTf-00glJc; Thu, 27
 Jan 2022 00:57:36 +0100
Message-ID: <23a2d582-16ce-61f6-60a7-87389e03df40@gmx.com>
Date:   Thu, 27 Jan 2022 07:57:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20220126005850.14729-1-wqu@suse.com>
 <20220126005850.14729-2-wqu@suse.com> <YfEzNCybtrSufSvu@debian9.Home>
 <7e0ba10b-04f0-d7d4-1da0-01f455b2d55e@suse.com>
 <CAL3q7H4RJTxZ-SebRPhyQRPUUaSr0fHvaTm1o1qu18wTuKYOZg@mail.gmail.com>
 <dc25f2ec-1afc-8cb4-8a01-6416602d45a4@gmx.com>
 <CAL3q7H7mnWnYsYM2t8tTpjS7jwJejN9t2HfSHxNjX2G89mfEDQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 2/3] btrfs: defrag: use extent_thresh to replace the
 hardcoded size limit
In-Reply-To: <CAL3q7H7mnWnYsYM2t8tTpjS7jwJejN9t2HfSHxNjX2G89mfEDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tzTKIUiH0NlpT+aM+4WSmcYwZkwjW0WxLRocIVyB4xBAnQ/bC7Q
 MOIHd0XfhR1x3IFPCadq7B+NM/LC7AfafMANzCKiaUSaLMyJgyaGWG91LlhzFPez5I4m9+B
 iuOYQ4fNaVS/+zn0Bq7cIQl7bVI8UIeFo4zLq7SG76hakWFiLn8+oyU2wpcp1IfPnjGUbdJ
 5OY9v7YHTOghYg38jA7yA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ufimJXbHtTA=:V1jDSWOyGAKdHvtRLaqnEC
 RA3vhu5VOC/Xe4MlLZJjXC0udghiWvLuw7zvVs76+VhI254YaWJtBRVEMidCshtI9jPB49FTT
 MkzceP7Df682KkPr4LSD7NtmzvpeIoHq+SHtsFBAq2EVKLv7wF7/OF5uQVUVrFtoyxUsBwwQj
 jVeN/4Fys4d+8WNl8SqwR54te/sjltqoNbvN1hztWJFCjxCn0Opc4h1j7aQZ4JRXhNlNcCh3W
 AY+EHvh0FO9aVtqCYqu1bycZKAPJJyGLtrQv5Kgmn9QKMtFUE2QxFfCVKcSQzVCUEoOXFItuO
 gcV3IMVpr0svrJeLMXqJv37Vz8dJGG7b1O/yJ3Uw2q5EUNirV0HuzsjqkhmC/UwHabeM/RsTu
 yKyPgdEOIE5ufyrD1o58RbC1Lp19EH604pDZIV6tKYfH940C4crlUtEqirNeSdwyM+UsMFixf
 j6BtVHwmW3n2StiX60BTURolyyCeSuwVjNrQ8X5cqgbH3fSCTfhpkZPxrjheuomWIDek56Ypz
 KiU1+aqLp21i02ko4RuYTW+GU+uvSne+0jUKy079hRJMIMvJBtPxd2hpNVZ98kMvK8179UAWl
 Ku0a36VSk1lMNBpdNh0C3aPNtdJkDE3eyesKC+4lBWrLVATQ2xRu1Bo1DEHnHaJu0f149s4bg
 HdtEU+rGF1PYO6h72YcxwIKBBbxQhATVkMn4bajpJOout05Ot2V2gsRoe948x2Fi87bRbquqS
 FaFpE5k79IAiZ0DGQWA+xo5hT8QBNdYleD/Oq5VoMvaNX+A7b3B00Tqu0XuAt+0cpoA9PT+RV
 zZGGsumCUA+zbt12t9TxV5qmFTzD2uihixs2lDxB5ryVsgAoiEmCGj8GC1toNP+h2k593bYjV
 pCLHFFMYuk+sK7BX6UJK2cz6v0KVTsgCgnn17C/zzjxUh+WIqq2c/2yEzzWagnOHTV7yR/cjK
 R+rc3+JDaI+O1XQ4La3x4J7AaNExlwQbEX0BLzVbx2wkyPrcTYW3oDePpUU5lLRRqWEhUirxc
 mNK/EBfwE9Q3mUtB0kcKhP03Pu657ZVeUD1Rhv5Z5MDhMP4SdXl456E/EzFuEibyNO0sG6TUl
 51AFuN28rRkrsk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/26 21:37, Filipe Manana wrote:
> On Wed, Jan 26, 2022 at 1:00 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2022/1/26 20:36, Filipe Manana wrote:
>>> On Wed, Jan 26, 2022 at 12:26 PM Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2022/1/26 19:40, Filipe Manana wrote:
>>>>> On Wed, Jan 26, 2022 at 08:58:49AM +0800, Qu Wenruo wrote:
>>>>>> In defrag_lookup_extent() we use hardcoded extent size threshold, S=
Z_128K,
>>>>>> other than @extent_thresh in btrfs_defrag_file().
>>>>>>
>>>>>> This can lead to some inconsistent behavior, especially the default
>>>>>> extent size threshold is 256K.
>>>>>>
>>>>>> Fix this by passing @extent_thresh into defrag_check_next_extent() =
and
>>>>>> use that value.
>>>>>>
>>>>>> Also, since the extent_thresh check should be applied to all extent=
s,
>>>>>> not only physically adjacent extents, move the threshold check into=
 a
>>>>>> dedicate if ().
>>>>>>
>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>> ---
>>>>>>     fs/btrfs/ioctl.c | 12 +++++++-----
>>>>>>     1 file changed, 7 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>>>> index 0d8bfc716e6b..2911df12fc48 100644
>>>>>> --- a/fs/btrfs/ioctl.c
>>>>>> +++ b/fs/btrfs/ioctl.c
>>>>>> @@ -1050,7 +1050,7 @@ static struct extent_map *defrag_lookup_exten=
t(struct inode *inode, u64 start,
>>>>>>     }
>>>>>>
>>>>>>     static bool defrag_check_next_extent(struct inode *inode, struc=
t extent_map *em,
>>>>>> -                                 bool locked)
>>>>>> +                                 u32 extent_thresh, bool locked)
>>>>>>     {
>>>>>>        struct extent_map *next;
>>>>>>        bool ret =3D false;
>>>>>> @@ -1066,9 +1066,11 @@ static bool defrag_check_next_extent(struct =
inode *inode, struct extent_map *em,
>>>>>>        /* Preallocated */
>>>>>>        if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
>>>>>>                goto out;
>>>>>> -    /* Physically adjacent and large enough */
>>>>>> -    if ((em->block_start + em->block_len =3D=3D next->block_start)=
 &&
>>>>>> -        (em->block_len > SZ_128K && next->block_len > SZ_128K))
>>>>>> +    /* Extent is already large enough */
>>>>>> +    if (next->len >=3D extent_thresh)
>>>>>> +            goto out;
>>>>>
>>>>> So this will trigger unnecessary rewrites of compressed extents.
>>>>> The SZ_128K is there to deal with compressed extents, it has nothing=
 to
>>>>> do with the threshold passed to the ioctl.
>>>>
>>>> Then there is still something wrong.
>>>>
>>>> The original check will only reject it when both conditions are met.
>>>>
>>>> So based on your script, I can still find a way to defrag the extents=
,
>>>> with or without this modification:
>>>
>>> Right, without the intermediary write to file "baz", this patchset
>>> brings a regression in regards to
>>> compressed extents - when they are adjacent, which is typically the
>>> case when doing large writes,
>>> as they'll create multiple extents covering consecutive 128K ranges.
>>>
>>> With the write to file "baz", as I pasted it, it happens before and
>>> after the patchset.
>>>
>>>>
>>>>           mkfs.btrfs -f $DEV
>>>>           mount -o compress $DEV $MNT
>>>>
>>>>           xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/file1
>>>>           sync
>>>>           xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/file2
>>>>           sync
>>>>           xfs_io -f -c "pwrite -S 0xab 128K 128K" $MNT/file1
>>>>           sync
>>>>
>>>>           echo "=3D=3D=3D file1 before defrag =3D=3D=3D"
>>>>           xfs_io -f -c "fiemap -v" $MNT/file1
>>>>           echo "=3D=3D=3D file1 after defrag =3D=3D=3D"
>>>>           btrfs fi defrag $MNT/file1
>>>>           sync
>>>>           xfs_io -f -c "fiemap -v" $MNT/file1
>>>>
>>>> The output looks like this:
>>>>
>>>> =3D=3D=3D before =3D=3D=3D
>>>> /mnt/btrfs/file1:
>>>>     EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>>>>       0: [0..255]:        26624..26879       256   0x8
>>>>       1: [256..511]:      26640..26895       256   0x9
>>>> =3D=3D=3D after =3D=3D=3D
>>>> /mnt/btrfs/file1:
>>>>     EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>>>>       0: [0..255]:        26648..26903       256   0x8
>>>>       1: [256..511]:      26656..26911       256   0x9
>>>>
>>>> No matter if the patch is applied, the result is the same.
>>>
>>> Yes, explained above.
>>>
>>>>
>>>> So thank you very much for finding another case we're not handling we=
ll...
>>>>
>>>>
>>>> BTW, if the check is want to reject adjacent non-compressed extent, t=
he
>>>> original one is still incorrect, we can have extents smaller than 128=
K
>>>> and is still uncompressed.
>>>>
>>>> So what we really want is to reject physically adjacent, non-compress=
ed
>>>> extents?
>>>
>>> We want to avoid doing work that does nothing.
>>> If 2 consecutive extents are compressed and at least one is already
>>> 128K, then it's a waste of time, IO and CPU.
>>
>> So can we define the behavior like this?
>>
>>    If the extent is already at its max capacity (compressed 128K,
>>     non-compressed 128M), we don't defrag it.
>
> My previous suggestion was: if one of the extents is compressed and
> its size is 128K, don't include it for defrag.

Yep, your previous one can handling it well, I'd just want to add the
similar check for uncompressed one (which may be too rare to hit though)

>
> There's probably other cases to think about: 1 compressed extent
> representing 100K of data, followed by another compressed extent
> representing 64K of data for example.
> In that case using both for defrag will still result in 2 extents, 1
> for 128K of data and another for 36K of data - still not worth it to
> defrag them, we end up with 2 extents, just different sizes.

Yes, that's also a factor to consider.

And with the target list we can determine how many compressed extents it
would result.
The missing piece is the number of the original extents.

I think this would be a target for later optimization.

>
> At the very least we should not regress on what we did not defrag before=
:
>
> 2 extents with physically contiguous ranges, representing 128K of data
> each, both compressed.

Although the original code is not really working as it's doing block_len
 > SZ_128K, while our maximum compressed extent size is exactly 128K.

I'll fix the problem first with better check and comments.

Thanks,
Qu

>
> Which is a very common case.
>
> Thanks.
>
>>
>> This also means, we need to do the same check in
>> defrag_collect_targets() to avoid defragging such extent.
>>
>> Thanks,
>> Qu
>>
>>
>>>
>>> And that's a fairly common scenario. Do a one megabyte write for
>>> example, then after writeback we end up with several 128K extents with
>>> compression.
>>> In that case defrag should do nothing for the whole range.
>>>
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> After applying this patchset, if you run a trivial test like this:
>>>>>
>>>>>       #!/bin/bash
>>>>>
>>>>>       DEV=3D/dev/sdj
>>>>>       MNT=3D/mnt/sdj
>>>>>
>>>>>       mkfs.btrfs -f $DEV
>>>>>       mount -o compress $DEV $MNT
>>>>>
>>>>>       xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/foobar
>>>>>       sync
>>>>>       # Write to some other file so that the next extent for foobar
>>>>>       # is not contiguous with the first extent.
>>>>>       xfs_io -f -c "pwrite 0 128K" $MNT/baz
>>>>>       sync
>>>>>       xfs_io -f -c "pwrite -S 0xcd 128K 128K" $MNT/foobar
>>>>>       sync
>>>>>
>>>>>       echo -e "\n\nTree after creating file:\n\n"
>>>>>       btrfs inspect-internal dump-tree -t 5 $DEV
>>>>>
>>>>>       btrfs filesystem defragment $MNT/foobar
>>>>>       sync
>>>>>
>>>>>       echo -e "\n\nTree after defrag:\n\n"
>>>>>       btrfs inspect-internal dump-tree -t 5 $DEV
>>>>>
>>>>>       umount $MNT
>>>>>
>>>>> It will result in rewriting the two 128K compressed extents:
>>>>>
>>>>> (...)
>>>>> Tree after write and sync:
>>>>>
>>>>> btrfs-progs v5.12.1
>>>>> fs tree key (FS_TREE ROOT_ITEM 0)
>>>>> (...)
>>>>>         item 7 key (257 INODE_REF 256) itemoff 15797 itemsize 16
>>>>>                 index 2 namelen 6 name: foobar
>>>>>         item 8 key (257 EXTENT_DATA 0) itemoff 15744 itemsize 53
>>>>>                 generation 6 type 1 (regular)
>>>>>                 extent data disk byte 13631488 nr 4096
>>>>>                 extent data offset 0 nr 131072 ram 131072
>>>>>                 extent compression 1 (zlib)
>>>>>         item 9 key (257 EXTENT_DATA 131072) itemoff 15691 itemsize 5=
3
>>>>>                 generation 8 type 1 (regular)
>>>>>                 extent data disk byte 14163968 nr 4096
>>>>>                 extent data offset 0 nr 131072 ram 131072
>>>>>                 extent compression 1 (zlib)
>>>>> (...)
>>>>>
>>>>> Tree after defrag:
>>>>>
>>>>> btrfs-progs v5.12.1
>>>>> fs tree key (FS_TREE ROOT_ITEM 0)
>>>>> (...)
>>>>>         item 7 key (257 INODE_REF 256) itemoff 15797 itemsize 16
>>>>>                 index 2 namelen 6 name: foobar
>>>>>         item 8 key (257 EXTENT_DATA 0) itemoff 15744 itemsize 53
>>>>>                 generation 9 type 1 (regular)
>>>>>                 extent data disk byte 14430208 nr 4096
>>>>>                 extent data offset 0 nr 131072 ram 131072
>>>>>                 extent compression 1 (zlib)
>>>>>         item 9 key (257 EXTENT_DATA 131072) itemoff 15691 itemsize 5=
3
>>>>>                 generation 9 type 1 (regular)
>>>>>                 extent data disk byte 13635584 nr 4096
>>>>>                 extent data offset 0 nr 131072 ram 131072
>>>>>                 extent compression 1 (zlib)
>>>>>
>>>>> In other words, a waste of IO and CPU time.
>>>>>
>>>>> So it needs to check if we are dealing with compressed extents, and
>>>>> if so, skip either of them has a size of SZ_128K (and changelog upda=
ted).
>>>>>
>>>>> Thanks.
>>>>>
>>>>>> +    /* Physically adjacent */
>>>>>> +    if ((em->block_start + em->block_len =3D=3D next->block_start)=
)
>>>>>>                goto out;
>>>>>>        ret =3D true;
>>>>>>     out:
>>>>>> @@ -1231,7 +1233,7 @@ static int defrag_collect_targets(struct btrf=
s_inode *inode,
>>>>>>                        goto next;
>>>>>>
>>>>>>                next_mergeable =3D defrag_check_next_extent(&inode->=
vfs_inode, em,
>>>>>> -                                                      locked);
>>>>>> +                                                      extent_thres=
h, locked);
>>>>>>                if (!next_mergeable) {
>>>>>>                        struct defrag_target_range *last;
>>>>>>
>>>>>> --
>>>>>> 2.34.1
>>>>>>
>>>>>
>>>>
