Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98573FEE67
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 15:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344999AbhIBNJt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 09:09:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33938 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344953AbhIBNJt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 09:09:49 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 125981FF97
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Sep 2021 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630588130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RF/tLN7YLAJWd3MwCeHOOHVCYD6DmYR2luSvSVhQbtY=;
        b=Fd1U549atT2Bbtn46vkB+0EUnzcf1Yw82LA3EUsq5WwgOsjq+nArE7+UcthcRk2YRvrij2
        wnTOXQyoYZ05zepDItaO77W75lFu8350QmNTTrhNMWhWLYjTVhQQDO/pMUThLm8Ajcdw9U
        GaxJziWvjB9ZWfmCJuzdh6ktaobSns4=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4990913712
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Sep 2021 13:08:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 2NLFAuHMMGEsEAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Sep 2021 13:08:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: backport btrfs_check_leaf() from kernel
Date:   Thu,  2 Sep 2021 21:08:42 +0800
Message-Id: <20210902130843.120176-3-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210902130843.120176-1-wqu@suse.com>
References: <20210902130843.120176-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_check_leaf() provides almost meaningless messages for
things like invalid item offset:

  incorrect offsets 8492 3707786077

While kernel tree-checker is doing a way better job, so it's wise to
backport btrfs_check_leaf() from kernel.

There are some modification needed:

- New generic_err() helper

- Remove unlikely() macro

- Remove empty essential tree check
  Mkfs still needs to create empty essential trees.

- Using BTRFS_TREE_BLOCK_* return value
  Original mode check still relies on them to do certain repair.

- No need for btrfs_fs_info
  We no longer needs fsid output, thus no need for btrfs_fs_info.

- No item contents check

- Still using the fail: label for btrfs-progs specific error handling

The new output looks like:

  corrupt leaf: root=2 block=72164753408 slot=109, unexpected item end, have 3707786077 expect 8492

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/ctree.c | 152 +++++++++++++++++++++++++-----------------
 1 file changed, 90 insertions(+), 62 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index c015c4f879c1..b53107d5a84e 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -566,6 +566,20 @@ static inline unsigned int leaf_data_end(const struct btrfs_fs_info *fs_info,
 	return btrfs_item_offset_nr(leaf, nr - 1);
 }
 
+static void generic_err(const struct extent_buffer *buf, int slot,
+			const char *fmt, ...)
+{
+	va_list args;
+
+	fprintf(stderr, "corrupt %s: root=%lld block=%llu slot=%d, ",
+		btrfs_header_level(buf) == 0 ? "leaf": "node",
+		btrfs_header_owner(buf), btrfs_header_bytenr(buf), slot);
+	va_start(args, fmt);
+	vfprintf(stderr, fmt, args);
+	va_end(args);
+	fprintf(stderr, "\n");
+}
+
 enum btrfs_tree_block_status
 btrfs_check_node(struct btrfs_fs_info *fs_info,
 		 struct btrfs_key *parent_key, struct extent_buffer *buf)
@@ -609,100 +623,114 @@ fail:
 
 enum btrfs_tree_block_status
 btrfs_check_leaf(struct btrfs_fs_info *fs_info,
-		 struct btrfs_key *parent_key, struct extent_buffer *buf)
+		 struct btrfs_key *parent_key, struct extent_buffer *leaf)
 {
-	int i;
+	/* No valid key type is 0, so all key should be larger than this key */
+	struct btrfs_key prev_key = {0, 0, 0};
 	struct btrfs_key key;
-	u32 nritems = btrfs_header_nritems(buf);
-	enum btrfs_tree_block_status ret = BTRFS_TREE_BLOCK_INVALID_NRITEMS;
-
-	if (nritems * sizeof(struct btrfs_item) > buf->len)  {
-		fprintf(stderr, "invalid number of items %llu\n",
-			(unsigned long long)buf->start);
-		goto fail;
-	}
+	u32 nritems = btrfs_header_nritems(leaf);
+	int slot;
+	int ret;
 
-	if (btrfs_header_level(buf) != 0) {
+	if (btrfs_header_level(leaf) != 0) {
+		generic_err(leaf, 0,
+			"invalid level for leaf, have %d expect 0",
+			btrfs_header_level(leaf));
 		ret = BTRFS_TREE_BLOCK_INVALID_LEVEL;
-		fprintf(stderr, "leaf is not a leaf %llu\n",
-		       (unsigned long long)btrfs_header_bytenr(buf));
-		goto fail;
-	}
-	if (btrfs_leaf_free_space(buf) < 0) {
-		ret = BTRFS_TREE_BLOCK_INVALID_FREE_SPACE;
-		fprintf(stderr, "leaf free space incorrect %llu %d\n",
-			(unsigned long long)btrfs_header_bytenr(buf),
-			btrfs_leaf_free_space(buf));
 		goto fail;
 	}
 
 	if (nritems == 0)
-		return BTRFS_TREE_BLOCK_CLEAN;
-
-	btrfs_item_key_to_cpu(buf, &key, 0);
-	if (parent_key && parent_key->type &&
-	    memcmp(parent_key, &key, sizeof(key))) {
-		ret = BTRFS_TREE_BLOCK_INVALID_PARENT_KEY;
-		fprintf(stderr, "leaf parent key incorrect %llu\n",
-		       (unsigned long long)btrfs_header_bytenr(buf));
-		goto fail;
-	}
-	for (i = 0; nritems > 1 && i < nritems - 1; i++) {
-		struct btrfs_key next_key;
-
-		btrfs_item_key_to_cpu(buf, &key, i);
-		btrfs_item_key_to_cpu(buf, &next_key, i + 1);
+		return 0;
 
-		if (btrfs_comp_cpu_keys(&key, &next_key) >= 0) {
+	/*
+	 * Check the following things to make sure this is a good leaf, and
+	 * leaf users won't need to bother with similar sanity checks:
+	 *
+	 * 1) key ordering
+	 * 2) item offset and size
+	 *    No overlap, no hole, all inside the leaf.
+	 * 3) item content
+	 *    If possible, do comprehensive sanity check.
+	 *    NOTE: All checks must only rely on the item data itself.
+	 */
+	for (slot = 0; slot < nritems; slot++) {
+		u32 item_end_expected;
+
+		btrfs_item_key_to_cpu(leaf, &key, slot);
+
+		/* Make sure the keys are in the right order */
+		if (btrfs_comp_cpu_keys(&prev_key, &key) >= 0) {
+			generic_err(leaf, slot,
+	"bad key order, prev (%llu %u %llu) current (%llu %u %llu)",
+				prev_key.objectid, prev_key.type,
+				prev_key.offset, key.objectid, key.type,
+				key.offset);
 			ret = BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
-			fprintf(stderr, "bad key ordering %d %d\n", i, i+1);
 			goto fail;
 		}
-		if (btrfs_item_offset_nr(buf, i) !=
-			btrfs_item_end_nr(buf, i + 1)) {
+
+		/*
+		 * Make sure the offset and ends are right, remember that the
+		 * item data starts at the end of the leaf and grows towards the
+		 * front.
+		 */
+		if (slot == 0)
+			item_end_expected = BTRFS_LEAF_DATA_SIZE(fs_info);
+		else
+			item_end_expected = btrfs_item_offset_nr(leaf,
+								 slot - 1);
+		if (btrfs_item_end_nr(leaf, slot) != item_end_expected) {
+			generic_err(leaf, slot,
+				"unexpected item end, have %u expect %u",
+				btrfs_item_end_nr(leaf, slot),
+				item_end_expected);
 			ret = BTRFS_TREE_BLOCK_INVALID_OFFSETS;
-			fprintf(stderr, "incorrect offsets %u %u\n",
-				btrfs_item_offset_nr(buf, i),
-				btrfs_item_end_nr(buf, i + 1));
 			goto fail;
 		}
-		if (i == 0 && btrfs_item_end_nr(buf, i) !=
+
+		/*
+		 * Check to make sure that we don't point outside of the leaf,
+		 * just in case all the items are consistent to each other, but
+		 * all point outside of the leaf.
+		 */
+		if (btrfs_item_end_nr(leaf, slot) >
 		    BTRFS_LEAF_DATA_SIZE(fs_info)) {
+			generic_err(leaf, slot,
+			"slot end outside of leaf, have %u expect range [0, %u]",
+				btrfs_item_end_nr(leaf, slot),
+				BTRFS_LEAF_DATA_SIZE(fs_info));
 			ret = BTRFS_TREE_BLOCK_INVALID_OFFSETS;
-			fprintf(stderr, "bad item end %u wanted %u\n",
-				btrfs_item_end_nr(buf, i),
-				(unsigned)BTRFS_LEAF_DATA_SIZE(fs_info));
 			goto fail;
 		}
-	}
 
-	for (i = 0; i < nritems; i++) {
-		if (btrfs_item_end_nr(buf, i) >
-				BTRFS_LEAF_DATA_SIZE(fs_info)) {
-			struct btrfs_disk_key disk_key;
-
-			btrfs_item_key(buf, &disk_key, 0);
-			btrfs_print_key(&disk_key);
-			fflush(stdout);
+		/* Also check if the item pointer overlaps with btrfs item. */
+		if (btrfs_item_ptr_offset(leaf, slot) <
+		    btrfs_item_nr_offset(slot) + sizeof(struct btrfs_item)) {
+			generic_err(leaf, slot,
+		"slot overlaps with its data, item end %lu data start %lu",
+				btrfs_item_nr_offset(slot) +
+				sizeof(struct btrfs_item),
+				btrfs_item_ptr_offset(leaf, slot));
 			ret = BTRFS_TREE_BLOCK_INVALID_OFFSETS;
-			fprintf(stderr, "slot end outside of leaf %llu > %llu\n",
-				(unsigned long long)btrfs_item_end_nr(buf, i),
-				(unsigned long long)BTRFS_LEAF_DATA_SIZE(
-					fs_info));
 			goto fail;
 		}
+
+		prev_key.objectid = key.objectid;
+		prev_key.type = key.type;
+		prev_key.offset = key.offset;
 	}
 
 	return BTRFS_TREE_BLOCK_CLEAN;
 fail:
-	if (btrfs_header_owner(buf) == BTRFS_EXTENT_TREE_OBJECTID) {
+	if (btrfs_header_owner(leaf) == BTRFS_EXTENT_TREE_OBJECTID) {
 		if (parent_key)
 			memcpy(&key, parent_key, sizeof(struct btrfs_key));
 		else
-			btrfs_item_key_to_cpu(buf, &key, 0);
+			btrfs_item_key_to_cpu(leaf, &key, 0);
 
 		btrfs_add_corrupt_extent_record(fs_info, &key,
-						buf->start, buf->len, 0);
+						leaf->start, leaf->len, 0);
 	}
 	return ret;
 }
-- 
2.33.0

