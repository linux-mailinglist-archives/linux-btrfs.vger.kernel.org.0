Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62F0518231
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 12:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiECKZL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 06:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiECKZK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 06:25:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620B955AB
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 03:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651573298; x=1683109298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F2TazI0aaCDtqUZB8Af0dFuA2JKk8qO6gB+gTKJXiPk=;
  b=SKmXdsqZx8pf/D0rYJk2P9N75t63a7cj4+0ZOwa8tKjnGYsqr1QUcX5q
   EHDRVci5n/Gx2GtQ1V93tZOuLwdhEZsId6SWmIEvLrowj9b4TR24GKKW2
   NE3d4QeCiYzdWDgAL/Om850jW6FHtfcpLDD03bvnnAdKUlZWV6uyykHX3
   EES5gCjgMEBLtYUAE6ECArggupMYJaB+9yz2E0Y2+M0A22P9Wg/vanBIK
   J/cEurdJAi2ONcbnFT7qn9Inqkhvo2yg/pheaRMHfKmYrcUoMx/RAmqwN
   RTu4Q9LcPFLHz2C4bIJiUdDf60aqSv12WUuMHaYpPH5oFIlFzFNMCDEFX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="327985968"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="327985968"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 03:21:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="599008652"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 May 2022 03:21:36 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlpey-000AN3-4X;
        Tue, 03 May 2022 10:21:36 +0000
Date:   Tue, 3 May 2022 18:20:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 1/2] btrfs: Introduce btrfs_try_lock_balance
Message-ID: <202205031820.eWTnmpgQ-lkp@intel.com>
References: <20220503083637.1051023-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503083637.1051023-2-nborisov@suse.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Nikolay,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on v5.18-rc5 next-20220503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikolay-Borisov/Refactor-btrfs_ioctl_balance/20220503-163837
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220503/202205031820.eWTnmpgQ-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d383145190e87f46bc73d86059724df2b3af9720
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nikolay-Borisov/Refactor-btrfs_ioctl_balance/20220503-163837
        git checkout d383145190e87f46bc73d86059724df2b3af9720
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/btrfs/ioctl.c:4350: warning: expecting prototype for Try to acquire fs_info:(). Prototype was for btrfs_try_lock_balance() instead


vim +4350 fs/btrfs/ioctl.c

  4336	
  4337	/**
  4338	 * Try to acquire fs_info::balance_Mutex as well as set BTRFS_EXLCOP_BALANCE as
  4339	 * required.
  4340	 *
  4341	 * @fs_info:       context of the filesystem
  4342	 * @excl_acquired: ptr to boolean value which is set to 'false' in case balance
  4343	 * is being resumed.
  4344	 *
  4345	 * Returns 0 on success in which case both fs_info::balance is acquired as well
  4346	 * as exclusive ops are blocked. In case of failure returns an error code.
  4347	 *
  4348	 */
  4349	static int btrfs_try_lock_balance(struct btrfs_fs_info *fs_info, bool *excl_acquired)
> 4350	{
  4351		int ret;
  4352		/*
  4353		 * mut. excl. ops lock is locked.  Three possibilities:
  4354		 *   (1) some other op is running
  4355		 *   (2) balance is running
  4356		 *   (3) balance is paused -- special case (think resume)
  4357		 */
  4358		while (1) {
  4359			if (btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
  4360				*excl_acquired = true;
  4361				mutex_lock(&fs_info->balance_mutex);
  4362				return 0;
  4363			}
  4364	
  4365			mutex_lock(&fs_info->balance_mutex);
  4366			if (fs_info->balance_ctl) {
  4367				/* this is either (2) or (3) */
  4368				if (test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
  4369					/* this is (2) */
  4370					ret = -EINPROGRESS;
  4371					goto out_failure;
  4372	
  4373				} else {
  4374					mutex_unlock(&fs_info->balance_mutex);
  4375					/*
  4376					 * Lock released to allow other waiters to continue,
  4377					 * we'll reexamine the status again.
  4378					 */
  4379					mutex_lock(&fs_info->balance_mutex);
  4380	
  4381					if (fs_info->balance_ctl &&
  4382					    !test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
  4383						/* this is (3) */
  4384						*excl_acquired = false;
  4385						return 0;
  4386					}
  4387				}
  4388			} else {
  4389				/* this is (1) */
  4390				ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
  4391				goto out_failure;
  4392			}
  4393	
  4394			mutex_unlock(&fs_info->balance_mutex);
  4395		}
  4396	
  4397	out_failure:
  4398		mutex_unlock(&fs_info->balance_mutex);
  4399		*excl_acquired = false;
  4400		return ret;
  4401	}
  4402	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
