Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C555E7286
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 05:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiIWDoC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 23:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIWDoA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 23:44:00 -0400
Received: from out20-134.mail.aliyun.com (out20-134.mail.aliyun.com [115.124.20.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327B71176E3
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 20:43:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436284|-1;BR=01201311R121S36rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.677926-6.68392e-05-0.322007;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.PMF.197_1663903879;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.PMF.197_1663903879)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 11:31:20 +0800
Date:   Fri, 23 Sep 2022 11:31:24 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: loosen the block-group-tree feature dependency check
In-Reply-To: <d43e26ecf12268e8bc75986052cc6021a096db74.1662961395.git.wqu@suse.com>
References: <d43e26ecf12268e8bc75986052cc6021a096db74.1662961395.git.wqu@suse.com>
Message-Id: <20220923113120.DC30.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> [BUG]
> When one user did a wrong try to clear block group tree, which can not
> be done through mount option, by using "-o clear_cache,space_cache=v2",
> it will cause the following error on a fs with block-group-tree feature:
> 
>  BTRFS info (device dm-1): force clearing of disk cache
>  BTRFS info (device dm-1): using free space tree
>  BTRFS info (device dm-1): clearing free space tree
>  BTRFS info (device dm-1): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
>  BTRFS info (device dm-1): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
>  BTRFS error (device dm-1): block-group-tree feature requires fres-space-tree and no-holes
>  BTRFS error (device dm-1): super block corruption detected before writing it to disk
>  BTRFS: error (device dm-1) in write_all_supers:4318: errno=-117 Filesystem corrupted (unexpected superblock corruption detected)
>  BTRFS warning (device dm-1: state E): Skipping commit of aborted transaction.
> 
> [CAUSE]
> Although the dependency for block-group-tree feature is just an
> artificial one (to reduce test matrix), we put the dependency check into
> btrfs_validate_super().
> 
> This is too strict, and during space cache clearing, we will have a
> window where free space tree is cleared, and we need to commit the super
> block.
> 
> In that window, we had block group tree without v2 cache, and triggered
> the artificial dependency check.
> 
> This is not necessary at all, especially for such a soft dependency.
> 
> [FIX]
> Introduce a new helper, btrfs_check_features(), to do all the runtime
> limitation checks, including:
> 
> - Unsupported incompat flags check
> 
> - Unsupported compat RO flags check
> 
> - Setting missing incompat flags
> 
> - Aritifical feature dependency checks
>   Currently only block group tree will rely on this.
> 
> - Subpage runtime check for v1 cache
> 
> With this helper, we can move quite some checks from
> open_ctree()/btrfs_remount() into it, and just call it after
> btrfs_parse_options().
> 
> Now "-o clear_cache,space_cache=v2" will not trigger above error
> anymore.

btrfs misc-next broken fstests btrfs/056 and more tests.

dmesg output of fstests btrfs/056 failure.
[  658.119910] BTRFS error (device dm-0): cannot replay dirty log with unsupported compat_ro features (0x3), try rescue=nologreplay

It seems that the root reason is this patch.

this patch or xfstests need to be fixed?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/09/23


> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c | 174 +++++++++++++++++++++++++++++----------------
>  fs/btrfs/disk-io.h |   1 +
>  fs/btrfs/super.c   |  19 +----
>  3 files changed, 115 insertions(+), 79 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 54b5784a59e5..d50df66d6ce9 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3292,6 +3292,114 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
>  	return ret;
>  }
>  
> +/*
> + * Do various sanity and dependency checks on different features.
> + *
> + * This is the place for less strict checks (like for subpage or artificial
> + * feature dependency).
> + *
> + * For strict checks or possible corruption detection, they should go
> + * btrfs_validate_super().
> + *
> + * This function also should be called after btrfs_parse_option(), as some
> + * mount option (space_cache related) can modify on-disk format like free
> + * space tree and screw up certain feature dependency.
> + */
> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb)
> +{
> +	struct btrfs_super_block *disk_super = fs_info->super_copy;
> +	u64 incompat = btrfs_super_incompat_flags(disk_super);
> +	u64 compat_ro = btrfs_super_compat_ro_flags(disk_super);
> +
> +	if (incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
> +		btrfs_err(fs_info,
> +		    "cannot mount because of unsupported optional features (0x%llx)",
> +		    incompat);
> +		return -EINVAL;
> +	}
> +
> +	/* Runtime limitation for mixed block groups. */
> +	if ((incompat & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) &&
> +	    (fs_info->sectorsize != fs_info->nodesize)) {
> +		btrfs_err(fs_info,
> +"unequal nodesize/sectorsize (%u != %u) are not allowed for mixed block groups",
> +			fs_info->nodesize, fs_info->sectorsize);
> +		return -EINVAL;
> +	}
> +
> +	/* Mixed backref is an always-enabled feature. */
> +	incompat |= BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF;
> +
> +	/* Set compression related flags just in case. */
> +	if (fs_info->compress_type == BTRFS_COMPRESS_LZO)
> +		incompat |= BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO;
> +	else if (fs_info->compress_type == BTRFS_COMPRESS_ZSTD)
> +		incompat |= BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD;
> +
> +	/*
> +	 * An ancient flag, which should really be marked deprecated.
> +	 * Such runtime limitation doesn't really need a incompat flag.
> +	 */
> +	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
> +		incompat |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
> +
> +	if (compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP && !sb_rdonly(sb)) {
> +		btrfs_err(fs_info,
> +	"cannot mount read-write because of unsupported optional features (0x%llx)",
> +		       compat_ro);
> +		return -EINVAL;
> +	}
> +	/*
> +	 * We have unsupported RO compat features, although RO mounted, we
> +	 * should not cause any metadata write, including log replay.
> +	 * Or we could screw up whatever the new feature requires.
> +	 */
> +	if (unlikely(compat_ro && btrfs_super_log_root(disk_super) &&
> +		     !btrfs_test_opt(fs_info, NOLOGREPLAY))) {
> +		btrfs_err(fs_info,
> +"cannot replay dirty log with unsupported compat_ro features (0x%llx), try rescue=nologreplay",
> +			  compat_ro);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Artificial limitations for block group tree, to force
> +	 * block-group-tree to rely on no-holes and free-space-tree.
> +	 * Mostly to reduce test matrix.
> +	 */
> +	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE) &&
> +	    (!btrfs_fs_incompat(fs_info, NO_HOLES) ||
> +	     !btrfs_test_opt(fs_info, FREE_SPACE_TREE))) {
> +		btrfs_err(fs_info,
> +"block-group-tree feature requires no-holes and free-space-tree features");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Subpage runtime limitation on v1 cache.
> +	 *
> +	 * V1 space cache still has some hard code PAGE_SIZE usage, while
> +	 * we're already defaulting to v2 cache, no need to bother
> +	 * v1 as it's going to be deprecated anyway.
> +	 */
> +	if (fs_info->sectorsize < PAGE_SIZE &&
> +	    btrfs_test_opt(fs_info, SPACE_CACHE)) {
> +		btrfs_warn(fs_info,
> +	"v1 space cache is not supported for page size %lu with sectorsize %u",
> +			   PAGE_SIZE, fs_info->sectorsize);
> +		return -EINVAL;
> +	}
> +	/*
> +	 * This function can be called by remount, thus we need spinlock to
> +	 * protect the super block.
> +	 */
> +	spin_lock(&fs_info->super_lock);
> +	btrfs_set_super_incompat_flags(disk_super, incompat);
> +	spin_unlock(&fs_info->super_lock);
> +
> +	return 0;
> +}
> +
>  int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices,
>  		      char *options)
>  {
> @@ -3441,72 +3549,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  		goto fail_alloc;
>  	}
>  
> -	features = btrfs_super_incompat_flags(disk_super) &
> -		~BTRFS_FEATURE_INCOMPAT_SUPP;
> -	if (features) {
> -		btrfs_err(fs_info,
> -		    "cannot mount because of unsupported optional features (0x%llx)",
> -		    features);
> -		err = -EINVAL;
> -		goto fail_alloc;
> -	}
> -
> -	features = btrfs_super_incompat_flags(disk_super);
> -	features |= BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF;
> -	if (fs_info->compress_type == BTRFS_COMPRESS_LZO)
> -		features |= BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO;
> -	else if (fs_info->compress_type == BTRFS_COMPRESS_ZSTD)
> -		features |= BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD;
> -
> -	/*
> -	 * Flag our filesystem as having big metadata blocks if they are bigger
> -	 * than the page size.
> -	 */
> -	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
> -		features |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
> -
> -	/*
> -	 * mixed block groups end up with duplicate but slightly offset
> -	 * extent buffers for the same range.  It leads to corruptions
> -	 */
> -	if ((features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS) &&
> -	    (sectorsize != nodesize)) {
> -		btrfs_err(fs_info,
> -"unequal nodesize/sectorsize (%u != %u) are not allowed for mixed block groups",
> -			nodesize, sectorsize);
> -		goto fail_alloc;
> -	}
> -
> -	/*
> -	 * Needn't use the lock because there is no other task which will
> -	 * update the flag.
> -	 */
> -	btrfs_set_super_incompat_flags(disk_super, features);
> -
> -	features = btrfs_super_compat_ro_flags(disk_super) &
> -		~BTRFS_FEATURE_COMPAT_RO_SUPP;
> -	if (!sb_rdonly(sb) && features) {
> -		btrfs_err(fs_info,
> -	"cannot mount read-write because of unsupported optional features (0x%llx)",
> -		       features);
> -		err = -EINVAL;
> -		goto fail_alloc;
> -	}
> -	/*
> -	 * We have unsupported RO compat features, although RO mounted, we
> -	 * should not cause any metadata write, including log replay.
> -	 * Or we could screw up whatever the new feature requires.
> -	 */
> -	if (unlikely(features && btrfs_super_log_root(disk_super) &&
> -		     !btrfs_test_opt(fs_info, NOLOGREPLAY))) {
> -		btrfs_err(fs_info,
> -"cannot replay dirty log with unsupported compat_ro features (0x%llx), try rescue=nologreplay",
> -			  features);
> -		err = -EINVAL;
> +	ret = btrfs_check_features(fs_info, sb);
> +	if (ret < 0) {
> +		err = ret;
>  		goto fail_alloc;
>  	}
>  
> -
>  	if (sectorsize < PAGE_SIZE) {
>  		struct btrfs_subpage_info *subpage_info;
>  
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 7e545ec09a10..c67c15d4d20b 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -48,6 +48,7 @@ int __cold open_ctree(struct super_block *sb,
>  void __cold close_ctree(struct btrfs_fs_info *fs_info);
>  int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>  			 struct btrfs_super_block *sb, int mirror_num);
> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb);
>  int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
>  struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
>  struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index eb0ae7e396ef..b0aeecc932b2 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2014,14 +2014,10 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>  	if (ret)
>  		goto restore;
>  
> -	/* V1 cache is not supported for subpage mount. */
> -	if (fs_info->sectorsize < PAGE_SIZE && btrfs_test_opt(fs_info, SPACE_CACHE)) {
> -		btrfs_warn(fs_info,
> -	"v1 space cache is not supported for page size %lu with sectorsize %u",
> -			   PAGE_SIZE, fs_info->sectorsize);
> -		ret = -EINVAL;
> +	ret = btrfs_check_features(fs_info, sb);
> +	if (ret < 0)
>  		goto restore;
> -	}
> +
>  	btrfs_remount_begin(fs_info, old_opts, *flags);
>  	btrfs_resize_thread_pool(fs_info,
>  		fs_info->thread_pool_size, old_thread_pool_size);
> @@ -2117,15 +2113,6 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>  			ret = -EINVAL;
>  			goto restore;
>  		}
> -		if (btrfs_super_compat_ro_flags(fs_info->super_copy) &
> -		    ~BTRFS_FEATURE_COMPAT_RO_SUPP) {
> -			btrfs_err(fs_info,
> -		"can not remount read-write due to unsupported optional flags 0x%llx",
> -				btrfs_super_compat_ro_flags(fs_info->super_copy) &
> -				~BTRFS_FEATURE_COMPAT_RO_SUPP);
> -			ret = -EINVAL;
> -			goto restore;
> -		}
>  		if (fs_info->fs_devices->rw_devices == 0) {
>  			ret = -EACCES;
>  			goto restore;
> -- 
> 2.37.3


