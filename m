Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB214DBD46
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 03:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbiCQC4S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 22:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiCQC4S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 22:56:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B03EFD37
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 19:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647485702; x=1679021702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mJG3+T/os74k4u38gDzqV2ESlHiHGU9GXbuLmI+9WmE=;
  b=TZ2Z01fBUq9tlsG7Oq4zbr3bI4vGYl20ICFX8kcmZP12LvmKh2SfWyPX
   kuYfxtSS4lT7KUy6lB79+7lh1KI1Ke+LpfuwJTqfnJrDQNq6c6YtpebV7
   J6ldljk63L484OKVKu/weuBZzsgXi7t5+PCxdpIlLeOl/T4KXEcG2qT6H
   1Aehjsiqk7xR/YzJdgxkO30dKUOliPCp6kg+rVRwIRiijMdAXcFgRwK4f
   SZn6jbxVgJFosiFKA6yo7QgJtI42XOxJ4cbvA3pSlgDS7c5E0j9Eyw8Qz
   VMqc9yeaRd+7iYWSGUyauofdNR6Ju7XH/0SGG0niCGkU0KnrYLr66jQ8g
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256719436"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="256719436"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 19:54:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="714867774"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Mar 2022 19:54:36 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUgHb-000DE3-CI; Thu, 17 Mar 2022 02:54:35 +0000
Date:   Thu, 17 Mar 2022 10:54:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH] btrfs: fix the uninitialized btrfs_bio::iter
Message-ID: <202203171007.1LuEGp3u-lkp@intel.com>
References: <f7698bebfcbd1687dbf8742290cd8d88b891590f.1647476483.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7698bebfcbd1687dbf8742290cd8d88b891590f.1647476483.git.wqu@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on v5.17-rc8 next-20220316]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Qu-Wenruo/btrfs-fix-the-uninitialized-btrfs_bio-iter/20220317-082643
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: arm-randconfig-c002-20220314 (https://download.01.org/0day-ci/archive/20220317/202203171007.1LuEGp3u-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8712b95c5f74e4842f3b19b36417be829b2281b2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Qu-Wenruo/btrfs-fix-the-uninitialized-btrfs_bio-iter/20220317-082643
        git checkout 8712b95c5f74e4842f3b19b36417be829b2281b2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/btrfs/compression.c: In function 'btrfs_submit_compressed_write':
>> fs/btrfs/compression.c:617:17: error: implicit declaration of function 'btrfs_bio_save_iter'; did you mean 'btrfs_do_write_iter'? [-Werror=implicit-function-declaration]
     617 |                 btrfs_bio_save_iter(btrfs_bio(bio));
         |                 ^~~~~~~~~~~~~~~~~~~
         |                 btrfs_do_write_iter
   cc1: some warnings being treated as errors


vim +617 fs/btrfs/compression.c

   494	
   495	/*
   496	 * worker function to build and submit bios for previously compressed pages.
   497	 * The corresponding pages in the inode should be marked for writeback
   498	 * and the compressed pages should have a reference on them for dropping
   499	 * when the IO is complete.
   500	 *
   501	 * This also checksums the file bytes and gets things ready for
   502	 * the end io hooks.
   503	 */
   504	blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
   505					 unsigned int len, u64 disk_start,
   506					 unsigned int compressed_len,
   507					 struct page **compressed_pages,
   508					 unsigned int nr_pages,
   509					 unsigned int write_flags,
   510					 struct cgroup_subsys_state *blkcg_css,
   511					 bool writeback)
   512	{
   513		struct btrfs_fs_info *fs_info = inode->root->fs_info;
   514		struct bio *bio = NULL;
   515		struct compressed_bio *cb;
   516		u64 cur_disk_bytenr = disk_start;
   517		u64 next_stripe_start;
   518		blk_status_t ret;
   519		int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;
   520		const bool use_append = btrfs_use_zone_append(inode, disk_start);
   521		const unsigned int bio_op = use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE;
   522	
   523		ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
   524		       IS_ALIGNED(len, fs_info->sectorsize));
   525		cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
   526		if (!cb)
   527			return BLK_STS_RESOURCE;
   528		refcount_set(&cb->pending_sectors, compressed_len >> fs_info->sectorsize_bits);
   529		cb->status = BLK_STS_OK;
   530		cb->inode = &inode->vfs_inode;
   531		cb->start = start;
   532		cb->len = len;
   533		cb->mirror_num = 0;
   534		cb->compressed_pages = compressed_pages;
   535		cb->compressed_len = compressed_len;
   536		cb->writeback = writeback;
   537		cb->orig_bio = NULL;
   538		cb->nr_pages = nr_pages;
   539	
   540		while (cur_disk_bytenr < disk_start + compressed_len) {
   541			u64 offset = cur_disk_bytenr - disk_start;
   542			unsigned int index = offset >> PAGE_SHIFT;
   543			unsigned int real_size;
   544			unsigned int added;
   545			struct page *page = compressed_pages[index];
   546			bool submit = false;
   547	
   548			/* Allocate new bio if submitted or not yet allocated */
   549			if (!bio) {
   550				bio = alloc_compressed_bio(cb, cur_disk_bytenr,
   551					bio_op | write_flags, end_compressed_bio_write,
   552					&next_stripe_start);
   553				if (IS_ERR(bio)) {
   554					ret = errno_to_blk_status(PTR_ERR(bio));
   555					bio = NULL;
   556					goto finish_cb;
   557				}
   558			}
   559			/*
   560			 * We should never reach next_stripe_start start as we will
   561			 * submit comp_bio when reach the boundary immediately.
   562			 */
   563			ASSERT(cur_disk_bytenr != next_stripe_start);
   564	
   565			/*
   566			 * We have various limits on the real read size:
   567			 * - stripe boundary
   568			 * - page boundary
   569			 * - compressed length boundary
   570			 */
   571			real_size = min_t(u64, U32_MAX, next_stripe_start - cur_disk_bytenr);
   572			real_size = min_t(u64, real_size, PAGE_SIZE - offset_in_page(offset));
   573			real_size = min_t(u64, real_size, compressed_len - offset);
   574			ASSERT(IS_ALIGNED(real_size, fs_info->sectorsize));
   575	
   576			if (use_append)
   577				added = bio_add_zone_append_page(bio, page, real_size,
   578						offset_in_page(offset));
   579			else
   580				added = bio_add_page(bio, page, real_size,
   581						offset_in_page(offset));
   582			/* Reached zoned boundary */
   583			if (added == 0)
   584				submit = true;
   585	
   586			cur_disk_bytenr += added;
   587			/* Reached stripe boundary */
   588			if (cur_disk_bytenr == next_stripe_start)
   589				submit = true;
   590	
   591			/* Finished the range */
   592			if (cur_disk_bytenr == disk_start + compressed_len)
   593				submit = true;
   594	
   595			if (submit) {
   596				if (!skip_sum) {
   597					ret = btrfs_csum_one_bio(inode, bio, start, true);
   598					if (ret)
   599						goto finish_cb;
   600				}
   601	
   602				ret = submit_compressed_bio(fs_info, cb, bio, 0);
   603				if (ret)
   604					goto finish_cb;
   605				bio = NULL;
   606			}
   607			cond_resched();
   608		}
   609		if (blkcg_css)
   610			kthread_associate_blkcg(NULL);
   611	
   612		return 0;
   613	
   614	finish_cb:
   615		if (bio) {
   616			bio->bi_status = ret;
 > 617			btrfs_bio_save_iter(btrfs_bio(bio));
   618			bio_endio(bio);
   619		}
   620		/* Last byte of @cb is submitted, endio will free @cb */
   621		if (cur_disk_bytenr == disk_start + compressed_len)
   622			return ret;
   623	
   624		wait_var_event(cb, refcount_read(&cb->pending_sectors) ==
   625				   (disk_start + compressed_len - cur_disk_bytenr) >>
   626				   fs_info->sectorsize_bits);
   627		/*
   628		 * Even with previous bio ended, we should still have io not yet
   629		 * submitted, thus need to finish manually.
   630		 */
   631		ASSERT(refcount_read(&cb->pending_sectors));
   632		/* Now we are the only one referring @cb, can finish it safely. */
   633		finish_compressed_bio_write(cb);
   634		return ret;
   635	}
   636	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
