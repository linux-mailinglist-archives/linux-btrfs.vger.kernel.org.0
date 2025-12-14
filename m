Return-Path: <linux-btrfs+bounces-19723-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 270C8CBC05A
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Dec 2025 22:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09D75300EA2F
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Dec 2025 21:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77783314B96;
	Sun, 14 Dec 2025 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLj+UV7H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E273B314B66
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Dec 2025 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765747312; cv=none; b=hdBeE6m2mPU1oMoAPogmArKMZT7su383xdjROvchpvcdNnGJIb3d3OrG4F0pIu1UkL5FhrfPuhQXWo29Y5bKH/mKkrPcHyVXMXz+sG+pbCIABzRO5Wuc1NwfIC6plzIc1JSdPu+lN81V3nHHs3ojzNe+jqHZWBttp0UXZKBiQPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765747312; c=relaxed/simple;
	bh=PooZ8Amv0fVIAe/EepoV8YRtJz54sblHp8fQOcG86c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/xvDhg7Bvp8Y7T96rn+neE0lXg6wcn8DABbDINLWoL3kqHM0ZGsrYgfNjCpMDuJ4Pg0yAiX/6xZP9SHMI56+2LUtOJRRkVG1aZt/2ZJz/QjojL3zKhQzeMOeMb93BjU4UaL2S0ojJ4ga3/9KZpCej/aMxC8L6C5nE3by62HawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLj+UV7H; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765747311; x=1797283311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PooZ8Amv0fVIAe/EepoV8YRtJz54sblHp8fQOcG86c8=;
  b=eLj+UV7HZa3T7zRdNZCEvfeIqhL3U3hmpNQ95lzYwvIosTdyfnyJZzZw
   Ohtzkj9QMER2GoKhjJVcXAKPETNirOWc1KYFANs6ivrx0/YBPDUT2bIw2
   Z06AbzTXZCXsmeJ2TRMO1Dg8j1HSUuI0VGxnltPFMjTQJ9pzZQzxGJb5D
   WPHJD4vv5kTmZpDXrqFfC5CrXKjvg0R6B/y3ELRT+8zcv18IjQWGQtiaF
   jUYDdfPp06Yt1jeZ6X6DQSvY7zjDg8OXyjLOZ8HRxcq0Pq3xasuZm26AS
   D2sBN8KaR7P1E0qs++TE4SGSXD3FjAuiP8mRXYdjc/iooOky8ZpicDrG1
   Q==;
X-CSE-ConnectionGUID: n2gB5h2rQxCY+ixkdpYLSg==
X-CSE-MsgGUID: mJAkhbRcQFKeuTwjzeiM6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="67618404"
X-IronPort-AV: E=Sophos;i="6.21,148,1763452800"; 
   d="scan'208";a="67618404"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2025 13:21:51 -0800
X-CSE-ConnectionGUID: 6uTt9CjzSaOFyN2GdESfZw==
X-CSE-MsgGUID: PHVgIPsMSBG6vfxLaiWpVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,148,1763452800"; 
   d="scan'208";a="202670335"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by orviesa005.jf.intel.com with ESMTP; 14 Dec 2025 13:21:50 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vUtXG-000000002TI-3Uo0;
	Sun, 14 Dec 2025 21:21:46 +0000
Date: Sun, 14 Dec 2025 22:21:42 +0100
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] btrfs: add an ASSERT() to catch ordered extents with
 incorrect csums
Message-ID: <202512142232.gh7ocB6J-lkp@intel.com>
References: <7ad76db98d300c3fedc73433aa343b654399cc2d.1765521720.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ad76db98d300c3fedc73433aa343b654399cc2d.1765521720.git.wqu@suse.com>

Hi Qu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.19-rc1 next-20251212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-add-an-ASSERT-to-catch-ordered-extents-with-incorrect-csums/20251212-144720
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/7ad76db98d300c3fedc73433aa343b654399cc2d.1765521720.git.wqu%40suse.com
patch subject: [PATCH] btrfs: add an ASSERT() to catch ordered extents with incorrect csums
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251214/202512142232.gh7ocB6J-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251214/202512142232.gh7ocB6J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512142232.gh7ocB6J-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/btrfs/inode.c:3089:12: warning: function 'oe_csum_bytes' is not needed and will not be emitted [-Wunneeded-internal-declaration]
    3089 | static u64 oe_csum_bytes(struct btrfs_ordered_extent *oe)
         |            ^~~~~~~~~~~~~
   1 warning generated.


vim +/oe_csum_bytes +3089 fs/btrfs/inode.c

  3088	
> 3089	static u64 oe_csum_bytes(struct btrfs_ordered_extent *oe)
  3090	{
  3091		struct btrfs_ordered_sum *sum;
  3092		u64 ret = 0;
  3093	
  3094		list_for_each_entry(sum, &oe->list, list)
  3095			ret += sum->len;
  3096		return ret;
  3097	}
  3098	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

