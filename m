Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84997AED1E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 14:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbjIZMpj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 08:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbjIZMph (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 08:45:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC182EB
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 05:45:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5B3C433C8
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 12:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695732330;
        bh=iteBX5AamMjRxAi3oexLMgmW2wqiKIiyIEdIOBJPRqQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GukQ4IgxCjV1e6HQSExkUJQfTq36cvO5J5VCkT+DAtYZ1d/icVN/JrTXmGcY5aSU1
         9u30XNp0iecnG+1yqL3iESo7PdQYFa3CAJ9ujdz3Nb44kI4D/NVAJYNGFGQf4zNA1W
         a208JP3jG08zwS278WfGx+ZBM8yGivOa0lHHOOo1/jkeMVV3t5LC2GUNaIRhBnwfsy
         bcFkcJ3+mDyMehwVZRbwHT2BcO3G8ZHD81E/+xGvlFexTK0NNX+HWkQN+CVoT7wxlk
         RcY0pmXAqWdHG7AmbaW8yZtqD5FXFF0lccCistbptYypRjWjNNHVvABTVGW5iDkl6B
         0sIRgbyhpcm/A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: export comp_keys() from ctree.c as btrfs_comp_keys()
Date:   Tue, 26 Sep 2023 13:45:19 +0100
Message-Id: <bb107fab47c074a7a89f4cd92949e3262b4189ab.1695731844.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695731838.git.fdmanana@suse.com>
References: <cover.1695731838.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 fs/btrfs/ctree.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index fddf700cc1a7..f584e79c29e9 100644
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
index c685952a544c..e6d982c3ea11 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -461,6 +461,36 @@ int btrfs_bin_search(struct extent_buffer *eb, int first_slot,
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

