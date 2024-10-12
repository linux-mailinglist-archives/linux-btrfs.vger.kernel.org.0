Return-Path: <linux-btrfs+bounces-8871-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7390C99B136
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 08:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2778B21B25
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 06:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C02137742;
	Sat, 12 Oct 2024 06:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFqDJtsc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA0783CDB
	for <linux-btrfs@vger.kernel.org>; Sat, 12 Oct 2024 06:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728713578; cv=none; b=DMjTmLgOQ1IcsOQv515us6OG9MV9SFJC4cJlZNpMQ0Ux4eLDLAEaYkpi92REh037f3FUXrMPUJDWQgQ9bNsG6SEH1mgIq5lDFSaBfbScF4m7A2lrvXW3IQiEcQ48T/XHZF6f49kqh9fSHvHKeIaFrfVLsKHBlm9p2hFSPA0OrcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728713578; c=relaxed/simple;
	bh=HrwfpR6MApueHIvmpFEsucjp44XnXiI+LWo2n1gX26A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDvp8Mfkn7m77rVAWDWuKo8cAEwJ3jrTrVuy1XKbik5Gan5xOabyUaC/3DT46YV2orqFn4f5S/YJCqsVM3VyBQnygiHTPjLitwjjMV+FnWQCtpkeqVLi1g/T1V79z3VE0PEhCH5/BeMaWIZ41caitU+2XzeNFtj6qyGC6pyDFj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFqDJtsc; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728713576; x=1760249576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HrwfpR6MApueHIvmpFEsucjp44XnXiI+LWo2n1gX26A=;
  b=bFqDJtscp0776TrWUmjo2Jb/akBBtI/O4kYLHT0Qlj/A4ex1t+N9gAW1
   ZV5Rnps+xo6dI26ffXG1QAdHOzFd6zjulR123WP01nniHW8hoJMwZHPeu
   Re/tfb4Bq0uIiMDL/eC9mQp2+ipO9Fu4gyHzsc4KmgzlUCKcrVLLJnm7K
   FgicUi5VgnQFyVx7aH4ier8X4DaAb3LrZTE4GoP9M55p5n5u0i8xW62Zx
   wnUCM39HGKGt9nmJLI3NYMx7fjhPsEPV2QTx3a/tCDJoJte2mOaBVABbz
   3x+QPgb+VEJAUiLTh1rDncJJhnFZJw0iZWoKmcp/sySiaOufmT8GfW/0w
   g==;
X-CSE-ConnectionGUID: vFm4QtVhRjSXtl9Nd2GSFA==
X-CSE-MsgGUID: MFhCNCh+TkKwtb/jOl1SAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38761173"
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="38761173"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 23:12:55 -0700
X-CSE-ConnectionGUID: +iVbF2NcTfSGpASYR1HQYw==
X-CSE-MsgGUID: XMr40zCrT/+TkSMSVwfd3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="77412332"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Oct 2024 23:12:54 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szVMy-000D6f-0L;
	Sat, 12 Oct 2024 06:12:52 +0000
Date: Sat, 12 Oct 2024 14:12:36 +0800
From: kernel test robot <lkp@intel.com>
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, wqu@suse.com, hch@lst.de,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] btrfs: fix error propagation of split bios
Message-ID: <202410121307.AKR3Gyyc-lkp@intel.com>
References: <db5c272fc27c59ddded5c691373c26458698cb1a.1728489285.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db5c272fc27c59ddded5c691373c26458698cb1a.1728489285.git.naohiro.aota@wdc.com>

Hi Naohiro,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.12-rc2 next-20241011]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Naohiro-Aota/btrfs-fix-error-propagation-of-split-bios/20241010-001915
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/db5c272fc27c59ddded5c691373c26458698cb1a.1728489285.git.naohiro.aota%40wdc.com
patch subject: [PATCH] btrfs: fix error propagation of split bios
config: i386-randconfig-061-20241012 (https://download.01.org/0day-ci/archive/20241012/202410121307.AKR3Gyyc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241012/202410121307.AKR3Gyyc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410121307.AKR3Gyyc-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/btrfs/bio.c:125:65: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int i @@     got restricted blk_status_t [usertype] bi_status @@
   fs/btrfs/bio.c:125:65: sparse:     expected int i
   fs/btrfs/bio.c:125:65: sparse:     got restricted blk_status_t [usertype] bi_status
>> fs/btrfs/bio.c:133:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted blk_status_t [usertype] bi_status @@     got int @@
   fs/btrfs/bio.c:133:45: sparse:     expected restricted blk_status_t [usertype] bi_status
   fs/btrfs/bio.c:133:45: sparse:     got int

vim +125 fs/btrfs/bio.c

   116	
   117	void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
   118	{
   119		bbio->bio.bi_status = status;
   120		if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
   121			struct btrfs_bio *orig_bbio = bbio->private;
   122	
   123			/* Save the last error. */
   124			if (bbio->bio.bi_status != BLK_STS_OK)
 > 125				atomic_set(&orig_bbio->status, bbio->bio.bi_status);
   126			btrfs_cleanup_bio(bbio);
   127			bbio = orig_bbio;
   128		}
   129	
   130		if (atomic_dec_and_test(&bbio->pending_ios)) {
   131			/* Load split bio's error which might be set above. */
   132			if (status == BLK_STS_OK)
 > 133				bbio->bio.bi_status = atomic_read(&bbio->status);
   134			__btrfs_bio_end_io(bbio);
   135		}
   136	}
   137	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

