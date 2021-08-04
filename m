Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FBA3E083F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Aug 2021 20:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbhHDSts (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 14:49:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34854 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbhHDSto (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Aug 2021 14:49:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C8789201D3;
        Wed,  4 Aug 2021 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628102970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3o9BYEj6GOmieJldwceTT4Fh2sgpeOi0UtaU17AGc8E=;
        b=TfgE0JpeurFPtKeqMncUFD0zQnLon9EeaG6w2GzzQO2MHp8Ct2K8p8abAcaDNCzwMe2QBF
        cYlQLytHOHKIFQWnCpz3pUZJIC7SgsAV66PMFrt35eAUIg2wzEcH13FlmHrrHq51jWFPLx
        LLVnQon2fKptg0iVBQvxyTdOD9JL1bA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76BCA13D24;
        Wed,  4 Aug 2021 18:49:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CFMIEDnhCmGFOQAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Wed, 04 Aug 2021 18:49:29 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 5/7] btrfs: scrub: Use btrfs_find_item in scrub_enumerate_chunks
Date:   Wed,  4 Aug 2021 15:48:52 -0300
Message-Id: <20210804184854.10696-6-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210804184854.10696-1-mpdesouza@suse.com>
References: <20210804184854.10696-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Prefer btrfs_find_item instead of btrfs_search_slot, since it calls
btrfs_next_leaf if needed and checks if the item found has the same
objectid and type passed in the search key.

As result, we can remove one btrfs_key from this function.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/scrub.c | 52 +++++++++++++-----------------------------------
 1 file changed, 14 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 088641ba7a8e..008eeb502267 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3657,11 +3657,10 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	struct btrfs_root *root = fs_info->dev_root;
 	u64 length;
 	u64 chunk_offset;
+	u64 offset = 0;
 	int ret = 0;
 	int ro_set;
-	int slot;
 	struct extent_buffer *l;
-	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_block_group *cache;
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
@@ -3674,47 +3673,24 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	path->search_commit_root = 1;
 	path->skip_locking = 1;
 
-	key.objectid = scrub_dev->devid;
-	key.offset = 0ull;
-	key.type = BTRFS_DEV_EXTENT_KEY;
-
 	while (1) {
-		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-		if (ret < 0)
-			break;
-		if (ret > 0) {
-			if (path->slots[0] >=
-			    btrfs_header_nritems(path->nodes[0])) {
-				ret = btrfs_next_leaf(root, path);
-				if (ret < 0)
-					break;
-				if (ret > 0) {
-					ret = 0;
-					break;
-				}
-			} else {
-				ret = 0;
-			}
-		}
-
-		l = path->nodes[0];
-		slot = path->slots[0];
-
-		btrfs_item_key_to_cpu(l, &found_key, slot);
-
-		if (found_key.objectid != scrub_dev->devid)
+		ret = btrfs_find_item(root, path, scrub_dev->devid,
+				BTRFS_DEV_EXTENT_KEY, offset, &found_key);
+		if (ret < 0) {
 			break;
-
-		if (found_key.type != BTRFS_DEV_EXTENT_KEY)
-			break;
-
-		if (found_key.offset >= end)
+		} else if (ret > 0) {
+			/* Reset error if not found. */
+			ret = 0;
 			break;
+		}
 
-		if (found_key.offset < key.offset)
+		if (found_key.offset >= end ||
+		    found_key.offset < offset)
 			break;
 
-		dev_extent = btrfs_item_ptr(l, slot, struct btrfs_dev_extent);
+		l = path->nodes[0];
+		dev_extent = btrfs_item_ptr(l, path->slots[0],
+						struct btrfs_dev_extent);
 		length = btrfs_dev_extent_length(l, dev_extent);
 
 		if (found_key.offset + length <= start)
@@ -3938,7 +3914,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			break;
 		}
 skip:
-		key.offset = found_key.offset + length;
+		offset = found_key.offset + length;
 		btrfs_release_path(path);
 	}
 
-- 
2.31.1

