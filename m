Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE313F657B
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 19:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbhHXRNp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 13:13:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54602 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbhHXRLn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 13:11:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BDE672008E;
        Tue, 24 Aug 2021 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629825058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HcewAwXkTEy6MBkqxno1jMapsW5umEYUWtWsy9XfZkM=;
        b=qy5eV3fz65MSDe167hwb2433bflBHvXGbIzmw7BRLtbyIiCVfNMVbEbkJCjldr3WtC6yZy
        hp6scSOxOkMTzua+VOTZCFzd8jm56GKLOpNIhmdsVQeg73SwbrO8zgIYlii3FRsPRj1HyZ
        apf7EiynLCcz+kD5FuZDdntQFMGfGK8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6384613B45;
        Tue, 24 Aug 2021 17:10:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oEpGCyEoJWGDNwAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Tue, 24 Aug 2021 17:10:57 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 4/7] btrfs: dir-item: use btrfs_for_each_slot in btrfs_search_dir_index_item
Date:   Tue, 24 Aug 2021 14:06:55 -0300
Message-Id: <20210824170658.12567-5-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210824170658.12567-1-mpdesouza@suse.com>
References: <20210824170658.12567-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function can be simplified by using the iterator like macro.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/dir-item.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index f1274d5c3805..10560663dae1 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -301,36 +301,15 @@ btrfs_search_dir_index_item(struct btrfs_root *root,
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
 
@@ -338,9 +317,9 @@ btrfs_search_dir_index_item(struct btrfs_root *root,
 					       name, name_len);
 		if (di)
 			return di;
-
-		path->slots[0]++;
 	}
+	if (ret < 0)
+		return ERR_PTR(ret);
 	return NULL;
 }
 
-- 
2.31.1

