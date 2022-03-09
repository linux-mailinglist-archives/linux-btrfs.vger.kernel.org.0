Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73334D3083
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 14:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiCINwY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 08:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbiCINwS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 08:52:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B91617BC72
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 05:51:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ED06521118;
        Wed,  9 Mar 2022 13:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646833876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VrV+Ovdda5tOEvE3X9WYAWsMg1EPBwaePejA26MEXQ4=;
        b=DniZ/24ucffaStaB0AavjkjvFLv1NCkFjRlTxrZfgjlfcdc0IoVd2B2NPfCs8nlxnKrtAy
        WdBzXOoPFYxfkACi4Q4RHSYpHWwdaNNZfkajJlKbOETuI3fURNuU5J8to7fLD9X0p75lWr
        EmLMyJbl3/TLk+LZFzTmaKy6PPBQpNE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C11CA13D7A;
        Wed,  9 Mar 2022 13:51:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iH/ULdSwKGL1LQAAMHmgww
        (envelope-from <gniebler@suse.com>); Wed, 09 Mar 2022 13:51:16 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v4 12/14] btrfs: Use btrfs_for_each_slot in btrfs_unlink_all_paths
Date:   Wed,  9 Mar 2022 14:50:49 +0100
Message-Id: <20220309135051.5738-13-gniebler@suse.com>
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
 fs/btrfs/send.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 573ea102f8ab..b339f919bb75 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6115,8 +6115,11 @@ static int btrfs_unlink_all_paths(struct send_ctx *sctx)
 {
 	LIST_HEAD(deleted_refs);
 	struct btrfs_path *path;
+	struct btrfs_root *root = sctx->parent_root;
 	struct btrfs_key key;
+	struct btrfs_key found_key;
 	struct parent_paths_ctx ctx;
+	int iter_ret = 0;
 	int ret;
 
 	path = alloc_path_for_send();
@@ -6126,39 +6129,26 @@ static int btrfs_unlink_all_paths(struct send_ctx *sctx)
 	key.objectid = sctx->cur_ino;
 	key.type = BTRFS_INODE_REF_KEY;
 	key.offset = 0;
-	ret = btrfs_search_slot(NULL, sctx->parent_root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
 
 	ctx.refs = &deleted_refs;
 	ctx.sctx = sctx;
 
-	while (true) {
-		struct extent_buffer *eb = path->nodes[0];
-		int slot = path->slots[0];
-
-		if (slot >= btrfs_header_nritems(eb)) {
-			ret = btrfs_next_leaf(sctx->parent_root, path);
-			if (ret < 0)
-				goto out;
-			else if (ret > 0)
-				break;
-			continue;
-		}
-
-		btrfs_item_key_to_cpu(eb, &key, slot);
-		if (key.objectid != sctx->cur_ino)
+	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
+		if (found_key.objectid != key.objectid)
 			break;
-		if (key.type != BTRFS_INODE_REF_KEY &&
-		    key.type != BTRFS_INODE_EXTREF_KEY)
+		if (found_key.type != key.type &&
+		    found_key.type != BTRFS_INODE_EXTREF_KEY)
 			break;
 
-		ret = iterate_inode_ref(sctx->parent_root, path, &key, 1,
+		ret = iterate_inode_ref(root, path, &found_key, 1,
 					record_parent_ref, &ctx);
 		if (ret < 0)
 			goto out;
-
-		path->slots[0]++;
+	}
+	/* Catch error found on iteration */
+	if (iter_ret < 0) {
+		ret = iter_ret;
+		goto out;
 	}
 
 	while (!list_empty(&deleted_refs)) {
-- 
2.35.1

