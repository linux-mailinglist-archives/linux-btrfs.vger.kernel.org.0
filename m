Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A914460EB
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 09:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhKEIyw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 04:54:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47552 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhKEIyv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 04:54:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9FBDC1FD43;
        Fri,  5 Nov 2021 08:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636102331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/aTW+pDiWSZu/Pf84MG147CblTTB72NKDau8u4lxrkg=;
        b=HPz4DPNHdKHcT2N67VRPR8Jx9Y+3sRe4VYl1ELZ3oW2sFWYiOIDhxpWl8AU17DaHKEZN/n
        Ax1qk0Z9+kwTxwx/17Fly7Bfji4Z6cKCGYnSKW0Ht5mWBSp/7CgQRADznNaRkEMKmu6yai
        NDmEcOKgumXQ7Y8iGqeYw6xQnKoxnHo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69FB713FBA;
        Fri,  5 Nov 2021 08:52:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N8LrFrvwhGHHUwAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 05 Nov 2021 08:52:11 +0000
Subject: Re: [PATCH v4 1/4] btrfs: store chunk size in space-info struct.
To:     Stefan Roesch <shr@fb.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20211029183950.3613491-1-shr@fb.com>
 <20211029183950.3613491-2-shr@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <6e8e8da7-00e7-4f64-5def-d9f0481aa0a5@suse.com>
Date:   Fri, 5 Nov 2021 10:52:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211029183950.3613491-2-shr@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.10.21 г. 21:39, Stefan Roesch wrote:
> The chunk size is stored in the btrfs_space_info structure.
> It is initialized at the start and is then used.
> 
> Two api's are added to get the current value and one to update
> the value.

There is just a single API added to update the size, there is no api to
get the value, one has to directly read default_chunk_size. Additionally
if it's going to be changed then does the "default_" prefix really mean
anything?

> 
> These api's will be used to be able to expose the chunk_size
> as a sysfs setting.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---
>  fs/btrfs/space-info.c | 51 +++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/space-info.h |  3 +++
>  fs/btrfs/volumes.c    | 28 ++++++++----------------
>  3 files changed, 63 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 48d77f360a24..7370c152ce8a 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -181,6 +181,56 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
>  		found->full = 0;
>  }
>  
> +/*
> + * Compute chunk size depending on block type for regular volumes.
> + */
> +static u64 compute_chunk_size_regular(struct btrfs_fs_info *info, u64 flags)
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
> + * Compute chunk size for zoned volumes.
> + */
> +static u64 compute_chunk_size_zoned(struct btrfs_fs_info *info)
> +{
> +	return info->zone_size;
> +}

nit: This is trivial and so can simply be open-coded in
compute_chunk_size, yes it's static and will likely be compiled out but
it adds a bit of cognitive load when reading the code. In any case I'd
leave this to David to decide whether to leave the function or not.

> +
> +/*
> + * Compute chunk size depending on volume type.
> + */

<snip>


>  static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>  {
>  
> @@ -202,6 +252,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>  	INIT_LIST_HEAD(&space_info->tickets);
>  	INIT_LIST_HEAD(&space_info->priority_tickets);
>  	space_info->clamp = 1;
> +	space_info->default_chunk_size = compute_chunk_size(info, flags);
>  
>  	ret = btrfs_sysfs_add_space_info_type(info, space_info);
>  	if (ret)

<snip>

> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 546bf1146b2d..563e5b30060d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5063,26 +5063,16 @@ static void init_alloc_chunk_ctl_policy_regular(
>  				struct btrfs_fs_devices *fs_devices,
>  				struct alloc_chunk_ctl *ctl)
>  {
> -	u64 type = ctl->type;
> +	struct btrfs_space_info *space_info;
>  
> -	if (type & BTRFS_BLOCK_GROUP_DATA) {
> -		ctl->max_stripe_size = SZ_1G;
> -		ctl->max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
> -	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
> -		/* For larger filesystems, use larger metadata chunks */
> -		if (fs_devices->total_rw_bytes > 50ULL * SZ_1G)
> -			ctl->max_stripe_size = SZ_1G;
> -		else
> -			ctl->max_stripe_size = SZ_256M;
> -		ctl->max_chunk_size = ctl->max_stripe_size;
> -	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
> -		ctl->max_stripe_size = SZ_32M;
> -		ctl->max_chunk_size = 2 * ctl->max_stripe_size;
> -		ctl->devs_max = min_t(int, ctl->devs_max,
> -				      BTRFS_MAX_DEVS_SYS_CHUNK);
> -	} else {
> -		BUG();
> -	}
> +	space_info = btrfs_find_space_info(fs_devices->fs_info, ctl->type);
> +	ASSERT(space_info);
> +
> +	ctl->max_chunk_size = space_info->default_chunk_size;
> +	ctl->max_stripe_size = space_info->default_chunk_size;

Those are racy accesses, no ? Chunk allocation happens under
chunk_mutex, not the space_info lock ? Perhaps it could be turned into
an atomic?

> +
> +	if (ctl->type & BTRFS_BLOCK_GROUP_SYSTEM)
> +		ctl->devs_max = min_t(int, ctl->devs_max, BTRFS_MAX_DEVS_SYS_CHUNK);
>  
>  	/* We don't want a chunk larger than 10% of writable space */
>  	ctl->max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
> 
