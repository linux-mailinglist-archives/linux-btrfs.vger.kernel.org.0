Return-Path: <linux-btrfs+bounces-18986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37169C5BC94
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 08:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CFD3A552E
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 07:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBAB2F49F5;
	Fri, 14 Nov 2025 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn9JcyVh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05962E4274
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763105229; cv=none; b=ELgu66brza1myNu0lYdsNfcfDgZxQgusyhqnEiTjdoxT1RszSIeQLz+RKkFrljSUbD7k34B6KlY2v8ty5KbVCYgVQKDwNc4pUy0UTUXeQaZkPAyLPYUA36pIxvPaQyGubFv5m4sQUUemO5myxab2msEG717fP5ZFBxtfTswmTMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763105229; c=relaxed/simple;
	bh=y0a9/cIWKBys4edWntxbGaJFiyVwi6QNSY/T1ILLvSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YImqr1NT0OQlVBgZ6EXXGyIMm32VlraBReHokWekF88FP3Hf6h6F8KcqvIruJOAgf5Hvdv7zZ+9uoLWhW7YZrPmAu7luMBHhkGY6bdZh5+0vHdLvqTJR3oPPRJaHF/N+FQNxT2a85U3mr6K3VcFvqz+mPDkCI+Yq4SGBu8NtfOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn9JcyVh; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7b99c2a5208so122071b3a.3
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 23:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763105227; x=1763710027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMjTDGsOTaX1/1VOfAI7ZZspaKS/8rcaCzvbMRZ+YM8=;
        b=Nn9JcyVhqsbhLEh8uzWVjv9aAY2EShCNOkEbSzrZ/TNG2RHR51yEb3DuBBwgzo0VF9
         WWnY5/HtdKumGYgHMOJpfzPnncxmj0gXAMDRntH4YdKMIPMgHu5UsVyISBKjt8BI/g+z
         4H45/bkImc/2NjBXlheJMP4TV0PlAzjYJaRQ7eOvFS94T3S1W2Mj1tsQSvMu0A2qjM8H
         NHE0b7KOLtpnNyIDoZPSKyIXLQXCdKX8Xuni7IBTYradEvTO2bID3oUfTjbB9A67KqUn
         enxABLlQsUI+J4LH7MULCfww63Wrs9+hAgzakfWoImgQNcux4kiWnz1P2JPACeJXV65k
         pHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763105227; x=1763710027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tMjTDGsOTaX1/1VOfAI7ZZspaKS/8rcaCzvbMRZ+YM8=;
        b=PM2DGH3PkwtytjJ02aRgbefn3pyvy/EIzEMX2LjESr2BqnG5lbE9fR2rLla61yan4O
         GPGPg2SIDyf0XrYga9UuM3ZdAtmRgGuQ0AFB+wBMHRZOHvYNPmL+MAFfH1Zg2V8W7muZ
         Tq37IsIFeZV4vNjTzyRXSplE8Eq+hYOaX9cfLU+wxVorqtVz4IuSBEuUYhVgOtBNw+/M
         AMVINSdVyuJDeiCH+BQKWhjv8dGa2Gkdv7I54v+roQs3TGvrWkMaz3pa2iMN4RkM+qxx
         Q4Xdwi52IcS42kiaHhHBax6gicWYhj+OkpnNuyLfJKjsmK0N6HDBvNqsZ0NA2oNJS4I7
         rchw==
X-Gm-Message-State: AOJu0Yy3QoG6kHHIpvilwlQHSS1QING9eKY9ENHqEA9cAvzj6ooJ5+Fj
	gUo4eGZmKftxhkve9rKK17D+12yYM3+UjlW2qtOCl3LW1j30BMkres4ladLdvnpYBRegrmPA
X-Gm-Gg: ASbGncuklmx8P8DpxVHszJpORK2kIU6aQMcRDofbUp3WdCZ34SOCqVIuh6ndKGyqjbQ
	S6/1r47qFz8iShN/6ywiltvhkvhldRKaxhSbQZjUGUdH4nzQr10qmtcW3jrncg+MHTl/FsiN+ws
	oEGYNsYz7eAX1m97P6jqpdnSkylf6BqOALSXv9K+2pPhcLTYd2AM55IgXiSkYrNy1jdmBWVzbbD
	8h/Bq8C1cBPvXBlym6gaMqITs6aigJya/mWo8yyNQToYUrdoyoejaX5JGJxOz5dyWTbJUtGMNGF
	uFyMB9pqPHytO8rlUJhBQm/6Sw/WKw7K+PnHmM37UehNSWkJQ2WCjkcOPVJJ8JNLoCaVbmeMRT3
	NOD+T9qxeWVKyxWJQE06pRuqjnnl3BsWEgkiBFhgvTZrYzY9sEzheUmdOtl4qFjNXzVIzJnAYn9
	csQvLXCZlJTnjnw7746Kif9kbuTV5LscgyhSy8
X-Google-Smtp-Source: AGHT+IE9u1EwlcxO6tC1UaBQJnGAVb6/GbqIcDFAZT2eMZ6q9+MqsmVtCjHJ543oeB6jvVgrk/mHDg==
X-Received: by 2002:a05:6a20:728b:b0:250:e770:bcbb with SMTP id adf61e73a8af0-35bd6efa70fmr1264862637.2.1763105227146;
        Thu, 13 Nov 2025 23:27:07 -0800 (PST)
Received: from SaltyKitkat (160.16.142.119.v6.sakura.ne.jp. [2001:e42:102:1707:160:16:142:119])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36f42eb0esm3947084a12.13.2025.11.13.23.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 23:27:06 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 1/4] btrfs: extract root promotion logic into promote_child_to_root()
Date: Fri, 14 Nov 2025 15:24:45 +0800
Message-ID: <20251114072532.13205-2-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114072532.13205-1-sunk67188@gmail.com>
References: <20251114072532.13205-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The balance_level() function is overly long and contains a cold code path
that handles promoting a child node to root when the root has only one item.
This code has distinct logic that is clearer and more maintainable when
isolated in its own function.

No functional change.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c | 116 +++++++++++++++++++++++++++++------------------
 1 file changed, 71 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 561658aca018..2369aa8ab455 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -861,6 +861,76 @@ struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
 	return eb;
 }
 
+/*
+ * Promote a child node to become the new tree root.
+ *
+ * This helper is called during rebalancing when the root node contains only
+ * a single item (nritems == 1).  We can reduce the tree height by promoting
+ * that child to become the new root and freeing the old root node.  The path
+ * locks and references are updated accordingly.
+ *
+ * @trans: Transaction handle
+ * @root: Tree root structure to update
+ * @path: Path holding nodes and locks
+ * @level: Level of the parent (old root)
+ * @parent: The parent (old root) with exactly one item
+ *
+ * Return: 0 on success, negative errno on failure.  The transaction is aborted
+ * on critical errors.
+ */
+static noinline int promote_child_to_root(struct btrfs_trans_handle *trans,
+				    struct btrfs_root *root,
+				    struct btrfs_path *path,
+				    int level,
+				    struct extent_buffer *parent)
+{
+	struct extent_buffer *child;
+	int ret = 0;
+
+	ASSERT(btrfs_header_nritems(parent) == 1);
+
+	child = btrfs_read_node_slot(parent, 0);
+	if (IS_ERR(child))
+		return PTR_ERR(child);
+
+	btrfs_tree_lock(child);
+	ret = btrfs_cow_block(trans, root, child, parent, 0, &child,
+			      BTRFS_NESTING_COW);
+	if (ret) {
+		btrfs_tree_unlock(child);
+		free_extent_buffer(child);
+		return ret;
+	}
+
+	ret = btrfs_tree_mod_log_insert_root(root->node, child, true);
+	if (unlikely(ret < 0)) {
+		btrfs_tree_unlock(child);
+		free_extent_buffer(child);
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+	rcu_assign_pointer(root->node, child);
+
+	add_root_to_dirty_list(root);
+	btrfs_tree_unlock(child);
+
+	path->locks[level] = 0;
+	path->nodes[level] = NULL;
+	btrfs_clear_buffer_dirty(trans, parent);
+	btrfs_tree_unlock(parent);
+	/* once for the path */
+	free_extent_buffer(parent);
+
+	root_sub_used_bytes(root);
+	ret = btrfs_free_tree_block(trans, btrfs_root_id(root), parent, 0, 1);
+	/* once for the root ptr */
+	free_extent_buffer_stale(parent);
+	if (unlikely(ret < 0)) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+	return 0;
+}
 /*
  * node level balancing, used to make sure nodes are in proper order for
  * item deletion.  We balance from the top down, so we have to make sure
@@ -900,55 +970,11 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	 * by promoting the node below to a root
 	 */
 	if (!parent) {
-		struct extent_buffer *child;
-
 		if (btrfs_header_nritems(mid) != 1)
 			return 0;
 
 		/* promote the child to a root */
-		child = btrfs_read_node_slot(mid, 0);
-		if (IS_ERR(child)) {
-			ret = PTR_ERR(child);
-			goto out;
-		}
-
-		btrfs_tree_lock(child);
-		ret = btrfs_cow_block(trans, root, child, mid, 0, &child,
-				      BTRFS_NESTING_COW);
-		if (ret) {
-			btrfs_tree_unlock(child);
-			free_extent_buffer(child);
-			goto out;
-		}
-
-		ret = btrfs_tree_mod_log_insert_root(root->node, child, true);
-		if (unlikely(ret < 0)) {
-			btrfs_tree_unlock(child);
-			free_extent_buffer(child);
-			btrfs_abort_transaction(trans, ret);
-			goto out;
-		}
-		rcu_assign_pointer(root->node, child);
-
-		add_root_to_dirty_list(root);
-		btrfs_tree_unlock(child);
-
-		path->locks[level] = 0;
-		path->nodes[level] = NULL;
-		btrfs_clear_buffer_dirty(trans, mid);
-		btrfs_tree_unlock(mid);
-		/* once for the path */
-		free_extent_buffer(mid);
-
-		root_sub_used_bytes(root);
-		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
-		/* once for the root ptr */
-		free_extent_buffer_stale(mid);
-		if (unlikely(ret < 0)) {
-			btrfs_abort_transaction(trans, ret);
-			goto out;
-		}
-		return 0;
+		return promote_child_to_root(trans, root, path, level, mid);
 	}
 	if (btrfs_header_nritems(mid) >
 	    BTRFS_NODEPTRS_PER_BLOCK(fs_info) / 4)
-- 
2.51.0


