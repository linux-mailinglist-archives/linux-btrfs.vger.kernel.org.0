Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727027B0275
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 13:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjI0LJm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 07:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjI0LJl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 07:09:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A36F3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 04:09:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20988C433C8
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 11:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695812979;
        bh=YyyPLRaX/inRThsFeWmL3NyDzvZJrl9mFe2+xteW14k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fVuznosQV8cY/VA1aaGY+7stKwjr8n829yt9Bpm1pnNjenxuoNp4e9eHFKC7rmc7r
         I3XEXFOfB8mjbWQyy7J5YE/O7Po0+d9k1njvnkEK64k7137BbFHD4EZnI/pSNV3xuS
         unUeu3cT2v2jtieocKxMRt6AHCng0/1TpbKMSBkREabMLfdLY1VOrWb5CezmcIzS8V
         Iovj1B8Kl39TtAmsRjjOxGhrCbhY/5yYHBOJWlkVACMLTUNfE1lFoZ10u5K1r2LPJe
         Ahn3NH/ameC4RWqSs3redHdikR3K9n4U62o6zEwtkYElNBDkQEubesI9o7V5OIPKxk
         ZhC32fhYdJz3Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 7/8] btrfs: export comp_keys() from ctree.c as btrfs_comp_keys()
Date:   Wed, 27 Sep 2023 12:09:27 +0100
Message-Id: <222b6f1bd38e4317f1d26e47a79da563db359927.1695812791.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695812791.git.fdmanana@suse.com>
References: <cover.1695812791.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Export comp_keys() out of ctree.c, as btrfs_comp_keys(), so that in a
later patch we can move out defrag specific code from ctree.c into
defrag.c.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 44 +++++++-------------------------------------
 fs/btrfs/ctree.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 005f0e1f98b3..b25b42ebcc2b 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -743,36 +743,6 @@ static int close_blocks(u64 blocknr, u64 other, u32 blocksize)
 	return 0;
 }
 
-#ifdef __LITTLE_ENDIAN
-
-/*
- * Compare two keys, on little-endian the disk order is same as CPU order and
- * we can avoid the conversion.
- */
-static int comp_keys(const struct btrfs_disk_key *disk_key,
-		     const struct btrfs_key *k2)
-{
-	const struct btrfs_key *k1 = (const struct btrfs_key *)disk_key;
-
-	return btrfs_comp_cpu_keys(k1, k2);
-}
-
-#else
-
-/*
- * compare two keys in a memcmp fashion
- */
-static int comp_keys(const struct btrfs_disk_key *disk,
-		     const struct btrfs_key *k2)
-{
-	struct btrfs_key k1;
-
-	btrfs_disk_key_to_cpu(&k1, disk);
-
-	return btrfs_comp_cpu_keys(&k1, k2);
-}
-#endif
-
 /*
  * same as comp_keys only with two btrfs_key's
  */
@@ -845,7 +815,7 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 		int close = 1;
 
 		btrfs_node_key(parent, &disk_key, i);
-		if (!progress_passed && comp_keys(&disk_key, progress) < 0)
+		if (!progress_passed && btrfs_comp_keys(&disk_key, progress) < 0)
 			continue;
 
 		progress_passed = 1;
@@ -958,7 +928,7 @@ int btrfs_bin_search(struct extent_buffer *eb, int first_slot,
 			tmp = &unaligned;
 		}
 
-		ret = comp_keys(tmp, key);
+		ret = btrfs_comp_keys(tmp, key);
 
 		if (ret < 0)
 			low = mid + 1;
@@ -1995,7 +1965,7 @@ static int search_leaf(struct btrfs_trans_handle *trans,
 			 * the extent buffer's header and we have recently accessed
 			 * the header's level field.
 			 */
-			ret = comp_keys(&first_key, key);
+			ret = btrfs_comp_keys(&first_key, key);
 			if (ret < 0) {
 				/*
 				 * The first key is smaller than the key we want
@@ -2504,7 +2474,7 @@ static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 	 */
 	if (path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
 		btrfs_item_key(path->nodes[0], &found_key, path->slots[0]);
-		ret = comp_keys(&found_key, &orig_key);
+		ret = btrfs_comp_keys(&found_key, &orig_key);
 		if (ret == 0) {
 			if (path->slots[0] > 0) {
 				path->slots[0]--;
@@ -2519,7 +2489,7 @@ static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 	}
 
 	btrfs_item_key(path->nodes[0], &found_key, 0);
-	ret = comp_keys(&found_key, &key);
+	ret = btrfs_comp_keys(&found_key, &key);
 	/*
 	 * We might have had an item with the previous key in the tree right
 	 * before we released our path. And after we released our path, that
@@ -2710,7 +2680,7 @@ void btrfs_set_item_key_safe(struct btrfs_trans_handle *trans,
 	slot = path->slots[0];
 	if (slot > 0) {
 		btrfs_item_key(eb, &disk_key, slot - 1);
-		if (unlikely(comp_keys(&disk_key, new_key) >= 0)) {
+		if (unlikely(btrfs_comp_keys(&disk_key, new_key) >= 0)) {
 			btrfs_print_leaf(eb);
 			btrfs_crit(fs_info,
 		"slot %u key (%llu %u %llu) new key (%llu %u %llu)",
@@ -2724,7 +2694,7 @@ void btrfs_set_item_key_safe(struct btrfs_trans_handle *trans,
 	}
 	if (slot < btrfs_header_nritems(eb) - 1) {
 		btrfs_item_key(eb, &disk_key, slot + 1);
-		if (unlikely(comp_keys(&disk_key, new_key) <= 0)) {
+		if (unlikely(btrfs_comp_keys(&disk_key, new_key) <= 0)) {
 			btrfs_print_leaf(eb);
 			btrfs_crit(fs_info,
 		"slot %u key (%llu %u %llu) new key (%llu %u %llu)",
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c685952a544c..7b69abb5009c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -9,6 +9,7 @@
 #include <linux/pagemap.h>
 #include "locking.h"
 #include "fs.h"
+#include "accessors.h"
 
 struct btrfs_trans_handle;
 struct btrfs_transaction;
@@ -461,6 +462,36 @@ int btrfs_bin_search(struct extent_buffer *eb, int first_slot,
 		     const struct btrfs_key *key, int *slot);
 
 int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
+
+#ifdef __LITTLE_ENDIAN
+
+/*
+ * Compare two keys, on little-endian the disk order is same as CPU order and
+ * we can avoid the conversion.
+ */
+static inline int btrfs_comp_keys(const struct btrfs_disk_key *disk_key,
+				  const struct btrfs_key *k2)
+{
+	const struct btrfs_key *k1 = (const struct btrfs_key *)disk_key;
+
+	return btrfs_comp_cpu_keys(k1, k2);
+}
+
+#else
+
+/* Compare two keys in a memcmp fashion. */
+static inline int btrfs_comp_keys(const struct btrfs_disk_key *disk,
+				  const struct btrfs_key *k2)
+{
+	struct btrfs_key k1;
+
+	btrfs_disk_key_to_cpu(&k1, disk);
+
+	return btrfs_comp_cpu_keys(&k1, k2);
+}
+
+#endif
+
 int btrfs_previous_item(struct btrfs_root *root,
 			struct btrfs_path *path, u64 min_objectid,
 			int type);
-- 
2.40.1

