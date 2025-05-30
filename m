Return-Path: <linux-btrfs+bounces-14317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C67AC91E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08AD9188337C
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 14:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF437235042;
	Fri, 30 May 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aR0EXnQ4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE9923182E
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616931; cv=none; b=euNoOJnOpwSnfWCBTpEfaBdh+n98t5xTFOP1b1C7A1MOX5lBvbgpKKhA5ZWQUz6cmCwrju7afNAiJYWcAxv5Sj2BmIHOSGJF/gnP2W9NMwvI9Wt93Ix044iO6G7tyOMkAiORVwhv5AiH4LRYOgFXPrV85IRVaRe6MPR2Sz4QeVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616931; c=relaxed/simple;
	bh=Q8v/DR7NQxBucKMslXTa+IrbJfsTtf60Gz+HJKuZKN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyoRAYpSm5ZoOqvhHCSnvnuOs6Gk+GGHri5ncs9jBkx96PrXlzzoHtppoUpeh5kxgM9Hbvecl+ZLLLoc+Z/jwebb74gybieSKmlMKiNi1t7LgbR7e4Rp+80v3psxZHzk52zy51dx+4ezwqj4PIME2LdCGnXDJPnsjygC6YOINh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aR0EXnQ4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748616929; x=1780152929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q8v/DR7NQxBucKMslXTa+IrbJfsTtf60Gz+HJKuZKN0=;
  b=aR0EXnQ4it3ETO5yUBv/tQFYejT5jJuViT4LlV1V9IgOb/CyIawUXetA
   UAparS8ySZ/dCUL3BlE+iOddg8i36qsFHIbRkRLGMdMaZ3woeW3l51ZlE
   aiBg4Xf80kUGOh0MXJ3yZKPzFETT3ZRsqyQo7pG1flA1eZ5X3+z5T+yQn
   efNMyhVk5b9QzC/5JLe2fUYtVWWLSEqNL3q8eo2SoS6JkIC2PtfaZ6obD
   45j1Pp9H0hnz+kPOsSU2SoNK1ozoL/6pgt5zYdcquvZtgXnEOopH+Jk2M
   fBr0AZc2bUcZ9+mAga0ZwTtOVDgtAFbdsTi3lsDWloAZGcZsWhvSPSZK/
   A==;
X-CSE-ConnectionGUID: HdUE8yuGS1m7ksB0jRb8tg==
X-CSE-MsgGUID: b5bq/9qbSUOuGInb+51IdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="54377295"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="54377295"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 07:55:28 -0700
X-CSE-ConnectionGUID: Zk6/FZVoQyyIX7ECVcdBAg==
X-CSE-MsgGUID: MNwQs+hsQ6G47gI7982M0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="148684096"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 30 May 2025 07:55:25 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uL18l-000Xi4-1n;
	Fri, 30 May 2025 14:55:23 +0000
Date: Fri, 30 May 2025 22:55:07 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: reserve data_reloc block group on mount
Message-ID: <202505302259.zSrfEvem-lkp@intel.com>
References: <1c24dcb591bbd2c70b7dcf2a2a8219eea1e06b55.1748604543.git.johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c24dcb591bbd2c70b7dcf2a2a8219eea1e06b55.1748604543.git.johannes.thumshirn@wdc.com>

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.15 next-20250530]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Thumshirn/btrfs-zoned-reserve-data_reloc-block-group-on-mount/20250530-193012
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/1c24dcb591bbd2c70b7dcf2a2a8219eea1e06b55.1748604543.git.johannes.thumshirn%40wdc.com
patch subject: [PATCH] btrfs: zoned: reserve data_reloc block group on mount
config: um-randconfig-001-20250530 (https://download.01.org/0day-ci/archive/20250530/202505302259.zSrfEvem-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250530/202505302259.zSrfEvem-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505302259.zSrfEvem-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/btrfs/disk-io.c: In function 'open_ctree':
>> fs/btrfs/disk-io.c:3563:43: error: passing argument 1 of 'btrfs_zoned_reserve_data_reloc_bg' from incompatible pointer type [-Werror=incompatible-pointer-types]
    3563 |         btrfs_zoned_reserve_data_reloc_bg(fs_info);
         |                                           ^~~~~~~
         |                                           |
         |                                           struct btrfs_fs_info *
   In file included from fs/btrfs/disk-io.c:42:
   fs/btrfs/zoned.h:245:80: note: expected 'struct btrfs_block_group *' but argument is of type 'struct btrfs_fs_info *'
     245 | static inline void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_block_group *bg) { }
         |                                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~^~
   cc1: some warnings being treated as errors


vim +/btrfs_zoned_reserve_data_reloc_bg +3563 fs/btrfs/disk-io.c

  3281	
  3282	int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices)
  3283	{
  3284		u32 sectorsize;
  3285		u32 nodesize;
  3286		u32 stripesize;
  3287		u64 generation;
  3288		u16 csum_type;
  3289		struct btrfs_super_block *disk_super;
  3290		struct btrfs_fs_info *fs_info = btrfs_sb(sb);
  3291		struct btrfs_root *tree_root;
  3292		struct btrfs_root *chunk_root;
  3293		int ret;
  3294		int level;
  3295	
  3296		ret = init_mount_fs_info(fs_info, sb);
  3297		if (ret)
  3298			goto fail;
  3299	
  3300		/* These need to be init'ed before we start creating inodes and such. */
  3301		tree_root = btrfs_alloc_root(fs_info, BTRFS_ROOT_TREE_OBJECTID,
  3302					     GFP_KERNEL);
  3303		fs_info->tree_root = tree_root;
  3304		chunk_root = btrfs_alloc_root(fs_info, BTRFS_CHUNK_TREE_OBJECTID,
  3305					      GFP_KERNEL);
  3306		fs_info->chunk_root = chunk_root;
  3307		if (!tree_root || !chunk_root) {
  3308			ret = -ENOMEM;
  3309			goto fail;
  3310		}
  3311	
  3312		ret = btrfs_init_btree_inode(sb);
  3313		if (ret)
  3314			goto fail;
  3315	
  3316		invalidate_bdev(fs_devices->latest_dev->bdev);
  3317	
  3318		/*
  3319		 * Read super block and check the signature bytes only
  3320		 */
  3321		disk_super = btrfs_read_disk_super(fs_devices->latest_dev->bdev, 0, false);
  3322		if (IS_ERR(disk_super)) {
  3323			ret = PTR_ERR(disk_super);
  3324			goto fail_alloc;
  3325		}
  3326	
  3327		btrfs_info(fs_info, "first mount of filesystem %pU", disk_super->fsid);
  3328		/*
  3329		 * Verify the type first, if that or the checksum value are
  3330		 * corrupted, we'll find out
  3331		 */
  3332		csum_type = btrfs_super_csum_type(disk_super);
  3333		if (!btrfs_supported_super_csum(csum_type)) {
  3334			btrfs_err(fs_info, "unsupported checksum algorithm: %u",
  3335				  csum_type);
  3336			ret = -EINVAL;
  3337			btrfs_release_disk_super(disk_super);
  3338			goto fail_alloc;
  3339		}
  3340	
  3341		fs_info->csum_size = btrfs_super_csum_size(disk_super);
  3342	
  3343		ret = btrfs_init_csum_hash(fs_info, csum_type);
  3344		if (ret) {
  3345			btrfs_release_disk_super(disk_super);
  3346			goto fail_alloc;
  3347		}
  3348	
  3349		/*
  3350		 * We want to check superblock checksum, the type is stored inside.
  3351		 * Pass the whole disk block of size BTRFS_SUPER_INFO_SIZE (4k).
  3352		 */
  3353		if (btrfs_check_super_csum(fs_info, disk_super)) {
  3354			btrfs_err(fs_info, "superblock checksum mismatch");
  3355			ret = -EINVAL;
  3356			btrfs_release_disk_super(disk_super);
  3357			goto fail_alloc;
  3358		}
  3359	
  3360		/*
  3361		 * super_copy is zeroed at allocation time and we never touch the
  3362		 * following bytes up to INFO_SIZE, the checksum is calculated from
  3363		 * the whole block of INFO_SIZE
  3364		 */
  3365		memcpy(fs_info->super_copy, disk_super, sizeof(*fs_info->super_copy));
  3366		btrfs_release_disk_super(disk_super);
  3367	
  3368		disk_super = fs_info->super_copy;
  3369	
  3370		memcpy(fs_info->super_for_commit, fs_info->super_copy,
  3371		       sizeof(*fs_info->super_for_commit));
  3372	
  3373		ret = btrfs_validate_mount_super(fs_info);
  3374		if (ret) {
  3375			btrfs_err(fs_info, "superblock contains fatal errors");
  3376			ret = -EINVAL;
  3377			goto fail_alloc;
  3378		}
  3379	
  3380		if (!btrfs_super_root(disk_super)) {
  3381			btrfs_err(fs_info, "invalid superblock tree root bytenr");
  3382			ret = -EINVAL;
  3383			goto fail_alloc;
  3384		}
  3385	
  3386		/* check FS state, whether FS is broken. */
  3387		if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_ERROR)
  3388			WRITE_ONCE(fs_info->fs_error, -EUCLEAN);
  3389	
  3390		/* Set up fs_info before parsing mount options */
  3391		nodesize = btrfs_super_nodesize(disk_super);
  3392		sectorsize = btrfs_super_sectorsize(disk_super);
  3393		stripesize = sectorsize;
  3394		fs_info->dirty_metadata_batch = nodesize * (1 + ilog2(nr_cpu_ids));
  3395		fs_info->delalloc_batch = sectorsize * 512 * (1 + ilog2(nr_cpu_ids));
  3396	
  3397		fs_info->nodesize = nodesize;
  3398		fs_info->sectorsize = sectorsize;
  3399		fs_info->sectorsize_bits = ilog2(sectorsize);
  3400		fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
  3401		fs_info->stripesize = stripesize;
  3402		fs_info->fs_devices->fs_info = fs_info;
  3403	
  3404		/*
  3405		 * Handle the space caching options appropriately now that we have the
  3406		 * super block loaded and validated.
  3407		 */
  3408		btrfs_set_free_space_cache_settings(fs_info);
  3409	
  3410		if (!btrfs_check_options(fs_info, &fs_info->mount_opt, sb->s_flags)) {
  3411			ret = -EINVAL;
  3412			goto fail_alloc;
  3413		}
  3414	
  3415		ret = btrfs_check_features(fs_info, !sb_rdonly(sb));
  3416		if (ret < 0)
  3417			goto fail_alloc;
  3418	
  3419		/*
  3420		 * At this point our mount options are validated, if we set ->max_inline
  3421		 * to something non-standard make sure we truncate it to sectorsize.
  3422		 */
  3423		fs_info->max_inline = min_t(u64, fs_info->max_inline, fs_info->sectorsize);
  3424	
  3425		ret = btrfs_init_workqueues(fs_info);
  3426		if (ret)
  3427			goto fail_sb_buffer;
  3428	
  3429		sb->s_bdi->ra_pages *= btrfs_super_num_devices(disk_super);
  3430		sb->s_bdi->ra_pages = max(sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
  3431	
  3432		/* Update the values for the current filesystem. */
  3433		sb->s_blocksize = sectorsize;
  3434		sb->s_blocksize_bits = blksize_bits(sectorsize);
  3435		memcpy(&sb->s_uuid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE);
  3436	
  3437		mutex_lock(&fs_info->chunk_mutex);
  3438		ret = btrfs_read_sys_array(fs_info);
  3439		mutex_unlock(&fs_info->chunk_mutex);
  3440		if (ret) {
  3441			btrfs_err(fs_info, "failed to read the system array: %d", ret);
  3442			goto fail_sb_buffer;
  3443		}
  3444	
  3445		generation = btrfs_super_chunk_root_generation(disk_super);
  3446		level = btrfs_super_chunk_root_level(disk_super);
  3447		ret = load_super_root(chunk_root, btrfs_super_chunk_root(disk_super),
  3448				      generation, level);
  3449		if (ret) {
  3450			btrfs_err(fs_info, "failed to read chunk root");
  3451			goto fail_tree_roots;
  3452		}
  3453	
  3454		read_extent_buffer(chunk_root->node, fs_info->chunk_tree_uuid,
  3455				   offsetof(struct btrfs_header, chunk_tree_uuid),
  3456				   BTRFS_UUID_SIZE);
  3457	
  3458		ret = btrfs_read_chunk_tree(fs_info);
  3459		if (ret) {
  3460			btrfs_err(fs_info, "failed to read chunk tree: %d", ret);
  3461			goto fail_tree_roots;
  3462		}
  3463	
  3464		/*
  3465		 * At this point we know all the devices that make this filesystem,
  3466		 * including the seed devices but we don't know yet if the replace
  3467		 * target is required. So free devices that are not part of this
  3468		 * filesystem but skip the replace target device which is checked
  3469		 * below in btrfs_init_dev_replace().
  3470		 */
  3471		btrfs_free_extra_devids(fs_devices);
  3472		if (!fs_devices->latest_dev->bdev) {
  3473			btrfs_err(fs_info, "failed to read devices");
  3474			ret = -EIO;
  3475			goto fail_tree_roots;
  3476		}
  3477	
  3478		ret = init_tree_roots(fs_info);
  3479		if (ret)
  3480			goto fail_tree_roots;
  3481	
  3482		/*
  3483		 * Get zone type information of zoned block devices. This will also
  3484		 * handle emulation of a zoned filesystem if a regular device has the
  3485		 * zoned incompat feature flag set.
  3486		 */
  3487		ret = btrfs_get_dev_zone_info_all_devices(fs_info);
  3488		if (ret) {
  3489			btrfs_err(fs_info,
  3490				  "zoned: failed to read device zone info: %d", ret);
  3491			goto fail_block_groups;
  3492		}
  3493	
  3494		/*
  3495		 * If we have a uuid root and we're not being told to rescan we need to
  3496		 * check the generation here so we can set the
  3497		 * BTRFS_FS_UPDATE_UUID_TREE_GEN bit.  Otherwise we could commit the
  3498		 * transaction during a balance or the log replay without updating the
  3499		 * uuid generation, and then if we crash we would rescan the uuid tree,
  3500		 * even though it was perfectly fine.
  3501		 */
  3502		if (fs_info->uuid_root && !btrfs_test_opt(fs_info, RESCAN_UUID_TREE) &&
  3503		    fs_info->generation == btrfs_super_uuid_tree_generation(disk_super))
  3504			set_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags);
  3505	
  3506		ret = btrfs_verify_dev_extents(fs_info);
  3507		if (ret) {
  3508			btrfs_err(fs_info,
  3509				  "failed to verify dev extents against chunks: %d",
  3510				  ret);
  3511			goto fail_block_groups;
  3512		}
  3513		ret = btrfs_recover_balance(fs_info);
  3514		if (ret) {
  3515			btrfs_err(fs_info, "failed to recover balance: %d", ret);
  3516			goto fail_block_groups;
  3517		}
  3518	
  3519		ret = btrfs_init_dev_stats(fs_info);
  3520		if (ret) {
  3521			btrfs_err(fs_info, "failed to init dev_stats: %d", ret);
  3522			goto fail_block_groups;
  3523		}
  3524	
  3525		ret = btrfs_init_dev_replace(fs_info);
  3526		if (ret) {
  3527			btrfs_err(fs_info, "failed to init dev_replace: %d", ret);
  3528			goto fail_block_groups;
  3529		}
  3530	
  3531		ret = btrfs_check_zoned_mode(fs_info);
  3532		if (ret) {
  3533			btrfs_err(fs_info, "failed to initialize zoned mode: %d",
  3534				  ret);
  3535			goto fail_block_groups;
  3536		}
  3537	
  3538		ret = btrfs_sysfs_add_fsid(fs_devices);
  3539		if (ret) {
  3540			btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
  3541					ret);
  3542			goto fail_block_groups;
  3543		}
  3544	
  3545		ret = btrfs_sysfs_add_mounted(fs_info);
  3546		if (ret) {
  3547			btrfs_err(fs_info, "failed to init sysfs interface: %d", ret);
  3548			goto fail_fsdev_sysfs;
  3549		}
  3550	
  3551		ret = btrfs_init_space_info(fs_info);
  3552		if (ret) {
  3553			btrfs_err(fs_info, "failed to initialize space info: %d", ret);
  3554			goto fail_sysfs;
  3555		}
  3556	
  3557		ret = btrfs_read_block_groups(fs_info);
  3558		if (ret) {
  3559			btrfs_err(fs_info, "failed to read block groups: %d", ret);
  3560			goto fail_sysfs;
  3561		}
  3562	
> 3563		btrfs_zoned_reserve_data_reloc_bg(fs_info);
  3564		btrfs_free_zone_cache(fs_info);
  3565	
  3566		btrfs_check_active_zone_reservation(fs_info);
  3567	
  3568		if (!sb_rdonly(sb) && fs_info->fs_devices->missing_devices &&
  3569		    !btrfs_check_rw_degradable(fs_info, NULL)) {
  3570			btrfs_warn(fs_info,
  3571			"writable mount is not allowed due to too many missing devices");
  3572			ret = -EINVAL;
  3573			goto fail_sysfs;
  3574		}
  3575	
  3576		fs_info->cleaner_kthread = kthread_run(cleaner_kthread, fs_info,
  3577						       "btrfs-cleaner");
  3578		if (IS_ERR(fs_info->cleaner_kthread)) {
  3579			ret = PTR_ERR(fs_info->cleaner_kthread);
  3580			goto fail_sysfs;
  3581		}
  3582	
  3583		fs_info->transaction_kthread = kthread_run(transaction_kthread,
  3584							   tree_root,
  3585							   "btrfs-transaction");
  3586		if (IS_ERR(fs_info->transaction_kthread)) {
  3587			ret = PTR_ERR(fs_info->transaction_kthread);
  3588			goto fail_cleaner;
  3589		}
  3590	
  3591		ret = btrfs_read_qgroup_config(fs_info);
  3592		if (ret)
  3593			goto fail_trans_kthread;
  3594	
  3595		if (btrfs_build_ref_tree(fs_info))
  3596			btrfs_err(fs_info, "couldn't build ref tree");
  3597	
  3598		/* do not make disk changes in broken FS or nologreplay is given */
  3599		if (btrfs_super_log_root(disk_super) != 0 &&
  3600		    !btrfs_test_opt(fs_info, NOLOGREPLAY)) {
  3601			btrfs_info(fs_info, "start tree-log replay");
  3602			ret = btrfs_replay_log(fs_info, fs_devices);
  3603			if (ret)
  3604				goto fail_qgroup;
  3605		}
  3606	
  3607		fs_info->fs_root = btrfs_get_fs_root(fs_info, BTRFS_FS_TREE_OBJECTID, true);
  3608		if (IS_ERR(fs_info->fs_root)) {
  3609			ret = PTR_ERR(fs_info->fs_root);
  3610			btrfs_warn(fs_info, "failed to read fs tree: %d", ret);
  3611			fs_info->fs_root = NULL;
  3612			goto fail_qgroup;
  3613		}
  3614	
  3615		if (sb_rdonly(sb))
  3616			return 0;
  3617	
  3618		ret = btrfs_start_pre_rw_mount(fs_info);
  3619		if (ret) {
  3620			close_ctree(fs_info);
  3621			return ret;
  3622		}
  3623		btrfs_discard_resume(fs_info);
  3624	
  3625		if (fs_info->uuid_root &&
  3626		    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
  3627		     fs_info->generation != btrfs_super_uuid_tree_generation(disk_super))) {
  3628			btrfs_info(fs_info, "checking UUID tree");
  3629			ret = btrfs_check_uuid_tree(fs_info);
  3630			if (ret) {
  3631				btrfs_warn(fs_info,
  3632					"failed to check the UUID tree: %d", ret);
  3633				close_ctree(fs_info);
  3634				return ret;
  3635			}
  3636		}
  3637	
  3638		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
  3639	
  3640		/* Kick the cleaner thread so it'll start deleting snapshots. */
  3641		if (test_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags))
  3642			wake_up_process(fs_info->cleaner_kthread);
  3643	
  3644		return 0;
  3645	
  3646	fail_qgroup:
  3647		btrfs_free_qgroup_config(fs_info);
  3648	fail_trans_kthread:
  3649		kthread_stop(fs_info->transaction_kthread);
  3650		btrfs_cleanup_transaction(fs_info);
  3651		btrfs_free_fs_roots(fs_info);
  3652	fail_cleaner:
  3653		kthread_stop(fs_info->cleaner_kthread);
  3654	
  3655		/*
  3656		 * make sure we're done with the btree inode before we stop our
  3657		 * kthreads
  3658		 */
  3659		filemap_write_and_wait(fs_info->btree_inode->i_mapping);
  3660	
  3661	fail_sysfs:
  3662		btrfs_sysfs_remove_mounted(fs_info);
  3663	
  3664	fail_fsdev_sysfs:
  3665		btrfs_sysfs_remove_fsid(fs_info->fs_devices);
  3666	
  3667	fail_block_groups:
  3668		btrfs_put_block_group_cache(fs_info);
  3669	
  3670	fail_tree_roots:
  3671		if (fs_info->data_reloc_root)
  3672			btrfs_drop_and_free_fs_root(fs_info, fs_info->data_reloc_root);
  3673		free_root_pointers(fs_info, true);
  3674		invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
  3675	
  3676	fail_sb_buffer:
  3677		btrfs_stop_all_workers(fs_info);
  3678		btrfs_free_block_groups(fs_info);
  3679	fail_alloc:
  3680		btrfs_mapping_tree_free(fs_info);
  3681	
  3682		iput(fs_info->btree_inode);
  3683	fail:
  3684		btrfs_close_devices(fs_info->fs_devices);
  3685		ASSERT(ret < 0);
  3686		return ret;
  3687	}
  3688	ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
  3689	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

