Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C62A28EEB3
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Oct 2020 10:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbgJOIpM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Oct 2020 04:45:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57878 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387422AbgJOIpM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Oct 2020 04:45:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09F8e01R119245;
        Thu, 15 Oct 2020 08:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wnflbAqfg+UswGKKQ5Wqopn4+MFO2Zb2Ba1imLASra4=;
 b=Jf0RcmUYtqo1acIC+5ck4nf9OryROB+Mc3nIziJDITNoi/EzcPjefZbbdHTJ/s4/F6pD
 k5ijvVDZiqeYVO65RFcuvmE14btCMvpqsWr19gCoe5oQ5wRl+pZZm1/0xlsfdLI7X4EC
 8P6lox8IbpseRhclPrBWXd/83CbHVsndp/usCz+FtBlw3S+7Hu4dnaW6sV1WeAI258iR
 o1nbcc18Wf9c++g0xDlr4arK14V9Ehr4wzoMTghkgV6gMpl0YSyGpr+JuxO8mYBX8+bF
 zaY2PA1WliEopwk7VX9qZ0UhAQjqJAeClsQqL+6vzLJklsLMpSbbwjUZnUbSe10ewZ5V wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 343vaehvy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Oct 2020 08:45:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09F8fJcZ165532;
        Thu, 15 Oct 2020 08:45:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 343pv1heth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Oct 2020 08:45:06 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09F8j4lD024355;
        Thu, 15 Oct 2020 08:45:04 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Oct 2020 01:45:04 -0700
Subject: Re: [PATCH] btrfs: drop the path before adding blockgroup sysfs files
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <03a94ec83095d00b19dcb65fda1b58f1b41f1297.1602709223.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <db8d6f3a-38f0-34e6-e118-47e14b301fe4@oracle.com>
Date:   Thu, 15 Oct 2020 16:44:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <03a94ec83095d00b19dcb65fda1b58f1b41f1297.1602709223.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150062
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/10/20 5:00 am, Josef Bacik wrote:
> Dave reported a problem with my rwsem conversion patch where we got the
> following lockdep splat
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.9.0-default+ #1297 Not tainted
> ------------------------------------------------------
> kswapd0/76 is trying to acquire lock:
> ffff9d5d25df2530 (&delayed_node->mutex){+.+.}-{3:3}, at: __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
> 
> but task is already holding lock:
> ffffffffa40cbba0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x5/0x30
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #4 (fs_reclaim){+.+.}-{0:0}:
>         __lock_acquire+0x582/0xac0
>         lock_acquire+0xca/0x430
>         fs_reclaim_acquire.part.0+0x25/0x30
>         kmem_cache_alloc+0x30/0x9c0
>         alloc_inode+0x81/0x90
>         iget_locked+0xcd/0x1a0
>         kernfs_get_inode+0x1b/0x130
>         kernfs_get_tree+0x136/0x210
>         sysfs_get_tree+0x1a/0x50
>         vfs_get_tree+0x1d/0xb0
>         path_mount+0x70f/0xa80
>         do_mount+0x75/0x90
>         __x64_sys_mount+0x8e/0xd0
>         do_syscall_64+0x2d/0x70
>         entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> -> #3 (kernfs_mutex){+.+.}-{3:3}:
>         __lock_acquire+0x582/0xac0
>         lock_acquire+0xca/0x430
>         __mutex_lock+0xa0/0xaf0
>         kernfs_add_one+0x23/0x150
>         kernfs_create_dir_ns+0x58/0x80
>         sysfs_create_dir_ns+0x70/0xd0
>         kobject_add_internal+0xbb/0x2d0
>         kobject_add+0x7a/0xd0
>         btrfs_sysfs_add_block_group_type+0x141/0x1d0 [btrfs]
>         btrfs_read_block_groups+0x1f1/0x8c0 [btrfs]
>         open_ctree+0x981/0x1108 [btrfs]
>         btrfs_mount_root.cold+0xe/0xb0 [btrfs]
>         legacy_get_tree+0x2d/0x60
>         vfs_get_tree+0x1d/0xb0
>         fc_mount+0xe/0x40
>         vfs_kern_mount.part.0+0x71/0x90
>         btrfs_mount+0x13b/0x3e0 [btrfs]
>         legacy_get_tree+0x2d/0x60
>         vfs_get_tree+0x1d/0xb0
>         path_mount+0x70f/0xa80
>         do_mount+0x75/0x90
>         __x64_sys_mount+0x8e/0xd0
>         do_syscall_64+0x2d/0x70
>         entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> -> #2 (btrfs-extent-00){++++}-{3:3}:
>         __lock_acquire+0x582/0xac0
>         lock_acquire+0xca/0x430
>         down_read_nested+0x45/0x220
>         __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]
>         __btrfs_read_lock_root_node+0x3a/0x50 [btrfs]
>         btrfs_search_slot+0x6d4/0xfd0 [btrfs]
>         check_committed_ref+0x69/0x200 [btrfs]
>         btrfs_cross_ref_exist+0x65/0xb0 [btrfs]
>         run_delalloc_nocow+0x446/0x9b0 [btrfs]
>         btrfs_run_delalloc_range+0x61/0x6a0 [btrfs]
>         writepage_delalloc+0xae/0x160 [btrfs]
>         __extent_writepage+0x262/0x420 [btrfs]
>         extent_write_cache_pages+0x2b6/0x510 [btrfs]
>         extent_writepages+0x43/0x90 [btrfs]
>         do_writepages+0x40/0xe0
>         __writeback_single_inode+0x62/0x610
>         writeback_sb_inodes+0x20f/0x500
>         wb_writeback+0xef/0x4a0
>         wb_do_writeback+0x49/0x2e0
>         wb_workfn+0x81/0x340
>         process_one_work+0x233/0x5d0
>         worker_thread+0x50/0x3b0
>         kthread+0x137/0x150
>         ret_from_fork+0x1f/0x30
> 
> -> #1 (btrfs-fs-00){++++}-{3:3}:
>         __lock_acquire+0x582/0xac0
>         lock_acquire+0xca/0x430
>         down_read_nested+0x45/0x220
>         __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]
>         __btrfs_read_lock_root_node+0x3a/0x50 [btrfs]
>         btrfs_search_slot+0x6d4/0xfd0 [btrfs]
>         btrfs_lookup_inode+0x3a/0xc0 [btrfs]
>         __btrfs_update_delayed_inode+0x93/0x2c0 [btrfs]
>         __btrfs_commit_inode_delayed_items+0x7de/0x850 [btrfs]
>         __btrfs_run_delayed_items+0x8e/0x140 [btrfs]
>         btrfs_commit_transaction+0x367/0xbc0 [btrfs]
>         btrfs_mksubvol+0x2db/0x470 [btrfs]
>         btrfs_mksnapshot+0x7b/0xb0 [btrfs]
>         __btrfs_ioctl_snap_create+0x16f/0x1a0 [btrfs]
>         btrfs_ioctl_snap_create_v2+0xb0/0xf0 [btrfs]
>         btrfs_ioctl+0xd0b/0x2690 [btrfs]
>         __x64_sys_ioctl+0x6f/0xa0
>         do_syscall_64+0x2d/0x70
>         entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> -> #0 (&delayed_node->mutex){+.+.}-{3:3}:
>         check_prev_add+0x91/0xc60
>         validate_chain+0xa6e/0x2a20
>         __lock_acquire+0x582/0xac0
>         lock_acquire+0xca/0x430
>         __mutex_lock+0xa0/0xaf0
>         __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
>         btrfs_evict_inode+0x3cc/0x560 [btrfs]
>         evict+0xd6/0x1c0
>         dispose_list+0x48/0x70
>         prune_icache_sb+0x54/0x80
>         super_cache_scan+0x121/0x1a0
>         do_shrink_slab+0x16d/0x3b0
>         shrink_slab+0xb1/0x2e0
>         shrink_node+0x230/0x6a0
>         balance_pgdat+0x325/0x750
>         kswapd+0x206/0x4d0
>         kthread+0x137/0x150
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
> 3 locks held by kswapd0/76:
>   #0: ffffffffa40cbba0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x5/0x30
>   #1: ffffffffa40b8b58 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x54/0x2e0
>   #2: ffff9d5d322390e8 (&type->s_umount_key#26){++++}-{3:3}, at: trylock_super+0x16/0x50
> 
> stack backtrace:
> CPU: 2 PID: 76 Comm: kswapd0 Not tainted 5.9.0-default+ #1297
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> Call Trace:
>   dump_stack+0x77/0x97
>   check_noncircular+0xff/0x110
>   ? save_trace+0x50/0x470
>   check_prev_add+0x91/0xc60
>   validate_chain+0xa6e/0x2a20
>   ? save_trace+0x50/0x470
>   __lock_acquire+0x582/0xac0
>   lock_acquire+0xca/0x430
>   ? __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
>   __mutex_lock+0xa0/0xaf0
>   ? __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
>   ? __lock_acquire+0x582/0xac0
>   ? __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
>   ? btrfs_evict_inode+0x30b/0x560 [btrfs]
>   ? __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
>   __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
>   btrfs_evict_inode+0x3cc/0x560 [btrfs]
>   evict+0xd6/0x1c0
>   dispose_list+0x48/0x70
>   prune_icache_sb+0x54/0x80
>   super_cache_scan+0x121/0x1a0
>   do_shrink_slab+0x16d/0x3b0
>   shrink_slab+0xb1/0x2e0
>   shrink_node+0x230/0x6a0
>   balance_pgdat+0x325/0x750
>   kswapd+0x206/0x4d0
>   ? finish_wait+0x90/0x90
>   ? balance_pgdat+0x750/0x750
>   kthread+0x137/0x150
>   ? kthread_mod_delayed_work+0xc0/0xc0
>   ret_from_fork+0x1f/0x30
> 
> This happens because we are still holding the path open when we start
> adding the sysfs files for the block groups, which creates a dependency
> on fs_reclaim via the tree lock.  Fix this by dropping the path before
> we start doing anything with sysfs.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/block-group.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c0f1d6818df7..3ba6f3839d39 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2024,6 +2024,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>   		key.offset = 0;
>   		btrfs_release_path(path);
>   	}
> +	btrfs_release_path(path);
>   
>   	list_for_each_entry(space_info, &info->space_info, list) {
>   		int i;
> 

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

