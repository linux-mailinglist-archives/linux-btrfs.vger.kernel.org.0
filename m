Return-Path: <linux-btrfs+bounces-13541-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AF0AA473C
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 11:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F847AC999
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 09:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9E21E51FF;
	Wed, 30 Apr 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6Z8KoDi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBFF1EA7C8
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005399; cv=none; b=Rglws41J5lxW/a/rLmgRiQWNAw+B+VJ+HtSX7rWzybTeLTgEVAHnsGQMx+g5zMTTYd4DhhRgXkifabNck+bEUSQT4xxotTodMntsz5OiXRhvL9MU9A6/JymW+1Ku88mKlzdVUumeufYuKTAx+aeXNlhH0fyPAF+ACJ1jEFYzUMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005399; c=relaxed/simple;
	bh=6y/EpfSEDdajxjmm4bNOX9LSI3yJ3eDuX1zKegdrzLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmvzVlKBSoGRVJVyCVb0qPMminnhy7g8AqKWKxsLkEjL46CeqpQhl1VMvzsbgLfwa41fXfbJ1haip/4PXi38jhyDugTTcWaaFmoynSfE4re6Ebl+r72p2mI+aA89G+iGvO9XDd1r5ZP4+k3QAmrcl3O+Bf4feekA86HIZ9N3ltE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6Z8KoDi; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746005398; x=1777541398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6y/EpfSEDdajxjmm4bNOX9LSI3yJ3eDuX1zKegdrzLY=;
  b=Q6Z8KoDipP+UyIvLnLGZxFiT8s+y212MngivV4Rsd6x85xf2f0ZP+vYn
   MfBArHPLSc07OxAktx+CM4JXsRglsKn0miIo8CmB9/SqFPuqgvzUXIKdc
   LH6iEtKP3/lFtJj7WWDZ5eUWW2alJ2XqUtbrR0cbSOm2KPIr0FM2S985h
   otO5dfFURfDxzxLYboSeVPkdGvemLbD2OJQFC/jGLBR8JWpmu56jj79Sl
   mkWa5+AMjDM+/2RGXIyg7zm806pde9+UXRtPn99lmd22jEXDGBs4Pbocg
   yl227MuEa6FvpZcFFQJpt9chrOZDUOrakRPg0Mp8kzddQkYQJQjf+x4wh
   Q==;
X-CSE-ConnectionGUID: 6KD7RBPySWC9l47LXZ3PVA==
X-CSE-MsgGUID: tMgF3NeqR4OtnGjvWjMa+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="59033764"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="59033764"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 02:29:57 -0700
X-CSE-ConnectionGUID: rLL55U8PTMaQabuWIvWqAQ==
X-CSE-MsgGUID: EoFLqSMNSPq7QJ1tNCxd2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134016536"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 30 Apr 2025 02:29:55 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uA3lJ-0003Lx-1r;
	Wed, 30 Apr 2025 09:29:53 +0000
Date: Wed, 30 Apr 2025 17:28:45 +0800
From: kernel test robot <lkp@intel.com>
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: send: remove btrfs_debug() calls
Message-ID: <202504301726.KJfSXyNW-lkp@intel.com>
References: <20250429085349.2169622-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429085349.2169622-1-dsterba@suse.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.15-rc4 next-20250429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Sterba/btrfs-send-remove-btrfs_debug-calls/20250429-165603
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20250429085349.2169622-1-dsterba%40suse.com
patch subject: [PATCH] btrfs: send: remove btrfs_debug() calls
config: arc-randconfig-001-20250430 (https://download.01.org/0day-ci/archive/20250430/202504301726.KJfSXyNW-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250430/202504301726.KJfSXyNW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504301726.KJfSXyNW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/btrfs/send.c: In function 'send_rename':
>> fs/btrfs/send.c:819:31: warning: unused variable 'fs_info' [-Wunused-variable]
     819 |         struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
         |                               ^~~~~~~
   fs/btrfs/send.c: In function 'send_link':
   fs/btrfs/send.c:841:31: warning: unused variable 'fs_info' [-Wunused-variable]
     841 |         struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
         |                               ^~~~~~~
   fs/btrfs/send.c: In function 'send_unlink':
   fs/btrfs/send.c:862:31: warning: unused variable 'fs_info' [-Wunused-variable]
     862 |         struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
         |                               ^~~~~~~
   fs/btrfs/send.c: In function 'send_rmdir':
   fs/btrfs/send.c:882:31: warning: unused variable 'fs_info' [-Wunused-variable]
     882 |         struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
         |                               ^~~~~~~
   fs/btrfs/send.c: In function 'find_extent_clone':
>> fs/btrfs/send.c:1568:13: warning: variable 'logical' set but not used [-Wunused-but-set-variable]
    1568 |         u64 logical;
         |             ^~~~~~~
   fs/btrfs/send.c: In function 'send_truncate':
   fs/btrfs/send.c:2620:31: warning: unused variable 'fs_info' [-Wunused-variable]
    2620 |         struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
         |                               ^~~~~~~
   fs/btrfs/send.c: In function 'send_chmod':
   fs/btrfs/send.c:2645:31: warning: unused variable 'fs_info' [-Wunused-variable]
    2645 |         struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
         |                               ^~~~~~~
   fs/btrfs/send.c: In function 'send_fileattr':
   fs/btrfs/send.c:2670:31: warning: unused variable 'fs_info' [-Wunused-variable]
    2670 |         struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
         |                               ^~~~~~~
   fs/btrfs/send.c: In function 'send_chown':
   fs/btrfs/send.c:2698:31: warning: unused variable 'fs_info' [-Wunused-variable]
    2698 |         struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
         |                               ^~~~~~~
   fs/btrfs/send.c: In function 'send_utimes':
   fs/btrfs/send.c:2724:31: warning: unused variable 'fs_info' [-Wunused-variable]
    2724 |         struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
         |                               ^~~~~~~
   fs/btrfs/send.c: In function 'send_create_inode':
   fs/btrfs/send.c:2839:31: warning: unused variable 'fs_info' [-Wunused-variable]
    2839 |         struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
         |                               ^~~~~~~
   fs/btrfs/send.c: In function 'send_write':
   fs/btrfs/send.c:5308:31: warning: unused variable 'fs_info' [-Wunused-variable]
    5308 |         struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
         |                               ^~~~~~~


vim +/fs_info +819 fs/btrfs/send.c

31db9f7c23fbf7e Alexander Block 2012-07-25  812  
31db9f7c23fbf7e Alexander Block 2012-07-25  813  /*
31db9f7c23fbf7e Alexander Block 2012-07-25  814   * Sends a move instruction to user space
31db9f7c23fbf7e Alexander Block 2012-07-25  815   */
31db9f7c23fbf7e Alexander Block 2012-07-25  816  static int send_rename(struct send_ctx *sctx,
31db9f7c23fbf7e Alexander Block 2012-07-25  817  		     struct fs_path *from, struct fs_path *to)
31db9f7c23fbf7e Alexander Block 2012-07-25  818  {
04ab956ee69cdbe Jeff Mahoney    2016-09-20 @819  	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
31db9f7c23fbf7e Alexander Block 2012-07-25  820  	int ret;
31db9f7c23fbf7e Alexander Block 2012-07-25  821  
31db9f7c23fbf7e Alexander Block 2012-07-25  822  	ret = begin_cmd(sctx, BTRFS_SEND_C_RENAME);
31db9f7c23fbf7e Alexander Block 2012-07-25  823  	if (ret < 0)
264515c7cb62661 Filipe Manana   2025-02-20  824  		return ret;
31db9f7c23fbf7e Alexander Block 2012-07-25  825  
31db9f7c23fbf7e Alexander Block 2012-07-25  826  	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, from);
31db9f7c23fbf7e Alexander Block 2012-07-25  827  	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH_TO, to);
31db9f7c23fbf7e Alexander Block 2012-07-25  828  
31db9f7c23fbf7e Alexander Block 2012-07-25  829  	ret = send_cmd(sctx);
31db9f7c23fbf7e Alexander Block 2012-07-25  830  
31db9f7c23fbf7e Alexander Block 2012-07-25  831  tlv_put_failure:
31db9f7c23fbf7e Alexander Block 2012-07-25  832  	return ret;
31db9f7c23fbf7e Alexander Block 2012-07-25  833  }
31db9f7c23fbf7e Alexander Block 2012-07-25  834  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

