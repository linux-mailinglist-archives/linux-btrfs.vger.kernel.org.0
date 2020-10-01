Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA78227FDB2
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 12:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbgJAKvB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 06:51:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:41376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732121AbgJAKvB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 06:51:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6C1BEABBD;
        Thu,  1 Oct 2020 10:50:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2B409DA781; Thu,  1 Oct 2020 12:49:39 +0200 (CEST)
Date:   Thu, 1 Oct 2020 12:49:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        nborisov@suse.com, josef@toxicpanda.com
Subject: Re: [PATCH v3] btrfs: free device without BTRFS_MAGIC
Message-ID: <20201001104938.GU6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        nborisov@suse.com, josef@toxicpanda.com
References: <dbc067b24194241f6d87b8f9799d9b6484984a13.1600473987.git.anand.jain@oracle.com>
 <e15a2f44a540c1e036e19664fd3a8220045dd762.1601470709.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e15a2f44a540c1e036e19664fd3a8220045dd762.1601470709.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 30, 2020 at 09:09:52PM +0800, Anand Jain wrote:
> Many things can happen after the device is scanned and before the device
> is mounted.
> 
> One such thing is losing the BTRFS_MAGIC on the device.
> 
> If it happens we still won't free that device from the memory and causes
> the userland to confuse.
> 
> For example: As the BTRFS_IOC_DEV_INFO still carries the device path which
> does not have the BTRFS_MAGIC, the btrfs fi show still shows device
> which does not belong. As shown below.
> 
> mkfs.btrfs -fq -draid1 -mraid1 /dev/sda /dev/sdb
> 
> wipefs -a /dev/sdb
> mount -o degraded /dev/sda /btrfs
> btrfs fi show -m
> 
> /dev/sdb does not contain BTRFS_MAGIC and we still show it as part of
> btrfs.
> Label: none  uuid: 470ec6fb-646b-4464-b3cb-df1b26c527bd
>         Total devices 2 FS bytes used 128.00KiB
>         devid    1 size 3.00GiB used 571.19MiB path /dev/sda
>         devid    2 size 3.00GiB used 571.19MiB path /dev/sdb
> 
> Fix is to return -ENODATA error code in btrfs_read_dev_one_super()
> when BTRFS_MAGIC check fails, and its parent open_fs_devices() to
> free the device in the mount-thread.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v3: First check for the BTRFS_MAGIC and then the bytenr check.
>     Add rb.
> v2: Do not return ENODATA on `btrfs_super_bytenr(super) != bytenr`
> 
>  fs/btrfs/disk-io.c |  8 ++++++--
>  fs/btrfs/volumes.c | 19 +++++++++++++------
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 3d39f5d47ad3..764001609a15 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3424,8 +3424,12 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
>  		return ERR_CAST(page);
>  
>  	super = page_address(page);
> -	if (btrfs_super_bytenr(super) != bytenr ||
> -		    btrfs_super_magic(super) != BTRFS_MAGIC) {
> +	if (btrfs_super_magic(super) != BTRFS_MAGIC) {
> +		btrfs_release_disk_super(super);
> +		return ERR_PTR(-ENODATA);
> +	}
> +
> +	if (btrfs_super_bytenr(super) != bytenr) {
>  		btrfs_release_disk_super(super);
>  		return ERR_PTR(-EINVAL);
>  	}
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c69da5eb7636..a208043b4419 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1197,17 +1197,24 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>  {
>  	struct btrfs_device *device;
>  	struct btrfs_device *latest_dev = NULL;
> +	struct btrfs_device *tmp_device;
>  
>  	flags |= FMODE_EXCL;
>  
> -	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> -		/* Just open everything we can; ignore failures here */
> -		if (btrfs_open_one_device(fs_devices, device, flags, holder))
> -			continue;
> +	list_for_each_entry_safe(device, tmp_device, &fs_devices->devices,
> +				 dev_list) {
> +		int ret;
>  
> -		if (!latest_dev ||
> -		    device->generation > latest_dev->generation)
> +		/* Just open everything we can; ignore failures here */

The comment does not make sense anymore, the failures are checked now.

> +		ret = btrfs_open_one_device(fs_devices, device, flags, holder);
> +		if (ret == 0 && (!latest_dev ||
> +		    device->generation > latest_dev->generation)) {
>  			latest_dev = device;
> +		} else if (ret == -ENODATA) {
> +			fs_devices->num_devices--;
> +			list_del(&device->dev_list);
> +			btrfs_free_device(device);

Now ret is ENODATA and we don't want to propagate that up the to the
callers. It's not a problem right now as open_fs_devices returns
directly or 0 at the end.

Otherwise it looks ok to me.
