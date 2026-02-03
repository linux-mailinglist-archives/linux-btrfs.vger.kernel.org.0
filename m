Return-Path: <linux-btrfs+bounces-21347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEl3GbSJgmk9WAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21347-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 00:50:12 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9464DFD8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 00:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCEA73038FF9
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 23:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1057032FA38;
	Tue,  3 Feb 2026 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXFxJOej"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A531ED8A
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 23:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770162601; cv=none; b=b+LHpsI/cljwl4OBxqYhKDwoBhUKHr9j+oAOeAPf0Ij1u76MSV0sHKz/2yV8OEA2e3Oit8pr6iXepWh6CyKd39WyCdJX5Sk3oE3Cn9mV1eWCjNYLGgaBrtGNrz5rY7G/fFTTIlnsxzkeV2BbdQaMqDtgNgbsPd+gqY+97yFrJKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770162601; c=relaxed/simple;
	bh=0FE/9IlbnnnB5Syjs+C+XOn2w3fMFyktdcf8wsWYO6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p78w4H6XKnxC9W/o0CqD3RCiCkNmu7rpyhnB2SnnvypxDON4IoUoLiwzapPoCWYAkWAtWE7jFhZ7ib24fR4tywcdqunPz2/bRrqBxZ7CC+o5tIxMkGNJuxn043tE+3SApVyRXP2mELUbsvCxRNGaNhS51Esomj6Si+7p4UCig2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXFxJOej; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770162599; x=1801698599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0FE/9IlbnnnB5Syjs+C+XOn2w3fMFyktdcf8wsWYO6g=;
  b=FXFxJOejA+kJ/I7lxLIk5tDJHvxBMnPwZTyqIvM1cU6uEC8/BFlkI2gC
   OlP1Shv4qm6PiFfVtVDiZBGPkg68xj9cSF5mAe1LrjfLchhb38WWQWxah
   4TOvWci3nZWzMoEH5h4/LxIGBBcvVN4jMwBgBMYP0EWmDf4m0GZgJGvMp
   G5hvKr51121bZ98Xz3U7iLnfjL60oN/CtBh6nxvBNOYhJe5fyfqjet0pf
   SsuSbpdU7/bGp7YQQU9XWpIl96Q1xKlYhclsl+9YZEFg/BuWpC8NARnML
   Gn2xL3x7B4bTlLMKr9cnLQfe38EAb4P4ddKggi1yge1Sn3p9loWZaI7hx
   A==;
X-CSE-ConnectionGUID: KhiIxOxZSkSWifAYEnWy0g==
X-CSE-MsgGUID: xn9n3Cs1TZyMiLgMzPkBQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="75203084"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="75203084"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 15:49:58 -0800
X-CSE-ConnectionGUID: Vi1ojMQATI2mKhbvShqgtg==
X-CSE-MsgGUID: w99rgcScTZmh8a6mvf0kog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="209381034"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 03 Feb 2026 15:49:58 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnQ9b-00000000hJ6-3eTc;
	Tue, 03 Feb 2026 23:49:55 +0000
Date: Wed, 4 Feb 2026 07:49:13 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/3] btrfs: introduce the device layout aware per-profile
 available space
Message-ID: <202602040700.ald285sK-lkp@intel.com>
References: <eb573bac21a16092d8e9f64533c6b0d6ed6b16a4.1770087101.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb573bac21a16092d8e9f64533c6b0d6ed6b16a4.1770087101.git.wqu@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21347-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,git-scm.com:url,01.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9464DFD8F
X-Rspamd-Action: no action

Hi Qu,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.19-rc8 next-20260203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-introduce-the-device-layout-aware-per-profile-available-space/20260203-110526
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/eb573bac21a16092d8e9f64533c6b0d6ed6b16a4.1770087101.git.wqu%40suse.com
patch subject: [PATCH 1/3] btrfs: introduce the device layout aware per-profile available space
config: powerpc-randconfig-002-20260204 (https://download.01.org/0day-ci/archive/20260204/202602040700.ald285sK-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260204/202602040700.ald285sK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602040700.ald285sK-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: fs/btrfs/volumes.o: in function `alloc_virtual_chunk':
>> volumes.c:(.text+0x2648): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

