Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683A14A5DF4
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 15:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbiBAOHq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 09:07:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:52815 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235891AbiBAOHq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Feb 2022 09:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643724466; x=1675260466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X4+yFqaGonjFiBohQRRndCIUBVeJRAwNX/8i/rSGHN4=;
  b=bBRe6XeN48sa07ducNt6KwFchq8WLt08d0R4WPeYw5ZUolPanyU1Thne
   ZgU4BHfvTpV4buCFZsdgyTXh9GVHg2iPYfDYUn6bOXcBe8V5hI8jR+Y1W
   lcfFNRUS96PzyecVc354pIMCUFLviBsRGwSP3iP7hvPysHzlanA/ey4ex
   xCL7dkn2UosMXv1NBrjYMfxLqsim4p+KwdQ9vREZ2kijr8k+6HkppV+cY
   5VCHbgYYBJHeMdqYFVtnwVQFSB9PbBZK1CiKgwYbACuTZhzkdbJOpsBvP
   i7Pf1p951vfsJNjyFKZsj8yNf1M2kmBFMUUgei0DWAgNlKo9AHitMc88p
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="235089278"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="235089278"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 06:07:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="771114916"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Feb 2022 06:07:44 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEtou-000TLP-7K; Tue, 01 Feb 2022 14:07:44 +0000
Date:   Tue, 1 Feb 2022 22:07:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org,
        quwenruo.btrfs@gmx.com
Cc:     kbuild-all@lists.01.org, Sidong Yang <realwakka@gmail.com>
Subject: Re: [PATCH] btrfs: qgroup: replace modifing qgroup_flags to bitops
Message-ID: <202202012156.wyQPJZyD-lkp@intel.com>
References: <20220201125331.260482-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201125331.260482-1-realwakka@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Sidong,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.17-rc2]
[cannot apply to kdave/for-next next-20220131]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sidong-Yang/btrfs-qgroup-replace-modifing-qgroup_flags-to-bitops/20220201-205452
base:    26291c54e111ff6ba87a164d85d4a4e134b7315c
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220201/202202012156.wyQPJZyD-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ba6f4f3d431a14034f4e4da2b8f342fe17ec78bf
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sidong-Yang/btrfs-qgroup-replace-modifing-qgroup_flags-to-bitops/20220201-205452
        git checkout ba6f4f3d431a14034f4e4da2b8f342fe17ec78bf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/btrfs/qgroup.c: In function 'qgroup_rescan_init':
>> fs/btrfs/qgroup.c:3375:70: warning: passing argument 2 of 'test_bit' makes pointer from integer without a cast [-Wint-conversion]
    3375 |                 if (test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, fs_info->qgroup_flags)) {
         |                                                               ~~~~~~~^~~~~~~~~~~~~~
         |                                                                      |
         |                                                                      u64 {aka long long unsigned int}
   In file included from include/linux/bitops.h:33,
                    from include/linux/thread_info.h:27,
                    from include/asm-generic/current.h:5,
                    from ./arch/alpha/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from fs/btrfs/qgroup.c:6:
   arch/alpha/include/asm/bitops.h:287:40: note: expected 'const volatile void *' but argument is of type 'u64' {aka 'long long unsigned int'}
     287 | test_bit(int nr, const volatile void * addr)
         |                  ~~~~~~~~~~~~~~~~~~~~~~^~~~


vim +/test_bit +3375 fs/btrfs/qgroup.c

  3345	
  3346	/*
  3347	 * Checks that (a) no rescan is running and (b) quota is enabled. Allocates all
  3348	 * memory required for the rescan context.
  3349	 */
  3350	static int
  3351	qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
  3352			   int init_flags)
  3353	{
  3354		int ret = 0;
  3355	
  3356		if (!init_flags) {
  3357			/* we're resuming qgroup rescan at mount time */
  3358			if (!test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags)) {
  3359				btrfs_warn(fs_info,
  3360				"qgroup rescan init failed, qgroup rescan is not queued");
  3361				ret = -EINVAL;
  3362			} else if (!test_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags)) {
  3363				btrfs_warn(fs_info,
  3364				"qgroup rescan init failed, qgroup is not enabled");
  3365				ret = -EINVAL;
  3366			}
  3367	
  3368			if (ret)
  3369				return ret;
  3370		}
  3371	
  3372		mutex_lock(&fs_info->qgroup_rescan_lock);
  3373	
  3374		if (init_flags) {
> 3375			if (test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, fs_info->qgroup_flags)) {
  3376				btrfs_warn(fs_info,
  3377					   "qgroup rescan is already in progress");
  3378				ret = -EINPROGRESS;
  3379			} else if (!test_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags)) {
  3380				btrfs_warn(fs_info,
  3381				"qgroup rescan init failed, qgroup is not enabled");
  3382				ret = -EINVAL;
  3383			}
  3384	
  3385			if (ret) {
  3386				mutex_unlock(&fs_info->qgroup_rescan_lock);
  3387				return ret;
  3388			}
  3389			set_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags);
  3390		}
  3391	
  3392		memset(&fs_info->qgroup_rescan_progress, 0,
  3393			sizeof(fs_info->qgroup_rescan_progress));
  3394		fs_info->qgroup_rescan_progress.objectid = progress_objectid;
  3395		init_completion(&fs_info->qgroup_rescan_completion);
  3396		mutex_unlock(&fs_info->qgroup_rescan_lock);
  3397	
  3398		btrfs_init_work(&fs_info->qgroup_rescan_work,
  3399				btrfs_qgroup_rescan_worker, NULL, NULL);
  3400		return 0;
  3401	}
  3402	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
