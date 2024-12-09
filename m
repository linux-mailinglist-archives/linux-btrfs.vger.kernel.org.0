Return-Path: <linux-btrfs+bounces-10144-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5CE9E8AE3
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 06:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C69C1882840
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 05:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5981537C3;
	Mon,  9 Dec 2024 05:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdrGYDDK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0143C0B
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 05:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733720444; cv=none; b=C2G2KP2c0TWrXqBixJyg1Cr03oi9PAt8EdtzFRVwFsmyGLaAV2h9QfS1JBi7BSKPzuvefnEB4qWbues81RgMPUvi6oGMjlw1DXZdo2e1x8pPXZDAeufK8U7CJzRIfW1k9ZW/QOxxgBxzP9oT6CwOzQN/I5yZ87FALgke/z3exXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733720444; c=relaxed/simple;
	bh=v4sX5Pd3FM8uA7Duinre9hyC9XQ2sRUkXxp3VcWz1Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6oDFbqIibTjzGO5G7SLVEkXt1ii/NRjPHCRayKQ/cpRNnjRBUW80Xk0ZBNOa+VSharf9glQV8COJyObsJL6kJDwzIBkFsNd1JWcqfwuZnTVrDWXYnvBrs0hsfsCKZn4rYYl+rkbnHS93LtAJUmAs7ogJgl1Brk2cFozK2qxVm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdrGYDDK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733720442; x=1765256442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v4sX5Pd3FM8uA7Duinre9hyC9XQ2sRUkXxp3VcWz1Zk=;
  b=cdrGYDDKFZj0eQt5GlQhA4m/r39jXNrjl26eqGELQ96NoOmNh75DN2dv
   MJGx9yu2KErUCdjnbfo5ipkJZMZA5Zq3dfBHALx98eYvi9NFEO7oJj9V3
   FRRj5UiCBrq4lGEHcPPb7YEVlZ6hAtB6WBZvClhbjsqVJTM4JGg12nUPJ
   lq6YgsymTpfcyASV8mHM3VYhvIPHUWeISDMx5FRR9mfM0lX5N0VdHm2q3
   wRypigSHF1MzdZBZekS+EHoWwuApWAGJh0GnX2YE30KkYsueI+hERFIM0
   Zpl15Il4BxNSF9pWip7AShcLYE14F1D+M8CgDd2Jk7ky+i5Z0dJndP+Ti
   Q==;
X-CSE-ConnectionGUID: uMIjlnn6R/yeW1AI1ko0lA==
X-CSE-MsgGUID: PUdGK3soTl2Nn4D4ckWB5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45382902"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45382902"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 21:00:42 -0800
X-CSE-ConnectionGUID: B/TasuEtRhe7PdVH5lhAUA==
X-CSE-MsgGUID: HI17XiHaT7y5dpamq2LpqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="99781638"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 08 Dec 2024 21:00:41 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVss-0003x3-2L;
	Mon, 09 Dec 2024 05:00:38 +0000
Date: Mon, 9 Dec 2024 13:00:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	"Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: Re: [PATCH] btrfs: edit __btrfs_add_delayed_item() to use rb helper
Message-ID: <202412090921.E0n0Ioce-lkp@intel.com>
References: <9b85bdbc269d20886590f0a70de66c602d72aa9d.1733695544.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b85bdbc269d20886590f0a70de66c602d72aa9d.1733695544.git.beckerlee3@gmail.com>

Hi Roger,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.13-rc2 next-20241206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roger-L-Beckermeyer-III/btrfs-edit-__btrfs_add_delayed_item-to-use-rb-helper/20241209-064154
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/9b85bdbc269d20886590f0a70de66c602d72aa9d.1733695544.git.beckerlee3%40gmail.com
patch subject: [PATCH] btrfs: edit __btrfs_add_delayed_item() to use rb helper
config: arc-randconfig-002-20241209 (https://download.01.org/0day-ci/archive/20241209/202412090921.E0n0Ioce-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241209/202412090921.E0n0Ioce-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412090921.E0n0Ioce-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/btrfs/delayed-inode.c: In function '__btrfs_add_delayed_item':
>> fs/btrfs/delayed-inode.c:392:17: error: implicit declaration of function 'rb_find_add_cached'; did you mean 'rb_find_add_rcu'? [-Werror=implicit-function-declaration]
     392 |         exist = rb_find_add_cached(&ins->rb_node, root, btrfs_add_delayed_item_cmp);
         |                 ^~~~~~~~~~~~~~~~~~
         |                 rb_find_add_rcu
>> fs/btrfs/delayed-inode.c:392:15: warning: assignment to 'struct rb_node *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     392 |         exist = rb_find_add_cached(&ins->rb_node, root, btrfs_add_delayed_item_cmp);
         |               ^
   cc1: some warnings being treated as errors


vim +392 fs/btrfs/delayed-inode.c

   380	
   381	static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
   382					    struct btrfs_delayed_item *ins)
   383	{
   384		struct rb_root_cached *root;
   385		struct rb_node *exist;
   386	
   387		if (ins->type == BTRFS_DELAYED_INSERTION_ITEM)
   388			root = &delayed_node->ins_root;
   389		else
   390			root = &delayed_node->del_root;
   391	
 > 392		exist = rb_find_add_cached(&ins->rb_node, root, btrfs_add_delayed_item_cmp);
   393		if (exist != NULL)
   394			return -EEXIST;
   395	
   396		if (ins->type == BTRFS_DELAYED_INSERTION_ITEM &&
   397		    ins->index >= delayed_node->index_cnt)
   398			delayed_node->index_cnt = ins->index + 1;
   399	
   400		delayed_node->count++;
   401		atomic_inc(&delayed_node->root->fs_info->delayed_root->items);
   402		return 0;
   403	}
   404	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

