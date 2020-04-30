Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32D41BF989
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 15:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgD3NcB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 09:32:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:40404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgD3NcB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 09:32:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 597A5AC91;
        Thu, 30 Apr 2020 13:31:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B5503DA728; Thu, 30 Apr 2020 15:31:12 +0200 (CEST)
Date:   Thu, 30 Apr 2020 15:31:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com,
        josef@toxicpanda.com
Subject: Re: [PATCH 3/3] btrfs: free alien device due to device add
Message-ID: <20200430133111.GL18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com,
        josef@toxicpanda.com
References: <20200428152227.8331-1-anand.jain@oracle.com>
 <20200428152227.8331-4-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428152227.8331-4-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 28, 2020 at 11:22:27PM +0800, Anand Jain wrote:
> When the old device has new fsid through btrfs device add -f <dev> our
> fs_devices list has an alien device in one of the fs_devices. So this is
> a trigger and not the root cause of the issue. This patch fixes the trigger.
> 
> By having an alien device in fs_devices, we have two issues so far
> 
> 1. missing device is not shows as missing in the userland
> 
> Which is due to cracks in the function btrfs_open_one_device() and
> hardened by the pending patches in the ml.
>  btrfs: remove identified alien device in open_fs_devices
>  btrfs: remove identified alien btrfs device in open_fs_devices
> 
> 2. mount of a degraded fs_devices fails
> 
> Which is due to cracks in the function btrfs_free_extra_devids() and
> hardened by patch (included in the set).
>  btrfs: include non-missing as a qualifier for the latest_bdev
> 
> Now the trigger for both of this issue is that there is an alien (does not
> contain the intended fsid/btrfs_magic) device in the fs_devices.
> 
> We know a device can be scanned/added through
> btrfs-control::BTRFS_IOC_SCAN_DEV|BTRFS_IOC_DEVICES_READY
> or by
> ioctl::BTRFS_IOC_ADD_DEV
> 
> And device coming through btrfs-control is checked against the all other
> devices in btrfs kernel but not coming through BTRFS_IOC_ADD_DEV.
> 
> This patch checks if the device add is alienating any other scanned
> device and deletes it.
> 
> In fact, this patch fixes both the issues 1 and 2 (above) by eliminating
> the trigger of the issue, but still they have their own patch as well
> because its the right way to harden the functions and fill the cracks.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v3-rebased: change log updated.
> 
>  fs/btrfs/volumes.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a67af16d960d..300ee5f0bfa2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2665,6 +2665,19 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  
>  	/* Update ctime/mtime for libblkid */
>  	update_dev_time(device_path);
> +
> +	/*
> +	 * Now that we have written a new sb into this device, check all other
> +	 * fs_devices list if it alienates any scanned device.
> +	 */
> +	mutex_lock(&uuid_mutex);
> +	/*
> +	 * Ignore the return as we are successfull in the core task - to added
> +	 * the device
> +	 */
> +	btrfs_free_stale_devices(device_path, NULL);

So this is open coding btrfs_forget_devices, so the helper should be
used.

As there's NULL passed, all stale devices will be removed from the list,
but we can remove just the device being added, no? And before the whole
operation starts, not after. The closest moment is before
btrfs_commit_transaction, that's where the superblock gets overwritten.

> +	mutex_unlock(&uuid_mutex);
> +
>  	return ret;
>  
>  error_sysfs:
> -- 
> 2.23.0
