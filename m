Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EF4259CA1
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 19:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbgIARRr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 13:17:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38114 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbgIARRn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 13:17:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081HDZTq178943;
        Tue, 1 Sep 2020 17:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=g/JxFBTzsAGgM5odDpIp57XeeVAMWJBUMLVCxbDvr3Q=;
 b=E4mzurmv88w9aV7jJodB0T4wsOXuU4dr7SnMMh9izyPXKr2ME+z+UuTU2pJoke8oYScF
 F2imxzWhgagq00Z/4tzRlxDomlPvtXs68LY0CLTcmDATvqzCJ/kQvH5OPnZn+Hd0WOHy
 r2zb6SGqTZhqZHZ2dFnPv1i80PVHtLi3eDx0FE9etIP9zDPTF4b+PzwQAy+L2bzlldpX
 G1iKBdJlSpqIKx/G1SLcwyN5a7ToOKVUVQL0TnSsJeHXizrSbgWer5TFrt5B/dTVt0WF
 Qiv0mrRa2ducqdvYr6qtQKjEOXzUqj1hDH1UU9utRwjn7NEhKZJkU1p6MvkVM4P3mB4J RA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 339dmmv8y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Sep 2020 17:17:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081HEatC110020;
        Tue, 1 Sep 2020 17:15:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3380x3xmnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Sep 2020 17:15:38 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 081HFbmO005674;
        Tue, 1 Sep 2020 17:15:37 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Sep 2020 10:15:37 -0700
Subject: Re: [PATCH] btrfs: fix lockdep splat in add_missing_dev
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <8cad21a9f0bcc2bd29a2b0e89e475687c44b3a59.1598885260.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8d906780-1507-795c-99cb-39bc11024229@oracle.com>
Date:   Wed, 2 Sep 2020 01:15:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <8cad21a9f0bcc2bd29a2b0e89e475687c44b3a59.1598885260.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010144
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31/8/20 10:52 pm, Josef Bacik wrote:
> Nikolay reported a lockdep splat that I could reproduce with btrfs/187.
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.9.0-rc2+ #1 Tainted: G        W
> ------------------------------------------------------
> kswapd0/100 is trying to acquire lock:
> ffff9e8ef38b6268 (&delayed_node->mutex){+.+.}-{3:3}, at: __btrfs_release_delayed_node.part.0+0x3f/0x330
> 
> but task is already holding lock:
> ffffffffa9d74700 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x5/0x30
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (fs_reclaim){+.+.}-{0:0}:
>         fs_reclaim_acquire+0x65/0x80
>         slab_pre_alloc_hook.constprop.0+0x20/0x200
>         kmem_cache_alloc_trace+0x3a/0x1a0
>         btrfs_alloc_device+0x43/0x210
>         add_missing_dev+0x20/0x90
>         read_one_chunk+0x301/0x430
>         btrfs_read_sys_array+0x17b/0x1b0
>         open_ctree+0xa62/0x1896
>         btrfs_mount_root.cold+0x12/0xea
>         legacy_get_tree+0x30/0x50
>         vfs_get_tree+0x28/0xc0
>         vfs_kern_mount.part.0+0x71/0xb0
>         btrfs_mount+0x10d/0x379
>         legacy_get_tree+0x30/0x50
>         vfs_get_tree+0x28/0xc0
>         path_mount+0x434/0xc00
>         __x64_sys_mount+0xe3/0x120
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
>         btrfs_lookup_inode+0x2a/0x8f
>         __btrfs_update_delayed_inode+0x80/0x240
>         btrfs_commit_inode_delayed_inode+0x119/0x120
>         btrfs_evict_inode+0x357/0x500
>         evict+0xcf/0x1f0
>         vfs_rmdir.part.0+0x149/0x160
>         do_rmdir+0x136/0x1a0
>         do_syscall_64+0x33/0x40
>         entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> -> #0 (&delayed_node->mutex){+.+.}-{3:3}:
>         __lock_acquire+0x1184/0x1fa0
>         lock_acquire+0xa4/0x3d0
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
>    &delayed_node->mutex --> &fs_info->chunk_mutex --> fs_reclaim
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(fs_reclaim);
>                                 lock(&fs_info->chunk_mutex);
>                                 lock(fs_reclaim);
>    lock(&delayed_node->mutex);
> 
>   *** DEADLOCK ***
> 
> 3 locks held by kswapd0/100:
>   #0: ffffffffa9d74700 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x5/0x30
>   #1: ffffffffa9d65c50 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x115/0x290
>   #2: ffff9e8e9da260e0 (&type->s_umount_key#48){++++}-{3:3}, at: super_cache_scan+0x38/0x1e0
> 
> stack backtrace:
> CPU: 1 PID: 100 Comm: kswapd0 Tainted: G        W         5.9.0-rc2+ #1
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> Call Trace:
>   dump_stack+0x92/0xc8
>   check_noncircular+0x12d/0x150
>   __lock_acquire+0x1184/0x1fa0
>   lock_acquire+0xa4/0x3d0
>   ? __btrfs_release_delayed_node.part.0+0x3f/0x330
>   __mutex_lock+0x7e/0x7e0
>   ? __btrfs_release_delayed_node.part.0+0x3f/0x330
>   ? __btrfs_release_delayed_node.part.0+0x3f/0x330
>   ? lock_acquire+0xa4/0x3d0
>   ? btrfs_evict_inode+0x11e/0x500
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
>   ? _raw_spin_unlock_irqrestore+0x46/0x60
>   ? add_wait_queue_exclusive+0x70/0x70
>   ? balance_pgdat+0x670/0x670
>   kthread+0x138/0x160
>   ? kthread_create_worker_on_cpu+0x40/0x40
>   ret_from_fork+0x1f/0x30
> 
> This is because we are holding the chunk_mutex when we call
> btrfs_alloc_device, which does a GFP_KERNEL allocation.  We don't want
> to switch that to a GFP_NOFS lock because this is the only place where
> it matters.  So instead use memalloc_nofs_save() around the allocation
> in order to avoid the lockdep splat.
> 
> References: https://github.com/btrfs/fstests/issues/6
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>


Thanks. Anand

