Return-Path: <linux-btrfs+bounces-15433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5023AB00FDF
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 01:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD6797AB7F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 23:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6693D2951D5;
	Thu, 10 Jul 2025 23:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lW45ncYE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C96269CF1
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191416; cv=none; b=PbzSEaNFXhEg1JsBpArbceIkBb3w2k+hsECdCYdaMAH1PeXoJhQrqU/KYLXvZiRozuCocr3vzlibdIXxYpGHQhYOkEV41aHADjV+tXTCoUuoBcJkPMoEOhVBxdPPxM2EtWnbY0oApqsuPGkwMh3GsIJnmI3Czya3JOrZf7pC1SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191416; c=relaxed/simple;
	bh=3tzl65rBO3Yv8KHYuTFmnq/R4cPrySxS8jpRI9eQ1o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2YFPglTqr6/EvTlh7oQWLYtXTcsXebnuSkIiUwFcGhNn7AsMKDWEbfTSdylD10C+9S9xpEW9kXU6F6uxuPAKQ8/RabN+Ms3SpGNT7FWNc2492hPYmXcHRImMiPdIZVClh9X03J2mtgMm6iUqen7K/UucC17nrJu5qbgecyOx8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lW45ncYE; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752191414; x=1783727414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3tzl65rBO3Yv8KHYuTFmnq/R4cPrySxS8jpRI9eQ1o4=;
  b=lW45ncYE5G/KrtzvNR7DovljqTXQ8v+oDpjwxlmwfbc7mYyzkVtbVDnh
   L0W2vtGTyWcGoT0T4hHEz61AnXPPn+vd8/KIcaKzngwknguZ8A44c3kUx
   scULcn7d3hWxc/Hhz8Y8WFM3+JdhjtFbCyiSZTfxz4yAjtuYkljQze1j4
   H3RylABTqlSIx79RnLII8ia3KDgkxxVPQtnjQ7LCzIE+/PNjqt5yLsRWs
   t4Y+YE0R36Nql1fNyRhvzx4qpB94uL9IE0HdU14h4DrdJ3jO2M46d6XRg
   eL8m7weg9i+mBszITYgqm/cV7TJftKSH5pPv00dF+pItuaNedaRq47ICg
   w==;
X-CSE-ConnectionGUID: jqCUsbYER7qGwO/EsQgC2A==
X-CSE-MsgGUID: oT43ORPkQReAloIUZ34k2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65545855"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="65545855"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 16:50:13 -0700
X-CSE-ConnectionGUID: TUQ/RxUxQP22EQzVZRqGgg==
X-CSE-MsgGUID: 63uZ9fmXRq6aqPyC7IaGUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="156944636"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2025 16:50:12 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ua11l-0005bX-2X;
	Thu, 10 Jul 2025 23:50:09 +0000
Date: Fri, 11 Jul 2025 07:49:17 +0800
From: kernel test robot <lkp@intel.com>
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, jlayton@kernel.org
Subject: Re: [PATCH] btrfs: implement ref_tracker for delayed_nodes
Message-ID: <202507110735.DbwDC17f-lkp@intel.com>
References: <fa19acf9dc38e93546183fc083c365cdb237e89b.1752098515.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa19acf9dc38e93546183fc083c365cdb237e89b.1752098515.git.loemra.dev@gmail.com>

Hi Leo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.16-rc5 next-20250710]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Leo-Martins/btrfs-implement-ref_tracker-for-delayed_nodes/20250710-060640
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/fa19acf9dc38e93546183fc083c365cdb237e89b.1752098515.git.loemra.dev%40gmail.com
patch subject: [PATCH] btrfs: implement ref_tracker for delayed_nodes
config: alpha-kismet-CONFIG_REF_TRACKER-CONFIG_BTRFS_DELAYED_NODE_REF_TRACKER-0-0 (https://download.01.org/0day-ci/archive/20250711/202507110735.DbwDC17f-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250711/202507110735.DbwDC17f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507110735.DbwDC17f-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for REF_TRACKER when selected by BTRFS_DELAYED_NODE_REF_TRACKER
   WARNING: unmet direct dependencies detected for REF_TRACKER
     Depends on [n]: STACKTRACE_SUPPORT
     Selected by [y]:
     - BTRFS_DELAYED_NODE_REF_TRACKER [=y] && BLOCK [=y] && BTRFS_DEBUG [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

