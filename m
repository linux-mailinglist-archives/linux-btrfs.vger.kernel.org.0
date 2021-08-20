Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BD33F2A76
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 13:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbhHTLBc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 07:01:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50898 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbhHTLBb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 07:01:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6889B1FE02;
        Fri, 20 Aug 2021 11:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629457253;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0tUfYUIN2qZ0QxiAenWyGbNtKppvAyiAcTO0iByjHaA=;
        b=0ulLxZz5H8Xw2D+y6CxBUyrg5mcXr2IW0c7n7bM9vy0A4iFbAcKa0HKrRb127uujimuB8X
        iM1wfV39RRaYXZ5Y7Vou/bCEHZwEVv1LVom6cOq2rKQamY7+4acA+PDAMn3vBtdBmDIL+b
        i7kRuT428SHjX8hFPUp4olozr/tFRu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629457253;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0tUfYUIN2qZ0QxiAenWyGbNtKppvAyiAcTO0iByjHaA=;
        b=rLSrDXSk8cEBiZhBHrHJx34hMVbLo1Kl0sxbAV3e55r6aehFXfMgdMGE5dtb78WeszKryx
        lg1BjgQoB0NvgQCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5E18DA3B84;
        Fri, 20 Aug 2021 11:00:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AE84EDA730; Fri, 20 Aug 2021 12:57:55 +0200 (CEST)
Date:   Fri, 20 Aug 2021 12:57:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, l@damenly.su
Subject: Re: [PATCH RFC 3/3] btrfs: use latest_bdev in btrfs_show_devname
Message-ID: <20210820105755.GM5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, l@damenly.su
References: <cover.1629396187.git.anand.jain@oracle.com>
 <9a06b04b9003f86c3300e497b35b0ef0310c84c0.1629396187.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a06b04b9003f86c3300e497b35b0ef0310c84c0.1629396187.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 20, 2021 at 02:18:14AM +0800, Anand Jain wrote:
> latest_bdev is updated according to the changes to the device list.
> That means we could use the latest_bdev to show the device name in
> /proc/self/mounts. So this patch makes that change.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> 
> RFC because
> 1. latest_bdev might not be the lowest devid but, we showed
> the lowest devid in /proc/self/mount.
> 2. The device's path is not shown now but, previously we did.
> So does these break ABI? Maybe yes for 2 howabout for 1 above?

The path needs to be preserved, that would break a lot of things..

>  fs/btrfs/super.c | 25 +++----------------------
>  1 file changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 1f9dd1a4faa3..4ad3fe174c41 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2464,30 +2464,11 @@ static int btrfs_unfreeze(struct super_block *sb)
>  static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
> -	struct btrfs_device *dev, *first_dev = NULL;
> +	char name[BDEVNAME_SIZE];
>  
> -	/*
> -	 * Lightweight locking of the devices. We should not need
> -	 * device_list_mutex here as we only read the device data and the list
> -	 * is protected by RCU.  Even if a device is deleted during the list
> -	 * traversals, we'll get valid data, the freeing callback will wait at
> -	 * least until the rcu_read_unlock.
> -	 */
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(dev, &fs_info->fs_devices->devices, dev_list) {
> -		if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
> -			continue;
> -		if (!dev->name)
> -			continue;
> -		if (!first_dev || dev->devid < first_dev->devid)
> -			first_dev = dev;
> -	}
> +	seq_escape(m, bdevname(fs_info->fs_devices->latest_bdev, name),
> +		   " \t\n\\");

No protection at all? So what if latest_bdev or latest_dev gets updated
in parallel with devicre remove and there's a window where the pointer
is invalid but still is accessed. The whole point of RCU section here is
to prevent that.

>  
> -	if (first_dev)
> -		seq_escape(m, rcu_str_deref(first_dev->name), " \t\n\\");
> -	else
> -		WARN_ON(1);
> -	rcu_read_unlock();
>  	return 0;
>  }
>  
> -- 
> 2.31.1
