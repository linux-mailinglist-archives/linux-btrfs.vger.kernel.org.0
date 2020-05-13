Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4971D1F98
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 21:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390607AbgEMTr1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 15:47:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52454 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732218AbgEMTr0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 15:47:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DJlLh6134246;
        Wed, 13 May 2020 19:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=SvNqzq82qPSpZDr8/PAyQJT/eEWN9W/rwAVmus7dv0U=;
 b=gPqgqUF0BGZ2gRQzNZiOeahjim70z3FcsDiqrDzyWMQHaGZB7nsxpwRK/vJ+j7DWt1fS
 P9oMZtN959rWLK9UP9qlLEeqoDNYOT+8k1YyEwE6tz/iyPUbmMVU9jg8bCwajHFR0sS8
 o5WVJjj6xgO4zwmazvfOxOMuhUW3CiFdO22JCzD+/H8fyNrhn1Lsn9tXL85gWlJOcpHr
 QEdIiTCpMQNOZFQTP8dFja+sqjD8lhMWpGI7Wfu6DUMU6T95EgUzsrrFJvhjllGOX7qn
 Gu7Y1P791qtKu38i4j8AlNJx3BGxvSNR2qXkdhQWfqcOQBrSnbr2xfjVnq69C5qFWkXw og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3100xwecge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 19:47:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DJgcnS190220;
        Wed, 13 May 2020 19:47:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3100ysjtm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 19:47:20 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04DJlJP6022195;
        Wed, 13 May 2020 19:47:19 GMT
Received: from ltp.sg.oracle.com (/10.191.32.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 May 2020 12:47:18 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH] btrfs: fix lockdep warning chunk_mutex vs device_list_mutex
Date:   Thu, 14 May 2020 03:46:59 +0800
Message-Id: <20200513194659.34493-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <52b6ff4c2da5838393f5bd754310cfa6abcfcc7b3efb3c63c8d95824cb163d6d.dsterba@suse.com>
References: <52b6ff4c2da5838393f5bd754310cfa6abcfcc7b3efb3c63c8d95824cb163d6d.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=3
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 lowpriorityscore=0
 suspectscore=3 mlxlogscore=999 clxscore=1015 cotscore=-2147483648
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130169
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

ABBA locking order lockdep warning reported during fstests btrfs/161 as
below.

[ 5174.262652] WARNING: possible circular locking dependency detected
[ 5174.264662] 5.7.0-rc3-default+ #1094 Not tainted
[ 5174.266245] ------------------------------------------------------
[ 5174.268215] mount/30761 is trying to acquire lock:
[ 5174.269838] ffff8d950e4164e8 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: clone_fs_devices+0x3f/0x170 [btrfs]
[ 5174.272880]
[ 5174.272880] but task is already holding lock:
[ 5174.275081] ffff8d952ae80980 (&fs_info->chunk_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0x5a/0x2a0 [btrfs]
[ 5174.278232]
[ 5174.278232] which lock already depends on the new lock.
[ 5174.278232]
[ 5174.281372]
[ 5174.281372] the existing dependency chain (in reverse order) is:
[ 5174.283784]
[ 5174.283784] -> #1 (&fs_info->chunk_mutex){+.+.}-{3:3}:
[ 5174.286134]        __lock_acquire+0x581/0xae0
[ 5174.287563]        lock_acquire+0xa3/0x400
[ 5174.289033]        __mutex_lock+0xa0/0xaf0
[ 5174.290488]        btrfs_init_new_device+0x316/0x12f0 [btrfs]
[ 5174.292209]        btrfs_ioctl+0xc3c/0x2590 [btrfs]
[ 5174.293673]        ksys_ioctl+0x68/0xa0
[ 5174.294883]        __x64_sys_ioctl+0x16/0x20
[ 5174.296231]        do_syscall_64+0x50/0x210
[ 5174.297548]        entry_SYSCALL_64_after_hwframe+0x49/0xb3
[ 5174.299278]
[ 5174.299278] -> #0 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
[ 5174.301760]        check_prev_add+0x98/0xa20
[ 5174.303219]        validate_chain+0xa6c/0x29e0
[ 5174.304770]        __lock_acquire+0x581/0xae0
[ 5174.306274]        lock_acquire+0xa3/0x400
[ 5174.307716]        __mutex_lock+0xa0/0xaf0
[ 5174.309145]        clone_fs_devices+0x3f/0x170 [btrfs]
[ 5174.310757]        read_one_dev+0xc4/0x500 [btrfs]
[ 5174.312293]        btrfs_read_chunk_tree+0x202/0x2a0 [btrfs]
[ 5174.313946]        open_ctree+0x7a3/0x10db [btrfs]
[ 5174.315411]        btrfs_mount_root.cold+0xe/0xcc [btrfs]
[ 5174.317122]        legacy_get_tree+0x2d/0x60
[ 5174.318543]        vfs_get_tree+0x1d/0xb0
[ 5174.319844]        fc_mount+0xe/0x40
[ 5174.321122]        vfs_kern_mount.part.0+0x71/0x90
[ 5174.322688]        btrfs_mount+0x147/0x3e0 [btrfs]
[ 5174.324250]        legacy_get_tree+0x2d/0x60
[ 5174.325644]        vfs_get_tree+0x1d/0xb0
[ 5174.326978]        do_mount+0x7d5/0xa40
[ 5174.328294]        __x64_sys_mount+0x8e/0xd0
[ 5174.329829]        do_syscall_64+0x50/0x210
[ 5174.331260]        entry_SYSCALL_64_after_hwframe+0x49/0xb3
[ 5174.333102]
[ 5174.333102] other info that might help us debug this:
[ 5174.333102]
[ 5174.335988]  Possible unsafe locking scenario:
[ 5174.335988]
[ 5174.338051]        CPU0                    CPU1
[ 5174.339490]        ----                    ----
[ 5174.340810]   lock(&fs_info->chunk_mutex);
[ 5174.342203]                                lock(&fs_devs->device_list_mutex);
[ 5174.344228]                                lock(&fs_info->chunk_mutex);
[ 5174.346161]   lock(&fs_devs->device_list_mutex);
[ 5174.347666]
[ 5174.347666]  *** DEADLOCK ***

The test case btrfs/161 creates seed device and adds sprout device to
it using ioctl.

The ioctl thread which adds the sprout device to the mounted seed device
calls btrfs_prepare_sprout() and holds the lock in the following order.

 mutex_lock(&fs_devices->device_list_mutex);
 mutex_lock(&fs_info->chunk_mutex);

The add thread still in the CPU#1 however as the test case would the mount
the sprout device this time is on CPU#0. As it is mounting the sprout
device btrfs_read_chunk_tree() it calls clone_fs_devices() establishing
the lock order.

 mutex_lock(&fs_info->chunk_mutex);
 mutex_lock(&fs_devices->device_list_mutex);

But the address of these two fs_devices and fs_info are different
so this ABBA warning won't be true in real.

However as per our design the chunk_mutex and device_list_mutex must
follow the locking order of the former thread so there is something
to fix.

volume.c:
 279  * Lock nesting
 280  * ============
 281  *
 282  * uuid_mutex
 283  *     device_list_mutex
 284  *       chunk_mutex

To fix the idea is to move out the lock from clone_fs_devices() to
its call chain up at btrfs_read_chunk_tree().

btrfs_read_chunk_tree()
+  mutex_lock(&orig->device_list_mutex);
   mutex_lock(&fs_info->chunk_mutex);
   read_one_dev(leaf, dev_item); (single parent fn)
     open_seed_devices(fs_info, fs_uuid); (single parent fn)
       clone_fs_devices(fs_devices);  (also called by btrfs_prepare_sprout only)
-        mutex_lock(&orig->device_list_mutex);

As clone_fs_devices() is also called by btrfs_prepare_sprout() add the
required device_list_mutex there.

btrfs_prepare_sprout()
+  mutex_lock(&fs_devices->device_list_mutex);
   clone_fs_devices()
+  mutex_unlock(&fs_devices->device_list_mutex);

Next, in btrfs_read_chunk_tree() there are several helper functions
which are now under device_list_mutex which are fine to be unless
there is already device_list_mutex lock some other incompatible lock.
So each of those helper functions were checked as below, and they
don't hold any locks.

open_seed_devices() ok
find_fsid() ok
clone_fs_devices() ok with fix
open_fs_devices() ok
free_fs_devices() ok
btrfs_find_device() ok
add_missing_dev() ok

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---

Testing:
fstests groups volume and seed ran fine.
A full list of tests just started.

 fs/btrfs/volumes.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 60ab41c12e50..ebc8565d0f73 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -984,7 +984,6 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 	if (IS_ERR(fs_devices))
 		return fs_devices;
 
-	mutex_lock(&orig->device_list_mutex);
 	fs_devices->total_devices = orig->total_devices;
 
 	list_for_each_entry(orig_dev, &orig->devices, dev_list) {
@@ -1016,10 +1015,8 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 		device->fs_devices = fs_devices;
 		fs_devices->num_devices++;
 	}
-	mutex_unlock(&orig->device_list_mutex);
 	return fs_devices;
 error:
-	mutex_unlock(&orig->device_list_mutex);
 	free_fs_devices(fs_devices);
 	return ERR_PTR(ret);
 }
@@ -2363,11 +2360,14 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	if (IS_ERR(seed_devices))
 		return PTR_ERR(seed_devices);
 
+	mutex_lock(&fs_devices->device_list_mutex);
 	old_devices = clone_fs_devices(fs_devices);
 	if (IS_ERR(old_devices)) {
+		mutex_unlock(&fs_devices->device_list_mutex);
 		kfree(seed_devices);
 		return PTR_ERR(old_devices);
 	}
+	mutex_unlock(&fs_devices->device_list_mutex);
 
 	list_add(&old_devices->fs_list, &fs_uuids);
 
@@ -7049,6 +7049,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	 * otherwise we don't need it.
 	 */
 	mutex_lock(&uuid_mutex);
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	mutex_lock(&fs_info->chunk_mutex);
 
 	/*
@@ -7117,6 +7118,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	ret = 0;
 error:
 	mutex_unlock(&fs_info->chunk_mutex);
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 	mutex_unlock(&uuid_mutex);
 
 	btrfs_free_path(path);
-- 
2.25.1

