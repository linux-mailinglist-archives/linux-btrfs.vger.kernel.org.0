Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A03223A79
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jul 2020 13:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgGQLZL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 07:25:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:33888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgGQLZK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 07:25:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF64AAE25;
        Fri, 17 Jul 2020 11:25:12 +0000 (UTC)
Subject: Re: [PATCH] btrfs: fix lockdep warning while mounting sprout fs
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     martin.petersen@oracle.com
References: <20200717100525.320697-1-anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3d76a318-9ef2-0125-0b46-4466a54a2e84@suse.com>
Date:   Fri, 17 Jul 2020 14:25:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717100525.320697-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.07.20 г. 13:05 ч., Anand Jain wrote:
> Martin reported the following test case which reproduces lockdep
> warning on his machine.
> 
>   modprobe scsi_debug dev_size_mb=1024 num_parts=2
>   sleep 3
>   mkfs.btrfs /dev/sda1
>   mount /dev/sda1 /mnt
>   cp -v /bin/ls /mnt
>   umount /mnt
>   btrfstune -S 1 /dev/sda1
>   mount /dev/sda1 /mnt
>   btrfs dev add /dev/sda2 /mnt
>   umount /mnt
>   mount /dev/sda2 /mnt
>   <splat>
> 
> kernel: ======================================================
> kernel: WARNING: possible circular locking dependency detected
> kernel: 5.8.0-rc1+ #575 Not tainted
> kernel: ------------------------------------------------------
> kernel: mount/1024 is trying to acquire lock:
> kernel: ffff888065e0a4e0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: clone_fs_devices+0x46/0x1f0 [btrfs]
> kernel: #012but task is already holding lock:
> kernel: ffff8880610508d0 (&fs_info->chunk_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0xd1/0x390 [btrfs]
> kernel: #012which lock already depends on the new lock.
> kernel: #012the existing dependency chain (in reverse order) is:
> kernel: #012-> #1 (&fs_info->chunk_mutex){+.+.}-{3:3}:
> kernel:       __lock_acquire+0x798/0xe50
> kernel:       lock_acquire+0x15a/0x4d0
> kernel:       __mutex_lock+0x116/0xbd0
> kernel:       btrfs_remove_chunk+0x769/0xaa0 [btrfs]
> kernel:       btrfs_delete_unused_bgs+0xa2c/0xfe0 [btrfs]
> kernel:       cleaner_kthread+0x27c/0x2a0 [btrfs]
> kernel:       kthread+0x1d6/0x200
> kernel:       ret_from_fork+0x22/0x30
> kernel: #012-> #0 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
> kernel:       check_prev_add+0xf5/0xf50
> kernel:       validate_chain+0xca7/0x1920
> kernel:       __lock_acquire+0x798/0xe50
> kernel:       lock_acquire+0x15a/0x4d0
> kernel:       __mutex_lock+0x116/0xbd0
> kernel:       clone_fs_devices+0x46/0x1f0 [btrfs]
> kernel:       read_one_dev+0x15f/0x930 [btrfs]
> kernel:       btrfs_read_chunk_tree+0x333/0x390 [btrfs]
> kernel:       open_ctree+0xa72/0x15a6 [btrfs]
> kernel:       btrfs_mount_root.cold+0xe/0xf1 [btrfs]
> kernel:       legacy_get_tree+0x82/0xd0
> kernel:       vfs_get_tree+0x4c/0x140
> kernel:       fc_mount+0xf/0x60
> kernel:       vfs_kern_mount.part.0+0x71/0x90
> kernel:       btrfs_mount+0x1d7/0x610 [btrfs]
> kernel:       legacy_get_tree+0x82/0xd0
> kernel:       vfs_get_tree+0x4c/0x140
> kernel:       do_mount+0xad1/0xe70
> kernel:       __x64_sys_mount+0xbe/0x100
> kernel:       do_syscall_64+0x56/0xa0
> kernel:       entry_SYSCALL_64_after_hwframe+0x44/0xa9
> kernel: #012other info that might help us debug this:
> kernel: Possible unsafe locking scenario:
> kernel:       CPU0                    CPU1
> kernel:       ----                    ----
> kernel:  lock(&fs_info->chunk_mutex);
> kernel:                               lock(&fs_devs->device_list_mutex);
> kernel:                               lock(&fs_info->chunk_mutex);
> kernel:  lock(&fs_devs->device_list_mutex);
> kernel: #012 *** DEADLOCK ***
> ================================================
> 
> Lockdep warning is complaining about the violation of the lock order of
> device_list_mutex and chunk_mutex[1]. And, lockdep warning isn't entirely
> correct, as it appears that it can't understand the different filesystem
> instances.  Here, chunk_mutex was held by the mounting sprout filesystem,
> and device_list_mutex was held belongs to the seed filesystem as the sprout
> does not want the seed device to be freed.
> 
> [1]
> open_ctree <== mount sprout
>  btrfs_read_chunk_tree()
>   mutex_lock(&uuid_mutex) <== global fsid lock
>   mutex_lock(&fs_info->chunk_mutex) <== sprout fs
>    read_one_dev()
>     open_seed_devices()
>      clone_fs_devices()
>        mutex_lock(&orig->device_list_mutex) <== seed fs_devices

open_seed_devices doesn't delete the seed device
> 
> There are two function stacks [1] and [2] leading to clone_fs_devices().
> 
> [2]
> btrfs_init_new_device()
>  mutex_lock(&uuid_mutex);
>  btrfs_prepare_sprout()
>   lockdep_assert_held(&uuid_mutex);
>    clone_fs_devices()

and neither does prepare_sprout. So why are you mentioning them in the
context of freeing seed devices? By the way clone_fs_devices also
doesn't free the seed.

> 
> They both hold the uuid_mutex which is sufficient to protect from
> freeing the seed device. That's because a seed device can not be

As such the first sentence is false, because holding the uuid_mutex in
those 2 paths has absolutely no relevance to freeing the seed devices.

> freed while it is mounted because it is read-only and an unmounted
> seed device (but registered) can be freed only by the command forget
> or making it stale. Which is handled by the function
> btrfs_free_stale_devices() which also needs uuid_mutex.

Both of those cases seem to be handled by btrfs_forget_devices which
indeed holds the uuid_mutex so this is correct.

> 
> So remove the unnecessary seed->device_list_mutex in clone_fs_devices.
> 
> Reported-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Tested-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
> The above test case is similar to fstests btrfs/161 so no new
> test case will be required.
> 
>  fs/btrfs/volumes.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c35603b5595a..9dc3b826be0d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -561,6 +561,8 @@ static int btrfs_free_stale_devices(const char *path,
>  	struct btrfs_device *device, *tmp_device;
>  	int ret = 0;
>  
> +	lockdep_assert_held(&uuid_mutex);
> +
>  	if (path)
>  		ret = -ENOENT;
>  
> @@ -985,7 +987,6 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
>  	if (IS_ERR(fs_devices))
>  		return fs_devices;
>  
> -	mutex_lock(&orig->device_list_mutex);
>  	fs_devices->total_devices = orig->total_devices;
>  
>  	list_for_each_entry(orig_dev, &orig->devices, dev_list) {
> @@ -1017,10 +1018,8 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
>  		device->fs_devices = fs_devices;
>  		fs_devices->num_devices++;
>  	}
> -	mutex_unlock(&orig->device_list_mutex);
>  	return fs_devices;
>  error:
> -	mutex_unlock(&orig->device_list_mutex);
>  	free_fs_devices(fs_devices);
>  	return ERR_PTR(ret);
>  }
> 
