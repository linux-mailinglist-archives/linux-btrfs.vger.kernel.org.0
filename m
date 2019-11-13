Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43E2EFB303
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 15:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfKMO66 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 09:58:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:37158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbfKMO65 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 09:58:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A1698B3F8;
        Wed, 13 Nov 2019 14:58:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 658AADA7E8; Wed, 13 Nov 2019 15:58:59 +0100 (CET)
Date:   Wed, 13 Nov 2019 15:58:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] btrfs: handle device allocation failure in
 btrfs_close_one_device()
Message-ID: <20191113145859.GB3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191113102728.8835-1-jthumshirn@suse.de>
 <20191113102728.8835-3-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113102728.8835-3-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 13, 2019 at 11:27:23AM +0100, Johannes Thumshirn wrote:
> In btrfs_close_one_device() we're allocating a new device and if this
> fails we BUG().
> 
> Move the allocation to the top of the function and return an error in case
> it failed.
> 
> The BUG_ON() is temporarily moved to close_fs_devices(), the caller of
> btrfs_close_one_device() as further work is pending to untangle this.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  fs/btrfs/volumes.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 5ee26e7fca32..0a2a73907563 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1061,12 +1061,17 @@ static void btrfs_close_bdev(struct btrfs_device *device)
>  	blkdev_put(device->bdev, device->mode);
>  }
>  
> -static void btrfs_close_one_device(struct btrfs_device *device)
> +static int btrfs_close_one_device(struct btrfs_device *device)
>  {
>  	struct btrfs_fs_devices *fs_devices = device->fs_devices;
>  	struct btrfs_device *new_device;
>  	struct rcu_string *name;
>  
> +	new_device = btrfs_alloc_device(NULL, &device->devid,
> +					device->uuid);
> +	if (IS_ERR(new_device))
> +		goto err_close_device;
> +
>  	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
>  	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
>  		list_del_init(&device->dev_alloc_list);
> @@ -1080,10 +1085,6 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>  	if (device->bdev)
>  		fs_devices->open_devices--;
>  
> -	new_device = btrfs_alloc_device(NULL, &device->devid,
> -					device->uuid);
> -	BUG_ON(IS_ERR(new_device)); /* -ENOMEM */
> -
>  	/* Safe because we are under uuid_mutex */
>  	if (device->name) {
>  		name = rcu_string_strdup(device->name->str, GFP_NOFS);
> @@ -1096,18 +1097,32 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>  
>  	synchronize_rcu();
>  	btrfs_free_device(device);
> +
> +	return 0;
> +
> +err_close_device:
> +	btrfs_close_bdev(device);
> +	if (device->bdev) {
> +		fs_devices->open_devices--;
> +		btrfs_sysfs_rm_device_link(fs_devices, device);
> +		device->bdev = NULL;
> +	}

I don't understand this part: the 'device' pointer is from the argument,
so the device we want to delete from the list and for that all the state
bit tests, bdev close, list replace rcu and synchronize_rcu should
happen -- in case we have a newly allocated new_device.

What I don't understand how the short version after label
err_close_device: is correct. The device is still left in the list but
with NULL bdev but rw_devices, missing_devices is untouched.

That a device closing needs to allocate memory for a new device instead
of reinitializing it again is stupid but with the simplified device
closing I'm not sure the state is well defined.
