Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E267A151A7A
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 13:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgBDM1S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 07:27:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:54820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgBDM1S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 07:27:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A4F48B1A7;
        Tue,  4 Feb 2020 12:27:15 +0000 (UTC)
Subject: Re: [PATCH 2/3] btrfs: add a comment describing delalloc space
 reservation
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200203204436.517473-1-josef@toxicpanda.com>
 <20200203204436.517473-3-josef@toxicpanda.com>
 <7000f8a2-4d78-d9a1-2e3f-143b88ace1eb@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <55055cf9-2c36-8e3e-d1b8-b3fb53cc03c1@suse.com>
Date:   Tue, 4 Feb 2020 14:27:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7000f8a2-4d78-d9a1-2e3f-143b88ace1eb@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.02.20 г. 11:48 ч., Qu Wenruo wrote:
>


<snip>

> 
>> + *
>> + *   Once this space is reserved, it is added to space_info->bytes_may_use.  The
>> + *   caller must keep track of this reservation and free it up if it is never
>> + *   used.  With the buffered IO case this is handled via the EXTENT_DELALLOC
>> + *   bit's on the inode's io_tree.  For direct IO it's more straightforward, we
>> + *   take the reservation at the start of the operation, and if we write less
>> + *   than we reserved we free the excess.
> 
> This part involves the lifespan and state machine of data.
> I guess more explanation on the state machine would help a lot.
> 
> Like:
> Page clean
> |
> +- btrfs_buffered_write()
> |  Reserve data space for data, metadata space for csum/file
> |  extents/inodes.
> |
> Page dirty
> |
> +- run_delalloc_range()
> |  Allocate data extents, submit ordered extents to do csum calculation
> |  and bio submission
> Page write back
> |
> +- finish_oredred_io()
> |  Insert csum and file extents
> |
> Page clean
> 
> Although I'm not sure if such lifespan should belong to delalloc-space.c.

This omits a lot of critical details. FOr example it should be noted
that in btrfs_buffered_write we reserve as much space as is requested by
the user. Then in run_delalloc_range it must be mentioned that in case
of compressed extents it can be called to allocate an extent which is
less than the space reserved in btrfs_buffered_write => that's where the
possible space savings in case of compressed come from.

As a matter of fact running ordered io doesn't really clean any space
apart from a bit of metadata space (unless we do overwrites, as per our
discussion with josef in the slack channel).

<snip>

>> + *
>> + *   1) Updating the inode item.  We hold a reservation for this inode as long
>> + *   as there are dirty bytes outstanding for this inode.  This is because we
>> + *   may update the inode multiple times throughout an operation, and there is
>> + *   no telling when we may have to do a full cow back to that inode item.  Thus
>> + *   we must always hold a reservation.
>> + *
>> + *   2) Adding an extent item.  This is trickier, so a few sub points
>> + *
>> + *     a) We keep track of how many extents an inode may need to create in
>> + *     inode->outstanding_extents.  This is how many items we will have reserved
>> + *     for the extents for this inode.
>> + *
>> + *     b) count_max_extents() is used to figure out how many extent items we
>> + *     will need based on the contiguous area we have dirtied.  Thus if we are
>> + *     writing 4k extents but they coalesce into a very large extent, we will

I THe way you have worded this is a bit confusing because first you
mention that count_max_extents calcs how many extent items we'll need
for a contiguous area. Then you mention that if we make a bunch of 4k
writes that coalesce to a single extent i.e create 1 large contiguous
(that's what coalescing implies in this context) we'll have to split it
them. This is counter-intuitive.

I guess what you meant here is physically contiguous as opposed to
logically contiguous?

>> + *     break this into smaller extents which means we'll need a reservation for
>> + *     each of those extents.
>> + *
>> + *     c) When we set EXTENT_DELALLOC on the inode io_tree we will figure out
>> + *     the nummber of extents needed for the contiguous area we just created,

nit: s/nummber/number

>> + *     and add that to inode->outstanding_extents.

<snip>

>> + *
>> + *   3) Adding csums for the range.  This is more straightforward than the
>> + *   extent items, as we just want to hold the number of bytes we'll need for
>> + *   checksums until the ordered extent is removed.  If there is an error it is
>> + *   cleared via the EXTENT_CLEAR_META_RESV bit when clearning EXTENT_DELALLOC

nit: s/clearning/clearing

>> + *   on the inode io_tree.
>> + */
>> +
>>  int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
>>  {
>>  	struct btrfs_root *root = inode->root;
>>
> 
