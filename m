Return-Path: <linux-btrfs+bounces-12111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C84A57C86
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Mar 2025 18:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F374B3B064F
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Mar 2025 17:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6258D1E9B0E;
	Sat,  8 Mar 2025 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0NzoyH3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70BD528
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Mar 2025 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741456161; cv=none; b=hlS+KIZObf3c19nXOnwsrvVW0MiVDBrq52SVIkrhTse/9btApfzZiZUmKAVtZvT/xhKTjJ3nWp2r2gFah5QtZdjXPWS9sEdImDcrZbDKbzFasBT4qUtQmdmX+6yVkuBNUtAeGFEAXqbyr6mxVmqCJOHSruQqGbo/eVMfsvh7Hi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741456161; c=relaxed/simple;
	bh=sp7v80xpaznIvmnItT1wH0F7vEXqhErdcmMSDkebixY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYvmSenIJvcRqRAaU6L/anw86RlaCBJ5XyvwHWoneqpVtd+Bh96C3zDqAQ8u1/mUxLksSYYLF/emZkdfizgKBDsdolTablPbk9wGMtrx5W/rQ0zr5D+ZS/48tFBIdUgRzc6EUwIeHTUu0EOW4Wqp1zr7C0wuOEq1CS8bXMJ/YUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0NzoyH3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741456159; x=1772992159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sp7v80xpaznIvmnItT1wH0F7vEXqhErdcmMSDkebixY=;
  b=l0NzoyH3T50y6I4/N8ZMinIzZJy8E1/XNE8czA1VXSxJPvEECQKVKsLF
   i830WfceIG1t2tPawrTNLbnXPH+RzW5AGrOhCZlFLWwoAk29xw4Q18lUa
   aWahxeLNfeGLerYh9zq9En07syWlnZHcu6YOJwDEYlBSwORcPYrnGjplg
   0KLvwMwAomkBWxrL5fmjQWn75wXFh3aCkzKCTkr2S9uZ03lVaMEI5X+ik
   rMt8bvzuj2fTzZg7A85OXyZA6FZPRCpC0Ei2y3uKfmAH9kdRtWi+xsvpK
   5pIO/B7tM8XfY61yAZKd/qPBmFw0LFvVOeFe8CjU7dnOt61cHeg4bGRbh
   w==;
X-CSE-ConnectionGUID: gkPdjpTQSICOL8mmird7Jw==
X-CSE-MsgGUID: I/QKmr9rRUahR/O28GueYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="52699883"
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="52699883"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 09:49:19 -0800
X-CSE-ConnectionGUID: b5faxIkgT2CbQTiVKbDyrA==
X-CSE-MsgGUID: qDLejKgIRJ2/xpEMe8+bnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="120079533"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 08 Mar 2025 09:49:17 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqyIV-00029W-2H;
	Sat, 08 Mar 2025 17:49:15 +0000
Date: Sun, 9 Mar 2025 01:48:25 +0800
From: kernel test robot <lkp@intel.com>
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 4/8] btrfs: make btrfs_iget() return a btrfs inode instead
Message-ID: <202503090344.SeJrOfHD-lkp@intel.com>
References: <f6d2a09fb43742fb5be38f820908510e298f8d40.1741354479.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6d2a09fb43742fb5be38f820908510e298f8d40.1741354479.git.fdmanana@suse.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on next-20250307]
[cannot apply to linus/master v6.14-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/fdmanana-kernel-org/btrfs-return-a-btrfs_inode-from-btrfs_iget_logging/20250307-214724
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/f6d2a09fb43742fb5be38f820908510e298f8d40.1741354479.git.fdmanana%40suse.com
patch subject: [PATCH 4/8] btrfs: make btrfs_iget() return a btrfs inode instead
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250309/202503090344.SeJrOfHD-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250309/202503090344.SeJrOfHD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503090344.SeJrOfHD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/btrfs/send.c:11:
   In file included from include/linux/xattr.h:18:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> fs/btrfs/send.c:5535:8: error: incompatible pointer types assigning to 'struct inode *' from 'struct btrfs_inode *' [-Werror,-Wincompatible-pointer-types]
    5535 |         inode = btrfs_iget(sctx->cur_ino, root);
         |               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   3 warnings and 1 error generated.


vim +5535 fs/btrfs/send.c

16e7549f045d33b Josef Bacik   2013-10-22  5519  
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5520  static int send_encoded_inline_extent(struct send_ctx *sctx,
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5521  				      struct btrfs_path *path, u64 offset,
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5522  				      u64 len)
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5523  {
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5524  	struct btrfs_root *root = sctx->send_root;
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5525  	struct btrfs_fs_info *fs_info = root->fs_info;
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5526  	struct inode *inode;
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5527  	struct fs_path *fspath;
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5528  	struct extent_buffer *leaf = path->nodes[0];
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5529  	struct btrfs_key key;
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5530  	struct btrfs_file_extent_item *ei;
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5531  	u64 ram_bytes;
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5532  	size_t inline_size;
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5533  	int ret;
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5534  
d13240dd0a2d13b Filipe Manana 2024-06-13 @5535  	inode = btrfs_iget(sctx->cur_ino, root);
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5536  	if (IS_ERR(inode))
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5537  		return PTR_ERR(inode);
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5538  
6054b503e2eafac Filipe Manana 2025-02-18  5539  	fspath = get_cur_inode_path(sctx);
6054b503e2eafac Filipe Manana 2025-02-18  5540  	if (IS_ERR(fspath)) {
6054b503e2eafac Filipe Manana 2025-02-18  5541  		ret = PTR_ERR(fspath);
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5542  		goto out;
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5543  	}
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5544  
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5545  	ret = begin_cmd(sctx, BTRFS_SEND_C_ENCODED_WRITE);
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5546  	if (ret < 0)
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5547  		goto out;
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5548  
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5549  	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5550  	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5551  	ram_bytes = btrfs_file_extent_ram_bytes(leaf, ei);
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5552  	inline_size = btrfs_file_extent_inline_item_len(leaf, path->slots[0]);
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5553  
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5554  	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, fspath);
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5555  	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5556  	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_FILE_LEN,
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5557  		    min(key.offset + ram_bytes - offset, len));
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5558  	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_LEN, ram_bytes);
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5559  	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_OFFSET, offset - key.offset);
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5560  	ret = btrfs_encoded_io_compression_from_extent(fs_info,
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5561  				btrfs_file_extent_compression(leaf, ei));
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5562  	if (ret < 0)
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5563  		goto out;
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5564  	TLV_PUT_U32(sctx, BTRFS_SEND_A_COMPRESSION, ret);
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5565  
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5566  	ret = put_data_header(sctx, inline_size);
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5567  	if (ret < 0)
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5568  		goto out;
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5569  	read_extent_buffer(leaf, sctx->send_buf + sctx->send_size,
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5570  			   btrfs_file_extent_inline_start(ei), inline_size);
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5571  	sctx->send_size += inline_size;
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5572  
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5573  	ret = send_cmd(sctx);
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5574  
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5575  tlv_put_failure:
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5576  out:
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5577  	iput(inode);
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5578  	return ret;
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5579  }
3ea4dc5bf00c7d1 Omar Sandoval 2022-03-17  5580  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

