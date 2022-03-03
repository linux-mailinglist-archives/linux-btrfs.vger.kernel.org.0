Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2A84CC060
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 15:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiCCOwr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 09:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiCCOwq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 09:52:46 -0500
X-Greylist: delayed 608 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Mar 2022 06:52:01 PST
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBAE18F233
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 06:52:00 -0800 (PST)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 223EeT4P019337-223EeT4S019337
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 3 Mar 2022 22:40:35 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: don't access possibly stale fs_info data in device_list_add
Date:   Thu,  3 Mar 2022 22:40:27 +0800
Message-Id: <20220303144027.1981835-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Dongliang Mu <mudongliangabcd@gmail.com>

Syzbot reported a possible use-after-free in printing information
in device_list_add.

Very similar with the bug fixed by commit 0697d9a61099 ("btrfs: don't
access possibly stale fs_info data for printing duplicate device"),
but this time the use occurs in btrfs_info_in_rcu.

============================================================
Call Trace:
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 btrfs_printk+0x395/0x425 fs/btrfs/super.c:244
 device_list_add.cold+0xd7/0x2ed fs/btrfs/volumes.c:957
 btrfs_scan_one_device+0x4c7/0x5c0 fs/btrfs/volumes.c:1387
 btrfs_control_ioctl+0x12a/0x2d0 fs/btrfs/super.c:2409
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
============================================================

Fix this by modifying device->fs_info to NULL too.

Reported-and-tested-by: syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b07d382d53a8..c1325bdae9a1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -954,7 +954,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 						  task_pid_nr(current));
 				return ERR_PTR(-EEXIST);
 			}
-			btrfs_info_in_rcu(device->fs_info,
+			btrfs_info_in_rcu(NULL,
 	"devid %llu device path %s changed to %s scanned by %s (%d)",
 					  devid, rcu_str_deref(device->name),
 					  path, current->comm,
-- 
2.25.1

