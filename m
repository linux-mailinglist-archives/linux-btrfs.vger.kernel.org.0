Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE6E6A8176
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 12:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCBLpp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 06:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCBLpo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 06:45:44 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E315596
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 03:45:42 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZTqg-1q4GSW0e7a-00WZZc; Thu, 02
 Mar 2023 12:45:34 +0100
Message-ID: <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com>
Date:   Thu, 2 Mar 2023 19:45:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
In-Reply-To: <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Z9J6Few7Nqd+cfRxFPL0q3k3u0s+uwLB459Irw/JISMDG7UUGCf
 zm9hmDH2kIuIFGA0VB2H+78mex08PGWAxAptt98PLZvwhEGU3aKgxNSzYZBRnVosCPNsyKq
 nmHCxtUjdbtZfKxw2j/5Gc5q8BjoRL1+KIMoYI9W2PAwcRFdXXpmdfCLL4wAcKJYEnbiHia
 ni7RkFmsGfN++IYUNsTaQ==
UI-OutboundReport: notjunk:1;M01:P0:Z7rcSm0nKPU=;MnAXhBDdDVU7KmlvMed/t/0CuU1
 odSV3ft6Mqn3dGrGo/bd1RJOGkAKP2kgv7RbPIpRzdB+42lvpe6J6sWoqtgEvd5QDw/deejSw
 nBCB8rhVV3A8ttFvcpHaY8xCM9hVne66GxrleYYbmRW1fqW0jL6wvoh2gbwzMfcAiYXHK8l78
 3cQamZqwL8GhDMXdop3BPfej4tDbCWCKUz3LpnVISPO85UJbkmTjrEleelXIR4AjJTMc40poh
 dcJB/HGCGlbQBqVPUBRB2NZdTPIs4ul4FcypnNak5aw8HhUiODYpv0muJrYXSCMG0njdfslaC
 ANXvj5YrfsW+e+oUgseLD9OLh44rzjyEVkU5G9SCKIWOQgMDjjfzIKDXkiuYKc2tv0geZF/5v
 b3JgkxY14i8VfA/m7yXPp2lkTAHidWI7vc93X6DTnNH6/C56NTJwtbPwJx63fYcl5N/d9qy+r
 YWiGIypyZKugd6C4Q2JDWpz42gtF9HasCOsLnGvZQkIFkPo9CabEjyBPBO5thlIKZKVKvGOdP
 TyTz8pK0VfidLV6T9YGF/SXYsKGTGVi1Dtv7AGdrQEno8YgnNwYxeyVfFzrEg5hH+1eruoJeT
 NcMLLPkNQj5eA8dCnFnSKHh++D3HIusqUt7v5+tFL/eyY3o5qX5mq1fodWoIXbzTg/kh/vCep
 v9MNmT8MAUeygqCT5wx7lAw7fQ2N/SGjneik3fTOSR0xnXDtZ3PDz/HRHSvldyKebk2SkRMq8
 a33MNLrdvuqQzktQTDd4DdCbYxlGI6ADX2lG7RFPVmip2RMxcpHzSWFPCkGkna7pHtpSXmtKT
 MEKSAKv1dEI+NPdbDG5dxCbe8S17Bt53oRlejag1fcJJBzbr0BEhjhrGy3lMukeXSJcYL8uSj
 BwdHlJ1tpCEizVrJ4EFgrIIkRUyiC3Uiung0hC8hftzVXKjz8++iiTGeNbBOG9f4jolqwC//b
 O1pqoNhnGNsyQ4CCTMZrclJvc2I=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/2 19:25, Johannes Thumshirn wrote:
> On 02.03.23 11:59, Qu Wenruo wrote:
>>
>>
>> On 2023/3/2 17:45, Johannes Thumshirn wrote:
>>> Add support for inserting stripe extents into the raid stripe tree on
>>> completion of every write that needs an extra logical-to-physical
>>> translation when using RAID.
>>>
>>> Inserting the stripe extents happens after the data I/O has completed,
>>> this is done to a) support zone-append and b) rule out the possibility of
>>> a RAID-write-hole.
>>>
>>> This is done by creating in-memory ordered stripe extents, just like the
>>> in memory ordered extents, on I/O completion and the on-disk raid stripe
>>> extents get created once we're running the delayed_refs for the extent
>>> item this stripe extent is tied to.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> ---
>>>    fs/btrfs/Makefile           |   2 +-
>>>    fs/btrfs/bio.c              |  29 +++++
>>>    fs/btrfs/delayed-ref.c      |   6 +-
>>>    fs/btrfs/delayed-ref.h      |   2 +
>>>    fs/btrfs/extent-tree.c      |  60 +++++++++++
>>>    fs/btrfs/inode.c            |  15 ++-
>>>    fs/btrfs/raid-stripe-tree.c | 204 ++++++++++++++++++++++++++++++++++++
>>>    fs/btrfs/raid-stripe-tree.h |  71 +++++++++++++
>>>    fs/btrfs/volumes.c          |   4 +-
>>>    fs/btrfs/volumes.h          |  13 +--
>>>    fs/btrfs/zoned.c            |   3 +
>>>    11 files changed, 397 insertions(+), 12 deletions(-)
>>>    create mode 100644 fs/btrfs/raid-stripe-tree.c
>>>    create mode 100644 fs/btrfs/raid-stripe-tree.h
>>>
>>> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
>>> index 90d53209755b..3bb869a84e54 100644
>>> --- a/fs/btrfs/Makefile
>>> +++ b/fs/btrfs/Makefile
>>> @@ -33,7 +33,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
>>>    	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
>>>    	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
>>>    	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o \
>>> -	   lru_cache.o
>>> +	   lru_cache.o raid-stripe-tree.o
>>>    
>>>    btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
>>>    btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
>>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>>> index 726592868e9c..2b174865d347 100644
>>> --- a/fs/btrfs/bio.c
>>> +++ b/fs/btrfs/bio.c
>>> @@ -15,6 +15,7 @@
>>>    #include "rcu-string.h"
>>>    #include "zoned.h"
>>>    #include "file-item.h"
>>> +#include "raid-stripe-tree.h"
>>>    
>>>    static struct bio_set btrfs_bioset;
>>>    static struct bio_set btrfs_clone_bioset;
>>> @@ -348,6 +349,21 @@ static void btrfs_raid56_end_io(struct bio *bio)
>>>    	btrfs_put_bioc(bioc);
>>>    }
>>>    
>>> +static void btrfs_raid_stripe_update(struct work_struct *work)
>>> +{
>>> +	struct btrfs_bio *bbio =
>>> +		container_of(work, struct btrfs_bio, end_io_work);
>>> +	struct btrfs_io_stripe *stripe = bbio->bio.bi_private;
>>> +	struct btrfs_io_context *bioc = stripe->bioc;
>>> +	int ret;
>>> +
>>> +	ret = btrfs_add_ordered_stripe(bioc);
>>> +	if (ret)
>>> +		bbio->bio.bi_status = errno_to_blk_status(ret);
>>> +	btrfs_orig_bbio_end_io(bbio);
>>> +	btrfs_put_bioc(bioc);
>>> +}
>>> +
>>>    static void btrfs_orig_write_end_io(struct bio *bio)
>>>    {
>>>    	struct btrfs_io_stripe *stripe = bio->bi_private;
>>> @@ -370,6 +386,16 @@ static void btrfs_orig_write_end_io(struct bio *bio)
>>>    	else
>>>    		bio->bi_status = BLK_STS_OK;
>>>    
>>> +	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
>>> +		stripe->physical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
>>> +
>>> +	if (btrfs_need_stripe_tree_update(bioc->fs_info, bioc->map_type)) {
>>> +		INIT_WORK(&bbio->end_io_work, btrfs_raid_stripe_update);
>>> +		queue_work(btrfs_end_io_wq(bioc->fs_info, bio),
>>> +			&bbio->end_io_work);
>>
>> I'm still having the old question, what would happen if the delayed
>> workload happen after the ordered extent finished?
>>
>> Since we can not ensure the order between this RST update workload and
>> finish_ordered_io(), there can be an window where we finish ordered io,
>> and then the pages get released (by memory pressure), then a new read
>> happen to the range, then our RST workload happened.
>>
>> In that case, we would have read failure.
>>
>>
>> Thus I strongly recommened to do the RST tree update inside
>> finish_ordered_io().
>>
>> This has several advantages:
>>
>> - We don't need in-memory structure as a gap stopper
>>     Since read would be blocked if there is a running ordered extent,
>>     we don't need an in-memory RST mapping.
>>
>> - finish_ordered_io() itself has all the proper context for tree
>>     updates.
>>     As that's the main location we update the subvolume tree.
> 
> The first versions of this patchset did do that and then you asked me
> to create an in-memory structure and do the update at delayed ref time.

I have to admit that, I was a total idiot.

At that time I didn't notice the read would block when there is a 
running ordered extent at all...

So, all my fault.

> 
> How about adding a completion, or something like a atomic_t
> ordered_stripes_pending for the RST updates and have
> finish_ordered_io() waiting for it?

That's also a feasible solution.

Although I'm a little concerned about the fact that the RST delayed work 
is also going into fs_info->endio_workers, which is also used by 
finish_ordered_fn().

Thus it can cause deadlock if the workqueue has one max_active, and the 
running one is finish_ordered_fn(), which then can be waiting for the 
RST work.

But the RST work can only be executed if the endio_workers has finished 
its current work, thus leading to a deadlock.

Thanks,
Qu
> 
>> The main concern may be the bioc <-> ordered extent mapping, but IIRC
>> for zoned mode one bioc is one ordered extent, thus this shouldn't be a
>> super big deal?
> 
> Yep, but I want to be able to use RST for non-zoned devices as well
> to attack the RAID56 problems and add erasure coding RAID.
> 
>> Otherwise we may need something to trace all the bioc belong to the
>> ordered extent.
> 
