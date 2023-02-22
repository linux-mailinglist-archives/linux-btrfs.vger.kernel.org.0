Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D5769F293
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 11:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjBVKVN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 05:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjBVKVM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 05:21:12 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375F632E7F
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 02:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677061271; x=1708597271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sEi1Fi/Tei/qpxQY5+15dlIa56v/nFH49uu7QNT+WT4=;
  b=InzYdC7vGdTBlUv8BU+x75UUE8UI1aRaZzr/crDwgFpF8/EqUsct4vXT
   3klU0bIz/kmCY8xHsAdcapoPMTALNEiwGatfIQVM/aXIxC9joeptocCvl
   ZOOHzJAS4ejr84iQ5qu2pShD/AM475kvOavOefiuQSYNpHFy1Ph4Bu4b6
   Ns1LsFrQRODXuVsDcf6SNfIAMA+ltsLMVYoVteCAuZ8yX49reYjHUPzCB
   +ywDTuguWvPmq/NVXx4jZD8+XU+y0lwfM0qHoyrlHhaZ88byR7McYVTr8
   avdneSpuLeOdSwwzOSrPBgT7E1xHPaDC7Rxd7jbii5bDON8Oxr1c5XLG4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="335085954"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="335085954"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 02:21:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="740755933"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="740755933"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Feb 2023 02:21:08 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUmFI-0000En-0c;
        Wed, 22 Feb 2023 10:21:08 +0000
Date:   Wed, 22 Feb 2023 18:20:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v4] btrfs: make dev-replace properly follow its read mode
Message-ID: <202302221816.1fqvNytO-lkp@intel.com>
References: <9abbfc83c08b2cea215f870f26c553b58fbabeab.1677048584.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9abbfc83c08b2cea215f870f26c553b58fbabeab.1677048584.git.wqu@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.2 next-20230222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-make-dev-replace-properly-follow-its-read-mode/20230222-150629
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/9abbfc83c08b2cea215f870f26c553b58fbabeab.1677048584.git.wqu%40suse.com
patch subject: [PATCH v4] btrfs: make dev-replace properly follow its read mode
config: s390-randconfig-r013-20230222 (https://download.01.org/0day-ci/archive/20230222/202302221816.1fqvNytO-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/07c729ddc3a8f3074e5f61c4def8836bdfc37f73
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qu-Wenruo/btrfs-make-dev-replace-properly-follow-its-read-mode/20230222-150629
        git checkout 07c729ddc3a8f3074e5f61c4def8836bdfc37f73
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302221816.1fqvNytO-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/btrfs/scrub.c:2762:44: error: no member named 'replace_nr_stripes' in 'struct btrfs_io_context'
           for (i = 0; i < bioc->num_stripes - bioc->replace_nr_stripes; i++) {
                                               ~~~~  ^
   fs/btrfs/scrub.c:2773:44: error: no member named 'replace_nr_stripes' in 'struct btrfs_io_context'
           for (i = 0; i < bioc->num_stripes - bioc->replace_nr_stripes; i++) {
                                               ~~~~  ^
   2 errors generated.


vim +2762 fs/btrfs/scrub.c

  2704	
  2705	static bool should_use_device(struct btrfs_fs_info *fs_info,
  2706				      struct btrfs_device *dev,
  2707				      bool follow_replace_read_mode)
  2708	{
  2709		struct btrfs_device *replace_srcdev = fs_info->dev_replace.srcdev;
  2710		struct btrfs_device *replace_tgtdev = fs_info->dev_replace.tgtdev;
  2711	
  2712		if (!dev->bdev)
  2713			return false;
  2714	
  2715		/*
  2716		 * We're doing scrub/replace, if it's pure scrub, no tgtdev should be
  2717		 * here.
  2718		 * If it's replace, we're going to write data to tgtdev, thus the current
  2719		 * data of the tgtdev is all garbage, thus we can not use it at all.
  2720		 */
  2721		if (dev == replace_tgtdev)
  2722			return false;
  2723	
  2724		/* No need to follow replace read policy, any existing device is fine. */
  2725		if (!follow_replace_read_mode)
  2726			return true;
  2727	
  2728		/* Need to follow the policy. */
  2729		if (fs_info->dev_replace.cont_reading_from_srcdev_mode ==
  2730		    BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID)
  2731			return dev != replace_srcdev;
  2732		return true;
  2733	}
  2734	static int scrub_find_good_copy(struct btrfs_fs_info *fs_info,
  2735					u64 extent_logical, u32 extent_len,
  2736					u64 *extent_physical,
  2737					struct btrfs_device **extent_dev,
  2738					int *extent_mirror_num)
  2739	{
  2740		u64 mapped_length;
  2741		struct btrfs_io_context *bioc = NULL;
  2742		int ret;
  2743		int i;
  2744	
  2745		mapped_length = extent_len;
  2746		ret = btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
  2747				      extent_logical, &mapped_length, &bioc, 0);
  2748		if (ret || !bioc || mapped_length < extent_len) {
  2749			btrfs_put_bioc(bioc);
  2750			btrfs_err_rl(fs_info, "btrfs_map_block() failed for logical %llu: %d",
  2751					extent_logical, ret);
  2752			return -EIO;
  2753		}
  2754	
  2755		/*
  2756		 * First loop to exclude all missing devices and the source
  2757		 * device if needed.
  2758		 * And we don't want to use target device as mirror either,
  2759		 * as we're doing the replace, the target device range
  2760		 * contains nothing.
  2761		 */
> 2762		for (i = 0; i < bioc->num_stripes - bioc->replace_nr_stripes; i++) {
  2763			struct btrfs_io_stripe *stripe = &bioc->stripes[i];
  2764	
  2765			if (!should_use_device(fs_info, stripe->dev, true))
  2766				continue;
  2767			goto found;
  2768		}
  2769		/*
  2770		 * We didn't find any alternative mirrors, we have to break our
  2771		 * replace read mode, or we can not read at all.
  2772		 */
  2773		for (i = 0; i < bioc->num_stripes - bioc->replace_nr_stripes; i++) {
  2774			struct btrfs_io_stripe *stripe = &bioc->stripes[i];
  2775	
  2776			if (!should_use_device(fs_info, stripe->dev, false))
  2777				continue;
  2778			goto found;
  2779		}
  2780	
  2781		btrfs_err_rl(fs_info, "failed to find any live mirror for logical %llu",
  2782				extent_logical);
  2783		return -EIO;
  2784	
  2785	found:
  2786		*extent_physical = bioc->stripes[i].physical;
  2787		*extent_mirror_num = i + 1;
  2788		*extent_dev = bioc->stripes[i].dev;
  2789		btrfs_put_bioc(bioc);
  2790		return 0;
  2791	}
  2792	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
