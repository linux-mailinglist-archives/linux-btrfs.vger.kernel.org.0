Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C2221D7C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgGMOEi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 10:04:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:51536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729703AbgGMOEi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 10:04:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F976AED7;
        Mon, 13 Jul 2020 14:04:38 +0000 (UTC)
Subject: Re: [PATCH] btrfs_show_devname don't traverse into the seed fsid
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20200710063738.28368-1-anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <88241a07-9994-bf83-c06f-374611bc03c7@suse.com>
Date:   Mon, 13 Jul 2020 17:04:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710063738.28368-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.07.20 г. 9:37 ч., Anand Jain wrote:
> ->show_devname currently shows the lowest devid in the list. As the seed
> devices have the lowest devid in the sprouted filesystem, the userland
> tool such as findmnt end up seeing seed device instead of the device from
> the read-writable sprouted filesystem. As shown below.
> 
>  mount /dev/sda /btrfs
>  mount: /btrfs: WARNING: device write-protected, mounted read-only.
> 
>  findmnt --output SOURCE,TARGET,UUID /btrfs
>  SOURCE   TARGET UUID
>  /dev/sda /btrfs 899f7027-3e46-4626-93e7-7d4c9ad19111
> 
>  btrfs dev add -f /dev/sdb /btrfs
> 
>  umount /btrfs
>  mount /dev/sdb /btrfs
> 
>  findmnt --output SOURCE,TARGET,UUID /btrfs
>  SOURCE   TARGET UUID
>  /dev/sda /btrfs 899f7027-3e46-4626-93e7-7d4c9ad19111
> 
> 
> All sprouts from a single seed will show the same seed device and the
> same fsid. That's messy.
> This is causing problems in our prototype as there isn't any reference
> to the sprout file-system(s) which is being used for actual read and
> write.
> 
> This was added in the patch which implemented the show_devname in btrfs
> commit 9c5085c14798 (Btrfs: implement ->show_devname).
> I tried to look for any particular reason that we need to show the seed
> device, there isn't any.
> 
> So instead, do not traverse through the seed devices, just show the
> lowest devid in the sprouted fsid.
> 
> After the patch:
> 
>  mount /dev/sda /btrfs
>  mount: /btrfs: WARNING: device write-protected, mounted read-only.
> 
>  findmnt --output SOURCE,TARGET,UUID /btrfs
>  SOURCE   TARGET UUID
>  /dev/sda /btrfs 899f7027-3e46-4626-93e7-7d4c9ad19111
> 
>  btrfs dev add -f /dev/sdb /btrfs
>  mount -o rw,remount /dev/sdb /btrfs
> 
>  findmnt --output SOURCE,TARGET,UUID /btrfs
>  SOURCE   TARGET UUID
>  /dev/sdb /btrfs 595ca0e6-b82e-46b5-b9e2-c72a6928be48
> 
>  mount /dev/sda /btrfs1
>  mount: /btrfs1: WARNING: device write-protected, mounted read-only.
> 
>  btrfs dev add -f /dev/sdc /btrfs1
> 
>  findmnt --output SOURCE,TARGET,UUID /btrfs1
>  SOURCE   TARGET  UUID
>  /dev/sdc /btrfs1 ca1dbb7a-8446-4f95-853c-a20f3f82bdbb
> 
>  cat /proc/self/mounts | grep btrfs
>  /dev/sdb /btrfs btrfs rw,relatime,noacl,space_cache,subvolid=5,subvol=/ 0 0
>  /dev/sdc /btrfs1 btrfs ro,relatime,noacl,space_cache,subvolid=5,subvol=/ 0 0
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>

> ---
> This has passed the xfstests/btrfs sucessfully with no new
> regressions. Thanks.
> 
>  fs/btrfs/super.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index c7ee119cffa1..1e2a36f5c792 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2377,9 +2377,7 @@ static int btrfs_unfreeze(struct super_block *sb)
>  static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
> -	struct btrfs_fs_devices *cur_devices;
>  	struct btrfs_device *dev, *first_dev = NULL;
> -	struct list_head *head;
>  
>  	/*
>  	 * Lightweight locking of the devices. We should not need
> @@ -2389,18 +2387,13 @@ static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
>  	 * least until the rcu_read_unlock.
>  	 */
>  	rcu_read_lock();
> -	cur_devices = fs_info->fs_devices;
> -	while (cur_devices) {
> -		head = &cur_devices->devices;
> -		list_for_each_entry_rcu(dev, head, dev_list) {
> -			if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
> -				continue;
> -			if (!dev->name)
> -				continue;
> -			if (!first_dev || dev->devid < first_dev->devid)
> -				first_dev = dev;
> -		}
> -		cur_devices = cur_devices->seed;
> +	list_for_each_entry_rcu(dev, &fs_info->fs_devices->devices, dev_list) {
> +		if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
> +			continue;
> +		if (!dev->name)
> +			continue;
> +		if (!first_dev || dev->devid < first_dev->devid)
> +			first_dev = dev;
>  	}
>  
>  	if (first_dev)
> 
