Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796C749CA3B
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 14:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbiAZNA2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 08:00:28 -0500
Received: from mout.gmx.net ([212.227.17.22]:37107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234659AbiAZNA2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 08:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643202021;
        bh=LkKCcFPEVKXQagmB6poy3rp63gWjWdF/S9iR4FMT+dU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=GMcQOUGB1HifHIKy1dN2oc42epk6QXazZ03RwUmvWg9TH1RR6CHDrW/SQNqEjhjCC
         JNoTjiDRp11KBZe0A7bsofuNWJ2X92rLX9yOYOBDX38p4iRRCPxN/G3jmBfULJLNU8
         qRvxssX2kUh0vVI5aWX19moRzxvPwfT8QRlRULuc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfHEJ-1mbkT93THX-00gmB5; Wed, 26
 Jan 2022 14:00:21 +0100
Message-ID: <dc25f2ec-1afc-8cb4-8a01-6416602d45a4@gmx.com>
Date:   Wed, 26 Jan 2022 21:00:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] btrfs: defrag: use extent_thresh to replace the
 hardcoded size limit
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20220126005850.14729-1-wqu@suse.com>
 <20220126005850.14729-2-wqu@suse.com> <YfEzNCybtrSufSvu@debian9.Home>
 <7e0ba10b-04f0-d7d4-1da0-01f455b2d55e@suse.com>
 <CAL3q7H4RJTxZ-SebRPhyQRPUUaSr0fHvaTm1o1qu18wTuKYOZg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H4RJTxZ-SebRPhyQRPUUaSr0fHvaTm1o1qu18wTuKYOZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QJVkWtKl3R4FnIYdOZz8tseXkNHRsFO9hrcTUcaI1HfQZQUs8L4
 Vpw+vBLSM+hOWu5YT3cXUm18+xKhZT+deE+EMmG9Uh2MtzKch0UnzL6cUKd2NrlHq0/DKcm
 JGsy0LkukZ2XjeZzpvh8ir/+SqzfCF45VjickzYi5p6xN7WKlCYWLX0NlotDFRPY70LOe3k
 00cGtpSvWKZEt2odCEAWA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H2sqJpDEnag=:FB6p2II6qF8MtBRwUjNl4k
 Ym0YHe3g3KmQ7sy2PnqDZ0pFxfP0516Ms1Ohr+SGB6PPyl/hRNwzsLUkFJBOI+6qqrgfQBIGK
 08pC6Qqfz+cJpqSZoviJxs30xe8CNnPBrEVGf1EMBM1LuWAmOvqEZ4TYT4TLyBPjfOeBJDjHl
 mtR+3O0NYdKhZuSbh/YVQzNK44sAZTlTVRCbcXnqBBdD3B95lWx39+PKPViE+mFMhrTFSgnzq
 /JEZMQiuVjiNLX1v2Jds5VBMsj7/QxHqPFq5gomDXpE4be4l5uHuj6vOHLmBuWJyvU1Hri7Ko
 sXtaQhtLLj/0XC3NdG11tpvnV0lsvATsrZVMt1JHGDnrZdgKgmiAgq5WSfZJHRaWT7t5WyXxC
 ATH1LMVkwy4Cfn+0N9GLY3xwz8nvxRs8Vn2FbzrmBBalvHavS5WiEMOO0X2nQ4PeCpPb3rfzO
 YnKDjJDi9zYrieYaElxWCUf3KsEPHa/JuQ8TqmA1Zm9PPHv4hgqZms9t9K+5BprAsNGYY9fRW
 b++TF/2QNkCZNrOmWTykbpqL6wxc3PDa18c8W/INPy1uPuGN7J4LMXme1PGMXBmW1qsgS9xq/
 yPiaMqsW11iH2mitpQhD3cu5ID3IJtmyWWhC1+yeSJXdy6Ruex8K15TEgtLKDcR5SYgiSJOQZ
 pxcmkbxJj4Re+bciYw3+st9EpVXgvpL55/b4zia4c4IIJwmhBi2HwxyBD8ZGWTi6o1AbUY/qJ
 wblUVZSBNPVBO915Rc6jUz92SVDkp04Owvdpw6oAv0h8zrrf5puNe5SQWdMhjcTLmRGqXf62h
 MUSyDXuDGh9YV5sbwsQSHOHfLIOaPElBB059jyicUoNUo0GupQHAx7iKsm7lPVBjtKbUforsx
 ZVu5l5MSdPaeL40HR+TKEkTeU+muZjxTsg57/gbkGCzdVOr37wyfFu/KuCVcAP/vMPAOqQyxD
 xBADcbN20PgtxXPvq2RYoTVoSOtJCfRsZQ2B1RmugOS8qHCnFTP0YPcQ0RQbPIpk+taOdmmy5
 xeJ4+Sjrw3KOwJ7TmqyGeYdoqgb0sldaEYKuCowr26+OPeHgRfMX1an3F+Qv9cXo/RF6sduC6
 R4pC0x3pSpy6i5Y7puGKU1vCIkgQ/ygzANvi2tQthmeWTGFCfatMmm5tA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/26 20:36, Filipe Manana wrote:
> On Wed, Jan 26, 2022 at 12:26 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> On 2022/1/26 19:40, Filipe Manana wrote:
>>> On Wed, Jan 26, 2022 at 08:58:49AM +0800, Qu Wenruo wrote:
>>>> In defrag_lookup_extent() we use hardcoded extent size threshold, SZ_=
128K,
>>>> other than @extent_thresh in btrfs_defrag_file().
>>>>
>>>> This can lead to some inconsistent behavior, especially the default
>>>> extent size threshold is 256K.
>>>>
>>>> Fix this by passing @extent_thresh into defrag_check_next_extent() an=
d
>>>> use that value.
>>>>
>>>> Also, since the extent_thresh check should be applied to all extents,
>>>> not only physically adjacent extents, move the threshold check into a
>>>> dedicate if ().
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    fs/btrfs/ioctl.c | 12 +++++++-----
>>>>    1 file changed, 7 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>> index 0d8bfc716e6b..2911df12fc48 100644
>>>> --- a/fs/btrfs/ioctl.c
>>>> +++ b/fs/btrfs/ioctl.c
>>>> @@ -1050,7 +1050,7 @@ static struct extent_map *defrag_lookup_extent(=
struct inode *inode, u64 start,
>>>>    }
>>>>
>>>>    static bool defrag_check_next_extent(struct inode *inode, struct e=
xtent_map *em,
>>>> -                                 bool locked)
>>>> +                                 u32 extent_thresh, bool locked)
>>>>    {
>>>>       struct extent_map *next;
>>>>       bool ret =3D false;
>>>> @@ -1066,9 +1066,11 @@ static bool defrag_check_next_extent(struct in=
ode *inode, struct extent_map *em,
>>>>       /* Preallocated */
>>>>       if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
>>>>               goto out;
>>>> -    /* Physically adjacent and large enough */
>>>> -    if ((em->block_start + em->block_len =3D=3D next->block_start) &=
&
>>>> -        (em->block_len > SZ_128K && next->block_len > SZ_128K))
>>>> +    /* Extent is already large enough */
>>>> +    if (next->len >=3D extent_thresh)
>>>> +            goto out;
>>>
>>> So this will trigger unnecessary rewrites of compressed extents.
>>> The SZ_128K is there to deal with compressed extents, it has nothing t=
o
>>> do with the threshold passed to the ioctl.
>>
>> Then there is still something wrong.
>>
>> The original check will only reject it when both conditions are met.
>>
>> So based on your script, I can still find a way to defrag the extents,
>> with or without this modification:
>
> Right, without the intermediary write to file "baz", this patchset
> brings a regression in regards to
> compressed extents - when they are adjacent, which is typically the
> case when doing large writes,
> as they'll create multiple extents covering consecutive 128K ranges.
>
> With the write to file "baz", as I pasted it, it happens before and
> after the patchset.
>
>>
>>          mkfs.btrfs -f $DEV
>>          mount -o compress $DEV $MNT
>>
>>          xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/file1
>>          sync
>>          xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/file2
>>          sync
>>          xfs_io -f -c "pwrite -S 0xab 128K 128K" $MNT/file1
>>          sync
>>
>>          echo "=3D=3D=3D file1 before defrag =3D=3D=3D"
>>          xfs_io -f -c "fiemap -v" $MNT/file1
>>          echo "=3D=3D=3D file1 after defrag =3D=3D=3D"
>>          btrfs fi defrag $MNT/file1
>>          sync
>>          xfs_io -f -c "fiemap -v" $MNT/file1
>>
>> The output looks like this:
>>
>> =3D=3D=3D before =3D=3D=3D
>> /mnt/btrfs/file1:
>>    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>>      0: [0..255]:        26624..26879       256   0x8
>>      1: [256..511]:      26640..26895       256   0x9
>> =3D=3D=3D after =3D=3D=3D
>> /mnt/btrfs/file1:
>>    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>>      0: [0..255]:        26648..26903       256   0x8
>>      1: [256..511]:      26656..26911       256   0x9
>>
>> No matter if the patch is applied, the result is the same.
>
> Yes, explained above.
>
>>
>> So thank you very much for finding another case we're not handling well=
...
>>
>>
>> BTW, if the check is want to reject adjacent non-compressed extent, the
>> original one is still incorrect, we can have extents smaller than 128K
>> and is still uncompressed.
>>
>> So what we really want is to reject physically adjacent, non-compressed
>> extents?
>
> We want to avoid doing work that does nothing.
> If 2 consecutive extents are compressed and at least one is already
> 128K, then it's a waste of time, IO and CPU.

So can we define the behavior like this?

  If the extent is already at its max capacity (compressed 128K,
   non-compressed 128M), we don't defrag it.

This also means, we need to do the same check in
defrag_collect_targets() to avoid defragging such extent.

Thanks,
Qu


>
> And that's a fairly common scenario. Do a one megabyte write for
> example, then after writeback we end up with several 128K extents with
> compression.
> In that case defrag should do nothing for the whole range.
>
>
>>
>> Thanks,
>> Qu
>>>
>>> After applying this patchset, if you run a trivial test like this:
>>>
>>>      #!/bin/bash
>>>
>>>      DEV=3D/dev/sdj
>>>      MNT=3D/mnt/sdj
>>>
>>>      mkfs.btrfs -f $DEV
>>>      mount -o compress $DEV $MNT
>>>
>>>      xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/foobar
>>>      sync
>>>      # Write to some other file so that the next extent for foobar
>>>      # is not contiguous with the first extent.
>>>      xfs_io -f -c "pwrite 0 128K" $MNT/baz
>>>      sync
>>>      xfs_io -f -c "pwrite -S 0xcd 128K 128K" $MNT/foobar
>>>      sync
>>>
>>>      echo -e "\n\nTree after creating file:\n\n"
>>>      btrfs inspect-internal dump-tree -t 5 $DEV
>>>
>>>      btrfs filesystem defragment $MNT/foobar
>>>      sync
>>>
>>>      echo -e "\n\nTree after defrag:\n\n"
>>>      btrfs inspect-internal dump-tree -t 5 $DEV
>>>
>>>      umount $MNT
>>>
>>> It will result in rewriting the two 128K compressed extents:
>>>
>>> (...)
>>> Tree after write and sync:
>>>
>>> btrfs-progs v5.12.1
>>> fs tree key (FS_TREE ROOT_ITEM 0)
>>> (...)
>>>        item 7 key (257 INODE_REF 256) itemoff 15797 itemsize 16
>>>                index 2 namelen 6 name: foobar
>>>        item 8 key (257 EXTENT_DATA 0) itemoff 15744 itemsize 53
>>>                generation 6 type 1 (regular)
>>>                extent data disk byte 13631488 nr 4096
>>>                extent data offset 0 nr 131072 ram 131072
>>>                extent compression 1 (zlib)
>>>        item 9 key (257 EXTENT_DATA 131072) itemoff 15691 itemsize 53
>>>                generation 8 type 1 (regular)
>>>                extent data disk byte 14163968 nr 4096
>>>                extent data offset 0 nr 131072 ram 131072
>>>                extent compression 1 (zlib)
>>> (...)
>>>
>>> Tree after defrag:
>>>
>>> btrfs-progs v5.12.1
>>> fs tree key (FS_TREE ROOT_ITEM 0)
>>> (...)
>>>        item 7 key (257 INODE_REF 256) itemoff 15797 itemsize 16
>>>                index 2 namelen 6 name: foobar
>>>        item 8 key (257 EXTENT_DATA 0) itemoff 15744 itemsize 53
>>>                generation 9 type 1 (regular)
>>>                extent data disk byte 14430208 nr 4096
>>>                extent data offset 0 nr 131072 ram 131072
>>>                extent compression 1 (zlib)
>>>        item 9 key (257 EXTENT_DATA 131072) itemoff 15691 itemsize 53
>>>                generation 9 type 1 (regular)
>>>                extent data disk byte 13635584 nr 4096
>>>                extent data offset 0 nr 131072 ram 131072
>>>                extent compression 1 (zlib)
>>>
>>> In other words, a waste of IO and CPU time.
>>>
>>> So it needs to check if we are dealing with compressed extents, and
>>> if so, skip either of them has a size of SZ_128K (and changelog update=
d).
>>>
>>> Thanks.
>>>
>>>> +    /* Physically adjacent */
>>>> +    if ((em->block_start + em->block_len =3D=3D next->block_start))
>>>>               goto out;
>>>>       ret =3D true;
>>>>    out:
>>>> @@ -1231,7 +1233,7 @@ static int defrag_collect_targets(struct btrfs_=
inode *inode,
>>>>                       goto next;
>>>>
>>>>               next_mergeable =3D defrag_check_next_extent(&inode->vfs=
_inode, em,
>>>> -                                                      locked);
>>>> +                                                      extent_thresh,=
 locked);
>>>>               if (!next_mergeable) {
>>>>                       struct defrag_target_range *last;
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>>
>>
