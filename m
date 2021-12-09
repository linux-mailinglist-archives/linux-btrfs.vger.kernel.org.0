Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486D946E168
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 05:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhLIEDl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Dec 2021 23:03:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:60516 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231622AbhLIEDl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Dec 2021 23:03:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="224879294"
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="224879294"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 20:00:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="680174853"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Dec 2021 20:00:06 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvAbF-0001RU-W3; Thu, 09 Dec 2021 04:00:05 +0000
Date:   Thu, 9 Dec 2021 11:59:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs: harden identification of the stale device
Message-ID: <202112091123.ETjD5KQj-lkp@intel.com>
References: <166e39f69a8693e5fe10784cdbd950d68f98d4fb.1638953372.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166e39f69a8693e5fe10784cdbd950d68f98d4fb.1638953372.git.anand.jain@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Anand,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on v5.16-rc4 next-20211208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Anand-Jain/btrfs-harden-identification-of-the-stale-device/20211208-220757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: i386-randconfig-s001-20211207 (https://download.01.org/0day-ci/archive/20211209/202112091123.ETjD5KQj-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/03b597640967afb3d37dc37f0a685fed95594b83
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Anand-Jain/btrfs-harden-identification-of-the-stale-device/20211208-220757
        git checkout 03b597640967afb3d37dc37f0a685fed95594b83
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/btrfs/volumes.c:402:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rcu_string *str @@     got struct rcu_string [noderef] __rcu *name @@
   fs/btrfs/volumes.c:402:31: sparse:     expected struct rcu_string *str
   fs/btrfs/volumes.c:402:31: sparse:     got struct rcu_string [noderef] __rcu *name
>> fs/btrfs/volumes.c:549:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *pathname @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:549:35: sparse:     expected char const *pathname
   fs/btrfs/volumes.c:549:35: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:643:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *device_path @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:643:43: sparse:     expected char const *device_path
   fs/btrfs/volumes.c:643:43: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:904:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *cs @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:904:50: sparse:     expected char const *cs
   fs/btrfs/volumes.c:904:50: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:984:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rcu_string *str @@     got struct rcu_string [noderef] __rcu *name @@
   fs/btrfs/volumes.c:984:39: sparse:     expected struct rcu_string *str
   fs/btrfs/volumes.c:984:39: sparse:     got struct rcu_string [noderef] __rcu *name
   fs/btrfs/volumes.c:1040:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *src @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:1040:58: sparse:     expected char const *src
   fs/btrfs/volumes.c:1040:58: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:2235:49: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected char const *device_path @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:2235:49: sparse:     expected char const *device_path
   fs/btrfs/volumes.c:2235:49: sparse:     got char [noderef] __rcu *
   fs/btrfs/volumes.c:2350:41: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected char const *device_path @@     got char [noderef] __rcu * @@
   fs/btrfs/volumes.c:2350:41: sparse:     expected char const *device_path
   fs/btrfs/volumes.c:2350:41: sparse:     got char [noderef] __rcu *

vim +549 fs/btrfs/volumes.c

   532	
   533	/*
   534	 * Check if the device in the 'path' matches with the device in the given
   535	 * struct btrfs_device '*device'.
   536	 * Returns:
   537	 *	0	If it is the same device.
   538	 *	1	If it is not the same device.
   539	 *	-errno	For error.
   540	 */
   541	static int device_matched(struct btrfs_device *device, const char *path)
   542	{
   543		dev_t dev_old;
   544		dev_t dev_new;
   545		int error;
   546	
   547		lockdep_assert_held(&device->fs_devices->device_list_mutex);
   548		/* rcu is not required as we are inside the device_list_mutex */
 > 549		error = lookup_bdev(device->name->str, &dev_old);
   550		if (error)
   551			return error;
   552	
   553		error = lookup_bdev(path, &dev_new);
   554		if (error)
   555			return error;
   556	
   557		if (dev_old == dev_new)
   558			return 0;
   559	
   560		return 1;
   561	}
   562	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
