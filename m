Return-Path: <linux-btrfs+bounces-20970-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBVVEsHzc2ny0AAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20970-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 23:18:41 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D547B144
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 23:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92763300D97E
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 22:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901991F583D;
	Fri, 23 Jan 2026 22:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l28hCu8p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890A019CD06
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769206712; cv=none; b=eL+qgJxKEWCzDCBi99KFwUUr/La/1IQvWz9M+CAfqRSqfLDu7RgQEYTBgSmbB1PXbscW0iwxzID2qQoC+Q92umdrp0ZdQewS4U6g5f2x1F+mAd5jKu7PEagD2jvB+adaRPdOiBV/FJRI8dj00Zj6Huv8SiWVa9l2Hn7v6BWAD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769206712; c=relaxed/simple;
	bh=FFvhxAUFVZSSxRcJdhqoo1TBLYbOL5iqdKLYgP5/gEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inalByrBytWZt9h2nFBhw+43cRIjtnkCSKDITY/bagXXJQWOgZRGnVpFS1dzcfRryuzuqeBj5a5N8YK8LtjQ1HgYtuS3V9a3mM07gpryCSFCZgXzJi5TbC0WZFmaAyjWO/TFOixlf5WJ1G7XgXPQryjoJwcNOuGfNOpn7sPiixQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l28hCu8p; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769206710; x=1800742710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FFvhxAUFVZSSxRcJdhqoo1TBLYbOL5iqdKLYgP5/gEM=;
  b=l28hCu8pEcyOyDaaAGF0sVgAuz/L75kc4neObjGkIkQLy9AexnPDWu4Y
   2fQ8qafFI/2oeUd8ORWmsKzNLjUP2wAFEttE9JqsTp6WidLDGO8tf3Aic
   FLrlqKGRUA0g1duy9POsSWFeaDAni3bp/b5+G99bOhQ72GJLgcapu+z8d
   94kHMuNhMdI6842VVvbbYHSChkvm7gIPp5YUJjFoi8UiAa9yVF8hTl0xN
   1qwI1n3NautC3gGBzm6ArGFNaumu5iV+KCNLZYWTcESyyKIxdtC7B3YhM
   nNQew5Iw+oQ7T4s9XtA6SnxdfKqnJ/3BGLz+lj/pyXi59G+by3w7mS1LO
   Q==;
X-CSE-ConnectionGUID: 28xbJXO/S8ur+cY6S7ArGA==
X-CSE-MsgGUID: I3McHqYfTRWdXZ7EQLSuvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="81576896"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="81576896"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 14:18:30 -0800
X-CSE-ConnectionGUID: F8/ICUURS5GWOUWsj/FNuQ==
X-CSE-MsgGUID: XpFNGb1ZSamdIFincg188g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="207377331"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 23 Jan 2026 14:18:28 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjPU2-00000000UWk-0zu4;
	Fri, 23 Jan 2026 22:18:26 +0000
Date: Sat, 24 Jan 2026 06:17:59 +0800
From: kernel test robot <lkp@intel.com>
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 4/4] btrfs: tests: zoned: add selftest for zoned code
Message-ID: <202601240657.rNUgphBi-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20970-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,git-scm.com:url]
X-Rspamd-Queue-Id: E0D547B144
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
config: powerpc64-randconfig-002-20260124 (https://download.01.org/0day-ci/archive/20260124/202601240657.rNUgphBi-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260124/202601240657.rNUgphBi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601240657.rNUgphBi-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/btrfs/tests/zoned-tests.c: In function 'test_load_zone_info':
>> fs/btrfs/tests/zoned-tests.c:89:8: error: implicit declaration of function 'btrfs_load_block_group_by_raid_type'; did you mean 'btrfs_load_block_group_zone_info'? [-Werror=implicit-function-declaration]
     ret = btrfs_load_block_group_by_raid_type(bg, map, zone_info, active,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           btrfs_load_block_group_zone_info
   cc1: some warnings being treated as errors


vim +89 fs/btrfs/tests/zoned-tests.c

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

