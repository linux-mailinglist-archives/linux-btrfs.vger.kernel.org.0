Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4874D9BFF
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 14:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiCONRk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 09:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiCONRj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 09:17:39 -0400
Received: from out20-49.mail.aliyun.com (out20-49.mail.aliyun.com [115.124.20.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A28527E0
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 06:16:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04437399|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.209243-0.0558655-0.734892;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.N57PGXB_1647350183;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.N57PGXB_1647350183)
          by smtp.aliyun-inc.com(33.37.68.185);
          Tue, 15 Mar 2022 21:16:24 +0800
Date:   Tue, 15 Mar 2022 21:16:27 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     fdmanana@kernel.org
Subject: Re: [PATCH v2 1/7] btrfs: only reserve the needed data space amount during fallocate
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <dde255ba71e1bfe38daf88c1b7ef51df15d5c150.1647346287.git.fdmanana@suse.com>
References: <cover.1647346287.git.fdmanana@suse.com> <dde255ba71e1bfe38daf88c1b7ef51df15d5c150.1647346287.git.fdmanana@suse.com>
Message-Id: <20220315211627.BD66.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> TODO: test case when the file with/without snapshot
> 
> From: Filipe Manana <fdmanana@suse.com>
> 
> During a plain fallocate, we always start by reserving an amount of data
> space that matches the length of the range passed to fallocate. When we
> already have extents allocated in that range, we may end up trying to
> reserve a lot more data space then we need, which can result in two
> undesired behaviours:

Need we check whether the allocated extents are exclusive  or shared?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/03/15

> 
> 1) We fail with -ENOSPC. For example the passed range has a length
>    of 1G, but there's only one hole with a size of 1M in that range;
> 
> 2) We temporarily reserve excessive data space that could be used by
>    other operations happening concurrently;
> 
> 3) By reserving much more data space then we need, we can end up
>    doing expensive things like triggering dellaloc for other inodes,
>    waiting for the ordered extents to complete, trigger transaction
>    commits, allocate new block groups, etc.
> 
> Example:
> 
>   $ cat test.sh
>   #!/bin/bash
> 
>   DEV=/dev/sdj
>   MNT=/mnt/sdj
> 
>   mkfs.btrfs -f -b 1g $DEV
>   mount $DEV $MNT
> 
>   # Create a file with a size of 600M and two holes, one at [200M, 201M[
>   # and another at [401M, 402M[
>   xfs_io -f -c "pwrite -S 0xab 0 200M" \
>             -c "pwrite -S 0xcd 201M 200M" \
>             -c "pwrite -S 0xef 402M 198M" \
>             $MNT/foobar
> 
>   # Now call fallocate against the whole file range, see if it fails
>   # with -ENOSPC or not - it shouldn't since we only need to allocate
>   # 2M of data space.
>   xfs_io -c "falloc 0 600M" $MNT/foobar
> 
>   umount $MNT
> 
>   $ ./test.sh
>   (...)
>   wrote 209715200/209715200 bytes at offset 0
>   200 MiB, 51200 ops; 0.8063 sec (248.026 MiB/sec and 63494.5831 ops/sec)
>   wrote 209715200/209715200 bytes at offset 210763776
>   200 MiB, 51200 ops; 0.8053 sec (248.329 MiB/sec and 63572.3172 ops/sec)
>   wrote 207618048/207618048 bytes at offset 421527552
>   198 MiB, 50688 ops; 0.7925 sec (249.830 MiB/sec and 63956.5548 ops/sec)
>   fallocate: No space left on device
>   $
> 
> So fix this by not allocating an amount of data space that matches the
> length of the range passed to fallocate. Instead allocate an amount of
> data space that corresponds to the sum of the sizes of each hole found
> in the range. This reservation now happens after we have locked the file
> range, which is safe since we know at this point there's no delalloc
> in the range because we've taken the inode's VFS lock in exclusive mode,
> we have taken the inode's i_mmap_lock in exclusive mode, we have flushed
> delalloc and waited for all ordered extents in the range to complete.
> 
> This type of failure actually seems to happen in pratice with systemd,
> and we had at least one report about this in a very long thread which
> is referenced by the Link tag below.
> 
> Link: https://lore.kernel.org/linux-btrfs/bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/file.c | 69 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 37 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 380054c94e4b..b7c0db1000cd 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3417,6 +3417,9 @@ static long btrfs_fallocate(struct file *file, int mode,
>  	u64 alloc_hint = 0;
>  	u64 locked_end;
>  	u64 actual_end = 0;
> +	u64 data_space_needed = 0;
> +	u64 data_space_reserved = 0;
> +	u64 qgroup_reserved = 0;
>  	struct extent_map *em;
>  	int blocksize = btrfs_inode_sectorsize(BTRFS_I(inode));
>  	int ret;
> @@ -3437,18 +3440,6 @@ static long btrfs_fallocate(struct file *file, int mode,
>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>  		return btrfs_punch_hole(file, offset, len);
>  
> -	/*
> -	 * Only trigger disk allocation, don't trigger qgroup reserve
> -	 *
> -	 * For qgroup space, it will be checked later.
> -	 */
> -	if (!(mode & FALLOC_FL_ZERO_RANGE)) {
> -		ret = btrfs_alloc_data_chunk_ondemand(BTRFS_I(inode),
> -						      alloc_end - alloc_start);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
>  	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
>  
>  	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size) {
> @@ -3548,48 +3539,66 @@ static long btrfs_fallocate(struct file *file, int mode,
>  		if (em->block_start == EXTENT_MAP_HOLE ||
>  		    (cur_offset >= inode->i_size &&
>  		     !test_bit(EXTENT_FLAG_PREALLOC, &em->flags))) {
> +			const u64 range_len = last_byte - cur_offset;
> +
>  			ret = add_falloc_range(&reserve_list, cur_offset,
> -					       last_byte - cur_offset);
> +					       range_len);
>  			if (ret < 0) {
>  				free_extent_map(em);
>  				break;
>  			}
>  			ret = btrfs_qgroup_reserve_data(BTRFS_I(inode),
>  					&data_reserved, cur_offset,
> -					last_byte - cur_offset);
> +					range_len);
>  			if (ret < 0) {
> -				cur_offset = last_byte;
>  				free_extent_map(em);
>  				break;
>  			}
> -		} else {
> -			/*
> -			 * Do not need to reserve unwritten extent for this
> -			 * range, free reserved data space first, otherwise
> -			 * it'll result in false ENOSPC error.
> -			 */
> -			btrfs_free_reserved_data_space(BTRFS_I(inode),
> -				data_reserved, cur_offset,
> -				last_byte - cur_offset);
> +			qgroup_reserved += range_len;
> +			data_space_needed += range_len;
>  		}
>  		free_extent_map(em);
>  		cur_offset = last_byte;
>  	}
>  
> +	if (!ret && data_space_needed > 0) {
> +		/*
> +		 * We are safe to reserve space here as we can't have delalloc
> +		 * in the range, see above.
> +		 */
> +		ret = btrfs_alloc_data_chunk_ondemand(BTRFS_I(inode),
> +						      data_space_needed);
> +		if (!ret)
> +			data_space_reserved = data_space_needed;
> +	}
> +
>  	/*
>  	 * If ret is still 0, means we're OK to fallocate.
>  	 * Or just cleanup the list and exit.
>  	 */
>  	list_for_each_entry_safe(range, tmp, &reserve_list, list) {
> -		if (!ret)
> +		if (!ret) {
>  			ret = btrfs_prealloc_file_range(inode, mode,
>  					range->start,
>  					range->len, i_blocksize(inode),
>  					offset + len, &alloc_hint);
> -		else
> +			/*
> +			 * btrfs_prealloc_file_range() releases space even
> +			 * if it returns an error.
> +			 */
> +			data_space_reserved -= range->len;
> +			qgroup_reserved -= range->len;
> +		} else if (data_space_reserved > 0) {
>  			btrfs_free_reserved_data_space(BTRFS_I(inode),
> -					data_reserved, range->start,
> -					range->len);
> +					       data_reserved, range->start,
> +					       range->len);
> +			data_space_reserved -= range->len;
> +			qgroup_reserved -= range->len;
> +		} else if (qgroup_reserved > 0) {
> +			btrfs_qgroup_free_data(BTRFS_I(inode), data_reserved,
> +					       range->start, range->len);
> +			qgroup_reserved -= range->len;
> +		}
>  		list_del(&range->list);
>  		kfree(range);
>  	}
> @@ -3606,10 +3615,6 @@ static long btrfs_fallocate(struct file *file, int mode,
>  			     &cached_state);
>  out:
>  	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
> -	/* Let go of our reservation. */
> -	if (ret != 0 && !(mode & FALLOC_FL_ZERO_RANGE))
> -		btrfs_free_reserved_data_space(BTRFS_I(inode), data_reserved,
> -				cur_offset, alloc_end - cur_offset);
>  	extent_changeset_free(data_reserved);
>  	return ret;
>  }
> -- 
> 2.33.0


