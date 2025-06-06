Return-Path: <linux-btrfs+bounces-14523-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B25ACFCF4
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 08:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933F4171C7A
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 06:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F0B26A0EE;
	Fri,  6 Jun 2025 06:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWKceBrr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F06255247
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 06:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749192146; cv=none; b=R2QPjOJhgPhry8u/UfGdcY7IrG5roORO/YF7NdvXoYD0fPSDzk5yUM3xp2zAd6U3/Jew0k5qPM/bJAKOGW+olgwOK56jhOV/aDlqLXUFm46UdEyTJpemESEhx6ZhpIHK3A8BVFnwOhxWIHQU1//7bOr8MRxZXfs2O/lwYDo+duE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749192146; c=relaxed/simple;
	bh=zXhzX4woctBm+ZgESQf1WUuKky+7BJcUTCU9fvKwcNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyI+jCWr2WrhCMeIiWz5RiGbfFalxIK1gYm1ow7b/DtZGmsrq/zIxFiuoZ9K1keKP4iDj1zUaI3J2vP7L89wBWoBqp2+X50+aPrlmoG3qmBtnxB6+4eeE0D8r+ietQYyeGNQkqyXZBJoNFqk/81jJ7+X1EsKQIhbARqRLZ4OeTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kWKceBrr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749192144; x=1780728144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zXhzX4woctBm+ZgESQf1WUuKky+7BJcUTCU9fvKwcNU=;
  b=kWKceBrrWFDhkKO5LtWHZ5DBMncw5AnGb2OHt1et2VWnQV9BVM87498o
   qFHMeeI8OvUC2T2EXxwELwZxC5ua2juJqIjbhV5okFJXtxN9srlYcOu9q
   UxACRHy+UYCY9dBuFnSBqLHA3HRIlXch/I1v1VvY/hMWM0BstDyTEwoHH
   nvdRiJWMc/xUPljj75I+JrudLnBsSLq0FPI6vAdmQpqOm+BQgYh5Cxn3V
   o116sCEEv4sJKhrUOTJrGErcOikRjXwiikYDNJtDy/k/Mzvg/TmUdVLlj
   wlJO8e0xmHJkQH4JzTaZNmZuwmdu/3LS2lr0W/SDbqmHmSkcTB2OKPfeR
   Q==;
X-CSE-ConnectionGUID: UbGmW+J3QrK0cvsPFXjNTQ==
X-CSE-MsgGUID: HpxxFo9mQTONdG8ZZslVDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="62378932"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="62378932"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 23:42:19 -0700
X-CSE-ConnectionGUID: LeL/J/qfR9K80Qg+bnUadQ==
X-CSE-MsgGUID: LzXa+m9GRUia6SnTcSkSIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="145692485"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 05 Jun 2025 23:42:18 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNQmN-0004nV-2p;
	Fri, 06 Jun 2025 06:42:15 +0000
Date: Fri, 6 Jun 2025 14:41:22 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Mark Harmstone <maharmstone@fb.com>
Subject: Re: [PATCH 04/12] btrfs: remove remapped block groups from the
 free-space tree
Message-ID: <202506061455.6kk5l6Ct-lkp@intel.com>
References: <20250605162345.2561026-5-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605162345.2561026-5-maharmstone@fb.com>

Hi Mark,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master next-20250605]
[cannot apply to v6.15]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Harmstone/btrfs-add-definitions-and-constants-for-remap-tree/20250606-002804
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20250605162345.2561026-5-maharmstone%40fb.com
patch subject: [PATCH 04/12] btrfs: remove remapped block groups from the free-space tree
config: i386-randconfig-014-20250606 (https://download.01.org/0day-ci/archive/20250606/202506061455.6kk5l6Ct-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250606/202506061455.6kk5l6Ct-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506061455.6kk5l6Ct-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/btrfs/block-group.c:2470:23: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
    2470 |                             !(cache->flags && BTRFS_BLOCK_GROUP_REMAPPED)) {
         |                                            ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/btrfs/block-group.c:2470:23: note: use '&' for a bitwise operation
    2470 |                             !(cache->flags && BTRFS_BLOCK_GROUP_REMAPPED)) {
         |                                            ^~
         |                                            &
   fs/btrfs/block-group.c:2470:23: note: remove constant to silence this warning
    2470 |                             !(cache->flags && BTRFS_BLOCK_GROUP_REMAPPED)) {
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> fs/btrfs/block-group.c:2470:26: warning: converting the result of '<<' to a boolean always evaluates to true [-Wtautological-constant-compare]
    2470 |                             !(cache->flags && BTRFS_BLOCK_GROUP_REMAPPED)) {
         |                                               ^
   include/uapi/linux/btrfs_tree.h:1171:47: note: expanded from macro 'BTRFS_BLOCK_GROUP_REMAPPED'
    1171 | #define BTRFS_BLOCK_GROUP_REMAPPED      (1ULL << 11)
         |                                               ^
   2 warnings generated.


vim +2470 fs/btrfs/block-group.c

  2361	
  2362	static int read_one_block_group(struct btrfs_fs_info *info,
  2363					struct btrfs_block_group_item *bgi,
  2364					const struct btrfs_key *key,
  2365					int need_clear)
  2366	{
  2367		struct btrfs_block_group *cache;
  2368		const bool mixed = btrfs_fs_incompat(info, MIXED_GROUPS);
  2369		int ret;
  2370	
  2371		ASSERT(key->type == BTRFS_BLOCK_GROUP_ITEM_KEY);
  2372	
  2373		cache = btrfs_create_block_group_cache(info, key->objectid);
  2374		if (!cache)
  2375			return -ENOMEM;
  2376	
  2377		cache->length = key->offset;
  2378		cache->used = btrfs_stack_block_group_used(bgi);
  2379		cache->commit_used = cache->used;
  2380		cache->flags = btrfs_stack_block_group_flags(bgi);
  2381		cache->global_root_id = btrfs_stack_block_group_chunk_objectid(bgi);
  2382		cache->space_info = btrfs_find_space_info(info, cache->flags);
  2383	
  2384		set_free_space_tree_thresholds(cache);
  2385	
  2386		if (need_clear) {
  2387			/*
  2388			 * When we mount with old space cache, we need to
  2389			 * set BTRFS_DC_CLEAR and set dirty flag.
  2390			 *
  2391			 * a) Setting 'BTRFS_DC_CLEAR' makes sure that we
  2392			 *    truncate the old free space cache inode and
  2393			 *    setup a new one.
  2394			 * b) Setting 'dirty flag' makes sure that we flush
  2395			 *    the new space cache info onto disk.
  2396			 */
  2397			if (btrfs_test_opt(info, SPACE_CACHE))
  2398				cache->disk_cache_state = BTRFS_DC_CLEAR;
  2399		}
  2400		if (!mixed && ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
  2401		    (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
  2402				btrfs_err(info,
  2403	"bg %llu is a mixed block group but filesystem hasn't enabled mixed block groups",
  2404					  cache->start);
  2405				ret = -EINVAL;
  2406				goto error;
  2407		}
  2408	
  2409		ret = btrfs_load_block_group_zone_info(cache, false);
  2410		if (ret) {
  2411			btrfs_err(info, "zoned: failed to load zone info of bg %llu",
  2412				  cache->start);
  2413			goto error;
  2414		}
  2415	
  2416		/*
  2417		 * We need to exclude the super stripes now so that the space info has
  2418		 * super bytes accounted for, otherwise we'll think we have more space
  2419		 * than we actually do.
  2420		 */
  2421		ret = exclude_super_stripes(cache);
  2422		if (ret) {
  2423			/* We may have excluded something, so call this just in case. */
  2424			btrfs_free_excluded_extents(cache);
  2425			goto error;
  2426		}
  2427	
  2428		/*
  2429		 * For zoned filesystem, space after the allocation offset is the only
  2430		 * free space for a block group. So, we don't need any caching work.
  2431		 * btrfs_calc_zone_unusable() will set the amount of free space and
  2432		 * zone_unusable space.
  2433		 *
  2434		 * For regular filesystem, check for two cases, either we are full, and
  2435		 * therefore don't need to bother with the caching work since we won't
  2436		 * find any space, or we are empty, and we can just add all the space
  2437		 * in and be done with it.  This saves us _a_lot_ of time, particularly
  2438		 * in the full case.
  2439		 */
  2440		if (btrfs_is_zoned(info)) {
  2441			btrfs_calc_zone_unusable(cache);
  2442			/* Should not have any excluded extents. Just in case, though. */
  2443			btrfs_free_excluded_extents(cache);
  2444		} else if (cache->length == cache->used) {
  2445			cache->cached = BTRFS_CACHE_FINISHED;
  2446			btrfs_free_excluded_extents(cache);
  2447		} else if (cache->used == 0) {
  2448			cache->cached = BTRFS_CACHE_FINISHED;
  2449			ret = btrfs_add_new_free_space(cache, cache->start,
  2450						       cache->start + cache->length, NULL);
  2451			btrfs_free_excluded_extents(cache);
  2452			if (ret)
  2453				goto error;
  2454		}
  2455	
  2456		ret = btrfs_add_block_group_cache(cache);
  2457		if (ret) {
  2458			btrfs_remove_free_space_cache(cache);
  2459			goto error;
  2460		}
  2461	
  2462		trace_btrfs_add_block_group(info, cache, 0);
  2463		btrfs_add_bg_to_space_info(info, cache);
  2464	
  2465		set_avail_alloc_bits(info, cache->flags);
  2466		if (btrfs_chunk_writeable(info, cache->start)) {
  2467			if (cache->used == 0) {
  2468				ASSERT(list_empty(&cache->bg_list));
  2469				if (btrfs_test_opt(info, DISCARD_ASYNC) &&
> 2470				    !(cache->flags && BTRFS_BLOCK_GROUP_REMAPPED)) {
  2471					btrfs_discard_queue_work(&info->discard_ctl, cache);
  2472				} else {
  2473					btrfs_mark_bg_unused(cache);
  2474				}
  2475			}
  2476		} else {
  2477			inc_block_group_ro(cache, 1);
  2478		}
  2479	
  2480		return 0;
  2481	error:
  2482		btrfs_put_block_group(cache);
  2483		return ret;
  2484	}
  2485	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

