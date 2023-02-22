Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF1869EF30
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 08:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjBVHRO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 02:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjBVHRJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 02:17:09 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006633668A
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 23:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677050224; x=1708586224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pVEp1PoQoB73sV3lchurCEEPk/szGoF5+p5XDHU7KYk=;
  b=ib23W534g3sps6S6G5OAjuXv1oKAHruftLs/+9cZw1T+2Z1UJuAKoikP
   1e8ZLEb4UmnRYieM2cGmBkfuhcVPIG/wiJe6GTJg3QMvaeTxG5pCXxPB8
   3DTjFFIKaVWY2mh92+p1Lv9eJoxPQZOie65jH/Wpj6/1zxiHfRcp8znQT
   vB5MinOKHmfgqFbTpm3VRq+glI5x1IFMNlaYhNLIlblFKoMg7r944aGag
   pHCjqNXHs+uDulHYE/Zbc+vv3ySuVBzN+KtnGF//l2HHPYm7XYRfqESsJ
   KGJFfIl7M26RxitlTFiloTBQ35JvmAzZ5hzGgV02doK4gWAqmIRuUJcLX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="335051039"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="335051039"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 23:17:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="665251890"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="665251890"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 21 Feb 2023 23:17:01 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUjN6-00006X-1u;
        Wed, 22 Feb 2023 07:17:00 +0000
Date:   Wed, 22 Feb 2023 15:16:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] btrfs: scrub: fix an error in stripe offset calculation
Message-ID: <202302221532.TzU0U9gm-lkp@intel.com>
References: <c8f91363ab2e7ca24edbddf1feeca6c9fcf34f6e.1677033010.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8f91363ab2e7ca24edbddf1feeca6c9fcf34f6e.1677033010.git.wqu@suse.com>
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

[auto build test ERROR on next-20230221]
[cannot apply to kdave/for-next v6.2 v6.2-rc8 v6.2-rc7 linus/master v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-scrub-fix-an-error-in-stripe-offset-calculation/20230222-103158
patch link:    https://lore.kernel.org/r/c8f91363ab2e7ca24edbddf1feeca6c9fcf34f6e.1677033010.git.wqu%40suse.com
patch subject: [PATCH] btrfs: scrub: fix an error in stripe offset calculation
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20230222/202302221532.TzU0U9gm-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ede724f4f7127f86931756949269770a7197339c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qu-Wenruo/btrfs-scrub-fix-an-error-in-stripe-offset-calculation/20230222-103158
        git checkout ede724f4f7127f86931756949269770a7197339c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302221532.TzU0U9gm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/btrfs/scrub.c:1456:6: error: use of undeclared identifier 'BTRFS_STRIPE_LEN_MASK'
                                    BTRFS_STRIPE_LEN_MASK;
                                    ^
   1 error generated.


vim +/BTRFS_STRIPE_LEN_MASK +1456 fs/btrfs/scrub.c

  1431	
  1432	static inline void scrub_stripe_index_and_offset(u64 logical, u64 map_type,
  1433							 u64 full_stripe_logical,
  1434							 int nstripes, int mirror,
  1435							 int *stripe_index,
  1436							 u64 *stripe_offset)
  1437	{
  1438		int i;
  1439	
  1440		if (map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
  1441			const int nr_data_stripes = (map_type & BTRFS_BLOCK_GROUP_RAID5) ?
  1442						    nstripes - 1 : nstripes - 2;
  1443	
  1444			/* RAID5/6 */
  1445			for (i = 0; i < nr_data_stripes; i++) {
  1446				const u64 data_stripe_start = full_stripe_logical +
  1447							(i * BTRFS_STRIPE_LEN);
  1448	
  1449				if (logical >= data_stripe_start &&
  1450				    logical < data_stripe_start + BTRFS_STRIPE_LEN)
  1451					break;
  1452			}
  1453	
  1454			*stripe_index = i;
  1455			*stripe_offset = (logical - full_stripe_logical) &
> 1456					 BTRFS_STRIPE_LEN_MASK;
  1457		} else {
  1458			/* The other RAID type */
  1459			*stripe_index = mirror;
  1460			*stripe_offset = 0;
  1461		}
  1462	}
  1463	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
