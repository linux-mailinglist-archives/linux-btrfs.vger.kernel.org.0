Return-Path: <linux-btrfs+bounces-14527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46080AD012E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 13:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB04C179E98
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 11:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE112882AE;
	Fri,  6 Jun 2025 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pl0/VHvD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5D12853EE
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749208908; cv=none; b=qBcktisUVK4TrbqTiwKk4LxSSMxCIAqAlsO8J1MtwCeWxtok5asyWAsqTbAapIAr0mc9CwotjVl7wsncaNkfnXlT/gOzSN2lTqYXX8JiLJh9D4Q8RJ+8SxNzQjyshlOzZ6IJ8OtuZ3eid81pbpd6x1wGbHBTteUptOCV3Chzg+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749208908; c=relaxed/simple;
	bh=WRFxejyU3N8q0Vg9ORaH/lGeIKYH5zrahWgn4qaPWw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktdvgcUA47ivQLUKYtX7j9dyRAdI9j6h2gkzC4QJJsiaWUtyr1OsNR9u2YrIyvjZwWoPrc9sB7vm3O/5V5woqUyJ65rQRnmB7OBaKWhuw0oRMu+6mdz7v2TAdLqXNe2efgDIqEL9stQSBw1iCZO0hlKCUjkr8HZUGIber1IqcQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pl0/VHvD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749208907; x=1780744907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WRFxejyU3N8q0Vg9ORaH/lGeIKYH5zrahWgn4qaPWw8=;
  b=Pl0/VHvDbr7juI8EPRUw2oVSVL4VL6QauOlDOgl+3B8LZWyuywfVld54
   XjsJrB3ZWfFEND2bkpj8fExdErtCupSWByIHXYYlXYZzuP1LfFwV3OcWN
   CFkLdplYMy6JJzlaNqLKJVEpbG6yj6y7YIMy5SFFxGt48sD1RgboeSXNe
   kAwXaQsLeKIhrdT0brSIkLYEqhVV/Fpmcad8axwihUlk3fzA92t5pFzsQ
   GLW12zEE94Sr+lus0SQ5NxyufxM7/Yl/tNdsr1bfCbYdIaLUP/i0zGANK
   dNWEvpGEzbNx7lLM11xIen4o16N5bu0MVl34ZV2bbEV9tm7TnmcK4dtKL
   g==;
X-CSE-ConnectionGUID: 3ZjCCs48Q0yokrya92i9VQ==
X-CSE-MsgGUID: XMPoO4vASvua9+j2+U6lkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="53981720"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="53981720"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 04:21:46 -0700
X-CSE-ConnectionGUID: ouYuD+YQTP+esAD5Xn8F3w==
X-CSE-MsgGUID: vyNPZ3YlQ16QvULRhi1YkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="145676923"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jun 2025 04:21:44 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNV8j-0004wv-2d;
	Fri, 06 Jun 2025 11:21:37 +0000
Date: Fri, 6 Jun 2025 19:20:56 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Mark Harmstone <maharmstone@fb.com>
Subject: Re: [PATCH 11/12] btrfs: move existing remaps before relocating
 block group
Message-ID: <202506061952.ALl7BezR-lkp@intel.com>
References: <20250605162345.2561026-12-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605162345.2561026-12-maharmstone@fb.com>

Hi Mark,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master next-20250606]
[cannot apply to v6.15]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Harmstone/btrfs-add-definitions-and-constants-for-remap-tree/20250606-002804
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20250605162345.2561026-12-maharmstone%40fb.com
patch subject: [PATCH 11/12] btrfs: move existing remaps before relocating block group
config: csky-randconfig-r133-20250606 (https://download.01.org/0day-ci/archive/20250606/202506061952.ALl7BezR-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.3.0
reproduce: (https://download.01.org/0day-ci/archive/20250606/202506061952.ALl7BezR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506061952.ALl7BezR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/btrfs/relocation.c:4036:27: sparse: sparse: incorrect type in initializer (different base types) @@     expected int op @@     got restricted blk_opf_t @@
   fs/btrfs/relocation.c:4036:27: sparse:     expected int op
   fs/btrfs/relocation.c:4036:27: sparse:     got restricted blk_opf_t
>> fs/btrfs/relocation.c:4042:46: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted blk_opf_t [usertype] opf @@     got int op @@
   fs/btrfs/relocation.c:4042:46: sparse:     expected restricted blk_opf_t [usertype] opf
   fs/btrfs/relocation.c:4042:46: sparse:     got int op
   fs/btrfs/relocation.c:4053:62: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted blk_opf_t [usertype] opf @@     got int op @@
   fs/btrfs/relocation.c:4053:62: sparse:     expected restricted blk_opf_t [usertype] opf
   fs/btrfs/relocation.c:4053:62: sparse:     got int op

vim +4036 fs/btrfs/relocation.c

  4028	
  4029	static int copy_remapped_data_io(struct btrfs_fs_info *fs_info,
  4030					 struct reloc_io_private *priv,
  4031					 struct page **pages, u64 addr, u64 length,
  4032					 bool do_write)
  4033	{
  4034		struct btrfs_bio *bbio;
  4035		unsigned long i = 0;
> 4036		int op = do_write ? REQ_OP_WRITE : REQ_OP_READ;
  4037	
  4038		init_completion(&priv->done);
  4039		refcount_set(&priv->pending_refs, 1);
  4040		priv->status = 0;
  4041	
> 4042		bbio = btrfs_bio_alloc(BIO_MAX_VECS, op, fs_info, reloc_endio,
  4043				       priv);
  4044		bbio->bio.bi_iter.bi_sector = addr >> SECTOR_SHIFT;
  4045	
  4046		do {
  4047			size_t bytes = min_t(u64, length, PAGE_SIZE);
  4048	
  4049			if (bio_add_page(&bbio->bio, pages[i], bytes, 0) < bytes) {
  4050				refcount_inc(&priv->pending_refs);
  4051				btrfs_submit_bbio(bbio, 0);
  4052	
  4053				bbio = btrfs_bio_alloc(BIO_MAX_VECS, op, fs_info,
  4054						       reloc_endio, priv);
  4055				bbio->bio.bi_iter.bi_sector = addr >> SECTOR_SHIFT;
  4056				continue;
  4057			}
  4058	
  4059			i++;
  4060			addr += bytes;
  4061			length -= bytes;
  4062		} while (length);
  4063	
  4064		refcount_inc(&priv->pending_refs);
  4065		btrfs_submit_bbio(bbio, 0);
  4066	
  4067		if (!refcount_dec_and_test(&priv->pending_refs))
  4068			wait_for_completion_io(&priv->done);
  4069	
  4070		return blk_status_to_errno(READ_ONCE(priv->status));
  4071	}
  4072	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

