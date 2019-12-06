Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E71ED114B7A
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 04:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfLFDoM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 22:44:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:54688 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbfLFDoM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 22:44:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 09D93ADBB;
        Fri,  6 Dec 2019 03:44:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Christian Wimmer <telefonchris@icloud.com>
Subject: [PATCH] btrfs-progs: Skip device tree when we failed to read it
Date:   Fri,  6 Dec 2019 11:44:06 +0800
Message-Id: <20191206034406.40167-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Device tree is one of the least important tree, it only contains:
- Device status
  Like various error count
- Device extents
  Only makes sense for chunk allocation and physical->logical map, and
  even for that only purpose, we can rebuild it easily from chunk tree.

So device tree even makes less sense compared to extent tree, while we
still can't skip it at btrfs-progs.

This makes restore less useful. So this patch will make device tree to
follow the same requirement for OPEN_CTREE_PARTIAL.

Reported-by: Christian Wimmer <telefonchris@icloud.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 disk-io.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/disk-io.c b/disk-io.c
index 659f8b93..22aa2a61 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -947,12 +947,10 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 		return ret;
 	fs_info->extent_root->track_dirty = 1;
 
-	ret = find_and_setup_root(root, fs_info, BTRFS_DEV_TREE_OBJECTID,
-				  fs_info->dev_root);
-	if (ret) {
-		printk("Couldn't setup device tree\n");
-		return -EIO;
-	}
+	ret = setup_root_or_create_block(fs_info, flags, fs_info->dev_root,
+					 BTRFS_DEV_TREE_OBJECTID, "device");
+	if (ret)
+		return ret;
 	fs_info->dev_root->track_dirty = 1;
 
 	ret = setup_root_or_create_block(fs_info, flags, fs_info->csum_root,
-- 
2.24.0

