Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544684BE467
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Feb 2022 18:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345111AbiBUKuM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Feb 2022 05:50:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355239AbiBUKuB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Feb 2022 05:50:01 -0500
Received: from out20-97.mail.aliyun.com (out20-97.mail.aliyun.com [115.124.20.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309C4617A
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 02:11:43 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04437186|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.14753-0.000839838-0.851631;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.MtOA12F_1645438300;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.MtOA12F_1645438300)
          by smtp.aliyun-inc.com(33.38.168.99);
          Mon, 21 Feb 2022 18:11:40 +0800
Date:   Mon, 21 Feb 2022 18:11:42 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     fdmanana@kernel.org
Subject: Re: [PATCH 1/7] btrfs: fix lost prealloc extents beyond eof after full fsync
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <0b6139a324f2cd5b470d58c45617fc29ab893f12.1645098951.git.fdmanana@suse.com>
References: <cover.1645098951.git.fdmanana@suse.com> <0b6139a324f2cd5b470d58c45617fc29ab893f12.1645098951.git.fdmanana@suse.com>
Message-Id: <20220221181141.DD77.409509F4@e16-tech.com>
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

xfstest btrfs/261 PASSED 40 times without this patch.

so there is some problem in xfstest btrfs/261?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/02/21

> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing a full fsync, if we have prealloc extents beyond (or at) eof,
> and the leaves that contain them were not modified in the current
> transaction, we end up not logging them. This results in losing those
> extents when we replay the log after a power failure, since the inode is
> truncated to the current value of the logged i_size.
> 
> Just like for the fast fsync path, we need to always log all prealloc
> extents starting at or beyond i_size. The fast fsync case was fixed in
> commit 471d557afed155 ("Btrfs: fix loss of prealloc extents past i_size
> after fsync log replay") but it missed the full fsync path. The problem
> exists since the very early days, when the log tree was added by
> commit e02119d5a7b439 ("Btrfs: Add a write ahead tree log to optimize
> synchronous operations").
> 
> Example reproducer:
> 
>   $ mkfs.btrfs -f /dev/sdc
>   $ mount /dev/sdc /mnt
> 
>   # Create our test file with many file extent items, so that they span
>   # several leaves of metadata, even if the node/page size is 64K. Use
>   # direct IO and not fsync/O_SYNC because it's both faster and it avoids
>   # clearing the full sync flag from the inode - we want the fsync below
>   # to trigger the slow full sync code path.
>   $ xfs_io -f -d -c "pwrite -b 4K 0 16M" /mnt/foo
> 
>   # Now add two preallocated extents to our file without extending the
>   # file's size. One right at i_size, and another further beyond, leaving
>   # a gap between the two prealloc extents.
>   $ xfs_io -c "falloc -k 16M 1M" /mnt/foo
>   $ xfs_io -c "falloc -k 20M 1M" /mnt/foo
> 
>   # Make sure everything is durably persisted and the transaction is
>   # committed. This makes all created extents to have a generation lower
>   # than the generation of the transaction used by the next write and
>   # fsync.
>   sync
> 
>   # Now overwrite only the first extent, which will result in modifying
>   # only the first leaf of metadata for our inode. Then fsync it. This
>   # fsync will use the slow code path (inode full sync bit is set) because
>   # it's the first fsync since the inode was created/loaded.
>   $ xfs_io -c "pwrite 0 4K" -c "fsync" /mnt/foo
> 
>   # Extent list before power failure.
>   $ xfs_io -c "fiemap -v" /mnt/foo
>   /mnt/foo:
>    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>      0: [0..7]:          2178048..2178055     8   0x0
>      1: [8..16383]:      26632..43007     16376   0x0
>      2: [16384..32767]:  2156544..2172927 16384   0x0
>      3: [32768..34815]:  2172928..2174975  2048 0x800
>      4: [34816..40959]:  hole              6144
>      5: [40960..43007]:  2174976..2177023  2048 0x801
> 
>   <power fail>
> 
>   # Mount fs again, trigger log replay.
>   $ mount /dev/sdc /mnt
> 
>   # Extent list after power failure and log replay.
>   $ xfs_io -c "fiemap -v" /mnt/foo
>   /mnt/foo:
>    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>      0: [0..7]:          2178048..2178055     8   0x0
>      1: [8..16383]:      26632..43007     16376   0x0
>      2: [16384..32767]:  2156544..2172927 16384   0x1
> 
>   # The prealloc extents at file offsets 16M and 20M are missing.
> 
> So fix this by calling btrfs_log_prealloc_extents() when we are doing a
> full fsync, so that we always log all prealloc extents beyond eof.
> 
> A test case for fstests will follow soon.
> 
> CC: stable@vger.kernel.org # 4.19+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/tree-log.c | 43 +++++++++++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index a483337e8f41..71a5a961fef7 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -4732,7 +4732,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
>  
>  /*
>   * Log all prealloc extents beyond the inode's i_size to make sure we do not
> - * lose them after doing a fast fsync and replaying the log. We scan the
> + * lose them after doing a full/fast fsync and replaying the log. We scan the
>   * subvolume's root instead of iterating the inode's extent map tree because
>   * otherwise we can log incorrect extent items based on extent map conversion.
>   * That can happen due to the fact that extent maps are merged when they
> @@ -5510,6 +5510,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
>  				   struct btrfs_log_ctx *ctx,
>  				   bool *need_log_inode_item)
>  {
> +	const u64 i_size = i_size_read(&inode->vfs_inode);
>  	struct btrfs_root *root = inode->root;
>  	int ins_start_slot = 0;
>  	int ins_nr = 0;
> @@ -5530,13 +5531,21 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
>  		if (min_key->type > max_key->type)
>  			break;
>  
> -		if (min_key->type == BTRFS_INODE_ITEM_KEY)
> +		if (min_key->type == BTRFS_INODE_ITEM_KEY) {
>  			*need_log_inode_item = false;
> -
> -		if ((min_key->type == BTRFS_INODE_REF_KEY ||
> -		     min_key->type == BTRFS_INODE_EXTREF_KEY) &&
> -		    inode->generation == trans->transid &&
> -		    !recursive_logging) {
> +		} else if (min_key->type == BTRFS_EXTENT_DATA_KEY &&
> +			   min_key->offset >= i_size) {
> +			/*
> +			 * Extents at and beyond eof are logged with
> +			 * btrfs_log_prealloc_extents().
> +			 * Only regular files have BTRFS_EXTENT_DATA_KEY keys,
> +			 * and no keys greater than that, so bail out.
> +			 */
> +			break;
> +		} else if ((min_key->type == BTRFS_INODE_REF_KEY ||
> +			    min_key->type == BTRFS_INODE_EXTREF_KEY) &&
> +			   inode->generation == trans->transid &&
> +			   !recursive_logging) {
>  			u64 other_ino = 0;
>  			u64 other_parent = 0;
>  
> @@ -5567,10 +5576,8 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
>  				btrfs_release_path(path);
>  				goto next_key;
>  			}
> -		}
> -
> -		/* Skip xattrs, we log them later with btrfs_log_all_xattrs() */
> -		if (min_key->type == BTRFS_XATTR_ITEM_KEY) {
> +		} else if (min_key->type == BTRFS_XATTR_ITEM_KEY) {
> +			/* Skip xattrs, logged later with btrfs_log_all_xattrs() */
>  			if (ins_nr == 0)
>  				goto next_slot;
>  			ret = copy_items(trans, inode, dst_path, path,
> @@ -5623,9 +5630,21 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
>  			break;
>  		}
>  	}
> -	if (ins_nr)
> +	if (ins_nr) {
>  		ret = copy_items(trans, inode, dst_path, path, ins_start_slot,
>  				 ins_nr, inode_only, logged_isize);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (inode_only == LOG_INODE_ALL && S_ISREG(inode->vfs_inode.i_mode)) {
> +		/*
> +		 * Release the path because otherwise we might attempt to double
> +		 * lock the same leaf with btrfs_log_prealloc_extents() below.
> +		 */
> +		btrfs_release_path(path);
> +		ret = btrfs_log_prealloc_extents(trans, inode, dst_path);
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.33.0


