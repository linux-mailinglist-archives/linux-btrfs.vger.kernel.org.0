Return-Path: <linux-btrfs+bounces-17375-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99515BB6347
	for <lists+linux-btrfs@lfdr.de>; Fri, 03 Oct 2025 09:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9494262E4
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 07:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95FB260566;
	Fri,  3 Oct 2025 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ooh3thlD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44B81862
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759478308; cv=none; b=W7P9LzUaSmGtAHOGfMXXB48ggIZrJB6UE7skkq5+qtj4vzTo7Ta+mIu+Xo14f410UZtfMVzNGn4haX/slkqVoUNWB+myBBk17YasMseORJGQOng7mHYjthIRUvL3gTQboBbQrlU45gJOfAR/SKt9WTb629zqEvX+dHFqElLmw3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759478308; c=relaxed/simple;
	bh=ICvnSkwTXtZ2q6ptNYbxbzmEP48GzA8srtDhuOUaKTM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R46HqgVq1yC+lJNfFusqRGVIsZyhM2XtGLCV2Ek9BAfdI+zjqJjz9/COMxeJd29dm9M/sSPGLVFyKfdkxylOY6BnEXYgnvZxyTY8pbgmHfVW2pyWtLW7FK7+LXavzAQyX8/rxpGurFQwDdw2QE5xGLg2nOVDKJnbv311JmbOEG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ooh3thlD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso1311855f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Oct 2025 00:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759478303; x=1760083103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKQIE5kMOiqxVyxhsksVXgye3GZ3763KOwMOrctoVnQ=;
        b=ooh3thlDDCT515Nz2Fz3Ji0+PK+H6K6xS/TAw/sVR8grZIBqbAd5vLmE0A/wNtlYnI
         8X7zVpsA7Uyy2THeJfnxrZu0TkkBQdE6SvDyeSUCobFbUrbXC84KZQz1AZfdndUeuezt
         8GD3oojYHi2OgbPYpP+a2uOExWyD6VedEhXlBjRomBTl+lV5Ksj+6kcP4boojpXUks4s
         sldERVHZowYkBH4F9LeQ4u1Zr5gUb0YtpXSDu1j/H1jGOSiNvIeL6NlMcvl8y+ixv3bc
         2r6n+32J362pOgcu+IBl93/v2Pp+QpF71sdmK+fi6Ax23MVMaSeeayGK2tAUoZ3TkKR2
         103Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759478303; x=1760083103;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKQIE5kMOiqxVyxhsksVXgye3GZ3763KOwMOrctoVnQ=;
        b=vbAhmyNxsuqbwq8vdWpM6uE7ZF99BweSZYT+IjLaa2PQC4NQanhg/mcQYpohERWzy9
         9CsVIX1RD5q+VG79N5qBgvraSlqWBfZdiGiZNZ35WHbFO2ecsjKTyUDCAsgrgyaTQHd0
         +ZWj5zMMRtwiznY/n+iXxBMQBptL1kDJg518i/ouLMNnzxCvW249on4LR2XMB1n+8nmH
         EVyr/aE9eNKAuDOk+LFv2a11e2Q5WqrETT9T4QHG95NZ3gMfn72rBRSzDO1zxHiPk3NW
         BPGquLtDnpc4N0ryQ41nb3+XW63ZIwnJIfJQ111o6suorkmxDxe/iTmYKCaJKRz1LPYK
         wiaA==
X-Forwarded-Encrypted: i=1; AJvYcCWYa40u7bmTMngX0wVvDJyh4/uP3PlTUcN8mtKwKKzMK2434ebDtN9uX5tz7ROxZoxMcXw+wvtIrps8zA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu8gEG6cPJgBiKEXKX3R7fPEAoVyKyAzj30saJOS1MEy3iXqMt
	uHFTw4A6HFMsaT7uMC2QopH8PEM/pKEu5g5FimXpGk6HvDCB2i2jqJ4+zv2i1lYoUYc=
X-Gm-Gg: ASbGncui1pdtDb6tO+6Cq34cg+OaaNJFv86v2neUzT23IY4XULgwvQBtELTorazQMhc
	rYSyFcNAPOe0So0REA8HhDPXg87v5R9QS5PyDMxM+a3TZGNQF5OHMJ7dHATRLrSYaK9nXGyRSeY
	PSPLZ+fbClJTswG/shcNvDnRlEV/ZANITG1XHac9paWIJQFgAYPFMAApX9HrQfjhSGi361mhJFh
	CgSJIWtVt1k4/yHkrbDRtOzmn6JKaB+RtuCZez7aNelGq4ELITsRVLtZVqku1LYbRUpAg58NN+f
	gU8qADMF7zqEcRqb0j049dNNwgzmkfhdTbb3A3aImXT0WT2wNnwopOcdWyF7KVzwAsW7l/VhyXm
	xss/mSXmi3cD2qdMPTAHCrfkztwx71hc6OrkTPBH4uWcmUwfXKXJCkfjAzTFa/RE/z6M=
X-Google-Smtp-Source: AGHT+IFCOtv4hauC768f/SH5npRM8KwtIVQ8biqflqNBeylk+f4+Iu9K2H28Nujr9MM47gOyTB2iTw==
X-Received: by 2002:a05:6000:2583:b0:3ec:dd12:54d3 with SMTP id ffacd0b85a97d-42567176351mr1178108f8f.35.1759478302975;
        Fri, 03 Oct 2025 00:58:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8e980dsm7400242f8f.36.2025.10.03.00.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 00:58:22 -0700 (PDT)
Date: Fri, 3 Oct 2025 10:58:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/4] btrfs: make btrfs_repair_io_failure() handle bs > ps
 cases without large folios
Message-ID: <202510030550.mqFoO0Dw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33c39907866c148a360ff60387097fbad63a19aa.1759311101.git.wqu@suse.com>

Hi Qu,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-make-btrfs_csum_one_bio-handle-bs-ps-without-large-folios/20251001-175128
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/33c39907866c148a360ff60387097fbad63a19aa.1759311101.git.wqu%40suse.com
patch subject: [PATCH 2/4] btrfs: make btrfs_repair_io_failure() handle bs > ps cases without large folios
config: powerpc64-randconfig-r071-20251002 (https://download.01.org/0day-ci/archive/20251003/202510030550.mqFoO0Dw-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 39f292ffa13d7ca0d1edff27ac8fd55024bb4d19)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202510030550.mqFoO0Dw-lkp@intel.com/

smatch warnings:
fs/btrfs/bio.c:914 btrfs_repair_io_failure() warn: variable dereferenced before check 'bio' (see line 894)

vim +/bio +914 fs/btrfs/bio.c

2d65a91734a195 Qu Wenruo         2025-10-01  855  int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 fileoff,
2d65a91734a195 Qu Wenruo         2025-10-01  856  			    u64 length, u64 logical, const phys_addr_t paddrs[], int mirror_num)
bacf60e5158629 Christoph Hellwig 2022-11-15  857  {
2d65a91734a195 Qu Wenruo         2025-10-01  858  	const u32 step = min(fs_info->sectorsize, PAGE_SIZE);
2d65a91734a195 Qu Wenruo         2025-10-01  859  	const u32 nr_steps = DIV_ROUND_UP_POW2(length, step);
4886ff7b50f634 Qu Wenruo         2023-03-20  860  	struct btrfs_io_stripe smap = { 0 };
2d65a91734a195 Qu Wenruo         2025-10-01  861  	struct bio *bio = NULL;
bacf60e5158629 Christoph Hellwig 2022-11-15  862  	int ret = 0;
bacf60e5158629 Christoph Hellwig 2022-11-15  863  
bacf60e5158629 Christoph Hellwig 2022-11-15  864  	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
bacf60e5158629 Christoph Hellwig 2022-11-15  865  	BUG_ON(!mirror_num);
bacf60e5158629 Christoph Hellwig 2022-11-15  866  
2d65a91734a195 Qu Wenruo         2025-10-01  867  	/* Basic alignment checks. */
2d65a91734a195 Qu Wenruo         2025-10-01  868  	ASSERT(IS_ALIGNED(logical, fs_info->sectorsize));
2d65a91734a195 Qu Wenruo         2025-10-01  869  	ASSERT(IS_ALIGNED(length, fs_info->sectorsize));
2d65a91734a195 Qu Wenruo         2025-10-01  870  	ASSERT(IS_ALIGNED(fileoff, fs_info->sectorsize));
2d65a91734a195 Qu Wenruo         2025-10-01  871  
bacf60e5158629 Christoph Hellwig 2022-11-15  872  	if (btrfs_repair_one_zone(fs_info, logical))
bacf60e5158629 Christoph Hellwig 2022-11-15  873  		return 0;
bacf60e5158629 Christoph Hellwig 2022-11-15  874  
bacf60e5158629 Christoph Hellwig 2022-11-15  875  	/*
bacf60e5158629 Christoph Hellwig 2022-11-15  876  	 * Avoid races with device replace and make sure our bioc has devices
bacf60e5158629 Christoph Hellwig 2022-11-15  877  	 * associated to its stripes that don't go away while we are doing the
bacf60e5158629 Christoph Hellwig 2022-11-15  878  	 * read repair operation.
bacf60e5158629 Christoph Hellwig 2022-11-15  879  	 */
bacf60e5158629 Christoph Hellwig 2022-11-15  880  	btrfs_bio_counter_inc_blocked(fs_info);
4886ff7b50f634 Qu Wenruo         2023-03-20  881  	ret = btrfs_map_repair_block(fs_info, &smap, logical, length, mirror_num);
4886ff7b50f634 Qu Wenruo         2023-03-20  882  	if (ret < 0)
d73a27b86fc722 Qu Wenruo         2023-01-01  883  		goto out_counter_dec;
bacf60e5158629 Christoph Hellwig 2022-11-15  884  
cc53bd2085c8fa David Sterba      2025-09-17  885  	if (unlikely(!smap.dev->bdev ||
cc53bd2085c8fa David Sterba      2025-09-17  886  		     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &smap.dev->dev_state))) {
bacf60e5158629 Christoph Hellwig 2022-11-15  887  		ret = -EIO;
bacf60e5158629 Christoph Hellwig 2022-11-15  888  		goto out_counter_dec;
bacf60e5158629 Christoph Hellwig 2022-11-15  889  	}
bacf60e5158629 Christoph Hellwig 2022-11-15  890  
2d65a91734a195 Qu Wenruo         2025-10-01  891  	bio = bio_alloc(smap.dev->bdev, nr_steps, REQ_OP_WRITE | REQ_SYNC, GFP_NOFS);
2d65a91734a195 Qu Wenruo         2025-10-01  892  	/* Backed by fs_bio_set, shouldn't fail. */
2d65a91734a195 Qu Wenruo         2025-10-01  893  	ASSERT(bio);
2d65a91734a195 Qu Wenruo         2025-10-01 @894  	bio->bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
2d65a91734a195 Qu Wenruo         2025-10-01  895  	for (int i = 0; i < nr_steps; i++) {
2d65a91734a195 Qu Wenruo         2025-10-01  896  		ret = bio_add_page(bio, phys_to_page(paddrs[i]), step, offset_in_page(paddrs[i]));
2d65a91734a195 Qu Wenruo         2025-10-01  897  		/* We should have allocated enough slots to contain all the different pages. */
2d65a91734a195 Qu Wenruo         2025-10-01  898  		ASSERT(ret == step);
2d65a91734a195 Qu Wenruo         2025-10-01  899  	}
2d65a91734a195 Qu Wenruo         2025-10-01  900  	ret = submit_bio_wait(bio);
bacf60e5158629 Christoph Hellwig 2022-11-15  901  	if (ret) {
bacf60e5158629 Christoph Hellwig 2022-11-15  902  		/* try to remap that extent elsewhere? */
4886ff7b50f634 Qu Wenruo         2023-03-20  903  		btrfs_dev_stat_inc_and_print(smap.dev, BTRFS_DEV_STAT_WRITE_ERRS);
2d65a91734a195 Qu Wenruo         2025-10-01  904  		goto out_free_bio;
bacf60e5158629 Christoph Hellwig 2022-11-15  905  	}
bacf60e5158629 Christoph Hellwig 2022-11-15  906  
2eac2ae8b214ab David Sterba      2025-06-09  907  	btrfs_info_rl(fs_info,
bacf60e5158629 Christoph Hellwig 2022-11-15  908  		"read error corrected: ino %llu off %llu (dev %s sector %llu)",
2d65a91734a195 Qu Wenruo         2025-10-01  909  			     ino, fileoff, btrfs_dev_name(smap.dev),
4886ff7b50f634 Qu Wenruo         2023-03-20  910  			     smap.physical >> SECTOR_SHIFT);
bacf60e5158629 Christoph Hellwig 2022-11-15  911  	ret = 0;
bacf60e5158629 Christoph Hellwig 2022-11-15  912  
2d65a91734a195 Qu Wenruo         2025-10-01  913  out_free_bio:
2d65a91734a195 Qu Wenruo         2025-10-01 @914  	if (bio)

This check could be deleted if you want.  Or you could leave it since
it's harmless.  Up to you.  I would prefer to silence these warning by
updating Smatch, but Smatch isn't smart enough to parse bio_alloc()
Smatch deliberately ignores ASSERT()s.

2d65a91734a195 Qu Wenruo         2025-10-01  915  		bio_put(bio);
bacf60e5158629 Christoph Hellwig 2022-11-15  916  out_counter_dec:
bacf60e5158629 Christoph Hellwig 2022-11-15  917  	btrfs_bio_counter_dec(fs_info);
bacf60e5158629 Christoph Hellwig 2022-11-15  918  	return ret;
bacf60e5158629 Christoph Hellwig 2022-11-15  919  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


