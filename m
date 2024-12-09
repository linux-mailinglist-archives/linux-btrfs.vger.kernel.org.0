Return-Path: <linux-btrfs+bounces-10148-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973479E8AE8
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 06:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9624D163540
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 05:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0301115A85E;
	Mon,  9 Dec 2024 05:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Od54OnAy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02B5155C96
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 05:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733720805; cv=none; b=H5zZqXC5YB53gDnW9xBmPfmST+lWxmIsPvBzbA1Im5HVcNCTb1ZlJwlOsDWyLAzdde69e57kaxaB3MNrhPJ29427GMBULswGxJmWBTRZiEjIdUaXGtn+tKDfezBhcHX8LE81mbtifxs+jBK2DbPI4ZJyXtyiujbFAE3o5rP7KZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733720805; c=relaxed/simple;
	bh=cTr3lapS8mNljMA681LxoLHHNbbHxzECMxAuw2/g/SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGzC5X7eP8mVERVnt59OaTNz59A+Z7Tjotszi9uyjaevPoD2+kBOodj9Jv0zrNwaEAGFsAFaF1BCJ5/5HtmT0jyFORiTIvfNCGkQn1uNs0O8Uaozzwkv/cdMo7IajwPCLiaMAn6XIb9Ax9Zjxd5cHDOFxhChVHacPQw8hVqQOW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Od54OnAy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733720804; x=1765256804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cTr3lapS8mNljMA681LxoLHHNbbHxzECMxAuw2/g/SM=;
  b=Od54OnAycv1dI5GFwtn0JalM2UZcFwoRSq+dOiYtRJlOOuM3+157JXXR
   By4MRV4CyNLKYYB0hStimN+jHm8W3wY3TGrxUYhNaHv41I9CWRpVpYk4u
   WJyWrHW+yxrDL/eaic5iClJNqf2FSVe4e23Vuz/h4e7Cb+M7dgnGiqFNF
   y+LnTqY3CaQoMqaKhSMPwffTwqfJsB908vB0dU9UX3QDUd9g/SqJPxT3h
   rMYbxKq4IJylePBreNjyxc+avsBNC8X6YVwtQj7EX/um/z5FVwud4Uis/
   rMadBjVeeDaKxdGCuduNVx3q6jasfKNolyV6rlmrBxkt35dQkDHXOoi9N
   Q==;
X-CSE-ConnectionGUID: 4mo1SYhdSaWnuKDT/VbpAw==
X-CSE-MsgGUID: cC4ZGWPSSDOH/E95c65pKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="33894065"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="33894065"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 21:06:44 -0800
X-CSE-ConnectionGUID: GgfZUlTKRZ+WXqaTxXqbkg==
X-CSE-MsgGUID: pxldlHjMSV+B+T0QZlRJIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95308625"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Dec 2024 21:06:42 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVyh-0003xZ-12;
	Mon, 09 Dec 2024 05:06:39 +0000
Date: Mon, 9 Dec 2024 13:05:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	"Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs: edit btrfs_add_block_group_cache() to use rb
 helper
Message-ID: <202412090910.F5gin2Tv-lkp@intel.com>
References: <4d8d468cc1240adf03fd23fd4b80582f57a5b28f.1733695544.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8d468cc1240adf03fd23fd4b80582f57a5b28f.1733695544.git.beckerlee3@gmail.com>

Hi Roger,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.13-rc2 next-20241206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roger-L-Beckermeyer-III/btrfs-edit-btrfs_add_block_group_cache-to-use-rb-helper/20241209-064300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/4d8d468cc1240adf03fd23fd4b80582f57a5b28f.1733695544.git.beckerlee3%40gmail.com
patch subject: [PATCH] btrfs: edit btrfs_add_block_group_cache() to use rb helper
config: arc-randconfig-002-20241209 (https://download.01.org/0day-ci/archive/20241209/202412090910.F5gin2Tv-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241209/202412090910.F5gin2Tv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412090910.F5gin2Tv-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/btrfs/block-group.c: In function 'btrfs_add_block_group_cache':
>> fs/btrfs/block-group.c:200:17: error: implicit declaration of function 'rb_find_add_cached'; did you mean 'rb_find_add_rcu'? [-Werror=implicit-function-declaration]
     200 |         exist = rb_find_add_cached(&block_group->cache_node,
         |                 ^~~~~~~~~~~~~~~~~~
         |                 rb_find_add_rcu
>> fs/btrfs/block-group.c:200:15: warning: assignment to 'struct rb_node *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     200 |         exist = rb_find_add_cached(&block_group->cache_node,
         |               ^
   cc1: some warnings being treated as errors


vim +200 fs/btrfs/block-group.c

   187	
   188	/*
   189	 * This adds the block group to the fs_info rb tree for the block group cache
   190	 */
   191	static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
   192					       struct btrfs_block_group *block_group)
   193	{
   194		struct rb_node *exist;
   195	
   196		ASSERT(block_group->length != 0);
   197	
   198		write_lock(&info->block_group_cache_lock);
   199	
 > 200		exist = rb_find_add_cached(&block_group->cache_node,
   201				&info->block_group_cache_tree, btrfs_add_blkgrp_cmp);
   202		if (exist != NULL)
   203			return -EEXIST;
   204		write_unlock(&info->block_group_cache_lock);
   205	
   206		return 0;
   207	}
   208	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

