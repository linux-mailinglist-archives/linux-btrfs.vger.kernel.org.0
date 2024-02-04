Return-Path: <linux-btrfs+bounces-2094-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CBC848FE3
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Feb 2024 19:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25980B21FE4
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Feb 2024 18:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166CA24A12;
	Sun,  4 Feb 2024 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elXcEfiV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C6B249ED
	for <linux-btrfs@vger.kernel.org>; Sun,  4 Feb 2024 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707070839; cv=none; b=dmOKCgwqr4teXT5PLq3J7avfR9FMnbH922oAvBZa0gMFI+6nylCD+md6V+0q8eGbzItfeMqyuNigScPddcbZ8/RJYNuU3d/gu9dR/DO+uWagRe4Hy5bwMJFEYAFHop8IpceC5oC8eY3h8x9nwNTxCsMpXA/h6kGR7Z2N7sRxXJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707070839; c=relaxed/simple;
	bh=gy8zs2FoOIoSogXPm8fRBnCFPBZTbqCcHm5nXQLDHz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MG26jBD1ALgJ6nNwHJRUGqA9bzc82/e99useqd4+/ngI8EQY0pj7p3AigSAnoYxMS0SmYeQv5YbYNPrpLk78FbNyJC04M3+nkVHfr+sAtRabMBnMIXpYlkNCcc8lrlvpAz3/jIZbc+MzGsmyk/ytGMkAclUZZ1Z47KrzBJpOoMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elXcEfiV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707070837; x=1738606837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gy8zs2FoOIoSogXPm8fRBnCFPBZTbqCcHm5nXQLDHz8=;
  b=elXcEfiVyfSy4TkffaXh/0ejjWoGBUQQqIsJP4tZHGvxZj4oZMMktXZI
   RbbOGB8aoY1za/PcsovFTM9Wfb2u+SRatAVfmrd/RiAKmHsDNFEv5H4Vc
   qZI7kp8qSspumpfDwRknZpYfyLawmabnkt6Y3G6CWN2Bz1N8d1CDJa0Ct
   qOV9skn2xx0Nl8r+3FvSvzlg4mnA9RXusNvJ42QjnMeyjk80lf3QtKL5W
   cQwz+qEoR/m8wwMOFBjtFmZlDEX16SedqOvGBDLpwQb13qjxHaWkuWyAb
   Esc3ge5Mru9RfVmO3Xmb5fgDfA0lbGM1QtddMniKTCTS1d2k+ugdhF2GQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="3374146"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="3374146"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 10:20:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="5151591"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 04 Feb 2024 10:20:36 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWh6X-0006c8-2Y;
	Sun, 04 Feb 2024 18:20:33 +0000
Date: Mon, 5 Feb 2024 02:19:43 +0800
From: kernel test robot <lkp@intel.com>
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 4/6] btrfs: periodic block_group reclaim
Message-ID: <202402050244.pa6hJds3-lkp@intel.com>
References: <1173e535ec7b46bda33ed2dc4219027502763902.1706914865.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1173e535ec7b46bda33ed2dc4219027502763902.1706914865.git.boris@bur.io>

Hi Boris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.8-rc2 next-20240202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Boris-Burkov/btrfs-report-reclaim-count-in-sysfs/20240203-071516
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/1173e535ec7b46bda33ed2dc4219027502763902.1706914865.git.boris%40bur.io
patch subject: [PATCH 4/6] btrfs: periodic block_group reclaim
config: i386-randconfig-141-20240204 (https://download.01.org/0day-ci/archive/20240205/202402050244.pa6hJds3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402050244.pa6hJds3-lkp@intel.com/

smatch warnings:
fs/btrfs/space-info.c:1996 btrfs_reclaim_sweep() error: uninitialized symbol 'ret'.

vim +/ret +1996 fs/btrfs/space-info.c

  1977	
  1978	int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info)
  1979	{
  1980		int ret;
  1981		int raid;
  1982		struct btrfs_space_info *space_info;
  1983	
  1984		list_for_each_entry(space_info, &fs_info->space_info, list) {
  1985			if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
  1986				continue;
  1987			if (!READ_ONCE(space_info->periodic_reclaim))
  1988				continue;
  1989			for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
  1990				ret = do_reclaim_sweep(fs_info, space_info, raid);
  1991				if (ret)
  1992					return ret;
  1993			}
  1994		}
  1995	
> 1996		return ret;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

