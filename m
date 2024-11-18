Return-Path: <linux-btrfs+bounces-9745-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8639D0A59
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2024 08:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D412B227F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2024 07:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F641494BF;
	Mon, 18 Nov 2024 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cm5j7rSS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED39E81745
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2024 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731915330; cv=none; b=Hak5KdCoXbJPErqe5skuV5m2dQVHlRLu5w8Sn10iFqjJjvpWa+qN/ju5Hg2QJsf3SR22tqaA2fucHMTZf5d/XsnDAR5GQf/iKh1OswVeI8Wj4QRY0b4H2YZTAf2XTbk8EcpbCT5wDmDoDZzSN8z4R5XYwrEtrWXDyNScf7ceQx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731915330; c=relaxed/simple;
	bh=ksPBSllEouqrr99MKLP7FFwbh+zo5Mu1lXVfcYTeK+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaCAWhxDgf8f3r4RgrnKD9JCGS69umRqAiqocA6CHOvdic4FD8P8XDuBrsiDOcRzysC9uOyb/I1oszvPnujJh6vTgfT7qi0uDWIu+Ncfuprv5ngj8g1umiyfzOoBA+eaIdkMiU5j1t1xhfdLDamTBeUPkUTY68jAugOmk1IpbDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cm5j7rSS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731915327; x=1763451327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ksPBSllEouqrr99MKLP7FFwbh+zo5Mu1lXVfcYTeK+4=;
  b=Cm5j7rSSj6gkIvR6/jtJQjIipWWbJrbCRDRIxEhVhMePH+m9pvqJiuC5
   FeapFPwae9wrgS5lbuPlsk3vLLTAAWh2BRrJVsUDTj/9I6ebBKLcAgkna
   KhGaBS6aXC0sBcGfZQWZqb3E9X0eXIdpJC0pVqwm6SpjO8cQ7qDg0vTJo
   ufgOkuS6AWjtb0HeCMU7O2XmRDmtW1dbrjw88JjgKTZ4JBiMIO7ljMUW2
   mWRhbg4URV01zlHf201AtuKiWr32UtzgkkFqxXiIrFe2jJ3sO52yFovZ5
   v7qPMJCHqB42xuRtuX+Na+Q9VMRarj3IrlrhG7ptUodW0dUD1BLepXLDJ
   w==;
X-CSE-ConnectionGUID: OvZ6OwjHTiap0Cu00cQJQA==
X-CSE-MsgGUID: ltL0UYHqSp6i4azdGbPvzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="31912851"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="31912851"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 23:35:26 -0800
X-CSE-ConnectionGUID: OJhChfJXTgKwwFPVaVsNwQ==
X-CSE-MsgGUID: /LABZ+NBRoOoINcVyFbAIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="89572133"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Nov 2024 23:35:24 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCwI6-0002K1-03;
	Mon, 18 Nov 2024 07:35:22 +0000
Date: Mon, 18 Nov 2024 15:34:46 +0800
From: kernel test robot <lkp@intel.com>
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dsterba@suse.com, wqu@suse.com,
	hrx@bupt.moe, waxhead@dirtcellar.net
Subject: Re: [PATCH v3 05/10] btrfs: introduce RAID1 round-robin read
 balancing
Message-ID: <202411181508.CyjUUrnX-lkp@intel.com>
References: <995d4a9dd9f553825805efdac24dec4a9de20ef3.1731076425.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <995d4a9dd9f553825805efdac24dec4a9de20ef3.1731076425.git.anand.jain@oracle.com>

Hi Anand,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on next-20241115]
[cannot apply to linus/master v6.12]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Jain/btrfs-initialize-fs_devices-fs_info-earlier/20241116-230928
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/995d4a9dd9f553825805efdac24dec4a9de20ef3.1731076425.git.anand.jain%40oracle.com
patch subject: [PATCH v3 05/10] btrfs: introduce RAID1 round-robin read balancing
config: m68k-randconfig-r113-20241117 (https://download.01.org/0day-ci/archive/20241118/202411181508.CyjUUrnX-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241118/202411181508.CyjUUrnX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411181508.CyjUUrnX-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: fs/btrfs/sysfs.o: in function `btrfs_read_policy_store':
>> sysfs.c:(.text+0x197a): undefined reference to `__moddi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

