Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE5115E8F
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 09:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfEGHta (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 03:49:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:59298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726249AbfEGHta (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 May 2019 03:49:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D22CAE4B;
        Tue,  7 May 2019 07:49:29 +0000 (UTC)
Subject: Re: [PATCH RFC] btrfs: reflink: Flush before reflink any extent to
 prevent NOCOW write falling back to CoW without data reservation
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190503010852.10342-1-wqu@suse.com>
 <CAL3q7H5uLiPzCQpLdM=4yjz+fA-mQAe_XP1=5fHQ83dyBwcK5w@mail.gmail.com>
 <1e36e9e2-dbd3-3ab0-b908-25cfdf1d310d@gmx.com>
 <CAL3q7H4xp9=Kw3Q1hoDz_2Tbek4NdaULhJX4s7wmUqmku=ex0A@mail.gmail.com>
 <d3e1b3dd-60da-bd6f-24b7-7cda8fde6ac2@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a5b4c1a5-a76a-4412-4f42-677ef2676e62@suse.com>
Date:   Tue, 7 May 2019 10:49:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d3e1b3dd-60da-bd6f-24b7-7cda8fde6ac2@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6.05.19 г. 5:04 ч., Qu Wenruo wrote:
> [snip]
>>>
>>> For data writeback, it should only cause sync related failure.
>>
>> Ok, so please remove the transaction abort comments for next iteration.
>> By sync related failure, you mean running dealloc fails with ENOSPC,
>> since when it tries to reserve a data extent it fails as it can't find
>> any free extent.
> 
> Well, btrfs has some hidden way to fix such problem by itself already.
> 
> At buffered write time, we have the following call chain:
> btrfs_buffered_write()
> |- btrfs_check_data_free_space()
>    |- btrfs_alloc_data_chunk_ondemand()
>       |- need_commit = 2; /* We have 2 chance to retry, 1 to flush */
>       |- do_chunk_alloc() /* we have no data space available */
>       |- if (ret < 0 && ret == -ENOSPC)
>       |-     goto commit_trans;  /* try to free some space */
>       |- commit_trans:
>       |-     need_commit--;
>       |-     if (need_commit > 0) {
>       |-         btrfs_start_delalloc_roots();
>       |-         btrfs_wait_ordered_roots();
>       |-     }
> 
> This means, as long as we hit ENOSPC for data space, we will start write
> back, thus NODATACOW data will still hit disk as NODATACOW.

I'm lost for words at expressing how subtle and despicable that code is
... Is there a way to factor that out and make it more explicit ? I
don't think we should rely on such subtleties...

> 
> Such hidden behavior along with always-reserve-data-space solves the
> problem pretty well.
> We either:
> - reserve data space
>   Then no matter how it ends, we're OK, although it may end as CoW.
> 
> - Failed to reserve data space
>   Writeback will be triggered anyway, no way to screw things around.
> 
> Thus this workaround has nothing to fix, but only make certain NODATACOW
> reach disk as NODATACOW.
> 
> It makes some NODATACOW behaves more correctly but won't fix any obvious
> bug.
> 
> My personal take is to fix any strange behavior even it won't cause any
> problem, but the full inode writeback can be performance heavy.
> 
> So my question is, do we really need this anyway?
> 
> Thanks,
> Qu
> 
>>
>>>
>>>> I don't recall starting transactions when running dealloc, and failed
>>>> to see where after a quick glance to cow_file_range()
>>>> and run_delalloc_nocow(). I'm assuming that 'at delalloc time' means
>>>> when starting writeback.
>>>>
>>>>>
>>>>> [CAUSE]
>>>>> This is due to the fact that btrfs can only do extent level share check.
>>>>>
>>>>> Btrfs can only tell if an extent is shared, no matter if only part of the
>>>>> extent is shared or not.
>>>>>
>>>>> So for above script we have:
>>>>> - fallocate
>>>>> - buffered write
>>>>>   If we don't have enough data space, we fall back to NOCOW check.
>>>>>   At this timming, the extent is not shared, we can skip data
>>>>>   reservation.
>>>>
>>>> But in the above example we don't fall to nocow mode when doing the
>>>> buffered write, as there's plenty of data space available (1Gb -
>>>> 24Kb).
>>>> You need to update the example.
>>> I have to admit that the core part is mostly based on the worst case
>>> *assumption*.
>>>
>>> I'll try to make the case convincing by making it fail directly.
>>
>> Great, thanks.
>>
>>>
>>>>
>>>>
>>>>> - reflink
>>>>>   Now part of the large preallocated extent is shared.
>>>>> - delalloc kicks in
>>>>
>>>> writeback kicks in
>>>>
>>>>>   For the NOCOW range, as the preallocated extent is shared, we need
>>>>>   to fall back to COW.
>>>>>
>>>>> [WORKAROUND]
>>>>> The workaround is to ensure any buffered write in the related extents
>>>>> (not the reflink source range) get flushed before reflink.
>>>>
>>>> not the reflink source range -> not just the reflink source range
>>>>
>>>>>
>>>>> However it's pretty expensive to do a comprehensive check.
>>>>> In the reproducer, the reflink source is just a part of a larger
>>>>
>>>> Again, the reproducer needs to be fixed (yes, I tested it even if it's
>>>> clear by looking at it that it doesn't trigger the nocow case).
>>>>
>>>>> preallocated extent, we need to flush all buffered write of that extent
>>>>> before reflink.
>>>>> Such backward search can be complex and we may not get much benefit from
>>>>> it.
>>>>>
>>>>> So this patch will just try to flush the whole inode before reflink.
>>>>
>>>>
>>>>>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>> Reason for RFC:
>>>>> Flushing an inode just because it's a reflink source is definitely
>>>>> overkilling, but I don't have any better way to handle it.
>>>>>
>>>>> Any comment on this is welcomed.
>>>>> ---
>>>>>  fs/btrfs/ioctl.c | 22 ++++++++++++++++++++++
>>>>>  1 file changed, 22 insertions(+)
>>>>>
>>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>>> index 7755b503b348..8caa0edb6fbf 100644
>>>>> --- a/fs/btrfs/ioctl.c
>>>>> +++ b/fs/btrfs/ioctl.c
>>>>> @@ -3930,6 +3930,28 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
>>>>>                         return ret;
>>>>>         }
>>>>>
>>>>> +       /*
>>>>> +        * Workaround to make sure NOCOW buffered write reach disk as NOCOW.
>>>>> +        *
>>>>> +        * Due to the limit of btrfs extent tree design, we can only have
>>>>> +        * extent level share view. Any part of an extent is shared then the
>>>>
>>>> Any -> If any
>>>>
>>>>> +        * whole extent is shared and any write into that extent needs to fall
>>>>
>>>> is -> is considered
>>>>
>>>>> +        * back to COW.
>>>>
>>>> I would add, something like:
>>>>
>>>> That is, btrfs' back references do not have a block level granularity,
>>>> they work at the whole extent level.
>>>>
>>>>> +        *
>>>>> +        * NOCOW buffered write without data space reserved could to lead to
>>>>> +        * either data space bytes_may_use underflow (kernel warning) or ENOSPC
>>>>> +        * at delalloc time (transaction abort).
>>>>
>>>> I would omit the warning and transaction abort parts, that can change
>>>> any time. And we have that information in the changelog, so it's not
>>>> lost.
>>>>
>>>>> +        *
>>>>> +        * Here we take a shortcut by flush the whole inode. We could do better
>>>>> +        * by finding all extents in that range and flush the space referring
>>>>> +        * all those extents.
>>>>> +        * But that's too complex for such corner case.
>>>>> +        */
>>>>> +       filemap_flush(src->i_mapping);
>>>>> +       if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
>>>>> +                    &BTRFS_I(src)->runtime_flags))
>>>>> +               filemap_flush(src->i_mapping);
>>>>
>>>> So a few comments here:
>>>>
>>>> - why just in the clone part? The dedupe side has the same problem, doesn't it?
>>>
>>> Right.
>>>
>>>>
>>>> - I would move such flushing to btrfs_remap_file_range_prep - this is
>>>> where we do the source and target range flush and wait.
>>>>
>>>> Can you turn the reproducer into an fstests case?
>>>
>>> Sure.
>>>
>>> Thanks for the info and all the comment,
>>> Qu
>>>
>>>>
>>>> Thanks.
>>>>
>>>>> +
>>>>>         /*
>>>>>          * Lock destination range to serialize with concurrent readpages() and
>>>>>          * source range to serialize with relocation.
>>>>> --
>>>>> 2.21.0
>>>>>
>>>>
>>>>
>>>
>>
>>
> 
