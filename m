Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3086538CF38
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 22:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhEUUpj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 16:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhEUUpi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 16:45:38 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA2FC0613CE
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 13:44:15 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v8so21187658qkv.1
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 13:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kg42gVq1AI6IZtQ80DXtEY82+HG/2AcUzZXKKpLdRAM=;
        b=JkflL4KhqI37hmrOu+FCpwh+iKF4cLf/Ep2Lk33Pd+dLXvT/Vvjo5coCaQ1irDYZEx
         UGyhW4LuFrBe08oQTJrH9YTzRZO36G0fsTBxbmjLfEe6kKcevrOEQMze4rC6J0wdSXHq
         wbSpi/kE1/lAWi2NrBx0WCQwm+ow1hUwv9c7KutgirimuRkPdq9Op56BIklAkefJe3K4
         LRWVkMrYotjgSwq/JydioFYivAKQ4gnp2nwtWY0iEOv7jR2KNKLCKvBSQ/MvxW0O0nmm
         2iW++L7thq2iCkhYdhLuCtLd6mQsDqpnDPsoVa0fCCEIlNbmgWfHbQhr4NNDvLnwwqH7
         rKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kg42gVq1AI6IZtQ80DXtEY82+HG/2AcUzZXKKpLdRAM=;
        b=bP6DPYvDORUrmcbZlTPwV3QRkoCC6ogwkndChPFHjR3zp24LiQRzmVD1tVXIB1/VE/
         pWh1VDY6hUmm1fKM6Scr8AQuyFAKWPSbVzHRu7p8o60rD/+2jR6EzbsYISKAnm0LZ22X
         KWZqM5K4JdOkFSirhx/MGFuRJOTf/37UnrwbrjEP3R3dYdEjITpnt3+smEUkjqy+J/Zz
         umcX/lA8PQac1KlkM460GaLQo+0AH06/ddqTPgoMq71YGW/9SxFE3c0I3z7MKZK43Kbo
         2ZHUnyy2QyNYxQF0PbJrxQOH5AorrDcb9GEsjxKHV/f7WgcRx929NsfUnYEIXqgD4DUM
         hDQQ==
X-Gm-Message-State: AOAM530iaQuxnQ6Bs15ZpqS5Ku3HOysFUa8ZAgnS7yXloNaCyDGMBDcx
        u1YzjbXhfTj5k7xLRc8gFh9f55lbVlKc5w==
X-Google-Smtp-Source: ABdhPJzFSYXWiGJkPUL/0lIPkWNH4C52aeS48YyopPGRDWypltFS4wMujRjEGV/Gwur7kXLkDZz8AQ==
X-Received: by 2002:a37:9a44:: with SMTP id c65mr3357868qke.152.1621629854108;
        Fri, 21 May 2021 13:44:14 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h62sm5870516qkf.45.2021.05.21.13.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:44:13 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs: fix error handling in __btrfs_update_delayed_inode
Date:   Fri, 21 May 2021 16:44:08 -0400
Message-Id: <5e98791bfd935879e638ffa25d154ad6dd49c7b1.1621629737.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1621629737.git.josef@toxicpanda.com>
References: <cover.1621629737.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we get an error while looking up the inode item we'll simply bail
without cleaning up the delayed node.  This results in this style of
warning happening on commit

------------[ cut here ]------------
WARNING: CPU: 0 PID: 76403 at fs/btrfs/delayed-inode.c:1365 btrfs_assert_delayed_root_empty+0x5b/0x90
CPU: 0 PID: 76403 Comm: fsstress Tainted: G        W         5.13.0-rc1+ #373
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
RIP: 0010:btrfs_assert_delayed_root_empty+0x5b/0x90
RSP: 0018:ffffb8bb815a7e50 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff95d6d07e1888 RCX: ffff95d6c0fa3000
RDX: 0000000000000002 RSI: 000000000029e91c RDI: ffff95d6c0fc8060
RBP: ffff95d6c0fc8060 R08: 00008d6d701a2c1d R09: 0000000000000000
R10: ffff95d6d1760ea0 R11: 0000000000000001 R12: ffff95d6c15a4d00
R13: ffff95d6c0fa3000 R14: 0000000000000000 R15: ffffb8bb815a7e90
FS:  00007f490e8dbb80(0000) GS:ffff95d73bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6e75555cb0 CR3: 00000001101ce001 CR4: 0000000000370ef0
Call Trace:
 btrfs_commit_transaction+0x43c/0xb00
 ? finish_wait+0x80/0x80
 ? vfs_fsync_range+0x90/0x90
 iterate_supers+0x8c/0x100
 ksys_sync+0x50/0x90
 __do_sys_sync+0xa/0x10
 do_syscall_64+0x3d/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Because the iref isn't dropped and this leaves an elevated node->count,
so any release just re-queues it onto the delayed inodes list.  Fix this
by going to the out label to handle the proper cleanup of the delayed
node.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-inode.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 3ed4ecb49f8a..263f3ab3009c 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1012,12 +1012,10 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 	nofs_flag = memalloc_nofs_save();
 	ret = btrfs_lookup_inode(trans, root, path, &key, mod);
 	memalloc_nofs_restore(nofs_flag);
-	if (ret > 0) {
-		btrfs_release_path(path);
-		return -ENOENT;
-	} else if (ret < 0) {
-		return ret;
-	}
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		goto out;
 
 	leaf = path->nodes[0];
 	inode_item = btrfs_item_ptr(leaf, path->slots[0],
-- 
2.26.3

