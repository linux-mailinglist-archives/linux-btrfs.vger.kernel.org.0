Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DAF3E0840
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Aug 2021 20:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbhHDSts (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 14:49:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39562 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239162AbhHDStq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Aug 2021 14:49:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7994A222ED;
        Wed,  4 Aug 2021 18:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628102972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ibsEFebdCWhNSwPx4/WZXXPW3l0/CZ82Cei7cy+4cNA=;
        b=mHZ5r7+x8fZwudXZL10ykPsfELdkh+Idcey11CHOh+zYZMdoi+3BB75uLuYBd7ugW7dykg
        m5+M1Jjoej7IL3GzCjLtxfsYXG88W4GNnC0ewdx0eMZPcrD0sPzi/d/i/wcStc1Rl7Rmzv
        YYLlVScSaL2TOKB638VtJ5v9WxWBw3s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3423513D24;
        Wed,  4 Aug 2021 18:49:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sBEbADvhCmGFOQAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Wed, 04 Aug 2021 18:49:31 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 6/7] btrfs: tree-log: Simplify log_new_ancestors
Date:   Wed,  4 Aug 2021 15:48:53 -0300
Message-Id: <20210804184854.10696-7-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210804184854.10696-1-mpdesouza@suse.com>
References: <20210804184854.10696-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The search_key variable was being used only as argument of
btrfs_search_slot. This can be simplified by calling btrfs_find_item,
which also handles the next leaf condition as well.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/tree-log.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 567adc3de11a..22417cd32347 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5929,31 +5929,30 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+/*
+ * Iterate over the given and all it's parent directories, logging them if
+ * needed.
+ *
+ * Return 0 if we reach the toplevel directory, or < 0 if error.
+ */
 static int log_new_ancestors(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
 			     struct btrfs_path *path,
 			     struct btrfs_log_ctx *ctx)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key found_key;
+	u64 ino;
 
 	btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
 
 	while (true) {
-		struct btrfs_fs_info *fs_info = root->fs_info;
-		struct extent_buffer *leaf = path->nodes[0];
-		int slot = path->slots[0];
-		struct btrfs_key search_key;
 		struct inode *inode;
-		u64 ino;
 		int ret = 0;
 
 		btrfs_release_path(path);
 
 		ino = found_key.offset;
-
-		search_key.objectid = found_key.offset;
-		search_key.type = BTRFS_INODE_ITEM_KEY;
-		search_key.offset = 0;
 		inode = btrfs_iget(fs_info->sb, ino, root);
 		if (IS_ERR(inode))
 			return PTR_ERR(inode);
@@ -5966,29 +5965,14 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 		if (ret)
 			return ret;
 
-		if (search_key.objectid == BTRFS_FIRST_FREE_OBJECTID)
+		if (ino == BTRFS_FIRST_FREE_OBJECTID)
 			break;
 
-		search_key.type = BTRFS_INODE_REF_KEY;
-		ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
+		ret = btrfs_find_item(root, path, ino, BTRFS_INODE_REF_KEY, 0,
+					&found_key);
 		if (ret < 0)
 			return ret;
-
-		leaf = path->nodes[0];
-		slot = path->slots[0];
-		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				return ret;
-			else if (ret > 0)
-				return -ENOENT;
-			leaf = path->nodes[0];
-			slot = path->slots[0];
-		}
-
-		btrfs_item_key_to_cpu(leaf, &found_key, slot);
-		if (found_key.objectid != search_key.objectid ||
-		    found_key.type != BTRFS_INODE_REF_KEY)
+		else if (ret > 0)
 			return -ENOENT;
 	}
 	return 0;
-- 
2.31.1

