Return-Path: <linux-btrfs+bounces-3320-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37FC87CC9C
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 12:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1295E1C2146E
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 11:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6482B1B960;
	Fri, 15 Mar 2024 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gMYpZ9si"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D442D1B816
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710503110; cv=none; b=qlX3KtNxm3vQ8v0v2rWs5WcjsNMxYBGT7gbSYwpntnAWAcSBSvsGWtTanXr80nvrQrm0aZnQfblQ7Cum/uVZEFC1uygqetppBX1a1E37lEowyg9WlpWAj0S2zdjPW9cyYoIYIdHAh9ZFGAdmmqmdIU5Beya6ty0BSjcBy+6h7fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710503110; c=relaxed/simple;
	bh=W1h7C8nWgl0Bm3F343Qhm5mCdOm85E4ZK+85Zfb/11w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSg6ZXmyKJhypn4xiLo78hx4IYp29p2gL3sAr7n+Ek1TgVrKkN/Jz0uNC2cgfRh5u1QMfYb//1SF0flCfcwEYU5gC/LZSjKYsIQ+6FQRxgx2R6VppUECk2QRO9NVp+nX45R0S15P3sAEHYLIsQ/r5y2xtuwlCzeEnDQebl+YFXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gMYpZ9si; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710503109; x=1742039109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W1h7C8nWgl0Bm3F343Qhm5mCdOm85E4ZK+85Zfb/11w=;
  b=gMYpZ9sih5VSXymY43LNXsl6xWpAjIPHdxdp6ibsG/Gbumswh0Du4IJl
   5K9JJGYc5BZ61NbAh2uJSQQQtkmiHK2ErGQuMYnSrLGx+MF0nYkuT3Fby
   qjzJNyBVhtQCRBFBDyimP/YiaqaLCb0jOOZDwujMwpJ9EA78M5nxUirM6
   Eubohn9N8IFr1azBIJLWwb2dzTtYZiPAtL1KSfrxcDO7bMDacYcpy1aus
   vdHsKJg7seipK1pXeDj1FWpiVsfgS6ud4KkgpkPA5f9OkIhDVtYp0vBdI
   VU0/4Lk72/xLWq1wWmTPxLjK+1dWpaW74IyRyL8KSxsrm8vTZWCkPsxRD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="22886813"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="22886813"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 04:45:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="17260325"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Mar 2024 04:45:07 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rl5zk-000EOd-23;
	Fri, 15 Mar 2024 11:45:04 +0000
Date: Fri, 15 Mar 2024 19:44:54 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6/7] btrfs: scrub: unify and shorten the error message
Message-ID: <202403151954.2aDLBPQm-lkp@intel.com>
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
[also build test WARNING on linus/master v6.8 next-20240315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-scrub-fix-incorrectly-reported-logical-physical-address/20240314-215457
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/6ba44b940e4e3eea573cad667ab8c0b2dd8f2c06.1710409033.git.wqu%40suse.com
patch subject: [PATCH 6/7] btrfs: scrub: unify and shorten the error message
config: hexagon-randconfig-r111-20240315 (https://download.01.org/0day-ci/archive/20240315/202403151954.2aDLBPQm-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 8f68022f8e6e54d1aeae4ed301f5a015963089b7)
reproduce: (https://download.01.org/0day-ci/archive/20240315/202403151954.2aDLBPQm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403151954.2aDLBPQm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/btrfs/scrub.c:430:17: sparse: sparse: non size-preserving integer to pointer cast

vim +430 fs/btrfs/scrub.c

a2de733c78fa7a Arne Jansen    2011-03-08  388  
c7499a64dcf62b Filipe Manana  2022-11-01  389  static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
c7499a64dcf62b Filipe Manana  2022-11-01  390  				     u64 root, void *warn_ctx)
558540c17771ea Jan Schmidt    2011-06-13  391  {
558540c17771ea Jan Schmidt    2011-06-13  392  	int ret;
558540c17771ea Jan Schmidt    2011-06-13  393  	int i;
de2491fdefe7e5 David Sterba   2017-05-31  394  	unsigned nofs_flag;
ff023aac31198e Stefan Behrens 2012-11-06  395  	struct scrub_warning *swarn = warn_ctx;
fb456252d3d9c0 Jeff Mahoney   2016-06-22  396  	struct btrfs_fs_info *fs_info = swarn->dev->fs_info;
558540c17771ea Jan Schmidt    2011-06-13  397  	struct inode_fs_paths *ipath = NULL;
558540c17771ea Jan Schmidt    2011-06-13  398  	struct btrfs_root *local_root;
558540c17771ea Jan Schmidt    2011-06-13  399  
56e9357a1e8167 David Sterba   2020-05-15  400  	local_root = btrfs_get_fs_root(fs_info, root, true);
558540c17771ea Jan Schmidt    2011-06-13  401  	if (IS_ERR(local_root)) {
558540c17771ea Jan Schmidt    2011-06-13  402  		ret = PTR_ERR(local_root);
558540c17771ea Jan Schmidt    2011-06-13  403  		goto err;
558540c17771ea Jan Schmidt    2011-06-13  404  	}
558540c17771ea Jan Schmidt    2011-06-13  405  
de2491fdefe7e5 David Sterba   2017-05-31  406  	/*
de2491fdefe7e5 David Sterba   2017-05-31  407  	 * init_path might indirectly call vmalloc, or use GFP_KERNEL. Scrub
de2491fdefe7e5 David Sterba   2017-05-31  408  	 * uses GFP_NOFS in this context, so we keep it consistent but it does
de2491fdefe7e5 David Sterba   2017-05-31  409  	 * not seem to be strictly necessary.
de2491fdefe7e5 David Sterba   2017-05-31  410  	 */
de2491fdefe7e5 David Sterba   2017-05-31  411  	nofs_flag = memalloc_nofs_save();
558540c17771ea Jan Schmidt    2011-06-13  412  	ipath = init_ipath(4096, local_root, swarn->path);
de2491fdefe7e5 David Sterba   2017-05-31  413  	memalloc_nofs_restore(nofs_flag);
26bdef541d26fd Dan Carpenter  2011-11-16  414  	if (IS_ERR(ipath)) {
0024652895e347 Josef Bacik    2020-01-24  415  		btrfs_put_root(local_root);
26bdef541d26fd Dan Carpenter  2011-11-16  416  		ret = PTR_ERR(ipath);
26bdef541d26fd Dan Carpenter  2011-11-16  417  		ipath = NULL;
26bdef541d26fd Dan Carpenter  2011-11-16  418  		goto err;
26bdef541d26fd Dan Carpenter  2011-11-16  419  	}
558540c17771ea Jan Schmidt    2011-06-13  420  	ret = paths_from_inode(inum, ipath);
558540c17771ea Jan Schmidt    2011-06-13  421  
558540c17771ea Jan Schmidt    2011-06-13  422  	if (ret < 0)
558540c17771ea Jan Schmidt    2011-06-13  423  		goto err;
558540c17771ea Jan Schmidt    2011-06-13  424  
558540c17771ea Jan Schmidt    2011-06-13  425  	/*
558540c17771ea Jan Schmidt    2011-06-13  426  	 * we deliberately ignore the bit ipath might have been too small to
558540c17771ea Jan Schmidt    2011-06-13  427  	 * hold all of the paths here
558540c17771ea Jan Schmidt    2011-06-13  428  	 */
558540c17771ea Jan Schmidt    2011-06-13  429  	for (i = 0; i < ipath->fspath->elem_cnt; ++i)
5d163e0e68ce74 Jeff Mahoney   2016-09-20 @430  		btrfs_warn_in_rcu(fs_info,
023af88ce10a69 Qu Wenruo      2024-03-14  431  "%s at inode %lld/%llu(%s) fileoff %llu, logical %llu(%u) physical %llu(%s)%llu",
023af88ce10a69 Qu Wenruo      2024-03-14  432  				  swarn->errstr, root, inum,
023af88ce10a69 Qu Wenruo      2024-03-14  433  				  (char *)ipath->fspath->val[i], offset,
023af88ce10a69 Qu Wenruo      2024-03-14  434  				  swarn->logical, swarn->mirror_num,
023af88ce10a69 Qu Wenruo      2024-03-14  435  				  swarn->dev->devid, btrfs_dev_name(swarn->dev),
023af88ce10a69 Qu Wenruo      2024-03-14  436  				  swarn->physical);
558540c17771ea Jan Schmidt    2011-06-13  437  
0024652895e347 Josef Bacik    2020-01-24  438  	btrfs_put_root(local_root);
558540c17771ea Jan Schmidt    2011-06-13  439  	free_ipath(ipath);
558540c17771ea Jan Schmidt    2011-06-13  440  	return 0;
558540c17771ea Jan Schmidt    2011-06-13  441  
558540c17771ea Jan Schmidt    2011-06-13  442  err:
5d163e0e68ce74 Jeff Mahoney   2016-09-20  443  	btrfs_warn_in_rcu(fs_info,
023af88ce10a69 Qu Wenruo      2024-03-14  444  	"%s at inode %lld/%llu fileoff %llu, logical %llu(%u) physical %llu(%s)%llu",
023af88ce10a69 Qu Wenruo      2024-03-14  445  			  swarn->errstr, root, inum, offset,
023af88ce10a69 Qu Wenruo      2024-03-14  446  			  swarn->logical, swarn->mirror_num,
023af88ce10a69 Qu Wenruo      2024-03-14  447  			  swarn->dev->devid, btrfs_dev_name(swarn->dev),
023af88ce10a69 Qu Wenruo      2024-03-14  448  			  swarn->physical);
558540c17771ea Jan Schmidt    2011-06-13  449  	free_ipath(ipath);
558540c17771ea Jan Schmidt    2011-06-13  450  	return 0;
558540c17771ea Jan Schmidt    2011-06-13  451  }
558540c17771ea Jan Schmidt    2011-06-13  452  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

