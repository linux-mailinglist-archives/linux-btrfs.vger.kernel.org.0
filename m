Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5867070EFA1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 09:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbjEXHl4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 03:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239978AbjEXHlx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 03:41:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5358F
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 00:41:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8B08C1F8AF
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684914110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+MsLyQ9EtzC19HFwPmjq9vM57S1dbnZRsoyGE957bA=;
        b=O/trRCAo1ZgqsImBVENpYth35ynPLoskHgX/UtEoT0LqlSAirmpsjz6jguiLYEqFDx3eWO
        e7C/UDZKXkguQnEFBh98HIhUAv3K5i6AJ9aIM2kY0ZD3QzmRzWy1QQh+qodsgJuaG4tZXT
        YtAWmkVHV745iPfjvqAqVFyUFtbvi2o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2DAC13425
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +BwkK72/bWSiRQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs-progs: tune: implement resume support for generating new data csum
Date:   Wed, 24 May 2023 15:41:25 +0800
Message-Id: <2e78225fdd088219c01b45865a112204536f21f4.1684913599.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684913599.git.wqu@suse.com>
References: <cover.1684913599.git.wqu@suse.com>
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

If a csum change is interrupted at new data csum generation stage, we
can detect such situation by checking the old and new csum items.

At the new data csum generation stage, old csums are untouched, and only
new csums items (with different objectid) are inserted into the csum
tree.

Thus the old csum items should cover a larger range, while the new csum
items should be a subset of the old csums.

The resume part would start by re-generating the remaining part, then go
through the conversion stages.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 226 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 193 insertions(+), 33 deletions(-)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index 7ae618a433cb..b95a4117b59b 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -197,9 +197,9 @@ out:
  * item.
  */
 #define CSUM_CHANGE_BYTES_THRESHOLD	(SZ_2M)
-static int generate_new_data_csums(struct btrfs_fs_info *fs_info, u16 new_csum_type)
+static int generate_new_data_csums_range(struct btrfs_fs_info *fs_info, u64 start,
+					 u16 new_csum_type)
 {
-	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, 0);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_path path = { 0 };
@@ -208,7 +208,7 @@ static int generate_new_data_csums(struct btrfs_fs_info *fs_info, u16 new_csum_t
 	void *csum_buffer;
 	u64 converted_bytes = 0;
 	u64 last_csum;
-	u64 cur = 0;
+	u64 cur = start;
 	int ret;
 
 	ret = get_last_csum_bytenr(fs_info, &last_csum);
@@ -221,34 +221,6 @@ static int generate_new_data_csums(struct btrfs_fs_info *fs_info, u16 new_csum_t
 	if (!csum_buffer)
 		return -ENOMEM;
 
-	trans = btrfs_start_transaction(tree_root, 1);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		errno = -ret;
-		error("failed to start transaction: %m");
-		goto out;
-	}
-	key.objectid = BTRFS_CSUM_CHANGE_OBJECTID;
-	key.type = BTRFS_TEMPORARY_ITEM_KEY;
-	key.offset = new_csum_type;
-	ret = btrfs_insert_empty_item(trans, tree_root, &path, &key, 0);
-	btrfs_release_path(&path);
-	if (ret < 0) {
-		errno = -ret;
-		error("failed to insert csum change item: %m");
-		btrfs_abort_transaction(trans, ret);
-		goto out;
-	}
-	btrfs_set_super_flags(fs_info->super_copy,
-			      btrfs_super_flags(fs_info->super_copy) |
-			      BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM);
-	ret = btrfs_commit_transaction(trans, tree_root);
-	if (ret < 0) {
-		errno = -ret;
-		error("failed to commit the initial transaction: %m");
-		goto out;
-	}
-
 	trans = btrfs_start_transaction(csum_root,
 			CSUM_CHANGE_BYTES_THRESHOLD / fs_info->sectorsize *
 			new_csum_size);
@@ -321,6 +293,44 @@ out:
 	return ret;
 }
 
+static int generate_new_data_csums(struct btrfs_fs_info *fs_info, u16 new_csum_type)
+{
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	struct btrfs_trans_handle *trans;
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key;
+	int ret;
+
+	trans = btrfs_start_transaction(tree_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction: %m");
+		return ret;
+	}
+	key.objectid = BTRFS_CSUM_CHANGE_OBJECTID;
+	key.type = BTRFS_TEMPORARY_ITEM_KEY;
+	key.offset = new_csum_type;
+	ret = btrfs_insert_empty_item(trans, tree_root, &path, &key, 0);
+	btrfs_release_path(&path);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to insert csum change item: %m");
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+	btrfs_set_super_flags(fs_info->super_copy,
+			      btrfs_super_flags(fs_info->super_copy) |
+			      BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM);
+	ret = btrfs_commit_transaction(trans, tree_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to commit the initial transaction: %m");
+		return ret;
+	}
+	return generate_new_data_csums_range(fs_info, 0, new_csum_type);
+}
+
 static int delete_old_data_csums(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, 0);
@@ -635,6 +645,152 @@ out:
 	return ret;
 }
 
+/*
+ * Get the first and last csum items which has @objectid as their objectid.
+ *
+ * This would be called to handle data csum resume, which may have both old
+ * and new csums co-exist in the same csum tree.
+ *
+ * Return >0 if there is no such EXTENT_CSUM with given @objectid.
+ * Return 0 if there is such EXTENT_CSUM and populate @first_ret and @last_ret.
+ * Return <0 for errors.
+ */
+static int get_csum_items_range(struct btrfs_fs_info *fs_info,
+				u64 objectid, u64 *first_ret, u64 *last_ret,
+				u32 *last_item_size)
+{
+	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, 0);
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key;
+	int ret;
+
+	key.objectid = objectid;
+	key.type = BTRFS_EXTENT_CSUM_KEY;
+	key.offset = 0;
+
+	ret = btrfs_search_slot(NULL, csum_root, &key, &path, 0, 0);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to search csum tree: %m");
+		return ret;
+	}
+	if (path.slots[0] >= btrfs_header_nritems(path.nodes[0])) {
+		ret = btrfs_next_leaf(csum_root, &path);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to search csum tree: %m");
+			btrfs_release_path(&path);
+			return ret;
+		}
+		/*
+		 * There is no next leaf, meaning we didn't find any
+		 * csum item with given objectid.
+		 */
+		if (ret > 0) {
+			btrfs_release_path(&path);
+			return ret;
+		}
+	}
+
+	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+	btrfs_release_path(&path);
+	if (key.objectid != objectid)
+		return 1;
+	*first_ret = key.offset;
+
+	key.objectid = objectid;
+	key.type = BTRFS_EXTENT_CSUM_KEY;
+	key.offset = (u64)-1;
+
+	ret = btrfs_search_slot(NULL, csum_root, &key, &path, 0, 0);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to search csum tree: %m");
+		return ret;
+	}
+	assert(ret > 0);
+	ret = btrfs_previous_item(csum_root, &path, objectid,
+				  BTRFS_EXTENT_CSUM_KEY);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to search csum tree: %m");
+		btrfs_release_path(&path);
+		return ret;
+	}
+	if (ret > 0) {
+		btrfs_release_path(&path);
+		return 1;
+	}
+	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+	*last_item_size = btrfs_item_size(path.nodes[0], path.slots[0]);
+	btrfs_release_path(&path);
+	*last_ret = key.offset;
+	return 0;
+}
+
+static int resume_data_csum_change(struct btrfs_fs_info *fs_info,
+				   u16 new_csum_type)
+{
+	u64 old_csum_first;
+	u64 old_csum_last;
+	u64 new_csum_first;
+	u64 new_csum_last;
+	bool old_csum_found = false;
+	bool new_csum_found = false;
+	u32 old_last_size;
+	u32 new_last_size;
+	u64 resume_start;
+	int ret;
+
+	ret = get_csum_items_range(fs_info, BTRFS_EXTENT_CSUM_OBJECTID,
+				   &old_csum_first, &old_csum_last,
+				   &old_last_size);
+	if (ret < 0)
+		return ret;
+	if (ret == 0)
+		old_csum_found = true;
+	ret = get_csum_items_range(fs_info, BTRFS_CSUM_CHANGE_OBJECTID,
+				   &new_csum_first, &new_csum_last,
+				   &new_last_size);
+	if (ret < 0)
+		return ret;
+	if (ret == 0)
+		new_csum_found = true;
+
+	/*
+	 * Both old and new csum exist, and new csum is only a subset of the
+	 * old ones.
+	 *
+	 * This means we're still generating new data csums.
+	 */
+	if (old_csum_found && new_csum_found && old_csum_first <= new_csum_first &&
+	    old_csum_last >= new_csum_last) {
+		resume_start = new_csum_last + new_last_size /
+				btrfs_csum_type_size(new_csum_type) *
+				fs_info->sectorsize;
+		goto new_data_csums;
+	}
+
+	/* Other cases are not yet supported. */
+	return -EOPNOTSUPP;
+
+new_data_csums:
+	ret = generate_new_data_csums_range(fs_info, resume_start, new_csum_type);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to generate new data csums: %m");
+		return ret;
+	}
+	ret = delete_old_data_csums(fs_info);
+	if (ret < 0)
+		return ret;
+	ret = change_csum_objectids(fs_info);
+	if (ret < 0)
+		return ret;
+	ret = change_meta_csums(fs_info, new_csum_type);
+	return ret;
+}
+
 static int resume_csum_change(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 {
 	const u64 super_flags = btrfs_super_flags(fs_info->super_copy);
@@ -683,8 +839,12 @@ static int resume_csum_change(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 	}
 
 	if (super_flags & BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM) {
-		error("resume on data checksum changing is not yet supported");
-		return -EOPNOTSUPP;
+		ret = resume_data_csum_change(fs_info, new_csum_type);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to resume data checksum change: %m");
+		}
+		return ret;
 	}
 
 	/*
-- 
2.40.1

