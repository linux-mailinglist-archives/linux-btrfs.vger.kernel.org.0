Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A121E0715
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 08:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388952AbgEYGeY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 02:34:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:33574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388487AbgEYGeY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 02:34:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6D0E0AF69;
        Mon, 25 May 2020 06:34:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT v2 24/30] fs: btrfs: Introduce lookup_data_extent() for later use
Date:   Mon, 25 May 2020 14:32:51 +0800
Message-Id: <20200525063257.46757-25-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525063257.46757-1-wqu@suse.com>
References: <20200525063257.46757-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 36f6b90b058f..9a1b1d265bdd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -819,3 +819,104 @@ out:
 	free(dbuf);
 	return ret;
 }
+
+/*
+ * Get the first file extent that covers bytenr @file_offset.
+ *
+ * @file_offset must be aligned to sectorsize.
+ *
+ * return 0 for found, and path points to the file extent.
+ * return >0 for not found, and fill @next_offset.
+ * @next_offset can be 0 if there is no next file extent.
+ * return <0 for error.
+ */
+static int lookup_data_extent(struct btrfs_root *root, struct btrfs_path *path,
+			      u64 ino, u64 file_offset, u64 *next_offset)
+{
+	struct btrfs_key key;
+	struct btrfs_file_extent_item *fi;
+	u8 extent_type;
+	int ret = 0;
+
+	ASSERT(IS_ALIGNED(file_offset, root->fs_info->sectorsize));
+	key.objectid = ino;
+	key.type = BTRFS_EXTENT_DATA_KEY;
+	key.offset = file_offset;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	/* Error or we're already at the file extent */
+	if (ret <= 0)
+		return ret;
+	if (ret > 0) {
+		/* Check previous file extent */
+		ret = btrfs_previous_item(root, path, ino,
+					  BTRFS_EXTENT_DATA_KEY);
+		if (ret < 0)
+			return ret;
+		if (ret > 0)
+			goto check_next;
+	}
+	/* Now the key.offset must be smaller than @file_offset */
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	if (key.objectid != ino ||
+	    key.type != BTRFS_EXTENT_DATA_KEY)
+		goto check_next;
+
+	fi = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_file_extent_item);
+	extent_type = btrfs_file_extent_type(path->nodes[0], fi);
+	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
+		if (file_offset == 0)
+			return 0;
+		/* Inline extent should be the only extent, no next extent. */
+		*next_offset = 0;
+		return 1;
+	}
+
+	/* This file extent covers @file_offset */
+	if (key.offset <= file_offset && key.offset +
+	    btrfs_file_extent_num_bytes(path->nodes[0], fi) > file_offset)
+		return 0;
+check_next:
+	ret = btrfs_next_item(root, path);
+	if (ret < 0)
+		return ret;
+	if (ret > 0) {
+		*next_offset = 0;
+		return 1;
+	}
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	fi = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_file_extent_item);
+	/* Next next data extent */
+	if (key.objectid != ino ||
+	    key.type != BTRFS_EXTENT_DATA_KEY) {
+		*next_offset = 0;
+		return 1;
+	}
+	/* Current file extent already beyond @file_offset */
+	if (key.offset > file_offset) {
+		*next_offset = key.offset;
+		return 1;
+	}
+	/* This file extent covers @file_offset */
+	if (key.offset <= file_offset && key.offset +
+	    btrfs_file_extent_num_bytes(path->nodes[0], fi) > file_offset)
+		return 0;
+	/* This file extent ends before @file_offset, check next */
+	ret = btrfs_next_item(root, path);
+	if (ret < 0)
+		return ret;
+	if (ret > 0) {
+		*next_offset = 0;
+		return 1;
+	}
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	if (key.type != BTRFS_EXTENT_DATA_KEY || key.objectid != ino) {
+		*next_offset = 0;
+		return 1;
+	}
+	*next_offset = key.offset;
+	return 1;
+}
-- 
2.26.2

