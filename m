Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62BB49D014
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 17:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbiAZQxp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 11:53:45 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51256 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbiAZQxp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 11:53:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F2DB4218F8;
        Wed, 26 Jan 2022 16:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643216024;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N1wKGgFaNiQdRZZ5SMos8WeK6cc3zY0DjE7KEKoNyqE=;
        b=HjWj46nBaSkdcZrPHqoLQbMEcUdy9ZER6vIXZy8H0gXyCo8SNiBVhl0vRUjKIZDJkSHwTi
        B2USm9KO61bJok2Tnjkd3LiPLEbToqIa3uzD+ADcE/ze+CU47tf6jS/wxByjEv7m8PikGU
        5Q1Z7/GDkpxSBgglt1y36eYDYmj4604=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643216024;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N1wKGgFaNiQdRZZ5SMos8WeK6cc3zY0DjE7KEKoNyqE=;
        b=z1grC9DlYEbGVAojv4ODLoF0QSPgcXFbR53+Czwa1+O02XQuM/EwKbfxD4VkA60Ph2uUFF
        7G4as6B8DUrEy0Cg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EC8D7A3B85;
        Wed, 26 Jan 2022 16:53:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0A69FDA7A9; Wed, 26 Jan 2022 17:53:02 +0100 (CET)
Date:   Wed, 26 Jan 2022 17:53:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: keep device type in the struct btrfs_device
Message-ID: <20220126165302.GC14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1642518245.git.anand.jain@oracle.com>
 <c815946b0b05990230e9342cc50da3d146268b65.1642518245.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c815946b0b05990230e9342cc50da3d146268b65.1642518245.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 18, 2022 at 11:18:01PM +0800, Anand Jain wrote:
> Preparation to make data/metadata chunks allocations based on the device
> types- keep the identified device type in the struct btrfs_device.
> 
> This patch adds a member 'dev_type' to hold the defined device types in
> the struct btrfs_devices.
> 
> Also, add a helper function and a struct btrfs_fs_devices member
> 'mixed_dev_type' to know if the filesystem contains the mixed device
> types.
> 
> Struct btrfs_device has an existing member 'type' that stages and writes
> back to the on-disk format. This patch does not use it. As just an
> in-memory only data will suffice the requirement here.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/dev-replace.c |  2 ++
>  fs/btrfs/volumes.c     | 45 ++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.h     | 26 +++++++++++++++++++++++-
>  3 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 71fd99b48283..3731c7d1c6b7 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -325,6 +325,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>  	device->dev_stats_valid = 1;
>  	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
>  	device->fs_devices = fs_devices;
> +	device->dev_type = btrfs_get_device_type(device);
>  
>  	ret = btrfs_get_dev_zone_info(device, false);
>  	if (ret)
> @@ -334,6 +335,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>  	list_add(&device->dev_list, &fs_devices->devices);
>  	fs_devices->num_devices++;
>  	fs_devices->open_devices++;
> +	fs_devices->mixed_dev_types = btrfs_has_mixed_dev_types(fs_devices);
>  	mutex_unlock(&fs_devices->device_list_mutex);
>  
>  	*device_out = device;
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 9d50e035e61d..da3d6d0f5bc3 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1041,6 +1041,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
>  			     device->generation > (*latest_dev)->generation)) {
>  				*latest_dev = device;
>  			}
> +			device->dev_type = btrfs_get_device_type(device);
>  			continue;
>  		}
>  
> @@ -1084,6 +1085,7 @@ void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices)
>  		__btrfs_free_extra_devids(seed_dev, &latest_dev);
>  
>  	fs_devices->latest_dev = latest_dev;
> +	fs_devices->mixed_dev_types = btrfs_has_mixed_dev_types(fs_devices);
>  
>  	mutex_unlock(&uuid_mutex);
>  }
> @@ -2183,6 +2185,9 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>  
>  	num_devices = btrfs_super_num_devices(fs_info->super_copy) - 1;
>  	btrfs_set_super_num_devices(fs_info->super_copy, num_devices);
> +
> +	cur_devices->mixed_dev_types = btrfs_has_mixed_dev_types(cur_devices);
> +
>  	mutex_unlock(&fs_devices->device_list_mutex);
>  
>  	/*
> @@ -2584,6 +2589,44 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
>  	return ret;
>  }
>  
> +bool btrfs_has_mixed_dev_types(struct btrfs_fs_devices *fs_devices)
> +{
> +	struct btrfs_device *device;
> +	int type_rot = 0;
> +	int type_nonrot = 0;
> +
> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +
> +		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
> +			continue;
> +
> +		switch (device->dev_type) {
> +		case BTRFS_DEV_TYPE_ROT:
> +			type_rot++;
> +			break;
> +		case BTRFS_DEV_TYPE_NONROT:
> +		default:
> +			type_nonrot++;
> +		}
> +	}
> +
> +	if (type_rot && type_nonrot)
> +		return true;
> +	else
> +		return false;
> +}
> +
> +enum btrfs_dev_types btrfs_get_device_type(struct btrfs_device *device)
> +{
> +	if (bdev_is_zoned(device->bdev))
> +		return BTRFS_DEV_TYPE_ZONED;
> +
> +	if (blk_queue_nonrot(bdev_get_queue(device->bdev)))
> +		return BTRFS_DEV_TYPE_NONROT;
> +
> +	return BTRFS_DEV_TYPE_ROT;
> +}
> +
>  int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path)
>  {
>  	struct btrfs_root *root = fs_info->dev_root;
> @@ -2675,6 +2718,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
>  	device->mode = FMODE_EXCL;
>  	device->dev_stats_valid = 1;
> +	device->dev_type = btrfs_get_device_type(device);
>  	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
>  
>  	if (seeding_dev) {
> @@ -2710,6 +2754,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
>  
>  	fs_devices->rotating = !blk_queue_nonrot(bdev_get_queue(bdev));
> +	fs_devices->mixed_dev_types = btrfs_has_mixed_dev_types(fs_devices);
>  
>  	orig_super_total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
>  	btrfs_set_super_total_bytes(fs_info->super_copy,
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 6a790b85edd8..5be31161601d 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -52,6 +52,16 @@ struct btrfs_io_geometry {
>  #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
>  #define BTRFS_DEV_STATE_NO_READA	(5)
>  
> +/*
> + * Device class types arranged by their IO latency from low to high.
> + */
> +enum btrfs_dev_types {
> +	BTRFS_DEV_TYPE_MEM = 1,
> +	BTRFS_DEV_TYPE_NONROT,
> +	BTRFS_DEV_TYPE_ROT,
> +	BTRFS_DEV_TYPE_ZONED,

I think this should be separate, in one list define all sensible device
types and then add arrays sorted by latency, or other factors.

The zoned devices are mostly HDD but ther are also SSD-like using ZNS,
so that can't be both under BTRFS_DEV_TYPE_ZONED and behind
BTRFS_DEV_TYPE_ROT as if it had worse latency.

I'm not sure how much we should try to guess the device types, the ones
you have so far are almost all we can get without peeking too much into
the devices/queues internals.

Also here's the terminology question if we should still consider
rotational device status as the main criteria, because then SSD, NVMe,
RAM-backed are all non-rotational but with different latency
characteristics.

> +};
> +
>  struct btrfs_zoned_device_info;
>  
>  struct btrfs_device {
> @@ -101,9 +111,16 @@ struct btrfs_device {
>  
>  	/* optimal io width for this device */
>  	u32 io_width;
> -	/* type and info about this device */
> +
> +	/* Type and info about this device, on-disk (currently unused) */
>  	u64 type;
>  
> +	/*
> +	 * Device type (in memory only) at some point, merge to the on-disk
> +	 * member 'type' above.
> +	 */
> +	enum btrfs_dev_types dev_type;

So at some point this is planned to be user configurable? We should be
always able to detect the device type at mount type so I wonder if this
needs to be stored on disk.
