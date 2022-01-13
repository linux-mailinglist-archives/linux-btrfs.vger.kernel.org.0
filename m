Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2601048D2FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jan 2022 08:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiAMHiL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 02:38:11 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50162 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiAMHiK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 02:38:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 709001F3A3;
        Thu, 13 Jan 2022 07:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642059489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ftGM/r9Dv95S9XTAWJi+iuhz9G6y7tgfCHlfsMgjj5w=;
        b=MiqUVZ2iCMcyq2vfp/JcJwsf5DQGugi8rmlZhuSq7+3WB3uUmguGNtQy9YLjfdbl6FAjVO
        RNYdzAnEOe5XIJAXKmAhdzidEpGZeXc+8MHqf/k83Lxs4r1NJGKBUspZ6AbsjqfxXNp3qT
        K0rjG8UYmhZRXxWLGcKKA6FBLEQE0Oo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4333713E32;
        Thu, 13 Jan 2022 07:38:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tRw9DeHW32HwNgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 13 Jan 2022 07:38:09 +0000
Subject: Re: [PATCH] btrfs: cleanup finding rotating device
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <1b19262076d9ae10d3ff81f73209249375ae25bc.1642048893.git.anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <36153eed-0fb9-ac05-0e5c-24e05f97a87e@suse.com>
Date:   Thu, 13 Jan 2022 09:38:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1b19262076d9ae10d3ff81f73209249375ae25bc.1642048893.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.01.22 г. 6:44, Anand Jain wrote:
> The pointer to struct request_queue is used only to get device type
> rotating or the non-rotating. So use it directly.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 7e92bf130137..68ea15e8e3cb 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -609,7 +609,6 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  			struct btrfs_device *device, fmode_t flags,
>  			void *holder)
>  {
> -	struct request_queue *q;
>  	struct block_device *bdev;
>  	struct btrfs_super_block *disk_super;
>  	u64 devid;
> @@ -651,8 +650,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  			set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>  	}
>  
> -	q = bdev_get_queue(bdev);
> -	if (!blk_queue_nonrot(q))
> +	if (!blk_queue_nonrot(bdev_get_queue(bdev)))
>  		fs_devices->rotating = true;

Eliminate the altogether:

fs_devices->rotating = !blk_queue_nonrot(bdev_get_queue(bdev));

>  
>  	device->bdev = bdev;
> @@ -2600,7 +2598,6 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
>  int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path)
>  {
>  	struct btrfs_root *root = fs_info->dev_root;
> -	struct request_queue *q;
>  	struct btrfs_trans_handle *trans;
>  	struct btrfs_device *device;
>  	struct block_device *bdev;
> @@ -2676,7 +2673,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  		goto error_free_zone;
>  	}
>  
> -	q = bdev_get_queue(bdev);
>  	set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>  	device->generation = trans->transid;
>  	device->io_width = fs_info->sectorsize;
> @@ -2724,7 +2720,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  
>  	atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
>  
> -	if (!blk_queue_nonrot(q))
> +	if (!blk_queue_nonrot(bdev_get_queue(bdev)))
>  		fs_devices->rotating = true;

Ditto

>  
>  	orig_super_total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
> 
