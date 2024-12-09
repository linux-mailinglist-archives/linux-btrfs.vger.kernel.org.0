Return-Path: <linux-btrfs+bounces-10147-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22BD9E8AE7
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 06:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B40280E62
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 05:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE92F15958A;
	Mon,  9 Dec 2024 05:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IW4EXCxR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5344C91
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733720745; cv=none; b=YsyzORCjz2FOq3RFgZLqQh87bFWVvr2TvxcS5x9x1HS/UkuHTwNjSsFmYRpM1kaYFXRo7U5w0sQ7HAc0OioJgxj7I/s1+R25OHEcZuQ+DInyTolFciOiGErrIQ+N5cR9tjPQxeprdgx1uxyFEGBZbqvVMaUafG3Y6XORip+r6HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733720745; c=relaxed/simple;
	bh=rKUj0aBTI0ZfKatutdv9ouSsWdAn3pRG3PywUXBeT7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwOXmGGFFOJQWP1zRQwEUXLGU0YY/RZ9aFsbFLGwdgi4kp0entbxPHtsuZDRRD3DQ+zfXl6Xtr4uGgtwLVfcEmw13dHbuA/JkqCOzG/EkWKcdJXsk9/YH3dSCZWQR7AgEjeZQlkM3S7YifMrRRUOiY8r+zVhnxqWDOdLzZBdmK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IW4EXCxR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733720744; x=1765256744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rKUj0aBTI0ZfKatutdv9ouSsWdAn3pRG3PywUXBeT7Y=;
  b=IW4EXCxRz6Sp/JuMA51oTdkx8zTvTGswKORCTAtgsNLuXWqFwa/BEniq
   syMF1VALOck//P+yIuFaqjmA+ZlFFqu/Y66Dye1XfUC3L1z7DQJUuAFhn
   EgDZCIIRnwboYrveXuzmMV5/3dK0QtnUD/dAPJYFHiSd9l3EdkNu2MsEk
   zpnfu8MIOXbExHrcEMDZJh1DtxSK6dRZgJUVp1QAp4JaUcB158FNinGnA
   GqTTsKrwRSIl2h/f0dTATnmzhw7yMIqXCvXztATUIdU2G/tw/QrmK58bl
   GbGh0pD7RHmQCbNYkw0JDKxhj8nauzLXaQ9hoQjc8wzvidxjeZm5pJrtU
   g==;
X-CSE-ConnectionGUID: nRUCcahNRnGn9C3koJxj9w==
X-CSE-MsgGUID: 2CVZ7n+OT2y0P6YCfeyhPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="33894017"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="33894017"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 21:05:43 -0800
X-CSE-ConnectionGUID: ADfjMYPmQ6+AEcHPxwGpJg==
X-CSE-MsgGUID: jLoC4unPQfWTQMslKptsmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95308500"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Dec 2024 21:05:41 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVxj-0003xR-0g;
	Mon, 09 Dec 2024 05:05:39 +0000
Date: Mon, 9 Dec 2024 13:05:06 +0800
From: kernel test robot <lkp@intel.com>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: Re: [PATCH] btrfs: edit btrfs_add_chunk_map() to use rb helpers
Message-ID: <202412090922.LHCgRc17-lkp@intel.com>
References: <3d4e17f44bafeb7e83d2fdfb50ac4e0c3ce2d23e.1733695544.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d4e17f44bafeb7e83d2fdfb50ac4e0c3ce2d23e.1733695544.git.beckerlee3@gmail.com>

Hi Roger,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.13-rc2 next-20241206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roger-L-Beckermeyer-III/btrfs-edit-btrfs_add_chunk_map-to-use-rb-helpers/20241209-064330
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/3d4e17f44bafeb7e83d2fdfb50ac4e0c3ce2d23e.1733695544.git.beckerlee3%40gmail.com
patch subject: [PATCH] btrfs: edit btrfs_add_chunk_map() to use rb helpers
config: arm-randconfig-001-20241209 (https://download.01.org/0day-ci/archive/20241209/202412090922.LHCgRc17-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241209/202412090922.LHCgRc17-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412090922.LHCgRc17-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/btrfs/volumes.c:16:
   In file included from fs/btrfs/ctree.h:10:
   In file included from include/linux/pagemap.h:8:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/btrfs/volumes.c:5534:10: error: call to undeclared function 'rb_find_add_cached'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    5534 |         exist = rb_find_add_cached(&map->rb_node, &fs_info->mapping_tree, btrfs_chunk_map_cmp);
         |                 ^
>> fs/btrfs/volumes.c:5534:8: error: incompatible integer to pointer conversion assigning to 'struct rb_node *' from 'int' [-Wint-conversion]
    5534 |         exist = rb_find_add_cached(&map->rb_node, &fs_info->mapping_tree, btrfs_chunk_map_cmp);
         |               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 2 errors generated.


vim +/rb_find_add_cached +5534 fs/btrfs/volumes.c

  5527	
  5528	EXPORT_FOR_TESTS
  5529	int btrfs_add_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map)
  5530	{
  5531		struct rb_node *exist;
  5532	
  5533		write_lock(&fs_info->mapping_tree_lock);
> 5534		exist = rb_find_add_cached(&map->rb_node, &fs_info->mapping_tree, btrfs_chunk_map_cmp);
  5535	
  5536		if (exist != NULL) {
  5537			write_unlock(&fs_info->mapping_tree_lock);
  5538			return -EEXIST;
  5539		}
  5540		chunk_map_device_set_bits(map, CHUNK_ALLOCATED);
  5541		chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
  5542		write_unlock(&fs_info->mapping_tree_lock);
  5543	
  5544		return 0;
  5545	}
  5546	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

