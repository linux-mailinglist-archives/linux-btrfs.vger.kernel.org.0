Return-Path: <linux-btrfs+bounces-14463-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70460ACE4D2
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 21:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C54F166BD9
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 19:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606E020D4E4;
	Wed,  4 Jun 2025 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BKZcP8G+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A01F3B85
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065610; cv=none; b=HAUoZvFfpGJc0Yy9VxmqIo15D0whEuHJsHpqx+tRGmNozFuIC2fT+++7IAttbi4GotRp2jGbGFsAFV0Qvy2M/CYakEE1jp/6cvjxyT+Xy9v0RW03CzezyrbXLx1ThNLryY0XN6DAulp6YLxy1IxURnj4HsCuXzgIEpMJjg1J4Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065610; c=relaxed/simple;
	bh=KgDeZPdoLQy4XL5zoSz4C8PxTI78nX3mxsRdRNlPGYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgz03gcrdt6gVTeiBzqtQW/4vV3Cxf74B/2CEL3Ko2KvnFECMfaaZOScH6oPuYZDU3HRKZ5XLeIFn5qKRBoZlzAptoSO0jfgNQ/2mXtr+08v0eeaXZI2S8qprhneZLqGitHQPvNZ/rOoX4aGHLPY8PP9CElU8MKw5Py4aFgJLeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BKZcP8G+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749065609; x=1780601609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KgDeZPdoLQy4XL5zoSz4C8PxTI78nX3mxsRdRNlPGYA=;
  b=BKZcP8G+Jep6x+hOxeS6r6ddigN4K9K3DuXxSa7+fVnRj57CyyDMPhGT
   HBOq0H8LeiB04O+y+FYteiTa9Gys7zqyD+q+BxyMLXIkZKQVQH3bheYxm
   41R5eyRo1CpQQwSx0CjcwwfuPEnCZICQS4oaUUbmS3VYWl5IqjSqIv3O6
   U3Y/53Z2XQoieObyBzgnoGwZQGGcua7HDMJouuIjUFGDFWD5l6BIrwkrS
   /o+qTYEM+Udwlty2gAfR8U3OWWWw7AW5JAkQqMTqI1chp3b4/VUejRG0Q
   PYRtARi9hiQAkJFFz33fgdoDiuEf4IH5rTXJN6uA94P2kM0Hau9JCmIlv
   A==;
X-CSE-ConnectionGUID: 0pd2pZ8USwKDEURqOgnw3w==
X-CSE-MsgGUID: tgv7ryqVQJiu1jnjOIoWEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="50282004"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="50282004"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 12:33:29 -0700
X-CSE-ConnectionGUID: 1aIrmsYuTbK2yQSzDjv/ew==
X-CSE-MsgGUID: i2e10bogTG6s/+QV5GT0ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="145152783"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 04 Jun 2025 12:33:26 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uMtrY-0003PZ-1T;
	Wed, 04 Jun 2025 19:33:24 +0000
Date: Thu, 5 Jun 2025 03:32:59 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: fix alloc_offset calculation for partly
 conventional block groups
Message-ID: <202506050355.YAxl8jV6-lkp@intel.com>
References: <20250604103730.358907-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604103730.358907-1-jth@kernel.org>

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.15 next-20250604]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Thumshirn/btrfs-zoned-fix-alloc_offset-calculation-for-partly-conventional-block-groups/20250604-183812
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20250604103730.358907-1-jth%40kernel.org
patch subject: [PATCH] btrfs: zoned: fix alloc_offset calculation for partly conventional block groups
config: i386-buildonly-randconfig-001-20250605 (https://download.01.org/0day-ci/archive/20250605/202506050355.YAxl8jV6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250605/202506050355.YAxl8jV6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506050355.YAxl8jV6-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__udivmoddi4" [fs/btrfs/btrfs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

