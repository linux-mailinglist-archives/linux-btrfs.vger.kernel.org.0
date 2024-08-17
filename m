Return-Path: <linux-btrfs+bounces-7304-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE38955A0B
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Aug 2024 00:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FFD51F218DE
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Aug 2024 22:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A376146A9F;
	Sat, 17 Aug 2024 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDryxbQG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F768C0B
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Aug 2024 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723934578; cv=none; b=aGU2HEmuB5339WveetOC43WRcrHEJ7UG+LlM7XXC/OOQ+gx1+DKz5sjUBvxdfbBMzXisQXRgisOjSKE3pmVonWKMo5hf+xwg7bgKct8jOk7KL+8OH33itqpQcvwCVOoaJx6NSXz34NjcWiaKti3QdS2l5cnou5Sy/s+3UufpCuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723934578; c=relaxed/simple;
	bh=C2DXFZ2ExMCea4YTAJOOEe3HdjJLJkKqqxX3e/u3pyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwxoSZ2rlwPBpaWIDzlxiSSqG9M0XQf+bKw7BIx9zj3J1nxPOAc3oOXScBQbdDwe+Re5xkIM3Z7wB4zKV0JAKcQ0zdyf7fferDae73Em99+vvV2Z4twZconvy7bkJWhYJ0wHshuw/f3DTHi0X/SSkEdmqTdREYFCqK3QhF3stOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDryxbQG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723934576; x=1755470576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C2DXFZ2ExMCea4YTAJOOEe3HdjJLJkKqqxX3e/u3pyk=;
  b=TDryxbQGPDS6HMAS5RrO2uCVa/XskwAQqFBSRPyx6zPkhcTR088n1R20
   TMiK1R0tUMTxPoE5FH0mqnCue6QQ/cZEG5sVxw64mt2iMYuIOjD7Js6tS
   Jn8BENWpHhBP+wv3NGEHe7MkbQYaZn5F57z2+XGGuZhEFu8VnyPlRBHaC
   xEG7fOaw3V9tbYsiffN2HMzzvdU7hn/X4431uBIgqyz91JhUQ054Z3tyF
   LYp7g94tn0baMnperge8FGhnqqH5Z4A/c1CY323fJr2Je/AEx5Mng1ojg
   4jbY8eoltWm2VINIBsBobhstzZ7VGN15vnMxRUoknzHyHevkFLRkyIoHR
   A==;
X-CSE-ConnectionGUID: 7C2ElRBeTRS9hbq0lanp+g==
X-CSE-MsgGUID: L+3kcnc0Roi2XInrODJqYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11167"; a="22171588"
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="22171588"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 15:42:55 -0700
X-CSE-ConnectionGUID: NGSCVnz0TECKR7g4IDbf8A==
X-CSE-MsgGUID: ED7D8kDLT+SV7FfRKgKs+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="60042063"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Aug 2024 15:42:54 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfS8J-0007r9-2x;
	Sat, 17 Aug 2024 22:42:51 +0000
Date: Sun, 18 Aug 2024 06:42:13 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: fix a use-after-free bug when hitting errors
 inside btrfs_submit_chunk()
Message-ID: <202408180546.vnwFs9i3-lkp@intel.com>
References: <25987ba63d6e11a6983bf2c57eb2ac8efe059d8e.1723897285.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25987ba63d6e11a6983bf2c57eb2ac8efe059d8e.1723897285.git.wqu@suse.com>

Hi Qu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master v6.11-rc3 next-20240816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-fix-a-use-after-free-bug-when-hitting-errors-inside-btrfs_submit_chunk/20240817-202316
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/25987ba63d6e11a6983bf2c57eb2ac8efe059d8e.1723897285.git.wqu%40suse.com
patch subject: [PATCH] btrfs: fix a use-after-free bug when hitting errors inside btrfs_submit_chunk()
config: arc-randconfig-002-20240818 (https://download.01.org/0day-ci/archive/20240818/202408180546.vnwFs9i3-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240818/202408180546.vnwFs9i3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408180546.vnwFs9i3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/btrfs/bio.c: In function 'btrfs_submit_chunk':
>> fs/btrfs/bio.c:671:27: warning: unused variable 'orig_bbio' [-Wunused-variable]
     671 |         struct btrfs_bio *orig_bbio = bbio;
         |                           ^~~~~~~~~


vim +/orig_bbio +671 fs/btrfs/bio.c

f8a53bb58ec7e21 Christoph Hellwig  2023-01-21  666  
ae42a154ca89727 Christoph Hellwig  2023-03-07  667  static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
103c19723c80bf7 Christoph Hellwig  2022-11-15  668  {
d5e4377d505189c Christoph Hellwig  2023-01-21  669  	struct btrfs_inode *inode = bbio->inode;
4317ff0056bedfc Qu Wenruo          2023-03-23  670  	struct btrfs_fs_info *fs_info = bbio->fs_info;
852eee62d31abd6 Christoph Hellwig  2023-01-21 @671  	struct btrfs_bio *orig_bbio = bbio;
ae42a154ca89727 Christoph Hellwig  2023-03-07  672  	struct bio *bio = &bbio->bio;
adbe7e388e4239d Anand Jain         2023-04-15  673  	u64 logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
103c19723c80bf7 Christoph Hellwig  2022-11-15  674  	u64 length = bio->bi_iter.bi_size;
103c19723c80bf7 Christoph Hellwig  2022-11-15  675  	u64 map_length = length;
921603c76246a7f Christoph Hellwig  2022-12-12  676  	bool use_append = btrfs_use_zone_append(bbio);
103c19723c80bf7 Christoph Hellwig  2022-11-15  677  	struct btrfs_io_context *bioc = NULL;
103c19723c80bf7 Christoph Hellwig  2022-11-15  678  	struct btrfs_io_stripe smap;
9ba0004bd95e059 Christoph Hellwig  2023-01-21  679  	blk_status_t ret;
9ba0004bd95e059 Christoph Hellwig  2023-01-21  680  	int error;
103c19723c80bf7 Christoph Hellwig  2022-11-15  681  
31ae7881f9cd502 Johannes Thumshirn 2024-07-31  682  	if (!bbio->inode || btrfs_is_data_reloc_root(inode->root))
31ae7881f9cd502 Johannes Thumshirn 2024-07-31  683  		smap.rst_search_commit_root = true;
31ae7881f9cd502 Johannes Thumshirn 2024-07-31  684  	else
31ae7881f9cd502 Johannes Thumshirn 2024-07-31  685  		smap.rst_search_commit_root = false;
9acaa64187f9b4c Johannes Thumshirn 2023-09-14  686  
103c19723c80bf7 Christoph Hellwig  2022-11-15  687  	btrfs_bio_counter_inc_blocked(fs_info);
cd4efd210edfb34 Christoph Hellwig  2023-05-31  688  	error = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
9fb2acc2fe07f15 Qu Wenruo          2023-09-17  689  				&bioc, &smap, &mirror_num);
9ba0004bd95e059 Christoph Hellwig  2023-01-21  690  	if (error) {
9ba0004bd95e059 Christoph Hellwig  2023-01-21  691  		ret = errno_to_blk_status(error);
9ba0004bd95e059 Christoph Hellwig  2023-01-21  692  		goto fail;
103c19723c80bf7 Christoph Hellwig  2022-11-15  693  	}
103c19723c80bf7 Christoph Hellwig  2022-11-15  694  
852eee62d31abd6 Christoph Hellwig  2023-01-21  695  	map_length = min(map_length, length);
d5e4377d505189c Christoph Hellwig  2023-01-21  696  	if (use_append)
d5e4377d505189c Christoph Hellwig  2023-01-21  697  		map_length = min(map_length, fs_info->max_zone_append_size);
d5e4377d505189c Christoph Hellwig  2023-01-21  698  
103c19723c80bf7 Christoph Hellwig  2022-11-15  699  	if (map_length < length) {
2cef0c79bb81d8b Christoph Hellwig  2023-03-07  700  		bbio = btrfs_split_bio(fs_info, bbio, map_length, use_append);
2cef0c79bb81d8b Christoph Hellwig  2023-03-07  701  		bio = &bbio->bio;
103c19723c80bf7 Christoph Hellwig  2022-11-15  702  	}
103c19723c80bf7 Christoph Hellwig  2022-11-15  703  
1c2b3ee3b0ec4bc Christoph Hellwig  2023-01-21  704  	/*
1c2b3ee3b0ec4bc Christoph Hellwig  2023-01-21  705  	 * Save the iter for the end_io handler and preload the checksums for
1c2b3ee3b0ec4bc Christoph Hellwig  2023-01-21  706  	 * data reads.
1c2b3ee3b0ec4bc Christoph Hellwig  2023-01-21  707  	 */
fbe960877b6f434 Christoph Hellwig  2023-05-31  708  	if (bio_op(bio) == REQ_OP_READ && is_data_bbio(bbio)) {
0d3acb25e70d5f5 Christoph Hellwig  2023-01-21  709  		bbio->saved_iter = bio->bi_iter;
1c2b3ee3b0ec4bc Christoph Hellwig  2023-01-21  710  		ret = btrfs_lookup_bio_sums(bbio);
1c2b3ee3b0ec4bc Christoph Hellwig  2023-01-21  711  		if (ret)
852eee62d31abd6 Christoph Hellwig  2023-01-21  712  			goto fail_put_bio;
1c2b3ee3b0ec4bc Christoph Hellwig  2023-01-21  713  	}
7276aa7d38255b4 Christoph Hellwig  2023-01-21  714  
f8a53bb58ec7e21 Christoph Hellwig  2023-01-21  715  	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
d5e4377d505189c Christoph Hellwig  2023-01-21  716  		if (use_append) {
d5e4377d505189c Christoph Hellwig  2023-01-21  717  			bio->bi_opf &= ~REQ_OP_WRITE;
d5e4377d505189c Christoph Hellwig  2023-01-21  718  			bio->bi_opf |= REQ_OP_ZONE_APPEND;
69ccf3f4244abc5 Christoph Hellwig  2023-01-21  719  		}
69ccf3f4244abc5 Christoph Hellwig  2023-01-21  720  
02c372e1f016e51 Johannes Thumshirn 2023-09-14  721  		if (is_data_bbio(bbio) && bioc &&
02c372e1f016e51 Johannes Thumshirn 2023-09-14  722  		    btrfs_need_stripe_tree_update(bioc->fs_info, bioc->map_type)) {
02c372e1f016e51 Johannes Thumshirn 2023-09-14  723  			/*
02c372e1f016e51 Johannes Thumshirn 2023-09-14  724  			 * No locking for the list update, as we only add to
02c372e1f016e51 Johannes Thumshirn 2023-09-14  725  			 * the list in the I/O submission path, and list
02c372e1f016e51 Johannes Thumshirn 2023-09-14  726  			 * iteration only happens in the completion path, which
02c372e1f016e51 Johannes Thumshirn 2023-09-14  727  			 * can't happen until after the last submission.
02c372e1f016e51 Johannes Thumshirn 2023-09-14  728  			 */
02c372e1f016e51 Johannes Thumshirn 2023-09-14  729  			btrfs_get_bioc(bioc);
02c372e1f016e51 Johannes Thumshirn 2023-09-14  730  			list_add_tail(&bioc->rst_ordered_entry, &bbio->ordered->bioc_list);
02c372e1f016e51 Johannes Thumshirn 2023-09-14  731  		}
02c372e1f016e51 Johannes Thumshirn 2023-09-14  732  
f8a53bb58ec7e21 Christoph Hellwig  2023-01-21  733  		/*
f8a53bb58ec7e21 Christoph Hellwig  2023-01-21  734  		 * Csum items for reloc roots have already been cloned at this
f8a53bb58ec7e21 Christoph Hellwig  2023-01-21  735  		 * point, so they are handled as part of the no-checksum case.
f8a53bb58ec7e21 Christoph Hellwig  2023-01-21  736  		 */
4317ff0056bedfc Qu Wenruo          2023-03-23  737  		if (inode && !(inode->flags & BTRFS_INODE_NODATASUM) &&
169aaaf2e0be615 Qu Wenruo          2024-06-14  738  		    !test_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state) &&
d5e4377d505189c Christoph Hellwig  2023-01-21  739  		    !btrfs_is_data_reloc_root(inode->root)) {
f8a53bb58ec7e21 Christoph Hellwig  2023-01-21  740  			if (should_async_write(bbio) &&
f8a53bb58ec7e21 Christoph Hellwig  2023-01-21  741  			    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
852eee62d31abd6 Christoph Hellwig  2023-01-21  742  				goto done;
103c19723c80bf7 Christoph Hellwig  2022-11-15  743  
f8a53bb58ec7e21 Christoph Hellwig  2023-01-21  744  			ret = btrfs_bio_csum(bbio);
f8a53bb58ec7e21 Christoph Hellwig  2023-01-21  745  			if (ret)
852eee62d31abd6 Christoph Hellwig  2023-01-21  746  				goto fail_put_bio;
cebae292e0c32a2 Johannes Thumshirn 2024-06-07  747  		} else if (use_append ||
cebae292e0c32a2 Johannes Thumshirn 2024-06-07  748  			   (btrfs_is_zoned(fs_info) && inode &&
cebae292e0c32a2 Johannes Thumshirn 2024-06-07  749  			    inode->flags & BTRFS_INODE_NODATASUM)) {
cbfce4c7fbde23c Christoph Hellwig  2023-05-24  750  			ret = btrfs_alloc_dummy_sum(bbio);
cbfce4c7fbde23c Christoph Hellwig  2023-05-24  751  			if (ret)
cbfce4c7fbde23c Christoph Hellwig  2023-05-24  752  				goto fail_put_bio;
f8a53bb58ec7e21 Christoph Hellwig  2023-01-21  753  		}
103c19723c80bf7 Christoph Hellwig  2022-11-15  754  	}
f8a53bb58ec7e21 Christoph Hellwig  2023-01-21  755  
f8a53bb58ec7e21 Christoph Hellwig  2023-01-21  756  	__btrfs_submit_bio(bio, bioc, &smap, mirror_num);
852eee62d31abd6 Christoph Hellwig  2023-01-21  757  done:
852eee62d31abd6 Christoph Hellwig  2023-01-21  758  	return map_length == length;
9ba0004bd95e059 Christoph Hellwig  2023-01-21  759  
852eee62d31abd6 Christoph Hellwig  2023-01-21  760  fail_put_bio:
852eee62d31abd6 Christoph Hellwig  2023-01-21  761  	if (map_length < length)
ec63b84d4611b2f Christoph Hellwig  2023-05-31  762  		btrfs_cleanup_bio(bbio);
9ba0004bd95e059 Christoph Hellwig  2023-01-21  763  fail:
9ba0004bd95e059 Christoph Hellwig  2023-01-21  764  	btrfs_bio_counter_dec(fs_info);
75f0d5c40c2c2f5 Qu Wenruo          2024-08-17  765  	bbio->bio.bi_status = ret;
75f0d5c40c2c2f5 Qu Wenruo          2024-08-17  766  	btrfs_orig_bbio_end_io(bbio);
852eee62d31abd6 Christoph Hellwig  2023-01-21  767  	/* Do not submit another chunk */
852eee62d31abd6 Christoph Hellwig  2023-01-21  768  	return true;
852eee62d31abd6 Christoph Hellwig  2023-01-21  769  }
852eee62d31abd6 Christoph Hellwig  2023-01-21  770  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

