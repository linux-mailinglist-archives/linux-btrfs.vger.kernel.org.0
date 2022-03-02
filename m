Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA74D4CAAD3
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 17:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbiCBQvn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 11:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243551AbiCBQvm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 11:51:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBD2CFBBB
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 08:50:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 44908219A4;
        Wed,  2 Mar 2022 16:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646239858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eapvnadoSgxk9yc11ZDOAFU2Xt0Rt/AhkGU2HtRIlgM=;
        b=ZutbLkEtFa6+39xengwedD4A/Yq6tllnJrjwKXVVLfp9yWH2t/rt4b64V6bp1iDc15n/0T
        Xk/wNV0RVTviBS/GxhrLabSN20N+WRKTuMyEWshzKw2rC3onpdGxVWfCSE44pnv1ZuhGxP
        0yLFGnUT/yahz+ZvWULnI7LYsh5I7z8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 056E813A93;
        Wed,  2 Mar 2022 16:50:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8F7VOnGgH2LdOwAAMHmgww
        (envelope-from <gniebler@suse.com>); Wed, 02 Mar 2022 16:50:57 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v3 09/14] btrfs: Use btrfs_for_each_slot in process_all_refs
Date:   Wed,  2 Mar 2022 17:48:24 +0100
Message-Id: <20220302164829.17524-10-gniebler@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302164829.17524-1-gniebler@suse.com>
References: <20220302164829.17524-1-gniebler@suse.com>
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
 fs/btrfs/send.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index bb797f411daf..e54f168b6fc6 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4518,13 +4518,12 @@ static int record_changed_ref(struct send_ctx *sctx)
 static int process_all_refs(struct send_ctx *sctx,
 			    enum btrfs_compare_tree_result cmd)
 {
-	int ret;
+	int ret = 0;
+	int iter_ret = 0;
 	struct btrfs_root *root;
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
-	struct extent_buffer *eb;
-	int slot;
 	iterate_inode_ref_t cb;
 	int pending_move = 0;
 
@@ -4540,7 +4539,7 @@ static int process_all_refs(struct send_ctx *sctx,
 		cb = __record_deleted_ref;
 	} else {
 		btrfs_err(sctx->send_root->fs_info,
-				"Wrong command %d in process_all_refs", cmd);
+			  "Wrong command %d in process_all_refs", cmd);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -4548,24 +4547,7 @@ static int process_all_refs(struct send_ctx *sctx,
 	key.objectid = sctx->cmp_key->objectid;
 	key.type = BTRFS_INODE_REF_KEY;
 	key.offset = 0;
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
-
-	while (1) {
-		eb = path->nodes[0];
-		slot = path->slots[0];
-		if (slot >= btrfs_header_nritems(eb)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto out;
-			else if (ret > 0)
-				break;
-			continue;
-		}
-
-		btrfs_item_key_to_cpu(eb, &found_key, slot);
-
+	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
 		if (found_key.objectid != key.objectid ||
 		    (found_key.type != BTRFS_INODE_REF_KEY &&
 		     found_key.type != BTRFS_INODE_EXTREF_KEY))
@@ -4574,8 +4556,11 @@ static int process_all_refs(struct send_ctx *sctx,
 		ret = iterate_inode_ref(root, path, &found_key, 0, cb, sctx);
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
 	btrfs_release_path(path);
 
-- 
2.35.1

