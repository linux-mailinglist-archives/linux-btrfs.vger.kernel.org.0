Return-Path: <linux-btrfs+bounces-18466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 251BEC24F59
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 13:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 305354E994A
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 12:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCB42E5B0D;
	Fri, 31 Oct 2025 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtLRiFGt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F512E401;
	Fri, 31 Oct 2025 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913183; cv=none; b=j4N0wOdqeiFkFiOnR93xp8yjV9H21YiOWOl/h0nUESgfWiZkTWjgr1DL1xbuqtnFBx8HnVo2U5etClaQQu3ZXCkNWcUkQi5vB8gN4bPqdUQR8wxljttW/PmXoLNj9KLVN0hNJfKuFKxayVNTd/q7SRUkovuWCJUR6snO8kYo+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913183; c=relaxed/simple;
	bh=dT6kDyIp8MnyYNrNozXVkRFEY5aT2X5uIUkMcsMzINM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG7MXkeItipEPb6AuiYzsC2GsEan2NCqiU1gSWOj6GtSGOsDsBD8faC5AEixZaHCaGFKniXZhZIaTuiWvPE83CZnC3aMmDBM8Ca+I+4HYSRdERyU5VDU5oWfX1NxF7psKL2syC8H4RtHMQIq+S2G3lkKKqgAGHfqRz7qZu01KWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtLRiFGt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761913182; x=1793449182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dT6kDyIp8MnyYNrNozXVkRFEY5aT2X5uIUkMcsMzINM=;
  b=dtLRiFGteG16aguDFHWJTSd+5p/x62uwOt47tffhSxY4AddN3JslHu1E
   6UkuG1FypmJe3mAPO8IIGqwIzFY6o2Wqqs37g+Tt+OCz/dw/9wrHeGJYC
   DajW8ZkDWeuKJteAlpJ9U9FebtCcBNHN8rSYAGYwDuimA3okpCYPyo/4U
   wJPvxWaiCAA7W23nAMZiXt65yh1yHaqd1tMjEx1wdz7Dd6F5RYP6F4txR
   9h2nhop2XyAwuhwFwglOMnUhEv3adHPIvIOwoCd3ySUNs00sayzUT7sNJ
   V0VMEvKXtRCzI/+6wOo2uMuQEZF0d9ppFIBr3YXbP/fDjdG6VFaBkypHb
   Q==;
X-CSE-ConnectionGUID: CfwGiGT5QoyQso6IovkT8g==
X-CSE-MsgGUID: G7QUEbXCSXml75tIq0221Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="51645315"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="51645315"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:19:41 -0700
X-CSE-ConnectionGUID: fTTR/R0NRDy/611ccDKfQw==
X-CSE-MsgGUID: 0TL+EGaZRWWRg0ayPfR35Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="186965714"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 31 Oct 2025 05:19:39 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEo5z-000N5U-2z;
	Fri, 31 Oct 2025 12:19:19 +0000
Date: Fri, 31 Oct 2025 20:18:50 +0800
From: kernel test robot <lkp@intel.com>
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Chris Mason <chris.mason@fusionio.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: make ASSERT no-op in release builds
Message-ID: <202510311956.w2iYoQcn-lkp@intel.com>
References: <20251030182322.4085697-1-foxido@foxido.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030182322.4085697-1-foxido@foxido.dev>

Hi Gladyshev,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6]

url:    https://github.com/intel-lab-lkp/linux/commits/Gladyshev-Ilya/btrfs-make-ASSERT-no-op-in-release-builds/20251031-024059
base:   e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
patch link:    https://lore.kernel.org/r/20251030182322.4085697-1-foxido%40foxido.dev
patch subject: [PATCH] btrfs: make ASSERT no-op in release builds
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251031/202510311956.w2iYoQcn-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510311956.w2iYoQcn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510311956.w2iYoQcn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/btrfs/raid56.c:302:13: warning: function 'full_page_sectors_uptodate' is not needed and will not be emitted [-Wunneeded-internal-declaration]
     302 | static bool full_page_sectors_uptodate(struct btrfs_raid_bio *rbio,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/full_page_sectors_uptodate +302 fs/btrfs/raid56.c

53b381b3abeb86 David Woodhouse 2013-01-29  301  
d4e28d9b5f04d8 Qu Wenruo       2022-04-01 @302  static bool full_page_sectors_uptodate(struct btrfs_raid_bio *rbio,
d4e28d9b5f04d8 Qu Wenruo       2022-04-01  303  				       unsigned int page_nr)
d4e28d9b5f04d8 Qu Wenruo       2022-04-01  304  {
d4e28d9b5f04d8 Qu Wenruo       2022-04-01  305  	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
d4e28d9b5f04d8 Qu Wenruo       2022-04-01  306  	const u32 sectors_per_page = PAGE_SIZE / sectorsize;
d4e28d9b5f04d8 Qu Wenruo       2022-04-01  307  	int i;
d4e28d9b5f04d8 Qu Wenruo       2022-04-01  308  
d4e28d9b5f04d8 Qu Wenruo       2022-04-01  309  	ASSERT(page_nr < rbio->nr_pages);
d4e28d9b5f04d8 Qu Wenruo       2022-04-01  310  
d4e28d9b5f04d8 Qu Wenruo       2022-04-01  311  	for (i = sectors_per_page * page_nr;
d4e28d9b5f04d8 Qu Wenruo       2022-04-01  312  	     i < sectors_per_page * page_nr + sectors_per_page;
d4e28d9b5f04d8 Qu Wenruo       2022-04-01  313  	     i++) {
d4e28d9b5f04d8 Qu Wenruo       2022-04-01  314  		if (!rbio->stripe_sectors[i].uptodate)
d4e28d9b5f04d8 Qu Wenruo       2022-04-01  315  			return false;
d4e28d9b5f04d8 Qu Wenruo       2022-04-01  316  	}
d4e28d9b5f04d8 Qu Wenruo       2022-04-01  317  	return true;
d4e28d9b5f04d8 Qu Wenruo       2022-04-01  318  }
d4e28d9b5f04d8 Qu Wenruo       2022-04-01  319  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

