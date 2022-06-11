Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019D35474A2
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jun 2022 14:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiFKM4S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jun 2022 08:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiFKM4R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jun 2022 08:56:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CF84C7AA
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jun 2022 05:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654952176; x=1686488176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/adh4WKjY9mXQDoWFkXSmdKFk6XNZc+dbKLtBwzdXpo=;
  b=OfYROyThXy2wB4v18lEdEVtegqMhefokYaSRx1k8vVf4Qvw36o9YVwxd
   Ma+YF80siBWHjm34HvV/nerlLxyCfqrTAc4Qd5duoQhOFNR00OA7EInx6
   dxJBqwTuoWZAmCm2SCc4sFO8E/eGnXBlDqZPLDg15mgRtLl3tqUKR6g87
   wz8Ov7pwGeR/0GBzNCsJGlPJQyrBiIzTY9Of3Hhvicd8w9fnaHjW/LD/B
   zbM4gIgtEd0UqijxKLOaPyut5uqOU93PHeElCUI7AJH4/7jYENUOOY0xn
   Ftz+LhUyph+q55nAMYm6k8g5IUyuufDQh0ELTj0J3nh4xQ8HuZGsZ8WOZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="277918699"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="277918699"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 05:56:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="711327310"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 Jun 2022 05:56:14 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o00f0-000Iug-65;
        Sat, 11 Jun 2022 12:56:14 +0000
Date:   Sat, 11 Jun 2022 20:55:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 1/2] btrfs: Add the capability of getting commit stats in
 BTRFS
Message-ID: <202206112045.UQwxPCB0-lkp@intel.com>
References: <20220610205406.301397-2-iangelak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610205406.301397-2-iangelak@fb.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Ioannis,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on v5.19-rc1 next-20220610]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Ioannis-Angelakopoulos/btrfs-Expose-BTRFS-commit-stats-through-sysfs/20220611-045738
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: microblaze-randconfig-r015-20220611 (https://download.01.org/0day-ci/archive/20220611/202206112045.UQwxPCB0-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8f66d4d3d43f1502549101630cdc1291093b7596
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ioannis-Angelakopoulos/btrfs-Expose-BTRFS-commit-stats-through-sysfs/20220611-045738
        git checkout 8f66d4d3d43f1502549101630cdc1291093b7596
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: fs/btrfs/transaction.o: in function `update_commit_stats':
>> fs/btrfs/transaction.c:2094: undefined reference to `__divdi3'


vim +2094 fs/btrfs/transaction.c

  2087	
  2088	static void update_commit_stats(struct btrfs_fs_info *fs_info,
  2089									ktime_t interval)
  2090	{
  2091		/* Increase the successful commits counter */
  2092		fs_info->commit_stats->commit_counter += 1;
  2093		/* Update the last commit duration */
> 2094		fs_info->commit_stats->last_commit_dur = interval / 1000000;
  2095		/* Update the maximum commit duration */
  2096		fs_info->commit_stats->max_commit_dur =
  2097					fs_info->commit_stats->max_commit_dur >	interval / 1000000 ?
  2098					fs_info->commit_stats->max_commit_dur :	interval / 1000000;
  2099		/* Update the total commit duration */
  2100		fs_info->commit_stats->total_commit_dur += interval / 1000000;
  2101	}
  2102	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
