Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CE75757C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 00:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbiGNWlx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 18:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240777AbiGNWlw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 18:41:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABB671BFB
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 15:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657838510; x=1689374510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ifJW2rvI0TlMiJZ/rOtrnnVxI8Tm9w+jBaQ9MyStoq0=;
  b=n4ze0koFjV1kRcj7OGbsQ5v3eh1J5f4urwhP6BGnZMrCjRqWgvdtaOTi
   EeEdXS9DuVjLm4YScAC+Y4JEWnTpKLWeUEl2/VxLa1m4WrJI+Oys6GGVD
   gQlytUvuu9b2sRcfyr+hpzFM1XwEN8YcyY9aruD/I/BDMfEwXA6mlGsYC
   wGdkbxTxeqwMO/IEpyk8z2XeGXW05qad2osqcmzGwnFs/22W1psWXRNjp
   5ZHUmdY/kSuYxoyWVX3Yr5yx97mHYbtKqJ5aaEO/nfL7jIiM7YHrgh7Dh
   Ve6RFPx8p+pVCww6IOgi0mky8auUGHArJcRG1NOd3t9KmxMGTD86qJb4T
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="283203611"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="283203611"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 15:41:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="623611984"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Jul 2022 15:41:48 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC7Wl-0001ET-CB;
        Thu, 14 Jul 2022 22:41:47 +0000
Date:   Fri, 15 Jul 2022 06:40:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH 2/5] btrfs: convert block group bit field to use bit
 helpers
Message-ID: <202207150643.6MYJm2hT-lkp@intel.com>
References: <2d97c27f8441f0ebbcadd8b22a628ed94b16cf6b.1657758678.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d97c27f8441f0ebbcadd8b22a628ed94b16cf6b.1657758678.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Josef,

I love your patch! Yet something to improve:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on next-20220714]
[cannot apply to linus/master v5.19-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Josef-Bacik/btrfs-block-group-cleanups/20220714-083606
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: hexagon-randconfig-r045-20220714 (https://download.01.org/0day-ci/archive/20220715/202207150643.6MYJm2hT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d82c8630686065ad13f9a0a3b73284f9aa3beb2d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Josef-Bacik/btrfs-block-group-cleanups/20220714-083606
        git checkout d82c8630686065ad13f9a0a3b73284f9aa3beb2d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/btrfs/block-group.c:1056:24: error: no member named 'zone_is_active' in 'struct btrfs_block_group'
                   WARN_ON(block_group->zone_is_active &&
                           ~~~~~~~~~~~  ^
   include/asm-generic/bug.h:122:25: note: expanded from macro 'WARN_ON'
           int __ret_warn_on = !!(condition);                              \
                                  ^~~~~~~~~
   fs/btrfs/block-group.c:1061:19: error: no member named 'zone_is_active' in 'struct btrfs_block_group'
           if (block_group->zone_is_active)
               ~~~~~~~~~~~  ^
   fs/btrfs/block-group.c:2118:34: error: no member named 'zone_is_active' in 'struct btrfs_block_group'
                                   cache->zone_unusable, cache->zone_is_active,
                                                         ~~~~~  ^
   fs/btrfs/block-group.c:2571:12: error: no member named 'zone_is_active' in 'struct btrfs_block_group'
                                   cache->zone_is_active, &cache->space_info);
                                   ~~~~~  ^
   4 errors generated.
--
>> fs/btrfs/zoned.c:2269:43: error: no member named 'zone_is_active' in 'struct btrfs_block_group'
                                   if (btrfs_zoned_bg_is_full(bg) || bg->zone_is_active) {
                                                                     ~~  ^
   1 error generated.


vim +1056 fs/btrfs/block-group.c

7357623a7f4beb4 Qu Wenruo          2020-05-05   888  
e3e0520b32bc3db Josef Bacik        2019-06-20   889  int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
e3e0520b32bc3db Josef Bacik        2019-06-20   890  			     u64 group_start, struct extent_map *em)
e3e0520b32bc3db Josef Bacik        2019-06-20   891  {
e3e0520b32bc3db Josef Bacik        2019-06-20   892  	struct btrfs_fs_info *fs_info = trans->fs_info;
e3e0520b32bc3db Josef Bacik        2019-06-20   893  	struct btrfs_path *path;
32da5386d9a4fd5 David Sterba       2019-10-29   894  	struct btrfs_block_group *block_group;
e3e0520b32bc3db Josef Bacik        2019-06-20   895  	struct btrfs_free_cluster *cluster;
e3e0520b32bc3db Josef Bacik        2019-06-20   896  	struct inode *inode;
e3e0520b32bc3db Josef Bacik        2019-06-20   897  	struct kobject *kobj = NULL;
e3e0520b32bc3db Josef Bacik        2019-06-20   898  	int ret;
e3e0520b32bc3db Josef Bacik        2019-06-20   899  	int index;
e3e0520b32bc3db Josef Bacik        2019-06-20   900  	int factor;
e3e0520b32bc3db Josef Bacik        2019-06-20   901  	struct btrfs_caching_control *caching_ctl = NULL;
e3e0520b32bc3db Josef Bacik        2019-06-20   902  	bool remove_em;
e3e0520b32bc3db Josef Bacik        2019-06-20   903  	bool remove_rsv = false;
e3e0520b32bc3db Josef Bacik        2019-06-20   904  
e3e0520b32bc3db Josef Bacik        2019-06-20   905  	block_group = btrfs_lookup_block_group(fs_info, group_start);
e3e0520b32bc3db Josef Bacik        2019-06-20   906  	BUG_ON(!block_group);
e3e0520b32bc3db Josef Bacik        2019-06-20   907  	BUG_ON(!block_group->ro);
e3e0520b32bc3db Josef Bacik        2019-06-20   908  
e3e0520b32bc3db Josef Bacik        2019-06-20   909  	trace_btrfs_remove_block_group(block_group);
e3e0520b32bc3db Josef Bacik        2019-06-20   910  	/*
e3e0520b32bc3db Josef Bacik        2019-06-20   911  	 * Free the reserved super bytes from this block group before
e3e0520b32bc3db Josef Bacik        2019-06-20   912  	 * remove it.
e3e0520b32bc3db Josef Bacik        2019-06-20   913  	 */
e3e0520b32bc3db Josef Bacik        2019-06-20   914  	btrfs_free_excluded_extents(block_group);
b3470b5dbe1300d David Sterba       2019-10-23   915  	btrfs_free_ref_tree_range(fs_info, block_group->start,
b3470b5dbe1300d David Sterba       2019-10-23   916  				  block_group->length);
e3e0520b32bc3db Josef Bacik        2019-06-20   917  
e3e0520b32bc3db Josef Bacik        2019-06-20   918  	index = btrfs_bg_flags_to_raid_index(block_group->flags);
e3e0520b32bc3db Josef Bacik        2019-06-20   919  	factor = btrfs_bg_type_to_factor(block_group->flags);
e3e0520b32bc3db Josef Bacik        2019-06-20   920  
e3e0520b32bc3db Josef Bacik        2019-06-20   921  	/* make sure this block group isn't part of an allocation cluster */
e3e0520b32bc3db Josef Bacik        2019-06-20   922  	cluster = &fs_info->data_alloc_cluster;
e3e0520b32bc3db Josef Bacik        2019-06-20   923  	spin_lock(&cluster->refill_lock);
e3e0520b32bc3db Josef Bacik        2019-06-20   924  	btrfs_return_cluster_to_free_space(block_group, cluster);
e3e0520b32bc3db Josef Bacik        2019-06-20   925  	spin_unlock(&cluster->refill_lock);
e3e0520b32bc3db Josef Bacik        2019-06-20   926  
e3e0520b32bc3db Josef Bacik        2019-06-20   927  	/*
e3e0520b32bc3db Josef Bacik        2019-06-20   928  	 * make sure this block group isn't part of a metadata
e3e0520b32bc3db Josef Bacik        2019-06-20   929  	 * allocation cluster
e3e0520b32bc3db Josef Bacik        2019-06-20   930  	 */
e3e0520b32bc3db Josef Bacik        2019-06-20   931  	cluster = &fs_info->meta_alloc_cluster;
e3e0520b32bc3db Josef Bacik        2019-06-20   932  	spin_lock(&cluster->refill_lock);
e3e0520b32bc3db Josef Bacik        2019-06-20   933  	btrfs_return_cluster_to_free_space(block_group, cluster);
e3e0520b32bc3db Josef Bacik        2019-06-20   934  	spin_unlock(&cluster->refill_lock);
e3e0520b32bc3db Josef Bacik        2019-06-20   935  
40ab3be102f0a61 Naohiro Aota       2021-02-04   936  	btrfs_clear_treelog_bg(block_group);
c2707a255623435 Johannes Thumshirn 2021-09-09   937  	btrfs_clear_data_reloc_bg(block_group);
40ab3be102f0a61 Naohiro Aota       2021-02-04   938  
e3e0520b32bc3db Josef Bacik        2019-06-20   939  	path = btrfs_alloc_path();
e3e0520b32bc3db Josef Bacik        2019-06-20   940  	if (!path) {
e3e0520b32bc3db Josef Bacik        2019-06-20   941  		ret = -ENOMEM;
9fecd13202f520f Filipe Manana      2020-06-01   942  		goto out;
e3e0520b32bc3db Josef Bacik        2019-06-20   943  	}
e3e0520b32bc3db Josef Bacik        2019-06-20   944  
e3e0520b32bc3db Josef Bacik        2019-06-20   945  	/*
e3e0520b32bc3db Josef Bacik        2019-06-20   946  	 * get the inode first so any iput calls done for the io_list
e3e0520b32bc3db Josef Bacik        2019-06-20   947  	 * aren't the final iput (no unlinks allowed now)
e3e0520b32bc3db Josef Bacik        2019-06-20   948  	 */
e3e0520b32bc3db Josef Bacik        2019-06-20   949  	inode = lookup_free_space_inode(block_group, path);
e3e0520b32bc3db Josef Bacik        2019-06-20   950  
e3e0520b32bc3db Josef Bacik        2019-06-20   951  	mutex_lock(&trans->transaction->cache_write_mutex);
e3e0520b32bc3db Josef Bacik        2019-06-20   952  	/*
e3e0520b32bc3db Josef Bacik        2019-06-20   953  	 * Make sure our free space cache IO is done before removing the
e3e0520b32bc3db Josef Bacik        2019-06-20   954  	 * free space inode
e3e0520b32bc3db Josef Bacik        2019-06-20   955  	 */
e3e0520b32bc3db Josef Bacik        2019-06-20   956  	spin_lock(&trans->transaction->dirty_bgs_lock);
e3e0520b32bc3db Josef Bacik        2019-06-20   957  	if (!list_empty(&block_group->io_list)) {
e3e0520b32bc3db Josef Bacik        2019-06-20   958  		list_del_init(&block_group->io_list);
e3e0520b32bc3db Josef Bacik        2019-06-20   959  
e3e0520b32bc3db Josef Bacik        2019-06-20   960  		WARN_ON(!IS_ERR(inode) && inode != block_group->io_ctl.inode);
e3e0520b32bc3db Josef Bacik        2019-06-20   961  
e3e0520b32bc3db Josef Bacik        2019-06-20   962  		spin_unlock(&trans->transaction->dirty_bgs_lock);
e3e0520b32bc3db Josef Bacik        2019-06-20   963  		btrfs_wait_cache_io(trans, block_group, path);
e3e0520b32bc3db Josef Bacik        2019-06-20   964  		btrfs_put_block_group(block_group);
e3e0520b32bc3db Josef Bacik        2019-06-20   965  		spin_lock(&trans->transaction->dirty_bgs_lock);
e3e0520b32bc3db Josef Bacik        2019-06-20   966  	}
e3e0520b32bc3db Josef Bacik        2019-06-20   967  
e3e0520b32bc3db Josef Bacik        2019-06-20   968  	if (!list_empty(&block_group->dirty_list)) {
e3e0520b32bc3db Josef Bacik        2019-06-20   969  		list_del_init(&block_group->dirty_list);
e3e0520b32bc3db Josef Bacik        2019-06-20   970  		remove_rsv = true;
e3e0520b32bc3db Josef Bacik        2019-06-20   971  		btrfs_put_block_group(block_group);
e3e0520b32bc3db Josef Bacik        2019-06-20   972  	}
e3e0520b32bc3db Josef Bacik        2019-06-20   973  	spin_unlock(&trans->transaction->dirty_bgs_lock);
e3e0520b32bc3db Josef Bacik        2019-06-20   974  	mutex_unlock(&trans->transaction->cache_write_mutex);
e3e0520b32bc3db Josef Bacik        2019-06-20   975  
36b216c85eb9d7f Boris Burkov       2020-11-18   976  	ret = btrfs_remove_free_space_inode(trans, inode, block_group);
e3e0520b32bc3db Josef Bacik        2019-06-20   977  	if (ret)
9fecd13202f520f Filipe Manana      2020-06-01   978  		goto out;
e3e0520b32bc3db Josef Bacik        2019-06-20   979  
16b0c2581e3a81e Filipe Manana      2022-04-13   980  	write_lock(&fs_info->block_group_cache_lock);
08dddb2951c96b5 Filipe Manana      2022-04-13   981  	rb_erase_cached(&block_group->cache_node,
e3e0520b32bc3db Josef Bacik        2019-06-20   982  			&fs_info->block_group_cache_tree);
e3e0520b32bc3db Josef Bacik        2019-06-20   983  	RB_CLEAR_NODE(&block_group->cache_node);
e3e0520b32bc3db Josef Bacik        2019-06-20   984  
9fecd13202f520f Filipe Manana      2020-06-01   985  	/* Once for the block groups rbtree */
9fecd13202f520f Filipe Manana      2020-06-01   986  	btrfs_put_block_group(block_group);
9fecd13202f520f Filipe Manana      2020-06-01   987  
16b0c2581e3a81e Filipe Manana      2022-04-13   988  	write_unlock(&fs_info->block_group_cache_lock);
e3e0520b32bc3db Josef Bacik        2019-06-20   989  
e3e0520b32bc3db Josef Bacik        2019-06-20   990  	down_write(&block_group->space_info->groups_sem);
e3e0520b32bc3db Josef Bacik        2019-06-20   991  	/*
e3e0520b32bc3db Josef Bacik        2019-06-20   992  	 * we must use list_del_init so people can check to see if they
e3e0520b32bc3db Josef Bacik        2019-06-20   993  	 * are still on the list after taking the semaphore
e3e0520b32bc3db Josef Bacik        2019-06-20   994  	 */
e3e0520b32bc3db Josef Bacik        2019-06-20   995  	list_del_init(&block_group->list);
e3e0520b32bc3db Josef Bacik        2019-06-20   996  	if (list_empty(&block_group->space_info->block_groups[index])) {
e3e0520b32bc3db Josef Bacik        2019-06-20   997  		kobj = block_group->space_info->block_group_kobjs[index];
e3e0520b32bc3db Josef Bacik        2019-06-20   998  		block_group->space_info->block_group_kobjs[index] = NULL;
e3e0520b32bc3db Josef Bacik        2019-06-20   999  		clear_avail_alloc_bits(fs_info, block_group->flags);
e3e0520b32bc3db Josef Bacik        2019-06-20  1000  	}
e3e0520b32bc3db Josef Bacik        2019-06-20  1001  	up_write(&block_group->space_info->groups_sem);
e3e0520b32bc3db Josef Bacik        2019-06-20  1002  	clear_incompat_bg_bits(fs_info, block_group->flags);
e3e0520b32bc3db Josef Bacik        2019-06-20  1003  	if (kobj) {
e3e0520b32bc3db Josef Bacik        2019-06-20  1004  		kobject_del(kobj);
e3e0520b32bc3db Josef Bacik        2019-06-20  1005  		kobject_put(kobj);
e3e0520b32bc3db Josef Bacik        2019-06-20  1006  	}
e3e0520b32bc3db Josef Bacik        2019-06-20  1007  
d82c8630686065a Josef Bacik        2022-07-13  1008  	if (test_bit(BLOCK_GROUP_FLAG_HAS_CACHING_CTL,
d82c8630686065a Josef Bacik        2022-07-13  1009  		     &block_group->runtime_flags))
e3e0520b32bc3db Josef Bacik        2019-06-20  1010  		caching_ctl = btrfs_get_caching_control(block_group);
e3e0520b32bc3db Josef Bacik        2019-06-20  1011  	if (block_group->cached == BTRFS_CACHE_STARTED)
e3e0520b32bc3db Josef Bacik        2019-06-20  1012  		btrfs_wait_block_group_cache_done(block_group);
d82c8630686065a Josef Bacik        2022-07-13  1013  	if (test_bit(BLOCK_GROUP_FLAG_HAS_CACHING_CTL,
d82c8630686065a Josef Bacik        2022-07-13  1014  		     &block_group->runtime_flags)) {
16b0c2581e3a81e Filipe Manana      2022-04-13  1015  		write_lock(&fs_info->block_group_cache_lock);
e3e0520b32bc3db Josef Bacik        2019-06-20  1016  		if (!caching_ctl) {
e3e0520b32bc3db Josef Bacik        2019-06-20  1017  			struct btrfs_caching_control *ctl;
e3e0520b32bc3db Josef Bacik        2019-06-20  1018  
e3e0520b32bc3db Josef Bacik        2019-06-20  1019  			list_for_each_entry(ctl,
e3e0520b32bc3db Josef Bacik        2019-06-20  1020  				    &fs_info->caching_block_groups, list)
e3e0520b32bc3db Josef Bacik        2019-06-20  1021  				if (ctl->block_group == block_group) {
e3e0520b32bc3db Josef Bacik        2019-06-20  1022  					caching_ctl = ctl;
e3e0520b32bc3db Josef Bacik        2019-06-20  1023  					refcount_inc(&caching_ctl->count);
e3e0520b32bc3db Josef Bacik        2019-06-20  1024  					break;
e3e0520b32bc3db Josef Bacik        2019-06-20  1025  				}
e3e0520b32bc3db Josef Bacik        2019-06-20  1026  		}
e3e0520b32bc3db Josef Bacik        2019-06-20  1027  		if (caching_ctl)
e3e0520b32bc3db Josef Bacik        2019-06-20  1028  			list_del_init(&caching_ctl->list);
16b0c2581e3a81e Filipe Manana      2022-04-13  1029  		write_unlock(&fs_info->block_group_cache_lock);
e3e0520b32bc3db Josef Bacik        2019-06-20  1030  		if (caching_ctl) {
e3e0520b32bc3db Josef Bacik        2019-06-20  1031  			/* Once for the caching bgs list and once for us. */
e3e0520b32bc3db Josef Bacik        2019-06-20  1032  			btrfs_put_caching_control(caching_ctl);
e3e0520b32bc3db Josef Bacik        2019-06-20  1033  			btrfs_put_caching_control(caching_ctl);
e3e0520b32bc3db Josef Bacik        2019-06-20  1034  		}
e3e0520b32bc3db Josef Bacik        2019-06-20  1035  	}
e3e0520b32bc3db Josef Bacik        2019-06-20  1036  
e3e0520b32bc3db Josef Bacik        2019-06-20  1037  	spin_lock(&trans->transaction->dirty_bgs_lock);
e3e0520b32bc3db Josef Bacik        2019-06-20  1038  	WARN_ON(!list_empty(&block_group->dirty_list));
e3e0520b32bc3db Josef Bacik        2019-06-20  1039  	WARN_ON(!list_empty(&block_group->io_list));
e3e0520b32bc3db Josef Bacik        2019-06-20  1040  	spin_unlock(&trans->transaction->dirty_bgs_lock);
e3e0520b32bc3db Josef Bacik        2019-06-20  1041  
e3e0520b32bc3db Josef Bacik        2019-06-20  1042  	btrfs_remove_free_space_cache(block_group);
e3e0520b32bc3db Josef Bacik        2019-06-20  1043  
e3e0520b32bc3db Josef Bacik        2019-06-20  1044  	spin_lock(&block_group->space_info->lock);
e3e0520b32bc3db Josef Bacik        2019-06-20  1045  	list_del_init(&block_group->ro_list);
e3e0520b32bc3db Josef Bacik        2019-06-20  1046  
e3e0520b32bc3db Josef Bacik        2019-06-20  1047  	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
e3e0520b32bc3db Josef Bacik        2019-06-20  1048  		WARN_ON(block_group->space_info->total_bytes
b3470b5dbe1300d David Sterba       2019-10-23  1049  			< block_group->length);
e3e0520b32bc3db Josef Bacik        2019-06-20  1050  		WARN_ON(block_group->space_info->bytes_readonly
169e0da91a21a57 Naohiro Aota       2021-02-04  1051  			< block_group->length - block_group->zone_unusable);
169e0da91a21a57 Naohiro Aota       2021-02-04  1052  		WARN_ON(block_group->space_info->bytes_zone_unusable
169e0da91a21a57 Naohiro Aota       2021-02-04  1053  			< block_group->zone_unusable);
e3e0520b32bc3db Josef Bacik        2019-06-20  1054  		WARN_ON(block_group->space_info->disk_total
b3470b5dbe1300d David Sterba       2019-10-23  1055  			< block_group->length * factor);
5c21202df2c7336 Naohiro Aota       2022-07-09 @1056  		WARN_ON(block_group->zone_is_active &&
5c21202df2c7336 Naohiro Aota       2022-07-09  1057  			block_group->space_info->active_total_bytes
5c21202df2c7336 Naohiro Aota       2022-07-09  1058  			< block_group->length);
e3e0520b32bc3db Josef Bacik        2019-06-20  1059  	}
b3470b5dbe1300d David Sterba       2019-10-23  1060  	block_group->space_info->total_bytes -= block_group->length;
5c21202df2c7336 Naohiro Aota       2022-07-09  1061  	if (block_group->zone_is_active)
5c21202df2c7336 Naohiro Aota       2022-07-09  1062  		block_group->space_info->active_total_bytes -= block_group->length;
169e0da91a21a57 Naohiro Aota       2021-02-04  1063  	block_group->space_info->bytes_readonly -=
169e0da91a21a57 Naohiro Aota       2021-02-04  1064  		(block_group->length - block_group->zone_unusable);
169e0da91a21a57 Naohiro Aota       2021-02-04  1065  	block_group->space_info->bytes_zone_unusable -=
169e0da91a21a57 Naohiro Aota       2021-02-04  1066  		block_group->zone_unusable;
b3470b5dbe1300d David Sterba       2019-10-23  1067  	block_group->space_info->disk_total -= block_group->length * factor;
e3e0520b32bc3db Josef Bacik        2019-06-20  1068  
e3e0520b32bc3db Josef Bacik        2019-06-20  1069  	spin_unlock(&block_group->space_info->lock);
e3e0520b32bc3db Josef Bacik        2019-06-20  1070  
ffcb9d44572afba Filipe Manana      2020-06-01  1071  	/*
ffcb9d44572afba Filipe Manana      2020-06-01  1072  	 * Remove the free space for the block group from the free space tree
ffcb9d44572afba Filipe Manana      2020-06-01  1073  	 * and the block group's item from the extent tree before marking the
ffcb9d44572afba Filipe Manana      2020-06-01  1074  	 * block group as removed. This is to prevent races with tasks that
ffcb9d44572afba Filipe Manana      2020-06-01  1075  	 * freeze and unfreeze a block group, this task and another task
ffcb9d44572afba Filipe Manana      2020-06-01  1076  	 * allocating a new block group - the unfreeze task ends up removing
ffcb9d44572afba Filipe Manana      2020-06-01  1077  	 * the block group's extent map before the task calling this function
ffcb9d44572afba Filipe Manana      2020-06-01  1078  	 * deletes the block group item from the extent tree, allowing for
ffcb9d44572afba Filipe Manana      2020-06-01  1079  	 * another task to attempt to create another block group with the same
ffcb9d44572afba Filipe Manana      2020-06-01  1080  	 * item key (and failing with -EEXIST and a transaction abort).
ffcb9d44572afba Filipe Manana      2020-06-01  1081  	 */
ffcb9d44572afba Filipe Manana      2020-06-01  1082  	ret = remove_block_group_free_space(trans, block_group);
ffcb9d44572afba Filipe Manana      2020-06-01  1083  	if (ret)
ffcb9d44572afba Filipe Manana      2020-06-01  1084  		goto out;
ffcb9d44572afba Filipe Manana      2020-06-01  1085  
ffcb9d44572afba Filipe Manana      2020-06-01  1086  	ret = remove_block_group_item(trans, path, block_group);
ffcb9d44572afba Filipe Manana      2020-06-01  1087  	if (ret < 0)
ffcb9d44572afba Filipe Manana      2020-06-01  1088  		goto out;
ffcb9d44572afba Filipe Manana      2020-06-01  1089  
e3e0520b32bc3db Josef Bacik        2019-06-20  1090  	spin_lock(&block_group->lock);
d82c8630686065a Josef Bacik        2022-07-13  1091  	set_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags);
d82c8630686065a Josef Bacik        2022-07-13  1092  
e3e0520b32bc3db Josef Bacik        2019-06-20  1093  	/*
6b7304af62d02d7 Filipe Manana      2020-05-08  1094  	 * At this point trimming or scrub can't start on this block group,
6b7304af62d02d7 Filipe Manana      2020-05-08  1095  	 * because we removed the block group from the rbtree
6b7304af62d02d7 Filipe Manana      2020-05-08  1096  	 * fs_info->block_group_cache_tree so no one can't find it anymore and
6b7304af62d02d7 Filipe Manana      2020-05-08  1097  	 * even if someone already got this block group before we removed it
6b7304af62d02d7 Filipe Manana      2020-05-08  1098  	 * from the rbtree, they have already incremented block_group->frozen -
6b7304af62d02d7 Filipe Manana      2020-05-08  1099  	 * if they didn't, for the trimming case they won't find any free space
6b7304af62d02d7 Filipe Manana      2020-05-08  1100  	 * entries because we already removed them all when we called
6b7304af62d02d7 Filipe Manana      2020-05-08  1101  	 * btrfs_remove_free_space_cache().
e3e0520b32bc3db Josef Bacik        2019-06-20  1102  	 *
e3e0520b32bc3db Josef Bacik        2019-06-20  1103  	 * And we must not remove the extent map from the fs_info->mapping_tree
e3e0520b32bc3db Josef Bacik        2019-06-20  1104  	 * to prevent the same logical address range and physical device space
6b7304af62d02d7 Filipe Manana      2020-05-08  1105  	 * ranges from being reused for a new block group. This is needed to
6b7304af62d02d7 Filipe Manana      2020-05-08  1106  	 * avoid races with trimming and scrub.
6b7304af62d02d7 Filipe Manana      2020-05-08  1107  	 *
6b7304af62d02d7 Filipe Manana      2020-05-08  1108  	 * An fs trim operation (btrfs_trim_fs() / btrfs_ioctl_fitrim()) is
e3e0520b32bc3db Josef Bacik        2019-06-20  1109  	 * completely transactionless, so while it is trimming a range the
e3e0520b32bc3db Josef Bacik        2019-06-20  1110  	 * currently running transaction might finish and a new one start,
e3e0520b32bc3db Josef Bacik        2019-06-20  1111  	 * allowing for new block groups to be created that can reuse the same
e3e0520b32bc3db Josef Bacik        2019-06-20  1112  	 * physical device locations unless we take this special care.
e3e0520b32bc3db Josef Bacik        2019-06-20  1113  	 *
e3e0520b32bc3db Josef Bacik        2019-06-20  1114  	 * There may also be an implicit trim operation if the file system
e3e0520b32bc3db Josef Bacik        2019-06-20  1115  	 * is mounted with -odiscard. The same protections must remain
e3e0520b32bc3db Josef Bacik        2019-06-20  1116  	 * in place until the extents have been discarded completely when
e3e0520b32bc3db Josef Bacik        2019-06-20  1117  	 * the transaction commit has completed.
e3e0520b32bc3db Josef Bacik        2019-06-20  1118  	 */
6b7304af62d02d7 Filipe Manana      2020-05-08  1119  	remove_em = (atomic_read(&block_group->frozen) == 0);
e3e0520b32bc3db Josef Bacik        2019-06-20  1120  	spin_unlock(&block_group->lock);
e3e0520b32bc3db Josef Bacik        2019-06-20  1121  
e3e0520b32bc3db Josef Bacik        2019-06-20  1122  	if (remove_em) {
e3e0520b32bc3db Josef Bacik        2019-06-20  1123  		struct extent_map_tree *em_tree;
e3e0520b32bc3db Josef Bacik        2019-06-20  1124  
e3e0520b32bc3db Josef Bacik        2019-06-20  1125  		em_tree = &fs_info->mapping_tree;
e3e0520b32bc3db Josef Bacik        2019-06-20  1126  		write_lock(&em_tree->lock);
e3e0520b32bc3db Josef Bacik        2019-06-20  1127  		remove_extent_mapping(em_tree, em);
e3e0520b32bc3db Josef Bacik        2019-06-20  1128  		write_unlock(&em_tree->lock);
e3e0520b32bc3db Josef Bacik        2019-06-20  1129  		/* once for the tree */
e3e0520b32bc3db Josef Bacik        2019-06-20  1130  		free_extent_map(em);
e3e0520b32bc3db Josef Bacik        2019-06-20  1131  	}
f6033c5e333238f Xiyu Yang          2020-04-21  1132  
9fecd13202f520f Filipe Manana      2020-06-01  1133  out:
f6033c5e333238f Xiyu Yang          2020-04-21  1134  	/* Once for the lookup reference */
f6033c5e333238f Xiyu Yang          2020-04-21  1135  	btrfs_put_block_group(block_group);
e3e0520b32bc3db Josef Bacik        2019-06-20  1136  	if (remove_rsv)
e3e0520b32bc3db Josef Bacik        2019-06-20  1137  		btrfs_delayed_refs_rsv_release(fs_info, 1);
e3e0520b32bc3db Josef Bacik        2019-06-20  1138  	btrfs_free_path(path);
e3e0520b32bc3db Josef Bacik        2019-06-20  1139  	return ret;
e3e0520b32bc3db Josef Bacik        2019-06-20  1140  }
e3e0520b32bc3db Josef Bacik        2019-06-20  1141  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
