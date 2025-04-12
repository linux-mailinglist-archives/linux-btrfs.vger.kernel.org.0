Return-Path: <linux-btrfs+bounces-12966-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8ECA86B20
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Apr 2025 07:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F0D1B84DFA
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Apr 2025 05:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190E918A6DF;
	Sat, 12 Apr 2025 05:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LMJIsObF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B09114A62A
	for <linux-btrfs@vger.kernel.org>; Sat, 12 Apr 2025 05:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744437279; cv=none; b=Ad0z6DSP3mrZp9YVX84IXjZktWGFEEGNxIWiDwHc9nrGX2qOiePJwWLcbyy03tB9CYgawQczbeW4JQkcc6HuqBDrVPZEfjLPysPbhbPNwTLsrcUmDzDnjbxemUcoI0AgiK8C2DP57QZEZ6KprbE0MZBw4ELIPCpSracQmGiZW7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744437279; c=relaxed/simple;
	bh=2f+toakEyeiRENnOoTHZLe642lxHon8ilhOYQErXikw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6t8tu3Ce7YRp/xtlFtmhOA0+ebmIAi0UpNNIY7m4Wy3Jgot/0LvLKT8Y4I86qpcifJlMOq6O5ioTTLLXU+IUnj2yB6HLmf3tfrS2zT37OYyNzL9w9E3X6FVMLCqb0kKTDeGRnBVeUXZzyFac0rhMl7158K4eg5rl2W0k8ZXspY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LMJIsObF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744437278; x=1775973278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2f+toakEyeiRENnOoTHZLe642lxHon8ilhOYQErXikw=;
  b=LMJIsObFdMha4vaeqJUbaVAbsODpqEi3ZjMjrMlsZCHPjwQuCkNM6RaL
   1B9Xf4V7eNEYhijjE6d2xiLU5qrmRLbCuwf11sfKPYZ2DY9fhMZnxqm7m
   P2q23YjjkShUSbKgIskqljXcdY28SQEF9bdpQULOAJyzITzb010Pep8CO
   DQrQR51O2UrhjmeVSqwyWztQx8EE4XEPxjzJ01HBR2L5sTuGk6RkGE/mx
   3plb8fxkeD1JhRygxbRtEaXBcc9EZnjKRwImMfXIpiHCJfJWxVD1y7wEG
   ZY7D/UEyCpHx0aQidAqoiLWfcSan3XSNedf4OyxCHMX1t7ed+Rxjf+1zY
   A==;
X-CSE-ConnectionGUID: gJYolkODSb+iAcveBQ8Kbg==
X-CSE-MsgGUID: E9F6qScuQSmny57LklIwRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="57354610"
X-IronPort-AV: E=Sophos;i="6.15,207,1739865600"; 
   d="scan'208";a="57354610"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 22:54:37 -0700
X-CSE-ConnectionGUID: vRlU2mqPQYmznAUftuiFKw==
X-CSE-MsgGUID: UOjomD0rRUmfWppPUyH0rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,207,1739865600"; 
   d="scan'208";a="134120771"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 11 Apr 2025 22:54:35 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3Tp2-000Bao-2p;
	Sat, 12 Apr 2025 05:54:32 +0000
Date: Sat, 12 Apr 2025 13:54:29 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] btrfs: make btrfs_truncate_block() zero folio range
 for certain subpage corner cases
Message-ID: <202504121352.3gzerLun-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-001-20250412 (https://download.01.org/0day-ci/archive/20250412/202504121352.3gzerLun-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250412/202504121352.3gzerLun-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504121352.3gzerLun-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: zero_range_folio+0x21f: relocation to !ENDBR: bd_may_claim+0x112

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

