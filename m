Return-Path: <linux-btrfs+bounces-20972-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLq1FDn+c2nu0wAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20972-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 00:03:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 879427B5BD
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 00:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3059E3018082
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 23:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB962BE03B;
	Fri, 23 Jan 2026 23:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6sU2bCQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19583EBF3B
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 23:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769209293; cv=none; b=GXFLi9rpHmCj05z36nUWHBvwgaBkje14e17d0ccHm2y+Afz+AiTn4RVx7E5Hi3bIH6fALbVJ55GlFgw/yA4A051cuyZWqhyoWRSS72Cn9GuoaAvoqt5bKcsncVWEEL8Pteisj7KBO5sDLXzCyA0RFRVJW2ygrzCWspyPCoC0how=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769209293; c=relaxed/simple;
	bh=bjgANok5VWaUR9/ZGKh2qhbPtOHe4DN7ZcA60OP3kdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuzHJjuYbHxKLkR7d8nAsyMi/oT3ky06l4hdNoLeTy1SMLKvZTEzkcQQOYWzC6VbnDTYkQYGmnF+c8NftVEWZECQ0nzvOZBIMcmfQKTlnyuMOj3fr+FH7GCjRKbyHwqhjUxywADX+4OPWoV71O1ZSYZP7nHucR1EQUOlHMP0YtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6sU2bCQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769209292; x=1800745292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bjgANok5VWaUR9/ZGKh2qhbPtOHe4DN7ZcA60OP3kdQ=;
  b=O6sU2bCQf1yTFqD9lelRkwPPVVQdwnT3sK1hakxvyqILT6Guz9oFkQoA
   K9CCqVwp4TV+7vztOBKy/gIlArtg0iNnlTSY4frq77mk3O9JoLmx521Ga
   26VP+U6tQhdblDFva0ocQRU8VOyGWBMA2iF0y8kGU3NNeiOgZMiO3ksjQ
   LJn19cws4d3/rUdNRddRAM7FPVaWmmzP5C36cJCCmJ9DOF4ViILvSmACb
   qi887Haguy0QQlxsce53GrXlfXoHstDVu98+2aR0V7J7n17F9KjTntGa4
   oHAjs89KhwcL7U9A3xv5F4TovTdz9tQHUBKKS2CM64mzKdAtbONSmptsl
   Q==;
X-CSE-ConnectionGUID: MzlrISF/T0ua0QwgNPtpIg==
X-CSE-MsgGUID: jjyX4vmBQEa2PoKxwjb0FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70525907"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="70525907"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 15:01:32 -0800
X-CSE-ConnectionGUID: bt3IcbDZSomtF6EsKFoyrA==
X-CSE-MsgGUID: yqvrjELfSkO/NTbDwMgjsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="211598656"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 23 Jan 2026 15:01:30 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjQ9g-00000000UYw-0FzO;
	Fri, 23 Jan 2026 23:01:28 +0000
Date: Sat, 24 Jan 2026 07:00:28 +0800
From: kernel test robot <lkp@intel.com>
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 4/4] btrfs: tests: zoned: add selftest for zoned code
Message-ID: <202601240640.fgNkjFQF-lkp@intel.com>
References: <20260123125920.4129581-5-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123125920.4129581-5-naohiro.aota@wdc.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20972-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,git-scm.com:url]
X-Rspamd-Queue-Id: 879427B5BD
X-Rspamd-Action: no action

Hi Naohiro,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on next-20260122]
[cannot apply to linus/master v6.19-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Naohiro-Aota/btrfs-tests-add-cleanup-functions-for-test-specific-functions/20260123-210300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20260123125920.4129581-5-naohiro.aota%40wdc.com
patch subject: [PATCH 4/4] btrfs: tests: zoned: add selftest for zoned code
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260124/202601240640.fgNkjFQF-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260124/202601240640.fgNkjFQF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601240640.fgNkjFQF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/btrfs/tests/zoned-tests.c:89:8: error: call to undeclared function 'btrfs_load_block_group_by_raid_type'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      89 |         ret = btrfs_load_block_group_by_raid_type(bg, map, zone_info, active,
         |               ^
   fs/btrfs/tests/zoned-tests.c:89:8: note: did you mean 'btrfs_load_block_group_zone_info'?
   fs/btrfs/tests/../zoned.h:195:19: note: 'btrfs_load_block_group_zone_info' declared here
     195 | static inline int btrfs_load_block_group_zone_info(
         |                   ^
   1 error generated.


vim +/btrfs_load_block_group_by_raid_type +89 fs/btrfs/tests/zoned-tests.c

    39	
    40	static int test_load_zone_info(struct btrfs_fs_info *fs_info,
    41				       struct load_zone_info_test_vector *test)
    42	{
    43		struct btrfs_block_group *bg __free(btrfs_free_dummy_block_group) = NULL;
    44		struct btrfs_chunk_map *map __free(btrfs_free_chunk_map) = NULL;
    45		struct zone_info AUTO_KFREE(zone_info);
    46		unsigned long AUTO_KFREE(active);
    47		int i, ret;
    48	
    49		bg = btrfs_alloc_dummy_block_group(fs_info, test->bg_length);
    50		if (!bg) {
    51			test_std_err(TEST_ALLOC_BLOCK_GROUP);
    52			return -ENOMEM;
    53		}
    54	
    55		map = btrfs_alloc_chunk_map(test->num_stripes, GFP_KERNEL);
    56		if (!map) {
    57			test_std_err(TEST_ALLOC_EXTENT_MAP);
    58			return -ENOMEM;
    59		}
    60	
    61		zone_info = kcalloc(test->num_stripes, sizeof(*zone_info), GFP_KERNEL);
    62		if (!zone_info) {
    63			test_err("cannot allocate zone info");
    64			return -ENOMEM;
    65		}
    66	
    67		active = bitmap_zalloc(test->num_stripes, GFP_KERNEL);
    68		if (!zone_info) {
    69			test_err("cannot allocate active bitmap");
    70			return -ENOMEM;
    71		}
    72	
    73		map->type = test->raid_type;
    74		map->num_stripes = test->num_stripes;
    75		if (test->raid_type == BTRFS_BLOCK_GROUP_RAID10)
    76			map->sub_stripes = 2;
    77		for (i = 0; i < test->num_stripes; i++) {
    78			zone_info[i].physical = 0;
    79			zone_info[i].alloc_offset = test->alloc_offsets[i];
    80			zone_info[i].capacity = ZONE_SIZE;
    81			if (zone_info[i].alloc_offset && zone_info[i].alloc_offset < ZONE_SIZE)
    82				__set_bit(i, active);
    83		}
    84		if (test->degraded)
    85			btrfs_set_opt(fs_info->mount_opt, DEGRADED);
    86		else
    87			btrfs_clear_opt(fs_info->mount_opt, DEGRADED);
    88	
  > 89		ret = btrfs_load_block_group_by_raid_type(bg, map, zone_info, active,
    90							  test->last_alloc);
    91	
    92		if (ret != test->expected_result) {
    93			test_err("unexpected return value: ret %d expected %d", ret,
    94				 test->expected_result);
    95			return -EINVAL;
    96		}
    97	
    98		if (!ret && bg->alloc_offset != test->expected_alloc_offset) {
    99			test_err("unexpected alloc_offset: alloc_offset %llu expected %llu",
   100				 bg->alloc_offset, test->expected_alloc_offset);
   101			return -EINVAL;
   102		}
   103	
   104		return 0;
   105	}
   106	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

