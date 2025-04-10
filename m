Return-Path: <linux-btrfs+bounces-12948-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0867A846BC
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 16:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C9977AE0C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 14:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2030628EA79;
	Thu, 10 Apr 2025 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XfpNn7y+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5493C28D82F;
	Thu, 10 Apr 2025 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296318; cv=none; b=SIBx+l2g5EYrqAn1h6FiTZolFZkradm+XX1O0nGsdsfNYNivo6pdcki8jCpTE+CdXaBaO6AOoGnzCWQZbVjHmxi2m0/V2OULg6dPwn6KoZIuBfz5e8sfy9p0dQBABRk0wWaROc7v+KoNbFJXZcm9TF7yVDbYOljvlnsmnFzOTAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296318; c=relaxed/simple;
	bh=Rd0GdhKleD8jAQfmJsnk5dtpLd/M+3nzHuU2sLt272Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQ2bC94RrV7upY6MwsUeN1anEYJR99B8xQrdpVDAHdHHACGQ3R5i4Yo5juInbC0NlzMJ9M9pq8NV0DuEO9LWMkGSSuHsPTtPvZ4UcF9NDZJvhA9jm0UIFDrn4skYw1WOgRqGI5K9yddHvQKCsXJe0nf1x+xkphnoke+1uXKhKxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XfpNn7y+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744296317; x=1775832317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rd0GdhKleD8jAQfmJsnk5dtpLd/M+3nzHuU2sLt272Y=;
  b=XfpNn7y+4gen2/R8hSTsDzE241rnxAfuuDbw8pBf/U3socI1FyeovBGm
   SiXnViCxWMXe6A1c+Pcr3MG5HwCqKTRNxZfBd8PkfS4kqDRzE21nODczc
   vuYCMKQii58jmjwP78YiOROQnx8T0R2ZF6B9wJlZ8zhutPz67m4cZU7Zr
   wbvxhjllrdYzJs+L6I/8FaWh9E7DLh4TX9Blwkmu1+okNGXCNatMRz12E
   Cxq5Zt7PKWDxdSvKqkVyhMXVrmjTqQRQDAsdjaQLxti8U1Fpo/sYibf0X
   LvoF2Yo6Ph3siccD4rn39gwWjUbxxGttbdQI5onA+ApFqpA2Wetwe0XDc
   A==;
X-CSE-ConnectionGUID: z3Ex0EVySImneUK9CZrqIg==
X-CSE-MsgGUID: UqPg4gc9RSO1GyTJMJ8R3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45835440"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="45835440"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 07:45:16 -0700
X-CSE-ConnectionGUID: XK/RRletSjyDVCwKAe+WiQ==
X-CSE-MsgGUID: k0vqAbm6TsyiMBHeZkytrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="133041348"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 10 Apr 2025 07:45:13 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2t9T-000ABL-0a;
	Thu, 10 Apr 2025 14:45:11 +0000
Date: Thu, 10 Apr 2025 22:45:03 +0800
From: kernel test robot <lkp@intel.com>
To: Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH 2/2] btrfs: convert to mutex guard in
 btrfs_ioctl_balance_progress()
Message-ID: <202504102206.gpAU9chA-lkp@intel.com>
References: <20250409125724.145597-2-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409125724.145597-2-frank.li@vivo.com>

Hi Yangtao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.15-rc1 next-20250410]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yangtao-Li/btrfs-convert-to-mutex-guard-in-btrfs_ioctl_balance_progress/20250409-204204
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20250409125724.145597-2-frank.li%40vivo.com
patch subject: [PATCH 2/2] btrfs: convert to mutex guard in btrfs_ioctl_balance_progress()
config: arm-randconfig-001-20250410 (https://download.01.org/0day-ci/archive/20250410/202504102206.gpAU9chA-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250410/202504102206.gpAU9chA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504102206.gpAU9chA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/btrfs/ioctl.c:3639:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    3639 |         if (copy_to_user(arg, bargs, sizeof(*bargs)))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/ioctl.c:3644:9: note: uninitialized use occurs here
    3644 |         return ret;
         |                ^~~
   fs/btrfs/ioctl.c:3639:2: note: remove the 'if' if its condition is always true
    3639 |         if (copy_to_user(arg, bargs, sizeof(*bargs)))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    3640 |                 ret = -EFAULT;
   fs/btrfs/ioctl.c:3623:9: note: initialize the variable 'ret' to silence this warning
    3623 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +3639 fs/btrfs/ioctl.c

837d5b6e46d1a4 Ilya Dryomov 2012-01-16  3618  
2ff7e61e0d30ff Jeff Mahoney 2016-06-22  3619  static long btrfs_ioctl_balance_progress(struct btrfs_fs_info *fs_info,
19a39dce3b9bf0 Ilya Dryomov 2012-01-16  3620  					 void __user *arg)
19a39dce3b9bf0 Ilya Dryomov 2012-01-16  3621  {
19a39dce3b9bf0 Ilya Dryomov 2012-01-16  3622  	struct btrfs_ioctl_balance_args *bargs;
68395a7bf00486 Yangtao Li   2025-04-09  3623  	int ret;
19a39dce3b9bf0 Ilya Dryomov 2012-01-16  3624  
19a39dce3b9bf0 Ilya Dryomov 2012-01-16  3625  	if (!capable(CAP_SYS_ADMIN))
19a39dce3b9bf0 Ilya Dryomov 2012-01-16  3626  		return -EPERM;
19a39dce3b9bf0 Ilya Dryomov 2012-01-16  3627  
68395a7bf00486 Yangtao Li   2025-04-09  3628  	guard(mutex)(&fs_info->balance_mutex);
68395a7bf00486 Yangtao Li   2025-04-09  3629  
68395a7bf00486 Yangtao Li   2025-04-09  3630  	if (!fs_info->balance_ctl)
68395a7bf00486 Yangtao Li   2025-04-09  3631  		return -ENOTCONN;
19a39dce3b9bf0 Ilya Dryomov 2012-01-16  3632  
8d2db7855e7b65 David Sterba 2015-11-04  3633  	bargs = kzalloc(sizeof(*bargs), GFP_KERNEL);
68395a7bf00486 Yangtao Li   2025-04-09  3634  	if (!bargs)
68395a7bf00486 Yangtao Li   2025-04-09  3635  		return -ENOMEM;
19a39dce3b9bf0 Ilya Dryomov 2012-01-16  3636  
008ef0969dd966 David Sterba 2018-03-21  3637  	btrfs_update_ioctl_balance_args(fs_info, bargs);
19a39dce3b9bf0 Ilya Dryomov 2012-01-16  3638  
19a39dce3b9bf0 Ilya Dryomov 2012-01-16 @3639  	if (copy_to_user(arg, bargs, sizeof(*bargs)))
19a39dce3b9bf0 Ilya Dryomov 2012-01-16  3640  		ret = -EFAULT;
19a39dce3b9bf0 Ilya Dryomov 2012-01-16  3641  
19a39dce3b9bf0 Ilya Dryomov 2012-01-16  3642  	kfree(bargs);
68395a7bf00486 Yangtao Li   2025-04-09  3643  
19a39dce3b9bf0 Ilya Dryomov 2012-01-16  3644  	return ret;
19a39dce3b9bf0 Ilya Dryomov 2012-01-16  3645  }
19a39dce3b9bf0 Ilya Dryomov 2012-01-16  3646  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

