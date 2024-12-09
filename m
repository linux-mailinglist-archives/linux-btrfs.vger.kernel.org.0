Return-Path: <linux-btrfs+bounces-10146-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 589839E8AE6
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 06:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1BC164524
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 05:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDD4158D8B;
	Mon,  9 Dec 2024 05:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXw2epz6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5934C91
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 05:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733720684; cv=none; b=bI22+fS1DTYVsCREMyFDcKsXaIQbH+ayAO/IHsNyTrHUFG4GcAzO1eFepmpS2zPYwGI6GuYv1srI5gs4gvZBNlCH4QUhqGW88Y5WzIN6ut3Lc0IDdUMhxSkYUfpZdOr/3CYwd4n60uFdWTnMkr+bFzaB57V5vEFabpB+kMrWYuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733720684; c=relaxed/simple;
	bh=+uszGQygTgEhZQEKq/ELrxbs7+rjhtj0vaIUT19kvSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldcFSi3UO3DXx2GyxV07qithrPjXA3d86xCcawSrBjqkscGybmyw2QloewOMod4+LfnJl/J7g4zaunbPpgpDXpQaOV2MDLD1tfohdnarKv9m9wxLwU7f5djg5Q0MT0kXXRFr3/weqhzz3OyiCeOmGeslJcqNjDZAjB3ZhiVTapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXw2epz6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733720683; x=1765256683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+uszGQygTgEhZQEKq/ELrxbs7+rjhtj0vaIUT19kvSA=;
  b=MXw2epz60NZ40FZzwiYB7t/ZcHtTzFlbTHTTeJb51fCztnis9qHZ/QwZ
   ThkAkV603id3k9fVHWDOSy34mBQQLeIiKHvMJu0+70zrG4YF9WdvkFond
   /pgMesPp+urjxYgNdBPhs7Oa9I30Ay+wwyhTdnDe9cLQu9l8PZTQRTJ4h
   FRpH9HRJdux8WVi6ityOf+mBx6oO1HOU+eUEPte5nUpeiROSWzhWXgrBZ
   XhPPzkrNgC6HQgi7gHcmYs44sybuYWbz1Bhx2aESEh4dzeZNp3tWYNIt5
   jsGNWEVjIRXiZLIA/RCygP+pbug3NHVtthB/1O//UoM5t/Q1Oi4G+5OcT
   A==;
X-CSE-ConnectionGUID: iJ7W/fdqQPecTXx2ZRMTDQ==
X-CSE-MsgGUID: C+nGzzNaQsa78tQ5IOGMXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34148494"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="34148494"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 21:04:43 -0800
X-CSE-ConnectionGUID: 7qd/1W/ZSOemWTHmxvikQA==
X-CSE-MsgGUID: k6QSZCUNRVexY42faNl/Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="94766311"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 08 Dec 2024 21:04:41 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVwl-0003xN-0Q;
	Mon, 09 Dec 2024 05:04:39 +0000
Date: Mon, 9 Dec 2024 13:04:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	"Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: Re: [PATCH] btrfs: edits tree_insert() to use rb helpers
Message-ID: <202412090944.g3jpT1Cz-lkp@intel.com>
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
config: arc-randconfig-002-20241209 (https://download.01.org/0day-ci/archive/20241209/202412090944.g3jpT1Cz-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241209/202412090944.g3jpT1Cz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412090944.g3jpT1Cz-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/btrfs/delayed-ref.c: In function 'tree_insert':
>> fs/btrfs/delayed-ref.c:342:17: error: implicit declaration of function 'rb_find_add_cached'; did you mean 'rb_find_add_rcu'? [-Werror=implicit-function-declaration]
     342 |         exist = rb_find_add_cached(node, root, comp_refs_node);
         |                 ^~~~~~~~~~~~~~~~~~
         |                 rb_find_add_rcu
>> fs/btrfs/delayed-ref.c:342:15: warning: assignment to 'struct rb_node *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     342 |         exist = rb_find_add_cached(node, root, comp_refs_node);
         |               ^
   cc1: some warnings being treated as errors


vim +342 fs/btrfs/delayed-ref.c

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

