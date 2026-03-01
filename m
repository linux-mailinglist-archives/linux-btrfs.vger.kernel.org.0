Return-Path: <linux-btrfs+bounces-22130-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALPSGgUypGnZaAUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22130-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 13:33:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C17081CF9BF
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 13:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5089301368A
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2026 12:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E831831715F;
	Sun,  1 Mar 2026 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKbTmKxm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE20184524
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Mar 2026 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772368332; cv=none; b=cijx2d8lKdkNAwnt8qSPjbOZMVqYIzttUQs15ZovVFS9KOXOqMPo29WwpR6dzR2BpJ9DGn/UolzM9aInPQURzeG2XzU/9ewELSWZIXD412ALn/4t2LyDtjO2H2cJ0zo5ORbI1g3g+ZJU+K4ZLnt708CnClQhBdT69VvVo75hcmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772368332; c=relaxed/simple;
	bh=uRNyj79yEJPu2ftsJe+/RGtJ0mZsbDoL/eQlGwFoV0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITUq2rQ7QEs0xBPAfeErhignKu4XzInbTbbCuMNN7M2HMbaeB1RtIw3qpCz200Ic9Ou81Xgx8BUXRf6n2ykM5P9rf2I7TRPiAHNtHNNY0ogalH/UtJtihau2sXsm29IphUq7dxKZVFmOu22FA7OS9IA9cfna5YTMShZiFtOhOn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKbTmKxm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772368329; x=1803904329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uRNyj79yEJPu2ftsJe+/RGtJ0mZsbDoL/eQlGwFoV0M=;
  b=OKbTmKxmDutm8UWYsqtN7hUGNGy3nYY2sdwtj70OlVGNrvLaj69DeUQv
   078okaiSyzWY7y8BaJvjTC4pBUULGP9UFScsFmo1tkZ6K4DOPUp2PW3wl
   EswV5pikqaWHPIBe752CkOwZUmmifUtfisPf3KtkFQJGHLrfSFrD4cpwV
   puTDmyCX34fat7C5Kg3ZO5LzFn6+w1medRsacCmwbyxrv087evy2RBl9/
   NQA2ABVv6bsbcZKnqIrEF3cg0H+riYgx0v6Y0orL3abQFO1LVqEIBXvHc
   BV4RIs4A5W1y6qSJ2M7C4PoFWJnw8nm9FWL2FD5XSFNVZsGyQjAukBQA/
   A==;
X-CSE-ConnectionGUID: UDvLSiuQQAC8Pt9dtb7+bg==
X-CSE-MsgGUID: G4iGty0hQ0uQMPO/OfkIRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11715"; a="73438773"
X-IronPort-AV: E=Sophos;i="6.21,318,1763452800"; 
   d="scan'208";a="73438773"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 04:32:09 -0800
X-CSE-ConnectionGUID: yFfGrSWARPC1eygDPBzumg==
X-CSE-MsgGUID: 4zef/lyIRtiKuQj3WcgOjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,318,1763452800"; 
   d="scan'208";a="217478473"
Received: from lkp-server01.sh.intel.com (HELO 59784f1c7b2a) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 01 Mar 2026 04:32:07 -0800
Received: from kbuild by 59784f1c7b2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwfxr-000000001Rp-3iki;
	Sun, 01 Mar 2026 12:32:03 +0000
Date: Sun, 1 Mar 2026 20:31:58 +0800
From: kernel test robot <lkp@intel.com>
To: Hongbo Li <lihongbo22@huawei.com>, clm@fb.com, dsterba@suse.com,
	josef@toxicpanda.com, wqu@suse.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	lihongbo22@huawei.com, fdmanana@suse.com,
	linux-btrfs@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH 6.6 v2] btrfs: free path if inline extents in
 range_is_hole_in_parent()
Message-ID: <202603012047.GqC1IRml-lkp@intel.com>
References: <20260227075219.2594937-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227075219.2594937-1-lihongbo22@huawei.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-22130-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C17081CF9BF
X-Rspamd-Action: no action

Hi Hongbo,

kernel test robot noticed the following build errors:

[auto build test ERROR on v7.0-rc1]
[also build test ERROR on linus/master next-20260227]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongbo-Li/btrfs-free-path-if-inline-extents-in-range_is_hole_in_parent/20260227-155544
base:   v7.0-rc1
patch link:    https://lore.kernel.org/r/20260227075219.2594937-1-lihongbo22%40huawei.com
patch subject: [PATCH 6.6 v2] btrfs: free path if inline extents in range_is_hole_in_parent()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260301/202603012047.GqC1IRml-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260301/202603012047.GqC1IRml-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603012047.GqC1IRml-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/btrfs/send.c:6388:9: error: use of undeclared label 'out'
    6388 |                         goto out;
         |                              ^
   1 error generated.


vim +/out +6388 fs/btrfs/send.c

  6334	
  6335	static int range_is_hole_in_parent(struct send_ctx *sctx,
  6336					   const u64 start,
  6337					   const u64 end)
  6338	{
  6339		BTRFS_PATH_AUTO_FREE(path);
  6340		struct btrfs_key key;
  6341		struct btrfs_root *root = sctx->parent_root;
  6342		u64 search_start = start;
  6343		int ret;
  6344	
  6345		path = alloc_path_for_send();
  6346		if (!path)
  6347			return -ENOMEM;
  6348	
  6349		key.objectid = sctx->cur_ino;
  6350		key.type = BTRFS_EXTENT_DATA_KEY;
  6351		key.offset = search_start;
  6352		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
  6353		if (ret < 0)
  6354			return ret;
  6355		if (ret > 0 && path->slots[0] > 0)
  6356			path->slots[0]--;
  6357	
  6358		while (search_start < end) {
  6359			struct extent_buffer *leaf = path->nodes[0];
  6360			int slot = path->slots[0];
  6361			struct btrfs_file_extent_item *fi;
  6362			u64 extent_end;
  6363	
  6364			if (slot >= btrfs_header_nritems(leaf)) {
  6365				ret = btrfs_next_leaf(root, path);
  6366				if (ret < 0)
  6367					return ret;
  6368				if (ret > 0)
  6369					break;
  6370				continue;
  6371			}
  6372	
  6373			btrfs_item_key_to_cpu(leaf, &key, slot);
  6374			if (key.objectid < sctx->cur_ino ||
  6375			    key.type < BTRFS_EXTENT_DATA_KEY)
  6376				goto next;
  6377			if (key.objectid > sctx->cur_ino ||
  6378			    key.type > BTRFS_EXTENT_DATA_KEY ||
  6379			    key.offset >= end)
  6380				break;
  6381	
  6382			fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
  6383			extent_end = btrfs_file_extent_end(path);
  6384			if (extent_end <= start)
  6385				goto next;
  6386			if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
  6387				ret = 0;
> 6388				goto out;
  6389			}
  6390			if (btrfs_file_extent_disk_bytenr(leaf, fi) == 0) {
  6391				search_start = extent_end;
  6392				goto next;
  6393			}
  6394			return 0;
  6395	next:
  6396			path->slots[0]++;
  6397		}
  6398		return 1;
  6399	}
  6400	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

