Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA0D4D307B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 14:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiCINwU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 08:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiCINwR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 08:52:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C52717C404
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 05:51:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA71C21116;
        Wed,  9 Mar 2022 13:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646833875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpLLgdzDMFFwPmKi1/scJfo9T2YDwubQYg24UQ00XEc=;
        b=DUUxsjCbuibRjzzp/yi1e4jM59+4HlgE7blfZsfwRbr28Ky8W+A4nh+KfF/e8VMSg6PdC6
        oesxg2WapzjhMTvDiaoDcUkAB54uuI18Mn3KHwA5y9Nqn/zF6+n0MGBni3UMwkhLKRfJDF
        FM4LauDW+u+CFhM1pO7bWbur1k6pakA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99F7013D7A;
        Wed,  9 Mar 2022 13:51:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4DD4I9OwKGL1LQAAMHmgww
        (envelope-from <gniebler@suse.com>); Wed, 09 Mar 2022 13:51:15 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v4 07/14] btrfs: Use btrfs_for_each_slot in can_rmdir
Date:   Wed,  9 Mar 2022 14:50:44 +0100
Message-Id: <20220309135051.5738-8-gniebler@suse.com>
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
 fs/btrfs/send.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 417aed3ab592..5ecb8e39f449 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2920,6 +2920,7 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 		     u64 send_progress)
 {
 	int ret = 0;
+	int iter_ret = 0;
 	struct btrfs_root *root = sctx->parent_root;
 	struct btrfs_path *path;
 	struct btrfs_key key;
@@ -2946,23 +2947,9 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 	if (odi)
 		key.offset = odi->last_dir_index_offset;
 
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
-
-	while (1) {
+	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
 		struct waiting_dir_move *dm;
 
-		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto out;
-			else if (ret > 0)
-				break;
-			continue;
-		}
-		btrfs_item_key_to_cpu(path->nodes[0], &found_key,
-				      path->slots[0]);
 		if (found_key.objectid != key.objectid ||
 		    found_key.type != key.type)
 			break;
@@ -2997,8 +2984,10 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 			ret = 0;
 			goto out;
 		}
-
-		path->slots[0]++;
+	}
+	if (iter_ret < 0) {
+		ret = iter_ret;
+		goto out;
 	}
 	free_orphan_dir_info(sctx, odi);
 
-- 
2.35.1

