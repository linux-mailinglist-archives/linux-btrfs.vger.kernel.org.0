Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8CD4CAACB
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 17:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243535AbiCBQvW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 11:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243532AbiCBQvV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 11:51:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AB4CF3BA
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 08:50:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 40F9D218B0;
        Wed,  2 Mar 2022 16:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646239837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sUC7YXe9FBIPq32CKKUrvPjxpItdxKQaRmndE3aulYY=;
        b=a0FY31drTEeU9p7C18PYO8q39bvHTfQw48uyqggxkeF+IrgXm/+anBO9VTFsm8OHR1GrFF
        53CNX09p+i3OK3LSwQY0jf4wON3s3I7lebX8i3t5/jm4+Mo+TGCErUk6erjd+B6OPo0eYJ
        FgdzY7UUCHdsrMNTiVVcdBsQGr3tctI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 110D013A93;
        Wed,  2 Mar 2022 16:50:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eJynAl2gH2LdOwAAMHmgww
        (envelope-from <gniebler@suse.com>); Wed, 02 Mar 2022 16:50:37 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v3 04/14] btrfs: Use btrfs_for_each_slot in btrfs_search_dir_index_item
Date:   Wed,  2 Mar 2022 17:48:19 +0100
Message-Id: <20220302164829.17524-5-gniebler@suse.com>
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
 fs/btrfs/dir-item.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 3b532bab0755..d7a24f17292d 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -325,36 +325,15 @@ btrfs_search_dir_index_item(struct btrfs_root *root,
 			    struct btrfs_path *path, u64 dirid,
 			    const char *name, int name_len)
 {
-	struct extent_buffer *leaf;
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
-	u32 nritems;
 	int ret;
 
 	key.objectid = dirid;
 	key.type = BTRFS_DIR_INDEX_KEY;
 	key.offset = 0;
 
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		return ERR_PTR(ret);
-
-	leaf = path->nodes[0];
-	nritems = btrfs_header_nritems(leaf);
-
-	while (1) {
-		if (path->slots[0] >= nritems) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				return ERR_PTR(ret);
-			if (ret > 0)
-				break;
-			leaf = path->nodes[0];
-			nritems = btrfs_header_nritems(leaf);
-			continue;
-		}
-
-		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+	btrfs_for_each_slot(root, &key, &key, path, ret) {
 		if (key.objectid != dirid || key.type != BTRFS_DIR_INDEX_KEY)
 			break;
 
@@ -362,10 +341,12 @@ btrfs_search_dir_index_item(struct btrfs_root *root,
 					       name, name_len);
 		if (di)
 			return di;
-
-		path->slots[0]++;
 	}
-	return NULL;
+	/* Fix return code if key was not found in next leaf. */
+	if (ret > 0) {
+		ret = 0;
+	}
+	return ERR_PTR(ret);
 }
 
 struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
-- 
2.35.1

