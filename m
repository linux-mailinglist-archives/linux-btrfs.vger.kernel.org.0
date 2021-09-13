Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A035E408E0B
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Sep 2021 15:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbhIMNbL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 09:31:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50736 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbhIMNSs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 09:18:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 79B431FFDA;
        Mon, 13 Sep 2021 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631539051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTfYwhYy3preHzStIUWk1Rr5+JA231Ru2Tn/uw4BtMw=;
        b=gK8/61fbHdp1hD2upojV6TH7rxbfncgmd8Y8V8x4OHcsW1xawW3Aovzk+WRIS8AH24WEgi
        0KJUSUpedmSEcnYiNcdEDt2csarT0QN1hAhAZDfKY/Kzo9jYGN5FrbfJE3TpmeRkm8V9qD
        1BKaty3y+e9vyh6m4nMRTrmh4BAQKhY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49F7C13AB4;
        Mon, 13 Sep 2021 13:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0LuCD2tPP2FNOwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 13 Sep 2021 13:17:31 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/8] btrfs-progs: Remove root argument from btrfs_fixup_low_keys
Date:   Mon, 13 Sep 2021 16:17:23 +0300
Message-Id: <20210913131729.37897-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913131729.37897-1-nborisov@suse.com>
References: <20210913131729.37897-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's not used, so just remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 check/main.c          |  5 ++---
 kernel-shared/ctree.c | 24 +++++++++++-------------
 kernel-shared/ctree.h |  4 ++--
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/check/main.c b/check/main.c
index a88518159830..6369bdd90656 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4197,8 +4197,7 @@ static int swap_values(struct btrfs_root *root, struct btrfs_path *path,
 			struct btrfs_disk_key key;
 
 			btrfs_node_key(buf, &key, 0);
-			btrfs_fixup_low_keys(root, path, &key,
-					     btrfs_header_level(buf) + 1);
+			btrfs_fixup_low_keys(path, &key, btrfs_header_level(buf) + 1);
 		}
 	} else {
 		struct btrfs_item *item1, *item2;
@@ -4302,7 +4301,7 @@ static int delete_bogus_item(struct btrfs_root *root,
 		struct btrfs_disk_key disk_key;
 
 		btrfs_item_key(buf, &disk_key, 0);
-		btrfs_fixup_low_keys(root, path, &disk_key, 1);
+		btrfs_fixup_low_keys(path, &disk_key, 1);
 	}
 	btrfs_mark_buffer_dirty(buf);
 	return 0;
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 518718de04dd..02eb975338e5 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -1437,8 +1437,8 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
  * fixing up pointers when a given leaf/node is not in slot 0 of the
  * higher levels
  */
-void btrfs_fixup_low_keys(struct btrfs_root *root, struct btrfs_path *path,
-			  struct btrfs_disk_key *key, int level)
+void btrfs_fixup_low_keys( struct btrfs_path *path, struct btrfs_disk_key *key,
+		int level)
 {
 	int i;
 	struct extent_buffer *t;
@@ -1485,7 +1485,7 @@ int btrfs_set_item_key_safe(struct btrfs_root *root, struct btrfs_path *path,
 	btrfs_set_item_key(eb, &disk_key, slot);
 	btrfs_mark_buffer_dirty(eb);
 	if (slot == 0)
-		btrfs_fixup_low_keys(root, path, &disk_key, 1);
+		btrfs_fixup_low_keys(path, &disk_key, 1);
 	return 0;
 }
 
@@ -1508,7 +1508,7 @@ void btrfs_set_item_key_unsafe(struct btrfs_root *root,
 	btrfs_set_item_key(eb, &disk_key, slot);
 	btrfs_mark_buffer_dirty(eb);
 	if (slot == 0)
-		btrfs_fixup_low_keys(root, path, &disk_key, 1);
+		btrfs_fixup_low_keys(path, &disk_key, 1);
 }
 
 /*
@@ -2184,7 +2184,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		btrfs_mark_buffer_dirty(right);
 
 	btrfs_item_key(right, &disk_key, 0);
-	btrfs_fixup_low_keys(root, path, &disk_key, 1);
+	btrfs_fixup_low_keys(path, &disk_key, 1);
 
 	/* then fixup the leaf pointer in the path */
 	if (path->slots[0] < push_items) {
@@ -2415,10 +2415,8 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 			free_extent_buffer(path->nodes[0]);
 			path->nodes[0] = right;
 			path->slots[0] = 0;
-			if (path->slots[1] == 0) {
-				btrfs_fixup_low_keys(root, path,
-						     &disk_key, 1);
-			}
+			if (path->slots[1] == 0)
+				btrfs_fixup_low_keys(path, &disk_key, 1);
 		}
 		btrfs_mark_buffer_dirty(right);
 		return ret;
@@ -2632,7 +2630,7 @@ int btrfs_truncate_item(struct btrfs_root *root, struct btrfs_path *path,
 		btrfs_set_disk_key_offset(&disk_key, offset + size_diff);
 		btrfs_set_item_key(leaf, &disk_key, slot);
 		if (slot == 0)
-			btrfs_fixup_low_keys(root, path, &disk_key, 1);
+			btrfs_fixup_low_keys(path, &disk_key, 1);
 	}
 
 	item = btrfs_item_nr(slot);
@@ -2809,7 +2807,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 	ret = 0;
 	if (slot == 0) {
 		btrfs_cpu_key_to_disk(&disk_key, cpu_key);
-		btrfs_fixup_low_keys(root, path, &disk_key, 1);
+		btrfs_fixup_low_keys(path, &disk_key, 1);
 	}
 
 	if (btrfs_leaf_free_space(leaf) < 0) {
@@ -2882,7 +2880,7 @@ int btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 		struct btrfs_disk_key disk_key;
 
 		btrfs_node_key(parent, &disk_key, 0);
-		btrfs_fixup_low_keys(root, path, &disk_key, level + 1);
+		btrfs_fixup_low_keys(path, &disk_key, level + 1);
 	}
 	btrfs_mark_buffer_dirty(parent);
 	return ret;
@@ -2982,7 +2980,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			struct btrfs_disk_key disk_key;
 
 			btrfs_item_key(leaf, &disk_key, 0);
-			btrfs_fixup_low_keys(root, path, &disk_key, 1);
+			btrfs_fixup_low_keys(path, &disk_key, 1);
 		}
 
 		/* delete the leaf if it is mostly empty */
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index f53436a7f38b..a17bf50e29b4 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -2747,8 +2747,8 @@ static inline int btrfs_next_item(struct btrfs_root *root,
 
 int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path);
 int btrfs_leaf_free_space(struct extent_buffer *leaf);
-void btrfs_fixup_low_keys(struct btrfs_root *root, struct btrfs_path *path,
-			  struct btrfs_disk_key *key, int level);
+void btrfs_fixup_low_keys(struct btrfs_path *path, struct btrfs_disk_key *key,
+		int level);
 int btrfs_set_item_key_safe(struct btrfs_root *root, struct btrfs_path *path,
 			    struct btrfs_key *new_key);
 void btrfs_set_item_key_unsafe(struct btrfs_root *root,
-- 
2.17.1

