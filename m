Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0444929D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 16:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345995AbiARPoL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 10:44:11 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50072 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345950AbiARPoI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 10:44:08 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A4F791F3C7;
        Tue, 18 Jan 2022 15:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642520647;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJ8mslxkPx6xYrtG8RAMidbRCSdstGvUhp9HBz1P5F0=;
        b=ZGsXV7ueBOiaNnbNslTYkDPuGXco3IBOYoQBBAhxrqs5TzqNUtjWyyroqsFQrt9X2aXrRK
        ZflV/0ZdnkuglXgUPzCVq8xEcyoCCuYtKhfyjk4tHGSKs2t8aLrhezxR3+OJtTOn3XGlfO
        pqMnpV2rzP8HCaaf6kbQv2uincH6vko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642520647;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJ8mslxkPx6xYrtG8RAMidbRCSdstGvUhp9HBz1P5F0=;
        b=jvXhTMbCpenzMQESEixPN0etbs7na5lklXnuRST65EN5mpQCwUmSYRUkMuG5oQaHq+47A7
        nN0VJHah+Zs2L6Cg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9E13CA3B94;
        Tue, 18 Jan 2022 15:44:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F3C01DA7A3; Tue, 18 Jan 2022 16:43:30 +0100 (CET)
Date:   Tue, 18 Jan 2022 16:43:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, nborisov@suse.com
Subject: Re: [PATCH v2] btrfs: cleanup finding rotating device
Message-ID: <20220118154330.GN14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, nborisov@suse.com
References: <1b19262076d9ae10d3ff81f73209249375ae25bc.1642048893.git.anand.jain@oracle.com>
 <d56216c5f955862d31be7c9884222fa9b7a4ddbd.1642060052.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d56216c5f955862d31be7c9884222fa9b7a4ddbd.1642060052.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 13, 2022 at 03:48:54PM +0800, Anand Jain wrote:
> The pointer to struct request_queue is used only to get device type
> rotating or the non-rotating. So use it directly.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Eliminate the if statement.
> 
>  fs/btrfs/volumes.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 70b085dff500..34d08c4f7b6c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -601,7 +601,6 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  			struct btrfs_device *device, fmode_t flags,
>  			void *holder)
>  {
> -	struct request_queue *q;
>  	struct block_device *bdev;
>  	struct btrfs_super_block *disk_super;
>  	u64 devid;
> @@ -643,9 +642,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  			set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>  	}
>  
> -	q = bdev_get_queue(bdev);
> -	if (!blk_queue_nonrot(q))
> -		fs_devices->rotating = true;
> +	fs_devices->rotating = !blk_queue_nonrot(bdev_get_queue(bdev));

This is an equivalent change, in the new code fs_devices->rotating will
be always set according to the last device, while in the old code, any
rotational device will set it to true and never back.

>  
>  	device->bdev = bdev;
>  	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
> @@ -2590,7 +2587,6 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
>  int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path)
>  {
>  	struct btrfs_root *root = fs_info->dev_root;
> -	struct request_queue *q;
>  	struct btrfs_trans_handle *trans;
>  	struct btrfs_device *device;
>  	struct block_device *bdev;
> @@ -2666,7 +2662,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  		goto error_free_zone;
>  	}
>  
> -	q = bdev_get_queue(bdev);
>  	set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>  	device->generation = trans->transid;
>  	device->io_width = fs_info->sectorsize;
> @@ -2714,8 +2709,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  
>  	atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
>  
> -	if (!blk_queue_nonrot(q))
> -		fs_devices->rotating = true;
> +	fs_devices->rotating = !blk_queue_nonrot(bdev_get_queue(bdev));

Same here.

>  
>  	orig_super_total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
>  	btrfs_set_super_total_bytes(fs_info->super_copy,
> -- 
> 2.33.1
