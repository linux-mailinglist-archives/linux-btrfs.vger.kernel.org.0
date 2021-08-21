Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981A93F3B12
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Aug 2021 16:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhHUOvY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Aug 2021 10:51:24 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:57284 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhHUOvY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Aug 2021 10:51:24 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 835976C007B6;
        Sat, 21 Aug 2021 17:50:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1629557442; bh=EVr+1x8s9GzrAVjvaUJuYKHctxs8BTyJTGKSRV5fJTI=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=Qk28HJczyCHZPcWB21Dp8QCZ5RxIEd6YBW/lgDjtz5ce1n8VR89DNh/o9OEYLlskl
         D2nM1DoF2R+0P1jr9DxQuO1nP/nGrmY+KWYs/7ftFF3uNYlfBrfgh1qzfLm++3OnOM
         +ntKgjxHzxM1ski/oee480ZST3Er6UO7Wcki8SiY=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 7590B6C007AB;
        Sat, 21 Aug 2021 17:50:42 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id phXb5du8LQrU; Sat, 21 Aug 2021 17:50:42 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 100696C007A4;
        Sat, 21 Aug 2021 17:50:42 +0300 (EEST)
Received: from nas (unknown [49.65.73.48])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 87B791BE009C;
        Sat, 21 Aug 2021 17:50:37 +0300 (EEST)
References: <cover.1629458519.git.anand.jain@oracle.com>
 <61d6dafaff6a119f56782fb35b2374411585b634.1629458519.git.anand.jain@oracle.com>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v3 2/4] btrfs: save latest btrfs_device instead of its
 block_device in fs_devices
Date:   Sat, 21 Aug 2021 22:46:58 +0800
In-reply-to: <61d6dafaff6a119f56782fb35b2374411585b634.1629458519.git.anand.jain@oracle.com>
Message-ID: <v93yets9.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBlzQh1+nQ3rcDQU2qyxVPp7o+PvJoxAq4meDUSOAd1YLVQ6wnnJyRWA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Fri 20 Aug 2021 at 19:28, Anand Jain <anand.jain@oracle.com> 
wrote:

> In preparation to fix a bug in btrfs_show_devname(), save the 
> device with
> the largest generation in fs_info instead of just its bdev. So 
> that
> btrfs_show_devname() can read device's name.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: born
> v3: -
>  fs/btrfs/disk-io.c   |  6 +++---
>  fs/btrfs/extent_io.c |  2 +-
>  fs/btrfs/inode.c     |  2 +-
>  fs/btrfs/procfs.c    |  6 +++---
>

Try to test the patchset but...
I can't find procfs in Linus/master, kdave/misc-next, v5.14-rc6 
even
through Google search.

--
Su

>  fs/btrfs/super.c     |  2 +-
>  fs/btrfs/volumes.c   | 10 +++++-----
>  fs/btrfs/volumes.h   |  2 +-
>  7 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 1052437cec64..c0d2c093b874 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3228,12 +3228,12 @@ int __cold open_ctree(struct super_block 
> *sb, struct btrfs_fs_devices *fs_device
>  	mapping_set_gfp_mask(fs_info->btree_inode->i_mapping, 
>  GFP_NOFS);
>  	btrfs_init_btree_inode(fs_info);
>
> -	invalidate_bdev(fs_devices->latest_bdev);
> +	invalidate_bdev(fs_devices->latest_dev->bdev);
>
>  	/*
>  	 * Read super block and check the signature bytes only
>  	 */
> -	disk_super = btrfs_read_dev_super(fs_devices->latest_bdev);
> +	disk_super = 
> btrfs_read_dev_super(fs_devices->latest_dev->bdev);
>  	if (IS_ERR(disk_super)) {
>  		err = PTR_ERR(disk_super);
>  		goto fail_alloc;
> @@ -3466,7 +3466,7 @@ int __cold open_ctree(struct super_block 
> *sb, struct btrfs_fs_devices *fs_device
>  	 * below in btrfs_init_dev_replace().
>  	 */
>  	btrfs_free_extra_devids(fs_devices);
> -	if (!fs_devices->latest_bdev) {
> +	if (!fs_devices->latest_dev->bdev) {
>  		btrfs_err(fs_info, "failed to read devices");
>  		goto fail_tree_roots;
>  	}
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index aaddd7225348..edf0162c9020 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3327,7 +3327,7 @@ static int alloc_new_bio(struct 
> btrfs_inode *inode,
>  	if (wbc) {
>  		struct block_device *bdev;
>
> -		bdev = fs_info->fs_devices->latest_bdev;
> +		bdev = fs_info->fs_devices->latest_dev->bdev;
>  		bio_set_dev(bio, bdev);
>  		wbc_init_bio(wbc, bio);
>  	}
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2aa9646bce56..ceedcd54e6d2 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7961,7 +7961,7 @@ static int btrfs_dio_iomap_begin(struct 
> inode *inode, loff_t start,
>  		iomap->type = IOMAP_MAPPED;
>  	}
>  	iomap->offset = start;
> -	iomap->bdev = fs_info->fs_devices->latest_bdev;
> +	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
>  	iomap->length = len;
>
>  	if (write && btrfs_use_zone_append(BTRFS_I(inode), 
>  em->block_start))
> diff --git a/fs/btrfs/procfs.c b/fs/btrfs/procfs.c
> index 30eaeca07aeb..2c3bb474c28f 100644
> --- a/fs/btrfs/procfs.c
> +++ b/fs/btrfs/procfs.c
> @@ -291,9 +291,9 @@ void btrfs_print_fsinfo(struct seq_file 
> *seq)
>  					bdevname(fs_info->sb->s_bdev, b) :
>  					"null");
>  		BTRFS_SEQ_PRINT2("\tlatest_bdev:\t\t%s\n",
> -				fs_devices->latest_bdev ?
> -					bdevname(fs_devices->latest_bdev, b) :
> -					"null");
> +				  fs_devices->latest_dev->bdev ?
> +				  bdevname(fs_devices->latest_dev->bdev, b) :
> +				  "null");
>
>  		fs_state_to_str(fs_info, fs_str);
>  		BTRFS_SEQ_PRINT2("\tfs_state:\t\t%s\n", fs_str);
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 1f9dd1a4faa3..64ecbdb50c1a 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1706,7 +1706,7 @@ static struct dentry 
> *btrfs_mount_root(struct file_system_type *fs_type,
>  		goto error_close_devices;
>  	}
>
> -	bdev = fs_devices->latest_bdev;
> +	bdev = fs_devices->latest_dev->bdev;
>  	s = sget(fs_type, btrfs_test_super, btrfs_set_super, flags | 
>  SB_NOSEC,
>  		 fs_info);
>  	if (IS_ERR(s)) {
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 51cf68785782..958503c8a854 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1091,7 +1091,7 @@ void btrfs_free_extra_devids(struct 
> btrfs_fs_devices *fs_devices)
>  	list_for_each_entry(seed_dev, &fs_devices->seed_list, 
>  seed_list)
>  		__btrfs_free_extra_devids(seed_dev, &latest_dev);
>
> -	fs_devices->latest_bdev = latest_dev->bdev;
> +	fs_devices->latest_dev = latest_dev;
>
>  	mutex_unlock(&uuid_mutex);
>  }
> @@ -1206,7 +1206,7 @@ static int open_fs_devices(struct 
> btrfs_fs_devices *fs_devices,
>  		return -EINVAL;
>
>  	fs_devices->opened = 1;
> -	fs_devices->latest_bdev = latest_dev->bdev;
> +	fs_devices->latest_dev = latest_dev;
>  	fs_devices->total_rw_bytes = 0;
>  	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
>  	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
> @@ -1968,7 +1968,7 @@ static struct btrfs_device * 
> btrfs_find_next_active_device(
>  }
>
>  /*
> - * Helper function to check if the given device is part of 
> s_bdev / latest_bdev
> + * Helper function to check if the given device is part of 
> s_bdev / latest_dev
>   * and replace it with the provided or the next active device, 
>   in the context
>   * where this function called, there should be always be 
>   another device (or
>   * this_dev) which is active.
> @@ -1987,8 +1987,8 @@ void __cold 
> btrfs_assign_next_active_device(struct btrfs_device *device,
>  			(fs_info->sb->s_bdev == device->bdev))
>  		fs_info->sb->s_bdev = next_device->bdev;
>
> -	if (fs_info->fs_devices->latest_bdev == device->bdev)
> -		fs_info->fs_devices->latest_bdev = next_device->bdev;
> +	if (fs_info->fs_devices->latest_dev->bdev == device->bdev)
> +		fs_info->fs_devices->latest_dev = next_device;
>  }
>
>  /*
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 4c941b4dd269..150b4cd8f81f 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -246,7 +246,7 @@ struct btrfs_fs_devices {
>  	/* Highest generation number of seen devices */
>  	u64 latest_generation;
>
> -	struct block_device *latest_bdev;
> +	struct btrfs_device *latest_dev;
>
>  	/* all of the devices in the FS, protected by a mutex
>  	 * so we can safely walk it to write out the supers without
