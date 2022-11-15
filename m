Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADC46291F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 07:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiKOGk3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 01:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiKOGk1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 01:40:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A891F2F0
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 22:40:26 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g12so22360709wrs.10
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 22:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZnGjJvIILG+DoLiF1ROFGu0Lb1DIJYuAEJ0FSfWlaM=;
        b=Hc+ae2ZW/5sZNciLK5Zk0SZhorn89jzA1KCUFAKeNso0SAB4j6wE5k7eO5Bs/YkReO
         IoOlFI2qwZhfyrnc7mxESxsdsgyY7kCrM/5om/3Z+WC5ibnZVtMkFmUFJfZtKgAz6gpG
         Gbd7zljJ3NmykDN/X3Sg31qjZpQk0V86lWoYBsIhMXS/Pc33WYkAiERG4eFfp5Zg97k+
         8iipBLCcPlzDcORK3LlsgrOAM/s2TqnsN7jU+96CGAvXAza1BctH6DgGICGYN9KXcSJM
         1379JvB/htKXy1e2JfVatWqkxma9ydH7mVBHrnefK9I3aqGfsY5YuRM9o1fHlcPMTjOV
         amsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZnGjJvIILG+DoLiF1ROFGu0Lb1DIJYuAEJ0FSfWlaM=;
        b=Rq8HbTFkDfPPR3ZBr1AYoERtyRIW8fIZ3k82HZQNZxgpOFnm1r6U1pcQxYrMk7CNqN
         ujSw38jyV+cVNf2mRvf5i1qYTx2XznCziSI3LuPrj0GqFL1SIAA26l2lqCvmj258rfPH
         1sAslkrT8mjCUqAuuGiCEoOMjboqbZaKTIszBLT2fLjnfa4WqHnfpzWfoPMNEFWkO7Zf
         0Z2v1qA13NWlTylnbOT9cs/0p+v/IVWceYHyhl84bcTLDPdZHKLeHsyWFjrYdnXTxMz1
         /7mOLvrieOrQHG36Y7rxo9SKV15YlOrUDI59adOmln7y/JhKbVi9aIZCKCwChLLugAEZ
         iKuw==
X-Gm-Message-State: ANoB5plmUbeKDN8GraJ0vRSN4GJT8TmHyRrjhP2McBA0ZUe2hpqaVXnL
        vOMfG4BU30ElrN56nGAW6p4=
X-Google-Smtp-Source: AA0mqf5cKshHZoW8bnQ+Ly2zUXrh9BrjBmuoNSz/QvOs0x6bSdcG7ACCuARUVwuNHEcmdjG/3ZMfAQ==
X-Received: by 2002:a5d:4384:0:b0:231:20a2:21f4 with SMTP id i4-20020a5d4384000000b0023120a221f4mr9726477wrq.398.1668494425159;
        Mon, 14 Nov 2022 22:40:25 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j5-20020a5d5645000000b0022da3977ec5sm11355123wrw.113.2022.11.14.22.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 22:40:24 -0800 (PST)
Date:   Tue, 15 Nov 2022 09:40:22 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 4/5] btrfs: raid56: prepare data checksums for later RMW
 data csum  verification
Message-ID: <202211150946.Z76SnBqp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6620c738ea5f959085bfad0c0c843880f4c4e6e2.1668384746.git.wqu@suse.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-raid56-destructive-RMW-fix-for-RAID5-data-profiles/20221114-082910
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/6620c738ea5f959085bfad0c0c843880f4c4e6e2.1668384746.git.wqu%40suse.com
patch subject: [PATCH 4/5] btrfs: raid56: prepare data checksums for later RMW data csum  verification
config: x86_64-randconfig-m001-20221114
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
fs/btrfs/raid56.c:2108 fill_data_csums() error: uninitialized symbol 'ret'.

Old smatch warnings:
fs/btrfs/raid56.c:1017 get_rbio_veritical_errors() error: we previously assumed 'faila' could be null (see line 1011)

vim +/ret +2108 fs/btrfs/raid56.c

f24e7de3761574 Qu Wenruo       2022-11-14  2057  static void fill_data_csums(struct btrfs_raid_bio *rbio)
f24e7de3761574 Qu Wenruo       2022-11-14  2058  {
f24e7de3761574 Qu Wenruo       2022-11-14  2059  	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
f24e7de3761574 Qu Wenruo       2022-11-14  2060  	struct btrfs_root *csum_root = btrfs_csum_root(fs_info,
f24e7de3761574 Qu Wenruo       2022-11-14  2061  						       rbio->bioc->raid_map[0]);
f24e7de3761574 Qu Wenruo       2022-11-14  2062  	const u64 start = rbio->bioc->raid_map[0];
f24e7de3761574 Qu Wenruo       2022-11-14  2063  	const u32 len = (rbio->nr_data * rbio->stripe_nsectors) <<
f24e7de3761574 Qu Wenruo       2022-11-14  2064  			fs_info->sectorsize_bits;
f24e7de3761574 Qu Wenruo       2022-11-14  2065  	int ret;
f24e7de3761574 Qu Wenruo       2022-11-14  2066  
f24e7de3761574 Qu Wenruo       2022-11-14  2067  	/* The rbio should not has its csum buffer initialized. */
f24e7de3761574 Qu Wenruo       2022-11-14  2068  	ASSERT(!rbio->csum_buf && !rbio->csum_bitmap);
f24e7de3761574 Qu Wenruo       2022-11-14  2069  
f24e7de3761574 Qu Wenruo       2022-11-14  2070  	/*
f24e7de3761574 Qu Wenruo       2022-11-14  2071  	 * Skip the csum search if:
f24e7de3761574 Qu Wenruo       2022-11-14  2072  	 *
f24e7de3761574 Qu Wenruo       2022-11-14  2073  	 * - The rbio doesn't belongs to data block groups
f24e7de3761574 Qu Wenruo       2022-11-14  2074  	 *   Then we are doing IO for tree blocks, no need to
f24e7de3761574 Qu Wenruo       2022-11-14  2075  	 *   search csums.
f24e7de3761574 Qu Wenruo       2022-11-14  2076  	 *
f24e7de3761574 Qu Wenruo       2022-11-14  2077  	 * - The rbio belongs to mixed block groups
f24e7de3761574 Qu Wenruo       2022-11-14  2078  	 *   This is to avoid deadlock, as we're already holding
f24e7de3761574 Qu Wenruo       2022-11-14  2079  	 *   the full stripe lock, if we trigger a metadata read, and
f24e7de3761574 Qu Wenruo       2022-11-14  2080  	 *   it needs to do raid56 recovery, we will deadlock.
f24e7de3761574 Qu Wenruo       2022-11-14  2081  	 */
f24e7de3761574 Qu Wenruo       2022-11-14  2082  	if (!(rbio->bioc->map_type & BTRFS_BLOCK_GROUP_DATA) ||
f24e7de3761574 Qu Wenruo       2022-11-14  2083  	    rbio->bioc->map_type & BTRFS_BLOCK_GROUP_METADATA)
f24e7de3761574 Qu Wenruo       2022-11-14  2084  		return;
f24e7de3761574 Qu Wenruo       2022-11-14  2085  
f24e7de3761574 Qu Wenruo       2022-11-14  2086  	rbio->csum_buf = kzalloc(rbio->nr_data * rbio->stripe_nsectors *
f24e7de3761574 Qu Wenruo       2022-11-14  2087  				 fs_info->csum_size, GFP_NOFS);
f24e7de3761574 Qu Wenruo       2022-11-14  2088  	rbio->csum_bitmap = bitmap_zalloc(rbio->nr_data * rbio->stripe_nsectors,
f24e7de3761574 Qu Wenruo       2022-11-14  2089  				 GFP_NOFS);
f24e7de3761574 Qu Wenruo       2022-11-14  2090  	if (!rbio->csum_buf || !rbio->csum_bitmap)
f24e7de3761574 Qu Wenruo       2022-11-14  2091  		goto error;

"ret" uninitialized on this path.

f24e7de3761574 Qu Wenruo       2022-11-14  2092  
f24e7de3761574 Qu Wenruo       2022-11-14  2093  	ret = btrfs_lookup_csums_bitmap(csum_root, start, start + len - 1,
f24e7de3761574 Qu Wenruo       2022-11-14  2094  					rbio->csum_buf, rbio->csum_bitmap);
f24e7de3761574 Qu Wenruo       2022-11-14  2095  	if (ret < 0)
f24e7de3761574 Qu Wenruo       2022-11-14  2096  		goto error;
f24e7de3761574 Qu Wenruo       2022-11-14  2097  	if (bitmap_empty(rbio->csum_bitmap, len >> fs_info->sectorsize_bits))
f24e7de3761574 Qu Wenruo       2022-11-14  2098  		goto no_csum;
f24e7de3761574 Qu Wenruo       2022-11-14  2099  	return;
f24e7de3761574 Qu Wenruo       2022-11-14  2100  
f24e7de3761574 Qu Wenruo       2022-11-14  2101  error:
f24e7de3761574 Qu Wenruo       2022-11-14  2102  	/*
f24e7de3761574 Qu Wenruo       2022-11-14  2103  	 * We failed to allocate memory or grab the csum,
f24e7de3761574 Qu Wenruo       2022-11-14  2104  	 * but it's not the end of day, we can still continue.
f24e7de3761574 Qu Wenruo       2022-11-14  2105  	 * But better to warn users that RMW is no longer safe for this
f24e7de3761574 Qu Wenruo       2022-11-14  2106  	 * particular sub-stripe write.
f24e7de3761574 Qu Wenruo       2022-11-14  2107  	 */
f24e7de3761574 Qu Wenruo       2022-11-14 @2108  	btrfs_warn_rl(fs_info,
f24e7de3761574 Qu Wenruo       2022-11-14  2109  "sub-stripe write for full stripe %llu is not safe, failed to get csum: %d",
f24e7de3761574 Qu Wenruo       2022-11-14  2110  			rbio->bioc->raid_map[0], ret);
                                                                                                 ^^^

f24e7de3761574 Qu Wenruo       2022-11-14  2111  no_csum:
f24e7de3761574 Qu Wenruo       2022-11-14  2112  	kfree(rbio->csum_buf);
f24e7de3761574 Qu Wenruo       2022-11-14  2113  	bitmap_free(rbio->csum_bitmap);
f24e7de3761574 Qu Wenruo       2022-11-14  2114  	rbio->csum_buf = NULL;
f24e7de3761574 Qu Wenruo       2022-11-14  2115  	rbio->csum_bitmap = NULL;
f24e7de3761574 Qu Wenruo       2022-11-14  2116  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

