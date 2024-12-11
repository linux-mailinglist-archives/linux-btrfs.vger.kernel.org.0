Return-Path: <linux-btrfs+bounces-10257-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 241219ED483
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 19:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021EB282DAB
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 18:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4323B201258;
	Wed, 11 Dec 2024 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQ3it6UN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D12246356
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940758; cv=none; b=YvBev/05I+SIlfAWkPI2rKU33R9uzv9TseYtJK2YPwkL2zyMPoLkNDPKtq8f8nyMUc8Tx7WAOuUnVAsP9OIp7J5qHUXOBRcQyPf9xlqnO9+M46BUuANcDN7Ym/RzikW0haUUrx6KM/uI8cRl+CLD3Lzksu7eIgrdFFVQSzbnxMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940758; c=relaxed/simple;
	bh=XD+BA6M0sURn4DZ5siN73KCcaHXGq/t4AEVTAe03Dtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8buAmzlzeXcoJ89tByW8XWqiBD5US3Lv+ILdkuM2n5yzpZNrafAG7Sou2JWjrLIs1nmJufLst/LWnRTdNswNXDQTq1T1P+pG5puif4Bp3wQsGK/sWnAkV9qVDZ4FDByps9nwCKWqqSbjMibMlkf8Kusc2eWQFgMyViXZjFQETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQ3it6UN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733940757; x=1765476757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XD+BA6M0sURn4DZ5siN73KCcaHXGq/t4AEVTAe03Dtw=;
  b=DQ3it6UN0GGR+7bpfJloUpDG9YesPaVloHedmOpcpoGcGJ85YTgovDSt
   0kMRjH7548vljim/rAAryUqUETkAMED7Pg9hKuMYxmVEKvYQVITocBjln
   YbUXDDp3VHzI3pwOWGN7U/UVWghVuZxVN0i6ccXTxs2p9RCQGwYOYwixG
   gHVY2zREu1v89uV3gNkR45lJ95UPyJ1uKgBkdekwvBSbePy0PbxEaDJ5H
   Ff3vfScJacXrt0txldeswycxyfi2bBgST6LfwPp1tJQpcR8fV3B7gj12o
   03qYk0a7TGRG7kvZzowt6lSEgBNO6gG9W/qs6MyV+3gqBi9Utptt+BHLi
   A==;
X-CSE-ConnectionGUID: qrdqDI7JSLygb8AIXjIgKw==
X-CSE-MsgGUID: aeOY7wUoTiSXEpGEwuUH2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45717084"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45717084"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 10:12:30 -0800
X-CSE-ConnectionGUID: 25BFb73hT1u3UocqRVJCTQ==
X-CSE-MsgGUID: nOrnXZFDSMG6x9yyW2wcsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="126726753"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Dec 2024 10:12:29 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLRCD-0006yF-2s;
	Wed, 11 Dec 2024 18:12:25 +0000
Date: Thu, 12 Dec 2024 02:12:24 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] btrfs: enhance ordered extent double freeing detection
Message-ID: <202412120129.tEVBFsR6-lkp@intel.com>
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
config: i386-buildonly-randconfig-005-20241211 (https://download.01.org/0day-ci/archive/20241212/202412120129.tEVBFsR6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412120129.tEVBFsR6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412120129.tEVBFsR6-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/btrfs/ordered-data.c: In function 'alloc_ordered_extent':
>> fs/btrfs/ordered-data.c:200:22: error: 'struct btrfs_ordered_extent' has no member named 'finished_bitmap'
     200 |                 entry->finished_bitmap = bitmap_zalloc(
         |                      ^~
   fs/btrfs/ordered-data.c:202:27: error: 'struct btrfs_ordered_extent' has no member named 'finished_bitmap'
     202 |                 if (!entry->finished_bitmap) {
         |                           ^~
   fs/btrfs/ordered-data.c: In function 'can_finish_ordered_extent':
   fs/btrfs/ordered-data.c:380:50: error: 'struct btrfs_ordered_extent' has no member named 'finished_bitmap'
     380 |                 nr_set = bitmap_count_set(ordered->finished_bitmap, start_bit, nbits);
         |                                                  ^~
   In file included from fs/btrfs/ordered-data.c:10:
   fs/btrfs/ordered-data.c:388:43: error: 'struct btrfs_ordered_extent' has no member named 'finished_bitmap'
     388 |                                    ordered->finished_bitmap);
         |                                           ^~
   fs/btrfs/messages.h:36:41: note: in definition of macro 'btrfs_printk'
      36 |         btrfs_no_printk(fs_info, fmt, ##args)
         |                                         ^~~~
   fs/btrfs/ordered-data.c:382:25: note: in expansion of macro 'btrfs_crit'
     382 |                         btrfs_crit(fs_info,
         |                         ^~~~~~~~~~
   fs/btrfs/ordered-data.c:390:35: error: 'struct btrfs_ordered_extent' has no member named 'finished_bitmap'
     390 |                 bitmap_set(ordered->finished_bitmap, start_bit, nbits);
         |                                   ^~
   In file included from arch/x86/include/asm/bug.h:99,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/linux/spinlock.h:60,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from fs/btrfs/ordered-data.c:6:
   fs/btrfs/ordered-data.c:418:49: error: 'struct btrfs_ordered_extent' has no member named 'finished_bitmap'
     418 |                 if (WARN_ON(!bitmap_full(ordered->finished_bitmap,
         |                                                 ^~
   include/asm-generic/bug.h:171:32: note: in definition of macro 'WARN_ON'
     171 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   fs/btrfs/ordered-data.c:426:40: error: 'struct btrfs_ordered_extent' has no member named 'finished_bitmap'
     426 |                                 ordered->finished_bitmap);
         |                                        ^~
   fs/btrfs/messages.h:36:41: note: in definition of macro 'btrfs_printk'
      36 |         btrfs_no_printk(fs_info, fmt, ##args)
         |                                         ^~~~
   fs/btrfs/ordered-data.c:420:25: note: in expansion of macro 'btrfs_crit'
     420 |                         btrfs_crit(fs_info,
         |                         ^~~~~~~~~~
   fs/btrfs/ordered-data.c: In function 'btrfs_put_ordered_extent':
   fs/btrfs/ordered-data.c:675:42: error: 'struct btrfs_ordered_extent' has no member named 'finished_bitmap'
     675 |                         bitmap_free(entry->finished_bitmap);
         |                                          ^~


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

