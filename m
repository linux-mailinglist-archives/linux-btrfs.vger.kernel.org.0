Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C046425A57A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 08:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgIBGVl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 02:21:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60596 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBGVk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 02:21:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08268xRt100795;
        Wed, 2 Sep 2020 06:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=OGPxzHwlt0kJbbTLVUWPZ/2365vVkp9pPlKIs2NlFr8=;
 b=nhE0wX6+FZQnQAIMbdVcrUtRdv3/PPAw4ipVXM56wqwF3M3mMTlDkgKQ3RobSx7eWOCh
 qXQvq/4lBQi0yLCnS6MSsvrT8KAbsSYIIGZtwTbb5mDXRle5kZD39Vi7KaoIA1IPSy1/
 Tt7ei8d4gZuqQAkjyYYjcNL8Lxiz1ULKOuFK3J719vsMCEtYexhcbsnW2ZHfjKtvWohu
 iFmtjcYNtUR4twU2r2MPEx5mElnpkboQyqmZCIyhPZh7Z6GFa0j7W/WEjZSTOp2OyTNR
 wWR0kIXe+BnR0bXK64yxwbbmv3M07GylE2DpKdQc1pWH2rJ269z7FWg4RDxX5wzKk5jp Dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 337eer0gfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 06:21:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0826B2md076392;
        Wed, 2 Sep 2020 06:21:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3380stb1a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 06:21:36 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0826LZc4000909;
        Wed, 2 Sep 2020 06:21:35 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Sep 2020 23:21:35 -0700
Subject: Re: [PATCH 2/4] btrfs: init sysfs for devices outside of the
 chunk_mutex
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1598996236.git.josef@toxicpanda.com>
 <5dccee8f9d7fe7b5072090327854fcbfdbd45b28.1598996236.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <79ace2bf-6f01-39ee-0566-727182c5ff85@oracle.com>
Date:   Wed, 2 Sep 2020 14:21:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <5dccee8f9d7fe7b5072090327854fcbfdbd45b28.1598996236.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020058
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/9/20 5:40 am, Josef Bacik wrote:
> While running btrfs/187 I hit the following lockdep splat
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.9.0-rc3+ #4 Not tainted
> ------------------------------------------------------
> kswapd0/100 is trying to acquire lock:
> ffff96ecc22ef4a0 (&delayed_node->mutex){+.+.}-{3:3}, at: __btrfs_release_delayed_node.part.0+0x3f/0x330
> 
> but task is already holding lock:
> ffffffff8dd74700 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x5/0x30
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #3 (fs_reclaim){+.+.}-{0:0}:
>         fs_reclaim_acquire+0x65/0x80
>         slab_pre_alloc_hook.constprop.0+0x20/0x200
>         kmem_cache_alloc+0x37/0x270
>         alloc_inode+0x82/0xb0
>         iget_locked+0x10d/0x2c0
>         kernfs_get_inode+0x1b/0x130
>         kernfs_get_tree+0x136/0x240
>         sysfs_get_tree+0x16/0x40
>         vfs_get_tree+0x28/0xc0
>         path_mount+0x434/0xc00
>         __x64_sys_mount+0xe3/0x120
>         do_syscall_64+0x33/0x40
>         entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> -> #2 (kernfs_mutex){+.+.}-{3:3}:
>         __mutex_lock+0x7e/0x7e0
>         kernfs_add_one+0x23/0x150
>         kernfs_create_link+0x63/0xa0
>         sysfs_do_create_link_sd+0x5e/0xd0
>         btrfs_sysfs_add_devices_dir+0x81/0x130
>         btrfs_init_new_device+0x67f/0x1250
>         btrfs_ioctl+0x1ef/0x2e20
>         __x64_sys_ioctl+0x83/0xb0
>         do_syscall_64+0x33/0x40
>         entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> -> #1 (&fs_info->chunk_mutex){+.+.}-{3:3}:
>         __mutex_lock+0x7e/0x7e0
>         btrfs_chunk_alloc+0x125/0x3a0
>         find_free_extent+0xdf6/0x1210
>         btrfs_reserve_extent+0xb3/0x1b0
>         btrfs_alloc_tree_block+0xb0/0x310
>         alloc_tree_block_no_bg_flush+0x4a/0x60
>         __btrfs_cow_block+0x11a/0x530
>         btrfs_cow_block+0x104/0x220
>         btrfs_search_slot+0x52e/0x9d0
>         btrfs_insert_empty_items+0x64/0xb0
>         btrfs_insert_delayed_items+0x90/0x4f0
>         btrfs_commit_inode_delayed_items+0x93/0x140
>         btrfs_log_inode+0x5de/0x2020
>         btrfs_log_inode_parent+0x429/0xc90
>         btrfs_log_new_name+0x95/0x9b
>         btrfs_rename2+0xbb9/0x1800
>         vfs_rename+0x64f/0x9f0
>         do_renameat2+0x320/0x4e0
>         __x64_sys_rename+0x1f/0x30
>         do_syscall_64+0x33/0x40
>         entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> -> #0 (&delayed_node->mutex){+.+.}-{3:3}:
>         __lock_acquire+0x119c/0x1fc0
>         lock_acquire+0xa7/0x3d0
>         __mutex_lock+0x7e/0x7e0
>         __btrfs_release_delayed_node.part.0+0x3f/0x330
>         btrfs_evict_inode+0x24c/0x500
>         evict+0xcf/0x1f0
>         dispose_list+0x48/0x70
>         prune_icache_sb+0x44/0x50
>         super_cache_scan+0x161/0x1e0
>         do_shrink_slab+0x178/0x3c0
>         shrink_slab+0x17c/0x290
>         shrink_node+0x2b2/0x6d0
>         balance_pgdat+0x30a/0x670
>         kswapd+0x213/0x4c0
>         kthread+0x138/0x160
>         ret_from_fork+0x1f/0x30
> 
> other info that might help us debug this:
> 
> Chain exists of:
>    &delayed_node->mutex --> kernfs_mutex --> fs_reclaim
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(fs_reclaim);
>                                 lock(kernfs_mutex);
>                                 lock(fs_reclaim);
>    lock(&delayed_node->mutex);
> 
>   *** DEADLOCK ***
> 
> 3 locks held by kswapd0/100:
>   #0: ffffffff8dd74700 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x5/0x30
>   #1: ffffffff8dd65c50 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x115/0x290
>   #2: ffff96ed2ade30e0 (&type->s_umount_key#36){++++}-{3:3}, at: super_cache_scan+0x38/0x1e0
> 
> stack backtrace:
> CPU: 0 PID: 100 Comm: kswapd0 Not tainted 5.9.0-rc3+ #4
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> Call Trace:
>   dump_stack+0x8b/0xb8
>   check_noncircular+0x12d/0x150
>   __lock_acquire+0x119c/0x1fc0
>   lock_acquire+0xa7/0x3d0
>   ? __btrfs_release_delayed_node.part.0+0x3f/0x330
>   __mutex_lock+0x7e/0x7e0
>   ? __btrfs_release_delayed_node.part.0+0x3f/0x330
>   ? __btrfs_release_delayed_node.part.0+0x3f/0x330
>   ? lock_acquire+0xa7/0x3d0
>   ? find_held_lock+0x2b/0x80
>   __btrfs_release_delayed_node.part.0+0x3f/0x330
>   btrfs_evict_inode+0x24c/0x500
>   evict+0xcf/0x1f0
>   dispose_list+0x48/0x70
>   prune_icache_sb+0x44/0x50
>   super_cache_scan+0x161/0x1e0
>   do_shrink_slab+0x178/0x3c0
>   shrink_slab+0x17c/0x290
>   shrink_node+0x2b2/0x6d0
>   balance_pgdat+0x30a/0x670
>   kswapd+0x213/0x4c0
>   ? _raw_spin_unlock_irqrestore+0x41/0x50
>   ? add_wait_queue_exclusive+0x70/0x70
>   ? balance_pgdat+0x670/0x670
>   kthread+0x138/0x160
>   ? kthread_create_worker_on_cpu+0x40/0x40
>   ret_from_fork+0x1f/0x30
> 
> This happens because we are holding the chunk_mutex at the time of
> adding in a new device.  However we only need to hold the
> device_list_mutex, as we're going to iterate over the fs_devices
> devices.  Move the sysfs init stuff outside of the chunk_mutex to get
> rid of this lockdep splat.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
 >
> ---
>   fs/btrfs/volumes.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d6bbbe1986bb..77b7da42c651 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2599,9 +2599,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	btrfs_set_super_num_devices(fs_info->super_copy,
>   				    orig_super_num_devices + 1);
>   
> -	/* add sysfs device entry */
> -	btrfs_sysfs_add_devices_dir(fs_devices, device);
> -
>   	/*
>   	 * we've got more storage, clear any full flags on the space
>   	 * infos
> @@ -2609,6 +2606,10 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	btrfs_clear_space_info_full(fs_info);
>   
>   	mutex_unlock(&fs_info->chunk_mutex);
> +
> +	/* add sysfs device entry */
> +	btrfs_sysfs_add_devices_dir(fs_devices, device);
> +
>   	mutex_unlock(&fs_devices->device_list_mutex);
>   
>   	if (seeding_dev) {
> 

Strange we should get this splat when btrfs_sysfs_add_devices_dir()
already has implicit GFP_NOFS allocation scope right? What did I
miss?

Thanks, Anand






