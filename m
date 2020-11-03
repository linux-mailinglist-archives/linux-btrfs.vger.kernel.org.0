Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDCA2A3C33
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 06:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgKCFuJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 00:50:09 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50942 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgKCFuI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 00:50:08 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A35o2gZ084602;
        Tue, 3 Nov 2020 05:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=pxosbg96zRoCygEtRHKcq6y+W/o+wSl5jAml8tg7fLk=;
 b=vPA5D2hVfergnoVQ4ouFdzDinPTDCHmyQJmkqpyF6pifMEssTJbpZE5BJGQN3sUxwAMl
 Gdcn8dDm8VQpH2JeeNcecttKdDhhrcdx9oaYg5QxsxA5j17sP0SLGPGxCbaJNmxUyIdF
 +LaUegQiNyy8UE4LmdJiQYLkYE95Qox93wmIzASzcs3lF7aZSXrj2aaJ4ro2Vh0UfEih
 mnpEFccaB58yHQcwQCtfR59TzLuwsOqR6UKL0IA25eQifHfXITjfY+667trH5vy48HER
 yUOIpnXCKNAFfAtbz7gYslPQhtljcwxxHxmnQVUKXW4ZiFd7oWPIStv5KskwwG+cP1Jx fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34hhb1yd5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 03 Nov 2020 05:50:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A35ngEM080571;
        Tue, 3 Nov 2020 05:50:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34hvrv802s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Nov 2020 05:50:01 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A35o0Rg008603;
        Tue, 3 Nov 2020 05:50:00 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Nov 2020 21:49:59 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com,
        syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
Subject: [PATCH RESEND v2 3/3] btrfs: fix devid 0 without a replace item by failing the mount
Date:   Tue,  3 Nov 2020 13:49:44 +0800
Message-Id: <de3f3de9ecf6ebf7536e10619a32b9fb303d7644.1604372689.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1604372688.git.anand.jain@oracle.com>
References: <cover.1604372688.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=3 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030043
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=3
 clxscore=1015 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030043
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If there is a BTRFS_DEV_REPLACE_DEVID without a replace item, then
it means some device is trying to attack or may be corrupted. Fail the
mount so that the user can remove the attacking or fix the corrupted
device.

As of now if BTRFS_DEV_REPLACE_DEVID is present without the replace
item, in __btrfs_free_extra_devids() we determine that there is an
extra device, and free those extra devices but continue to mount the
device.
However, we were wrong in keeping tack of the rw_devices so the syzbot
testcase failed as below [1].

[1]
WARNING: CPU: 1 PID: 3612 at fs/btrfs/volumes.c:1166 close_fs_devices.part.0+0x607/0x800 fs/btrfs/volumes.c:1166
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 3612 Comm: syz-executor.2 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x347/0x7c0 kernel/panic.c:231
 __warn.cold+0x20/0x46 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:close_fs_devices.part.0+0x607/0x800 fs/btrfs/volumes.c:1166
Code: 0f b6 04 02 84 c0 74 02 7e 33 48 8b 44 24 18 c6 80 30 01 00 00 00 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 99 ce 6a fe <0f> 0b e9 71 ff ff ff e8 8d ce 6a fe 0f 0b e9 20 ff ff ff e8 d1 d5
RSP: 0018:ffffc900091777e0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffffffffffffffff RCX: ffffc9000c8b7000
RDX: 0000000000040000 RSI: ffffffff83097f47 RDI: 0000000000000007
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff8880988a187f
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88809593a130
R13: ffff88809593a1ec R14: ffff8880988a1908 R15: ffff88809593a050
 close_fs_devices fs/btrfs/volumes.c:1193 [inline]
 btrfs_close_devices+0x95/0x1f0 fs/btrfs/volumes.c:1179
 open_ctree+0x4984/0x4a2d fs/btrfs/disk-io.c:3434
 btrfs_fill_super fs/btrfs/super.c:1316 [inline]
 btrfs_mount_root.cold+0x14/0x165 fs/btrfs/super.c:1672

The fix here is, when we determine that there isn't a replace item
then fail the mount if there is a replace target device (devid 0).

The reproducer and the fix looks like this.

 mkfs.btrfs -fq /dev/sda
 dd if=/dev/sda of=/dev/sdb bs=1 seek=64K skip=64K count=4096
 btrfs-sb-mod /dev/sdb dev_item.devid =0
 mount -o device=/dev/sdb /dev/sda /btrfsS
mount: /btrfs: wrong fs type, bad option, bad superblock on /dev/sda, missing codepage or helper program, or other error.

[ 3526.708108] BTRFS error (device sdb): found replace target device without a replace item
[ 3526.709152] BTRFS error (device sdb): failed to init dev_replace: -5
[ 3526.715623] BTRFS error (device sdb): open_ctree failed

Cc: josef@toxicpanda.com
Reported-by: syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
(changle log reproducer updated).

Conflicts with the patches
 btrfs: drop never met condition of disk_total_bytes == 0
 btrfs: fix btrfs_find_device unused arg seed
If these patches aren't integrated yet, then please add the last arg in
the function btrfs_find_device(). Any value is fine as it doesn't care.

Dropped the idea of fstests for now as the test case requires btrfs-sb-mod.
And there aren't any fstests yet which shall carry 4k superblock in its script
not sure if it's a good idea.

Instead, we could rely on sysbot for now.

v2: changed title
    old: btrfs: fix rw_devices count in __btrfs_free_extra_devids

    In btrfs_init_dev_replace() try to match the presence of replace_item
    to the BTRFS_DEV_REPLACE_DEVID device. If fails then fail the
    mount. So drop the similar check in __btrfs_free_extra_devids().

 fs/btrfs/dev-replace.c | 26 ++++++++++++++++++++++++--
 fs/btrfs/volumes.c     | 26 +++++++-------------------
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index ffab2758f991..8b3935757dc1 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -91,6 +91,17 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 	ret = btrfs_search_slot(NULL, dev_root, &key, path, 0, 0);
 	if (ret) {
 no_valid_dev_replace_entry_found:
+		/*
+		 * We don't have a replace item or it's corrupted.
+		 * If there is a replace target, fail the mount.
+		 */
+		if (btrfs_find_device(fs_info->fs_devices,
+				      BTRFS_DEV_REPLACE_DEVID, NULL, NULL)) {
+			btrfs_err(fs_info,
+			"found replace target device without a replace item");
+			ret = -EIO;
+			goto out;
+		}
 		ret = 0;
 		dev_replace->replace_state =
 			BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED;
@@ -143,8 +154,19 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_CANCELED:
-		dev_replace->srcdev = NULL;
-		dev_replace->tgtdev = NULL;
+		/*
+		 * We don't have an active replace item but if there is a
+		 * replace target, fail the mount.
+		 */
+		if (btrfs_find_device(fs_info->fs_devices,
+				      BTRFS_DEV_REPLACE_DEVID, NULL, NULL)) {
+			btrfs_err(fs_info,
+			"replace devid present without an active replace item");
+			ret = -EIO;
+		} else {
+			dev_replace->srcdev = NULL;
+			dev_replace->tgtdev = NULL;
+		}
 		break;
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 04ef251d885e..9dd55a6f38de 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1056,22 +1056,13 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
 			continue;
 		}
 
-		if (device->devid == BTRFS_DEV_REPLACE_DEVID) {
-			/*
-			 * In the first step, keep the device which has
-			 * the correct fsid and the devid that is used
-			 * for the dev_replace procedure.
-			 * In the second step, the dev_replace state is
-			 * read from the device tree and it is known
-			 * whether the procedure is really active or
-			 * not, which means whether this device is
-			 * used or whether it should be removed.
-			 */
-			if (step == 0 || test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
-						  &device->dev_state)) {
-				continue;
-			}
-		}
+		/*
+		 * We have already validated the presence of BTRFS_DEV_REPLACE_DEVID,
+		 * in btrfs_init_dev_replace() so just continue.
+		 */
+		if (device->devid == BTRFS_DEV_REPLACE_DEVID)
+			continue;
+
 		if (device->bdev) {
 			blkdev_put(device->bdev, device->mode);
 			device->bdev = NULL;
@@ -1080,9 +1071,6 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
 		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
 			list_del_init(&device->dev_alloc_list);
 			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
-			if (!test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
-				      &device->dev_state))
-				fs_devices->rw_devices--;
 		}
 		list_del_init(&device->dev_list);
 		fs_devices->num_devices--;
-- 
2.25.1

