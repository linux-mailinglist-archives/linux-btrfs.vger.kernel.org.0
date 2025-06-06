Return-Path: <linux-btrfs+bounces-14515-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72535ACFA47
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 02:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58279189A472
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 00:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75F4139E;
	Fri,  6 Jun 2025 00:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHlolu6A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB91136A
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 00:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749168407; cv=none; b=GdCEopVKpaB1e5/QcxqQKL5QieCI9VtAHZPFqFQdG3mggWbJhSGlpVep1hdd6WVcXM3vlH3Hp5QI52ge42sYowbBDaBZ6AWjZnx4maAyUc+5B5Z0xlZWkaazAcaP/WKl9TAawnE7gBiFRoH5qkMP9yWPXwgiPZsjj/neAGTNQ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749168407; c=relaxed/simple;
	bh=+oWZHG8IeFf4aAbPD5j+JD6IN20IKFmc5z9/9bEZU4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMZBUnUZ4igEbnglOy21a5GQLdfC78XmggZgYPVtTTgF+ZXaBeJvCRAZ9+VVNIc867tDTwf0ACDFBbKNvcTAMKaShd+xb+d1JMK/LKTNWsSKkyVwsdXP96iD5YfCpsHIl4RJr4TVLs/3ERJTQkhbVAiXIhwzZ7mtbKo1vJOH/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHlolu6A; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749168405; x=1780704405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+oWZHG8IeFf4aAbPD5j+JD6IN20IKFmc5z9/9bEZU4k=;
  b=PHlolu6AcDez26biotL4/8UYW3LJXV/1i9wimqJp2nqiipmO5dwWxyYf
   sIDryXtLYuuYhUzzNNMTo6ITSJ5QOeBuvI1NtaayNHZj7vbuz9gbAzLss
   vCTkcAKbY0pCqoXgU77v9OGGg/B8+mBfo2cqiPbesQKIHdYBEx2Mp70RF
   h52fW6d/1GZwwTYMHSA08ALsh2D/fufkZACR39TjJT4GFzjESot7I+9KK
   grqZmYVYJBd1rZFdAV/YTj0Xa02G2TqN6G3w0nQe3k+N55JdiQ6l6O7Qt
   z4R8J0Q4+d3mWqofCtM6vCdsIk6IAOcehsyZq1i+ja92m0pX+2lKgLp6z
   Q==;
X-CSE-ConnectionGUID: e5Y4q0V9QkSD4O+HoQWd3Q==
X-CSE-MsgGUID: njT3MoRhSfOjB11c7FzP9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51219429"
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="51219429"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 17:06:44 -0700
X-CSE-ConnectionGUID: Agl6kbLkQ1GD+2ww1e7OOg==
X-CSE-MsgGUID: NsnOY1afQRuuLieRbuVTXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="150679351"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 05 Jun 2025 17:06:42 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNKbX-0004Yb-2U;
	Fri, 06 Jun 2025 00:06:39 +0000
Date: Fri, 6 Jun 2025 08:06:02 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2] btrfs: zoned: fix alloc_offset calculation for partly
 conventional block groups
Message-ID: <202506060751.KRci5LHx-lkp@intel.com>
References: <20250605091811.386815-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605091811.386815-1-jth@kernel.org>

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.15 next-20250605]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Thumshirn/btrfs-zoned-fix-alloc_offset-calculation-for-partly-conventional-block-groups/20250605-171925
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20250605091811.386815-1-jth%40kernel.org
patch subject: [PATCH v2] btrfs: zoned: fix alloc_offset calculation for partly conventional block groups
config: i386-buildonly-randconfig-002-20250606 (https://download.01.org/0day-ci/archive/20250606/202506060751.KRci5LHx-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250606/202506060751.KRci5LHx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506060751.KRci5LHx-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: fs/btrfs/zoned.o: in function `btrfs_load_block_group_raid0':
>> fs/btrfs/zoned.c:1531: undefined reference to `__umoddi3'
   ld: fs/btrfs/zoned.o: in function `btrfs_load_block_group_raid10':
   fs/btrfs/zoned.c:1592: undefined reference to `__umoddi3'


vim +1531 fs/btrfs/zoned.c

  1504	
  1505	static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
  1506						struct btrfs_chunk_map *map,
  1507						struct zone_info *zone_info,
  1508						unsigned long *active,
  1509						u64 last_alloc)
  1510	{
  1511		struct btrfs_fs_info *fs_info = bg->fs_info;
  1512	
  1513		if ((map->type & BTRFS_BLOCK_GROUP_DATA) && !fs_info->stripe_root) {
  1514			btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
  1515				  btrfs_bg_type_to_raid_name(map->type));
  1516			return -EINVAL;
  1517		}
  1518	
  1519		for (int i = 0; i < map->num_stripes; i++) {
  1520			if (zone_info[i].alloc_offset == WP_MISSING_DEV)
  1521				continue;
  1522	
  1523			if (zone_info[i].alloc_offset == WP_CONVENTIONAL) {
  1524				u64 stripe_nr, full_stripe_nr;
  1525				u64 stripe_offset;
  1526				int stripe_index;
  1527	
  1528				stripe_nr = div64_u64(last_alloc, map->stripe_size);
  1529				stripe_offset = stripe_nr * map->stripe_size;
  1530				full_stripe_nr = div_u64(stripe_nr, map->num_stripes);
> 1531				stripe_index = stripe_nr % map->num_stripes;
  1532	
  1533				zone_info[i].alloc_offset =
  1534					full_stripe_nr * map->stripe_size;
  1535	
  1536				if (stripe_index > i)
  1537					zone_info[i].alloc_offset += map->stripe_size;
  1538				else if (stripe_index == i)
  1539					zone_info[i].alloc_offset +=
  1540						(last_alloc - stripe_offset);
  1541			}
  1542	
  1543			if (test_bit(0, active) != test_bit(i, active)) {
  1544				if (!btrfs_zone_activate(bg))
  1545					return -EIO;
  1546			} else {
  1547				if (test_bit(0, active))
  1548					set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &bg->runtime_flags);
  1549			}
  1550			bg->zone_capacity += zone_info[i].capacity;
  1551			bg->alloc_offset += zone_info[i].alloc_offset;
  1552		}
  1553	
  1554		return 0;
  1555	}
  1556	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

