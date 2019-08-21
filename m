Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4308497B0E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfHUNiT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 09:38:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:50538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728502AbfHUNiT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 09:38:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7394BAD08
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 13:38:18 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Make reada_tree_block_flagged private
Date:   Wed, 21 Aug 2019 16:38:15 +0300
Message-Id: <20190821133815.22173-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function is used only for the readahead machinery. It makes no
sense to keep it external to reada.c file. Place it above its sole
caller and make it static. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c | 29 -----------------------------
 fs/btrfs/disk-io.h |  2 --
 fs/btrfs/reada.c   | 29 +++++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2ae455ef312f..1facf0e659c0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1038,35 +1038,6 @@ void readahead_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr)
 		free_extent_buffer(buf);
 }
 
-int reada_tree_block_flagged(struct btrfs_fs_info *fs_info, u64 bytenr,
-			 int mirror_num, struct extent_buffer **eb)
-{
-	struct extent_buffer *buf = NULL;
-	int ret;
-
-	buf = btrfs_find_create_tree_block(fs_info, bytenr);
-	if (IS_ERR(buf))
-		return 0;
-
-	set_bit(EXTENT_BUFFER_READAHEAD, &buf->bflags);
-
-	ret = read_extent_buffer_pages(buf, WAIT_PAGE_LOCK, mirror_num);
-	if (ret) {
-		free_extent_buffer_stale(buf);
-		return ret;
-	}
-
-	if (test_bit(EXTENT_BUFFER_CORRUPT, &buf->bflags)) {
-		free_extent_buffer_stale(buf);
-		return -EIO;
-	} else if (extent_buffer_uptodate(buf)) {
-		*eb = buf;
-	} else {
-		free_extent_buffer(buf);
-	}
-	return 0;
-}
-
 struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
 						u64 bytenr)
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index e80f7c45a307..a6958103d87e 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -45,8 +45,6 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 				      u64 parent_transid, int level,
 				      struct btrfs_key *first_key);
 void readahead_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr);
-int reada_tree_block_flagged(struct btrfs_fs_info *fs_info, u64 bytenr,
-			 int mirror_num, struct extent_buffer **eb);
 struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
 						u64 bytenr);
diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index 0b034c494355..ee6f60547a8d 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -639,6 +639,35 @@ static int reada_pick_zone(struct btrfs_device *dev)
 	return 1;
 }
 
+static int reada_tree_block_flagged(struct btrfs_fs_info *fs_info, u64 bytenr,
+				    int mirror_num, struct extent_buffer **eb)
+{
+	struct extent_buffer *buf = NULL;
+	int ret;
+
+	buf = btrfs_find_create_tree_block(fs_info, bytenr);
+	if (IS_ERR(buf))
+		return 0;
+
+	set_bit(EXTENT_BUFFER_READAHEAD, &buf->bflags);
+
+	ret = read_extent_buffer_pages(buf, WAIT_PAGE_LOCK, mirror_num);
+	if (ret) {
+		free_extent_buffer_stale(buf);
+		return ret;
+	}
+
+	if (test_bit(EXTENT_BUFFER_CORRUPT, &buf->bflags)) {
+		free_extent_buffer_stale(buf);
+		return -EIO;
+	} else if (extent_buffer_uptodate(buf)) {
+		*eb = buf;
+	} else {
+		free_extent_buffer(buf);
+	}
+	return 0;
+}
+
 static int reada_start_machine_dev(struct btrfs_device *dev)
 {
 	struct btrfs_fs_info *fs_info = dev->fs_info;
-- 
2.17.1

