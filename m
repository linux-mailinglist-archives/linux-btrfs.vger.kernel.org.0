Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6D041321B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 13:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhIULDI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 07:03:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58746 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbhIULDD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 07:03:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 387452006B;
        Tue, 21 Sep 2021 11:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632222094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9Xo7ps42dzlg3A/8e+gYCdMM0KcwW4LsYnnUblxV/s=;
        b=nFNZASVQmsn0AzBj7PA1kRjOb5KlIX59tbdMl2LsNnQSny2WaOdLeeAChT4s3jePl6nkJ4
        RouZ+0Sc3XvNyzhM7DLcdY1dghOOqM/I8N8jVhNCr2Q06kC5GkMiufjvk++wbWrBOmNayG
        Kglwz7wHeQRCCeD8ypsFA/jzrTJ35aU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0580413BC6;
        Tue, 21 Sep 2021 11:01:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eaxZOo27SWEVbwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 21 Sep 2021 11:01:33 +0000
Subject: Re: [PATCH v6 3/3] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <cover.1632179897.git.anand.jain@oracle.com>
 <ec3ecca596bf5d9de5e152942a277ab48915f0cf.1632179897.git.anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <840713c4-48ef-b4e6-91e3-f92158448b7c@suse.com>
Date:   Tue, 21 Sep 2021 14:01:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ec3ecca596bf5d9de5e152942a277ab48915f0cf.1632179897.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21.09.21 г. 7:33, Anand Jain wrote:
> btrfs_prepare_sprout() splices seed devices into its own struct fs_devices,
> so that its parent function btrfs_init_new_device() can add the new sprout
> device to fs_info->fs_devices.
> 
> Both btrfs_prepare_sprout() and btrfs_init_new_device() needs
> device_list_mutex. But they are holding it sequentially, thus creates a
> small window to an opportunity to race. Close this opportunity and hold
> device_list_mutex common to both btrfs_init_new_device() and
> btrfs_prepare_sprout().
> 
> This patch splits btrfs_prepare_sprout() into btrfs_alloc_sprout() and
> btrfs_splice_sprout(). This split is essential because device_list_mutex
> shouldn't be held for btrfs_alloc_sprout() but must be held for
> btrfs_splice_sprout(). So now a common device_list_mutex can be used
> between btrfs_init_new_device() and btrfs_splice_sprout().
> 
> This patch also moves the lockdep_assert_held(&uuid_mutex) from the
> starting of the function to just above the line where we need this lock.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v6:
>  Remove RFC.
>  Split btrfs_prepare_sprout so that the allocation part can be outside
>  of the device_list_mutex in the parent function btrfs_init_new_device().
> 
>  fs/btrfs/volumes.c | 46 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e4079e25db70..b21eac32ec98 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2376,19 +2376,13 @@ struct btrfs_device *btrfs_find_device_by_devspec(
>  	return btrfs_find_device_by_path(fs_info, device_path);
>  }
>  
> -/*
> - * does all the dirty work required for changing file system's UUID.
> - */
> -static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
> +static int btrfs_alloc_sprout(struct btrfs_fs_info *fs_info,
> +			      struct btrfs_fs_devices **seed_devices_ret)

Nope, make the function return a struct btrfs_fs_devices *.

>  {
>  	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>  	struct btrfs_fs_devices *old_devices;
>  	struct btrfs_fs_devices *seed_devices;
> -	struct btrfs_super_block *disk_super = fs_info->super_copy;
> -	struct btrfs_device *device;
> -	u64 super_flags;
>  
> -	lockdep_assert_held(&uuid_mutex);
>  	if (!fs_devices->seeding)
>  		return -EINVAL;
>  
> @@ -2412,6 +2406,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>  		return PTR_ERR(old_devices);
>  	}
>  
> +	lockdep_assert_held(&uuid_mutex);
>  	list_add(&old_devices->fs_list, &fs_uuids);
>  
>  	memcpy(seed_devices, fs_devices, sizeof(*seed_devices));
> @@ -2419,7 +2414,23 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>  	INIT_LIST_HEAD(&seed_devices->devices);
>  	INIT_LIST_HEAD(&seed_devices->alloc_list);
>  
> -	mutex_lock(&fs_devices->device_list_mutex);
> +	*seed_devices_ret = seed_devices;
> +
> +	return 0;
> +}
> +
> +/*
> + * Splice seed devices into the sprout fs_devices.
> + * Generate a new fsid for the sprouted readwrite btrfs.
> + */
> +static void btrfs_splice_sprout(struct btrfs_fs_info *fs_info,
> +				struct btrfs_fs_devices *seed_devices)
> +{

This function is missing a lockdep_assert_held annotation and it depends
on the device_list_mutex being held.

However looking at the resulting code it doesn't look good, because
btrfs_splice_sporut suggests you simply add the seed device to a bunch
of places, yet looking at the function's body it's evident it actually
finishes some parts of the initialization, changes the uuid of the
fs_devices. I'm not convinced it really makes the code better or at the
very least the 'splice_sprout' needs to be changed, because splicing is
a minot part of what this function really does.


<snip>

