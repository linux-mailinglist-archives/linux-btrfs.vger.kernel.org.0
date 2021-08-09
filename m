Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E8D3E4C4B
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 20:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbhHISoc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 14:44:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43868 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhHISob (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 14:44:31 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2DCD621F7B;
        Mon,  9 Aug 2021 18:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628534650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OUQmLDvkp5bsQpslkYxl5dl/l1WIlAAllcfAJNtcjTw=;
        b=Ty1zvZ2VFKfvmYl2SEeYhlN5UMh5DMTJsDdoKE/Btw+G2NP3wmYa53nHHoi0aTcH0U/1UI
        WmDbB/bd+3Ha9q6CpjjBloWCU9qtOw9Byce5Wugz2YQElhCX5HvkcTiugcmplgqxMvOiMz
        e36TlJGYv0gbXvKN2kNw9PSG+WCwsig=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id F109E136C1;
        Mon,  9 Aug 2021 18:44:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id cphLOHl3EWEIRQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 09 Aug 2021 18:44:09 +0000
Subject: Re: [PATCH] btrfs-progs: Drop the type check in
 init_alloc_chunk_ctl_policy_regular
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20210809182613.4466-1-mpdesouza@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <c830b01e-08c5-c2fb-c322-3f216f53dd8e@suse.com>
Date:   Mon, 9 Aug 2021 21:44:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809182613.4466-1-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.08.21 г. 21:26, Marcos Paulo de Souza wrote:
> [PROBLEM]
> Our documentation says that a DATA block group can have up to 1G of
> size, or the at most 10% of the filesystem size. Currently, by default,
> mkfs.btrfs is creating an initial DATA block group of 8M of size,
> regardless of the filesystem size. It happens because we check for the
> ctl->type in init_alloc_chunk_ctl_policy_regular to be one of the
> BTRFS_BLOCK_GROUP_PROFILE_MASK bits, which is not the case for SINGLE
> (default) DATA block group:
> 
> $ mkfs.btrfs -f /storage/btrfs.disk
> btrfs-progs v4.19.1
> See http://btrfs.wiki.kernel.org for more information.
> 
> Label:              (null)
> UUID:               39e3492f-41f2-4bd7-8c25-93032606b9fe
> Node size:          16384
> Sector size:        4096
> Filesystem size:    55.00GiB
> Block group profiles:
>   Data:             single            8.00MiB
>   Metadata:         DUP               1.00GiB
>   System:           DUP               8.00MiB
> SSD detected:       no
> Incompat features:  extref, skinny-metadata
> Number of devices:  1
> Devices:
>    ID        SIZE  PATH
>     1    55.00GiB  /storage/btrfs.disk
> 
> In this case, for single data profile, it should create a data block
> group of 1G, since the filesystem if bigger than 50G.
> 
> [FIX]
> Remove the check for BTRFS_BLOCK_GROUP_PROFILE_MASK in
> init_alloc_chunk_ctl_policy_regular function. The ctl->stripe_size is
> later on assigned to ctl.num_bytes, which is used by
> btrfs_make_block_group to create the block group.
> 
> By removing the check we allow the code to always configure the correct
> stripe_size regardless of the PROFILE, looking on the block group TYPE.
> 
> With the fix applied, it now created the BG correctly:
> 
> $ ./mkfs.btrfs -f /storage/btrfs.disk
> btrfs-progs v5.10.1
> See http://btrfs.wiki.kernel.org for more information.
> 
> Label:              (null)
> UUID:               5145e343-5639-462d-82ee-3eb75dc41c31
> Node size:          16384
> Sector size:        4096
> Filesystem size:    55.00GiB
> Block group profiles:
>   Data:             single            1.00GiB
>   Metadata:         DUP               1.00GiB
>   System:           DUP               8.00MiB
> SSD detected:       no
> Zoned device:       no
> Incompat features:  extref, skinny-metadata
> Runtime features:
> Checksum:           crc32c
> Number of devices:  1
> Devices:
>    ID        SIZE  PATH
>     1    55.00GiB  /storage/btrfs.disk
> 
> Using a disk >50G it creates a 1G single data block group. Another
> example:
> 
> $ ./mkfs.btrfs -f /storage/btrfs2.disk
> btrfs-progs v5.10.1
> See http://btrfs.wiki.kernel.org for more information.
> 
> Label:              (null)
> UUID:               c0910857-e512-4e76-9efa-50a475aafc87
> Node size:          16384
> Sector size:        4096
> Filesystem size:    5.00GiB
> Block group profiles:
>   Data:             single          512.00MiB
>   Metadata:         DUP             256.00MiB
>   System:           DUP               8.00MiB
> SSD detected:       no
> Zoned device:       no
> Incompat features:  extref, skinny-metadata
> Runtime features:
> Checksum:           crc32c
> Number of devices:  1
> Devices:
>    ID        SIZE  PATH
>     1     5.00GiB  /storage/btrfs2.disk
> 
> The code now created a single data block group of 512M, which is exactly
> 10% of the size of the filesystem, which is 5G in this case.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

I see no reason why we should care about BTRFS_BLOCK_GROUP_PROFILE_MASK
when creating the chunks. Without this patch ctl's various member are
being initialized to their defaults in init_alloc_chunk_ctl,
subsequently in create_chunk, chunk_bytes_by_type returns
return stripe_size * ctl->num_stripes; which is really SZ_8M * 1.

> ---
> 
>  This change mimics what the kernel currently does, which is set the stripe_size
>  regardless of the profile. Any thoughts on it? Thanks!
> 
>  kernel-shared/volumes.c | 40 +++++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
> index aeeb25fe..3677dd7c 100644
> --- a/kernel-shared/volumes.c
> +++ b/kernel-shared/volumes.c
> @@ -1105,27 +1105,25 @@ static void init_alloc_chunk_ctl_policy_regular(struct btrfs_fs_info *info,
>  	u64 type = ctl->type;
>  	u64 percent_max;
>  
> -	if (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> -		if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
> -			ctl->stripe_size = SZ_8M;
> -			ctl->max_chunk_size = ctl->stripe_size * 2;
> -			ctl->min_stripe_size = SZ_1M;
> -			ctl->max_stripes = BTRFS_MAX_DEVS_SYS_CHUNK;
> -		} else if (type & BTRFS_BLOCK_GROUP_DATA) {
> -			ctl->stripe_size = SZ_1G;
> -			ctl->max_chunk_size = 10 * ctl->stripe_size;
> -			ctl->min_stripe_size = SZ_64M;
> -			ctl->max_stripes = BTRFS_MAX_DEVS(info);
> -		} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
> -			/* For larger filesystems, use larger metadata chunks */
> -			if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
> -				ctl->max_chunk_size = SZ_1G;
> -			else
> -				ctl->max_chunk_size = SZ_256M;
> -			ctl->stripe_size = ctl->max_chunk_size;
> -			ctl->min_stripe_size = SZ_32M;
> -			ctl->max_stripes = BTRFS_MAX_DEVS(info);
> -		}
> +	if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
> +		ctl->stripe_size = SZ_8M;
> +		ctl->max_chunk_size = ctl->stripe_size * 2;
> +		ctl->min_stripe_size = SZ_1M;
> +		ctl->max_stripes = BTRFS_MAX_DEVS_SYS_CHUNK;
> +	} else if (type & BTRFS_BLOCK_GROUP_DATA) {
> +		ctl->stripe_size = SZ_1G;
> +		ctl->max_chunk_size = 10 * ctl->stripe_size;
> +		ctl->min_stripe_size = SZ_64M;
> +		ctl->max_stripes = BTRFS_MAX_DEVS(info);
> +	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
> +		/* For larger filesystems, use larger metadata chunks */
> +		if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
> +			ctl->max_chunk_size = SZ_1G;
> +		else
> +			ctl->max_chunk_size = SZ_256M;
> +		ctl->stripe_size = ctl->max_chunk_size;
> +		ctl->min_stripe_size = SZ_32M;
> +		ctl->max_stripes = BTRFS_MAX_DEVS(info);
>  	}
>  
>  	/* We don't want a chunk larger than 10% of the FS */
> 
