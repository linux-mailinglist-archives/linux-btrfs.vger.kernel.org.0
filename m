Return-Path: <linux-btrfs+bounces-10150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593D39E8AEB
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 06:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1389C1642FD
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 05:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8710B16C69F;
	Mon,  9 Dec 2024 05:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISrgxLiL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FAF1581F8
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 05:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733720866; cv=none; b=e2hHi7z+CJfytVYLIEoWZWiQamj23wGsczAJhJXCc1HJoxSxctVRGz8awOstp8Qq8myWZfqFJEd8lsrQW6Z13OEroAa5pXjtz8/WAz6s9thbk8ob3SJPbSQDIWLjX5ZT4iuAAEmle3frhTDYvNDEink2guDiNy7J6a+l4BHNn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733720866; c=relaxed/simple;
	bh=4THFBTMhOmeIB3oP15NpKXiZ4Uv6hv1vHzzUBpJ8CkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDp5pUwmk6uEezeSnWK2lW61FkSt1G1Sq+H1KPDjjWfIRWfrrvAfiOsLjLN68aDWoeQHFsDTTka+MMUIH6cu352iNDaTRrwh9tl6XqfOuz/WkTrvEghyUWa1JOK73H3PJ5B0skNXYj6NsQFcwUuAgzWIrmrmM7NOFcloP73tD5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISrgxLiL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733720865; x=1765256865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4THFBTMhOmeIB3oP15NpKXiZ4Uv6hv1vHzzUBpJ8CkM=;
  b=ISrgxLiLxIXDps/yUUAjmzEGqNA0fcvv9WitXdoj5zY5ujp8FcE/Y2Z6
   qzTlGBb1MkK4rQ1MMBiLmVIyC96BqlsrklAIRTA+EIMAYy4nFRf3Pv9a4
   CnJwqnPPXs7PsyPsUu43KXkegw3p+Gu4jhw5H/5fxUf8Af3JGbFUmj+cP
   esMpzjRnDXWdNF0gNveDcyux9L/8072dPuT+f8Xh2Ggh0c9y0QfBzjRfY
   PDhkp5nLWI3NXoSC4vg6BvlVoxa1nEV3Ht8bIUhG+GZdoBeSbGWi9pNU+
   9uWOMUJ3Xfsl3IjPNJi56tVH5rQGi90867rsvYuekcWwij48VODJQqRhX
   w==;
X-CSE-ConnectionGUID: xaMV8x+TTfqOgRkH2zX64Q==
X-CSE-MsgGUID: LWfXUsfnQ2+732XAfLLkTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45383401"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45383401"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 21:07:43 -0800
X-CSE-ConnectionGUID: 5ndCDZ1bThagy3AmomyWVQ==
X-CSE-MsgGUID: nG5LV3WqQbOvdzODwBuxeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95053463"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 08 Dec 2024 21:07:42 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVzf-0003xj-1W;
	Mon, 09 Dec 2024 05:07:39 +0000
Date: Mon, 9 Dec 2024 13:07:29 +0800
From: kernel test robot <lkp@intel.com>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	"Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: Re: [PATCH] btrfs: edit btrfs_add_chunk_map() to use rb helpers
Message-ID: <202412090919.RdI1OMQg-lkp@intel.com>
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
config: arc-randconfig-002-20241209 (https://download.01.org/0day-ci/archive/20241209/202412090919.RdI1OMQg-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241209/202412090919.RdI1OMQg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412090919.RdI1OMQg-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/btrfs/volumes.c: In function 'btrfs_add_chunk_map':
>> fs/btrfs/volumes.c:5534:17: error: implicit declaration of function 'rb_find_add_cached'; did you mean 'rb_find_add_rcu'? [-Werror=implicit-function-declaration]
    5534 |         exist = rb_find_add_cached(&map->rb_node, &fs_info->mapping_tree, btrfs_chunk_map_cmp);
         |                 ^~~~~~~~~~~~~~~~~~
         |                 rb_find_add_rcu
>> fs/btrfs/volumes.c:5534:15: warning: assignment to 'struct rb_node *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    5534 |         exist = rb_find_add_cached(&map->rb_node, &fs_info->mapping_tree, btrfs_chunk_map_cmp);
         |               ^
   cc1: some warnings being treated as errors


vim +5534 fs/btrfs/volumes.c

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

