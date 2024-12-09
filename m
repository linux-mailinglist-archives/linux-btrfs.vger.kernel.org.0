Return-Path: <linux-btrfs+bounces-10152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F29E9E8AEF
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 06:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460291883CC6
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 05:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DA57BB1D;
	Mon,  9 Dec 2024 05:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWl17RK1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3D9156872
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 05:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733720988; cv=none; b=iUIaucETvURhekZTzaach9nqaDp0nzirdyT1yzPOTGiKiyTovSOh+bKKSRSV/AA4JjidParimlqNxv0Sbh2NmJIYKoN7DDNqgySDxXmO6nhwbV1tKIc2mjOgeUVK91DzF8uD0dcRj4ql/IF8iNI+pL9/jmPu8U4otIF2HWK4qwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733720988; c=relaxed/simple;
	bh=qarSG/Xlsa2PChZEa3NjRcGB+cNCc51vkdcp8HxhR8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rY9a6feAtHJuLYix4sGZtHy+16lHtpPpsV3hm0W2a3k6WTaYPkCP6ntNiWp56FFA0vK/Wq53/0cTUg2jYiUT7GnMGctGvKtDcnmmh6UbnY1dZ6pbBp1UyX7WyxquKyC00YclB4InIdMbBR9Oew01bAXIDRBMaQJ6YZn6ZMhP8Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWl17RK1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733720986; x=1765256986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qarSG/Xlsa2PChZEa3NjRcGB+cNCc51vkdcp8HxhR8U=;
  b=eWl17RK1d8BuncKrrasL1Cb6DKwjNfUj8QbS7LxJIGwZrMBP5R0XUPWq
   5ejBLgmh8hI+g32MaXGdP51HhuG7nxXAt0hnrT+8ttyFvoyMszSzzSuVA
   mj0H8TxddV6kwkgJemGxYyUkGkQxqdzaZKKoLMsJ0P6vILvy3QMWz9oqY
   ZS6JtBv2OWsSg7IGkJLpJW7a0KF7WslCNEGNyG1IKWOQ4fww0oxthvaoB
   rnYBWNzsIIWN8aeHyKlnQf9nGgAyCkYpzdc7F9A5NdATp2TIvWrabtJ8t
   NHSxOhH0KUhCc32N14c1Ct7PR6g5K5M7dxRiwVoVhminS1Xj8ZOZaLHgV
   Q==;
X-CSE-ConnectionGUID: jDg6V099QKuRMTl1ikybPg==
X-CSE-MsgGUID: MuAfnI3vSiWUCl4KGgOdCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="37683984"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="37683984"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 21:09:46 -0800
X-CSE-ConnectionGUID: CAC8SyyPToKePDqcyIl4Zw==
X-CSE-MsgGUID: qCK9x+ZSRguKvk7mjtsWGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="125806855"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 08 Dec 2024 21:09:45 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKW1e-0003yC-0Z;
	Mon, 09 Dec 2024 05:09:42 +0000
Date: Mon, 9 Dec 2024 13:08:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: Re: [PATCH] btrfs: edits tree_insert() to use rb helpers
Message-ID: <202412091004.4vQ7P5Kl-lkp@intel.com>
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
[also build test ERROR on linus/master v6.13-rc2 next-20241206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roger-L-Beckermeyer-III/btrfs-edits-tree_insert-to-use-rb-helpers/20241209-064230
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/5e023dcf8f086296da987f8ba2b43be0aca15b86.1733695544.git.beckerlee3%40gmail.com
patch subject: [PATCH] btrfs: edits tree_insert() to use rb helpers
config: i386-buildonly-randconfig-003-20241209 (https://download.01.org/0day-ci/archive/20241209/202412091004.4vQ7P5Kl-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241209/202412091004.4vQ7P5Kl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412091004.4vQ7P5Kl-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/btrfs/delayed-ref.c:10:
   In file included from fs/btrfs/ctree.h:10:
   In file included from include/linux/pagemap.h:8:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/btrfs/delayed-ref.c:342:10: error: call to undeclared function 'rb_find_add_cached'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     342 |         exist = rb_find_add_cached(node, root, comp_refs_node);
         |                 ^
>> fs/btrfs/delayed-ref.c:342:8: error: incompatible integer to pointer conversion assigning to 'struct rb_node *' from 'int' [-Wint-conversion]
     342 |         exist = rb_find_add_cached(node, root, comp_refs_node);
         |               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 2 errors generated.


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

