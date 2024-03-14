Return-Path: <linux-btrfs+bounces-3315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49E887C5BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 00:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03ABD1C21044
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 23:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DADFC0E;
	Thu, 14 Mar 2024 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZxUhe2n+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFACF9EC
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710457552; cv=none; b=EcIYQqtuULzQMmbU7NtwIfV6pprdoMsBE+O1yN5G6g22a7hKmAre663R8cJluppZoryLdrx3iTNixIP4GQH2jEYjF3DDVt8h5lx8fxnPAIF2ubYeIY0m0NK9kcvXRxmHmCpH6lMH0m/0ULBOxIg4ygOaejZv2PZtp8v307qrqgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710457552; c=relaxed/simple;
	bh=g+HfWUF7TbKy7dvKtxVWP429OhIknM/homu21ES69No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhswDKXL56581GIimpmBxC9Dzd9aSDzqSlYZz6wWDzlPuGHG+/miMUSXa7D6VCO+MdntxnUtJTCMbPOuYipdaWeDbvfhu6h9PLy5hV82gnMUIPJcRIEXerCD7lX9QIu9iHsrw+uTgDyr41FFgtxXWfd1i6JlVnGrzyEwQ07CxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZxUhe2n+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710457550; x=1741993550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g+HfWUF7TbKy7dvKtxVWP429OhIknM/homu21ES69No=;
  b=ZxUhe2n+wZRoKeusGONr/h6UvruiM0kHI+WPvqV4a6W9+EVrHbKFtcTy
   CUY3THRpCKiOIxEcx7Qkr4Hnb4wYSvvzlOZwNL5BqGrcmbdyZcSoJRstP
   O7e4VAstTqNpxnyPnQAQnUB/dHV9XOTR730vgKu4Y5NQukUK/Dh+tF5yN
   fhFK39vXcB6HYTRnoDCZX9llUz3hQvrbztlWaseRjzTsWBbodzZlggTXz
   Oy2MKIVDYvnxEpWcqgHQbySfLwdsD0DymOMSkFF4npdBa88pytHULD/PV
   FgUmyZG+4M8G1vdO7IXmQukLOwkitU6kp4uiR7nUn2Oz3c5zVT7z+SuUx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="22828071"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="22828071"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 16:05:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="49907535"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Mar 2024 16:05:47 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rku8v-000Ds1-0h;
	Thu, 14 Mar 2024 23:05:45 +0000
Date: Fri, 15 Mar 2024 07:05:07 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6/7] btrfs: scrub: unify and shorten the error message
Message-ID: <202403150650.dNFtHzxf-lkp@intel.com>
References: <6ba44b940e4e3eea573cad667ab8c0b2dd8f2c06.1710409033.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ba44b940e4e3eea573cad667ab8c0b2dd8f2c06.1710409033.git.wqu@suse.com>

Hi Qu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.8 next-20240314]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-scrub-fix-incorrectly-reported-logical-physical-address/20240314-215457
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/6ba44b940e4e3eea573cad667ab8c0b2dd8f2c06.1710409033.git.wqu%40suse.com
patch subject: [PATCH 6/7] btrfs: scrub: unify and shorten the error message
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20240315/202403150650.dNFtHzxf-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240315/202403150650.dNFtHzxf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403150650.dNFtHzxf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/btrfs/extent_io.h:16,
                    from fs/btrfs/locking.h:13,
                    from fs/btrfs/ctree.h:19,
                    from fs/btrfs/scrub.c:10:
   fs/btrfs/scrub.c: In function 'scrub_print_warning_inode':
>> fs/btrfs/scrub.c:433:35: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     433 |                                   (char *)ipath->fspath->val[i], offset,
         |                                   ^
   fs/btrfs/messages.h:27:39: note: in definition of macro 'btrfs_printk'
      27 |         _btrfs_printk(fs_info, fmt, ##args)
         |                                       ^~~~
   fs/btrfs/messages.h:66:9: note: in expansion of macro 'btrfs_printk_in_rcu'
      66 |         btrfs_printk_in_rcu(fs_info, KERN_WARNING fmt, ##args)
         |         ^~~~~~~~~~~~~~~~~~~
   fs/btrfs/scrub.c:430:17: note: in expansion of macro 'btrfs_warn_in_rcu'
     430 |                 btrfs_warn_in_rcu(fs_info,
         |                 ^~~~~~~~~~~~~~~~~


vim +433 fs/btrfs/scrub.c

   388	
   389	static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
   390					     u64 root, void *warn_ctx)
   391	{
   392		int ret;
   393		int i;
   394		unsigned nofs_flag;
   395		struct scrub_warning *swarn = warn_ctx;
   396		struct btrfs_fs_info *fs_info = swarn->dev->fs_info;
   397		struct inode_fs_paths *ipath = NULL;
   398		struct btrfs_root *local_root;
   399	
   400		local_root = btrfs_get_fs_root(fs_info, root, true);
   401		if (IS_ERR(local_root)) {
   402			ret = PTR_ERR(local_root);
   403			goto err;
   404		}
   405	
   406		/*
   407		 * init_path might indirectly call vmalloc, or use GFP_KERNEL. Scrub
   408		 * uses GFP_NOFS in this context, so we keep it consistent but it does
   409		 * not seem to be strictly necessary.
   410		 */
   411		nofs_flag = memalloc_nofs_save();
   412		ipath = init_ipath(4096, local_root, swarn->path);
   413		memalloc_nofs_restore(nofs_flag);
   414		if (IS_ERR(ipath)) {
   415			btrfs_put_root(local_root);
   416			ret = PTR_ERR(ipath);
   417			ipath = NULL;
   418			goto err;
   419		}
   420		ret = paths_from_inode(inum, ipath);
   421	
   422		if (ret < 0)
   423			goto err;
   424	
   425		/*
   426		 * we deliberately ignore the bit ipath might have been too small to
   427		 * hold all of the paths here
   428		 */
   429		for (i = 0; i < ipath->fspath->elem_cnt; ++i)
   430			btrfs_warn_in_rcu(fs_info,
   431	"%s at inode %lld/%llu(%s) fileoff %llu, logical %llu(%u) physical %llu(%s)%llu",
   432					  swarn->errstr, root, inum,
 > 433					  (char *)ipath->fspath->val[i], offset,
   434					  swarn->logical, swarn->mirror_num,
   435					  swarn->dev->devid, btrfs_dev_name(swarn->dev),
   436					  swarn->physical);
   437	
   438		btrfs_put_root(local_root);
   439		free_ipath(ipath);
   440		return 0;
   441	
   442	err:
   443		btrfs_warn_in_rcu(fs_info,
   444		"%s at inode %lld/%llu fileoff %llu, logical %llu(%u) physical %llu(%s)%llu",
   445				  swarn->errstr, root, inum, offset,
   446				  swarn->logical, swarn->mirror_num,
   447				  swarn->dev->devid, btrfs_dev_name(swarn->dev),
   448				  swarn->physical);
   449		free_ipath(ipath);
   450		return 0;
   451	}
   452	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

