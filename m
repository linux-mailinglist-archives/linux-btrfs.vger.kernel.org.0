Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2C14D3078
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 14:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiCINwS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 08:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiCINwQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 08:52:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC2B17BC71
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 05:51:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 592A31F38B;
        Wed,  9 Mar 2022 13:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646833875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jmmk5aALJxQC/6PqZgQ/labidrPnC/ltf+UK+1obIVM=;
        b=BJdr1KPJhhpWbiittxiMSICW/Q0IjBibw5lmxwQdT9+RJJuAHd0uW5XXLRPcZWRCWBlSc5
        v0eMrFYM9gLmVUZyLuxkJ4oOnWXgAh1x/gVSaUPMEs5Zwvb9fNmqMH9Wr+DUTGXukqnx6C
        wCItEwTNkI1EhfDwzHsufvLGO7HuefQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 298E513D7A;
        Wed,  9 Mar 2022 13:51:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iOaSCNOwKGL1LQAAMHmgww
        (envelope-from <gniebler@suse.com>); Wed, 09 Mar 2022 13:51:15 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v4 05/14] btrfs: Use btrfs_for_each_slot in btrfs_real_readdir
Date:   Wed,  9 Mar 2022 14:50:42 +0100
Message-Id: <20220309135051.5738-6-gniebler@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309135051.5738-1-gniebler@suse.com>
References: <20220309135051.5738-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function can be simplified by refactoring to use the new iterator macro.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---
 fs/btrfs/inode.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5bbea5ec31fc..ca0de91eeece 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5755,8 +5755,6 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	struct list_head ins_list;
 	struct list_head del_list;
 	int ret;
-	struct extent_buffer *leaf;
-	int slot;
 	char *name_ptr;
 	int name_len;
 	int entries = 0;
@@ -5783,35 +5781,20 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	key.offset = ctx->pos;
 	key.objectid = btrfs_ino(BTRFS_I(inode));
 
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto err;
-
-	while (1) {
+	btrfs_for_each_slot(root, &key, &found_key, path, ret) {
 		struct dir_entry *entry;
-
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
-
-		btrfs_item_key_to_cpu(leaf, &found_key, slot);
+		struct extent_buffer *leaf = path->nodes[0];
 
 		if (found_key.objectid != key.objectid)
 			break;
 		if (found_key.type != BTRFS_DIR_INDEX_KEY)
 			break;
 		if (found_key.offset < ctx->pos)
-			goto next;
+			continue;
 		if (btrfs_should_delete_dir_index(&del_list, found_key.offset))
-			goto next;
-		di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
+			continue;
+		di = btrfs_item_ptr(leaf, path->slots[0],
+				    struct btrfs_dir_item);
 		name_len = btrfs_dir_name_len(leaf, di);
 		if ((total_len + sizeof(struct dir_entry) + name_len) >=
 		    PAGE_SIZE) {
@@ -5838,9 +5821,11 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 		entries++;
 		addr += sizeof(struct dir_entry) + name_len;
 		total_len += sizeof(struct dir_entry) + name_len;
-next:
-		path->slots[0]++;
 	}
+	/* Catch error encountered while searching */
+	if (ret < 0)
+		goto err;
+
 	btrfs_release_path(path);
 
 	ret = btrfs_filldir(private->filldir_buf, entries, ctx);
-- 
2.35.1

