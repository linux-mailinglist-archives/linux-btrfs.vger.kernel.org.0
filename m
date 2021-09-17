Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A9240FCA0
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 17:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243019AbhIQPiy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 11:38:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45392 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242844AbhIQPix (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 11:38:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C56ED1FF5A;
        Fri, 17 Sep 2021 15:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631893050;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DtXsw8lXahyqjI+OuLsNAbtaStDHdwa/STTNduVdF7A=;
        b=KewngvvoDvVjKBW8t195hmBntaOq040UsbSW6SPYYQueyuimu0CV0M9CO7Da1+fwin6l0l
        JTT2JneATitO3qQEaooFvEouxQiXktD2iAau+Ck76tD6aW0+GcuJ+5zzoC8rWTk2Em+y0i
        Uxdztx3h4bdMRl7ojebLHn0ppnESFgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631893050;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DtXsw8lXahyqjI+OuLsNAbtaStDHdwa/STTNduVdF7A=;
        b=UiGwNAh7AxNZoDjQeNYkTf0MqhkXvuJnYEa8qCUBuM5qu7PFzVKd58x8Wtzj6SBs5xR4e1
        Moh2JPhbL4FBPoDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BB417A3B8A;
        Fri, 17 Sep 2021 15:37:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E1A30DA781; Fri, 17 Sep 2021 17:37:20 +0200 (CEST)
Date:   Fri, 17 Sep 2021 17:37:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, l@damenly.su
Subject: Re: [PATCH RFC V5 2/2] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
Message-ID: <20210917153720.GW9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, l@damenly.su
References: <cover.1630370459.git.anand.jain@oracle.com>
 <f00bad4ba0e8fd7f0c46c21118537fd49fd3c359.1630370459.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f00bad4ba0e8fd7f0c46c21118537fd49fd3c359.1630370459.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 31, 2021 at 09:21:29AM +0800, Anand Jain wrote:
> btrfs_prepare_sprout() moves seed devices into its own struct fs_devices,
> so that its parent function btrfs_init_new_device() can add the new sprout
> device to fs_info->fs_devices.
> 
> Both btrfs_prepare_sprout() and btrfs_init_new_device() needs
> device_list_mutex. But they are holding it sequentially, thus creates a
> small window to an opportunity to race. Close this opportunity and hold
> device_list_mutex common to both btrfs_init_new_device() and
> btrfs_prepare_sprout().

I don't se what exactly would go wrong with the separate device list
locking, but I see at least one potential problem with the new code.

> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> RFC because IMO the cleanup of device_list_mutex makes sense even though
> there isn't another thread that could race potentially race as of now.
> 
> Depends on
>  [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
> which removed the device_list_mutex from clone_fs_devices() otherwise
> this patch will cause a double mutex error.
> 
> v2: fix the missing mutex_unlock in the error return
> v3: -
> v4: -
> v5: - (Except for the change in below SO comments)
> 
>  fs/btrfs/volumes.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fa9fe47b5b68..53ead67b625c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2369,6 +2369,8 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>  	u64 super_flags;
>  
>  	lockdep_assert_held(&uuid_mutex);
> +	lockdep_assert_held(&fs_devices->device_list_mutex);
> +
>  	if (!fs_devices->seeding)
>  		return -EINVAL;
>  
> @@ -2400,7 +2402,6 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>  	INIT_LIST_HEAD(&seed_devices->alloc_list);
>  	mutex_init(&seed_devices->device_list_mutex);

A few lines before this one there's alloc_fs_devices and
clone_fs_devices, both allocating memory. This would happen under a big
lock as device_list_mutex also protects superblock write. This is a
pattern to avoid.

A rough idea would be to split btrfs_prepare_sprout into parts where the
allocations are not done under the lock and the locked part. It could be
partially inlined to btrfs_init_new_device.

>  
> -	mutex_lock(&fs_devices->device_list_mutex);
>  	list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
>  			      synchronize_rcu);
>  	list_for_each_entry(device, &seed_devices->devices, dev_list)
> @@ -2416,7 +2417,6 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>  	generate_random_uuid(fs_devices->fsid);
>  	memcpy(fs_devices->metadata_uuid, fs_devices->fsid, BTRFS_FSID_SIZE);
>  	memcpy(disk_super->fsid, fs_devices->fsid, BTRFS_FSID_SIZE);
> -	mutex_unlock(&fs_devices->device_list_mutex);
>  
>  	super_flags = btrfs_super_flags(disk_super) &
>  		      ~BTRFS_SUPER_FLAG_SEEDING;
> @@ -2591,10 +2591,12 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	device->dev_stats_valid = 1;
>  	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
>  
> +	mutex_lock(&fs_devices->device_list_mutex);
>  	if (seeding_dev) {
>  		btrfs_clear_sb_rdonly(sb);
>  		ret = btrfs_prepare_sprout(fs_info);
>  		if (ret) {
> +			mutex_unlock(&fs_devices->device_list_mutex);
>  			btrfs_abort_transaction(trans, ret);
>  			goto error_trans;
>  		}
> @@ -2604,7 +2606,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  
>  	device->fs_devices = fs_devices;
>  
> -	mutex_lock(&fs_devices->device_list_mutex);
>  	mutex_lock(&fs_info->chunk_mutex);
>  	list_add_rcu(&device->dev_list, &fs_devices->devices);
>  	list_add(&device->dev_alloc_list, &fs_devices->alloc_list);
> -- 
> 2.31.1
