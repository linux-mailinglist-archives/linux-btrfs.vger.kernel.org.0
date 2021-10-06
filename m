Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE3C4238FF
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 09:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhJFHge (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 03:36:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53718 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbhJFHge (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 03:36:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C506A20322;
        Wed,  6 Oct 2021 07:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633505681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8N1FC/N1Co+L8zqiTVSVQk+L8idADiVe3k1EYj0uEEo=;
        b=NwjRU+7StVj0MVg27iQv77+AugkYSUZ2q6MB0ir2fPItnXKFywJ3UDbfyzPJ3rDjHr3lrF
        uX5dceRuLCOpXQfGy7r74yP4+d+Ez2hUMcNKMG2k014nzMIgAyhFPLj6dIjKX16c2Vwazc
        SY/KnFdRlq32Ykn4TgvqeoGMS+pWFoM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9423D13E20;
        Wed,  6 Oct 2021 07:34:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cwChIZFRXWFIDwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 06 Oct 2021 07:34:41 +0000
Subject: Re: [PATCH v4 4/6] btrfs: handle device lookup with
 btrfs_dev_lookup_args
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1633464631.git.josef@toxicpanda.com>
 <dfcc04056a9895dedad6786a4d0944fffb3d82be.1633464631.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <cbc1df4a-d7bf-3c34-4c5c-c093512c08bf@suse.com>
Date:   Wed, 6 Oct 2021 10:34:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <dfcc04056a9895dedad6786a4d0944fffb3d82be.1633464631.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5.10.21 г. 23:12, Josef Bacik wrote:
> We have a lot of device lookup functions that all do something slightly
> different.  Clean this up by adding a struct to hold the different
> lookup criteria, and then pass this around to btrfs_find_device() so it
> can do the proper matching based on the lookup criteria.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Overall looks good, I have only some minor stylistic comments which can
be handled by David as well. In any case:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  fs/btrfs/dev-replace.c |  18 +++----
>  fs/btrfs/ioctl.c       |  13 ++---
>  fs/btrfs/scrub.c       |   6 ++-
>  fs/btrfs/volumes.c     | 120 +++++++++++++++++++++++++----------------
>  fs/btrfs/volumes.h     |  15 +++++-
>  5 files changed, 108 insertions(+), 64 deletions(-)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index d029be40ea6f..ff25da2dbd59 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -70,6 +70,7 @@ static int btrfs_dev_replace_kthread(void *data);
>  
>  int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
>  {
> +	BTRFS_DEV_LOOKUP_ARGS(args);

nit: This line can be:

struct btrfs_dev_lookup_args args = {.devid = BTRFS_DEV_REPLACE_DEVID};

as it doesn't go over the 76 char limit, the only reason I'm suggesting
it is for consistency sake, since in
btrfs_scrub_progress/btrfs_scrub_dev the latter style is preferred.

>  	struct btrfs_key key;
>  	struct btrfs_root *dev_root = fs_info->dev_root;
>  	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
> @@ -84,6 +85,8 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
>  	if (!dev_root)
>  		return 0;
>  
> +	args.devid = BTRFS_DEV_REPLACE_DEVID;
> +
>  	path = btrfs_alloc_path();
>  	if (!path) {
>  		ret = -ENOMEM;

<snip>

> @@ -6753,6 +6755,32 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
>  	return BLK_STS_OK;
>  }
>  
> +static inline bool dev_args_match_fs_devices(struct btrfs_dev_lookup_args *args,
> +					     struct btrfs_fs_devices *fs_devices)
> +{
> +	if (args->fsid == NULL)
> +		return true;
> +	if (!memcmp(fs_devices->metadata_uuid, args->fsid, BTRFS_FSID_SIZE))
> +		return true;
> +	return false;

Make last 3 lines into:

return !memcmp(fs_devices->metadata_uuid, args->fsid, BTRFS_FSID_SIZE)

> +}
> +
> +static inline bool dev_args_match_device(struct btrfs_dev_lookup_args *args,
> +					 struct btrfs_device *device)
> +{
> +	ASSERT((args->devid != (u64)-1) || args->missing);
> +	if ((args->devid != (u64)-1) && device->devid != args->devid)
> +		return false;
> +	if (args->uuid && memcmp(device->uuid, args->uuid, BTRFS_UUID_SIZE))
> +		return false;
> +	if (!args->missing)
> +		return true;
> +	if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state) &&
> +	    !device->bdev)

That's a new check, under what conditions does it happen, when a device
is forcefully removed from the system?

> +		return true;
> +	return false;
> +}
> +
>  /*
>   * Find a device specified by @devid or @uuid in the list of @fs_devices, or
>   * return NULL.

<snip>

> @@ -517,7 +530,7 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
>  int btrfs_grow_device(struct btrfs_trans_handle *trans,
>  		      struct btrfs_device *device, u64 new_size);
>  struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices *fs_devices,
> -				       u64 devid, u8 *uuid, u8 *fsid);
> +				       struct btrfs_dev_lookup_args *args);

Let's annotate this pointer with const to be more explicit about this
being really an input-only struct.

>  int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
>  int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *path);
>  int btrfs_balance(struct btrfs_fs_info *fs_info,
> 
