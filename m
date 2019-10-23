Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D1FE1FA4
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 17:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406869AbfJWPlT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 11:41:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:48466 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403975AbfJWPlT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 11:41:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1BC2BC7E;
        Wed, 23 Oct 2019 15:41:15 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] btrfs: extent-tree: Ensure we trim ranges across
 block group boundary
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191023135727.64358-1-wqu@suse.com>
 <20191023135727.64358-3-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1322eb4c-5d7a-29c0-befc-952a012f1bcc@suse.com>
Date:   Wed, 23 Oct 2019 18:41:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023135727.64358-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23.10.19 г. 16:57 ч., Qu Wenruo wrote:
> [BUG]
> When deleting large files (which cross block group boundary) with discard
> mount option, we find some btrfs_discard_extent() calls only trimmed part
> of its space, not the whole range:
> 
>   btrfs_discard_extent: type=0x1 start=19626196992 len=2144530432 trimmed=1073741824 ratio=50%
> 
> type:		bbio->map_type, in above case, it's SINGLE DATA.
> start:		Logical address of this trim
> len:		Logical length of this trim
> trimmed:	Physically trimmed bytes
> ratio:		trimmed / len
> 
> Thus leading some unused space not discarded.
> 
> [CAUSE]
> When discard mount option is specified, after a transaction is fully
> committed (super block written to disk), we begin to cleanup pinned
> extents in the following call chain:
> 
> btrfs_commit_transaction()
> |- write_all_supers()

You can remove write_all_supers

> |- btrfs_finish_extent_commit()
>    |- find_first_extent_bit(unpin, 0, &start, &end, EXTENT_DIRTY);
>    |- btrfs_discard_extent()
> 
> However pinned extents are recorded in an extent_io_tree, which can
> merge adjacent extent states.
> 
> When a large file get deleted and it has adjacent file extents across
> block group boundary, we will get a large merged range.

This is wrong, it will only get merged if the extent spans contiguous bg boundaries
(this is very important!)

> 
> Then when we pass the large range into btrfs_discard_extent(),
> btrfs_discard_extent() will just trim the first part, without trimming
> the remaining part.

Here is what my testing shows: 

mkfs.btrfs -f /dev/vdc

mount -onodatasum,nospace_cache /dev/vdc /media/scratch/
xfs_io -f -c "pwrite 0 800m" /media/scratch/file1 && sync
xfs_io -f -c "pwrite 0 300m" /media/scratch/file2 && sync
umount /media/scratch

mount -odiscard /dev/vdc /media/scratch
rm -f /media/scratch/file2 && sync
trace-cmd show

umount /media/scratch

The output I get in trace-cmd is: 

sync-1014  [001] ....   534.272310: btrfs_finish_extent_commit: Discarding 1943011328-2077229055 (len: 134217728)
sync-1014  [001] ....   534.272315: btrfs_discard_extent: Requested to discard: 134217728 but discarded: 134217728

sync-1014  [001] ....   534.272325: btrfs_finish_extent_commit: Discarding 2177892352-2358247423 (len: 180355072)
sync-1014  [001] ....   534.272330: btrfs_discard_extent: Requested to discard: 180355072 but discarded: 180355072

The extents of this file look like this in the extent tree prior to the trim: 

item 18 key (1943011328 EXTENT_ITEM 134217728) itemoff 15523 itemsize 53
		refs 1 gen 7 flags DATA
		extent data backref root FS_TREE objectid 258 offset 0 count 1
item 19 key (2177892352 EXTENT_ITEM 134217728) itemoff 15470 itemsize 53
		refs 1 gen 7 flags DATA
		extent data backref root FS_TREE objectid 258 offset 134217728 count 1
item 20 key (2177892352 BLOCK_GROUP_ITEM 1073741824) itemoff 15446 itemsize 24
		block group used 180355072 chunk_objectid 256 flags DATA
item 21 key (2312110080 EXTENT_ITEM 46137344) itemoff 15393 itemsize 53
		refs 1 gen 7 flags DATA
		extent data backref root FS_TREE objectid 258 offset 268435456 count 1

So we have 3 extents 1 of which is in bg 1 and the other 2 in bg2. The 2 extents in bg2 are merged but 
since the 2nd bg is not contiguous to the first hence no merging.  

Here comes the requirement why the bg must be contiguous.

If I modify my test case with slightly different write offsets such that bg1 
is indeed filled and the next extent gets allocated to in bg2, which is adjacent then 
the bug is reproduced: 

mkfs.btrfs -f /dev/vdc

mount -onodatasum,nospace_cache /dev/vdc /media/scratch/
xfs_io -f -c "pwrite 0 800m" /media/scratch/file1 && sync
xfs_io -f -c "pwrite 0 224m" /media/scratch/file2 && sync
xfs_io -f -c "pwrite 224m 76m" /media/scratch/file2 && sync
umount /media/scratch

mount -odiscard /dev/vdc /media/scratch
rm -f /media/scratch/file2 && sync
trace-cmd show

umount /media/scratch

The 3 extents being created and subsequently deleted are: 

sync-799   [000] ....   313.938048: btrfs_update_block_group: Pinning 1943011328-2077229055
sync-799   [000] ....   313.938073: btrfs_update_block_group: Pinning 2077229056-2177892351 <- BG1 ends
sync-799   [000] ....   313.938116: btrfs_update_block_group: Pinning 2177892352-2257584127 <- BG2 begins

But we only get 1 discard request:

sync-798   [003] ....   154.077897: btrfs_finish_extent_commit: Discarding 1943011328-2257584127 (len: 314572800) <- this is the request passed to btrfs_discard_extent
sync-798   [003] ....   154.077901: btrfs_discard_extent: Discarding 234881024 length for bytenr: 1943011328 <- this is the actual range being discarded inside the for loop. 

So the bug is genuine I will test whether your patch fixes it and report back. 

> Furthermore, this bug is not that reliably observed, as if the whole
> block group is empty, there will be another trim for that block group.

Not only because of this, mainly because of the contiguousness requirement. 

> 
> So the most obvious way to find this missing trim needs to delete large
> extents at block group boundary without empting involved block groups.
> 
> [FIX]
> - Allow __btrfs_map_block_for_discard() to modify @length parameter
>   btrfs_map_block() uses its @length paramter to notify the caller how
>   many bytes are mapped in current call.
>   With __btrfs_map_block_for_discard() also modifing the @length,
>   btrfs_discard_extent() now understands when to do extra trim.
> 
> - Call btrfs_map_block() in a loop until we hit the range end
>   Since we now know how many bytes are mapped each time, we can iterate
>   through each block group boundary and issue correct trim for each
>   range.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

<snip>
