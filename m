Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD0AD3C1F
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 11:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfJKJTm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 05:19:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:49618 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbfJKJTm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 05:19:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E03D5ADDA;
        Fri, 11 Oct 2019 09:19:38 +0000 (UTC)
Subject: Re: [PATCH 02/19] btrfs: rename DISCARD opt to DISCARD_SYNC
To:     Dennis Zhou <dennis@kernel.org>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <cover.1570479299.git.dennis@kernel.org>
 <cover.1570479299.git.dennis@kernel.org>
 <e2c7ca7b48bc3a5a219329f7d086ab1cfd7330a3.1570479299.git.dennis@kernel.org>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cb43e6ee-145c-61cc-77bf-b2d0f01c3bb3@suse.com>
Date:   Fri, 11 Oct 2019 12:19:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e2c7ca7b48bc3a5a219329f7d086ab1cfd7330a3.1570479299.git.dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7.10.19 г. 23:17 ч., Dennis Zhou wrote:
> This series introduces async discard which will use the flag
> DISCARD_ASYNC, so rename the original flag to DISCARD_SYNC as it is
> synchronously done in transaction commit.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  fs/btrfs/block-group.c | 2 +-
>  fs/btrfs/ctree.h       | 2 +-
>  fs/btrfs/extent-tree.c | 4 ++--
>  fs/btrfs/super.c       | 8 ++++----
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index bf7e3f23bba7..afe86028246a 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1365,7 +1365,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  		spin_unlock(&space_info->lock);
>  
>  		/* DISCARD can flip during remount */
> -		trimming = btrfs_test_opt(fs_info, DISCARD);
> +		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC);
>  
>  		/* Implicit trim during transaction commit. */
>  		if (trimming)
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 19d669d12ca1..1877586576aa 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1171,7 +1171,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
>  #define BTRFS_MOUNT_FLUSHONCOMMIT       (1 << 7)
>  #define BTRFS_MOUNT_SSD_SPREAD		(1 << 8)
>  #define BTRFS_MOUNT_NOSSD		(1 << 9)
> -#define BTRFS_MOUNT_DISCARD		(1 << 10)
> +#define BTRFS_MOUNT_DISCARD_SYNC	(1 << 10)
>  #define BTRFS_MOUNT_FORCE_COMPRESS      (1 << 11)
>  #define BTRFS_MOUNT_SPACE_CACHE		(1 << 12)
>  #define BTRFS_MOUNT_CLEAR_CACHE		(1 << 13)
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 49cb26fa7c63..77a5904756c5 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2903,7 +2903,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>  			break;
>  		}
>  
> -		if (btrfs_test_opt(fs_info, DISCARD))
> +		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
>  			ret = btrfs_discard_extent(fs_info, start,
>  						   end + 1 - start, NULL);
>  
> @@ -4146,7 +4146,7 @@ static int __btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
>  	if (pin)
>  		pin_down_extent(cache, start, len, 1);
>  	else {
> -		if (btrfs_test_opt(fs_info, DISCARD))
> +		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
>  			ret = btrfs_discard_extent(fs_info, start, len, NULL);

Is discard even needed in that function? All but one call of
btrfs_free_reserved_extent( it calls __btrfs_Free_Reserved_extent with
pin 0) happen in cleanup code when an extent has just been allocated,
not written to and potentially it has been discarded.

In cow_file_range that function is called only if create_io_em fails or
btrfs_add_ordered_extent fail, both of which happen _before_ any io is
submitted to the newly reserved range hence I think this can be removed.

In submit_compressed_extents the code flow is similar - out_free_reserve
can be called only before btrfs_submit_compressed_write

btrfs_new_extent_direct - again, called in case extent_map creation
fails, before any io happens.

__btrfs_prealloc_file_range - called as a cleanup for a prealloc extent.

btrfs_alloc_tree_block - the metadata extent is allocated but not
written to yet

btrfs_finish_ordered_io - here it seems it can be called for an extent
which could have had some data written to it on disk so discard seems
like necessary. On the other hand the code contradicts the comment:

"We only free the extent in the truncated case if we didn't write out
the extent at all. "

Yet the 'if' does:

 if ((ret || !logical_len) &&
     clear_reserved_extent &&
     !test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags) &&
     !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags))

So even if we have ret non 0 (meaning error) we could still free the
extent so long it's not before insert_reserved_file_extent returns
success (the clear_reserved_extent check). This logic is messy, Josef do
you have any idea what should be the correct behavior?

My point is that if btrfs_free_reserved_extent should only be called in
finish_ordered_io for a truncated extent, which hasn't been written at
all then this renders the btrfs_discard_extent call in
btrfs_free_reserved_extent redundant and can be removed, provided my
analysis is correct.

What do you think ?



<snip>
