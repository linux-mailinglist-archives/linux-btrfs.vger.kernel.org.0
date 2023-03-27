Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8057B6CB2A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 01:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjC0Xw4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 19:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjC0Xwz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 19:52:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF68DA4
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 16:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679961173; x=1711497173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTC3O0ewRnHdUL5K4DVtzq6oTfvlhDlrgu+dOUsW6TE=;
  b=jKWXhtyPpUhR9AucRm0ehba7KOqfTSygcNrAG147t+Sv1tSyUhdJAag3
   6jMEtKotacSH8bdLciRAtE6jsBL4ITpX7Sm9fHarghmEKmbieCDx8i+Mx
   uQtbAcWFcqOASZgWHwxWyge7mg4/ECJUSPSJPm9LH/R+zzZ5W7S8uHVqk
   qviZEowAkpp1yyXuJtJjcez01rm3kD/Rm9jhaTr47xVC1xurZC1UoqFTr
   JA8W2WP2euhoJRNr2wZTdF0LWcmcxcyHQzpXJEEZg5zVmnH8KNPjQjD4G
   Ywat6cTPC4bxhjh4Fp+5I1SAkriU83Ei8mZZj5/uDwZyVvkEjLeSKwywj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="342000643"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="342000643"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 16:52:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="660986182"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="660986182"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Mar 2023 16:52:38 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pgwdh-000I5n-2z;
        Mon, 27 Mar 2023 23:52:37 +0000
Date:   Tue, 28 Mar 2023 07:52:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 3/4] Btrfs: change wait_dev_flush() return type to bool
Message-ID: <202303280731.3zPschfL-lkp@intel.com>
References: <3e067c8b0956f0134501c8eea2e19c8eb5adcedc.1679910088.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e067c8b0956f0134501c8eea2e19c8eb5adcedc.1679910088.git.anand.jain@oracle.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Anand,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.3-rc4 next-20230327]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Jain/btrfs-move-last_flush_error-to-write_dev_flush-and-wait_dev_flush/20230327-180139
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/3e067c8b0956f0134501c8eea2e19c8eb5adcedc.1679910088.git.anand.jain%40oracle.com
patch subject: [PATCH 3/4] Btrfs: change wait_dev_flush() return type to bool
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20230328/202303280731.3zPschfL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/d26d540e470da0010fed61401cf0b7147f175aa1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anand-Jain/btrfs-move-last_flush_error-to-write_dev_flush-and-wait_dev_flush/20230327-180139
        git checkout d26d540e470da0010fed61401cf0b7147f175aa1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303280731.3zPschfL-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/btrfs/disk-io.c:4172:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted blk_status_t [usertype] ret @@     got bool @@
   fs/btrfs/disk-io.c:4172:21: sparse:     expected restricted blk_status_t [usertype] ret
   fs/btrfs/disk-io.c:4172:21: sparse:     got bool

vim +4172 fs/btrfs/disk-io.c

387125fc722a8e Chris Mason       2011-11-18  4133  
387125fc722a8e Chris Mason       2011-11-18  4134  /*
387125fc722a8e Chris Mason       2011-11-18  4135   * send an empty flush down to each device in parallel,
387125fc722a8e Chris Mason       2011-11-18  4136   * then wait for them
387125fc722a8e Chris Mason       2011-11-18  4137   */
387125fc722a8e Chris Mason       2011-11-18  4138  static int barrier_all_devices(struct btrfs_fs_info *info)
387125fc722a8e Chris Mason       2011-11-18  4139  {
387125fc722a8e Chris Mason       2011-11-18  4140  	struct list_head *head;
387125fc722a8e Chris Mason       2011-11-18  4141  	struct btrfs_device *dev;
5af3e8cce8b7ba Stefan Behrens    2012-08-01  4142  	int errors_wait = 0;
4e4cbee93d5613 Christoph Hellwig 2017-06-03  4143  	blk_status_t ret;
387125fc722a8e Chris Mason       2011-11-18  4144  
1538e6c52e1917 David Sterba      2017-06-16  4145  	lockdep_assert_held(&info->fs_devices->device_list_mutex);
387125fc722a8e Chris Mason       2011-11-18  4146  	/* send down all the barriers */
387125fc722a8e Chris Mason       2011-11-18  4147  	head = &info->fs_devices->devices;
1538e6c52e1917 David Sterba      2017-06-16  4148  	list_for_each_entry(dev, head, dev_list) {
e6e674bd4d54fe Anand Jain        2017-12-04  4149  		if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
f88ba6a2a44ee9 Hidetoshi Seto    2014-02-05  4150  			continue;
cea7c8bf77209b Anand Jain        2017-06-13  4151  		if (!dev->bdev)
387125fc722a8e Chris Mason       2011-11-18  4152  			continue;
e12c96214d28f9 Anand Jain        2017-12-04  4153  		if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &dev->dev_state) ||
ebbede42d47dc7 Anand Jain        2017-12-04  4154  		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))
387125fc722a8e Chris Mason       2011-11-18  4155  			continue;
387125fc722a8e Chris Mason       2011-11-18  4156  
4fc6441aac7589 Anand Jain        2017-06-13  4157  		write_dev_flush(dev);
387125fc722a8e Chris Mason       2011-11-18  4158  	}
387125fc722a8e Chris Mason       2011-11-18  4159  
387125fc722a8e Chris Mason       2011-11-18  4160  	/* wait for all the barriers */
1538e6c52e1917 David Sterba      2017-06-16  4161  	list_for_each_entry(dev, head, dev_list) {
e6e674bd4d54fe Anand Jain        2017-12-04  4162  		if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
f88ba6a2a44ee9 Hidetoshi Seto    2014-02-05  4163  			continue;
387125fc722a8e Chris Mason       2011-11-18  4164  		if (!dev->bdev) {
5af3e8cce8b7ba Stefan Behrens    2012-08-01  4165  			errors_wait++;
387125fc722a8e Chris Mason       2011-11-18  4166  			continue;
387125fc722a8e Chris Mason       2011-11-18  4167  		}
e12c96214d28f9 Anand Jain        2017-12-04  4168  		if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &dev->dev_state) ||
ebbede42d47dc7 Anand Jain        2017-12-04  4169  		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))
387125fc722a8e Chris Mason       2011-11-18  4170  			continue;
387125fc722a8e Chris Mason       2011-11-18  4171  
4fc6441aac7589 Anand Jain        2017-06-13 @4172  		ret = wait_dev_flush(dev);
7b3115dae5a0a2 Anand Jain        2023-03-27  4173  		if (ret)
5af3e8cce8b7ba Stefan Behrens    2012-08-01  4174  			errors_wait++;
387125fc722a8e Chris Mason       2011-11-18  4175  	}
401b41e5a85a63 Anand Jain        2017-05-06  4176  
401b41e5a85a63 Anand Jain        2017-05-06  4177  	/*
a112dad7e3abca Anand Jain        2023-03-27  4178  	 * Checks last_flush_error of disks in order to determine the
a112dad7e3abca Anand Jain        2023-03-27  4179  	 * volume state.
401b41e5a85a63 Anand Jain        2017-05-06  4180  	 */
a112dad7e3abca Anand Jain        2023-03-27  4181  	if (errors_wait && !btrfs_check_rw_degradable(info, NULL))
a112dad7e3abca Anand Jain        2023-03-27  4182  		return -EIO;
a112dad7e3abca Anand Jain        2023-03-27  4183  
387125fc722a8e Chris Mason       2011-11-18  4184  	return 0;
387125fc722a8e Chris Mason       2011-11-18  4185  }
387125fc722a8e Chris Mason       2011-11-18  4186  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
