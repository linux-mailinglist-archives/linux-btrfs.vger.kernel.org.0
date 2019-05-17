Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A79021971
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 16:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfEQOAN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 10:00:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:53642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728351AbfEQOAN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 10:00:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 619BAAF59
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 14:00:12 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: check/lowmem: Reset path in repair mode to avoid incorrect item from being passed to lowmem check.
Date:   Fri, 17 May 2019 22:00:03 +0800
Message-Id: <20190517140003.32285-1-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In lowmem mode, we check fs roots and free space cache by iterating
each root item and inode item, using btrfs_next_item() and a path
pointing to the root tree.

However in repair mode, check_fs_root() can modify the fs root, thus
CoWs the tree root, and the old path in check_fs

It could lead to strange behavior, e.g. after repairing a fs tree, the
path can point to a fs tree.
Since no ROOT_ITEM exists in fs tree, all remaining trees are skipped in
repair mode.

This bug exists from the early time of lowmem mode repair, and is only
exposed by recent free space inode check code. (Fs tree inodes are
passed to free space inode check, causing false alerts and repair
failure).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 6d7ae2bc0549..808d6be8db30 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -5184,6 +5184,28 @@ int check_fs_roots_lowmem(struct btrfs_fs_info *fs_info)
 			err |= ret;
 		}
 next:
+		/*
+		 * In repair mode, our path is no longer reliable as CoW can
+		 * happen.
+		 * We need to reset our path.
+		 */
+		if (repair) {
+			btrfs_release_path(&path);
+			ret = btrfs_search_slot(NULL, tree_root, &key, &path,
+						0, 0);
+			if (ret < 0) {
+				if (!err)
+					err = ret;
+				goto out;
+			}
+			if (ret > 0) {
+				/* Key not found, but already at next item */
+				if (path.slots[0] <
+				    btrfs_header_nritems(path.nodes[0]))
+					continue;
+				/* falls through to next leaf */
+			}
+		}
 		ret = btrfs_next_item(tree_root, &path);
 		if (ret > 0)
 			goto out;
-- 
2.21.0

