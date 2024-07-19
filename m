Return-Path: <linux-btrfs+bounces-6605-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34629937A17
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 17:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5808C1C21B46
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 15:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BC4145B13;
	Fri, 19 Jul 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xs/tzcqO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4051448F6
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403752; cv=none; b=lOXcgN8ixksErOZ4o3sOCTpmTOI0arzEAwYF8dpYNDRqYDom/gBVHeysKlffJTCNnTKg6vv2agjnGN6UIfS8A91M5oeTzIYYhX9oku7fVu+Wd90XAXJ5MOj8noxuALCozL4/iM14+U7JgKaHZQBcLxp2AJFE8NEIc/q29PVXqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403752; c=relaxed/simple;
	bh=jKJUaPue0wLBcXO8B7OZM0K2t1ojICBnZk6mzl/7/KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSqwICZhVnDfFm8Zht36lxzBGylOymIJRUXIYcrswdnVqGIu5qhRFCz2ddf+bEP4uweqz7vJgrDVKEVRo0jaGMr0R2n8Ckv1gE0Ic7Kz18LmUm1WAPUq1C+eIObqnJlRp1xovX5yBvEFP+AGRqKZkPj2ns/340y5H5NM14jGaBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xs/tzcqO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721403751; x=1752939751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jKJUaPue0wLBcXO8B7OZM0K2t1ojICBnZk6mzl/7/KA=;
  b=Xs/tzcqOFwgR7O6VMOibGzbWVap4n3oLR9MESgRum+7fhQZAKs3Lvzcl
   BKPeliML5Z6BGNUWaEpx6ySJ1rLolWvDs9NEOiJRftYh1Ptkn3nra8Ceu
   7M20IPaVkATwvPhsOmGn/02WiinUotEWDoYCqbff/e59lth3ikkWjF/Ub
   nym87OpBGw74EH4cFCSxF5C/5xVMxnH7yijsvxUXxwqhYHDL43LpWVWU9
   Y5URU8pNaC+3afNNWHNrBun7v3QC+b9wS+x+mNZQzPTRfWf99fC+5wyAB
   MO1eLFNk+BJ1pm7YdNmToy10vJKPpJNiR6sFtbim9f//rjrBzseB6BBRV
   Q==;
X-CSE-ConnectionGUID: 5qTqc223TzGyuAFBJhIBdg==
X-CSE-MsgGUID: 1V0tEZgoQsaMHpLfZOpwCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="19200959"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="19200959"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 08:42:30 -0700
X-CSE-ConnectionGUID: 6m3zcPrkTYqBHtomqlWjew==
X-CSE-MsgGUID: XDbzmS7WQeyOdx49pcuSbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="56276231"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 19 Jul 2024 08:42:28 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUpkX-000iJJ-2w;
	Fri, 19 Jul 2024 15:42:25 +0000
Date: Fri, 19 Jul 2024 23:42:03 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v5 1/2] btrfs: always uses root memcgroup for
 filemap_add_folio()
Message-ID: <202407192346.BjAEmrYl-lkp@intel.com>
References: <d408a1b35307101e82a6845e26af4a122c8e5a25.1721363035.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d408a1b35307101e82a6845e26af4a122c8e5a25.1721363035.git.wqu@suse.com>

Hi Qu,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v6.10 next-20240719]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-always-uses-root-memcgroup-for-filemap_add_folio/20240719-125131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/d408a1b35307101e82a6845e26af4a122c8e5a25.1721363035.git.wqu%40suse.com
patch subject: [PATCH v5 1/2] btrfs: always uses root memcgroup for filemap_add_folio()
config: x86_64-buildonly-randconfig-002-20240719 (https://download.01.org/0day-ci/archive/20240719/202407192346.BjAEmrYl-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240719/202407192346.BjAEmrYl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407192346.BjAEmrYl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/btrfs/extent_io.c:2992:31: error: use of undeclared identifier 'root_mem_cgroup'; did you mean 'parent_mem_cgroup'?
    2992 |         old_memcg = set_active_memcg(root_mem_cgroup);
         |                                      ^~~~~~~~~~~~~~~
         |                                      parent_mem_cgroup
   include/linux/memcontrol.h:1288:34: note: 'parent_mem_cgroup' declared here
    1288 | static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
         |                                  ^
   1 error generated.


vim +2992 fs/btrfs/extent_io.c

  2971	
  2972		struct btrfs_fs_info *fs_info = eb->fs_info;
  2973		struct address_space *mapping = fs_info->btree_inode->i_mapping;
  2974		struct mem_cgroup *old_memcg;
  2975		const unsigned long index = eb->start >> PAGE_SHIFT;
  2976		struct folio *existing_folio = NULL;
  2977		int ret;
  2978	
  2979		ASSERT(found_eb_ret);
  2980	
  2981		/* Caller should ensure the folio exists. */
  2982		ASSERT(eb->folios[i]);
  2983	
  2984	retry:
  2985		/*
  2986		 * Btree inode is a btrfs internal inode, and not exposed to any
  2987		 * user.
  2988		 * Furthermore we do not want any cgroup limits on this inode.
  2989		 * So we always use root_mem_cgroup as our active memcg when attaching
  2990		 * the folios.
  2991		 */
> 2992		old_memcg = set_active_memcg(root_mem_cgroup);
  2993		ret = filemap_add_folio(mapping, eb->folios[i], index + i,
  2994					GFP_NOFS | __GFP_NOFAIL);
  2995		set_active_memcg(old_memcg);
  2996		if (!ret)
  2997			goto finish;
  2998	
  2999		existing_folio = filemap_lock_folio(mapping, index + i);
  3000		/* The page cache only exists for a very short time, just retry. */
  3001		if (IS_ERR(existing_folio)) {
  3002			existing_folio = NULL;
  3003			goto retry;
  3004		}
  3005	
  3006		/* For now, we should only have single-page folios for btree inode. */
  3007		ASSERT(folio_nr_pages(existing_folio) == 1);
  3008	
  3009		if (folio_size(existing_folio) != eb->folio_size) {
  3010			folio_unlock(existing_folio);
  3011			folio_put(existing_folio);
  3012			return -EAGAIN;
  3013		}
  3014	
  3015	finish:
  3016		spin_lock(&mapping->i_private_lock);
  3017		if (existing_folio && fs_info->nodesize < PAGE_SIZE) {
  3018			/* We're going to reuse the existing page, can drop our folio now. */
  3019			__free_page(folio_page(eb->folios[i], 0));
  3020			eb->folios[i] = existing_folio;
  3021		} else if (existing_folio) {
  3022			struct extent_buffer *existing_eb;
  3023	
  3024			existing_eb = grab_extent_buffer(fs_info,
  3025							 folio_page(existing_folio, 0));
  3026			if (existing_eb) {
  3027				/* The extent buffer still exists, we can use it directly. */
  3028				*found_eb_ret = existing_eb;
  3029				spin_unlock(&mapping->i_private_lock);
  3030				folio_unlock(existing_folio);
  3031				folio_put(existing_folio);
  3032				return 1;
  3033			}
  3034			/* The extent buffer no longer exists, we can reuse the folio. */
  3035			__free_page(folio_page(eb->folios[i], 0));
  3036			eb->folios[i] = existing_folio;
  3037		}
  3038		eb->folio_size = folio_size(eb->folios[i]);
  3039		eb->folio_shift = folio_shift(eb->folios[i]);
  3040		/* Should not fail, as we have preallocated the memory. */
  3041		ret = attach_extent_buffer_folio(eb, eb->folios[i], prealloc);
  3042		ASSERT(!ret);
  3043		/*
  3044		 * To inform we have an extra eb under allocation, so that
  3045		 * detach_extent_buffer_page() won't release the folio private when the
  3046		 * eb hasn't been inserted into radix tree yet.
  3047		 *
  3048		 * The ref will be decreased when the eb releases the page, in
  3049		 * detach_extent_buffer_page().  Thus needs no special handling in the
  3050		 * error path.
  3051		 */
  3052		btrfs_folio_inc_eb_refs(fs_info, eb->folios[i]);
  3053		spin_unlock(&mapping->i_private_lock);
  3054		return 0;
  3055	}
  3056	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

