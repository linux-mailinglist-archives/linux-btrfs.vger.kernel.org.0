Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299AC4008FC
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Sep 2021 03:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350829AbhIDBcp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 21:32:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58116 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350825AbhIDBcp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 21:32:45 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B85EC21C09
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Sep 2021 01:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630719103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zsaYO5egtCnhvHI63cRpsF54k4n7iGktt0Qc6o54QiU=;
        b=NBYO5U4q4BwmbqX72xE6a9dqYPNSUgxvVrJcGjq7y7X2MRRfulzjFuo8FX+Wi5uCvgeMQI
        /xnsupxZ5bgrzoKlAqPwH7sLl38zjVbhBsFU5TdGgNMDecawaNzJYUzjXm0BzY5RusXjN5
        B7pGfYSuHG+vSOCK0kAHONop0MOiBHE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8842513689
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Sep 2021 01:31:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 2KnUEn3MMmGKQQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Sep 2021 01:31:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs-progs: backport btrfs_check_node() from kernel
Date:   Sat,  4 Sep 2021 09:31:31 +0800
Message-Id: <20210904013131.148061-4-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904013131.148061-1-wqu@suse.com>
References: <20210904013131.148061-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs_check_node() has far less meaningful error message compared to
kernel counterpart, and it even lacks certain checks like level check.

Backport btrfs_check_node() to btrfs-progs to not only unify the code
but greatly improve the readability of the error messages.

Extra modification includes:

- No fs_info needed
  As we don't need to output fsid.

- Remove unlikely() macro

- Extra BTRFS_TREE_BLOCK_* error type

- Btrfs-progs specific error handling
  To record the corrupted tree blocks.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/ctree.c | 70 ++++++++++++++++++++++++++++++-------------
 kernel-shared/ctree.h |  1 +
 2 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 4f1c34d8020d..8f9e4b7ca8bd 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -582,41 +582,71 @@ static void generic_err(const struct extent_buffer *buf, int slot,
 
 enum btrfs_tree_block_status
 btrfs_check_node(struct btrfs_fs_info *fs_info,
-		 struct btrfs_key *parent_key, struct extent_buffer *buf)
+		 struct btrfs_key *parent_key, struct extent_buffer *node)
 {
-	int i;
-	struct btrfs_key key;
-	u32 nritems = btrfs_header_nritems(buf);
+	unsigned long nr = btrfs_header_nritems(node);
+	struct btrfs_key key, next_key;
+	int slot;
+	int level = btrfs_header_level(node);
+	u64 bytenr;
 	enum btrfs_tree_block_status ret = BTRFS_TREE_BLOCK_INVALID_NRITEMS;
 
-	if (nritems == 0 || nritems > BTRFS_NODEPTRS_PER_BLOCK(fs_info))
+	if (level <= 0 || level >= BTRFS_MAX_LEVEL) {
+		generic_err(node, 0,
+			"invalid level for node, have %d expect [1, %d]",
+			level, BTRFS_MAX_LEVEL - 1);
+		ret = BTRFS_TREE_BLOCK_INVALID_LEVEL;
 		goto fail;
+	}
+	if (nr == 0 || nr > BTRFS_NODEPTRS_PER_BLOCK(fs_info)) {
+		generic_err(node, 0,
+"corrupt node: root=%llu block=%llu, nritems too %s, have %lu expect range [1,%u]",
+			   btrfs_header_owner(node), node->start,
+			   nr == 0 ? "small" : "large", nr,
+			   BTRFS_NODEPTRS_PER_BLOCK(fs_info));
+		ret = BTRFS_TREE_BLOCK_INVALID_NRITEMS;
+		goto fail;
+	}
 
-	ret = BTRFS_TREE_BLOCK_INVALID_PARENT_KEY;
-	if (parent_key && parent_key->type) {
-		btrfs_node_key_to_cpu(buf, &key, 0);
-		if (memcmp(parent_key, &key, sizeof(key)))
+	for (slot = 0; slot < nr - 1; slot++) {
+		bytenr = btrfs_node_blockptr(node, slot);
+		btrfs_node_key_to_cpu(node, &key, slot);
+		btrfs_node_key_to_cpu(node, &next_key, slot + 1);
+
+		if (!bytenr) {
+			generic_err(node, slot,
+				"invalid NULL node pointer");
+			ret = BTRFS_TREE_BLOCK_INVALID_BLOCKPTR;
 			goto fail;
-	}
-	ret = BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
-	for (i = 0; nritems > 1 && i < nritems - 2; i++) {
-		struct btrfs_key next_key;
+		}
+		if (!IS_ALIGNED(bytenr, fs_info->sectorsize)) {
+			generic_err(node, slot,
+			"unaligned pointer, have %llu should be aligned to %u",
+				bytenr, fs_info->sectorsize);
+			ret = BTRFS_TREE_BLOCK_INVALID_BLOCKPTR;
+			goto fail;
+		}
 
-		btrfs_node_key_to_cpu(buf, &key, i);
-		btrfs_node_key_to_cpu(buf, &next_key, i + 1);
-		if (btrfs_comp_cpu_keys(&key, &next_key) >= 0)
+		if (btrfs_comp_cpu_keys(&key, &next_key) >= 0) {
+			generic_err(node, slot,
+	"bad key order, current (%llu %u %llu) next (%llu %u %llu)",
+				key.objectid, key.type, key.offset,
+				next_key.objectid, next_key.type,
+				next_key.offset);
+			ret = BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
 			goto fail;
+		}
 	}
 	return BTRFS_TREE_BLOCK_CLEAN;
 fail:
-	if (btrfs_header_owner(buf) == BTRFS_EXTENT_TREE_OBJECTID) {
+	if (btrfs_header_owner(node) == BTRFS_EXTENT_TREE_OBJECTID) {
 		if (parent_key)
 			memcpy(&key, parent_key, sizeof(struct btrfs_key));
 		else
-			btrfs_node_key_to_cpu(buf, &key, 0);
+			btrfs_node_key_to_cpu(node, &key, 0);
 		btrfs_add_corrupt_extent_record(fs_info, &key,
-						buf->start, buf->len,
-						btrfs_header_level(buf));
+						node->start, node->len,
+						btrfs_header_level(node));
 	}
 	return ret;
 }
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 5ed8e3e373fa..529f8bce2f50 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -697,6 +697,7 @@ enum btrfs_tree_block_status {
 	BTRFS_TREE_BLOCK_INVALID_LEVEL,
 	BTRFS_TREE_BLOCK_INVALID_FREE_SPACE,
 	BTRFS_TREE_BLOCK_INVALID_OFFSETS,
+	BTRFS_TREE_BLOCK_INVALID_BLOCKPTR,
 };
 
 struct btrfs_inode_item {
-- 
2.33.0

