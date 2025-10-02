Return-Path: <linux-btrfs+bounces-17338-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE8FBB496D
	for <lists+linux-btrfs@lfdr.de>; Thu, 02 Oct 2025 18:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E8034E1E86
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Oct 2025 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8E92566D3;
	Thu,  2 Oct 2025 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WkY1vicz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40231D88A6
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Oct 2025 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759423651; cv=none; b=F18VN+ZGPnnyMC4TzJTmLQNPKnRwvbnxSxoy2OQfczkBOyyuZBlpXMV7SJNlVNoTEyOcqvcN9BYkkRkMWAF/MKQmqvkmmUALmOxRlDSZJ6SPNd5C5mHrvE2jpHtGFW5fAKUXqUw7wVuqKqVN4k9OBAaRsf6LKAg5Fr9AjMB+cqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759423651; c=relaxed/simple;
	bh=9xMMsceNwRO2MwP3HKE9fLK7gSGejApiZWfvmMfWFLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBUJoSHk3Z99Yl1X2V7CY+/JamcXyQMA6BuCk1W8RPJQqQh2WVzccxFy/MdBdfLnv9vHw2ZX1gPDnyRy+MbY+XHl20C4BwQ0FSKXQbSq75ZnjfZrlGyQEqVrHghgVjkpRz9h7SLgzbHpwToY4X3GEtEHpReDdmRTCd2Tw4R1PfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WkY1vicz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759423650; x=1790959650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9xMMsceNwRO2MwP3HKE9fLK7gSGejApiZWfvmMfWFLw=;
  b=WkY1viczCQPlf/tsc2gzcwd0MpNRwcmxPuYDOGmYby2a0EHahQvJWyma
   53k7W3jhXEBdxsow5SJOq2LF8XzP9k35HwnVvMVaDs9Zfobnd0ZHXGRKX
   is3mnfHGFaLLP2KEXy0Nv3qnTko+o2C9eDjJxGgAsTNalJrc9SZycJLVZ
   zoCOeK3uYBNXZVnMiloiOIujVbMTyFr5kuSrElCswckC7jMas098ANgQd
   4XWxv71kYyayUl3mu9n+lVBoLdmsCgTK9bxWiQEzVqDTHX7GjFILfJc0I
   B16Xnp17Q9L4RJ97F7ajjAi7IJvb9O3gcYtEwskB5s3TlnVwFgdisvBe7
   w==;
X-CSE-ConnectionGUID: pRhTljpSQMewfp7u2gJ0lw==
X-CSE-MsgGUID: mBHB7tAjQYGlIdVNUrCMWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61423012"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="61423012"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 09:47:29 -0700
X-CSE-ConnectionGUID: 44bEQ97dSkWJcgwOSQ6KZQ==
X-CSE-MsgGUID: KfDA4Z49T6a2pzDZSsVbrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="179521856"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 02 Oct 2025 09:47:28 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v4MSj-0003xP-1z;
	Thu, 02 Oct 2025 16:47:25 +0000
Date: Fri, 3 Oct 2025 00:46:37 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/4] btrfs: make btrfs_repair_io_failure() handle bs > ps
 cases without large folios
Message-ID: <202510030041.mTtTa2Pr-lkp@intel.com>
References: <33c39907866c148a360ff60387097fbad63a19aa.1759311101.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33c39907866c148a360ff60387097fbad63a19aa.1759311101.git.wqu@suse.com>

Hi Qu,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master next-20250929]
[cannot apply to v6.17]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-make-btrfs_csum_one_bio-handle-bs-ps-without-large-folios/20251001-175128
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/33c39907866c148a360ff60387097fbad63a19aa.1759311101.git.wqu%40suse.com
patch subject: [PATCH 2/4] btrfs: make btrfs_repair_io_failure() handle bs > ps cases without large folios
config: i386-randconfig-011-20251002 (https://download.01.org/0day-ci/archive/20251003/202510030041.mTtTa2Pr-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251003/202510030041.mTtTa2Pr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510030041.mTtTa2Pr-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: fs/btrfs/bio.o: in function `btrfs_repair_io_failure':
>> fs/btrfs/bio.c:859:(.text+0x188c): undefined reference to `__udivdi3'


vim +859 fs/btrfs/bio.c

   836	
   837	/*
   838	 * Submit a repair write.
   839	 *
   840	 * This bypasses btrfs_submit_bbio() deliberately, as that writes all copies in a
   841	 * RAID setup.  Here we only want to write the one bad copy, so we do the
   842	 * mapping ourselves and submit the bio directly.
   843	 *
   844	 * The I/O is issued synchronously to block the repair read completion from
   845	 * freeing the bio.
   846	 *
   847	 * @ino:	Offending inode number
   848	 * @fileoff:	File offset inside the inode
   849	 * @length:	Length of the repair write
   850	 * @logical:	Logical address of the range
   851	 * @paddrs:	Physical address array of the content.
   852	 *		Length for each paddr should be min(sectorsize, PAGE_SIZE).
   853	 * @mirror_num: Mirror number to write to. Must not be zero.
   854	 */
   855	int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 fileoff,
   856				    u64 length, u64 logical, const phys_addr_t paddrs[], int mirror_num)
   857	{
   858		const u32 step = min(fs_info->sectorsize, PAGE_SIZE);
 > 859		const u32 nr_steps = DIV_ROUND_UP_POW2(length, step);
   860		struct btrfs_io_stripe smap = { 0 };
   861		struct bio *bio = NULL;
   862		int ret = 0;
   863	
   864		ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
   865		BUG_ON(!mirror_num);
   866	
   867		/* Basic alignment checks. */
   868		ASSERT(IS_ALIGNED(logical, fs_info->sectorsize));
   869		ASSERT(IS_ALIGNED(length, fs_info->sectorsize));
   870		ASSERT(IS_ALIGNED(fileoff, fs_info->sectorsize));
   871	
   872		if (btrfs_repair_one_zone(fs_info, logical))
   873			return 0;
   874	
   875		/*
   876		 * Avoid races with device replace and make sure our bioc has devices
   877		 * associated to its stripes that don't go away while we are doing the
   878		 * read repair operation.
   879		 */
   880		btrfs_bio_counter_inc_blocked(fs_info);
   881		ret = btrfs_map_repair_block(fs_info, &smap, logical, length, mirror_num);
   882		if (ret < 0)
   883			goto out_counter_dec;
   884	
   885		if (unlikely(!smap.dev->bdev ||
   886			     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &smap.dev->dev_state))) {
   887			ret = -EIO;
   888			goto out_counter_dec;
   889		}
   890	
   891		bio = bio_alloc(smap.dev->bdev, nr_steps, REQ_OP_WRITE | REQ_SYNC, GFP_NOFS);
   892		/* Backed by fs_bio_set, shouldn't fail. */
   893		ASSERT(bio);
   894		bio->bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
   895		for (int i = 0; i < nr_steps; i++) {
   896			ret = bio_add_page(bio, phys_to_page(paddrs[i]), step, offset_in_page(paddrs[i]));
   897			/* We should have allocated enough slots to contain all the different pages. */
   898			ASSERT(ret == step);
   899		}
   900		ret = submit_bio_wait(bio);
   901		if (ret) {
   902			/* try to remap that extent elsewhere? */
   903			btrfs_dev_stat_inc_and_print(smap.dev, BTRFS_DEV_STAT_WRITE_ERRS);
   904			goto out_free_bio;
   905		}
   906	
   907		btrfs_info_rl(fs_info,
   908			"read error corrected: ino %llu off %llu (dev %s sector %llu)",
   909				     ino, fileoff, btrfs_dev_name(smap.dev),
   910				     smap.physical >> SECTOR_SHIFT);
   911		ret = 0;
   912	
   913	out_free_bio:
   914		if (bio)
   915			bio_put(bio);
   916	out_counter_dec:
   917		btrfs_bio_counter_dec(fs_info);
   918		return ret;
   919	}
   920	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

