Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901811C611D
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 21:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgEETfV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 May 2020 15:35:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:41806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbgEETfV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 May 2020 15:35:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D80A1AB7D;
        Tue,  5 May 2020 19:35:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5FC12DA726; Tue,  5 May 2020 21:34:31 +0200 (CEST)
Date:   Tue, 5 May 2020 21:34:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 3/3] btrfs: free alien device due to device add
Message-ID: <20200505193431.GV18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20200428152227.8331-4-anand.jain@oracle.com>
 <20200504185826.9954-2-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504185826.9954-2-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 05, 2020 at 02:58:26AM +0800, Anand Jain wrote:
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

Such notes do not belong to changelog, the subjects don't say enough
about the problem or the fix.

> 2. mount of a degraded fs_devices fails
> 
> Which is due to cracks in the function btrfs_free_extra_devids() and
> hardened by patch (included in the set).
>  btrfs: include non-missing as a qualifier for the latest_bdev

Same.

> The trigger for both of this issue is that there is an alien (does not
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

So I'm not sure how much the review holds when the code changes between
iterations. The right way is to drop the rev-by and CC the person for
any non-trivial or maybe for all changes.

I also rewrote the changelog as it's sometimes hard to understand what
you mean, I had most problems with the use of the term 'trigger'.

> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2664,6 +2664,15 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  
>  	/* Update ctime/mtime for libblkid */
>  	update_dev_time(device_path);
> +
> +	/*
> +	 * Now that we have written a new sb into this device, check all other
> +	 * fs_devices list if device_path alienates any other scanned device.
> +	 * Ignore the return as we are successfull in the core task - add
> +	 * the device.
> +	 */
> +	btrfs_forget_devices(device_path);

Actually this should go before update_dev_time, as this is the point
when the file change could be detected by udev and rescanned, which
increases the window between commit and removal from fs_devices.
