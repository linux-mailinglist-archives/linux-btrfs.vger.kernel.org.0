Return-Path: <linux-btrfs+bounces-16994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14401B8A280
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 17:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E0BB639A4
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6701C862E;
	Fri, 19 Sep 2025 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="l3vZRrsz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A9D316909;
	Fri, 19 Sep 2025 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293984; cv=none; b=bqFIl5p5cai5KGqoWbBmsQ6TW1crCT6lkSdEjQbU9nIV22XD2AmIrIUid50uQupjKQx9NzomkYZroabj9lx5z38POVyLI1UuqqjSZFgWCXlTSpNknEf/tYADw1eq/QUUIVNw9jXAKOLtGeYQnU4ZgKUlip7Xg5GVdy+BKlBJzeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293984; c=relaxed/simple;
	bh=kr6mncdEdFBhb0ayaHLcklPKxYQ73D8d02YbYGfhLLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghz/3B+eOF9ob2hWIb+hVB5LcwZmIXWZJWuPv4noAq3LAxgR5OvUJAzeWa4lwnoIVlprTby7behrlpYCk3ABcedkvJ6Z5OauM70XkyeSeWKE+iOmqUngTO10une1np95o3UswE29YZVWx6LDYwi0GDvkqym8k0tvGkJqZ4Tp0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=l3vZRrsz; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4cSwdh67Vsz9y1J;
	Fri, 19 Sep 2025 16:59:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1758293976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iy3+xtB6dCD1Wcf6/LtHwe/kyB0LTx+OrYk0SptWdFg=;
	b=l3vZRrszbzaWEgYc07P53pe2Qj1TsdNiIn8pHbg8Rt6l8WGJVpdi8fM9Kqb37X/FZ76zk1
	D7d4WynDdp/ifK59x5e8UkefxmKE/YY+NpuTPKa6Z3YUuj/PJEm3EQeNUvE3FSck8Urctz
	8OoLO8x6vqZqv0pRvcyKBlNs7qDjdSGrOgcMIaDr/O2EkY1cytI9vpuEr86kGWuYpsgcLt
	GhBMQ/h8XO8oWsZm8y3auNaZagbG94j4HpfNPQWEY4mEZWu7M0xLfaOv6HHH6PV3n/dtN8
	2CjlUU8t85LTBK0DiDCfjefk03ebmdEiEZhkSHXz1ACu0qhHZMEKp2lz3bnnew==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH 2/2] btrfs: Prefer using the __free cleanup attribute
Date: Fri, 19 Sep 2025 16:58:16 +0200
Message-ID: <20250919145816.959845-3-mssola@mssola.com>
In-Reply-To: <20250919145816.959845-1-mssola@mssola.com>
References: <20250919145816.959845-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In delayed-node.c and tree-log.c there were a couple of instances where
the __free(kfree) cleanup attribute allowed for more clear code and
safer for future changes, as they were in large functions with multiple
exit points and the end cleanup code was simply calling 'kfree' for the
ins_data variable.

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/delayed-inode.c | 14 ++++++--------
 fs/btrfs/tree-log.c      | 21 ++++++++-------------
 2 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 81577a0c601f..dbc63dc414bb 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -668,7 +668,7 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 	struct btrfs_key first_key;
 	const u32 first_data_size = first_item->data_len;
 	int total_size;
-	char *ins_data = NULL;
+	char *ins_data __free(kfree) = NULL;
 	int ret;
 	bool continuous_keys_only = false;
 
@@ -740,10 +740,9 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 
 		ins_data = kmalloc_array(batch.nr,
 					 sizeof(u32) + sizeof(struct btrfs_key), GFP_NOFS);
-		if (!ins_data) {
-			ret = -ENOMEM;
-			goto out;
-		}
+		if (!ins_data)
+			return -ENOMEM;
+
 		ins_sizes = (u32 *)ins_data;
 		ins_keys = (struct btrfs_key *)(ins_data + batch.nr * sizeof(u32));
 		batch.keys = ins_keys;
@@ -759,7 +758,7 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_insert_empty_items(trans, root, path, &batch);
 	if (ret)
-		goto out;
+		return ret;
 
 	list_for_each_entry(curr, &item_list, tree_list) {
 		char *data_ptr;
@@ -814,8 +813,7 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 		list_del(&curr->tree_list);
 		btrfs_release_delayed_item(curr);
 	}
-out:
-	kfree(ins_data);
+
 	return ret;
 }
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d6471cd33f7f..c376514cf844 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3302,7 +3302,7 @@ static inline void btrfs_remove_log_ctx(struct btrfs_root *root,
 	mutex_unlock(&root->log_mutex);
 }
 
-/* 
+/*
  * Invoked in log mutex context, or be sure there is no other task which
  * can access the list.
  */
@@ -4038,7 +4038,7 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
 				 int count)
 {
 	struct btrfs_root *log = inode->root->log_root;
-	char *ins_data = NULL;
+	char *ins_data __free(kfree) = NULL;
 	struct btrfs_item_batch batch;
 	struct extent_buffer *dst;
 	unsigned long src_offset;
@@ -4083,7 +4083,7 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_insert_empty_items(trans, log, dst_path, &batch);
 	if (ret)
-		goto out;
+		return ret;
 
 	dst = dst_path->nodes[0];
 	/*
@@ -4115,8 +4115,6 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
 
 	if (btrfs_get_first_dir_index_to_log(inode) == 0)
 		btrfs_set_first_dir_index_to_log(inode, batch.keys[0].offset);
-out:
-	kfree(ins_data);
 
 	return ret;
 }
@@ -4786,7 +4784,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 	struct btrfs_key *ins_keys;
 	u32 *ins_sizes;
 	struct btrfs_item_batch batch;
-	char *ins_data;
+	char *ins_data __free(kfree) = NULL;
 	int dst_index;
 	const bool skip_csum = (inode->flags & BTRFS_INODE_NODATASUM);
 	const u64 i_size = i_size_read(&inode->vfs_inode);
@@ -4914,7 +4912,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 					      disk_bytenr + extent_num_bytes - 1,
 					      &ordered_sums, false);
 		if (ret < 0)
-			goto out;
+			return ret;
 		ret = 0;
 
 		list_for_each_entry_safe(sums, sums_next, &ordered_sums, list) {
@@ -4924,7 +4922,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 			kfree(sums);
 		}
 		if (ret)
-			goto out;
+			return ret;
 
 add_to_batch:
 		ins_sizes[dst_index] = btrfs_item_size(src, src_slot);
@@ -4938,11 +4936,11 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 	 * so we don't need to do anything.
 	 */
 	if (batch.nr == 0)
-		goto out;
+		return 0;
 
 	ret = btrfs_insert_empty_items(trans, log, dst_path, &batch);
 	if (ret)
-		goto out;
+		return ret;
 
 	dst_index = 0;
 	for (int i = 0; i < nr; i++) {
@@ -4995,8 +4993,6 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 	}
 
 	btrfs_release_path(dst_path);
-out:
-	kfree(ins_data);
 
 	return ret;
 }
@@ -8082,4 +8078,3 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 		btrfs_end_log_trans(root);
 	free_extent_buffer(ctx.scratch_eb);
 }
-
-- 
2.51.0


