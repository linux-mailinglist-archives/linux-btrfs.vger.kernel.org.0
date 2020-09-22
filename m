Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94A927421A
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 14:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgIVMc5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 08:32:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50070 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgIVMc5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 08:32:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MCPGvM183477
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 12:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=39VMLnaGgbnyWGXs9cnicwCzN+Ma6Z1aV97mEG457Gs=;
 b=JNuFP1oqOoWEWeW/7WUCeguT4tp+ISWKAAOyRa+gbU2yBSGK399sh8VFDEo5CGOi9e8C
 /v/r4Lf2JVl4ujlqgku6GdYN0pQpBHC7VVuZkhGIpAXvXaKSWgPdAorV3SDNC53bEEoA
 ZNpZ64exVkHE2BUMPEfi0IL+QwJuQWPxtO2V9o/EnkmsQ85upgI+A38zrp5Pm/GatpRw
 1YQAIYS1Fuw8CvvpBxAH0GjPgHVWnJtAAKLERQFgT90OV3uymZ7SV/8nhRfxXIyMdhAb
 7hxFZXmHH27hx2xz5Yjw2Jk1P5o6vjbbfMx/n/PE4ZwLXCkidE7hGFKfawxEqIXC2i3B kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33q5rgasg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 12:32:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MCPLDE146258
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 12:30:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33nuwy8q0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 12:30:55 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08MCUsnO017539
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 12:30:54 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Sep 2020 05:30:54 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: fix rw_devices count in __btrfs_free_extra_devids
Date:   Tue, 22 Sep 2020 20:30:41 +0800
Message-Id: <b3a0a629df98bd044a1fd5c4964f381ff6e7aa05.1600777827.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=3 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=3 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220099
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot reported a warning [1] in close_fs_devcies() which it reproduces
using a crafted image.

        WARN_ON(fs_devices->rw_devices);

The crafted image successfully creates a replace-device with the devid 0.
But as there isn't any replace-item. We clean the extra the devid 0, at
__btrfs_free_extra_devids().

rw_devices is incremented in btrfs_open_one_device() for all write-able
devices except for devid == BTRFS_DEV_REPLACE_DEVID.
But while we clean up the extra devices in __btrfs_free_extra_devids()
we used the BTRFS_DEV_STATE_REPLACE_TGT flag which isn't set because
there isn't the replace-item. So rw_devices went below zero.

So let __btrfs_free_extra_devids() also depend on the
devid != BTRFS_DEV_REPLACE_DEVID to manage the rw_devices.

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
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 fc_mount fs/namespace.c:978 [inline]
 vfs_kern_mount.part.0+0xd3/0x170 fs/namespace.c:1008
 vfs_kern_mount+0x3c/0x60 fs/namespace.c:995
 btrfs_mount+0x234/0xaa0 fs/btrfs/super.c:1732
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x1387/0x2070 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x46004a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da 89 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007f414d78da88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f414d78db20 RCX: 000000000046004a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f414d78dae0
RBP: 00007f414d78dae0 R08: 00007f414d78db20 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 0000000020000200 R15: 000000002001a800

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ec9dac40b4f1..2fd73eab6219 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1080,8 +1080,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
 		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
 			list_del_init(&device->dev_alloc_list);
 			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
-			if (!test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
-				      &device->dev_state))
+			if (device->devid != BTRFS_DEV_REPLACE_DEVID)
 				fs_devices->rw_devices--;
 		}
 		list_del_init(&device->dev_list);
-- 
2.25.1

