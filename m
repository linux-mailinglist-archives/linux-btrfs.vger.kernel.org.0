Return-Path: <linux-btrfs+bounces-5978-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1F2917539
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 02:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05672284766
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 00:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726879474;
	Wed, 26 Jun 2024 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="amvvYWmq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157131FDD
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 00:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719361523; cv=none; b=o6fdu5t7p0rb1bZZt6UFy8ihJmwwMb2cbjG5qrMWYy1zhrRW4cpvvQ91b/QjNdkjZZ54bxxaAEVaWNemJNDCRAUEMGLHE5oX2xQHJCWJSPCSkKHvJuAabpFRKjYuucgxDZuQ1Ua1RJ02ujyMN/BAzsGgtVmsfRxLQh1wOJcjoec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719361523; c=relaxed/simple;
	bh=DMGdf2Hjct7n86GfjLZF82YoQjkFd0wZ1mtuIwsi27U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sABgEJKxriDUslPl9BThbDzhyHYd03Zh7Y7ELy/ButCKfxL3SNnoTXhouVGLaKTfcXNOe9uc8JnNIfFfMvpkWHaXirk5HBYaS4QeJs1b0VDjtUTgff/s1xR6xov40bAbMut3JGGfXO/HIVmdz46iYMOvHmxE7XTqy14FSpKVF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=amvvYWmq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719361522; x=1750897522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DMGdf2Hjct7n86GfjLZF82YoQjkFd0wZ1mtuIwsi27U=;
  b=amvvYWmq0Op0a57JCdm/kQznXtCErWM//UzxDWazpdxBN+W5gdmmaGVT
   aazyvITAYfHFe1LpDiPLdx7WTBl0dgJTdwm6gxu10eVRmNtW0jomgjYed
   BjRC+hB+lm/6dxz+k279zLqXaW4SizsiATG2jpQAnLoKdoS8U4JO4AgX4
   Notz26x8dhOEzckzBnw/y5rvHLPhtCTJkplsUKCn+II2Fdf5NtyimSEDJ
   LPqrjeymbcH9qPAGdnUhxt4BRtxKHU9ahQTnzJ+bsVtd9/hZrgx7pEVAC
   qH8FSCQ/GyxvFjiq3WHJZggWh9/J0HiPXjnMp/G6KsGCav/S/C2sCQofZ
   w==;
X-CSE-ConnectionGUID: /Yxgt9/8SsGr41sM/I1O2w==
X-CSE-MsgGUID: muY3gjb5T6C3dJqtXbrj5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16092151"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="16092151"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 17:25:21 -0700
X-CSE-ConnectionGUID: 2VsMBAceSEySrlkOcZKcUw==
X-CSE-MsgGUID: atrnndvTSPuJXOcf4647MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="44472864"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 25 Jun 2024 17:25:19 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMGTM-000Epq-1A;
	Wed, 26 Jun 2024 00:25:16 +0000
Date: Wed, 26 Jun 2024 08:24:42 +0800
From: kernel test robot <lkp@intel.com>
To: Hongbo Li <lihongbo22@huawei.com>, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com
Cc: oe-kbuild-all@lists.linux.dev, linux-btrfs@vger.kernel.org,
	lihongbo22@huawei.com
Subject: Re: [PATCH] btrfs: support STATX_DIOALIGN for statx
Message-ID: <202406260839.lNfzNan4-lkp@intel.com>
References: <20240620132000.888494-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620132000.888494-1-lihongbo22@huawei.com>

Hi Hongbo,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.10-rc5 next-20240625]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongbo-Li/btrfs-support-STATX_DIOALIGN-for-statx/20240625-141147
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20240620132000.888494-1-lihongbo22%40huawei.com
patch subject: [PATCH] btrfs: support STATX_DIOALIGN for statx
config: i386-randconfig-015-20240626 (https://download.01.org/0day-ci/archive/20240626/202406260839.lNfzNan4-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406260839.lNfzNan4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406260839.lNfzNan4-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/btrfs/inode.c: In function 'btrfs_getattr':
   fs/btrfs/inode.c:8561:3: error: unknown type name 'btrfs_fs_info'; use 'struct' keyword to refer to the type
      btrfs_fs_info *fs_info = inode_to_fs_info(inode);
      ^~~~~~~~~~~~~
      struct 
   In file included from fs/btrfs/ctree.h:20:0,
                    from fs/btrfs/inode.c:38:
>> fs/btrfs/fs.h:882:34: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    #define inode_to_fs_info(_inode) (BTRFS_I(_Generic((_inode),   \
                                     ^
   fs/btrfs/inode.c:8561:28: note: in expansion of macro 'inode_to_fs_info'
      btrfs_fs_info *fs_info = inode_to_fs_info(inode);
                               ^~~~~~~~~~~~~~~~
   fs/btrfs/inode.c:8562:38: error: request for member 'fs_devices' in something not a structure or union
      struct block_device *bdev = fs_info->fs_devices->latest_dev->bdev;
                                         ^~
   In file included from arch/x86/include/asm/atomic.h:5:0,
                    from include/linux/atomic.h:7,
                    from include/crypto/hash.h:11,
                    from fs/btrfs/inode.c:6:
   fs/btrfs/inode.c:8566:11: error: request for member 'sectorsize' in something not a structure or union
       fs_info->sectorsize);
              ^
   include/linux/compiler.h:284:48: note: in definition of macro '__is_constexpr'
     (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
                                                   ^
   include/linux/minmax.h:169:27: note: in expansion of macro '__careful_cmp'
    #define max_t(type, x, y) __careful_cmp(max, (type)(x), (type)(y))
                              ^~~~~~~~~~~~~
   fs/btrfs/inode.c:8565:25: note: in expansion of macro 'max_t'
      stat->dio_mem_align = max_t(u32, (bdev_dma_alignment(bdev) + 1),
                            ^~~~~
   In file included from include/linux/kernel.h:28:0,
                    from include/linux/cpumask.h:11,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from include/linux/crypto.h:15,
                    from include/crypto/hash.h:12,
                    from fs/btrfs/inode.c:6:
   fs/btrfs/inode.c:8566:11: error: request for member 'sectorsize' in something not a structure or union
       fs_info->sectorsize);
              ^
   include/linux/minmax.h:46:45: note: in definition of macro '__cmp'
    #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
                                                ^
   include/linux/minmax.h:169:27: note: in expansion of macro '__careful_cmp'
    #define max_t(type, x, y) __careful_cmp(max, (type)(x), (type)(y))
                              ^~~~~~~~~~~~~
   fs/btrfs/inode.c:8565:25: note: in expansion of macro 'max_t'
      stat->dio_mem_align = max_t(u32, (bdev_dma_alignment(bdev) + 1),
                            ^~~~~
   fs/btrfs/inode.c:8566:11: error: request for member 'sectorsize' in something not a structure or union
       fs_info->sectorsize);
              ^
   include/linux/minmax.h:46:57: note: in definition of macro '__cmp'
    #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
                                                            ^
   include/linux/minmax.h:169:27: note: in expansion of macro '__careful_cmp'
    #define max_t(type, x, y) __careful_cmp(max, (type)(x), (type)(y))
                              ^~~~~~~~~~~~~
   fs/btrfs/inode.c:8565:25: note: in expansion of macro 'max_t'
      stat->dio_mem_align = max_t(u32, (bdev_dma_alignment(bdev) + 1),
                            ^~~~~
   fs/btrfs/inode.c:8566:11: error: request for member 'sectorsize' in something not a structure or union
       fs_info->sectorsize);
              ^
   include/linux/minmax.h:50:9: note: in definition of macro '__cmp_once'
     typeof(y) unique_y = (y);   \
            ^
   include/linux/minmax.h:169:27: note: in expansion of macro '__careful_cmp'
    #define max_t(type, x, y) __careful_cmp(max, (type)(x), (type)(y))
                              ^~~~~~~~~~~~~
   fs/btrfs/inode.c:8565:25: note: in expansion of macro 'max_t'
      stat->dio_mem_align = max_t(u32, (bdev_dma_alignment(bdev) + 1),
                            ^~~~~
   fs/btrfs/inode.c:8566:11: error: request for member 'sectorsize' in something not a structure or union
       fs_info->sectorsize);
              ^
   include/linux/minmax.h:50:24: note: in definition of macro '__cmp_once'
     typeof(y) unique_y = (y);   \
                           ^
   include/linux/minmax.h:169:27: note: in expansion of macro '__careful_cmp'
    #define max_t(type, x, y) __careful_cmp(max, (type)(x), (type)(y))
                              ^~~~~~~~~~~~~
   fs/btrfs/inode.c:8565:25: note: in expansion of macro 'max_t'
      stat->dio_mem_align = max_t(u32, (bdev_dma_alignment(bdev) + 1),
                            ^~~~~
   In file included from include/linux/atomic/atomic-instrumented.h:15:0,
                    from include/linux/atomic.h:82,
                    from include/crypto/hash.h:11,
                    from fs/btrfs/inode.c:6:
   fs/btrfs/inode.c:8566:11: error: request for member 'sectorsize' in something not a structure or union
       fs_info->sectorsize);
              ^
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
    #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                           ^~~~
   include/linux/minmax.h:51:2: note: in expansion of macro 'static_assert'
     static_assert(__types_ok(x, y),   \
     ^~~~~~~~~~~~~
   include/linux/minmax.h:31:24: note: in expansion of macro '__is_constexpr'
     __builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))), \
                           ^~~~~~~~~~~~~~
   include/linux/minmax.h:31:39: note: in expansion of macro 'is_signed_type'
     __builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))), \


vim +882 fs/btrfs/fs.h

b33d2e535f9b2a David Sterba 2023-09-14  881  
41044b41ad2c8c David Sterba 2023-09-14 @882  #define inode_to_fs_info(_inode) (BTRFS_I(_Generic((_inode),			\
41044b41ad2c8c David Sterba 2023-09-14  883  					   struct inode *: (_inode)))->root->fs_info)
41044b41ad2c8c David Sterba 2023-09-14  884  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

