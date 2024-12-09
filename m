Return-Path: <linux-btrfs+bounces-10151-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7159E8AEC
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 06:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B747280E0F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 05:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDD21581F8;
	Mon,  9 Dec 2024 05:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kb2qtNgb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE020165EFA
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 05:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733720867; cv=none; b=WzKZIc8DSfOZcuXN+4LhG7sbNRXcLtB2y2qOMFFP3Z+fqy91zYxbS/nj+wzAC1Q1xQy94QiZbSYLjRF4qgAabwIeRWC9hjFUrkfosHQIgLYV2Nl8rGs45glBjc8hoGzzgs9tFlEm/PwVgixrHbdowQI1kOaghTJMjOXbIknR5Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733720867; c=relaxed/simple;
	bh=NKS66/pv9MPAa4a7cogZwjps/rvPn2fzeRcXPCeCwTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3ieZ0ec9oaAnW+s/PhxyeuubUfP/iSVzaGbat242Zsg9mc4VOVKBYyReKnEPOhkPXyMvdlBH51SwYw+Tzn1USMoO2ObyTOvjA2GaVlj9UhAPjbEj13TL9htnURLGNh19uXH45KML2alPDovMGhhOYQ57+EKaLmxskvTLvs+T9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kb2qtNgb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733720866; x=1765256866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NKS66/pv9MPAa4a7cogZwjps/rvPn2fzeRcXPCeCwTo=;
  b=kb2qtNgbJ/lQ7xgOERukgDH0W2v4SQE4NR7xG1o6mrp9QlMx8HyraCQT
   r72/c7hO7aM50eNRiyd4ROceQhMuM7hYyqNHF9c9AzIyxT3h7UrrGHaxR
   J/6wOvIarXJXb0GYNRqxt0tzs+pDxRnTM2LZ2fxZgJBLzFaOL6Q8VHzU6
   25e6dQtBjlfSxBAQw3IfjMsn8PRax/aSP9/h5S0yj61/O47C2DE4PBpZh
   ZsjGMx+onSWNkLHn8mHXwHdnQcQka6L4K42MmBPqxdwOB16o3U9ZBLnlu
   i4+7Uq4bz3QPnnqccTt+l+sN0b3vPYbVnZU/qzyGhOlu20gzaCMOYVu5a
   w==;
X-CSE-ConnectionGUID: b7BZb4siRNCOGpLcr0t1HQ==
X-CSE-MsgGUID: iElWnBa9R+a3rFUF4VWezQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45383404"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45383404"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 21:07:43 -0800
X-CSE-ConnectionGUID: rw/ar4JQQViLXsOymxmTew==
X-CSE-MsgGUID: txE7/nD1RQWVaIWJ7jr1nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95053462"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 08 Dec 2024 21:07:42 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVzf-0003xh-1R;
	Mon, 09 Dec 2024 05:07:39 +0000
Date: Mon, 9 Dec 2024 13:07:31 +0800
From: kernel test robot <lkp@intel.com>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: Re: [PATCH] btrfs: edit __btrfs_add_delayed_item() to use rb helper
Message-ID: <202412091036.JGaCqbvL-lkp@intel.com>
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
config: arm-randconfig-001-20241209 (https://download.01.org/0day-ci/archive/20241209/202412091036.JGaCqbvL-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241209/202412091036.JGaCqbvL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412091036.JGaCqbvL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/btrfs/delayed-inode.c:9:
   In file included from fs/btrfs/ctree.h:10:
   In file included from include/linux/pagemap.h:8:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/btrfs/delayed-inode.c:392:10: error: call to undeclared function 'rb_find_add_cached'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     392 |         exist = rb_find_add_cached(&ins->rb_node, root, btrfs_add_delayed_item_cmp);
         |                 ^
>> fs/btrfs/delayed-inode.c:392:8: error: incompatible integer to pointer conversion assigning to 'struct rb_node *' from 'int' [-Wint-conversion]
     392 |         exist = rb_find_add_cached(&ins->rb_node, root, btrfs_add_delayed_item_cmp);
         |               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 2 errors generated.


vim +/rb_find_add_cached +392 fs/btrfs/delayed-inode.c

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

