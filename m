Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5E14F1C22
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378965AbiDDVZN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379178AbiDDQmW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 12:42:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5FE2FFF5
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 09:40:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EACCA210E5;
        Mon,  4 Apr 2022 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649090424;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xd/1VjueFto4dgVuMPhlkYm9ikrQ454XSTDG6GhWTtw=;
        b=Z84U51gAa6tFvAZogGxh4rf//o5EatY41QJ6KF+tE0gn2sEcixDA8knX7lx9S9zqkpA0e/
        nsAWpUbTcSQSMEt1DXxuenxc7iJbYP1JTIrBMJQ9abJcc9XbRZvmh7t//9sqhD/Rqd69ra
        S9RLpjTR0Y+aqvZ4+mPo6gMTbnq+bHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649090424;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xd/1VjueFto4dgVuMPhlkYm9ikrQ454XSTDG6GhWTtw=;
        b=mcJ2SNscnIiyhscpGVLoMFts8Yor7HcydPnwZpS7oM3XSxMDkIzb/VncmN3O5Y3PwrPmPA
        U2GExXP1c2guUECA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E097CA3B87;
        Mon,  4 Apr 2022 16:40:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2BE2DDA80E; Mon,  4 Apr 2022 18:36:23 +0200 (CEST)
Date:   Mon, 4 Apr 2022 18:36:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stefan Roesch <shr@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v1 1/3] btrfs: store chunk size in space-info struct.
Message-ID: <20220404163623.GS15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stefan Roesch <shr@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220208193122.492533-1-shr@fb.com>
 <20220208193122.492533-2-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208193122.492533-2-shr@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,TRACKER_ID,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 08, 2022 at 11:31:20AM -0800, Stefan Roesch wrote:
> The chunk size is stored in the btrfs_space_info structure.
> It is initialized at the start and is then used.
> 
> A new api is added to update the current chunk size.
> 
> This api is used to be able to expose the chunk_size
> as a sysfs setting.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---
>  fs/btrfs/space-info.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/space-info.h |  3 +++
>  fs/btrfs/volumes.c    | 28 +++++++++-------------------
>  3 files changed, 53 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 294242c194d8..302522a250d8 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -181,6 +181,46 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
>  		found->full = 0;
>  }
>  
> +/*
> + * Compute chunk size depending on block type for regular volumes.
> + */
> +static u64 compute_chunk_size_regular(struct btrfs_fs_info *info, u64 flags)

compute_chunk_size_regular

We've been using 'calculate' or 'calc' for such helper elsewhere, please
rename it for consistency.

Also the common name for struct btrfs_fs_info is 'fs_info' and it can be
made const.

> +{
> +	ASSERT(flags & BTRFS_BLOCK_GROUP_TYPE_MASK);
> +
> +	if (flags & BTRFS_BLOCK_GROUP_DATA)
> +		return SZ_1G;
> +	else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
> +		return SZ_32M;
> +
> +	/* Handle BTRFS_BLOCK_GROUP_METADATA */
> +	if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
> +		return SZ_1G;
> +
> +	return SZ_256M;
> +}
> +
> +/*
> + * Compute chunk size depending on volume type.
> + */
> +static u64 compute_chunk_size(struct btrfs_fs_info *info, u64 flags)

Same.

> +{
> +	if (btrfs_is_zoned(info))
> +		return info->zone_size;
> +
> +	return compute_chunk_size_regular(info, flags);
> +}
> +
> +/*
> + * Update default chunk size.

That's not very helpful comment but the function is sort and clear
enough so I don't think it needs it anyway.

> + *
> + */
> +void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
> +					u64 chunk_size)
> +{
> +	atomic64_set(&space_info->chunk_size, chunk_size);
> +}
> +
>  static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>  {
>  
> @@ -202,6 +242,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>  	INIT_LIST_HEAD(&space_info->tickets);
>  	INIT_LIST_HEAD(&space_info->priority_tickets);
>  	space_info->clamp = 1;
> +	btrfs_update_space_info_chunk_size(space_info, compute_chunk_size(info, flags));
>  
>  	ret = btrfs_sysfs_add_space_info_type(info, space_info);
>  	if (ret)
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index d841fed73492..c1a64bbfb6d1 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -23,6 +23,7 @@ struct btrfs_space_info {
>  	u64 max_extent_size;	/* This will hold the maximum extent size of
>  				   the space info if we had an ENOSPC in the
>  				   allocator. */
> +	atomic64_t chunk_size;  /* chunk size in bytes */

Why is this an atomic? I don't see the atomic semantics used anywhere,
ie. not losing increments/decrements. For plain atomic_set/atomic_read
it's exactly the same as an int or long. The right annotation here is
READ_ONCE and WRITE_ONCE, which is used for other values updated from
sysfs.

>  
>  	int clamp;		/* Used to scale our threshold for preemptive
>  				   flushing. The value is >> clamp, so turns
