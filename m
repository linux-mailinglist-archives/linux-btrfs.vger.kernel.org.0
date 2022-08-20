Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5137059AA85
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Aug 2022 03:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245405AbiHTBk0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 21:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245396AbiHTBkY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 21:40:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D11C0E62
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 18:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660959622; x=1692495622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NPGHzyP5OchTE4PrA/8k6USemq1cvLwbS8EX2HmNpD0=;
  b=RD3fshJwYB9dVLYMaqWJAvqEPSQKoTsM9LltZ0AqfybOYSzkrAPm+xbo
   bIEhgH9VRVxjIBYdnCy8FD9NIll5NiyBzGjeSBphCFFpF8rugnACR2Rtl
   Y1VdMfDJzKHsbC9DS3VpYYsyNfUcrKId20i+ntnmJt2zBQVWkogLDLoEN
   gG3EVo4Sbcywla4CR7APM9BSX1NHPHBOJY3qPMT8zP8SV1bvBtW9I7pMD
   nRYcpDIEDnCmvjfRLrfetjZHlR8l7Uu1FF1EedrnyBIMbUDF7IxDkO/Da
   FdOgpk5IAPvXUs5jMObMhwV6GHcgsESWLdGE3ixwVZxAtE3WCdzVDGu2h
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="290700218"
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="290700218"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 18:40:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="559138784"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Aug 2022 18:40:19 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPDTH-00020L-11;
        Sat, 20 Aug 2022 01:40:19 +0000
Date:   Sat, 20 Aug 2022 09:39:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH] btrfs: take the correct ctl lock when removing free
 space cache
Message-ID: <202208200922.2GjdXWTx-lkp@intel.com>
References: <409ff4f5a9365bec56c6a6dc77190b7a3b3645e6.1660938272.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409ff4f5a9365bec56c6a6dc77190b7a3b3645e6.1660938272.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
[also build test ERROR on next-20220819]
[cannot apply to linus/master v6.0-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Josef-Bacik/btrfs-take-the-correct-ctl-lock-when-removing-free-space-cache/20220820-034858
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: arm64-randconfig-r031-20220820 (https://download.01.org/0day-ci/archive/20220820/202208200922.2GjdXWTx-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 0ac597f3cacf60479ffd36b03766fa7462dabd78)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/318faedfa41e18cc0da723a0405510d0c474d99e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Josef-Bacik/btrfs-take-the-correct-ctl-lock-when-removing-free-space-cache/20220820-034858
        git checkout 318faedfa41e18cc0da723a0405510d0c474d99e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash ./ fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/btrfs/free-space-cache.c:1038:21: error: member reference type 'struct btrfs_free_space_ctl' is not a pointer; did you mean to use '.'?
                   spin_lock(&tmp_ctl->tree_lock);
                              ~~~~~~~^~
                                     .
>> fs/btrfs/free-space-cache.c:1038:13: error: cannot take the address of an rvalue of type 'spinlock_t' (aka 'struct spinlock')
                   spin_lock(&tmp_ctl->tree_lock);
                             ^~~~~~~~~~~~~~~~~~~
   fs/btrfs/free-space-cache.c:1040:23: error: member reference type 'struct btrfs_free_space_ctl' is not a pointer; did you mean to use '.'?
                   spin_unlock(&tmp_ctl->tree_lock);
                                ~~~~~~~^~
                                       .
   fs/btrfs/free-space-cache.c:1040:15: error: cannot take the address of an rvalue of type 'spinlock_t' (aka 'struct spinlock')
                   spin_unlock(&tmp_ctl->tree_lock);
                               ^~~~~~~~~~~~~~~~~~~
   4 errors generated.


vim +1038 fs/btrfs/free-space-cache.c

   942	
   943	int load_free_space_cache(struct btrfs_block_group *block_group)
   944	{
   945		struct btrfs_fs_info *fs_info = block_group->fs_info;
   946		struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
   947		struct btrfs_free_space_ctl tmp_ctl = {};
   948		struct inode *inode;
   949		struct btrfs_path *path;
   950		int ret = 0;
   951		bool matched;
   952		u64 used = block_group->used;
   953	
   954		/*
   955		 * Because we could potentially discard our loaded free space, we want
   956		 * to load everything into a temporary structure first, and then if it's
   957		 * valid copy it all into the actual free space ctl.
   958		 */
   959		btrfs_init_free_space_ctl(block_group, &tmp_ctl);
   960	
   961		/*
   962		 * If this block group has been marked to be cleared for one reason or
   963		 * another then we can't trust the on disk cache, so just return.
   964		 */
   965		spin_lock(&block_group->lock);
   966		if (block_group->disk_cache_state != BTRFS_DC_WRITTEN) {
   967			spin_unlock(&block_group->lock);
   968			return 0;
   969		}
   970		spin_unlock(&block_group->lock);
   971	
   972		path = btrfs_alloc_path();
   973		if (!path)
   974			return 0;
   975		path->search_commit_root = 1;
   976		path->skip_locking = 1;
   977	
   978		/*
   979		 * We must pass a path with search_commit_root set to btrfs_iget in
   980		 * order to avoid a deadlock when allocating extents for the tree root.
   981		 *
   982		 * When we are COWing an extent buffer from the tree root, when looking
   983		 * for a free extent, at extent-tree.c:find_free_extent(), we can find
   984		 * block group without its free space cache loaded. When we find one
   985		 * we must load its space cache which requires reading its free space
   986		 * cache's inode item from the root tree. If this inode item is located
   987		 * in the same leaf that we started COWing before, then we end up in
   988		 * deadlock on the extent buffer (trying to read lock it when we
   989		 * previously write locked it).
   990		 *
   991		 * It's safe to read the inode item using the commit root because
   992		 * block groups, once loaded, stay in memory forever (until they are
   993		 * removed) as well as their space caches once loaded. New block groups
   994		 * once created get their ->cached field set to BTRFS_CACHE_FINISHED so
   995		 * we will never try to read their inode item while the fs is mounted.
   996		 */
   997		inode = lookup_free_space_inode(block_group, path);
   998		if (IS_ERR(inode)) {
   999			btrfs_free_path(path);
  1000			return 0;
  1001		}
  1002	
  1003		/* We may have converted the inode and made the cache invalid. */
  1004		spin_lock(&block_group->lock);
  1005		if (block_group->disk_cache_state != BTRFS_DC_WRITTEN) {
  1006			spin_unlock(&block_group->lock);
  1007			btrfs_free_path(path);
  1008			goto out;
  1009		}
  1010		spin_unlock(&block_group->lock);
  1011	
  1012		/*
  1013		 * Reinitialize the class of struct inode's mapping->invalidate_lock for
  1014		 * free space inodes to prevent false positives related to locks for normal
  1015		 * inodes.
  1016		 */
  1017		lockdep_set_class(&(&inode->i_data)->invalidate_lock,
  1018				  &btrfs_free_space_inode_key);
  1019	
  1020		ret = __load_free_space_cache(fs_info->tree_root, inode, &tmp_ctl,
  1021					      path, block_group->start);
  1022		btrfs_free_path(path);
  1023		if (ret <= 0)
  1024			goto out;
  1025	
  1026		matched = (tmp_ctl.free_space == (block_group->length - used -
  1027						  block_group->bytes_super));
  1028	
  1029		if (matched) {
  1030			ret = copy_free_space_cache(block_group, &tmp_ctl);
  1031			/*
  1032			 * ret == 1 means we successfully loaded the free space cache,
  1033			 * so we need to re-set it here.
  1034			 */
  1035			if (ret == 0)
  1036				ret = 1;
  1037		} else {
> 1038			spin_lock(&tmp_ctl->tree_lock);
  1039			__btrfs_remove_free_space_cache(&tmp_ctl);
  1040			spin_unlock(&tmp_ctl->tree_lock);
  1041			btrfs_warn(fs_info,
  1042				   "block group %llu has wrong amount of free space",
  1043				   block_group->start);
  1044			ret = -1;
  1045		}
  1046	out:
  1047		if (ret < 0) {
  1048			/* This cache is bogus, make sure it gets cleared */
  1049			spin_lock(&block_group->lock);
  1050			block_group->disk_cache_state = BTRFS_DC_CLEAR;
  1051			spin_unlock(&block_group->lock);
  1052			ret = 0;
  1053	
  1054			btrfs_warn(fs_info,
  1055				   "failed to load free space cache for block group %llu, rebuilding it now",
  1056				   block_group->start);
  1057		}
  1058	
  1059		spin_lock(&ctl->tree_lock);
  1060		btrfs_discard_update_discardable(block_group);
  1061		spin_unlock(&ctl->tree_lock);
  1062		iput(inode);
  1063		return ret;
  1064	}
  1065	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
