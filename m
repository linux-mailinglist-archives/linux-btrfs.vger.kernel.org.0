Return-Path: <linux-btrfs+bounces-2550-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3998085B026
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 01:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13041F21D34
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 00:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15149FBF3;
	Tue, 20 Feb 2024 00:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3JMQvI0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC653FBF4
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 00:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708390369; cv=none; b=Bfwbx38yGVrQDxvvEcOg6Di41aZb2hZimjAj16mvTMnMjcgSzpprUS5KhdwZ2PUZEP7ze9xzVjC5YnIsVAp98nkttgh0I0ZXJg6amzK81RQFm0WZi8CQuOPOWWvsTY+WLbO7pPPpk+44B1Gvv8nFyxwqi+WFL1Qb+7KVpzJ3x2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708390369; c=relaxed/simple;
	bh=LXLXmwSIwBH/np5crFKz+sYIekHscOgBVPVkPotEFoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDs83KwkEKkuz5W6XAjh/Qt74bblKhgdqF4i8BzCed7U4o2sMXiBR3pOTN9NVvFVUja9CjXF42DEqnEqMjn0JGa6Hmg0E5WWJHN+h3Ey+gisUheyZ1LmFWAWuQNfBXtqPsu52TX7y3cg91ooKpEwSs+8QZW8j+g2kEfOVA767h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3JMQvI0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708390367; x=1739926367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LXLXmwSIwBH/np5crFKz+sYIekHscOgBVPVkPotEFoo=;
  b=N3JMQvI0kbfoK/LLEPj/Q1v9aPbVELYxmUxXumba7zVQuPtcL5L0WqQS
   YN9HHQOQCoHLqQfSucEuhjdzirUESDdeZcRKZEfpLAnDEFmQETyJqB1zM
   0yxOfNO7p2/p2fi7ugFDpOGeeMK0BK5Gz8L3iuL3yPyYIYKqCz2/VyB54
   8dAptnh2cgnP3onxeHxw/hYPOopUKjqBcLL7rvfvtJzG+xapgn4fyU+UY
   Y4zD6HoU4MyrpMX0okVr1QQrHO0lkbcFTMaVI9GeISZjJoHt0nd1PpEhp
   oOskqq7CPts6MxLv3QOMf5fF9tcc3qOqp0DcnIAwcfH+/Jk5ck2exSa/9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="6301435"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="6301435"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 16:52:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="9275323"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 19 Feb 2024 16:52:46 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcENG-0004A0-21;
	Tue, 20 Feb 2024 00:52:42 +0000
Date: Tue, 20 Feb 2024 08:52:33 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/4] btrfs: subpage: introduce helpers to handle subpage
 delalloc locking
Message-ID: <202402200823.Su3xBnia-lkp@intel.com>
References: <02f5ad17b6415670bea37433c8ca332a06253315.1708322044.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02f5ad17b6415670bea37433c8ca332a06253315.1708322044.git.wqu@suse.com>

Hi Qu,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.8-rc5 next-20240219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-make-__extent_writepage_io-to-write-specified-range-only/20240219-141053
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/02f5ad17b6415670bea37433c8ca332a06253315.1708322044.git.wqu%40suse.com
patch subject: [PATCH 3/4] btrfs: subpage: introduce helpers to handle subpage delalloc locking
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240220/202402200823.Su3xBnia-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240220/202402200823.Su3xBnia-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402200823.Su3xBnia-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/btrfs/subpage.c: In function 'btrfs_folio_set_writer_lock':
>> fs/btrfs/subpage.c:758:60: error: 'struct btrfs_subpage_info' has no member named 'locked_offset'; did you mean 'checked_offset'?
     758 |         start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
         |                                                            ^~~~~~
   fs/btrfs/subpage.c:374:45: note: in definition of macro 'subpage_calc_start_bit'
     374 |         start_bit += fs_info->subpage_info->name##_offset;              \
         |                                             ^~~~
   fs/btrfs/subpage.c: In function 'btrfs_subpage_find_writer_locked':
   fs/btrfs/subpage.c:785:70: error: 'struct btrfs_subpage_info' has no member named 'locked_offset'; did you mean 'checked_offset'?
     785 |         const int start_bit = subpage_calc_start_bit(fs_info, folio, locked,
         |                                                                      ^~~~~~
   fs/btrfs/subpage.c:374:45: note: in definition of macro 'subpage_calc_start_bit'
     374 |         start_bit += fs_info->subpage_info->name##_offset;              \
         |                                             ^~~~
   fs/btrfs/subpage.c:787:55: error: 'struct btrfs_subpage_info' has no member named 'locked_offset'; did you mean 'checked_offset'?
     787 |         const int locked_bitmap_start = subpage_info->locked_offset;
         |                                                       ^~~~~~~~~~~~~
         |                                                       checked_offset


vim +758 fs/btrfs/subpage.c

   736	
   737	/*
   738	 * This is for folio already locked by plain lock_page()/folio_lock(), which
   739	 * doesn't have any subpage awareness.
   740	 *
   741	 * This would populate the involved subpage ranges so that subpage helpers can
   742	 * properly unlock them.
   743	 */
   744	void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
   745					 struct folio *folio, u64 start, u32 len)
   746	{
   747		struct btrfs_subpage *subpage;
   748		unsigned long flags;
   749		int start_bit;
   750		int nbits;
   751		int ret;
   752	
   753		ASSERT(folio_test_locked(folio));
   754		if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping))
   755			return;
   756	
   757		subpage = folio_get_private(folio);
 > 758		start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
   759		nbits = len >> fs_info->sectorsize_bits;
   760		spin_lock_irqsave(&subpage->lock, flags);
   761		/* Target range should not yet be locked. */
   762		ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
   763		bitmap_set(subpage->bitmaps, start_bit, nbits);
   764		ret = atomic_add_return(nbits, &subpage->writers);
   765		ASSERT(ret <= fs_info->subpage_info->bitmap_nr_bits);
   766		spin_unlock_irqrestore(&subpage->lock, flags);
   767	}
   768	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

