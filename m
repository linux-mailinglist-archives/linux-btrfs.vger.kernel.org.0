Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A694583BE4
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jul 2022 12:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbiG1KQN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jul 2022 06:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbiG1KQI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jul 2022 06:16:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172C0558C5
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jul 2022 03:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659003365; x=1690539365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZNQmZlEArRR6aAceILjoGXF8ZXTOPskSH4pHj20mQlk=;
  b=La4+RmNWjTai1A9GdHB7RnxtHesLNJObIh81p+OVE5WnDyTEcIseNRw5
   64qEt9J2wPnSumcALFx4st6KiNn4VBHeFR1NbxIJADYbmUXL2X66Szq6b
   mdAL4aZa3+nTUyOom7BhHVxpqgSET1hPF4Z9Zpr15ey3cSBE1B+SYaZW2
   VV5yqIs1Rj/fgAi2/Zx6a0bxgJ1h1613xIAveMvaZaCgadVVZhPDb8Lxw
   UVYu9XKwSIIdNo+rBAqvhTrUp2zcxVimmN/wbbvc/KibBnkVsmOdUoP8t
   X0Y/8HHx0TshnolDXBGqzBoWS8DERVVtCNvoFZdaTugZWvfw8+8gWHCiE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="288489550"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="288489550"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 03:16:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="777079221"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Jul 2022 03:16:03 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oH0Yk-0009tU-2y;
        Thu, 28 Jul 2022 10:16:02 +0000
Date:   Thu, 28 Jul 2022 18:15:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: sysfs: show discard stats and tunables in
 non-debug build
Message-ID: <202207281851.dWFlVSOz-lkp@intel.com>
References: <20220727175659.16661-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727175659.16661-1-dsterba@suse.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

I love your patch! Yet something to improve:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v5.19-rc8 next-20220727]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Sterba/btrfs-sysfs-show-discard-stats-and-tunables-in-non-debug-build/20220728-025841
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: arc-randconfig-r043-20220728 (https://download.01.org/0day-ci/archive/20220728/202207281851.dWFlVSOz-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7fe92f8e456bf61b528a969be287e7bfda2bb03d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Sterba/btrfs-sysfs-show-discard-stats-and-tunables-in-non-debug-build/20220728-025841
        git checkout 7fe92f8e456bf61b528a969be287e7bfda2bb03d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/btrfs/sysfs.c: In function 'btrfs_sysfs_remove_mounted':
>> fs/btrfs/sysfs.c:1435:20: error: 'struct btrfs_fs_info' has no member named 'debug_kobj'
    1435 |         if (fs_info->debug_kobj) {
         |                    ^~
   fs/btrfs/sysfs.c:1436:43: error: 'struct btrfs_fs_info' has no member named 'debug_kobj'
    1436 |                 sysfs_remove_files(fs_info->debug_kobj, btrfs_debug_mount_attrs);
         |                                           ^~
>> fs/btrfs/sysfs.c:1436:57: error: 'btrfs_debug_mount_attrs' undeclared (first use in this function)
    1436 |                 sysfs_remove_files(fs_info->debug_kobj, btrfs_debug_mount_attrs);
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/sysfs.c:1436:57: note: each undeclared identifier is reported only once for each function it appears in
   fs/btrfs/sysfs.c:1437:36: error: 'struct btrfs_fs_info' has no member named 'debug_kobj'
    1437 |                 kobject_del(fs_info->debug_kobj);
         |                                    ^~
   fs/btrfs/sysfs.c:1438:36: error: 'struct btrfs_fs_info' has no member named 'debug_kobj'
    1438 |                 kobject_put(fs_info->debug_kobj);
         |                                    ^~


vim +1435 fs/btrfs/sysfs.c

53f8a74cbeffd45 Anand Jain      2020-09-05  1418  
6618a59bfc0a049 Anand Jain      2015-08-14  1419  void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
5ac1d209f11271f Jeff Mahoney    2013-11-01  1420  {
3092c68fc58c7bd Nikolay Borisov 2020-07-03  1421  	struct kobject *fsid_kobj = &fs_info->fs_devices->fsid_kobj;
3092c68fc58c7bd Nikolay Borisov 2020-07-03  1422  
3092c68fc58c7bd Nikolay Borisov 2020-07-03  1423  	sysfs_remove_link(fsid_kobj, "bdi");
3092c68fc58c7bd Nikolay Borisov 2020-07-03  1424  
e453d989e0bb33d Jeff Mahoney    2013-11-21  1425  	if (fs_info->space_info_kobj) {
6ab0a2029ceaedb Jeff Mahoney    2013-11-01  1426  		sysfs_remove_files(fs_info->space_info_kobj, allocation_attrs);
6ab0a2029ceaedb Jeff Mahoney    2013-11-01  1427  		kobject_del(fs_info->space_info_kobj);
6ab0a2029ceaedb Jeff Mahoney    2013-11-01  1428  		kobject_put(fs_info->space_info_kobj);
e453d989e0bb33d Jeff Mahoney    2013-11-21  1429  	}
7fe92f8e456bf61 David Sterba    2022-07-27  1430  	if (fs_info->discard_kobj) {
7fe92f8e456bf61 David Sterba    2022-07-27  1431  		sysfs_remove_files(fs_info->discard_kobj, discard_attrs);
7fe92f8e456bf61 David Sterba    2022-07-27  1432  		kobject_del(fs_info->discard_kobj);
7fe92f8e456bf61 David Sterba    2022-07-27  1433  		kobject_put(fs_info->discard_kobj);
e4faab844a55edb Dennis Zhou     2019-12-13  1434  	}
93945cb43ead1e2 Dennis Zhou     2019-12-13 @1435  	if (fs_info->debug_kobj) {
93945cb43ead1e2 Dennis Zhou     2019-12-13 @1436  		sysfs_remove_files(fs_info->debug_kobj, btrfs_debug_mount_attrs);
93945cb43ead1e2 Dennis Zhou     2019-12-13  1437  		kobject_del(fs_info->debug_kobj);
93945cb43ead1e2 Dennis Zhou     2019-12-13  1438  		kobject_put(fs_info->debug_kobj);
93945cb43ead1e2 Dennis Zhou     2019-12-13  1439  	}
7fe92f8e456bf61 David Sterba    2022-07-27  1440  
e453d989e0bb33d Jeff Mahoney    2013-11-21  1441  	addrm_unknown_feature_attrs(fs_info, false);
3092c68fc58c7bd Nikolay Borisov 2020-07-03  1442  	sysfs_remove_group(fsid_kobj, &btrfs_feature_attr_group);
3092c68fc58c7bd Nikolay Borisov 2020-07-03  1443  	sysfs_remove_files(fsid_kobj, btrfs_attrs);
53f8a74cbeffd45 Anand Jain      2020-09-05  1444  	btrfs_sysfs_remove_fs_devices(fs_info->fs_devices);
5ac1d209f11271f Jeff Mahoney    2013-11-01  1445  }
5ac1d209f11271f Jeff Mahoney    2013-11-01  1446  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
