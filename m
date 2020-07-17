Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EE52238EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jul 2020 12:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgGQKFi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 06:05:38 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51792 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQKFi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 06:05:38 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06H9w27e182895
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 10:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=xH7W9KXWdHWENQCFtAFdkVWuNUnMTvFD8ar4D7s8Szs=;
 b=ErERZVGGzRsVEE8HjNSH8YyxiP2C2gN+CvdiYU+WCcq1iwOYZBt9Jwjh7ZKy+wBxE+Qk
 wd+HFnmQK2Rj/y8KreOb27VROkD75SPIXqRpmyAwjlXZrX0r5+4AO0rVoHVA8LoM3zq/
 Ucgm4QjBVUfyD0O0Y13ZzC9af47AAPn7tU8geTDuC8AAygw6SmvTB/pXCHANI7FEyKZO
 RL5HnBebMfG0CsKtpVYARVSPMYW7I0tjna7vjIMHUl7EcVyp4yNWV0BiNqXbKV5FJgKa
 CkqWjTutNDV0wGSJcRth/NNbqSG1w+ZEA9O7FEqL5Ipd9bUgWESUvu3Puw8IFXwmfHUZ 9g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 327s65vq5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 10:05:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06H9vin4147359
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 10:05:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 32b9hfgyq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 10:05:36 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06HA5ZrL028437
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 10:05:35 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jul 2020 03:05:34 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     martin.petersen@oracle.com
Subject: [PATCH] btrfs: fix lockdep warning while mounting sprout fs
Date:   Fri, 17 Jul 2020 18:05:25 +0800
Message-Id: <20200717100525.320697-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=3 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 impostorscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007170074
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Martin reported the following test case which reproduces lockdep
warning on his machine.

  modprobe scsi_debug dev_size_mb=1024 num_parts=2
  sleep 3
  mkfs.btrfs /dev/sda1
  mount /dev/sda1 /mnt
  cp -v /bin/ls /mnt
  umount /mnt
  btrfstune -S 1 /dev/sda1
  mount /dev/sda1 /mnt
  btrfs dev add /dev/sda2 /mnt
  umount /mnt
  mount /dev/sda2 /mnt
  <splat>

kernel: ======================================================
kernel: WARNING: possible circular locking dependency detected
kernel: 5.8.0-rc1+ #575 Not tainted
kernel: ------------------------------------------------------
kernel: mount/1024 is trying to acquire lock:
kernel: ffff888065e0a4e0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: clone_fs_devices+0x46/0x1f0 [btrfs]
kernel: #012but task is already holding lock:
kernel: ffff8880610508d0 (&fs_info->chunk_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0xd1/0x390 [btrfs]
kernel: #012which lock already depends on the new lock.
kernel: #012the existing dependency chain (in reverse order) is:
kernel: #012-> #1 (&fs_info->chunk_mutex){+.+.}-{3:3}:
kernel:       __lock_acquire+0x798/0xe50
kernel:       lock_acquire+0x15a/0x4d0
kernel:       __mutex_lock+0x116/0xbd0
kernel:       btrfs_remove_chunk+0x769/0xaa0 [btrfs]
kernel:       btrfs_delete_unused_bgs+0xa2c/0xfe0 [btrfs]
kernel:       cleaner_kthread+0x27c/0x2a0 [btrfs]
kernel:       kthread+0x1d6/0x200
kernel:       ret_from_fork+0x22/0x30
kernel: #012-> #0 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
kernel:       check_prev_add+0xf5/0xf50
kernel:       validate_chain+0xca7/0x1920
kernel:       __lock_acquire+0x798/0xe50
kernel:       lock_acquire+0x15a/0x4d0
kernel:       __mutex_lock+0x116/0xbd0
kernel:       clone_fs_devices+0x46/0x1f0 [btrfs]
kernel:       read_one_dev+0x15f/0x930 [btrfs]
kernel:       btrfs_read_chunk_tree+0x333/0x390 [btrfs]
kernel:       open_ctree+0xa72/0x15a6 [btrfs]
kernel:       btrfs_mount_root.cold+0xe/0xf1 [btrfs]
kernel:       legacy_get_tree+0x82/0xd0
kernel:       vfs_get_tree+0x4c/0x140
kernel:       fc_mount+0xf/0x60
kernel:       vfs_kern_mount.part.0+0x71/0x90
kernel:       btrfs_mount+0x1d7/0x610 [btrfs]
kernel:       legacy_get_tree+0x82/0xd0
kernel:       vfs_get_tree+0x4c/0x140
kernel:       do_mount+0xad1/0xe70
kernel:       __x64_sys_mount+0xbe/0x100
kernel:       do_syscall_64+0x56/0xa0
kernel:       entry_SYSCALL_64_after_hwframe+0x44/0xa9
kernel: #012other info that might help us debug this:
kernel: Possible unsafe locking scenario:
kernel:       CPU0                    CPU1
kernel:       ----                    ----
kernel:  lock(&fs_info->chunk_mutex);
kernel:                               lock(&fs_devs->device_list_mutex);
kernel:                               lock(&fs_info->chunk_mutex);
kernel:  lock(&fs_devs->device_list_mutex);
kernel: #012 *** DEADLOCK ***
================================================

Lockdep warning is complaining about the violation of the lock order of
device_list_mutex and chunk_mutex[1]. And, lockdep warning isn't entirely
correct, as it appears that it can't understand the different filesystem
instances.  Here, chunk_mutex was held by the mounting sprout filesystem,
and device_list_mutex was held belongs to the seed filesystem as the sprout
does not want the seed device to be freed.

[1]
open_ctree <== mount sprout
 btrfs_read_chunk_tree()
  mutex_lock(&uuid_mutex) <== global fsid lock
  mutex_lock(&fs_info->chunk_mutex) <== sprout fs
   read_one_dev()
    open_seed_devices()
     clone_fs_devices()
       mutex_lock(&orig->device_list_mutex) <== seed fs_devices

There are two function stacks [1] and [2] leading to clone_fs_devices().

[2]
btrfs_init_new_device()
 mutex_lock(&uuid_mutex);
 btrfs_prepare_sprout()
  lockdep_assert_held(&uuid_mutex);
   clone_fs_devices()

They both hold the uuid_mutex which is sufficient to protect from
freeing the seed device. That's because a seed device can not be
freed while it is mounted because it is read-only and an unmounted
seed device (but registered) can be freed only by the command forget
or making it stale. Which is handled by the function
btrfs_free_stale_devices() which also needs uuid_mutex.

So remove the unnecessary seed->device_list_mutex in clone_fs_devices.

Reported-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Tested-by: Martin K. Petersen <martin.petersen@oracle.com>
---
The above test case is similar to fstests btrfs/161 so no new
test case will be required.

 fs/btrfs/volumes.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c35603b5595a..9dc3b826be0d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -561,6 +561,8 @@ static int btrfs_free_stale_devices(const char *path,
 	struct btrfs_device *device, *tmp_device;
 	int ret = 0;
 
+	lockdep_assert_held(&uuid_mutex);
+
 	if (path)
 		ret = -ENOENT;
 
@@ -985,7 +987,6 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 	if (IS_ERR(fs_devices))
 		return fs_devices;
 
-	mutex_lock(&orig->device_list_mutex);
 	fs_devices->total_devices = orig->total_devices;
 
 	list_for_each_entry(orig_dev, &orig->devices, dev_list) {
@@ -1017,10 +1018,8 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
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
-- 
2.25.1

