Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA44788B9D
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 16:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343715AbjHYOW5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 10:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343846AbjHYOWi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 10:22:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6908E2108
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692973346; x=1724509346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EkDEmBP71GfVKS2nHR0q71X9UeQx44Cn+sYEwOoKywM=;
  b=fPXySiKGlFCeDv2qOer0SGxFRA5ckauCytWYqDBOQ9eg5jwm9HcNyUA/
   iS89sTsxX1mABua+nVnIstVbt2zeXLm679MWYW+RYdUjtwED5LClHIBtE
   D6OoYziA6zRXA37pt+6fC6XMOEp1wjnla+R3VmmS0Ir66QVOjK9xoPdfR
   dWEdeUdvX1cYIEmV1mfXQ0NHRy6LhGUHr2O+JPHbNWYuJ93csqadt61XS
   iPnr8xyvL/hVffoLrvfMjRTtTBdQ2rpcySx8udvCFW76oE6DXOGaYp4yu
   mJ6XNT2LOoMtUHPYWpMsyK6Ij4QQ0q27Vw/UOniMYfHkViGixzqQk9mTf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="374698664"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="374698664"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 07:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="851988314"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="851988314"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 25 Aug 2023 07:22:24 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZXhf-0003g3-11;
        Fri, 25 Aug 2023 14:22:23 +0000
Date:   Fri, 25 Aug 2023 22:21:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 11/11] btrfs: remove extraneous includes from ctree.h
Message-ID: <202308252218.ReiikzVx-lkp@intel.com>
References: <ed1caf5b26573e62547cb3b96031af66c0f082ca.1692798556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed1caf5b26573e62547cb3b96031af66c0f082ca.1692798556.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Josef,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on next-20230825]
[cannot apply to linus/master v6.5-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Josef-Bacik/btrfs-move-btrfs_crc32c_final-into-free-space-cache-c/20230823-215354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/ed1caf5b26573e62547cb3b96031af66c0f082ca.1692798556.git.josef%40toxicpanda.com
patch subject: [PATCH 11/11] btrfs: remove extraneous includes from ctree.h
config: arc-randconfig-001-20230824 (https://download.01.org/0day-ci/archive/20230825/202308252218.ReiikzVx-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230825/202308252218.ReiikzVx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308252218.ReiikzVx-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/btrfs/super.c: In function 'btrfs_mount_root':
>> fs/btrfs/super.c:1453:25: error: implicit declaration of function 'security_sb_eat_lsm_opts' [-Werror=implicit-function-declaration]
    1453 |                 error = security_sb_eat_lsm_opts(data, &new_sec_opts);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
>> fs/btrfs/super.c:1528:25: error: implicit declaration of function 'security_sb_set_mnt_opts' [-Werror=implicit-function-declaration]
    1528 |                 error = security_sb_set_mnt_opts(s, new_sec_opts, 0, NULL);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
>> fs/btrfs/super.c:1529:9: error: implicit declaration of function 'security_free_mnt_opts' [-Werror=implicit-function-declaration]
    1529 |         security_free_mnt_opts(&new_sec_opts);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/super.c: In function 'btrfs_remount':
>> fs/btrfs/super.c:1704:31: error: implicit declaration of function 'security_sb_remount' [-Werror=implicit-function-declaration]
    1704 |                         ret = security_sb_remount(sb, new_sec_opts);
         |                               ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/security_sb_eat_lsm_opts +1453 fs/btrfs/super.c

450ba0ea06b6ed3 Josef Bacik       2010-11-19  1433  
312c89fbca06896 Misono, Tomohiro  2017-12-14  1434  /*
312c89fbca06896 Misono, Tomohiro  2017-12-14  1435   * Find a superblock for the given device / mount point.
312c89fbca06896 Misono, Tomohiro  2017-12-14  1436   *
312c89fbca06896 Misono, Tomohiro  2017-12-14  1437   * Note: This is based on mount_bdev from fs/super.c with a few additions
312c89fbca06896 Misono, Tomohiro  2017-12-14  1438   *       for multiple device setup.  Make sure to keep it in sync.
312c89fbca06896 Misono, Tomohiro  2017-12-14  1439   */
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1440  static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1441  		int flags, const char *device_name, void *data)
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1442  {
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1443  	struct block_device *bdev = NULL;
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1444  	struct super_block *s;
36350e95a2b1fee Gu Jinxiang       2018-07-12  1445  	struct btrfs_device *device = NULL;
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1446  	struct btrfs_fs_devices *fs_devices = NULL;
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1447  	struct btrfs_fs_info *fs_info = NULL;
204cc0ccf1d49c6 Al Viro           2018-12-13  1448  	void *new_sec_opts = NULL;
05bdb9965305bbf Christoph Hellwig 2023-06-08  1449  	blk_mode_t mode = sb_open_mode(flags);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1450  	int error = 0;
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1451  
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1452  	if (data) {
a65001e8a4d4656 Al Viro           2018-12-10 @1453  		error = security_sb_eat_lsm_opts(data, &new_sec_opts);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1454  		if (error)
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1455  			return ERR_PTR(error);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1456  	}
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1457  
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1458  	/*
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1459  	 * Setup a dummy root and fs_info for test/set super.  This is because
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1460  	 * we don't actually fill this stuff out until open_ctree, but we need
8260edba67a2e6b Josef Bacik       2020-01-24  1461  	 * then open_ctree will properly initialize the file system specific
8260edba67a2e6b Josef Bacik       2020-01-24  1462  	 * settings later.  btrfs_init_fs_info initializes the static elements
8260edba67a2e6b Josef Bacik       2020-01-24  1463  	 * of the fs_info (locks and such) to make cleanup easier if we find a
8260edba67a2e6b Josef Bacik       2020-01-24  1464  	 * superblock with our given fs_devices later on at sget() time.
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1465  	 */
a8fd1f71749387c Jeff Mahoney      2018-02-15  1466  	fs_info = kvzalloc(sizeof(struct btrfs_fs_info), GFP_KERNEL);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1467  	if (!fs_info) {
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1468  		error = -ENOMEM;
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1469  		goto error_sec_opts;
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1470  	}
8260edba67a2e6b Josef Bacik       2020-01-24  1471  	btrfs_init_fs_info(fs_info);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1472  
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1473  	fs_info->super_copy = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1474  	fs_info->super_for_commit = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1475  	if (!fs_info->super_copy || !fs_info->super_for_commit) {
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1476  		error = -ENOMEM;
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1477  		goto error_fs_info;
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1478  	}
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1479  
399f7f4c42e8a58 David Sterba      2018-06-19  1480  	mutex_lock(&uuid_mutex);
2ef789288afd365 Christoph Hellwig 2023-06-08  1481  	error = btrfs_parse_device_options(data, mode);
81ffd56b5745355 David Sterba      2018-06-19  1482  	if (error) {
399f7f4c42e8a58 David Sterba      2018-06-19  1483  		mutex_unlock(&uuid_mutex);
399f7f4c42e8a58 David Sterba      2018-06-19  1484  		goto error_fs_info;
81ffd56b5745355 David Sterba      2018-06-19  1485  	}
399f7f4c42e8a58 David Sterba      2018-06-19  1486  
2ef789288afd365 Christoph Hellwig 2023-06-08  1487  	device = btrfs_scan_one_device(device_name, mode);
36350e95a2b1fee Gu Jinxiang       2018-07-12  1488  	if (IS_ERR(device)) {
399f7f4c42e8a58 David Sterba      2018-06-19  1489  		mutex_unlock(&uuid_mutex);
36350e95a2b1fee Gu Jinxiang       2018-07-12  1490  		error = PTR_ERR(device);
399f7f4c42e8a58 David Sterba      2018-06-19  1491  		goto error_fs_info;
81ffd56b5745355 David Sterba      2018-06-19  1492  	}
399f7f4c42e8a58 David Sterba      2018-06-19  1493  
36350e95a2b1fee Gu Jinxiang       2018-07-12  1494  	fs_devices = device->fs_devices;
399f7f4c42e8a58 David Sterba      2018-06-19  1495  	fs_info->fs_devices = fs_devices;
399f7f4c42e8a58 David Sterba      2018-06-19  1496  
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1497  	error = btrfs_open_devices(fs_devices, mode, fs_type);
f5194e34cabaddd David Sterba      2018-06-19  1498  	mutex_unlock(&uuid_mutex);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1499  	if (error)
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1500  		goto error_fs_info;
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1501  
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1502  	if (!(flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1503  		error = -EACCES;
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1504  		goto error_close_devices;
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1505  	}
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1506  
d24fa5c1da08026 Anand Jain        2021-08-24  1507  	bdev = fs_devices->latest_dev->bdev;
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1508  	s = sget(fs_type, btrfs_test_super, btrfs_set_super, flags | SB_NOSEC,
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1509  		 fs_info);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1510  	if (IS_ERR(s)) {
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1511  		error = PTR_ERR(s);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1512  		goto error_close_devices;
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1513  	}
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1514  
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1515  	if (s->s_root) {
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1516  		btrfs_close_devices(fs_devices);
0d4b0463011de06 Josef Bacik       2020-01-24  1517  		btrfs_free_fs_info(fs_info);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1518  		if ((flags ^ s->s_flags) & SB_RDONLY)
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1519  			error = -EBUSY;
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1520  	} else {
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1521  		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
e33c267ab70de42 Roman Gushchin    2022-05-31  1522  		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
e33c267ab70de42 Roman Gushchin    2022-05-31  1523  					s->s_id);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1524  		btrfs_sb(s)->bdev_holder = fs_type;
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1525  		error = btrfs_fill_super(s, fs_devices, data);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1526  	}
a65001e8a4d4656 Al Viro           2018-12-10  1527  	if (!error)
204cc0ccf1d49c6 Al Viro           2018-12-13 @1528  		error = security_sb_set_mnt_opts(s, new_sec_opts, 0, NULL);
a65001e8a4d4656 Al Viro           2018-12-10 @1529  	security_free_mnt_opts(&new_sec_opts);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1530  	if (error) {
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1531  		deactivate_locked_super(s);
a65001e8a4d4656 Al Viro           2018-12-10  1532  		return ERR_PTR(error);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1533  	}
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1534  
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1535  	return dget(s->s_root);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1536  
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1537  error_close_devices:
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1538  	btrfs_close_devices(fs_devices);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1539  error_fs_info:
0d4b0463011de06 Josef Bacik       2020-01-24  1540  	btrfs_free_fs_info(fs_info);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1541  error_sec_opts:
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1542  	security_free_mnt_opts(&new_sec_opts);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1543  	return ERR_PTR(error);
72fa39f5c7a1c9d Misono, Tomohiro  2017-12-14  1544  }
312c89fbca06896 Misono, Tomohiro  2017-12-14  1545  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
