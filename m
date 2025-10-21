Return-Path: <linux-btrfs+bounces-18131-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F183BF8E18
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 23:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B9F84353B3E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 21:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D70283FE6;
	Tue, 21 Oct 2025 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gn7gFGp3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA40C27FB37;
	Tue, 21 Oct 2025 21:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080629; cv=none; b=PMHUdxFvCAmIKJyW7BFNCxSaNi76SCJmygi8ii+UC4aZv+xIUU2wsmmnBbW9oUIvcpXKzh8MM62zGFjhgxZXBtxy13TQ2CIagGhYDznjQ1bkagC7nIo7oKQpvI6xyqQ2CT9A5NthaNnTkCZZq42wfZUZrgYLRI5nFspxYuaQyb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080629; c=relaxed/simple;
	bh=A2PKvR7e+pZtDb3gMM04hEAucxjpFWItO+4Ume5Cakg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEdW0Vygt0JwWpJZp75TYO0RBND+27yYYiTEP8LiUuMGVGjqP7u6fqTv52p6HSD5gheX2diOcVGe7LTAuz5x3JwmOYFJzS7/XwKlCY8jLdK1vY3WRO+2UzWEHDB3Oku6unMh1ARJ8fWoF1+EsvwWyFqtECRlf+tUwnFQje3tITs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gn7gFGp3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761080627; x=1792616627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A2PKvR7e+pZtDb3gMM04hEAucxjpFWItO+4Ume5Cakg=;
  b=gn7gFGp3n0NJAcQ2ZTcLS3HXsxw/t97vtDKWwCu9uqPwgnhj75oOkk0H
   qLTTyPRx1oLYshLCI6FT9Uyc8IPPasKuq+5rPyHu4fNiU2ppRn5PgMJFp
   Cad41kQL5UzFKKeOPiOlJhlsJCogHenTxyhUQGWcSsYG488QmvAWuhVPM
   apNDcVCOFIEKW6Fk6FbHdSkKMRyBnPGh+ve4fVlDWgSkRC+MpoPPssFwe
   NtL+UQ7g44pXxfb7Uulu5HmKbG1aF3mfTg9m2RNDFVWh/wAP7y1/RSUfg
   RoQMUJIaRc8YejT61POwJAEpNwZXV2/F0HkkTr+6t6JawRAsAo4fkgpLH
   g==;
X-CSE-ConnectionGUID: VCltmATLQq+RCd7MJpmwnQ==
X-CSE-MsgGUID: EW/X3NLXRRixBcb1XBbSoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73508368"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="73508368"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 14:03:47 -0700
X-CSE-ConnectionGUID: OxV8X38sRoaJoqtsfamSQA==
X-CSE-MsgGUID: f0n4Ux9YSIi9G4S8Go7FJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="184093667"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 21 Oct 2025 14:03:45 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBJWA-000BlZ-2e;
	Tue, 21 Oct 2025 21:03:42 +0000
Date: Wed, 22 Oct 2025 05:03:41 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, dsterba@suse.com, cem@kernel.org,
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de
Cc: oe-kbuild-all@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
	Chris Mason <chris.mason@fusionio.com>
Subject: Re: [PATCH 2/2] btrfs: handle bio split errors for append
Message-ID: <202510220421.KBMIIY8p-lkp@intel.com>
References: <20251020144356.693288-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020144356.693288-2-kbusch@meta.com>

Hi Keith,

kernel test robot noticed the following build warnings:

[auto build test WARNING on xfs-linux/for-next]
[also build test WARNING on kdave/for-next linus/master v6.18-rc2 next-20251021]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/btrfs-handle-bio-split-errors-for-append/20251020-224536
base:   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git for-next
patch link:    https://lore.kernel.org/r/20251020144356.693288-2-kbusch%40meta.com
patch subject: [PATCH 2/2] btrfs: handle bio split errors for append
config: i386-buildonly-randconfig-005-20251021 (https://download.01.org/0day-ci/archive/20251022/202510220421.KBMIIY8p-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510220421.KBMIIY8p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510220421.KBMIIY8p-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from arch/x86/include/asm/current.h:5,
                    from include/linux/sched.h:12,
                    from include/linux/mempool.h:8,
                    from include/linux/bio.h:8,
                    from fs/btrfs/bio.c:7:
   fs/btrfs/bio.c: In function 'btrfs_submit_chunk':
>> include/linux/err.h:28:49: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      28 | #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
         |                                                 ^
   include/linux/compiler.h:32:55: note: in definition of macro '__branch_check__'
      32 |                         ______r = __builtin_expect(!!(x), expect);      \
         |                                                       ^
   include/linux/err.h:28:25: note: in expansion of macro 'unlikely'
      28 | #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
         |                         ^~~~~~~~
   fs/btrfs/bio.c:692:21: note: in expansion of macro 'IS_ERR_VALUE'
     692 |                 if (IS_ERR_VALUE(map_length)) {
         |                     ^~~~~~~~~~~~
>> include/linux/err.h:28:49: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      28 | #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
         |                                                 ^
   include/linux/compiler.h:34:54: note: in definition of macro '__branch_check__'
      34 |                                              expect, is_constant);      \
         |                                                      ^~~~~~~~~~~
   include/linux/err.h:28:25: note: in expansion of macro 'unlikely'
      28 | #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
         |                         ^~~~~~~~
   fs/btrfs/bio.c:692:21: note: in expansion of macro 'IS_ERR_VALUE'
     692 |                 if (IS_ERR_VALUE(map_length)) {
         |                     ^~~~~~~~~~~~


vim +28 include/linux/err.h

ebba5f9fcb88230 Randy Dunlap   2006-09-27  21  
4d744ce9d5d7cf0 James Seo      2023-05-09  22  /**
4d744ce9d5d7cf0 James Seo      2023-05-09  23   * IS_ERR_VALUE - Detect an error pointer.
4d744ce9d5d7cf0 James Seo      2023-05-09  24   * @x: The pointer to check.
4d744ce9d5d7cf0 James Seo      2023-05-09  25   *
4d744ce9d5d7cf0 James Seo      2023-05-09  26   * Like IS_ERR(), but does not generate a compiler warning if result is unused.
4d744ce9d5d7cf0 James Seo      2023-05-09  27   */
aa00edc1287a693 Linus Torvalds 2016-05-27 @28  #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
07ab67c8d0d7c10 Linus Torvalds 2005-05-19  29  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

