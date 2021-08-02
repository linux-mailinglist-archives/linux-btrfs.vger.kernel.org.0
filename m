Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B73DD400
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Aug 2021 12:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbhHBKkS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Aug 2021 06:40:18 -0400
Received: from mail.synology.com ([211.23.38.101]:55096 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231357AbhHBKkS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Aug 2021 06:40:18 -0400
Received: from localhost.localdomain (unknown [10.17.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id F2D192D672BC;
        Mon,  2 Aug 2021 18:40:07 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1627900808; bh=CiQD9L4jlOQiTImc/hQyGqAHQa8J2Rtsqyh/hnFkav0=;
        h=From:To:Cc:Subject:Date;
        b=aNhY8DK8NVdpRWAutvgV0JthUwyeXRiPIaRIYjptAAKNDDOyTT9rOQK9TaVHMlqe/
         ddVRrvmucQc8JFVeuUvPSXbebVHNOKPqYb+kbqXhW59a/kIr/siw8APII8xgzFObwb
         wQrbtPrlz9PdPtkzcErriWGMLAkuYRm1uvEBdEUM=
From:   robbieko <robbieko@synology.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Robbie Ko <robbieko@synology.com>
Subject: [PATCH] Btrfs: fix root drop key mismatch when drop snapshot fails
Date:   Mon,  2 Aug 2021 18:40:04 +0800
Message-Id: <20210802104004.733-1-robbieko@synology.com>
X-Mailer: git-send-email 2.17.1
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Robbie Ko <robbieko@synology.com>

When walk down/up tree fails, we did not abort the transaction,
nor did modify the root drop key, but the refs of some tree blocks
may have been removed in the transaction.

Therefore, when we retry to delete subvol in the future, and
missing reference occurs when lookup extent info.

------------[ cut here ]------------
WARNING: at fs/btrfs/extent-tree.c:898 btrfs_lookup_extent_info+0x40a/0x4c0 [btrfs]()
CPU: 2 PID: 11618 Comm: btrfs-cleaner Tainted: P
Hardware name: Synology Inc. RS3617xs Series/Type2 - Board Product Name1, BIOS M.017 2019/10/16
ffffffff814c2246 ffffffff81036536 ffff88024a911d08 ffff880262de45b0
ffff8802448b5f20 ffff88024a9c1ad8 0000000000000000 ffffffffa08eb05a
000008f84e72c000 0000000000000000 0000000000000001 0000000100000000
Call Trace:
[<ffffffff814c2246>] ? dump_stack+0xc/0x15
[<ffffffff81036536>] ? warn_slowpath_common+0x56/0x70
[<ffffffffa08eb05a>] ? btrfs_lookup_extent_info+0x40a/0x4c0 [btrfs]
[<ffffffffa08ee558>] ? do_walk_down+0x128/0x750 [btrfs]
[<ffffffffa08ebab4>] ? walk_down_proc+0x314/0x330 [btrfs]
[<ffffffffa08eec42>] ? walk_down_tree+0xc2/0xf0 [btrfs]
[<ffffffffa08f2bce>] ? btrfs_drop_snapshot+0x40e/0x9a0 [btrfs]
[<ffffffffa09096db>] ? btrfs_clean_one_deleted_snapshot+0xab/0xe0 [btrfs]
[<ffffffffa08fe970>] ? cleaner_kthread+0x280/0x320 [btrfs]
[<ffffffff81052eaf>] ? kthread+0xaf/0xc0
[<ffffffff81052e00>] ? kthread_create_on_node+0x110/0x110
[<ffffffff814c8c0d>] ? ret_from_fork+0x5d/0xb0
[<ffffffff81052e00>] ? kthread_create_on_node+0x110/0x110
------------[ end trace ]------------
BTRFS error (device dm-1): Missing references.
BTRFS: error (device dm-1) in btrfs_drop_snapshot:9557: errno=-5 IO failure

We fix this problem by abort trnasaction when walk down/up tree fails.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/btrfs/extent-tree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 268ce58d4569..49cdb7eeccb3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5659,8 +5659,10 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		}
 	}
 	btrfs_release_path(path);
-	if (err)
+	if (err) {
+		btrfs_abort_transaction(trans, err);
 		goto out_end_trans;
+	}
 
 	ret = btrfs_del_root(trans, &root->root_key);
 	if (ret) {
-- 
2.17.1

