Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37E9E10A33A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 18:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfKZRRH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 12:17:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:57370 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727532AbfKZRRH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 12:17:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4723DAE47;
        Tue, 26 Nov 2019 17:17:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 982B0DA898; Tue, 26 Nov 2019 18:17:03 +0100 (CET)
Date:   Tue, 26 Nov 2019 18:17:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] btrfs: reset device back to allocation state when
 removing
Message-ID: <20191126171703.GO2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191126084006.23262-1-jthumshirn@suse.de>
 <20191126084006.23262-3-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126084006.23262-3-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 26, 2019 at 09:40:06AM +0100, Johannes Thumshirn wrote:
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

The changelong should say something about RCU as this is being changed
here.

RCU was for the dev_list and and device name, with some read-only list
traversal that can run in parallel (like FS_INFO or DEV_INFO ioctls).
This is safe because the device list hook is not removed and the name is
not changed.

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

I went through members of the device struct, lots of them are set once
so don't change. last_flush_error is set and read during commit,

Besides the dev_state bits handled above, I think tre rest should be
here too, ie.  BTRFS_DEV_STATE_IN_FS_METADATA and
BTRFS_DEV_STATE_MISSING (though this might be ok to keep as-is).
