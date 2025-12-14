Return-Path: <linux-btrfs+bounces-19721-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDE4CBB713
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Dec 2025 07:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBBA13004449
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Dec 2025 06:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48C52765C0;
	Sun, 14 Dec 2025 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0seXmzx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B442AB7
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Dec 2025 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765694571; cv=none; b=dvfF4uwLJxr7itPx/+vHnq+8Jz+yIwxSltwWJJUKzhz8BAwwPn6AyvslVIgf48vbpHOLNmnVI9t9ZRiuWGVAX1QAAG4gjne/Fdf/uOo0HX+DoYwDoEAcRB21LmGB8L7bbSfLd+YEdudY7EU/ipWkP7sa7DX58ezfze2TzfbgTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765694571; c=relaxed/simple;
	bh=wAf5W5h78Is4CrvkqVhtNy+sxagjVh0nv54EXPIwSKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjWLRTKrAXg9kDQTf3VlLf//jpUoNhF9YJlx5eJurtVA1bCQM/zBbc0tj7kEAVkKGUXVaMYLMQC3jtKtNTs1dBcbKVfpcJ4hhOqAUWHwEagjzBGuvcIuba5lBZc9YPBaY1M3wP3ueEXMRaSV67mWKWH9+EtKmKkf0gOIRslRe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0seXmzx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765694569; x=1797230569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wAf5W5h78Is4CrvkqVhtNy+sxagjVh0nv54EXPIwSKg=;
  b=d0seXmzxc6WS2mLcIfA2LkJXtRGdGI5YWkrpgbnLIJBgDsxCJxC/LEzv
   v49ZZt1u48nxs6b655anN6+5OPkJ6wttGEkMvCtvSusNouGcQYfKMwZjY
   BYpy3vVT+2c7bNF76WSyYCAecaic5lQqqkF+rSvH4ycegQB5tiytInNjq
   2cQKTBIVUO+TcaD1Yz9mmV1kyU5mMGfqzTL/y/GUU/9fW0aG+AKn/2/KO
   rfRZ+Urv5RR2rFNjb841UCf3IJD5rtMJcu+Dum826TeJKPRZola4q4SSQ
   CBn1OF1tqoyU13HIYZ4MtAvzWtjQCe9ndZ/x2p4ode1aj6FWjAcmrjQ/Z
   g==;
X-CSE-ConnectionGUID: QRrtl4xhRcCC2RFG8PJXFQ==
X-CSE-MsgGUID: QtHApuT7TXC5aM1iSHAlVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11641"; a="66806803"
X-IronPort-AV: E=Sophos;i="6.21,147,1763452800"; 
   d="scan'208";a="66806803"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2025 22:42:48 -0800
X-CSE-ConnectionGUID: Ck9U0PGVSHORFhjq+QR0FQ==
X-CSE-MsgGUID: TB+Ta9ioTouVAp12P7+6RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,147,1763452800"; 
   d="scan'208";a="197728163"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 13 Dec 2025 22:42:46 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vUfoa-000000008gz-3AlI;
	Sun, 14 Dec 2025 06:42:44 +0000
Date: Sun, 14 Dec 2025 14:42:11 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] btrfs: add an ASSERT() to catch ordered extents with
 incorrect csums
Message-ID: <202512141434.ZwLWwwtR-lkp@intel.com>
References: <7ad76db98d300c3fedc73433aa343b654399cc2d.1765521720.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ad76db98d300c3fedc73433aa343b654399cc2d.1765521720.git.wqu@suse.com>

Hi Qu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.19-rc1 next-20251212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-add-an-ASSERT-to-catch-ordered-extents-with-incorrect-csums/20251212-144720
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/7ad76db98d300c3fedc73433aa343b654399cc2d.1765521720.git.wqu%40suse.com
patch subject: [PATCH] btrfs: add an ASSERT() to catch ordered extents with incorrect csums
config: i386-buildonly-randconfig-004-20251213 (https://download.01.org/0day-ci/archive/20251214/202512141434.ZwLWwwtR-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251214/202512141434.ZwLWwwtR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512141434.ZwLWwwtR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/btrfs/inode.c:3089:12: warning: function 'oe_csum_bytes' is not needed and will not be emitted [-Wunneeded-internal-declaration]
    3089 | static u64 oe_csum_bytes(struct btrfs_ordered_extent *oe)
         |            ^~~~~~~~~~~~~
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for I2C_K1
   Depends on [n]: I2C [=m] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && OF [=n]
   Selected by [m]:
   - MFD_SPACEMIT_P1 [=m] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && I2C [=m]


vim +/oe_csum_bytes +3089 fs/btrfs/inode.c

  3088	
> 3089	static u64 oe_csum_bytes(struct btrfs_ordered_extent *oe)
  3090	{
  3091		struct btrfs_ordered_sum *sum;
  3092		u64 ret = 0;
  3093	
  3094		list_for_each_entry(sum, &oe->list, list)
  3095			ret += sum->len;
  3096		return ret;
  3097	}
  3098	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

