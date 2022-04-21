Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5277250A73E
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 19:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390809AbiDURjW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 13:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345437AbiDURjV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 13:39:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBD14927E;
        Thu, 21 Apr 2022 10:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650562591; x=1682098591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IaH/Q0uLjbSzyYuYCFdaJrJyTkwHmv+BQlUtkUbRdWA=;
  b=nJa2DnICHVEB8YMWRbK4kc6nGzE49IsGsR5kkaVISgUjA9IzLz/cptug
   IuZmVonD0FzMaSa3F/VSYyO4+2Z23TzBzCbZdOEI2pRBKe2lkMRDtwYGe
   Kvu9RPJCYlnICqJqiI95vjo15YoLv/gDwiOgnjs9co8KACj+8CQlFG4Yc
   QQiDXXrXw6pzWo3n4aD0BNv4/5Ih7hALX9yQbYyahFbL91/8//jWDZB7N
   cLHPrRbSgNQJ60Ayr6Jd4SBDEfB31k2yHQWeApRFQzhCkI8jrAMEhRY++
   B62/D/Co88op8giCP4JkL9Xu2jRr2QC8DrfNHopY6pP4gQnGk6AhSjZcZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244353529"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="244353529"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 10:36:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="593761713"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Apr 2022 10:36:28 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhajD-0008ch-Kb;
        Thu, 21 Apr 2022 17:36:27 +0000
Date:   Fri, 22 Apr 2022 01:35:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haowen Bai <baihaowen@meizu.com>,
        Chris Mason <chris.mason@fusionio.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Haowen Bai <baihaowen@meizu.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix a memory leak in btrfs_ioctl_balance()
Message-ID: <202204220132.EBMTHukr-lkp@intel.com>
References: <1650534677-31554-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650534677-31554-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Haowen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on v5.18-rc3 next-20220421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Haowen-Bai/btrfs-Fix-a-memory-leak-in-btrfs_ioctl_balance/20220421-175644
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220422/202204220132.EBMTHukr-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9e36507b94d20118a936198b321a3544931217f0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Haowen-Bai/btrfs-Fix-a-memory-leak-in-btrfs_ioctl_balance/20220421-175644
        git checkout 9e36507b94d20118a936198b321a3544931217f0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/btrfs/ioctl.c:4375:7: warning: variable 'need_unlock' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (!test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/ioctl.c:4463:6: note: uninitialized use occurs here
           if (need_unlock)
               ^~~~~~~~~~~
   fs/btrfs/ioctl.c:4375:3: note: remove the 'if' if its condition is always true
                   if (!test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/ioctl.c:4373:6: warning: variable 'need_unlock' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (fs_info->balance_ctl) {
               ^~~~~~~~~~~~~~~~~~~~
   fs/btrfs/ioctl.c:4463:6: note: uninitialized use occurs here
           if (need_unlock)
               ^~~~~~~~~~~
   fs/btrfs/ioctl.c:4373:2: note: remove the 'if' if its condition is always true
           if (fs_info->balance_ctl) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/ioctl.c:4343:18: note: initialize the variable 'need_unlock' to silence this warning
           bool need_unlock; /* for mut. excl. ops lock */
                           ^
                            = 0
   2 warnings generated.


vim +4375 fs/btrfs/ioctl.c

c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4336  
9ba1f6e44ed7a1 Liu Bo               2012-05-11  4337  static long btrfs_ioctl_balance(struct file *file, void __user *arg)
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4338  {
496ad9aa8ef448 Al Viro              2013-01-23  4339  	struct btrfs_root *root = BTRFS_I(file_inode(file))->root;
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4340  	struct btrfs_fs_info *fs_info = root->fs_info;
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4341  	struct btrfs_ioctl_balance_args *bargs;
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4342  	struct btrfs_balance_control *bctl;
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4343  	bool need_unlock; /* for mut. excl. ops lock */
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4344  	int ret;
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4345  
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4346  	if (!capable(CAP_SYS_ADMIN))
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4347  		return -EPERM;
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4348  
e54bfa31044d60 Liu Bo               2012-06-29  4349  	ret = mnt_want_write_file(file);
9ba1f6e44ed7a1 Liu Bo               2012-05-11  4350  	if (ret)
9ba1f6e44ed7a1 Liu Bo               2012-05-11  4351  		return ret;
9ba1f6e44ed7a1 Liu Bo               2012-05-11  4352  
0cb53767e6f475 Nikolay Borisov      2022-03-30  4353  	bargs = memdup_user(arg, sizeof(*bargs));
0cb53767e6f475 Nikolay Borisov      2022-03-30  4354  	if (IS_ERR(bargs)) {
0cb53767e6f475 Nikolay Borisov      2022-03-30  4355  		ret = PTR_ERR(bargs);
0cb53767e6f475 Nikolay Borisov      2022-03-30  4356  		goto out;
0cb53767e6f475 Nikolay Borisov      2022-03-30  4357  	}
0cb53767e6f475 Nikolay Borisov      2022-03-30  4358  
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4359  again:
c3e1f96c37d0f8 Goldwyn Rodrigues    2020-08-25  4360  	if (btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4361  		mutex_lock(&fs_info->balance_mutex);
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4362  		need_unlock = true;
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4363  		goto locked;
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4364  	}
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4365  
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4366  	/*
0132761017e012 Nicholas D Steeves   2016-05-19  4367  	 * mut. excl. ops lock is locked.  Three possibilities:
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4368  	 *   (1) some other op is running
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4369  	 *   (2) balance is running
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4370  	 *   (3) balance is paused -- special case (think resume)
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4371  	 */
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4372  	mutex_lock(&fs_info->balance_mutex);
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4373  	if (fs_info->balance_ctl) {
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4374  		/* this is either (2) or (3) */
3009a62f3b1823 David Sterba         2018-03-21 @4375  		if (!test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4376  			mutex_unlock(&fs_info->balance_mutex);
dccdb07bc996e9 David Sterba         2018-03-21  4377  			/*
dccdb07bc996e9 David Sterba         2018-03-21  4378  			 * Lock released to allow other waiters to continue,
dccdb07bc996e9 David Sterba         2018-03-21  4379  			 * we'll reexamine the status again.
dccdb07bc996e9 David Sterba         2018-03-21  4380  			 */
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4381  			mutex_lock(&fs_info->balance_mutex);
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4382  
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4383  			if (fs_info->balance_ctl &&
3009a62f3b1823 David Sterba         2018-03-21  4384  			    !test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4385  				/* this is (3) */
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4386  				need_unlock = false;
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4387  				goto locked;
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4388  			}
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4389  
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4390  			mutex_unlock(&fs_info->balance_mutex);
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4391  			goto again;
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4392  		} else {
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4393  			/* this is (2) */
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4394  			mutex_unlock(&fs_info->balance_mutex);
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4395  			ret = -EINPROGRESS;
9e36507b94d201 Haowen Bai           2022-04-21  4396  			goto out_bargs;
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4397  		}
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4398  	} else {
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4399  		/* this is (1) */
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4400  		mutex_unlock(&fs_info->balance_mutex);
e57138b3e96e45 Anand Jain           2013-08-21  4401  		ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
9e36507b94d201 Haowen Bai           2022-04-21  4402  		goto out_bargs;
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4403  	}
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4404  
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4405  locked:
de322263d3a6d4 Ilya Dryomov         2012-01-16  4406  	if (bargs->flags & BTRFS_BALANCE_RESUME) {
de322263d3a6d4 Ilya Dryomov         2012-01-16  4407  		if (!fs_info->balance_ctl) {
de322263d3a6d4 Ilya Dryomov         2012-01-16  4408  			ret = -ENOTCONN;
de322263d3a6d4 Ilya Dryomov         2012-01-16  4409  			goto out_bargs;
de322263d3a6d4 Ilya Dryomov         2012-01-16  4410  		}
de322263d3a6d4 Ilya Dryomov         2012-01-16  4411  
de322263d3a6d4 Ilya Dryomov         2012-01-16  4412  		bctl = fs_info->balance_ctl;
de322263d3a6d4 Ilya Dryomov         2012-01-16  4413  		spin_lock(&fs_info->balance_lock);
de322263d3a6d4 Ilya Dryomov         2012-01-16  4414  		bctl->flags |= BTRFS_BALANCE_RESUME;
de322263d3a6d4 Ilya Dryomov         2012-01-16  4415  		spin_unlock(&fs_info->balance_lock);
efc0e69c2feab8 Nikolay Borisov      2021-11-25  4416  		btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE);
de322263d3a6d4 Ilya Dryomov         2012-01-16  4417  
de322263d3a6d4 Ilya Dryomov         2012-01-16  4418  		goto do_balance;
de322263d3a6d4 Ilya Dryomov         2012-01-16  4419  	}
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4420  
0cb53767e6f475 Nikolay Borisov      2022-03-30  4421  	if (bargs->flags & ~(BTRFS_BALANCE_ARGS_MASK | BTRFS_BALANCE_TYPE_MASK)) {
0cb53767e6f475 Nikolay Borisov      2022-03-30  4422  		ret = -EINVAL;
0cb53767e6f475 Nikolay Borisov      2022-03-30  4423  		goto out_bargs;
0cb53767e6f475 Nikolay Borisov      2022-03-30  4424  	}
0cb53767e6f475 Nikolay Borisov      2022-03-30  4425  
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4426  	if (fs_info->balance_ctl) {
837d5b6e46d1a4 Ilya Dryomov         2012-01-16  4427  		ret = -EINPROGRESS;
837d5b6e46d1a4 Ilya Dryomov         2012-01-16  4428  		goto out_bargs;
837d5b6e46d1a4 Ilya Dryomov         2012-01-16  4429  	}
837d5b6e46d1a4 Ilya Dryomov         2012-01-16  4430  
8d2db7855e7b65 David Sterba         2015-11-04  4431  	bctl = kzalloc(sizeof(*bctl), GFP_KERNEL);
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4432  	if (!bctl) {
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4433  		ret = -ENOMEM;
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4434  		goto out_bargs;
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4435  	}
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4436  
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4437  	memcpy(&bctl->data, &bargs->data, sizeof(bctl->data));
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4438  	memcpy(&bctl->meta, &bargs->meta, sizeof(bctl->meta));
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4439  	memcpy(&bctl->sys, &bargs->sys, sizeof(bctl->sys));
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4440  
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4441  	bctl->flags = bargs->flags;
de322263d3a6d4 Ilya Dryomov         2012-01-16  4442  do_balance:
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4443  	/*
c3e1f96c37d0f8 Goldwyn Rodrigues    2020-08-25  4444  	 * Ownership of bctl and exclusive operation goes to btrfs_balance.
c3e1f96c37d0f8 Goldwyn Rodrigues    2020-08-25  4445  	 * bctl is freed in reset_balance_state, or, if restriper was paused
c3e1f96c37d0f8 Goldwyn Rodrigues    2020-08-25  4446  	 * all the way until unmount, in free_fs_info.  The flag should be
c3e1f96c37d0f8 Goldwyn Rodrigues    2020-08-25  4447  	 * cleared after reset_balance_state.
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4448  	 */
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4449  	need_unlock = false;
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4450  
6fcf6e2bffb6cf David Sterba         2018-05-07  4451  	ret = btrfs_balance(fs_info, bctl, bargs);
0f89abf56abbd0 Christian Engelmayer 2015-10-21  4452  	bctl = NULL;
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4453  
6ad365fd1bfcde Nikolay Borisov      2022-03-30  4454  	if (ret == 0 || ret == -ECANCELED) {
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4455  		if (copy_to_user(arg, bargs, sizeof(*bargs)))
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4456  			ret = -EFAULT;
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4457  	}
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4458  
0f89abf56abbd0 Christian Engelmayer 2015-10-21  4459  	kfree(bctl);
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4460  out_bargs:
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4461  	kfree(bargs);
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4462  	mutex_unlock(&fs_info->balance_mutex);
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4463  	if (need_unlock)
c3e1f96c37d0f8 Goldwyn Rodrigues    2020-08-25  4464  		btrfs_exclop_finish(fs_info);
ed0fb78fb6aa29 Ilya Dryomov         2013-01-20  4465  out:
e54bfa31044d60 Liu Bo               2012-06-29  4466  	mnt_drop_write_file(file);
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4467  	return ret;
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4468  }
c9e9f97bdfb64d Ilya Dryomov         2012-01-16  4469  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
