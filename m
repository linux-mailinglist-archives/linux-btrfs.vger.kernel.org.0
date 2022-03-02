Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517DF4CAACF
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 17:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243554AbiCBQvq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 11:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243558AbiCBQvq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 11:51:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74689CFB9C
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 08:51:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 33352219A4;
        Wed,  2 Mar 2022 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646239861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AP9bGi2J20l3TE5fMCzoziAUXQo3XjfqPb2G0CD0j+U=;
        b=TGfXKFra4oLiY6bEH6VFofIZ1h2zZXT+3p8kTO8N55NZEcSoeFDzJDT8QIXmqvz1rnU+PS
        ft+1nqOi7VUMp47PKX5Kx5rq4C6SoA/N8BtOLrT8sSvNGoIDM/aK78m9i7jmUHUe856MSB
        NtkCnpWt02l7AjFs1oF0RqcJRSAZ01c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04B6F13A93;
        Wed,  2 Mar 2022 16:51:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0E+MOnSgH2LdOwAAMHmgww
        (envelope-from <gniebler@suse.com>); Wed, 02 Mar 2022 16:51:00 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v3 10/14] btrfs: Use btrfs_for_each_slot in process_all_new_xattrs
Date:   Wed,  2 Mar 2022 17:48:25 +0100
Message-Id: <20220302164829.17524-11-gniebler@suse.com>
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
 fs/btrfs/send.c | 36 +++++++++---------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e54f168b6fc6..2057aca8c3eb 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4822,13 +4822,12 @@ static int process_changed_xattr(struct send_ctx *sctx)
 
 static int process_all_new_xattrs(struct send_ctx *sctx)
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
 
 	path = alloc_path_for_send();
 	if (!path)
@@ -4839,39 +4838,22 @@ static int process_all_new_xattrs(struct send_ctx *sctx)
 	key.objectid = sctx->cmp_key->objectid;
 	key.type = BTRFS_XATTR_ITEM_KEY;
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
-			if (ret < 0) {
-				goto out;
-			} else if (ret > 0) {
-				ret = 0;
-				break;
-			}
-			continue;
-		}
-
-		btrfs_item_key_to_cpu(eb, &found_key, slot);
+	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
 		if (found_key.objectid != key.objectid ||
 		    found_key.type != key.type) {
 			ret = 0;
-			goto out;
+			break;
 		}
 
 		ret = iterate_dir_item(root, path, __process_new_xattr, sctx);
 		if (ret < 0)
-			goto out;
-
-		path->slots[0]++;
+			break;
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

