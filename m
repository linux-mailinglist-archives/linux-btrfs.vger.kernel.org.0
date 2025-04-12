Return-Path: <linux-btrfs+bounces-12965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C3AA86AFD
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Apr 2025 07:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2978A2538
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Apr 2025 05:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5408318A953;
	Sat, 12 Apr 2025 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZCDX0Ev"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A371885A1
	for <linux-btrfs@vger.kernel.org>; Sat, 12 Apr 2025 05:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744434816; cv=none; b=fMsFe0zJso/Tmr/LIp7r72meJRhIaOd7yOOlhuxPbRjyk+QIBwX43837MUZtS2iISWM24LgHCmMFb7KkdRU3f2oW+qbpxAy9HLusAA/2EkRspPHljJTQefwoVGez3NRp1p1IeksIXTrlRpLVlqWTDhULZqlL1bQSsihnonZRmLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744434816; c=relaxed/simple;
	bh=TClDkmi/WEBWnM9WEqz+w4tDDndcVqSNbj2mtwW9UEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACnElcpZUK7TcAJFwKOv2/O8GLforabJmOiGXiX/PQ4tzLfNSPXTNzDyOFXkjtRNLaRUd6QP8lU+5pWI3subzhXu5FnV864F+9hD1tsWb6K0wQdEFDnZEgBWGTB1G1vAem3C9nuosK6ddq5+GX7BMO5WCEYFf5qX0zQh+AjFTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZCDX0Ev; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744434814; x=1775970814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TClDkmi/WEBWnM9WEqz+w4tDDndcVqSNbj2mtwW9UEY=;
  b=kZCDX0EvhZ08LK6eQk+UYfqqQ0JToHNLjLKEw9mmOuy5XL5PfFPekmbx
   fbtaGAHhj59ZqdL70BdOwMPeSLDDtn/iswSnOtSSAwnxG5Z82PlsTUuzA
   VloBA0w9h6yCvGI4y6OgdGl3f83JtYBCqJERhwC5ap8xP61kc/ZJOyuxu
   zCXulQYeckItA0N0lhHxynKHs271WS8V7JG711jX50vebwv0FRd4OnSr9
   ePlmnmSmsZuvciEJbS30dXnNrsnwDLGhAjMF7Q9fp5kQtqioRxqS15Lbe
   A6x4xflLfsfLONcVgps+KMWr6PEhUtXgoOjcmRGOjhsFoQ9rEALierxmw
   A==;
X-CSE-ConnectionGUID: 7x0fUhxsQwifPB1HM/rx7A==
X-CSE-MsgGUID: kbb9mgdNQAGyiTpBXoKIBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="68475551"
X-IronPort-AV: E=Sophos;i="6.15,207,1739865600"; 
   d="scan'208";a="68475551"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 22:13:33 -0700
X-CSE-ConnectionGUID: A6E1CernRsSCee5lSouLyg==
X-CSE-MsgGUID: wYG4gOkTSF2ExC80wb2LZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,207,1739865600"; 
   d="scan'208";a="129342278"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Apr 2025 22:13:32 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3TBJ-000BaE-36;
	Sat, 12 Apr 2025 05:13:29 +0000
Date: Sat, 12 Apr 2025 13:12:46 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] btrfs: make btrfs_truncate_block() zero folio range
 for certain subpage corner cases
Message-ID: <202504121224.JBBIEqsn-lkp@intel.com>
References: <d66c922e591b3a57a230ca357b9085fe6ae53812.1744344865.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d66c922e591b3a57a230ca357b9085fe6ae53812.1744344865.git.wqu@suse.com>

Hi Qu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.15-rc1 next-20250411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-make-btrfs_truncate_block-to-zero-involved-blocks-in-a-folio/20250411-131525
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/d66c922e591b3a57a230ca357b9085fe6ae53812.1744344865.git.wqu%40suse.com
patch subject: [PATCH 2/2] btrfs: make btrfs_truncate_block() zero folio range for certain subpage corner cases
config: arm-randconfig-002-20250412 (https://download.01.org/0day-ci/archive/20250412/202504121224.JBBIEqsn-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250412/202504121224.JBBIEqsn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504121224.JBBIEqsn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:27:0,
                    from include/linux/cpumask.h:11,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from include/linux/crypto.h:15,
                    from include/crypto/hash.h:12,
                    from fs/btrfs/inode.c:6:
   fs/btrfs/inode.c: In function 'zero_range_folio':
>> include/linux/math.h:15:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    #define __round_mask(x, y) ((__typeof__(x))((y)-1))
                                ^
   include/linux/math.h:35:34: note: in expansion of macro '__round_mask'
    #define round_down(x, y) ((x) & ~__round_mask(x, y))
                                     ^~~~~~~~~~~~
   fs/btrfs/inode.c:4843:16: note: in expansion of macro 'round_down'
     block_start = round_down(clamp_start, block_size);
                   ^~~~~~~~~~
>> include/linux/math.h:15:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    #define __round_mask(x, y) ((__typeof__(x))((y)-1))
                                ^
   include/linux/math.h:25:36: note: in expansion of macro '__round_mask'
    #define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
                                       ^~~~~~~~~~~~
   fs/btrfs/inode.c:4844:14: note: in expansion of macro 'round_up'
     block_end = round_up(clamp_end + 1, block_size) - 1;
                 ^~~~~~~~


vim +15 include/linux/math.h

aa6159ab99a9ab Andy Shevchenko 2020-12-15   8  
aa6159ab99a9ab Andy Shevchenko 2020-12-15   9  /*
aa6159ab99a9ab Andy Shevchenko 2020-12-15  10   * This looks more complex than it should be. But we need to
aa6159ab99a9ab Andy Shevchenko 2020-12-15  11   * get the type for the ~ right in round_down (it needs to be
aa6159ab99a9ab Andy Shevchenko 2020-12-15  12   * as wide as the result!), and we want to evaluate the macro
aa6159ab99a9ab Andy Shevchenko 2020-12-15  13   * arguments just once each.
aa6159ab99a9ab Andy Shevchenko 2020-12-15  14   */
aa6159ab99a9ab Andy Shevchenko 2020-12-15 @15  #define __round_mask(x, y) ((__typeof__(x))((y)-1))
aa6159ab99a9ab Andy Shevchenko 2020-12-15  16  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

