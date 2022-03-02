Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60BC4CAAC8
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 17:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243534AbiCBQvS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 11:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243532AbiCBQvR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 11:51:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C01CEA33
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 08:50:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A1B97218B0;
        Wed,  2 Mar 2022 16:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646239832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=61x6RFMwW5FwRfGvK6e3nACLhAth4njAJDyM+lNJDk8=;
        b=FU6gLZqpKmSL4DozYxSmZARljW7793ODx4fFRkpH9tfynCo2F+Xxv3bfOEyrjIE5DCVF4B
        LM0pXf2KMqATrBmOxK7ru/Je/BWpcJH8w8HK+awXQ/NDz9jNSct9W2xWXCwXRdPt++npi3
        +Ers9HlU/a2tsrIqeY82Z+mHP6NMh8Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7359D13A93;
        Wed,  2 Mar 2022 16:50:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aLJ1GligH2LdOwAAMHmgww
        (envelope-from <gniebler@suse.com>); Wed, 02 Mar 2022 16:50:32 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v3 03/14] btrfs: Use btrfs_for_each_slot in mark_block_group_to_copy
Date:   Wed,  2 Mar 2022 17:48:18 +0100
Message-Id: <20220302164829.17524-4-gniebler@suse.com>
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
 fs/btrfs/dev-replace.c | 41 ++++++++---------------------------------
 1 file changed, 8 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 62b9651ea662..3357739f427f 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -470,6 +470,7 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 	struct btrfs_dev_extent *dev_extent = NULL;
 	struct btrfs_block_group *cache;
 	struct btrfs_trans_handle *trans;
+	int iter_ret = 0;
 	int ret = 0;
 	u64 chunk_offset;
 
@@ -520,29 +521,8 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 	key.type = BTRFS_DEV_EXTENT_KEY;
 	key.offset = 0;
 
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto free_path;
-	if (ret > 0) {
-		if (path->slots[0] >=
-		    btrfs_header_nritems(path->nodes[0])) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto free_path;
-			if (ret > 0) {
-				ret = 0;
-				goto free_path;
-			}
-		} else {
-			ret = 0;
-		}
-	}
-
-	while (1) {
+	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
 		struct extent_buffer *leaf = path->nodes[0];
-		int slot = path->slots[0];
-
-		btrfs_item_key_to_cpu(leaf, &found_key, slot);
 
 		if (found_key.objectid != src_dev->devid)
 			break;
@@ -553,30 +533,25 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 		if (found_key.offset < key.offset)
 			break;
 
-		dev_extent = btrfs_item_ptr(leaf, slot, struct btrfs_dev_extent);
+		dev_extent = btrfs_item_ptr(leaf, path->slots[0],
+					    struct btrfs_dev_extent);
 
 		chunk_offset = btrfs_dev_extent_chunk_offset(leaf, dev_extent);
 
 		cache = btrfs_lookup_block_group(fs_info, chunk_offset);
 		if (!cache)
-			goto skip;
+			continue;
 
 		spin_lock(&cache->lock);
 		cache->to_copy = 1;
 		spin_unlock(&cache->lock);
 
 		btrfs_put_block_group(cache);
-
-skip:
-		ret = btrfs_next_item(root, path);
-		if (ret != 0) {
-			if (ret > 0)
-				ret = 0;
-			break;
-		}
+	}
+	if (iter_ret < 0) {
+		ret = iter_ret;
 	}
 
-free_path:
 	btrfs_free_path(path);
 unlock:
 	mutex_unlock(&fs_info->chunk_mutex);
-- 
2.35.1

