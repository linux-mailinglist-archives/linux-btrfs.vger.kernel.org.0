Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C047077DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 May 2023 04:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjERCLO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 22:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjERCLK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 22:11:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD6230F9
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 19:11:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6196B226C1
        for <linux-btrfs@vger.kernel.org>; Thu, 18 May 2023 02:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684375867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jRGmQvmBY86v55suzVIa9Wtb2ilZKBf2nyp7093ql4E=;
        b=gGKnw6YPexbrXgEBc0vnqPQzXs7vDFa0SneOWkXPargrhoNKkJOvntuvf8FtOVcRwKxN/j
        hVEhTd32a6v4jeiilXje9vtixHn7GmikCNYbqr4yMXp6z88265jjz04KV47HHzq/ZSMNpm
        TcU5bJA7TsPoHGnkxtWo4C22oFFX6B8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B20FA1332D
        for <linux-btrfs@vger.kernel.org>; Thu, 18 May 2023 02:11:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ICeLHjqJZWRVJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 18 May 2023 02:11:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/7] btrfs-progs: tune: add the ability to read and verify the data before generating new checksum
Date:   Thu, 18 May 2023 10:10:41 +0800
Message-Id: <002f1672a85549a445d36d3fde0d643981efb663.1684375729.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684375729.git.wqu@suse.com>
References: <cover.1684375729.git.wqu@suse.com>
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

This patch introduces a new helper function,
read_verify_one_data_sector(), to do the data read and checksum
verification (against the old csum).

This data would be later re-used to generate a new csum.

And since we're introduce the helper function, we also build the
skeleton to iterate the data extents using the old csum tree.

This method is much better compared to iterating using extent tree,
which has no directly indicator on whether the data extent has csum or
not (nodatasum or preallocated).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 244 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index daab70b6eb4a..9d1b529e9c34 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -20,10 +20,12 @@
 #include <stdlib.h>
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
+#include "kernel-shared/volumes.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/transaction.h"
 #include "common/messages.h"
 #include "common/internal.h"
+#include "common/utils.h"
 #include "tune/tune.h"
 
 static int check_csum_change_requreiment(struct btrfs_fs_info *fs_info)
@@ -80,6 +82,242 @@ static int check_csum_change_requreiment(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
+static int get_last_csum_bytenr(struct btrfs_fs_info *fs_info, u64 *result)
+{
+	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, 0);
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key;
+	int ret;
+
+	key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
+	key.type = BTRFS_EXTENT_CSUM_KEY;
+	key.offset = (u64)-1;
+
+	ret = btrfs_search_slot(NULL, csum_root, &key, &path, 0, 0);
+	if (ret < 0)
+		return ret;
+	assert(ret > 0);
+	ret = btrfs_previous_item(csum_root, &path, BTRFS_EXTENT_CSUM_OBJECTID,
+				  BTRFS_EXTENT_CSUM_KEY);
+	if (ret < 0)
+		return ret;
+	/*
+	 * Emptry csum tree, set last csum byte to 0 so we can skip new data
+	 * csum generation.
+	 */
+	if (ret > 0) {
+		*result = 0;
+		btrfs_release_path(&path);
+		return 0;
+	}
+	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+	*result = key.offset + btrfs_item_size(path.nodes[0], path.slots[0]) /
+			       fs_info->csum_size * fs_info->sectorsize;
+	btrfs_release_path(&path);
+	return 0;
+}
+
+static int read_verify_one_data_sector(struct btrfs_fs_info *fs_info,
+				       u64 logical, void *data_buf,
+				       const void *old_csums)
+{
+	const u32 sectorsize = fs_info->sectorsize;
+	int num_copies = btrfs_num_copies(fs_info, logical, sectorsize);
+	bool found_good = false;
+
+	for (int mirror = 1; mirror <= num_copies; mirror++) {
+		u8 csum_has[BTRFS_CSUM_SIZE];
+		u64 readlen = sectorsize;
+		int ret;
+
+		ret = read_data_from_disk(fs_info, data_buf, logical, &readlen,
+					  mirror);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to read logical %llu: %m", logical);
+			continue;
+		}
+		btrfs_csum_data(fs_info, fs_info->csum_type, data_buf, csum_has,
+				sectorsize);
+		if (memcmp(csum_has, old_csums, fs_info->csum_size) == 0) {
+			found_good = true;
+			break;
+		} else {
+			char found[BTRFS_CSUM_STRING_LEN];
+			char want[BTRFS_CSUM_STRING_LEN];
+
+			btrfs_format_csum(fs_info->csum_type, old_csums, want);
+			btrfs_format_csum(fs_info->csum_type, csum_has, found);
+			error("csum mismatch for logical %llu mirror %u, has %s expected %s",
+				logical, mirror, found, want);
+		}
+	}
+	if (!found_good)
+		return -EIO;
+	return 0;
+}
+
+static int generate_new_csum_range(struct btrfs_trans_handle *trans,
+				   u64 logical, u64 length, u16 new_csum_type,
+				   const void *old_csums)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	const u32 sectorsize = fs_info->sectorsize;
+	int ret = 0;
+	void *buf;
+
+	buf = malloc(fs_info->sectorsize);
+	if (!buf)
+		return -ENOMEM;
+
+	for (u64 cur = logical; cur < logical + length; cur += sectorsize) {
+		ret = read_verify_one_data_sector(fs_info, cur, buf, old_csums +
+				(cur - logical) / sectorsize * fs_info->csum_size);
+
+		if (ret < 0) {
+			error("failed to recover a good copy for data at logical %llu",
+			      logical);
+			goto out;
+		}
+		/* Calculate new csum and insert it into the csum tree. */
+		ret = -EOPNOTSUPP;
+	}
+out:
+	free(buf);
+	return ret;
+}
+
+/*
+ * After reading this many bytes of data, commit the current transaction.
+ *
+ * Only a soft cap, we can exceed the threshold if hitting a large enough csum
+ * item.
+ */
+#define CSUM_CHANGE_BYTES_THRESHOLD	(SZ_2M)
+static int generate_new_data_csums(struct btrfs_fs_info *fs_info, u16 new_csum_type)
+{
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, 0);
+	struct btrfs_trans_handle *trans;
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key;
+	const u32 new_csum_size = btrfs_csum_type_size(new_csum_type);
+	void *csum_buffer;
+	u64 converted_bytes = 0;
+	u64 last_csum;
+	u64 cur = 0;
+	int ret;
+
+	ret = get_last_csum_bytenr(fs_info, &last_csum);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to get the last csum item: %m");
+		return ret;
+	}
+	csum_buffer = malloc(fs_info->nodesize);
+	if (!csum_buffer)
+		return -ENOMEM;
+
+	trans = btrfs_start_transaction(tree_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction: %m");
+		goto out;
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
+		goto out;
+	}
+	btrfs_set_super_flags(fs_info->super_copy,
+			      btrfs_super_flags(fs_info->super_copy) |
+			      BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM);
+	ret = btrfs_commit_transaction(trans, tree_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to commit the initial transaction: %m");
+		goto out;
+	}
+
+	trans = btrfs_start_transaction(csum_root,
+			CSUM_CHANGE_BYTES_THRESHOLD / fs_info->sectorsize *
+			new_csum_size);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction: %m");
+		return ret;
+	}
+
+	while (cur < last_csum) {
+		u64 start;
+		u64 len;
+		u32 item_size;
+
+		key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
+		key.type = BTRFS_EXTENT_CSUM_KEY;
+		key.offset = cur;
+
+		ret = btrfs_search_slot(NULL, csum_root, &key, &path, 0, 0);
+		if (ret < 0)
+			goto out;
+		if (ret > 0 && path.slots[0] >=
+			       btrfs_header_nritems(path.nodes[0])) {
+			ret = btrfs_next_leaf(csum_root, &path);
+			if (ret > 0) {
+				ret = 0;
+				btrfs_release_path(&path);
+				break;
+			}
+			if (ret < 0) {
+				btrfs_release_path(&path);
+				goto out;
+			}
+		}
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+		assert(key.offset >= cur);
+		item_size = btrfs_item_size(path.nodes[0], path.slots[0]);
+
+		start = key.offset;
+		len = item_size / fs_info->csum_size * fs_info->sectorsize;
+		read_extent_buffer(path.nodes[0], csum_buffer,
+				btrfs_item_ptr_offset(path.nodes[0], path.slots[0]),
+				item_size);
+		btrfs_release_path(&path);
+
+		ret = generate_new_csum_range(trans, start, len, new_csum_type,
+					      csum_buffer);
+		if (ret < 0)
+			goto out;
+		converted_bytes += len;
+		if (converted_bytes >= CSUM_CHANGE_BYTES_THRESHOLD) {
+			converted_bytes = 0;
+			ret = btrfs_commit_transaction(trans, csum_root);
+			if (ret < 0)
+				goto out;
+			trans = btrfs_start_transaction(csum_root,
+					CSUM_CHANGE_BYTES_THRESHOLD /
+					fs_info->sectorsize * new_csum_size);
+			if (IS_ERR(trans)) {
+				ret = PTR_ERR(trans);
+				goto out;
+			}
+		}
+		cur = start + len;
+	}
+	ret = btrfs_commit_transaction(trans, csum_root);
+out:
+	free(csum_buffer);
+	return ret;
+}
+
 int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 {
 	int ret;
@@ -96,6 +334,12 @@ int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 	 * will be a temporary item in root tree to indicate the new checksum
 	 * algo.
 	 */
+	ret = generate_new_data_csums(fs_info, new_csum_type);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to generate new data csums: %m");
+		return ret;
+	}
 
 	/* Phase 2, delete the old data csums. */
 
-- 
2.40.1

