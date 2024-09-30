Return-Path: <linux-btrfs+bounces-8342-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED5A98AF17
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 23:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DCE51C21923
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 21:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200541A2C03;
	Mon, 30 Sep 2024 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5OfyoMz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688481A2559;
	Mon, 30 Sep 2024 21:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731722; cv=none; b=Xq9ZIVnAyCT6oNnoSYGnb6wTWdN2uvFTBNug3BaatSZ7IOAI6P9efuWdWYruNbhENGqn19tn+T9sOvV6LYK8t119uRnxjh9SSLy1Lfz95mElc3g9bjftvrCRie1eTxal2xyqKccsn1pEvHEwuQ2R84dwhWb7z/9APDNzXQg+jrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731722; c=relaxed/simple;
	bh=9E17lymEk6KtKuJ59Yq30OasH/9iFmcmwiud63nlNWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S59bfLtcaWYr8q2KO4grTR23Gnayxh5mYAzoSJsmOPQoUGFVdOok9NYEUmZURqC5KTwXmbupzi+Dw4mW6qBLaSA31KJSFxNiyrHXZm/oIgL4/mdCcXjhAxbftMzRdGZijU4G0u0jFfzLHJMTmOAb4/Kn7DEIt6c3/097xSiSRCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5OfyoMz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727731720; x=1759267720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9E17lymEk6KtKuJ59Yq30OasH/9iFmcmwiud63nlNWQ=;
  b=U5OfyoMzT90+V9qy1D5g4QAMeli/3rCS3aBKgRhKYCwB9Lr0YYecsSMb
   y4vEWtQAXilBYvPiSR1kZuPaLeliLC1pjTpeHVDV6D8nktwMcR1mfoMHL
   AJas2QpvpafebltIARp0FAvMxCwsdoiOgaALy/76rsFH7+SNVFMqKydXt
   ns9kuqH4zG2g8LaJKahkD98S1yJ+eQvZi/ASibVICyIU+b8Bf6tamxaav
   Qmix5t7goo8Jcn+yXkCHP/STevNwU3rXpKFtfdnOdyIqOUVVi34iTNJ+H
   u6v5pDfuzx1hIjl8GcUdOVnNIiy7SzCVgTsKxfUSq10mNyp2iAqJv33sK
   w==;
X-CSE-ConnectionGUID: Jbf4/gMfSrGz5ySSmnduPg==
X-CSE-MsgGUID: 9Hx3VsOnRRCF/89bAI513w==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="37517005"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="37517005"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 14:28:39 -0700
X-CSE-ConnectionGUID: mRsnRJanT9+iRBBLZund2Q==
X-CSE-MsgGUID: +ZB6XlJmRjmbvWEkNgwzeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73846662"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 30 Sep 2024 14:28:36 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svNwX-000Puf-2r;
	Mon, 30 Sep 2024 21:28:33 +0000
Date: Tue, 1 Oct 2024 05:27:43 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <chris.mason@fusionio.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] btrfs: tests: add selftests for RAID stripe-tree
Message-ID: <202410010421.NzGgvE6Y-lkp@intel.com>
References: <20240930104054.12290-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930104054.12290-1-jth@kernel.org>

Hi Johannes,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.12-rc1 next-20240930]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Thumshirn/btrfs-tests-add-selftests-for-RAID-stripe-tree/20240930-184234
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20240930104054.12290-1-jth%40kernel.org
patch subject: [PATCH] btrfs: tests: add selftests for RAID stripe-tree
config: i386-buildonly-randconfig-004-20241001 (https://download.01.org/0day-ci/archive/20241001/202410010421.NzGgvE6Y-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241001/202410010421.NzGgvE6Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410010421.NzGgvE6Y-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/btrfs/ioctl.c:37:
>> fs/btrfs/volumes.h:837:5: warning: "CONFIG_BTRFS_FS_RUN_SANITY_TESTS" is not defined, evaluates to 0 [-Wundef]
     837 | #if CONFIG_BTRFS_FS_RUN_SANITY_TESTS
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from fs/btrfs/relocation.c:16:
>> fs/btrfs/volumes.h:837:5: warning: "CONFIG_BTRFS_FS_RUN_SANITY_TESTS" is not defined, evaluates to 0 [-Wundef]
     837 | #if CONFIG_BTRFS_FS_RUN_SANITY_TESTS
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/btrfs/relocation.c:39:
>> fs/btrfs/raid-stripe-tree.h:31:5: warning: "CONFIG_BTRFS_FS_RUN_SANITY_TESTS" is not defined, evaluates to 0 [-Wundef]
      31 | #if CONFIG_BTRFS_FS_RUN_SANITY_TESTS
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from fs/btrfs/raid-stripe-tree.c:12:
>> fs/btrfs/raid-stripe-tree.h:31:5: warning: "CONFIG_BTRFS_FS_RUN_SANITY_TESTS" is not defined, evaluates to 0 [-Wundef]
      31 | #if CONFIG_BTRFS_FS_RUN_SANITY_TESTS
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/btrfs/raid-stripe-tree.c:13:
>> fs/btrfs/volumes.h:837:5: warning: "CONFIG_BTRFS_FS_RUN_SANITY_TESTS" is not defined, evaluates to 0 [-Wundef]
     837 | #if CONFIG_BTRFS_FS_RUN_SANITY_TESTS
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/CONFIG_BTRFS_FS_RUN_SANITY_TESTS +837 fs/btrfs/volumes.h

   836	
 > 837	#if CONFIG_BTRFS_FS_RUN_SANITY_TESTS
   838	struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
   839							u64 logical, u16 total_stripes);
   840	#endif
   841	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

