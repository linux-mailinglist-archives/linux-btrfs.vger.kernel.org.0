Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530B26B7304
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Mar 2023 10:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjCMJpV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Mar 2023 05:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCMJpL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Mar 2023 05:45:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191EF20D3C
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 02:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678700710; x=1710236710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/T6IuNMp9hcjQyUHOMww1SBI2NJsOyDeL0Q9XjSabwA=;
  b=Z/CpS8q+LZX+x/L4a7OggODagTXNJHL1KZVvQsWiIJdMMifaIryp02Dm
   T1Npd2VXVI4UZdg70E6Q95XuNa8Kozvw+HrKA8fJkAR3kdmk1Gsjiuows
   j+nAeWoYo43BFg6l+GK1dsYknCVIFIHvzgkUQOLEv+Xbr8azLOjEPPqL8
   00Pqmp2UyJgd749/zCFH1DGWuFf7CoqXWT9y2p6ii5QgzA4uLd/iJ3Ed2
   BlvrXcPqBtSiMggOOg0DguEs/er73bY1O07wbTdCz8MazVrS25lli70p4
   VZsG4JxGzX9eV8FArN7+Y65H+J8IMU0zD6Gn/sPWPBjIuVsx0SV2pMXCn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="334582268"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="334582268"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 02:45:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="711063569"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="711063569"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Mar 2023 02:45:08 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pbejr-0005X4-2i;
        Mon, 13 Mar 2023 09:45:07 +0000
Date:   Mon, 13 Mar 2023 17:44:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 1/2] btrfs: zoned: count fresh BG region as zone unusable
Message-ID: <202303131759.8M0pXaNR-lkp@intel.com>
References: <bdcc434abd271dfd2b75c1b018ed6dbe425f562e.1678689012.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdcc434abd271dfd2b75c1b018ed6dbe425f562e.1678689012.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Naohiro,

I love your patch! Yet something to improve:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.3-rc2 next-20230310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Naohiro-Aota/btrfs-zoned-count-fresh-BG-region-as-zone-unusable/20230313-150709
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/bdcc434abd271dfd2b75c1b018ed6dbe425f562e.1678689012.git.naohiro.aota%40wdc.com
patch subject: [PATCH 1/2] btrfs: zoned: count fresh BG region as zone unusable
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20230313/202303131759.8M0pXaNR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/c266ae6ba937488d8339e586ebcc8c93d3389eb0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Naohiro-Aota/btrfs-zoned-count-fresh-BG-region-as-zone-unusable/20230313-150709
        git checkout c266ae6ba937488d8339e586ebcc8c93d3389eb0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303131759.8M0pXaNR-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:22,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from include/linux/pagemap.h:8,
                    from fs/btrfs/free-space-cache.c:6:
   fs/btrfs/free-space-cache.c: In function '__btrfs_add_free_space_zoned':
>> fs/btrfs/free-space-cache.c:2700:27: error: 'BTRFS_FS_ACTIVE_ZONE_TRACKING' undeclared (first use in this function)
    2700 |                  test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &block_group->fs_info->flags) &&
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitops.h:49:32: note: in definition of macro 'bitop'
      49 |         ((__builtin_constant_p(nr) &&                                   \
         |                                ^~
   fs/btrfs/free-space-cache.c:2700:18: note: in expansion of macro 'test_bit'
    2700 |                  test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &block_group->fs_info->flags) &&
         |                  ^~~~~~~~
   fs/btrfs/free-space-cache.c:2700:27: note: each undeclared identifier is reported only once for each function it appears in
    2700 |                  test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &block_group->fs_info->flags) &&
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitops.h:49:32: note: in definition of macro 'bitop'
      49 |         ((__builtin_constant_p(nr) &&                                   \
         |                                ^~
   fs/btrfs/free-space-cache.c:2700:18: note: in expansion of macro 'test_bit'
    2700 |                  test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &block_group->fs_info->flags) &&
         |                  ^~~~~~~~
--
   In file included from fs/btrfs/zoned.c:3:
   fs/btrfs/zoned.c: In function 'btrfs_calc_zone_unusable':
>> fs/btrfs/zoned.c:1586:22: error: 'BTRFS_FS_ACTIVE_ZONE_TRACKING' undeclared (first use in this function)
    1586 |         if (test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &cache->fs_info->flags) &&
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitops.h:49:32: note: in definition of macro 'bitop'
      49 |         ((__builtin_constant_p(nr) &&                                   \
         |                                ^~
   fs/btrfs/zoned.c:1586:13: note: in expansion of macro 'test_bit'
    1586 |         if (test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &cache->fs_info->flags) &&
         |             ^~~~~~~~
   fs/btrfs/zoned.c:1586:22: note: each undeclared identifier is reported only once for each function it appears in
    1586 |         if (test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &cache->fs_info->flags) &&
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitops.h:49:32: note: in definition of macro 'bitop'
      49 |         ((__builtin_constant_p(nr) &&                                   \
         |                                ^~
   fs/btrfs/zoned.c:1586:13: note: in expansion of macro 'test_bit'
    1586 |         if (test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &cache->fs_info->flags) &&
         |             ^~~~~~~~


vim +/BTRFS_FS_ACTIVE_ZONE_TRACKING +2700 fs/btrfs/free-space-cache.c

  2678	
  2679	static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
  2680						u64 bytenr, u64 size, bool used)
  2681	{
  2682		struct btrfs_space_info *sinfo = block_group->space_info;
  2683		struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
  2684		u64 offset = bytenr - block_group->start;
  2685		u64 to_free, to_unusable;
  2686		int bg_reclaim_threshold = 0;
  2687		bool initial = (size == block_group->length);
  2688		u64 reclaimable_unusable;
  2689	
  2690		WARN_ON(!initial && offset + size > block_group->zone_capacity);
  2691	
  2692		if (!initial)
  2693			bg_reclaim_threshold = READ_ONCE(sinfo->bg_reclaim_threshold);
  2694	
  2695		spin_lock(&ctl->tree_lock);
  2696		/* Count initial region as zone_unusable until it gets activated. */
  2697		if (!used)
  2698			to_free = size;
  2699		else if (initial &&
> 2700			 test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &block_group->fs_info->flags) &&
  2701			 block_group->flags & (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM))
  2702			to_free = 0;
  2703		else if (initial)
  2704			to_free = block_group->zone_capacity;
  2705		else if (offset >= block_group->alloc_offset)
  2706			to_free = size;
  2707		else if (offset + size <= block_group->alloc_offset)
  2708			to_free = 0;
  2709		else
  2710			to_free = offset + size - block_group->alloc_offset;
  2711		to_unusable = size - to_free;
  2712	
  2713		ctl->free_space += to_free;
  2714		/*
  2715		 * If the block group is read-only, we should account freed space into
  2716		 * bytes_readonly.
  2717		 */
  2718		if (!block_group->ro)
  2719			block_group->zone_unusable += to_unusable;
  2720		spin_unlock(&ctl->tree_lock);
  2721		if (!used) {
  2722			spin_lock(&block_group->lock);
  2723			block_group->alloc_offset -= size;
  2724			spin_unlock(&block_group->lock);
  2725		}
  2726	
  2727		reclaimable_unusable = block_group->zone_unusable -
  2728				       (block_group->length - block_group->zone_capacity);
  2729		/* All the region is now unusable. Mark it as unused and reclaim */
  2730		if (block_group->zone_unusable == block_group->length &&
  2731		    block_group->alloc_offset) {
  2732			btrfs_mark_bg_unused(block_group);
  2733		} else if (bg_reclaim_threshold &&
  2734			   reclaimable_unusable >=
  2735			   mult_perc(block_group->zone_capacity, bg_reclaim_threshold)) {
  2736			btrfs_mark_bg_to_reclaim(block_group);
  2737		}
  2738	
  2739		return 0;
  2740	}
  2741	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
