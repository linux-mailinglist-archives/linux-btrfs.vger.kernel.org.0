Return-Path: <linux-btrfs+bounces-9255-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E36D9B6D41
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 21:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101081F21972
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 20:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703A01D318A;
	Wed, 30 Oct 2024 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDbTh8xn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2FB1D07A2
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 20:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318751; cv=none; b=Mjp5EipCXEV8d3neE/+sOeyERyCnoyxM8aNa3mhmVT5Q5SzJqevqFKNCFYZ3DcIRtKtmiKLZxo7amd+w4hmhpQbpDbAXJgUau0xVW+vE7U5gycShbb3+a96VjSjTaN4HW23xOCGEX9dGH8G2Coc1bibZsW4fMUMq3k3Ts5PSssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318751; c=relaxed/simple;
	bh=lkwtoRA5tvMUiCpjLAGYONGPDcS+xn0HGuOJP0Bh3dc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kA0xQviWo6Q2Fq8I+4xrZaacF4Qt0eHJIq62a/0z9d7RroctmUasmJUBOsXALzrL0+ZQrpKIW19yt9zrSTF4NgMLvOLDK0sla7XQlLuQ0i8xtT2fQiP8U5mt/mAGEI6zWxWbDe+YipsR1W8C5RM/LZgKs/OJ6cAeRrL0/yB2BKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CDbTh8xn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso1758435e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 13:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730318746; x=1730923546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BMYzWn3a9BZHBJmSLCvIY/w+pubGzIYYisFrSZ78I48=;
        b=CDbTh8xni7gt/fZC/QpUJta+7XxgsP6nM1iYI+yc36Uh5MZRuUVOudH4bKH3fj49sn
         1M5InDtuCThD8wXNGDFAy2+78AL6N/MbHG8Woa7mjuBuIT+8mk5/+I5g60/KEH4CFxPM
         rPVGsbn23SfMOFGa1YvGCfLgjOZSWgAKa8xh+KXNufUllaI6+1zGhj/dVLlIcqh6p0XH
         59D20lzthze2a7oC1+NYhX5fePMpeBaQU/SmKVZ6AAlyZwkvAgpXlk1qh5xbBHdIcnan
         hsDgS+VBMjf1Atzm6js6WIQipqyZpdoIp4UcdBT3+zpoo+aJ5lZ47xwI/Yt39SKOFGx0
         zrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730318746; x=1730923546;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMYzWn3a9BZHBJmSLCvIY/w+pubGzIYYisFrSZ78I48=;
        b=J9IVTGAJGQYPGoi7xwRwCwjWag/d3Nd5F9pcPAyM0TS9DTaF4VUgtb60swupx5lVbG
         h2dlVcuU4pwXYxK4iw5jzyaEKmh/8eMVpjRbQNHd4mPXxra9JaLUNQLYWrLHUTI/P1dD
         fBT8l3jdSybcJnhvKydHk6v/q5L4CX1Vc4hMHxQpYpYDPk0Mc/vQvhjI40+bomjAhErH
         yuowaIqz9zIQZQJ5Gi7UgRkcSYBW1ky7KGazeeRkXuyyIWa+EXnBQQSUxfy1z4aorzgl
         Qqmvy3ilMSo+cJ3pb0EN29RC9fnTMVu/ua86JbBRSc468AM2HqkESCjGiam2PLKNybhi
         Lhzw==
X-Forwarded-Encrypted: i=1; AJvYcCWTA37CqZZQ65Ng2omRy6PD1PzlW7WnaO5d4jBTbJ3ybgHRyAaJh+0E7txf211nTNHwjEQCzVRksY6vhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGcvQGnogCIzFtG4rAJrYEGcS23Zo/KWVaen+u79U0hFULrvAz
	BXuNYGY8Gx5gE76lRe3bxubcE0nzcLTUT9LoQ+KC5MV2Io/55OVtfysOU+WGsVM=
X-Google-Smtp-Source: AGHT+IEDH4m+a8rcy96TqWsPWN9s2UOIanCX22F1aRjED1fm8KzovyJb8Oo8tcsdMdF1fJbXALgUwQ==
X-Received: by 2002:a05:600c:1d28:b0:431:6060:8b16 with SMTP id 5b1f17b1804b1-4327b80055dmr7553265e9.30.1730318746063;
        Wed, 30 Oct 2024 13:05:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9a9a53sm30796495e9.30.2024.10.30.13.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:05:45 -0700 (PDT)
Date: Wed, 30 Oct 2024 23:05:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Johannes Thumshirn <jth@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	axboe@kernel.dk, song@kernel.org, yukuai3@huawei.com, hch@lst.de,
	martin.petersen@oracle.com, hare@suse.de,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: handle bio_split() error
Message-ID: <1cab6d9b-8493-4baf-8a44-602dc035ded6@stanley.mountain>
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

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Thumshirn/btrfs-handle-bio_split-error/20241029-171227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20241029091121.16281-1-jth%40kernel.org
patch subject: [PATCH] btrfs: handle bio_split() error
config: openrisc-randconfig-r072-20241030 (https://download.01.org/0day-ci/archive/20241031/202410310231.WMcRwBhG-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202410310231.WMcRwBhG-lkp@intel.com/

smatch warnings:
fs/btrfs/bio.c:763 btrfs_submit_chunk() error: 'bbio' dereferencing possible ERR_PTR()

vim +/bbio +763 fs/btrfs/bio.c

ae42a154ca8972 Christoph Hellwig  2023-03-07  660  static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
103c19723c80bf Christoph Hellwig  2022-11-15  661  {
d5e4377d505189 Christoph Hellwig  2023-01-21  662  	struct btrfs_inode *inode = bbio->inode;
4317ff0056bedf Qu Wenruo          2023-03-23  663  	struct btrfs_fs_info *fs_info = bbio->fs_info;
ae42a154ca8972 Christoph Hellwig  2023-03-07  664  	struct bio *bio = &bbio->bio;
adbe7e388e4239 Anand Jain         2023-04-15  665  	u64 logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
103c19723c80bf Christoph Hellwig  2022-11-15  666  	u64 length = bio->bi_iter.bi_size;
103c19723c80bf Christoph Hellwig  2022-11-15  667  	u64 map_length = length;
921603c76246a7 Christoph Hellwig  2022-12-12  668  	bool use_append = btrfs_use_zone_append(bbio);
103c19723c80bf Christoph Hellwig  2022-11-15  669  	struct btrfs_io_context *bioc = NULL;
103c19723c80bf Christoph Hellwig  2022-11-15  670  	struct btrfs_io_stripe smap;
9ba0004bd95e05 Christoph Hellwig  2023-01-21  671  	blk_status_t ret;
9ba0004bd95e05 Christoph Hellwig  2023-01-21  672  	int error;
103c19723c80bf Christoph Hellwig  2022-11-15  673  
f4d39cf1cebfb8 Johannes Thumshirn 2024-07-31  674  	if (!bbio->inode || btrfs_is_data_reloc_root(inode->root))
f4d39cf1cebfb8 Johannes Thumshirn 2024-07-31  675  		smap.rst_search_commit_root = true;
f4d39cf1cebfb8 Johannes Thumshirn 2024-07-31  676  	else
f4d39cf1cebfb8 Johannes Thumshirn 2024-07-31  677  		smap.rst_search_commit_root = false;
9acaa64187f9b4 Johannes Thumshirn 2023-09-14  678  
103c19723c80bf Christoph Hellwig  2022-11-15  679  	btrfs_bio_counter_inc_blocked(fs_info);
cd4efd210edfb3 Christoph Hellwig  2023-05-31  680  	error = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
9fb2acc2fe07f1 Qu Wenruo          2023-09-17  681  				&bioc, &smap, &mirror_num);
9ba0004bd95e05 Christoph Hellwig  2023-01-21  682  	if (error) {
9ba0004bd95e05 Christoph Hellwig  2023-01-21  683  		ret = errno_to_blk_status(error);
9ba0004bd95e05 Christoph Hellwig  2023-01-21  684  		goto fail;
103c19723c80bf Christoph Hellwig  2022-11-15  685  	}
103c19723c80bf Christoph Hellwig  2022-11-15  686  
852eee62d31abd Christoph Hellwig  2023-01-21  687  	map_length = min(map_length, length);
d5e4377d505189 Christoph Hellwig  2023-01-21  688  	if (use_append)
b35243a447b9fe Christoph Hellwig  2024-08-26  689  		map_length = btrfs_append_map_length(bbio, map_length);
d5e4377d505189 Christoph Hellwig  2023-01-21  690  
103c19723c80bf Christoph Hellwig  2022-11-15  691  	if (map_length < length) {
b35243a447b9fe Christoph Hellwig  2024-08-26  692  		bbio = btrfs_split_bio(fs_info, bbio, map_length);
28c02a018d50ae Johannes Thumshirn 2024-10-29  693  		if (IS_ERR(bbio)) {
28c02a018d50ae Johannes Thumshirn 2024-10-29  694  			ret = PTR_ERR(bbio);
28c02a018d50ae Johannes Thumshirn 2024-10-29  695  			goto fail;

We hit this goto.  We know from the if statement that map_length < length.

28c02a018d50ae Johannes Thumshirn 2024-10-29  696  		}
2cef0c79bb81d8 Christoph Hellwig  2023-03-07  697  		bio = &bbio->bio;
103c19723c80bf Christoph Hellwig  2022-11-15  698  	}
103c19723c80bf Christoph Hellwig  2022-11-15  699  
1c2b3ee3b0ec4b Christoph Hellwig  2023-01-21  700  	/*
1c2b3ee3b0ec4b Christoph Hellwig  2023-01-21  701  	 * Save the iter for the end_io handler and preload the checksums for
1c2b3ee3b0ec4b Christoph Hellwig  2023-01-21  702  	 * data reads.
1c2b3ee3b0ec4b Christoph Hellwig  2023-01-21  703  	 */
fbe960877b6f43 Christoph Hellwig  2023-05-31  704  	if (bio_op(bio) == REQ_OP_READ && is_data_bbio(bbio)) {
0d3acb25e70d5f Christoph Hellwig  2023-01-21  705  		bbio->saved_iter = bio->bi_iter;
1c2b3ee3b0ec4b Christoph Hellwig  2023-01-21  706  		ret = btrfs_lookup_bio_sums(bbio);
1c2b3ee3b0ec4b Christoph Hellwig  2023-01-21  707  		if (ret)
10d9d8c3512f16 Qu Wenruo          2024-08-17  708  			goto fail;
1c2b3ee3b0ec4b Christoph Hellwig  2023-01-21  709  	}
7276aa7d38255b Christoph Hellwig  2023-01-21  710  
f8a53bb58ec7e2 Christoph Hellwig  2023-01-21  711  	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
d5e4377d505189 Christoph Hellwig  2023-01-21  712  		if (use_append) {
d5e4377d505189 Christoph Hellwig  2023-01-21  713  			bio->bi_opf &= ~REQ_OP_WRITE;
d5e4377d505189 Christoph Hellwig  2023-01-21  714  			bio->bi_opf |= REQ_OP_ZONE_APPEND;
69ccf3f4244abc Christoph Hellwig  2023-01-21  715  		}
69ccf3f4244abc Christoph Hellwig  2023-01-21  716  
02c372e1f016e5 Johannes Thumshirn 2023-09-14  717  		if (is_data_bbio(bbio) && bioc &&
02c372e1f016e5 Johannes Thumshirn 2023-09-14  718  		    btrfs_need_stripe_tree_update(bioc->fs_info, bioc->map_type)) {
02c372e1f016e5 Johannes Thumshirn 2023-09-14  719  			/*
02c372e1f016e5 Johannes Thumshirn 2023-09-14  720  			 * No locking for the list update, as we only add to
02c372e1f016e5 Johannes Thumshirn 2023-09-14  721  			 * the list in the I/O submission path, and list
02c372e1f016e5 Johannes Thumshirn 2023-09-14  722  			 * iteration only happens in the completion path, which
02c372e1f016e5 Johannes Thumshirn 2023-09-14  723  			 * can't happen until after the last submission.
02c372e1f016e5 Johannes Thumshirn 2023-09-14  724  			 */
02c372e1f016e5 Johannes Thumshirn 2023-09-14  725  			btrfs_get_bioc(bioc);
02c372e1f016e5 Johannes Thumshirn 2023-09-14  726  			list_add_tail(&bioc->rst_ordered_entry, &bbio->ordered->bioc_list);
02c372e1f016e5 Johannes Thumshirn 2023-09-14  727  		}
02c372e1f016e5 Johannes Thumshirn 2023-09-14  728  
f8a53bb58ec7e2 Christoph Hellwig  2023-01-21  729  		/*
f8a53bb58ec7e2 Christoph Hellwig  2023-01-21  730  		 * Csum items for reloc roots have already been cloned at this
f8a53bb58ec7e2 Christoph Hellwig  2023-01-21  731  		 * point, so they are handled as part of the no-checksum case.
f8a53bb58ec7e2 Christoph Hellwig  2023-01-21  732  		 */
4317ff0056bedf Qu Wenruo          2023-03-23  733  		if (inode && !(inode->flags & BTRFS_INODE_NODATASUM) &&
169aaaf2e0be61 Qu Wenruo          2024-06-14  734  		    !test_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state) &&
d5e4377d505189 Christoph Hellwig  2023-01-21  735  		    !btrfs_is_data_reloc_root(inode->root)) {
f8a53bb58ec7e2 Christoph Hellwig  2023-01-21  736  			if (should_async_write(bbio) &&
f8a53bb58ec7e2 Christoph Hellwig  2023-01-21  737  			    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
852eee62d31abd Christoph Hellwig  2023-01-21  738  				goto done;
103c19723c80bf Christoph Hellwig  2022-11-15  739  
f8a53bb58ec7e2 Christoph Hellwig  2023-01-21  740  			ret = btrfs_bio_csum(bbio);
f8a53bb58ec7e2 Christoph Hellwig  2023-01-21  741  			if (ret)
10d9d8c3512f16 Qu Wenruo          2024-08-17  742  				goto fail;
cebae292e0c32a Johannes Thumshirn 2024-06-07  743  		} else if (use_append ||
cebae292e0c32a Johannes Thumshirn 2024-06-07  744  			   (btrfs_is_zoned(fs_info) && inode &&
cebae292e0c32a Johannes Thumshirn 2024-06-07  745  			    inode->flags & BTRFS_INODE_NODATASUM)) {
cbfce4c7fbde23 Christoph Hellwig  2023-05-24  746  			ret = btrfs_alloc_dummy_sum(bbio);
cbfce4c7fbde23 Christoph Hellwig  2023-05-24  747  			if (ret)
10d9d8c3512f16 Qu Wenruo          2024-08-17  748  				goto fail;
f8a53bb58ec7e2 Christoph Hellwig  2023-01-21  749  		}
103c19723c80bf Christoph Hellwig  2022-11-15  750  	}
f8a53bb58ec7e2 Christoph Hellwig  2023-01-21  751  
22b4ef50dc1d11 David Sterba       2024-08-27  752  	btrfs_submit_bio(bio, bioc, &smap, mirror_num);
852eee62d31abd Christoph Hellwig  2023-01-21  753  done:
852eee62d31abd Christoph Hellwig  2023-01-21  754  	return map_length == length;
9ba0004bd95e05 Christoph Hellwig  2023-01-21  755  
9ba0004bd95e05 Christoph Hellwig  2023-01-21  756  fail:
9ba0004bd95e05 Christoph Hellwig  2023-01-21  757  	btrfs_bio_counter_dec(fs_info);
10d9d8c3512f16 Qu Wenruo          2024-08-17  758  	/*
10d9d8c3512f16 Qu Wenruo          2024-08-17  759  	 * We have split the original bbio, now we have to end both the current
10d9d8c3512f16 Qu Wenruo          2024-08-17  760  	 * @bbio and remaining one, as the remaining one will never be submitted.
10d9d8c3512f16 Qu Wenruo          2024-08-17  761  	 */
10d9d8c3512f16 Qu Wenruo          2024-08-17  762  	if (map_length < length) {
10d9d8c3512f16 Qu Wenruo          2024-08-17 @763  		struct btrfs_bio *remaining = bbio->private;
                                                                                              ^^^^^^^^^^^^^
Error pointer dereference

10d9d8c3512f16 Qu Wenruo          2024-08-17  764  
10d9d8c3512f16 Qu Wenruo          2024-08-17  765  		ASSERT(bbio->bio.bi_pool == &btrfs_clone_bioset);
10d9d8c3512f16 Qu Wenruo          2024-08-17  766  		ASSERT(remaining);
10d9d8c3512f16 Qu Wenruo          2024-08-17  767  
9ca0e58cb752b0 Qu Wenruo          2024-08-24  768  		btrfs_bio_end_io(remaining, ret);
10d9d8c3512f16 Qu Wenruo          2024-08-17  769  	}
9ca0e58cb752b0 Qu Wenruo          2024-08-24  770  	btrfs_bio_end_io(bbio, ret);
852eee62d31abd Christoph Hellwig  2023-01-21  771  	/* Do not submit another chunk */
852eee62d31abd Christoph Hellwig  2023-01-21  772  	return true;
852eee62d31abd Christoph Hellwig  2023-01-21  773  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


