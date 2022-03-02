Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C134CAACE
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 17:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243556AbiCBQvk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 11:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243554AbiCBQvj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 11:51:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7CDCFBBB
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 08:50:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A4C701F383;
        Wed,  2 Mar 2022 16:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646239854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cUAcQ0+LJdu2Wl4B1ZBdkZN9vME5PfKbEXbbLqa7zFw=;
        b=LEquOgvufweqP06I7zdmSczY4BAgTH9W40kL2E322VblLyLNJenlyzudOTzMijSX+X7Pbw
        F7/vWWzfzsJ4sSCoecl0QvHfi0E/AmOSRQ+PIeUJHzC92NcQvjJz+oV6BiRU/KoYeJy54G
        a3VSC1rE+uHEdVBVPFXtg9w2PBrfjvA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 751A113A93;
        Wed,  2 Mar 2022 16:50:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UOWCGm6gH2LdOwAAMHmgww
        (envelope-from <gniebler@suse.com>); Wed, 02 Mar 2022 16:50:54 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v3 08/14] btrfs: Use btrfs_for_each_slot in is_ancestor
Date:   Wed,  2 Mar 2022 17:48:23 +0100
Message-Id: <20220302164829.17524-9-gniebler@suse.com>
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
 fs/btrfs/send.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7b6d1a65793e..bb797f411daf 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -3557,7 +3557,7 @@ static int check_ino_in_path(struct btrfs_root *root,
 }
 
 /*
- * Check if ino ino1 is an ancestor of inode ino2 in the given root for any
+ * Check if inode ino1 is an ancestor of inode ino2 in the given root for any
  * possible path (in case ino2 is not a directory and has multiple hard links).
  * Return 1 if true, 0 if false and < 0 on error.
  */
@@ -3569,6 +3569,7 @@ static int is_ancestor(struct btrfs_root *root,
 {
 	bool free_fs_path = false;
 	int ret = 0;
+	int iter_ret = 0;
 	struct btrfs_path *path = NULL;
 	struct btrfs_key key;
 
@@ -3589,26 +3590,12 @@ static int is_ancestor(struct btrfs_root *root,
 	key.type = BTRFS_INODE_REF_KEY;
 	key.offset = 0;
 
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
-
-	while (true) {
+	btrfs_for_each_slot(root, &key, &key, path, iter_ret) {
 		struct extent_buffer *leaf = path->nodes[0];
 		int slot = path->slots[0];
 		u32 cur_offset = 0;
 		u32 item_size;
 
-		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto out;
-			if (ret > 0)
-				break;
-			continue;
-		}
-
-		btrfs_item_key_to_cpu(leaf, &key, slot);
 		if (key.objectid != ino2)
 			break;
 		if (key.type != BTRFS_INODE_REF_KEY &&
@@ -3646,10 +3633,12 @@ static int is_ancestor(struct btrfs_root *root,
 			if (ret)
 				goto out;
 		}
-		path->slots[0]++;
 	}
 	ret = 0;
- out:
+	if (iter_ret < 0) {
+		ret = iter_ret;
+	}
+out:
 	btrfs_free_path(path);
 	if (free_fs_path)
 		fs_path_free(fs_path);
-- 
2.35.1

