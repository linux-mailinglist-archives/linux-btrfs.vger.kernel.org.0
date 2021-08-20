Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E59F3F27B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 09:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbhHTHhx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 03:37:53 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:51486 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbhHTHhw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 03:37:52 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 4006B1E00619;
        Fri, 20 Aug 2021 10:37:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1629445033; bh=xybIllDJ2RsYTIft4gowZ+hIsT6e1P4qswILX7uNI2w=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=nV0NLP/gU3KJDmJwlKEM8/wqa724UWkRgQ5Trl6gVQrw+D5jFgxMDWzZftcSRt7zk
         BBYXvuHOwxo5+o+A7aneHEnoZY0ZUQ6Pik0vBbfj0v+u5KcDhcjlQCwXhne6kqFYgz
         sa8X5jJ8W1p1s0GeuxC94I7OhW+0p+1X/+ET5b38=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 35D271E00610;
        Fri, 20 Aug 2021 10:37:13 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id TbWdhhM6l4rL; Fri, 20 Aug 2021 10:37:12 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id C219A1E0060B;
        Fri, 20 Aug 2021 10:37:12 +0300 (EEST)
Received: from nas (unknown [49.65.73.48])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 3D1C71BE00AB;
        Fri, 20 Aug 2021 10:37:10 +0300 (EEST)
References: <cover.1629396187.git.anand.jain@oracle.com>
 <9a06b04b9003f86c3300e497b35b0ef0310c84c0.1629396187.git.anand.jain@oracle.com>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH RFC 3/3] btrfs: use latest_bdev in btrfs_show_devname
Date:   Fri, 20 Aug 2021 15:31:11 +0800
Message-ID: <1r6ofu54.fsf@damenly.su>
In-reply-to: <9a06b04b9003f86c3300e497b35b0ef0310c84c0.1629396187.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWetdgtE0TYrL+Dm55TE3V0G3GeDUSOAd1YLVQ6wnnJyRWA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Fri 20 Aug 2021 at 02:18, Anand Jain <anand.jain@oracle.com> 
wrote:

> latest_bdev is updated according to the changes to the device 
> list.
> That means we could use the latest_bdev to show the device name 
> in
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
>
Mabybe a naive question but I have no time to dive into btrfs code
recently. If a device which has highest devid was replaced, will 
the
new device be the fs_devices->latest_bdev instead of the existing 
older
one?

Thanks.

--
Su
>  fs/btrfs/super.c | 25 +++----------------------
>  1 file changed, 3 insertions(+), 22 deletions(-)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 1f9dd1a4faa3..4ad3fe174c41 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2464,30 +2464,11 @@ static int btrfs_unfreeze(struct 
> super_block *sb)
>  static int btrfs_show_devname(struct seq_file *m, struct dentry 
>  *root)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
> -	struct btrfs_device *dev, *first_dev = NULL;
> +	char name[BDEVNAME_SIZE];
>
> -	/*
> -	 * Lightweight locking of the devices. We should not need
> -	 * device_list_mutex here as we only read the device data and 
> the list
> -	 * is protected by RCU.  Even if a device is deleted during 
> the list
> -	 * traversals, we'll get valid data, the freeing callback will 
> wait at
> -	 * least until the rcu_read_unlock.
> -	 */
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(dev, &fs_info->fs_devices->devices, 
> dev_list) {
> -		if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
> -			continue;
> -		if (!dev->name)
> -			continue;
> -		if (!first_dev || dev->devid < first_dev->devid)
> -			first_dev = dev;
> -	}
> +	seq_escape(m, bdevname(fs_info->fs_devices->latest_bdev, 
> name),
> +		   " \t\n\\");
>
> -	if (first_dev)
> -		seq_escape(m, rcu_str_deref(first_dev->name), " \t\n\\");
> -	else
> -		WARN_ON(1);
> -	rcu_read_unlock();
>  	return 0;
>  }
