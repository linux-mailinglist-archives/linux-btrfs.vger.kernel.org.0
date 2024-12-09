Return-Path: <linux-btrfs+bounces-10149-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D099E8AEA
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 06:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85842164455
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 05:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2093165F1F;
	Mon,  9 Dec 2024 05:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXlSR5m0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CB27BB1D
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 05:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733720865; cv=none; b=W5Sxk6t4jx/lklFk6WgNsy9k5evt6bDQd+xmH9zDnZdaQEur1WQYBpbUwy9zSTvFcNHSv7hhtsapdoYatikdHx9bFccGkH68DGr1mau4NRZ7KSVZ6lgZvBoql0lPFRep1M2nDgtfd8vGULX7ldBGGDvnauiCwQxSEQrKnLv8Kyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733720865; c=relaxed/simple;
	bh=v3HN4qqQI50dFLz716eyFD44vj5iRz15aeCSa1nCqdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umhG5Iv+j5sFqtfYXEXUWsxHJK2STMxk06dt8mnHz2hTbT+Cp18GDDV4/QnBxxZ7tVshT65Q74DVzah+6PS+1MT4kNNBmhV41xd5s1Lra4V/Iv/R+jicYvedOoACxdYDG76dsSA+Psl1d1AjWFRWqx+o6lssuRz45NZnfdK1ciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXlSR5m0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733720863; x=1765256863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v3HN4qqQI50dFLz716eyFD44vj5iRz15aeCSa1nCqdk=;
  b=QXlSR5m05073B3oEIiW6/6E60ufNdx1rmrg3jrmh+TgIViLNRcdGxZmp
   V0GD2JbvdzJtdvUpOr29FyiFzWjS2cFIdCUvQvCVB4CW1uA83gHVdZbex
   KIfihF92LDLAEfmrk6t/YFKjG4y+g+acwo5oaEo/UlUQO3l0FVKMg8uKU
   xELE/znONjccxVtH7T2Dju+Cpr8wTdPpDjGZK7JOgoHKayhmGMGcFUFuC
   7K4cbO5FNptJUdT4WLIIBZLwvxHYmUBdDhHiSHCZEPJOI1vdR7iPeU4kJ
   yTM0ffHI2uXQYKLivyfNwKyw8f8no6wrCzB0CKqZD8xwqZexO9Kpe5I+i
   w==;
X-CSE-ConnectionGUID: VNEWsgxjSeSjp8aDkmO2aQ==
X-CSE-MsgGUID: v1tWJYW8TDWZKzWpY3LQBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45383398"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45383398"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 21:07:43 -0800
X-CSE-ConnectionGUID: RFCBbniIR9mQRFtIPHZ9Kw==
X-CSE-MsgGUID: moDFsaVCT5Gwk4Pav9zpgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95053461"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 08 Dec 2024 21:07:42 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVzf-0003xl-1a;
	Mon, 09 Dec 2024 05:07:39 +0000
Date: Mon, 9 Dec 2024 13:06:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: Re: [PATCH] btrfs: edit prelim_ref_insert() to use rb helpers
Message-ID: <202412090958.CtUdYRwP-lkp@intel.com>
References: <8201f6ae724c5dbc7c82f2ed294d457db208b2fa.1733695544.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8201f6ae724c5dbc7c82f2ed294d457db208b2fa.1733695544.git.beckerlee3@gmail.com>

Hi Roger,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.13-rc2 next-20241206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roger-L-Beckermeyer-III/btrfs-edit-prelim_ref_insert-to-use-rb-helpers/20241209-064043
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/8201f6ae724c5dbc7c82f2ed294d457db208b2fa.1733695544.git.beckerlee3%40gmail.com
patch subject: [PATCH] btrfs: edit prelim_ref_insert() to use rb helpers
config: arm-randconfig-001-20241209 (https://download.01.org/0day-ci/archive/20241209/202412090958.CtUdYRwP-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241209/202412090958.CtUdYRwP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412090958.CtUdYRwP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/btrfs/backref.c:6:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/btrfs/backref.c:302:10: error: call to undeclared function 'rb_find_add_cached'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     302 |         exist = rb_find_add_cached(&newref->rbnode, root, prelim_ref_cmp);
         |                 ^
>> fs/btrfs/backref.c:302:8: error: incompatible integer to pointer conversion assigning to 'struct rb_node *' from 'int' [-Wint-conversion]
     302 |         exist = rb_find_add_cached(&newref->rbnode, root, prelim_ref_cmp);
         |               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 2 errors generated.


vim +/rb_find_add_cached +302 fs/btrfs/backref.c

   280	
   281	/*
   282	 * Add @newref to the @root rbtree, merging identical refs.
   283	 *
   284	 * Callers should assume that newref has been freed after calling.
   285	 */
   286	static void prelim_ref_insert(const struct btrfs_fs_info *fs_info,
   287				      struct preftree *preftree,
   288				      struct prelim_ref *newref,
   289				      struct share_check *sc)
   290	{
   291		struct rb_root_cached *root;
   292		struct rb_node **p;
   293		struct rb_node *parent = NULL;
   294		struct prelim_ref *ref;
   295		struct rb_node *exist;
   296	
   297		root = &preftree->root;
   298		p = &root->rb_root.rb_node;
   299		parent = *p;
   300		ref = rb_entry(parent, struct prelim_ref, rbnode);
   301	
 > 302		exist = rb_find_add_cached(&newref->rbnode, root, prelim_ref_cmp);
   303		if (exist != NULL) {
   304			/* Identical refs, merge them and free @newref */
   305			struct extent_inode_elem *eie = ref->inode_list;
   306	
   307			while (eie && eie->next)
   308				eie = eie->next;
   309	
   310			if (!eie)
   311				ref->inode_list = newref->inode_list;
   312			else
   313				eie->next = newref->inode_list;
   314			trace_btrfs_prelim_ref_merge(fs_info, ref, newref,
   315								preftree->count);
   316			/*
   317			 * A delayed ref can have newref->count < 0.
   318			 * The ref->count is updated to follow any
   319			 * BTRFS_[ADD|DROP]_DELAYED_REF actions.
   320			 */
   321			update_share_count(sc, ref->count,
   322						ref->count + newref->count, newref);
   323			ref->count += newref->count;
   324			free_pref(newref);
   325			return;
   326		}
   327	
   328		update_share_count(sc, 0, newref->count, newref);
   329		preftree->count++;
   330		trace_btrfs_prelim_ref_insert(fs_info, newref, NULL, preftree->count);
   331	}
   332	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

