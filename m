Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BF43F8C67
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 18:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243136AbhHZQn6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 12:43:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38084 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243123AbhHZQno (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 12:43:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 315701FE6E;
        Thu, 26 Aug 2021 16:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629996176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h9QYK+LNyQ1V0iCtxp5yxOjvbViFVXFiwyZAcxAZa1M=;
        b=AbFb/CEX9V4w79TowkCYThszitOOI5NNIHf3zuHN4Up3QDPMv41TTXcWEms4whNfllF7qr
        pLNzVpENVnaEJfUg9YteDVzwEFTBpApOMsLhBT/SOc4oKOPgiuegJzTHL4Oq3dQnkibVSi
        MBFGgWMpOhZxZRZnCJlxYsji0eYh69g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06F6A13B20;
        Thu, 26 Aug 2021 16:42:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EEoBLI7EJ2EVIQAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Thu, 26 Aug 2021 16:42:54 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 5/8] btrfs: inode: use btrfs_for_each_slot in btrfs_read_readdir
Date:   Thu, 26 Aug 2021 13:40:51 -0300
Message-Id: <20210826164054.14993-6-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826164054.14993-1-mpdesouza@suse.com>
References: <20210826164054.14993-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function can be simplified by using the macro.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/inode.c | 46 +++++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2aa9646bce56..12bee0107015 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6109,8 +6109,7 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	struct list_head ins_list;
 	struct list_head del_list;
 	int ret;
-	struct extent_buffer *leaf;
-	int slot;
+	int iter_ret;
 	char *name_ptr;
 	int name_len;
 	int entries = 0;
@@ -6137,35 +6136,19 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	key.offset = ctx->pos;
 	key.objectid = btrfs_ino(BTRFS_I(inode));
 
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto err;
-
-	while (1) {
+	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
 		struct dir_entry *entry;
+		struct extent_buffer *leaf = path->nodes[0];
 
-		leaf = path->nodes[0];
-		slot = path->slots[0];
-		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto err;
-			else if (ret > 0)
-				break;
-			continue;
-		}
+		if (found_key.objectid != key.objectid ||
+		    found_key.type != BTRFS_DIR_INDEX_KEY)
+			break;
 
-		btrfs_item_key_to_cpu(leaf, &found_key, slot);
+		if (found_key.offset < ctx->pos ||
+		    btrfs_should_delete_dir_index(&del_list, found_key.offset))
+			continue;
 
-		if (found_key.objectid != key.objectid)
-			break;
-		if (found_key.type != BTRFS_DIR_INDEX_KEY)
-			break;
-		if (found_key.offset < ctx->pos)
-			goto next;
-		if (btrfs_should_delete_dir_index(&del_list, found_key.offset))
-			goto next;
-		di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
+		di = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dir_item);
 		name_len = btrfs_dir_name_len(leaf, di);
 		if ((total_len + sizeof(struct dir_entry) + name_len) >=
 		    PAGE_SIZE) {
@@ -6192,9 +6175,14 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 		entries++;
 		addr += sizeof(struct dir_entry) + name_len;
 		total_len += sizeof(struct dir_entry) + name_len;
-next:
-		path->slots[0]++;
 	}
+
+	/* Error found while searching. */
+	if (iter_ret < 0) {
+		ret = iter_ret;
+		goto err;
+	}
+
 	btrfs_release_path(path);
 
 	ret = btrfs_filldir(private->filldir_buf, entries, ctx);
-- 
2.31.1

