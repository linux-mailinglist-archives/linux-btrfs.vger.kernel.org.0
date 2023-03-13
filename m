Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5076B7731
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Mar 2023 13:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCMMJS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Mar 2023 08:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCMMJR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Mar 2023 08:09:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C59322DEA
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 05:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678709355; x=1710245355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lv+YmFQZdWbyw1qbfd55OBvvBnDoJKDY+8E3ElIHRyE=;
  b=jj1PMM8wyu4zYe7uN5XLOZXIHjhSKEHI87AJry/w9/2SKdndAx+Rr1Fi
   cK36lwq6UxzOXP27jDI4EU36HYxzuJ+QeuAk5wzrqu27AJnSC0BImvLjN
   84T9o83nBWGOOWidSZWI2WUKBFxSysFP1HNe7mkvHecddbyh88QKVJTxE
   OcdAjtlaWea3VojEcJQnYAfXokJ+Yp2qspSmX5nvMXqhQlmtZq5NR597h
   yHHaIMW9wedQk3nqlJkLKQZPHIfT3ZrjMYV4O/n7qI1q7MZkqSNP+TUtG
   +dfn1qlNCKkik617BhCV0JO6p/5bZsMOGYUDC/MUgao+R4EYhfBYIFFkQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="401999761"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="401999761"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 05:09:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="671878252"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="671878252"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 Mar 2023 05:09:13 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pbgzJ-0005e6-0i;
        Mon, 13 Mar 2023 12:09:13 +0000
Date:   Mon, 13 Mar 2023 20:08:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 1/2] btrfs: zoned: count fresh BG region as zone unusable
Message-ID: <202303131915.APpbxwaX-lkp@intel.com>
References: <bdcc434abd271dfd2b75c1b018ed6dbe425f562e.1678689012.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdcc434abd271dfd2b75c1b018ed6dbe425f562e.1678689012.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: x86_64-randconfig-r025-20230313 (https://download.01.org/0day-ci/archive/20230313/202303131915.APpbxwaX-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c266ae6ba937488d8339e586ebcc8c93d3389eb0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Naohiro-Aota/btrfs-zoned-count-fresh-BG-region-as-zone-unusable/20230313-150709
        git checkout c266ae6ba937488d8339e586ebcc8c93d3389eb0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303131915.APpbxwaX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/btrfs/free-space-cache.c:2700:13: error: use of undeclared identifier 'BTRFS_FS_ACTIVE_ZONE_TRACKING'
                    test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &block_group->fs_info->flags) &&
                             ^
>> fs/btrfs/free-space-cache.c:2700:13: error: use of undeclared identifier 'BTRFS_FS_ACTIVE_ZONE_TRACKING'
>> fs/btrfs/free-space-cache.c:2700:13: error: use of undeclared identifier 'BTRFS_FS_ACTIVE_ZONE_TRACKING'
   3 errors generated.


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
