Return-Path: <linux-btrfs+bounces-9249-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD54E9B6516
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 15:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0CED1C21E97
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 14:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CB31F131C;
	Wed, 30 Oct 2024 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRQ6vm3k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA971EF94E;
	Wed, 30 Oct 2024 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296880; cv=none; b=Q8fv/w0gzBBAxzp6Ms0cTM1+eFpi5nOsxc8zth5rgZSTlbS+nN7zWFrLc/69C8G6GzCJNdtgP/keMGU1um9TgEQRH8PSX9U/dqwXDTdk9pLKd/0/8bfPOOeJpB050DBjWbQIVjwTExST6w5/aKNzIDiIb9kvRzS86ry3Ccg9R1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296880; c=relaxed/simple;
	bh=YIhTsercrbzL7x0w06FHLQISue1sNjFdKSssjAjGdqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBOCIbtN4NiGdMxYTBowpNTl9PzuhIqHTsUxZ29X5mCyIxdtQ/v33LdLytkLO4aiLkVkGuc8JSUhXbwrE9zNg0H2plhETyJO5U+Hf5Jy+1wxcFly7oz+4GFfv2jqTkuvgyEICOCyLhLduNGn9lcUibtrrB6i94fDdW/vGAAP+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRQ6vm3k; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730296876; x=1761832876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YIhTsercrbzL7x0w06FHLQISue1sNjFdKSssjAjGdqw=;
  b=kRQ6vm3kk2r5V1ZILNOAsabLdYexIAdZDf7N8M/WDS6QtEKxJzDfIfjh
   paZp8UkxWYp+YiUv5r9t20tqtTGqYMitjjE0I2ZRZ+pO6fyBXRDTA4wk8
   qPfqnLaVLpWvifHIUnX+YlmYtQHZMSaEZV29Lg5MTzYtB9REkkDboSr2k
   dfSnxoyW7iE3q13iv8vWYd2Bmqn4A4L1nG0vmKNDBc9rzAMFPpeMYzYzl
   LY3CJwgWUDd/dliUgqM1Nb+Gu8Nc4KtZWvWTO5lbvKBBY/21X70B6qCwX
   AHHMHrrlKmlWXeow/OtEMs/Pft6rzBpl7ccS3uUng1VBrRXJDRxTdf9yC
   g==;
X-CSE-ConnectionGUID: 1nskTdLHQPyhhWgvQIyNsw==
X-CSE-MsgGUID: onDg7ezQRguPbiZCVatVJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="29416464"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="29416464"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 07:01:15 -0700
X-CSE-ConnectionGUID: XO4nsi38RbOjeSgf09lQ9Q==
X-CSE-MsgGUID: M/qK/mcFRLO3gGzk/0zsnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87111576"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 30 Oct 2024 07:01:12 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t69G1-000euW-1b;
	Wed, 30 Oct 2024 14:01:09 +0000
Date: Wed, 30 Oct 2024 22:00:47 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Thumshirn <jth@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org, axboe@kernel.dk, song@kernel.org,
	yukuai3@huawei.com, hch@lst.de, martin.petersen@oracle.com,
	hare@suse.de, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: handle bio_split() error
Message-ID: <202410302118.6igPxwWv-lkp@intel.com>
References: <20241029091121.16281-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029091121.16281-1-jth@kernel.org>

Hi Johannes,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.12-rc5 next-20241030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Thumshirn/btrfs-handle-bio_split-error/20241029-171227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20241029091121.16281-1-jth%40kernel.org
patch subject: [PATCH] btrfs: handle bio_split() error
config: x86_64-randconfig-121-20241030 (https://download.01.org/0day-ci/archive/20241030/202410302118.6igPxwWv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241030/202410302118.6igPxwWv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410302118.6igPxwWv-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/btrfs/bio.c:694:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted blk_status_t [assigned] [usertype] ret @@     got long @@
   fs/btrfs/bio.c:694:29: sparse:     expected restricted blk_status_t [assigned] [usertype] ret
   fs/btrfs/bio.c:694:29: sparse:     got long
   fs/btrfs/bio.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:237:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:237:46: sparse: sparse: self-comparison always evaluates to false

vim +694 fs/btrfs/bio.c

   659	
   660	static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
   661	{
   662		struct btrfs_inode *inode = bbio->inode;
   663		struct btrfs_fs_info *fs_info = bbio->fs_info;
   664		struct bio *bio = &bbio->bio;
   665		u64 logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
   666		u64 length = bio->bi_iter.bi_size;
   667		u64 map_length = length;
   668		bool use_append = btrfs_use_zone_append(bbio);
   669		struct btrfs_io_context *bioc = NULL;
   670		struct btrfs_io_stripe smap;
   671		blk_status_t ret;
   672		int error;
   673	
   674		if (!bbio->inode || btrfs_is_data_reloc_root(inode->root))
   675			smap.rst_search_commit_root = true;
   676		else
   677			smap.rst_search_commit_root = false;
   678	
   679		btrfs_bio_counter_inc_blocked(fs_info);
   680		error = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
   681					&bioc, &smap, &mirror_num);
   682		if (error) {
   683			ret = errno_to_blk_status(error);
   684			goto fail;
   685		}
   686	
   687		map_length = min(map_length, length);
   688		if (use_append)
   689			map_length = btrfs_append_map_length(bbio, map_length);
   690	
   691		if (map_length < length) {
   692			bbio = btrfs_split_bio(fs_info, bbio, map_length);
   693			if (IS_ERR(bbio)) {
 > 694				ret = PTR_ERR(bbio);
   695				goto fail;
   696			}
   697			bio = &bbio->bio;
   698		}
   699	
   700		/*
   701		 * Save the iter for the end_io handler and preload the checksums for
   702		 * data reads.
   703		 */
   704		if (bio_op(bio) == REQ_OP_READ && is_data_bbio(bbio)) {
   705			bbio->saved_iter = bio->bi_iter;
   706			ret = btrfs_lookup_bio_sums(bbio);
   707			if (ret)
   708				goto fail;
   709		}
   710	
   711		if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
   712			if (use_append) {
   713				bio->bi_opf &= ~REQ_OP_WRITE;
   714				bio->bi_opf |= REQ_OP_ZONE_APPEND;
   715			}
   716	
   717			if (is_data_bbio(bbio) && bioc &&
   718			    btrfs_need_stripe_tree_update(bioc->fs_info, bioc->map_type)) {
   719				/*
   720				 * No locking for the list update, as we only add to
   721				 * the list in the I/O submission path, and list
   722				 * iteration only happens in the completion path, which
   723				 * can't happen until after the last submission.
   724				 */
   725				btrfs_get_bioc(bioc);
   726				list_add_tail(&bioc->rst_ordered_entry, &bbio->ordered->bioc_list);
   727			}
   728	
   729			/*
   730			 * Csum items for reloc roots have already been cloned at this
   731			 * point, so they are handled as part of the no-checksum case.
   732			 */
   733			if (inode && !(inode->flags & BTRFS_INODE_NODATASUM) &&
   734			    !test_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state) &&
   735			    !btrfs_is_data_reloc_root(inode->root)) {
   736				if (should_async_write(bbio) &&
   737				    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
   738					goto done;
   739	
   740				ret = btrfs_bio_csum(bbio);
   741				if (ret)
   742					goto fail;
   743			} else if (use_append ||
   744				   (btrfs_is_zoned(fs_info) && inode &&
   745				    inode->flags & BTRFS_INODE_NODATASUM)) {
   746				ret = btrfs_alloc_dummy_sum(bbio);
   747				if (ret)
   748					goto fail;
   749			}
   750		}
   751	
   752		btrfs_submit_bio(bio, bioc, &smap, mirror_num);
   753	done:
   754		return map_length == length;
   755	
   756	fail:
   757		btrfs_bio_counter_dec(fs_info);
   758		/*
   759		 * We have split the original bbio, now we have to end both the current
   760		 * @bbio and remaining one, as the remaining one will never be submitted.
   761		 */
   762		if (map_length < length) {
   763			struct btrfs_bio *remaining = bbio->private;
   764	
   765			ASSERT(bbio->bio.bi_pool == &btrfs_clone_bioset);
   766			ASSERT(remaining);
   767	
   768			btrfs_bio_end_io(remaining, ret);
   769		}
   770		btrfs_bio_end_io(bbio, ret);
   771		/* Do not submit another chunk */
   772		return true;
   773	}
   774	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

