Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248FB1B23B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 12:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgDUKZZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 06:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgDUKZY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 06:25:24 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8FB22064A
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Apr 2020 10:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587464724;
        bh=Bd9+mSOkOIlVq+UL8SXD4yWJjmSKl5od7AZF9BmsYW4=;
        h=From:To:Subject:Date:From;
        b=mcoGRrPEe+AoHKbfnZzSjS71x/dcW3I71Sb5SKewSQcaIrkK6YTgbUzBEPWsuNJHs
         kyhaXNXpwZHxGmMA+R/ajIiJxLk/IIPss0Rjndk/SlUD+resBw1KUCbqAGw0CvTzN4
         SxHOEy/trIClvOqOVd0pO11FK2uE+HIQwwdIDN08=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix partial loss of prealloc extent past i_size after fsync
Date:   Tue, 21 Apr 2020 11:25:20 +0100
Message-Id: <20200421102520.14686-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we have an inode with a prealloc extent that starts at an offset
lower than the i_size and there is another prealloc extent that starts at
an offset beyond i_size, we can end up losing part of the first prealloc
extent (the part that starts at i_size) and have an implicit hole if we
fsync the file and then have a power failure.

Consider the following example with comments explaining how and why it
happens.

  $ mkfs.btrfs -f /dev/sdb
  $ mount /dev/sdb /mnt

  # Create our test file with 2 consecutive prealloc extents, each with a
  # size of 128Kb, and covering the range from 0 to 256Kb, with a file
  # size of 0.
  $ xfs_io -f -c "falloc -k 0 128K" /mnt/foo
  $ xfs_io -c "falloc -k 128K 128K" /mnt/foo

  # Fsync the file to record both extents in the log tree.
  $ xfs_io -c "fsync" /mnt/foo

  # Now do a redudant extent allocation for the range from 0 to 64Kb.
  # This will merely increase the file size from 0 to 64Kb. Instead we
  # could also do a truncate to set the file size to 64Kb.
  $ xfs_io -c "falloc 0 64K" /mnt/foo

  # Fsync the file, so we update the inode item in the log tree with the
  # new file size (64Kb). This also ends up setting the number of bytes
  # for the first prealloc extent to 64Kb. This is done by the truncation
  # at btrfs_log_prealloc_extents().
  # This means that if a power failure happens after this, a write into
  # the file range 64Kb to 128Kb will not use the prealloc extent and
  # will result in allocation of a new extent.
  $ xfs_io -c "fsync" /mnt/foo

  # Now set the file size to 256K with a truncate and then fsync the file.
  # Since no changes happened to the extents, the fsync only updates the
  # i_size in the inode item at the log tree. This results in an implicit
  # hole for the file range from 64Kb to 128Kb, something which fsck will
  # complain when not using the NO_HOLES feature if we replay the log
  # after a power failure.
  $ xfs_io -c "truncate 256K" -c "fsync" /mnt/foo

So instead of always truncating the log to the inode's current i_size at
btrfs_log_prealloc_extents(), check first if there's a prealloc extent
that starts at an offset lower than the i_size and with a length that
crosses the i_size - if there is one, just make sure we truncate to a
size that corresponds to the end offset of that prealloc extent, so
that we don't lose the part of that extent that starts at i_size if a
power failure happens.

A test case for fstests follows soon.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4272610d7472..9761e6d538fb 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4226,6 +4226,9 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 	const u64 ino = btrfs_ino(inode);
 	struct btrfs_path *dst_path = NULL;
 	bool dropped_extents = false;
+	u64 truncate_offset = i_size;
+	struct extent_buffer *leaf;
+	int slot;
 	int ins_nr = 0;
 	int start_slot;
 	int ret;
@@ -4240,9 +4243,43 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 	if (ret < 0)
 		goto out;
 
+	/*
+	 * We must check if there is a prealloc extent that starts before the
+	 * i_size and crosses the i_size boundary. This is to ensure later we
+	 * truncate down to the end of that extent and not to the i_size, as
+	 * otherwise we end up losing part of the prealloc extent after a log
+	 * replay and with an implicit hole if there is another prealloc extent
+	 * that starts at an offset beyond i_size.
+	 */
+	ret = btrfs_previous_item(root, path, ino, BTRFS_EXTENT_DATA_KEY);
+	if (ret < 0)
+		goto out;
+
+	if (ret == 0) {
+		struct btrfs_file_extent_item *ei;
+
+		leaf = path->nodes[0];
+		slot = path->slots[0];
+		ei = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
+
+		if (btrfs_file_extent_type(leaf, ei) ==
+		    BTRFS_FILE_EXTENT_PREALLOC) {
+			u64 extent_end;
+
+			btrfs_item_key_to_cpu(leaf, &key, slot);
+			extent_end = key.offset +
+				btrfs_file_extent_disk_num_bytes(leaf, ei);
+
+			if (extent_end > i_size)
+				truncate_offset = extent_end;
+		}
+	} else {
+		ret = 0;
+	}
+
 	while (true) {
-		struct extent_buffer *leaf = path->nodes[0];
-		int slot = path->slots[0];
+		leaf = path->nodes[0];
+		slot = path->slots[0];
 
 		if (slot >= btrfs_header_nritems(leaf)) {
 			if (ins_nr > 0) {
@@ -4280,7 +4317,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 				ret = btrfs_truncate_inode_items(trans,
 							 root->log_root,
 							 &inode->vfs_inode,
-							 i_size,
+							 truncate_offset,
 							 BTRFS_EXTENT_DATA_KEY);
 			} while (ret == -EAGAIN);
 			if (ret)
-- 
2.11.0

