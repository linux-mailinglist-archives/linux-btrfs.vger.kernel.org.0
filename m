Return-Path: <linux-btrfs+bounces-10256-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C01F09ED482
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 19:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1BB188B14F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 18:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6919A1FF1DA;
	Wed, 11 Dec 2024 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jwz/RNcB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8D01DE4C8
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940753; cv=none; b=YgxAdhIVHpf6TJlJTT5Q21ReFJFKjNcFsNjaQTlJOeEbeydHL4P2VDQtYACL+SyH5JbQdifyBrCX7T5DchX1ZIaD0P6Gj3pnMKAJTXByw+GKGvGDKTdQfw7QlYA3VEtTPCQnDrvR5R3ROH1Smb+9j4+AfPnZNCDtk9xOvaIc1K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940753; c=relaxed/simple;
	bh=qCUl+HN2BGab9PpzJyjZVSy4LfxlqjSrrz5EQa95vdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWWr2Sj3SDf4CZhldEDB7bchqLMLtOvoB52CMoT9sIfiRNP+O1rQNWVyB1mJJHHFUBef5QNhnCVvX9EkB4dVkvHJhAWf7TqbyFIQKH4+PeT1y9O4TsvXTJ3t3q/Ej/AjmFwaEN5jl4gggtP/gkZy4ok4Hp17omU6kRfSlg8xW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jwz/RNcB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733940751; x=1765476751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qCUl+HN2BGab9PpzJyjZVSy4LfxlqjSrrz5EQa95vdI=;
  b=Jwz/RNcBhzQTzXFV793kVZZw1svDiJ1hOwrfqJ3m5/Wn+1lBNOg0sCSh
   Fvltw2Le3JvpOP579fBvuRNLUET2a/4kDYseKpRhd1/L+SOpsrkTxx+I5
   NMnap7Ianora62Vy+5iA+XFgqXC7u96/f7IcVw/6rmldMBj4uc1hXxnRv
   AEBL9aqWUNv36SNm5sdLtasSGdI9T/IrwsyMWtd5HoW5nrg/+XGLX2Fm8
   G65GYUa1DNseLVi2VOHgoRnTREeyd3o93K2iy6ie3XBDVS9DL1v0G7usl
   VNWBzr69Cn5KhO4/IGVATXWhh0ms1C/px/4xxLi8kpvnR3WYLr8ME9cpk
   w==;
X-CSE-ConnectionGUID: ot+8NZlrSJa7qMS0aS5X5Q==
X-CSE-MsgGUID: r6JZKwjmQfWVLoWS7vaxyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="51748720"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="51748720"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 10:12:30 -0800
X-CSE-ConnectionGUID: a8Bhw/BFS+es0Fzp2JQyZw==
X-CSE-MsgGUID: 53b4D2CfQTy4M4qpL1LlTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100849347"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 11 Dec 2024 10:12:28 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLRCD-0006yD-2o;
	Wed, 11 Dec 2024 18:12:25 +0000
Date: Thu, 12 Dec 2024 02:11:55 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] btrfs: enhance ordered extent double freeing detection
Message-ID: <202412120136.6OwbbtZf-lkp@intel.com>
References: <53b793f2e7a7788f89cda97de565cfc1577cbf75.1733890357.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53b793f2e7a7788f89cda97de565cfc1577cbf75.1733890357.git.wqu@suse.com>

Hi Qu,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.13-rc2 next-20241211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-enhance-ordered-extent-double-freeing-detection/20241211-121647
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/53b793f2e7a7788f89cda97de565cfc1577cbf75.1733890357.git.wqu%40suse.com
patch subject: [PATCH] btrfs: enhance ordered extent double freeing detection
config: i386-buildonly-randconfig-003-20241211 (https://download.01.org/0day-ci/archive/20241212/202412120136.6OwbbtZf-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412120136.6OwbbtZf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412120136.6OwbbtZf-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/btrfs/ordered-data.c:7:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/btrfs/ordered-data.c:200:10: error: no member named 'finished_bitmap' in 'struct btrfs_ordered_extent'
     200 |                 entry->finished_bitmap = bitmap_zalloc(
         |                 ~~~~~  ^
   fs/btrfs/ordered-data.c:202:15: error: no member named 'finished_bitmap' in 'struct btrfs_ordered_extent'
     202 |                 if (!entry->finished_bitmap) {
         |                      ~~~~~  ^
   fs/btrfs/ordered-data.c:380:38: error: no member named 'finished_bitmap' in 'struct btrfs_ordered_extent'
     380 |                 nr_set = bitmap_count_set(ordered->finished_bitmap, start_bit, nbits);
         |                                           ~~~~~~~  ^
   fs/btrfs/ordered-data.c:388:17: error: no member named 'finished_bitmap' in 'struct btrfs_ordered_extent'
     388 |                                    ordered->finished_bitmap);
         |                                    ~~~~~~~  ^
   fs/btrfs/messages.h:44:41: note: expanded from macro 'btrfs_crit'
      44 |         btrfs_printk(fs_info, KERN_CRIT fmt, ##args)
         |                                                ^~~~
   fs/btrfs/messages.h:27:32: note: expanded from macro 'btrfs_printk'
      27 |         _btrfs_printk(fs_info, fmt, ##args)
         |                                       ^~~~
   fs/btrfs/ordered-data.c:390:23: error: no member named 'finished_bitmap' in 'struct btrfs_ordered_extent'
     390 |                 bitmap_set(ordered->finished_bitmap, start_bit, nbits);
         |                            ~~~~~~~  ^
   fs/btrfs/ordered-data.c:418:37: error: no member named 'finished_bitmap' in 'struct btrfs_ordered_extent'
     418 |                 if (WARN_ON(!bitmap_full(ordered->finished_bitmap,
         |                                          ~~~~~~~  ^
   include/asm-generic/bug.h:123:25: note: expanded from macro 'WARN_ON'
     123 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   fs/btrfs/ordered-data.c:426:14: error: no member named 'finished_bitmap' in 'struct btrfs_ordered_extent'
     426 |                                 ordered->finished_bitmap);
         |                                 ~~~~~~~  ^
   fs/btrfs/messages.h:44:41: note: expanded from macro 'btrfs_crit'
      44 |         btrfs_printk(fs_info, KERN_CRIT fmt, ##args)
         |                                                ^~~~
   fs/btrfs/messages.h:27:32: note: expanded from macro 'btrfs_printk'
      27 |         _btrfs_printk(fs_info, fmt, ##args)
         |                                       ^~~~
   fs/btrfs/ordered-data.c:675:23: error: no member named 'finished_bitmap' in 'struct btrfs_ordered_extent'
     675 |                         bitmap_free(entry->finished_bitmap);
         |                                     ~~~~~  ^
   1 warning and 8 errors generated.


vim +200 fs/btrfs/ordered-data.c

   147	
   148	static struct btrfs_ordered_extent *alloc_ordered_extent(
   149				struct btrfs_inode *inode, u64 file_offset, u64 num_bytes,
   150				u64 ram_bytes, u64 disk_bytenr, u64 disk_num_bytes,
   151				u64 offset, unsigned long flags, int compress_type)
   152	{
   153		struct btrfs_ordered_extent *entry;
   154		int ret;
   155		u64 qgroup_rsv = 0;
   156	
   157		if (flags &
   158		    ((1 << BTRFS_ORDERED_NOCOW) | (1 << BTRFS_ORDERED_PREALLOC))) {
   159			/* For nocow write, we can release the qgroup rsv right now */
   160			ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &qgroup_rsv);
   161			if (ret < 0)
   162				return ERR_PTR(ret);
   163		} else {
   164			/*
   165			 * The ordered extent has reserved qgroup space, release now
   166			 * and pass the reserved number for qgroup_record to free.
   167			 */
   168			ret = btrfs_qgroup_release_data(inode, file_offset, num_bytes, &qgroup_rsv);
   169			if (ret < 0)
   170				return ERR_PTR(ret);
   171		}
   172		entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
   173		if (!entry)
   174			return ERR_PTR(-ENOMEM);
   175	
   176		entry->file_offset = file_offset;
   177		entry->num_bytes = num_bytes;
   178		entry->ram_bytes = ram_bytes;
   179		entry->disk_bytenr = disk_bytenr;
   180		entry->disk_num_bytes = disk_num_bytes;
   181		entry->offset = offset;
   182		entry->bytes_left = num_bytes;
   183		entry->inode = BTRFS_I(igrab(&inode->vfs_inode));
   184		entry->compress_type = compress_type;
   185		entry->truncated_len = (u64)-1;
   186		entry->qgroup_rsv = qgroup_rsv;
   187		entry->flags = flags;
   188		refcount_set(&entry->refs, 1);
   189		init_waitqueue_head(&entry->wait);
   190		INIT_LIST_HEAD(&entry->list);
   191		INIT_LIST_HEAD(&entry->log_list);
   192		INIT_LIST_HEAD(&entry->root_extent_list);
   193		INIT_LIST_HEAD(&entry->work_list);
   194		INIT_LIST_HEAD(&entry->bioc_list);
   195		init_completion(&entry->completion);
   196	
   197		if (IS_ENABLED(CONFIG_BTRFS_DEBUG)) {
   198			struct btrfs_fs_info *fs_info = inode->root->fs_info;
   199	
 > 200			entry->finished_bitmap = bitmap_zalloc(
   201				num_bytes >> fs_info->sectorsize_bits, GFP_NOFS);
   202			if (!entry->finished_bitmap) {
   203				kmem_cache_free(btrfs_ordered_extent_cache, entry);
   204				return ERR_PTR(-ENOMEM);
   205			}
   206		}
   207		/*
   208		 * We don't need the count_max_extents here, we can assume that all of
   209		 * that work has been done at higher layers, so this is truly the
   210		 * smallest the extent is going to get.
   211		 */
   212		spin_lock(&inode->lock);
   213		btrfs_mod_outstanding_extents(inode, 1);
   214		spin_unlock(&inode->lock);
   215	
   216		return entry;
   217	}
   218	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

