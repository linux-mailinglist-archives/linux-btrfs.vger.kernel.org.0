Return-Path: <linux-btrfs+bounces-444-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D987FE1B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 22:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C1C281E76
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 21:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4498061698;
	Wed, 29 Nov 2023 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="etui1BS0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2CB10C2
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 13:20:45 -0800 (PST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id 8Rz9rH8eYEwsU8Rz9rwvCK; Wed, 29 Nov 2023 22:20:43 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1701292843; bh=pfdnGCR1q5WhLw3OuY+T6kwDa+3Tv8Gq4PsJz9Hn0FI=;
	h=From;
	b=etui1BS0kdvWudTHxaFevsS8M+lWp7C4m6EnpS1oM25ZFD5Y63wGXJfvDJmIP/Etv
	 tL1q3bKhBvEdXY4A2eDeYKTdyJ5Ijs1Eyzt4Ffjw4wspMGiqtjCWqGGBpNjd57Ty1I
	 9q21SssYe/g9hQPBtO/bHaxHIeW3M6Gr9pjfhwVc1B2fUCfjSKZhhBqDVn9LK77QZ5
	 u1KySwGQ3wZNr9pI5uyXdSMYkoSrq++zTZLeMeNnNH23/+H0U49RJvMAXXYLEI/zZA
	 VWPJ95H8y1xN6I6bxaXeJhmcfaDuHICbxbtlCmOY9Kl4NsHzEm+eXouccYSyat79lG
	 W3JUoA8+kknuw==
X-CNFS-Analysis: v=2.4 cv=N6vvVUxB c=1 sm=1 tr=0 ts=6567ab2b cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=yPCof4ZbAAAA:8 a=1KMvhpZiXAMMLewUw68A:9 a=QEXdDO2ut3YA:10
Message-ID: <95be8cb9-73b0-4263-9c1c-96522323a78e@libero.it>
Date: Wed, 29 Nov 2023 22:20:43 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH RFC] btrfs: pick device with lowest devt for show_devname
Content-Language: en-US
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <85226cf68d7a72a034f0c0895b96b2557169755b.1698917826.git.anand.jain@oracle.com>
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <85226cf68d7a72a034f0c0895b96b2557169755b.1698917826.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfD4tvHzkOfIRxII+DxmesELjaruZQfbct5XW7gFBIFIS7Gu0w+65aeVV4jmyUyWQNKmKFBXbdiZZSDIFfs9PXQ4dJxE23jLyH+SANDoiOvZLDWOpgfvq
 uLwkX6/tCjpo70Ck5wZTfwtxjQwnSlvVF9FeYNDeaV/tGbKITaL1QaGEk/oYeIMXABsYI5PjX0EtC30fohRjJLNgPFPW62XrKlhJNVgFnBh+Jsto/W4OnrRs

On 02/11/2023 12.10, Anand Jain wrote:
> In a non-single-device Btrfs filesystem, if Btrfs is already mounted and
> if you run the command 'mount -a,' it will fail and the command
> 'umount <device>' also fails. As below:
> 
> ----------------
> $ cat /etc/fstab | grep btrfs
> UUID=12345678-1234-1234-1234-123456789abc /btrfs btrfs defaults,nofail 0 0
> 
> $ mkfs.btrfs -qf --uuid 12345678-1234-1234-1234-123456789abc /dev/sda2 /dev/sda1
> $ mount --verbose -a
> /                        : ignored
> /btrfs                   : successfully mounted
> 
> $ ls -l /dev/disk/by-uuid | grep 12345678-1234-1234-1234-123456789abc
> lrwxrwxrwx 1 root root 10 Nov  2 17:43 12345678-1234-1234-1234-123456789abc -> ../../sda1
> 
> $ cat /proc/self/mounts | grep btrfs
> /dev/sda2 /btrfs btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0
> 
> $ findmnt --df /btrfs
> SOURCE    FSTYPE SIZE  USED AVAIL USE% TARGET
> /dev/sda2 btrfs    2G  5.8M  1.8G   0% /btrfs
> 
> $ mount --verbose -a
> /                        : ignored
> mount: /btrfs: /dev/sda1 already mounted or mount point busy.
> $echo $?
> 32
> 
> $ umount /dev/sda1
> umount: /dev/sda1: not mounted.
> $ echo $?
> 32
> ----------------
> 
> I assume (RFC) this is because '/dev/disk/by-uuid,' '/proc/self/mounts,'
> and 'findmnt' do not all reference the same device, resulting in the
> 'mount -a' and 'umount' failures. However, an empirically found solution
> is to align them using a rule, such as the disk with the lowest 'devt,'
> for a multi-device Btrfs filesystem.

What about creating dedicated helper like mount.btrfs and umount.btrfs
that can manage all these kind of details ?

mount.btrfs may also help to have a better understand about problem
like a device missing.

> 
> I'm not yet sure (RFC) how to create a udev rule to point to the disk with
> the lowest 'devt,' as this kernel patch does, and I believe it is
> possible.
> 
> And this would ensure that '/proc/self/mounts,' 'findmnt,' and
> '/dev/disk/by-uuid' all reference the same device.
> 
> After applying this patch, the above test passes. Unfortunately,
> /dev/disk/by-uuid also points to the lowest 'devt' by chance, even though
> no rule has been set as of now. As shown below.
> 
> ----------------
> $ mkfs.btrfs -qf --uuid 12345678-1234-1234-1234-123456789abc /dev/sda2 /dev/sda1
> 
> $ mount --verbose -a
> /                        : ignored
> /btrfs                   : successfully mounted
> 
> $ ls -l /dev/disk/by-uuid | grep 12345678-1234-1234-1234-123456789abc
> lrwxrwxrwx 1 root root 10 Nov  2 17:53 12345678-1234-1234-1234-123456789abc -> ../../sda1
> 
> $ cat /proc/self/mounts | grep btrfs
> /dev/sda1 /btrfs btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0
> 
> $ findmnt --df /btrfs
> SOURCE    FSTYPE SIZE  USED AVAIL USE% TARGET
> /dev/sda1 btrfs    2G  5.8M  1.8G   0% /btrfs
> 
> $ mount --verbose -a
> /                        : ignored
> /btrfs                   : already mounted
> $echo $?
> 0
> 
> $ umount /dev/sda1
> $echo $?
> 0
> ----------------
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/super.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 66bdb6fd83bd..d768917cc5cc 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2301,7 +2301,18 @@ static int btrfs_unfreeze(struct super_block *sb)
>   
>   static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
>   {
> -	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
> +	struct btrfs_fs_devices *fs_devices = btrfs_sb(root->d_sb)->fs_devices;
> +	struct btrfs_device *device;
> +	struct btrfs_device *first_device = NULL;
> +
> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		if (first_device == NULL) {
> +			first_device = device;
> +			continue;
> +		}
> +		if (first_device->devt > device->devt)
> +			first_device = device;
> +	}
>   
>   	/*
>   	 * There should be always a valid pointer in latest_dev, it may be stale
> @@ -2309,7 +2320,7 @@ static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
>   	 * the end of RCU grace period.
>   	 */
>   	rcu_read_lock();
> -	seq_escape(m, btrfs_dev_name(fs_info->fs_devices->latest_dev), " \t\n\\");
> +	seq_escape(m, rcu_str_deref(first_device->name), " \t\n\\");
>   	rcu_read_unlock();
>   
>   	return 0;

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


