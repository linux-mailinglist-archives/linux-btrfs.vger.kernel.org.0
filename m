Return-Path: <linux-btrfs+bounces-18375-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E344FC1273E
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 02:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDF25E318E
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 00:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB67829D29D;
	Tue, 28 Oct 2025 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYtAjXNn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8484029CB3C
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Oct 2025 00:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612811; cv=none; b=TJaHN+d23DgGnZGd5XQ2COr+WStLdabHoZMW5Rn/PF2qMwWL74piWhnAAHfFfWJC8lGbrLMKAyKlXkngXEtyGuz+LRlk3rLSAmJNj0l06wBZrMiK2+fi6i3Gm5DIv2RSELXew6VVZnw18auD2h1vcIAp851gLvjJ5EtRhfzoW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612811; c=relaxed/simple;
	bh=2qTE1R31oXV8vSNiGcaYAHJTgjgp5WkoT/pKVFgWvco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJbC95L7GWzL25c6m8buziDuHDdSD+B/0348FGemKyDwNvzIIeOmmoqOoAAx6xBT7/hOsk53NUrK3gtYhyalznPBm0loGSFCUi2xXVWxORTGfaiVnwV+rwHiTNAeuuphgv5AlKhzva03/GMhYR9GY6asZh38mYcreET0JPO/egk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYtAjXNn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761612810; x=1793148810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2qTE1R31oXV8vSNiGcaYAHJTgjgp5WkoT/pKVFgWvco=;
  b=nYtAjXNnIB2gAXvKbGDlvyl4SiNnFnBIgVN04SdNJbPLVPun5f+pxNyQ
   jSYOB1PTgft+2Txp+SyYuHWoXJn9rRhEgeMaHY/NnrNl2Va/iCgEkYrkh
   z/N0Vku9lvQDIZd2k8Cm/lUsqbt1gqPTbdXUgJ54RKVohjr7VOMtsxXuk
   ETtUnQH2nKysEE0bPlmXLHj/P3jvig5lW8zU0fEVcbMyhbLAwh44Eab3e
   0bIdB6Dgxyaao7miMT/0xGiMaHs+eOt5hNDHoPQtv54wWBhp0kxh8sNyF
   brxKqKau2aTEJgD4bnCmCPEh6GIi0aXAa7bFAzJ/D6kMYuQ4+fmCxuQPz
   Q==;
X-CSE-ConnectionGUID: GzUbQ4m0T3Gi4u4MM/ZDrQ==
X-CSE-MsgGUID: +pCXSrc9TwqoUgm+vGpiPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73991531"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="73991531"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 17:53:29 -0700
X-CSE-ConnectionGUID: 0rbiwMPeQfScfEBv8C16pw==
X-CSE-MsgGUID: DVCPYMwAS5yQ+p7PaIFsYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="185659700"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 27 Oct 2025 17:53:28 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDXxj-000Ic5-0x;
	Tue, 28 Oct 2025 00:53:23 +0000
Date: Tue, 28 Oct 2025 08:52:19 +0800
From: kernel test robot <lkp@intel.com>
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 2/2] btrfs: zoned: fix stripe width calculation
Message-ID: <202510280859.KwBFlqRE-lkp@intel.com>
References: <20251027072758.1066720-3-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027072758.1066720-3-naohiro.aota@wdc.com>

Hi Naohiro,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.18-rc3 next-20251027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Naohiro-Aota/btrfs-zoned-fix-zone-capacity-calculation/20251027-153738
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20251027072758.1066720-3-naohiro.aota%40wdc.com
patch subject: [PATCH 2/2] btrfs: zoned: fix stripe width calculation
config: i386-buildonly-randconfig-006-20251028 (https://download.01.org/0day-ci/archive/20251028/202510280859.KwBFlqRE-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251028/202510280859.KwBFlqRE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510280859.KwBFlqRE-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__udivmoddi4" [fs/btrfs/btrfs.ko] undefined!
ERROR: modpost: "__udivdi3" [drivers/power/supply/intel_dc_ti_battery.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

