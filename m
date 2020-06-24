Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAD520783C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404751AbgFXQDc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:03:32 -0400
Received: from lists.nic.cz ([217.31.204.67]:48136 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404755AbgFXQD2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:28 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 7BD1A1409E9;
        Wed, 24 Jun 2020 18:03:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014605; bh=Bh4I9/tTAxn2LMU4sk0YOCbgBWavgtmZf3nSPHMYQ1A=;
        h=From:To:Date;
        b=MsPs6J2EKDvLPYTmGF06rfo0BextbqhXC0N83jY+WbJZ231a+v8R/m88oIISP0abL
         a1kZMSa+8w99ZNsU6bZVTd/cCnJcLnGU4ToXLsTuTZ+D6xXu34QUzM/d8JWC1koFs3
         yPJqOGc8+0zEctItIkuzf107pXe9g2J7OPoG6C7A=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 24/30] fs: btrfs: Introduce lookup_data_extent() for later use
Date:   Wed, 24 Jun 2020 18:03:10 +0200
Message-Id: <20200624160316.5001-25-marek.behun@nic.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624160316.5001-1-marek.behun@nic.cz>
References: <20200624160316.5001-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

This implements lookup_data_extent() function for the incoming
new implementation of btrfs_file_read().

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 fs/btrfs/inode.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ab45db87a6..11eb30c27a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -825,3 +825,104 @@ out:
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

