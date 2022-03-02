Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631FF4CAAD5
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 17:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiCBQvh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 11:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243555AbiCBQvg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 11:51:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09343D005F
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 08:50:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BD9291F37E;
        Wed,  2 Mar 2022 16:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646239847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SHe+vGe3tZj8iUanqGxOa8hlMIkahQIRCsECAci8wM4=;
        b=VrHhE20kGW6/oF3k2ale7uPr53PCCvojt0SmdZVLwHUoDmr5a6LEBkb+U9u4h9lHVevO8B
        ZjoL8WyuWu/drN4/xaHo7Xi88ndUwG8Y4WG/YY4FBpPvtCJMSRPvihU+AfGyj+F6RF7zs8
        a6C6KwGvuiNW30/aw0jWMwCBcb4oft4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D8D913A93;
        Wed,  2 Mar 2022 16:50:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0BuKIGegH2LdOwAAMHmgww
        (envelope-from <gniebler@suse.com>); Wed, 02 Mar 2022 16:50:47 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v3 06/14] btrfs: Use btrfs_for_each_slot in did_create_dir
Date:   Wed,  2 Mar 2022 17:48:21 +0100
Message-Id: <20220302164829.17524-7-gniebler@suse.com>
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
 fs/btrfs/send.c | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 201eb2628aea..09715d98145a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2680,61 +2680,45 @@ static int send_create_inode(struct send_ctx *sctx, u64 ino)
 static int did_create_dir(struct send_ctx *sctx, u64 dir)
 {
 	int ret = 0;
+	int iter_ret = 0;
 	struct btrfs_path *path = NULL;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_key di_key;
-	struct extent_buffer *eb;
 	struct btrfs_dir_item *di;
-	int slot;
 
 	path = alloc_path_for_send();
 	if (!path) {
-		ret = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
 	key.objectid = dir;
 	key.type = BTRFS_DIR_INDEX_KEY;
 	key.offset = 0;
-	ret = btrfs_search_slot(NULL, sctx->send_root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
 
-	while (1) {
-		eb = path->nodes[0];
-		slot = path->slots[0];
-		if (slot >= btrfs_header_nritems(eb)) {
-			ret = btrfs_next_leaf(sctx->send_root, path);
-			if (ret < 0) {
-				goto out;
-			} else if (ret > 0) {
-				ret = 0;
-				break;
-			}
-			continue;
-		}
+	btrfs_for_each_slot(sctx->send_root, &key, &found_key, path, iter_ret) {
+		struct extent_buffer *eb = path->nodes[0];
 
-		btrfs_item_key_to_cpu(eb, &found_key, slot);
 		if (found_key.objectid != key.objectid ||
 		    found_key.type != key.type) {
 			ret = 0;
-			goto out;
+			break;
 		}
 
-		di = btrfs_item_ptr(eb, slot, struct btrfs_dir_item);
+		di = btrfs_item_ptr(eb, path->slots[0], struct btrfs_dir_item);
 		btrfs_dir_item_key_to_cpu(eb, di, &di_key);
 
 		if (di_key.type != BTRFS_ROOT_ITEM_KEY &&
 		    di_key.objectid < sctx->send_progress) {
 			ret = 1;
-			goto out;
+			break;
 		}
-
-		path->slots[0]++;
+	}
+	/* Catch error found on iteration */
+	if (iter_ret < 0) {
+		ret = iter_ret;
 	}
 
-out:
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.35.1

