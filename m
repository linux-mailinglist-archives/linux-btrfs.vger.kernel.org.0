Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD88A4EB501
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 23:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiC2VGQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 17:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiC2VGP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 17:06:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091B8122991
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 14:04:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A115921639;
        Tue, 29 Mar 2022 21:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648587870;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=poTqrBX/KmFDZWQPx3Fa/QttSaNmIT22TbU9cPX1Qf8=;
        b=U4v9JWp7cENAlVcq60vVWS/4jiK6MBHJ5LFzIs/0WOJq9K4eAEtwBdv44LTKt6QLktIgQA
        6hdc6zZmDMvcqXKeML5bLS1IBardmEfel/f6xF2kvfHXkaGoG60s8pWMEMGXuuU0tljn9F
        E0xQUkBStSLoQ7BknmUHAehst3nywaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648587870;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=poTqrBX/KmFDZWQPx3Fa/QttSaNmIT22TbU9cPX1Qf8=;
        b=0hbTta9umXt9/NCrgGRDhnE8MJmrXUJHwhrOzx+/CfYo4PeyryDNjP25CEybE0CjTsZpz0
        tsrYfGR669qC2bDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 98EB4A3B88;
        Tue, 29 Mar 2022 21:04:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DC92DDA7F3; Tue, 29 Mar 2022 23:00:32 +0200 (CEST)
Date:   Tue, 29 Mar 2022 23:00:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: avoid checking wrong RAID5/6 P/Q data
Message-ID: <20220329210032.GA2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1648546873.git.wqu@suse.com>
 <1f2706f3ef6733df2d1732715553c01d51b06374.1648546873.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f2706f3ef6733df2d1732715553c01d51b06374.1648546873.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 29, 2022 at 05:44:25PM +0800, Qu Wenruo wrote:
> [BUG]
> "btrfs check --check-data-csum" is causing tons of false alerts for
> RAID56 systems:
> 
>   # mkfs.btrfs -f $dev1 $dev2 $dev3 -m raid1 -d raid5
>   # mount $dev1 $mnt
>   # xfs_io -f -c "pwrite 0 16k" $mnt/file
>   # umount $mnt
>   # btrfs check --check-data-csum $dev1
>   ...
>   [5/7] checking csums against data
>   mirror 2 bytenr 389152768 csum 0x02ca4e98 expected csum 0x98757625
>   mirror 2 bytenr 389156864 csum 0x02ca4e98 expected csum 0x98757625
>   mirror 2 bytenr 389160960 csum 0x02ca4e98 expected csum 0x98757625
>   mirror 2 bytenr 389165056 csum 0x02ca4e98 expected csum 0x98757625
>   ERROR: errors found in csum tree
>   [6/7] checking root refs
> 
> But scrub is completely fine, and manually inspecting the on-disk data
> shows nothing wrong.
> 
> [CAUSE]
> Btrfs-progs only implemented the RAID56 write support, mostly for
> metadata.
> 
> It doesn't have RAID56 repair ability at all.
> (Btrfs-fuse has the ability ready to be contribued to progs though).
> 
> In read_extent_data(), it always read data from the first stripe,
> without any RAID56 rebuild.
> 
> [WORKAROUND]
> It will take a while to port RAID56 repair into btrfs-progs.
> Just reduce the btrfs_num_copies() report for RAID56 to 1, so that we
> won't even try to rebuild using P/Q.
> 
> Also add a warning message for open_ctree() of btrfs-progs, so
> explicitly show the lack of RAID56 rebuild ability.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  kernel-shared/disk-io.c |  7 +++++++
>  kernel-shared/volumes.c | 10 ++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> index 4964cd3827e4..426fe40b53d6 100644
> --- a/kernel-shared/disk-io.c
> +++ b/kernel-shared/disk-io.c
> @@ -997,6 +997,13 @@ int btrfs_check_fs_compatibility(struct btrfs_super_block *sb,
>  		btrfs_set_super_incompat_flags(sb, features);
>  	}
>  
> +	/*
> +	 * We don't have the ability to repair from P/Q yet, give some warning
> +	 * about this
> +	 */
> +	if (features & BTRFS_FEATURE_INCOMPAT_RAID56)
> +		printf("WARNING: repairing using RAID56 P/Q is not supported yet\n");

There's a helper for warnings, warning()

> +
>  	features = btrfs_super_compat_ro_flags(sb);
>  	if (flags & OPEN_CTREE_WRITES) {
>  		if (flags & OPEN_CTREE_INVALIDATE_FST) {
> diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
> index e24428db8412..5845a4383d5f 100644
> --- a/kernel-shared/volumes.c
> +++ b/kernel-shared/volumes.c
> @@ -1645,10 +1645,12 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
>  		ret = map->num_stripes;
>  	else if (map->type & BTRFS_BLOCK_GROUP_RAID10)
>  		ret = map->sub_stripes;
> -	else if (map->type & BTRFS_BLOCK_GROUP_RAID5)
> -		ret = 2;
> -	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)
> -		ret = 3;
> +	else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
> +		/*
> +		 * In btrfs-progs we don't yet have the ability to rebuild
> +		 * from P/Q, thus currently it can only provide one mirror.
> +		 */
> +		ret = 1;
>  	else
>  		ret = 1;
>  	return ret;
> -- 
> 2.35.1
