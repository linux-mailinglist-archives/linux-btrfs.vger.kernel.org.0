Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87190109C35
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 11:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfKZKVS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 05:21:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:42742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727585AbfKZKVS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 05:21:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C782AB9D;
        Tue, 26 Nov 2019 10:21:15 +0000 (UTC)
Subject: Re: [PATCH v4 2/2] btrfs: reset device back to allocation state when
 removing
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191126084006.23262-1-jthumshirn@suse.de>
 <20191126084006.23262-3-jthumshirn@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cd73267b-3d6f-2f2d-4e06-b86bdb903139@suse.com>
Date:   Tue, 26 Nov 2019 12:21:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191126084006.23262-3-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.11.19 г. 10:40 ч., Johannes Thumshirn wrote:
> When closing a device, btrfs_close_one_device() first allocates a new
> device, copies the device to close's name, replaces it in the dev_list
> with the copy and then finally frees it.
> 
> This involves two memory allocation, which can potentially fail. As this
> code path is tricky to unwind, the allocation failures where handled by
> BUG_ON()s.
> 
> But this copying isn't strictly needed, all that is needed is resetting
> the device in question to it's state it had after the allocation.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Overall looks good one minor nit which can be fixed at commit time (or
ignored).

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> ---
> Changes to v3:
> - Clear DEV_STATE_WRITABLE _after_ btrfs_close_bdev() (Nik)
> ---
>  fs/btrfs/volumes.c | 38 +++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 2398b071bcf6..efabffa54a45 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1064,8 +1064,6 @@ static void btrfs_close_bdev(struct btrfs_device *device)
>  static void btrfs_close_one_device(struct btrfs_device *device)
>  {
>  	struct btrfs_fs_devices *fs_devices = device->fs_devices;
> -	struct btrfs_device *new_device;
> -	struct rcu_string *name;
>  
>  	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
>  	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
> @@ -1073,29 +1071,27 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>  		fs_devices->rw_devices--;
>  	}
>  
> -	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
> +	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
>  		fs_devices->missing_devices--;
> +		clear_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
> +	}
nit: you can use test_and_clear_bit

>  
> +	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>  	btrfs_close_bdev(device);
> -	if (device->bdev)
> +	if (device->bdev) {
>  		fs_devices->open_devices--;
> -
> -	new_device = btrfs_alloc_device(NULL, &device->devid,
> -					device->uuid);
> -	BUG_ON(IS_ERR(new_device)); /* -ENOMEM */
> -
> -	/* Safe because we are under uuid_mutex */
> -	if (device->name) {
> -		name = rcu_string_strdup(device->name->str, GFP_NOFS);
> -		BUG_ON(!name); /* -ENOMEM */
> -		rcu_assign_pointer(new_device->name, name);
> -	}
> -
> -	list_replace_rcu(&device->dev_list, &new_device->dev_list);
> -	new_device->fs_devices = device->fs_devices;
> -
> -	synchronize_rcu();
> -	btrfs_free_device(device);
> +		device->bdev = NULL;
> +	}
> +	clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
> +
> +	/* Verify the device is back in a pristine state  */
> +	ASSERT(!test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state));
> +	ASSERT(!test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state));
> +	ASSERT(list_empty(&device->dev_alloc_list));
> +	ASSERT(list_empty(&device->post_commit_list));
> +	ASSERT(atomic_read(&device->reada_in_flight) == 0);
> +	ASSERT(atomic_read(&device->dev_stats_ccnt) == 0);
> +	ASSERT(RB_EMPTY_ROOT(&device->alloc_state.state));
>  }
>  
>  static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
> 
