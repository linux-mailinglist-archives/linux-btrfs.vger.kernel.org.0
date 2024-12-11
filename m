Return-Path: <linux-btrfs+bounces-10271-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DEE9ED96E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 23:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587A318878C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 22:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB951EC4D6;
	Wed, 11 Dec 2024 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwsfuX0Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A171A0726
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955442; cv=none; b=CfhbYESaN4WPhrz3nmEKHXFhZnrnBUYS4akkbzgNiTanELBvfo1SyU3tcnl6ZBgEJ4I7+SrdPibYnSu6Tr/H36907ch77UQ2sy6iKx0OMhbj6yNKWvNHBKnYVYFfSk86yP1QoWZ57Ljw0yPy1XITuiOP1l6F5AOHRlZnbg9VYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955442; c=relaxed/simple;
	bh=E5xbxd34Ap4a+5uIuZu8Xvnmg/2vPzv6AOe5ovtfTok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXeT2YsYhD73CSPic8oka0s4dt/LNKLVQoX3z4727YXBmpWfn0Fv+fLOoWBuB6HVCioe1AMn4MPOZIKyZkqKBqJ8ZAN9kxPafQBQ9Bc8+JfqGqtz/SKfFhz64tT57U/MQ4fek9tdIFs32cZU42gibZ5t5XVN9VRTvKzkP8dFccE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwsfuX0Z; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733955440; x=1765491440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E5xbxd34Ap4a+5uIuZu8Xvnmg/2vPzv6AOe5ovtfTok=;
  b=ZwsfuX0Zx1x/sMerkCWj2fz75n5Jcvx3Yg6EDDyUeA7seqCnPz1BiS8e
   GaEJRot7ZM3ZjWtK7cW9wde5tIHDep1l13IlkXp+UwXyAMRFF+WSM6Ng/
   fHOMn2zKQmIMRXS3tyfd6mmUxuBhL1xu0D+XdyiZ7JAjzaVnW0O/U/w4G
   XtD7X1tVZz52pZmPfD/AMgXhm/hHr53GP1h5gWwO1eXSSEefVWEy3rdEk
   /F52A3+IeTQncNp6qhwHBo+6VLUyhfSluY9HUsvnop4OQRjQVAxqF9JvJ
   QnkXSoA9sb8wmvoHUaPJ0R2RKVtWMGIVYoUU3GwBMIF6C3I1Fj8SnZKNV
   Q==;
X-CSE-ConnectionGUID: FOQCQ2RSRwOODJsvujrvvQ==
X-CSE-MsgGUID: NXpR2MqFTNK3wDk0hT+GzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="38140540"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="38140540"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 14:17:19 -0800
X-CSE-ConnectionGUID: AT3Hk9oUSrusHkEf1nvC6Q==
X-CSE-MsgGUID: cUCNiLnYTqSryOfw+1Kqww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="95731762"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Dec 2024 14:17:16 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLV18-00079F-1F;
	Wed, 11 Dec 2024 22:17:14 +0000
Date: Thu, 12 Dec 2024 06:17:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: Re: [PATCH] btrfs: edits tree_insert() to use rb helpers
Message-ID: <202412120640.485KsaTz-lkp@intel.com>
References: <5e023dcf8f086296da987f8ba2b43be0aca15b86.1733695544.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e023dcf8f086296da987f8ba2b43be0aca15b86.1733695544.git.beckerlee3@gmail.com>

Hi Roger,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.13-rc2 next-20241211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roger-L-Beckermeyer-III/btrfs-edits-tree_insert-to-use-rb-helpers/20241209-104108
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/5e023dcf8f086296da987f8ba2b43be0aca15b86.1733695544.git.beckerlee3%40gmail.com
patch subject: [PATCH] btrfs: edits tree_insert() to use rb helpers
config: s390-defconfig (https://download.01.org/0day-ci/archive/20241212/202412120640.485KsaTz-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412120640.485KsaTz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412120640.485KsaTz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/btrfs/delayed-ref.c:342:10: error: call to undeclared function 'rb_find_add_cached'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           exist = rb_find_add_cached(node, root, comp_refs_node);
                   ^
   fs/btrfs/delayed-ref.c:342:8: error: incompatible integer to pointer conversion assigning to 'struct rb_node *' from 'int' [-Wint-conversion]
           exist = rb_find_add_cached(node, root, comp_refs_node);
                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/rb_find_add_cached +342 fs/btrfs/delayed-ref.c

   334	
   335	static struct btrfs_delayed_ref_node* tree_insert(struct rb_root_cached *root,
   336			struct btrfs_delayed_ref_node *ins)
   337	{
   338		struct rb_node *node = &ins->ref_node;
   339		struct rb_node *exist;
   340		struct btrfs_delayed_ref_node *entry;
   341	
 > 342		exist = rb_find_add_cached(node, root, comp_refs_node);
   343		if (exist != NULL) {
   344			entry = rb_entry(exist, struct btrfs_delayed_ref_node, ref_node);
   345			return entry;
   346		}
   347		return NULL;
   348	}
   349	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

