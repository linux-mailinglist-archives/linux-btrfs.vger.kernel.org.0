Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99C44151825
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 10:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBDJrU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 04:47:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:40568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgBDJrU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 04:47:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2F790ABF4;
        Tue,  4 Feb 2020 09:47:17 +0000 (UTC)
Subject: Re: [PATCH 24/24] btrfs: add a comment explaining the data flush
 steps
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200203204951.517751-1-josef@toxicpanda.com>
 <20200203204951.517751-25-josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <593bda62-3f25-28d6-bb5c-efaa677872c6@suse.com>
Date:   Tue, 4 Feb 2020 11:47:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203204951.517751-25-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3.02.20 г. 22:49 ч., Josef Bacik wrote:
> The data flushing steps are not obvious to people other than myself and
> Chris.  Write a giant comment explaining the reasoning behind each flush
> step for data as well as why it is in that particular order.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/space-info.c | 46 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 18a31d96bbbd..d3befc536a7f 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -780,6 +780,52 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
>  	} while (flush_state <= COMMIT_TRANS);
>  }
>  
> +/*
> + * FLUSH_DELALLOC_WAIT:
> + *   Space is free'd from flushing delalloc in one of two ways.
> + *
> + *   1) compression is on and we allocate less space than we reserved.
> + *   2) We are overwriting existing space.
> + *
> + *   For #1 that extra space is reclaimed as soon as the delalloc pages are
> + *   cow'ed, by way of btrfs_add_reserved_bytes() which adds the actual extent
> + *   length to ->bytes_reserved, and subtracts the reserved space from
> + *   ->bytes_may_use.
> + *
> + *   For #2 this is trickier.  Once the ordered extent runs we will drop the
> + *   extent in the range we are overwriting, which creates a delayed ref for
> + *   that freed extent.  This however is not reclaimed until the transaction
> + *   commits, thus the next stages.
> + *
> + * RUN_DELAYED_IPUTS
> + *   If we are freeing inodes, we want to make sure all delayed iputs have
> + *   completed, because they could have been on an inode with i_nlink == 0, and
> + *   thus have been trunated and free'd up space.  But again this space is not
> + *   immediately re-usable, it comes in the form of a delayed ref, which must be
> + *   run and then the transaction must be committed.
> + *
> + * FLUSH_DELAYED_REFS
> + *   The above two cases generate delayed refs that will affect
> + *   ->total_bytes_pinned.  However this counter can be inconsistent with
> + *   reality if there are outstanding delayed refs.  This is because we adjust
> + *   the counter based on the other delayed refs that exist.  So for example, if

IMO this sentence would be clearer if it simply says something along the
lines of " This is because we adjust the counter based solely on the
current set of delayed refs and disregard any on-disk state which might
include more refs".

> + *   we have an extent with 2 references, but we only drop 1, we'll see that
> + *   there is a negative delayed ref count for the extent and assume that the
> + *   space will be free'd, and thus increase ->total_bytes_pinned.
> + *
> + *   Running the delayed refs gives us the actual real view of what will be
> + *   freed at the transaction commit time.  This stage will not actually free
> + *   space for us, it just makes sure that may_commit_transaction() has all of
> + *   the information it needs to make the right decision.

Is there any particular reason why total_bytes_pinned is sort of double
accounted. I.e first add_pinned_bytes is called when a DROP del ref is
added with negative ref. Then during processing of that delref
__btrfs_free_extent either:

a) Removes the ref but doesn't free the extent if there were other,
non-del refs for this extent

b) Removes the extent and calls btrfs_update_block_group to account it
again as pinned (this time also setting the respective ranges as pinned)

This double accounting doesn't really happen because after the
processing of the DROP del ref is finished
cleanup_ref_head->btrfs_cleanup_ref_head_accounting will actually clean
the pinned bytes added at creation time of the DROP del ref. Can we
avoid this and simply rely on the update of total_bytes_pinned when an
extent is freed.


> + *
> + * COMMIT_TRANS
> + *   This is where we reclaim all of the pinned space generated by the previous
> + *   two stages.  We will not commit the transaction if we don't think we're
> + *   likely to satisfy our request, which means if our current free space +
> + *   total_bytes_pinned < reservation we will not commit.  This is why the
> + *   previous states are actually important, to make sure we know for sure
> + *   wether committing the transaction will allow us to make progress.

typo: s/wether/whether/

> + */
>  static const enum btrfs_flush_state data_flush_states[] = {
>  	FLUSH_DELALLOC_WAIT,
>  	RUN_DELAYED_IPUTS,
> 

This looks good and helped me understand the machinery and put some
context into the code.
