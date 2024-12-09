Return-Path: <linux-btrfs+bounces-10145-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E777D9E8AE5
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 06:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87DF280C7B
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 05:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B564158527;
	Mon,  9 Dec 2024 05:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgGcfRZl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95984C91
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 05:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733720624; cv=none; b=lEPggZPe4yjOLxqt3n6jsIrykY3a9ulXTeVMYE5rkux2d7Jg31pIsHUc0DWCqVOXvmAiDDclQgB3y072I1qdERtaFW90QrNE3yfU0D2fVMNxnZo8W7gIpjttwRSd8YwUOw7x7kj28BWWfMyPzQsDlouq81ETrZQjSujhcDQCFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733720624; c=relaxed/simple;
	bh=WQwI2sEpoiXOAE7+ovXCT15KklW1L3Im1ZB7rHTnJYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECUb5at/0G06StZkxK4Crd2XX68u8drATNjlzKoiD+Q0SZ0G0Kn0yJ76fu+0nXWYwgozdTAhJmZhz6ac1sdv+nI7ErS4lsARqDV3TfTbTgiqd1JiIyGJzxyoJGfe9qdw9anXQ5FRg8HKfdeyU0+WUUy2vXHylUCGkJijrzTIges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgGcfRZl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733720622; x=1765256622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WQwI2sEpoiXOAE7+ovXCT15KklW1L3Im1ZB7rHTnJYE=;
  b=IgGcfRZlqe5fmzQanHYSwPfhEZbnVPsrThDWafLxJ9r04GgKS4Lz5nGM
   O/eJLHSvTtF7y3JRnKPYNsBzjbgLQAORSNmMdwjePT3ewoLfYPsdDBfxf
   hd26cPV+vJF/sDEeUExDoLs/C6KdoUNmT7aFc/illb/8rnwfReop4Ky4I
   ZgbXFONAITF8zoDijcDaA8L+HKsANOuj9TRuIrslOTfyUv4qH4nwT3+g0
   3aAUwKCQ3DrPf5TFiRhbwQkEkcQfYC58MZDyCaxhzwDb9+qNs/+8Rr4er
   A59IZHgD8ZkjIlnF2fkYBqOxgzJ2iDlG5qFV3nDqUsAeApPe58yybj2Nj
   g==;
X-CSE-ConnectionGUID: /KqOv6WKSJ+0j0gyhrVzEw==
X-CSE-MsgGUID: Jiu/7uPTQEWF5l0bhBvKYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="37683120"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="37683120"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 21:03:42 -0800
X-CSE-ConnectionGUID: NlSklj1+SXKvFmJqjHMsmQ==
X-CSE-MsgGUID: QNstRwoeTlaaFz+6dLizKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95163783"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Dec 2024 21:03:41 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVvn-0003xF-03;
	Mon, 09 Dec 2024 05:03:39 +0000
Date: Mon, 9 Dec 2024 13:02:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	"Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: Re: [PATCH] btrfs: edit prelim_ref_insert() to use rb helpers
Message-ID: <202412090922.Cg7LuOhS-lkp@intel.com>
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
config: arc-randconfig-002-20241209 (https://download.01.org/0day-ci/archive/20241209/202412090922.Cg7LuOhS-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241209/202412090922.Cg7LuOhS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412090922.Cg7LuOhS-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/btrfs/backref.c: In function 'prelim_ref_insert':
>> fs/btrfs/backref.c:302:17: error: implicit declaration of function 'rb_find_add_cached'; did you mean 'rb_find_add_rcu'? [-Werror=implicit-function-declaration]
     302 |         exist = rb_find_add_cached(&newref->rbnode, root, prelim_ref_cmp);
         |                 ^~~~~~~~~~~~~~~~~~
         |                 rb_find_add_rcu
>> fs/btrfs/backref.c:302:15: warning: assignment to 'struct rb_node *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     302 |         exist = rb_find_add_cached(&newref->rbnode, root, prelim_ref_cmp);
         |               ^
   cc1: some warnings being treated as errors


vim +302 fs/btrfs/backref.c

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

