Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1095225867
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 09:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgGTHZi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jul 2020 03:25:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56192 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTHZi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jul 2020 03:25:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06K7O9c1004976;
        Mon, 20 Jul 2020 07:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nUcqrYGXVwNWo4dWSVkG82q9wxpCu/ZxMjvrE51aUYM=;
 b=ow3V+OQKB5UR08lKWWw7cTEF0eGMR1nViWFbsm2wzuAAXQjXiKEyWKXXuAYkobZgLKVI
 W5JrnX+lAOJKDM5sj7AAFIx6j7GN+DO8aZ6E5AZld/JvyXbSdalqsFiSyJ+kd0o8XUfq
 vHtQWm55ypA3qy3dD5U3EORQKgWvsQeW2dTUJSJPK/AMs6v3F651PH3syKzQneuhRG5C
 JGajmHui5NdloSqU1IpN2qsS0WAKpapwBWobueH58flxmyTtzUOvEgqfNG4IoT354s1Y
 YJJvHgB3ixh29UY94HPp+39P+z+vMT8Ai5er5uIl2C7FGJPLt3lUldUFmECI2vID61Bj Ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32bs1m552f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 07:25:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06K7MuY2128906;
        Mon, 20 Jul 2020 07:23:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32d68g2hmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 07:23:34 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06K7NXH2009692;
        Mon, 20 Jul 2020 07:23:33 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jul 2020 00:23:33 -0700
Subject: Re: [PATCH 2/3] btrfs: move the chunk_mutex in btrfs_read_chunk_tree
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200717191229.2283043-1-josef@toxicpanda.com>
 <20200717191229.2283043-3-josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6b2ef710-7f53-cc94-a858-73fb649f44c0@oracle.com>
Date:   Mon, 20 Jul 2020 15:23:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200717191229.2283043-3-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200054
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/7/20 3:12 am, Josef Bacik wrote:
> We are currently getting this lockdep splat
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.8.0-rc5+ #20 Tainted: G            E
> ------------------------------------------------------
> mount/678048 is trying to acquire lock:
> ffff9b769f15b6e0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: clone_fs_devices+0x4d/0x170 [btrfs]
> 
> but task is already holding lock:
> ffff9b76abdb08d0 (&fs_info->chunk_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0x6a/0x800 [btrfs]
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&fs_info->chunk_mutex){+.+.}-{3:3}:
>         __mutex_lock+0x8b/0x8f0
>         btrfs_init_new_device+0x2d2/0x1240 [btrfs]
>         btrfs_ioctl+0x1de/0x2d20 [btrfs]
>         ksys_ioctl+0x87/0xc0
>         __x64_sys_ioctl+0x16/0x20
>         do_syscall_64+0x52/0xb0
>         entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> -> #0 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
>         __lock_acquire+0x1240/0x2460
>         lock_acquire+0xab/0x360
>         __mutex_lock+0x8b/0x8f0
>         clone_fs_devices+0x4d/0x170 [btrfs]
>         btrfs_read_chunk_tree+0x330/0x800 [btrfs]
>         open_ctree+0xb7c/0x18ce [btrfs]
>         btrfs_mount_root.cold+0x13/0xfa [btrfs]
>         legacy_get_tree+0x30/0x50
>         vfs_get_tree+0x28/0xc0
>         fc_mount+0xe/0x40
>         vfs_kern_mount.part.0+0x71/0x90
>         btrfs_mount+0x13b/0x3e0 [btrfs]
>         legacy_get_tree+0x30/0x50
>         vfs_get_tree+0x28/0xc0
>         do_mount+0x7de/0xb30
>         __x64_sys_mount+0x8e/0xd0
>         do_syscall_64+0x52/0xb0
>         entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> other info that might help us debug this:
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&fs_info->chunk_mutex);
>                                 lock(&fs_devs->device_list_mutex);
>                                 lock(&fs_info->chunk_mutex);
>    lock(&fs_devs->device_list_mutex);
> 
>   *** DEADLOCK ***
> 
> 3 locks held by mount/678048:
>   #0: ffff9b75ff5fb0e0 (&type->s_umount_key#63/1){+.+.}-{3:3}, at: alloc_super+0xb5/0x380
>   #1: ffffffffc0c2fbc8 (uuid_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0x54/0x800 [btrfs]
>   #2: ffff9b76abdb08d0 (&fs_info->chunk_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0x6a/0x800 [btrfs]
> 
> stack backtrace:
> CPU: 2 PID: 678048 Comm: mount Tainted: G            E     5.8.0-rc5+ #20
> Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./890FX Deluxe5, BIOS P1.40 05/03/2011
> Call Trace:
>   dump_stack+0x96/0xd0
>   check_noncircular+0x162/0x180
>   __lock_acquire+0x1240/0x2460
>   ? asm_sysvec_apic_timer_interrupt+0x12/0x20
>   lock_acquire+0xab/0x360
>   ? clone_fs_devices+0x4d/0x170 [btrfs]
>   __mutex_lock+0x8b/0x8f0
>   ? clone_fs_devices+0x4d/0x170 [btrfs]
>   ? rcu_read_lock_sched_held+0x52/0x60
>   ? cpumask_next+0x16/0x20
>   ? module_assert_mutex_or_preempt+0x14/0x40
>   ? __module_address+0x28/0xf0
>   ? clone_fs_devices+0x4d/0x170 [btrfs]
>   ? static_obj+0x4f/0x60
>   ? lockdep_init_map_waits+0x43/0x200
>   ? clone_fs_devices+0x4d/0x170 [btrfs]
>   clone_fs_devices+0x4d/0x170 [btrfs]
>   btrfs_read_chunk_tree+0x330/0x800 [btrfs]
>   open_ctree+0xb7c/0x18ce [btrfs]
>   ? super_setup_bdi_name+0x79/0xd0
>   btrfs_mount_root.cold+0x13/0xfa [btrfs]
>   ? vfs_parse_fs_string+0x84/0xb0
>   ? rcu_read_lock_sched_held+0x52/0x60
>   ? kfree+0x2b5/0x310
>   legacy_get_tree+0x30/0x50
>   vfs_get_tree+0x28/0xc0
>   fc_mount+0xe/0x40
>   vfs_kern_mount.part.0+0x71/0x90
>   btrfs_mount+0x13b/0x3e0 [btrfs]
>   ? cred_has_capability+0x7c/0x120
>   ? rcu_read_lock_sched_held+0x52/0x60
>   ? legacy_get_tree+0x30/0x50
>   legacy_get_tree+0x30/0x50
>   vfs_get_tree+0x28/0xc0
>   do_mount+0x7de/0xb30
>   ? memdup_user+0x4e/0x90
>   __x64_sys_mount+0x8e/0xd0
>   do_syscall_64+0x52/0xb0
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> This is because btrfs_read_chunk_tree() can come upon DEV_EXTENT's and
> then read the device, which takes the device_list_mutex.  The
> device_list_mutex needs to be taken before the chunk_mutex, so this is a
> problem.  We only really need the chunk mutex around adding the chunk,
> so move the mutex around read_one_chunk.
> 
> An argument could be made that we don't even need the chunk_mutex here
> as it's during mount, and we are protected by various other locks.
> However we already have special rules for ->device_list_mutex, and I'd
> rather not have another special case for ->chunk_mutex.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand
