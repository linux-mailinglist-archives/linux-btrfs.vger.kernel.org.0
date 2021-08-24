Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B54A3F657F
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 19:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhHXRNu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 13:13:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48334 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbhHXRLu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 13:11:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 18F31220FC;
        Tue, 24 Aug 2021 17:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629825065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s7sfQD0oPGjiuW1/FkTs2WuclO+efJ7n5/7JRX7g3bI=;
        b=E1yD2+r0eL+nASKxemH05j7JCmkO5xrWFRC2qFPRdU84KR76pY0DIxWayB0ljNsEdOV4Va
        edNIFucwEt+UA4MwLc9OraO70C5kMbQEA1SQqRw3O9rJVYIB0rWt7lwW5pj5NSRD+PX/7d
        YhESkywECTJc40VWoih57RFPYF1n7Bs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6A7913B45;
        Tue, 24 Aug 2021 17:11:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MF1EHycoJWGDNwAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Tue, 24 Aug 2021 17:11:03 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 7/7] btrfs: volumes: use btrfs_for_each_slot in btrfs_read_chunk_tree
Date:   Tue, 24 Aug 2021 14:06:58 -0300
Message-Id: <20210824170658.12567-8-mpdesouza@suse.com>
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
 fs/btrfs/volumes.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d72e4e3e02b1..998838ac106c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7428,8 +7428,9 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
-	int ret;
 	int slot;
+	int iter_ret;
+	int ret = 0;
 	u64 total_dev = 0;
 	u64 last_ra_node = 0;
 
@@ -7460,22 +7461,12 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	key.objectid = BTRFS_DEV_ITEMS_OBJECTID;
 	key.offset = 0;
 	key.type = 0;
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto error;
-	while (1) {
+	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
 		struct extent_buffer *node;
 
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
+
 		/*
 		 * The nodes on level 1 are not locked but we don't need to do
 		 * that during mount time as nothing else can access the tree
@@ -7513,7 +7504,11 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 			if (ret)
 				goto error;
 		}
-		path->slots[0]++;
+	}
+
+	if (iter_ret < 0) {
+		ret = iter_ret;
+		goto error;
 	}
 
 	/*
-- 
2.31.1

