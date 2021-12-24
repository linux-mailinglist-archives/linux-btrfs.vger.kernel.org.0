Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8E47EBD1
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Dec 2021 06:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351414AbhLXFun (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Dec 2021 00:50:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54250 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351410AbhLXFun (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Dec 2021 00:50:43 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 575CB1F389
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Dec 2021 05:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1640325042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGPPVjW6aYiYbgIHxmhJjP2ENAqcEioJf3iNoGApW+o=;
        b=HjUoC/rKccSZLy7yZzEc67xzWhXqM8PBebC+AiDjZpFE6o5rBhXcptPQpGSrTrANI7tYXU
        9xEbuSTZ5bsdhnYWTDABDiosiY+HY4eHwknMfvRSYZoUpfWSjcNEHv+txe8yPDFANYF7Ec
        qtiW8eLwcGDB7eg5RGkXHb++XAvC1NU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DCF613A97
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Dec 2021 05:50:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WBXoGLFfxWGCGQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Dec 2021 05:50:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs-progs: check: skip NODATASUM inodes for `--init-csum-tree --init-extent-tree`
Date:   Fri, 24 Dec 2021 13:50:18 +0800
Message-Id: <20211224055019.51555-5-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211224055019.51555-1-wqu@suse.com>
References: <20211224055019.51555-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When using `--init-csum-tree` with `--init-extent-tree`, csum tree
population will be done by iterating all file extent items.

This allow us to skip preallocated extents, but it still has the
folllwing problems:

- Inodes with NODATASUM

- Hole file extents

- Written preallocated extents
  We will generate csum for the whole extent, while other part may still
  be unwritten.

Make it to follow the same behavior of recently introduced
fill_csum_for_file_extent(), so we can generate correct csum.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-common.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index dd0b1d695bfa..1c1374bae70b 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -1225,6 +1225,7 @@ static int fill_csum_tree_from_one_fs_root(struct btrfs_trans_handle *trans,
 	struct extent_buffer *node;
 	struct btrfs_file_extent_item *fi;
 	char *buf = NULL;
+	u64 skip_ino = 0;
 	u64 start = 0;
 	u64 len = 0;
 	int slot = 0;
@@ -1245,15 +1246,51 @@ static int fill_csum_tree_from_one_fs_root(struct btrfs_trans_handle *trans,
 	while (1) {
 		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
 
-		if (key.type != BTRFS_EXTENT_DATA_KEY)
+		if (key.type != BTRFS_EXTENT_DATA_KEY &&
+		    key.type != BTRFS_INODE_ITEM_KEY)
+			goto next;
+
+		/* This item belongs to an inode with NODATASUM, skip it */
+		if (key.objectid == skip_ino)
+			goto next;
+
+		if (key.type == BTRFS_INODE_ITEM_KEY) {
+			struct btrfs_inode_item *ii;
+
+			ii = btrfs_item_ptr(path.nodes[0], path.slots[0],
+					    struct btrfs_inode_item);
+			/* Check if the inode has NODATASUM flag */
+			if (btrfs_inode_flags(path.nodes[0], ii) &
+			    BTRFS_INODE_NODATASUM)
+				skip_ino = key.objectid;
 			goto next;
+		}
 		node = path.nodes[0];
 		slot = path.slots[0];
 		fi = btrfs_item_ptr(node, slot, struct btrfs_file_extent_item);
+
+		/* Skip preallocated/inline extents */
 		if (btrfs_file_extent_type(node, fi) != BTRFS_FILE_EXTENT_REG)
 			goto next;
-		start = btrfs_file_extent_disk_bytenr(node, fi);
-		len = btrfs_file_extent_disk_num_bytes(node, fi);
+
+		/* Skip hole extents */
+		if (btrfs_file_extent_disk_bytenr(node, fi) == 0)
+			goto next;
+
+		if (btrfs_file_extent_compression(node, fi) ==
+		    BTRFS_COMPRESS_NONE) {
+			/*
+			 * Non-compressed extent, only calculate csum for the
+			 * referred part, as the original larger extent can
+			 * be preallocated.
+			 */
+			start = btrfs_file_extent_disk_bytenr(node, fi) +
+				btrfs_file_extent_offset(node, fi);
+			len = btrfs_file_extent_num_bytes(node, fi);
+		} else {
+			start = btrfs_file_extent_disk_bytenr(node, fi);
+			len = btrfs_file_extent_disk_num_bytes(node, fi);
+		}
 
 		csum_root = btrfs_csum_root(gfs_info, start);
 		ret = populate_csum(trans, csum_root, buf, start, len);
-- 
2.34.1

