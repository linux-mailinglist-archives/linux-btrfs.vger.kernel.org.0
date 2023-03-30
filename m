Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9D06D0E1D
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 20:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjC3SwX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 14:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjC3SwU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 14:52:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD841EC4D
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680202328; x=1711738328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SlSUXl9XvF/948eZLcoAV3p13CcMTU2DGsbDplVyR3s=;
  b=EHbcdPTBaTv0HJ6SUw69NtiW4DYDGdsAfbLyMgF+QIKzlUA3Uvpcna2r
   EfpnqvnLj7m29Z/px2Ku2DcaMLb6jRFLwZlmNZ7xEowenNPTGPQhFm6Yp
   qZ/DvrtTuop9MmLnjNwQoeZjBP68AOm0LoFwjgJZ0uDHgciFG64BmBbG+
   sbeyH9zrTLxN9UrOECyxaktidkrT5hvqMKeoMWtQQY7GrLWi5/PBm94Xy
   a6F5G/N/hTdOTuF87Sep27LnIc8YhFF8R8bwXiQlJ+QpdwQtZejoPzecx
   hyG/9MFUZy7lHynlVTxvHEnh1hEh6fwuOKjH/mWXDyFu8J0IQBuxs1tNy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="321647738"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="321647738"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 11:52:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="635031425"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="635031425"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2023 11:52:06 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phxNV-000L79-2G;
        Thu, 30 Mar 2023 18:52:05 +0000
Date:   Fri, 31 Mar 2023 02:51:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] btrfs: correctly calculate delayed ref bytes when
 starting transaction
Message-ID: <202303310221.Zjv7RAZT-lkp@intel.com>
References: <93c382a002210831e1051456cdc5c44dbcef4562.1680185833.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93c382a002210831e1051456cdc5c44dbcef4562.1680185833.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kdave/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/fdmanana-kernel-org/btrfs-make-btrfs_block_rsv_full-check-more-boolean-when-starting-transaction/20230330-224056
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/93c382a002210831e1051456cdc5c44dbcef4562.1680185833.git.fdmanana%40suse.com
patch subject: [PATCH 2/2] btrfs: correctly calculate delayed ref bytes when starting transaction
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20230331/202303310221.Zjv7RAZT-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7f30c221a11d9dc6fad3f763b3df7ecd0b6d966c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review fdmanana-kernel-org/btrfs-make-btrfs_block_rsv_full-check-more-boolean-when-starting-transaction/20230330-224056
        git checkout 7f30c221a11d9dc6fad3f763b3df7ecd0b6d966c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303310221.Zjv7RAZT-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/btrfs/transaction.c: In function 'start_transaction':
>> fs/btrfs/transaction.c:611:46: error: implicit declaration of function 'btrfs_calc_delayed_ref_bytes'; did you mean 'btrfs_run_delayed_refs'? [-Werror=implicit-function-declaration]
     611 |                         delayed_refs_bytes = btrfs_calc_delayed_ref_bytes(fs_info,
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                              btrfs_run_delayed_refs
   cc1: some warnings being treated as errors


vim +611 fs/btrfs/transaction.c

   558	
   559	static struct btrfs_trans_handle *
   560	start_transaction(struct btrfs_root *root, unsigned int num_items,
   561			  unsigned int type, enum btrfs_reserve_flush_enum flush,
   562			  bool enforce_qgroups)
   563	{
   564		struct btrfs_fs_info *fs_info = root->fs_info;
   565		struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
   566		struct btrfs_trans_handle *h;
   567		struct btrfs_transaction *cur_trans;
   568		u64 num_bytes = 0;
   569		u64 qgroup_reserved = 0;
   570		bool reloc_reserved = false;
   571		bool do_chunk_alloc = false;
   572		int ret;
   573	
   574		if (BTRFS_FS_ERROR(fs_info))
   575			return ERR_PTR(-EROFS);
   576	
   577		if (current->journal_info) {
   578			WARN_ON(type & TRANS_EXTWRITERS);
   579			h = current->journal_info;
   580			refcount_inc(&h->use_count);
   581			WARN_ON(refcount_read(&h->use_count) > 2);
   582			h->orig_rsv = h->block_rsv;
   583			h->block_rsv = NULL;
   584			goto got_it;
   585		}
   586	
   587		/*
   588		 * Do the reservation before we join the transaction so we can do all
   589		 * the appropriate flushing if need be.
   590		 */
   591		if (num_items && root != fs_info->chunk_root) {
   592			struct btrfs_block_rsv *rsv = &fs_info->trans_block_rsv;
   593			u64 delayed_refs_bytes = 0;
   594	
   595			qgroup_reserved = num_items * fs_info->nodesize;
   596			ret = btrfs_qgroup_reserve_meta_pertrans(root, qgroup_reserved,
   597					enforce_qgroups);
   598			if (ret)
   599				return ERR_PTR(ret);
   600	
   601			/*
   602			 * We want to reserve all the bytes we may need all at once, so
   603			 * we only do 1 enospc flushing cycle per transaction start.  We
   604			 * accomplish this by simply assuming we'll do num_items worth
   605			 * of delayed refs updates in this trans handle, and refill that
   606			 * amount for whatever is missing in the reserve.
   607			 */
   608			num_bytes = btrfs_calc_insert_metadata_size(fs_info, num_items);
   609			if (flush == BTRFS_RESERVE_FLUSH_ALL &&
   610			    !btrfs_block_rsv_full(delayed_refs_rsv)) {
 > 611				delayed_refs_bytes = btrfs_calc_delayed_ref_bytes(fs_info,
   612										  num_items);
   613				num_bytes += delayed_refs_bytes;
   614			}
   615	
   616			/*
   617			 * Do the reservation for the relocation root creation
   618			 */
   619			if (need_reserve_reloc_root(root)) {
   620				num_bytes += fs_info->nodesize;
   621				reloc_reserved = true;
   622			}
   623	
   624			ret = btrfs_block_rsv_add(fs_info, rsv, num_bytes, flush);
   625			if (ret)
   626				goto reserve_fail;
   627			if (delayed_refs_bytes) {
   628				btrfs_migrate_to_delayed_refs_rsv(fs_info, rsv,
   629								  delayed_refs_bytes);
   630				num_bytes -= delayed_refs_bytes;
   631			}
   632	
   633			if (rsv->space_info->force_alloc)
   634				do_chunk_alloc = true;
   635		} else if (num_items == 0 && flush == BTRFS_RESERVE_FLUSH_ALL &&
   636			   !btrfs_block_rsv_full(delayed_refs_rsv)) {
   637			/*
   638			 * Some people call with btrfs_start_transaction(root, 0)
   639			 * because they can be throttled, but have some other mechanism
   640			 * for reserving space.  We still want these guys to refill the
   641			 * delayed block_rsv so just add 1 items worth of reservation
   642			 * here.
   643			 */
   644			ret = btrfs_delayed_refs_rsv_refill(fs_info, flush);
   645			if (ret)
   646				goto reserve_fail;
   647		}
   648	again:
   649		h = kmem_cache_zalloc(btrfs_trans_handle_cachep, GFP_NOFS);
   650		if (!h) {
   651			ret = -ENOMEM;
   652			goto alloc_fail;
   653		}
   654	
   655		/*
   656		 * If we are JOIN_NOLOCK we're already committing a transaction and
   657		 * waiting on this guy, so we don't need to do the sb_start_intwrite
   658		 * because we're already holding a ref.  We need this because we could
   659		 * have raced in and did an fsync() on a file which can kick a commit
   660		 * and then we deadlock with somebody doing a freeze.
   661		 *
   662		 * If we are ATTACH, it means we just want to catch the current
   663		 * transaction and commit it, so we needn't do sb_start_intwrite(). 
   664		 */
   665		if (type & __TRANS_FREEZABLE)
   666			sb_start_intwrite(fs_info->sb);
   667	
   668		if (may_wait_transaction(fs_info, type))
   669			wait_current_trans(fs_info);
   670	
   671		do {
   672			ret = join_transaction(fs_info, type);
   673			if (ret == -EBUSY) {
   674				wait_current_trans(fs_info);
   675				if (unlikely(type == TRANS_ATTACH ||
   676					     type == TRANS_JOIN_NOSTART))
   677					ret = -ENOENT;
   678			}
   679		} while (ret == -EBUSY);
   680	
   681		if (ret < 0)
   682			goto join_fail;
   683	
   684		cur_trans = fs_info->running_transaction;
   685	
   686		h->transid = cur_trans->transid;
   687		h->transaction = cur_trans;
   688		refcount_set(&h->use_count, 1);
   689		h->fs_info = root->fs_info;
   690	
   691		h->type = type;
   692		INIT_LIST_HEAD(&h->new_bgs);
   693	
   694		smp_mb();
   695		if (cur_trans->state >= TRANS_STATE_COMMIT_START &&
   696		    may_wait_transaction(fs_info, type)) {
   697			current->journal_info = h;
   698			btrfs_commit_transaction(h);
   699			goto again;
   700		}
   701	
   702		if (num_bytes) {
   703			trace_btrfs_space_reservation(fs_info, "transaction",
   704						      h->transid, num_bytes, 1);
   705			h->block_rsv = &fs_info->trans_block_rsv;
   706			h->bytes_reserved = num_bytes;
   707			h->reloc_reserved = reloc_reserved;
   708		}
   709	
   710	got_it:
   711		if (!current->journal_info)
   712			current->journal_info = h;
   713	
   714		/*
   715		 * If the space_info is marked ALLOC_FORCE then we'll get upgraded to
   716		 * ALLOC_FORCE the first run through, and then we won't allocate for
   717		 * anybody else who races in later.  We don't care about the return
   718		 * value here.
   719		 */
   720		if (do_chunk_alloc && num_bytes) {
   721			u64 flags = h->block_rsv->space_info->flags;
   722	
   723			btrfs_chunk_alloc(h, btrfs_get_alloc_profile(fs_info, flags),
   724					  CHUNK_ALLOC_NO_FORCE);
   725		}
   726	
   727		/*
   728		 * btrfs_record_root_in_trans() needs to alloc new extents, and may
   729		 * call btrfs_join_transaction() while we're also starting a
   730		 * transaction.
   731		 *
   732		 * Thus it need to be called after current->journal_info initialized,
   733		 * or we can deadlock.
   734		 */
   735		ret = btrfs_record_root_in_trans(h, root);
   736		if (ret) {
   737			/*
   738			 * The transaction handle is fully initialized and linked with
   739			 * other structures so it needs to be ended in case of errors,
   740			 * not just freed.
   741			 */
   742			btrfs_end_transaction(h);
   743			return ERR_PTR(ret);
   744		}
   745	
   746		return h;
   747	
   748	join_fail:
   749		if (type & __TRANS_FREEZABLE)
   750			sb_end_intwrite(fs_info->sb);
   751		kmem_cache_free(btrfs_trans_handle_cachep, h);
   752	alloc_fail:
   753		if (num_bytes)
   754			btrfs_block_rsv_release(fs_info, &fs_info->trans_block_rsv,
   755						num_bytes, NULL);
   756	reserve_fail:
   757		btrfs_qgroup_free_meta_pertrans(root, qgroup_reserved);
   758		return ERR_PTR(ret);
   759	}
   760	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
