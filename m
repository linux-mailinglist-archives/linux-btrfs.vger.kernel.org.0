Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CAC6299E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 14:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiKONTK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 08:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiKONTI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 08:19:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB68CDF65
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 05:19:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9494B220B5;
        Tue, 15 Nov 2022 13:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668518345;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ujcJIVFIxzxQNIYJWtyhWUQOE5HhxGvASb0AeTKC6U=;
        b=EaGdTNPTfvcR2HMqehyksdqQhehpnufntR0zz9uKn5w1vv7DRfEJW35XiiRrdUwda1FMbQ
        GSuxjyGZTrCO6nGnx8np4yfbxrcWyMTfggXJ6+ovo8xfemLIn+Lb4hOrqyzkfOn7KY0M/A
        My97He7s9Sedo5JWhK9Kv/qIwOjkokI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668518345;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ujcJIVFIxzxQNIYJWtyhWUQOE5HhxGvASb0AeTKC6U=;
        b=K6MwSjKnEd5/dwX+tJOrIHwhrL7hleHPBd0N44zyW4SDpyytyEiwSES5SlITmHQRXAejLl
        MD7UUNxjxAEpigCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6405B13A91;
        Tue, 15 Nov 2022 13:19:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J2drF8mRc2PkXgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 15 Nov 2022 13:19:05 +0000
Date:   Tue, 15 Nov 2022 14:18:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 4/5] btrfs: raid56: prepare data checksums for later RMW
 data csum  verification
Message-ID: <20221115131839.GG5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6620c738ea5f959085bfad0c0c843880f4c4e6e2.1668384746.git.wqu@suse.com>
 <202211150946.Z76SnBqp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211150946.Z76SnBqp-lkp@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 09:40:22AM +0300, Dan Carpenter wrote:
> Hi Qu,
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-raid56-destructive-RMW-fix-for-RAID5-data-profiles/20221114-082910
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> patch link:    https://lore.kernel.org/r/6620c738ea5f959085bfad0c0c843880f4c4e6e2.1668384746.git.wqu%40suse.com
> patch subject: [PATCH 4/5] btrfs: raid56: prepare data checksums for later RMW data csum  verification
> config: x86_64-randconfig-m001-20221114
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> 
> New smatch warnings:
> fs/btrfs/raid56.c:2108 fill_data_csums() error: uninitialized symbol 'ret'.
> 
> Old smatch warnings:
> fs/btrfs/raid56.c:1017 get_rbio_veritical_errors() error: we previously assumed 'faila' could be null (see line 1011)
> 
> vim +/ret +2108 fs/btrfs/raid56.c
> 
> f24e7de3761574 Qu Wenruo       2022-11-14  2057  static void fill_data_csums(struct btrfs_raid_bio *rbio)
> f24e7de3761574 Qu Wenruo       2022-11-14  2058  {
> f24e7de3761574 Qu Wenruo       2022-11-14  2059  	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
> f24e7de3761574 Qu Wenruo       2022-11-14  2060  	struct btrfs_root *csum_root = btrfs_csum_root(fs_info,
> f24e7de3761574 Qu Wenruo       2022-11-14  2061  						       rbio->bioc->raid_map[0]);
> f24e7de3761574 Qu Wenruo       2022-11-14  2062  	const u64 start = rbio->bioc->raid_map[0];
> f24e7de3761574 Qu Wenruo       2022-11-14  2063  	const u32 len = (rbio->nr_data * rbio->stripe_nsectors) <<
> f24e7de3761574 Qu Wenruo       2022-11-14  2064  			fs_info->sectorsize_bits;
> f24e7de3761574 Qu Wenruo       2022-11-14  2065  	int ret;
> f24e7de3761574 Qu Wenruo       2022-11-14  2066  
> f24e7de3761574 Qu Wenruo       2022-11-14  2067  	/* The rbio should not has its csum buffer initialized. */
> f24e7de3761574 Qu Wenruo       2022-11-14  2068  	ASSERT(!rbio->csum_buf && !rbio->csum_bitmap);
> f24e7de3761574 Qu Wenruo       2022-11-14  2069  
> f24e7de3761574 Qu Wenruo       2022-11-14  2070  	/*
> f24e7de3761574 Qu Wenruo       2022-11-14  2071  	 * Skip the csum search if:
> f24e7de3761574 Qu Wenruo       2022-11-14  2072  	 *
> f24e7de3761574 Qu Wenruo       2022-11-14  2073  	 * - The rbio doesn't belongs to data block groups
> f24e7de3761574 Qu Wenruo       2022-11-14  2074  	 *   Then we are doing IO for tree blocks, no need to
> f24e7de3761574 Qu Wenruo       2022-11-14  2075  	 *   search csums.
> f24e7de3761574 Qu Wenruo       2022-11-14  2076  	 *
> f24e7de3761574 Qu Wenruo       2022-11-14  2077  	 * - The rbio belongs to mixed block groups
> f24e7de3761574 Qu Wenruo       2022-11-14  2078  	 *   This is to avoid deadlock, as we're already holding
> f24e7de3761574 Qu Wenruo       2022-11-14  2079  	 *   the full stripe lock, if we trigger a metadata read, and
> f24e7de3761574 Qu Wenruo       2022-11-14  2080  	 *   it needs to do raid56 recovery, we will deadlock.
> f24e7de3761574 Qu Wenruo       2022-11-14  2081  	 */
> f24e7de3761574 Qu Wenruo       2022-11-14  2082  	if (!(rbio->bioc->map_type & BTRFS_BLOCK_GROUP_DATA) ||
> f24e7de3761574 Qu Wenruo       2022-11-14  2083  	    rbio->bioc->map_type & BTRFS_BLOCK_GROUP_METADATA)
> f24e7de3761574 Qu Wenruo       2022-11-14  2084  		return;
> f24e7de3761574 Qu Wenruo       2022-11-14  2085  
> f24e7de3761574 Qu Wenruo       2022-11-14  2086  	rbio->csum_buf = kzalloc(rbio->nr_data * rbio->stripe_nsectors *
> f24e7de3761574 Qu Wenruo       2022-11-14  2087  				 fs_info->csum_size, GFP_NOFS);
> f24e7de3761574 Qu Wenruo       2022-11-14  2088  	rbio->csum_bitmap = bitmap_zalloc(rbio->nr_data * rbio->stripe_nsectors,
> f24e7de3761574 Qu Wenruo       2022-11-14  2089  				 GFP_NOFS);
> f24e7de3761574 Qu Wenruo       2022-11-14  2090  	if (!rbio->csum_buf || !rbio->csum_bitmap)
> f24e7de3761574 Qu Wenruo       2022-11-14  2091  		goto error;
> 
> "ret" uninitialized on this path.

Thanks for the report, now initialized to -ENOMEM.
