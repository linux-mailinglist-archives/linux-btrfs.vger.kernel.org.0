Return-Path: <linux-btrfs+bounces-7694-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE5396675F
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 18:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1840DB27868
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 16:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335361B81CA;
	Fri, 30 Aug 2024 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h39TH2Zy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F5018E34F
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036682; cv=none; b=G55YVASt6V5zoPDkYJIG74VnELqABvmRbaUodbyDcVnWXBdr/LJ3udS4VYJGcU32wVW9gv+sN5QexNSj73uI4XtWGONclwUC+r7Hh5WJ9MD6ApxEAefjfUsLACCaR0MVqeEETikovVMaw2xpsvoByrDhtHOEvFewkXJl08w3k9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036682; c=relaxed/simple;
	bh=4ZCPpBaooYyMmKCgmTQHCqOblwDMHsslrsxdaKO+rA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7MZGDL9Z6b80QNXGpW9f1mzXtSYUd3kT8Qp7vLeNhMwCo55CZKQCYfzY1NVs6lNPl9RDMkY4DqBXL7FshsiLgRfhWNyW6xewL5ADcnFBYdNQWu6DeuL+dvrG8IuUpMSWLRz7RfNrOTkHHO0XEVQyOb9nD/5Ze94zos2v7FeB9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h39TH2Zy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725036681; x=1756572681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4ZCPpBaooYyMmKCgmTQHCqOblwDMHsslrsxdaKO+rA0=;
  b=h39TH2Zy/hTZRa9hCrsaQ0I5tuh+tdMA762FDoXLRcNBNSrX1XRQuFQQ
   k2vMY/jUUmUCiV8pO6VcYNRepxnrYjHQ9D9iUPTRCFtUfpOJyZ0si/dYW
   A7sqlPlUeCuXT/5D8kl/15PVpW7+L0BHxGxCkiv7qdy+TzAwYQt2TEFXy
   3gXEvhH4i2BSHyDmz+vhsP6LVIPtAauTFmO1kM+jLgt5IdzuCGpH7yfdC
   AkWJMR2lr38EtkfNzM/BMuBmNOCKd9FPuwxSPKmQx9+G10s4a0VtHzUOG
   MckvhdX14v0wxlB6WySoCSonZx9NJKq/QhSYLzIFAPcxTAglOeizk/Fpf
   A==;
X-CSE-ConnectionGUID: K9LUE7tbQbeUh9p1o2rL4A==
X-CSE-MsgGUID: 0taQiODITDKaUqA1NANJ7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23870834"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="23870834"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:51:20 -0700
X-CSE-ConnectionGUID: Yq9WyiRKSkeG1TewNGmigw==
X-CSE-MsgGUID: lOeoF0XPRnWL8y5bpk6ohA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63649912"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 30 Aug 2024 09:51:19 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk4qC-0001fm-2P;
	Fri, 30 Aug 2024 16:51:16 +0000
Date: Sat, 31 Aug 2024 00:50:28 +0800
From: kernel test robot <lkp@intel.com>
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 2/2] btrfs: constify more pointer parameters
Message-ID: <202408310007.Ds7bGRX9-lkp@intel.com>
References: <e163012ed80a4f55ce17641586681c6ac4ff9018.1724859620.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e163012ed80a4f55ce17641586681c6ac4ff9018.1724859620.git.dsterba@suse.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master next-20240830]
[cannot apply to v6.11-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Sterba/btrfs-rework-BTRFS_I-as-macro-to-preserve-parameter-const/20240828-234222
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/e163012ed80a4f55ce17641586681c6ac4ff9018.1724859620.git.dsterba%40suse.com
patch subject: [PATCH 2/2] btrfs: constify more pointer parameters
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240831/202408310007.Ds7bGRX9-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408310007.Ds7bGRX9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310007.Ds7bGRX9-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/btrfs/block-group.c:1762:37: error: passing 'const struct btrfs_fs_info *' to parameter of type 'struct btrfs_fs_info *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
    1762 |                 return btrfs_zoned_should_reclaim(fs_info);
         |                                                   ^~~~~~~
   fs/btrfs/zoned.h:245:69: note: passing argument to parameter 'fs_info' here
     245 | static inline bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
         |                                                                     ^
   1 error generated.


vim +1762 fs/btrfs/block-group.c

2ca0ec770c62b32 Johannes Thumshirn 2021-10-14  1758  
17ca64afd0470e9 David Sterba       2024-08-28  1759  static inline bool btrfs_should_reclaim(const struct btrfs_fs_info *fs_info)
3687fcb0752ac9c Johannes Thumshirn 2022-03-29  1760  {
3687fcb0752ac9c Johannes Thumshirn 2022-03-29  1761  	if (btrfs_is_zoned(fs_info))
3687fcb0752ac9c Johannes Thumshirn 2022-03-29 @1762  		return btrfs_zoned_should_reclaim(fs_info);
3687fcb0752ac9c Johannes Thumshirn 2022-03-29  1763  	return true;
3687fcb0752ac9c Johannes Thumshirn 2022-03-29  1764  }
3687fcb0752ac9c Johannes Thumshirn 2022-03-29  1765  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

