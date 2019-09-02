Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93615A4EBB
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2019 06:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfIBE54 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Sep 2019 00:57:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:43118 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729376AbfIBE54 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Sep 2019 00:57:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6533DAF5A
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2019 04:57:55 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: check/lowmem: Skip nbytes check for orphan inodes
Date:   Mon,  2 Sep 2019 12:57:49 +0800
Message-Id: <20190902045750.17183-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For orphan inodes, kernel won't update its nbytes and size since it's a
waste of time.

So lowmem check can report false alert on some orphan inodes.

Fix it by checking if the inode is an orphan before
complaining/repairing its nbytes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index da6b6fd86ae3..5f7f101daab1 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2519,6 +2519,7 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 		return err;
 	}
 
+	is_orphan = has_orphan_item(root, inode_id);
 	ii = btrfs_item_ptr(node, slot, struct btrfs_inode_item);
 	isize = btrfs_inode_size(node, ii);
 	nbytes = btrfs_inode_nbytes(node, ii);
@@ -2672,19 +2673,22 @@ out:
 		"root %llu INODE[%llu] nlink(%llu) not equal to inode_refs(%llu)",
 				      root->objectid, inode_id, nlink, refs);
 			}
-		} else if (!nlink) {
-			is_orphan = has_orphan_item(root, inode_id);
-			if (!is_orphan && repair)
+		} else if (!nlink && !is_orphan) {
+			if (repair)
 				ret = repair_inode_orphan_item_lowmem(root,
 							      path, inode_id);
-			if (!is_orphan && (!repair || ret)) {
+			if (!repair || ret) {
 				err |= ORPHAN_ITEM;
 				error("root %llu INODE[%llu] is orphan item",
 				      root->objectid, inode_id);
 			}
 		}
 
-		if (nbytes != extent_size) {
+		/*
+		 * For orhpan inode, updating nbytes/size is just a waste of
+		 * time, so skip such repair and don't report them as error.
+		 */
+		if (nbytes != extent_size && !is_orphan) {
 			if (repair) {
 				ret = repair_inode_nbytes_lowmem(root, path,
 							 inode_id, extent_size);
-- 
2.23.0

