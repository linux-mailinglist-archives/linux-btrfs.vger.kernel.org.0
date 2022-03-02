Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC114CAAC7
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 17:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243531AbiCBQvP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 11:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbiCBQvN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 11:51:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D3ECEA33
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 08:50:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8556218B0;
        Wed,  2 Mar 2022 16:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646239828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y1dDfqL97/ras1oQBauITfHAelwji2MkaywevmahfGc=;
        b=fWIdsXF6zwM9Ga9Opwsf45F5DdlGkU8Wm5jiqwfAFD65CFdaVdzS4sjuWImHr80eK2qNpw
        24FL0TJeXuiu6I1deCFS1oR5l3stJI5rpp061jg2nslYEsQBvGw34JOG9Nqwunf6LoWGUD
        H+7QB6g8QQleVSMp+mXX65XGl4erRL8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9716D13A93;
        Wed,  2 Mar 2022 16:50:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kF1ZIlSgH2LdOwAAMHmgww
        (envelope-from <gniebler@suse.com>); Wed, 02 Mar 2022 16:50:28 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v3 02/14] btrfs: Use btrfs_for_each_slot in find_first_block_group
Date:   Wed,  2 Mar 2022 17:48:17 +0100
Message-Id: <20220302164829.17524-3-gniebler@suse.com>
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
 fs/btrfs/block-group.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 8202ad6aa131..aafd7909d0f8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1686,35 +1686,13 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
 	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	int ret;
 	struct btrfs_key found_key;
-	struct extent_buffer *leaf;
-	int slot;
-
-	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
-	if (ret < 0)
-		return ret;
-
-	while (1) {
-		slot = path->slots[0];
-		leaf = path->nodes[0];
-		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret == 0)
-				continue;
-			if (ret < 0)
-				goto out;
-			break;
-		}
-		btrfs_item_key_to_cpu(leaf, &found_key, slot);
 
+	btrfs_for_each_slot(root, key, &found_key, path, ret) {
 		if (found_key.objectid >= key->objectid &&
 		    found_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
-			ret = read_bg_from_eb(fs_info, &found_key, path);
-			break;
+			return read_bg_from_eb(fs_info, &found_key, path);
 		}
-
-		path->slots[0]++;
 	}
-out:
 	return ret;
 }
 
-- 
2.35.1

