Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8B74D3082
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 14:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiCINwX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 08:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbiCINwR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 08:52:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E90E17BC6B
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 05:51:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3573D1F39D;
        Wed,  9 Mar 2022 13:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646833877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H9VJTtKjfbsDEW163CEOE2jRYJFJEzOAiuEYbDxrlo8=;
        b=NMYSvHZZ7fL+ORhCzMlGTlCMRFcT/YJLB2GBLMOY/6Th1rZEy9Etyva2+zs+e94uafZc6S
        kjNNYE65+wJDvqTDh84xzWTM61a0Rr6Axh+OhlKV7zE9EILSNFvzxHfEEi55xrKYaRjfHb
        XmiFbokaFcm8bH9dFJFi+LL4K9Zon54=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0155F13D7A;
        Wed,  9 Mar 2022 13:51:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YAl/OtSwKGL1LQAAMHmgww
        (envelope-from <gniebler@suse.com>); Wed, 09 Mar 2022 13:51:16 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v4 13/14] btrfs: Use btrfs_for_each_slot in btrfs_read_chunk_tree
Date:   Wed,  9 Mar 2022 14:50:50 +0100
Message-Id: <20220309135051.5738-14-gniebler@suse.com>
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
 fs/btrfs/volumes.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b07d382d53a8..3185ececc672 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7575,6 +7575,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	struct btrfs_key found_key;
 	int ret;
 	int slot;
+	int iter_ret = 0;
 	u64 total_dev = 0;
 	u64 last_ra_node = 0;
 
@@ -7618,30 +7619,18 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	key.objectid = BTRFS_DEV_ITEMS_OBJECTID;
 	key.offset = 0;
 	key.type = 0;
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto error;
-	while (1) {
-		struct extent_buffer *node;
+	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
+		struct extent_buffer *node = path->nodes[1];
 
 		leaf = path->nodes[0];
 		slot = path->slots[0];
-		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret == 0)
-				continue;
-			if (ret < 0)
-				goto error;
-			break;
-		}
-		node = path->nodes[1];
+
 		if (node) {
 			if (last_ra_node != node->start) {
 				readahead_tree_node_children(node);
 				last_ra_node = node->start;
 			}
 		}
-		btrfs_item_key_to_cpu(leaf, &found_key, slot);
 		if (found_key.type == BTRFS_DEV_ITEM_KEY) {
 			struct btrfs_dev_item *dev_item;
 			dev_item = btrfs_item_ptr(leaf, slot,
@@ -7666,7 +7655,11 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 			if (ret)
 				goto error;
 		}
-		path->slots[0]++;
+	}
+	/* Catch error found on iteration */
+	if (iter_ret < 0) {
+		ret = iter_ret;
+		goto error;
 	}
 
 	/*
-- 
2.35.1

