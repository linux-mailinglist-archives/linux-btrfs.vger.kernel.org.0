Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C70C1794E1
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 17:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbgCDQSs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 11:18:48 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43887 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388282AbgCDQSr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Mar 2020 11:18:47 -0500
Received: by mail-qv1-f67.google.com with SMTP id eb12so1021207qvb.10
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 08:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qChTNs5PQFgZpYfNDpPgq1Z7ZD8K2qPiNyh8Z2WttIM=;
        b=BxB7DSzUZnOF1sWWAyFsREA6BvOaUYX21CesNPXk9ZBolr1QCmwFc39sWTZS++1ypI
         mtV1vMnMZQSz903/7Or66t8ianqacysg0UfruNvEGKIX95ebFYcNZF6Bs2zez73t2/7D
         PkEzRCy3rKARUch6yZ3Rcm5JftSPt3/oNEYc0BpUeEub36q3xkvxoDJY+oFMS+SSxr/f
         NvBg0pCSPXIBfiuxCvyOmXTFhr09+28tFyT3tzJZZn2SOn9svbazPlr+zlfQfmpb3Phx
         piWfqFCVnLS5q6IIJXSnoKXYVARH17SG3nVNZWf1kmkEfLZ9iK0Hf1qvueJhmgV+xkoh
         7wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qChTNs5PQFgZpYfNDpPgq1Z7ZD8K2qPiNyh8Z2WttIM=;
        b=Sim61vjXlQubSjsvkI1RVeKFk1+8UAN6UdK0DKqo/3JGkCt+AUzTumHL3MD191/4cW
         /GsyPfTDFQM3d5gGUrnMgiT91SCAZwgxP7/93LLOUwUJ1T3XSgOrfmR8aPmGqU6SmLGm
         LDNor66wC+N067NCD+SDYBZHb6c5qVm9sTGQQOTe4mvJhcqoagVgS6RT42RT7n3IJyyX
         +dyOj+g5Yt/ISutgGs5ZIed7M5B6CNY/gdEx/9QbiHROVkY6pxQixTuEPhz9kWCHEs1U
         aGU7W9auYBpAKw/3lKMT/jRqZPXu2ukmgIqgJC57t+acKxIrPscJyYxgHwgjFJps4Dfn
         gVlw==
X-Gm-Message-State: ANhLgQ1hsMKr4x9vFfcTcWK+mQvggqA+sbGa/feOho3zN90Kgob8SaUF
        QJsgQMMP0VBFxWNXWvd23PFtnly59qg=
X-Google-Smtp-Source: ADFU+vt8BH+9N2Xf8yMfCQr7RGYeZqtTE/RHI2/1Kno690IoK2MX76x3SsLvXIFi8Nw4v4SIfZdPkg==
X-Received: by 2002:a0c:9081:: with SMTP id p1mr536732qvp.38.1583338725157;
        Wed, 04 Mar 2020 08:18:45 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t29sm14945942qtt.20.2020.03.04.08.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:18:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/8] btrfs: hold a ref on the root->reloc_root
Date:   Wed,  4 Mar 2020 11:18:29 -0500
Message-Id: <20200304161830.2360-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304161830.2360-1-josef@toxicpanda.com>
References: <20200304161830.2360-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We previously were relying on root->reloc_root to be cleaned up by the
drop snapshot, or the error handling.  However if btrfs_drop_snapshot()
failed it wouldn't drop the ref for the root.  Also we sort of depend on
the right thing to happen with moving reloc roots between lists and the
fs root they belong to, which makes it hard to figure out who owns the
reference.

Fix this by explicitly holding a reference on the reloc root for
roo->reloc_root.  This means that we hold two references on reloc roots,
one for whichever reloc_roots list it's attached to, and the
root->reloc_root we're on.

This makes it easier to reason out who owns a reference on the root, and
when it needs to be dropped.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 59 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ceb90d152cdd..0f19a22d7f44 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1384,6 +1384,7 @@ static void __del_reloc_root(struct btrfs_root *root)
 	struct rb_node *rb_node;
 	struct mapping_node *node = NULL;
 	struct reloc_control *rc = fs_info->reloc_ctl;
+	bool put_ref = false;
 
 	if (rc && root->node) {
 		spin_lock(&rc->reloc_root_tree.lock);
@@ -1399,9 +1400,22 @@ static void __del_reloc_root(struct btrfs_root *root)
 		BUG_ON((struct btrfs_root *)node->data != root);
 	}
 
+	/*
+	 * We only put the reloc root here if it's on the list.  There's a lot
+	 * of places where the pattern is to splice the rc->reloc_roots, process
+	 * the reloc roots, and then add the reloc root back onto
+	 * rc->reloc_roots.  If we call __del_reloc_root while it's off of the
+	 * list we don't want the reference being dropped, because the guy
+	 * messing with the list is in charge of the reference.
+	 */
 	spin_lock(&fs_info->trans_lock);
-	list_del_init(&root->root_list);
+	if (!list_empty(&root->root_list)) {
+		put_ref = true;
+		list_del_init(&root->root_list);
+	}
 	spin_unlock(&fs_info->trans_lock);
+	if (put_ref)
+		btrfs_put_root(root);
 	kfree(node);
 }
 
@@ -1516,6 +1530,9 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 /*
  * create reloc tree for a given fs tree. reloc tree is just a
  * snapshot of the fs tree with special root objectid.
+ *
+ * The reloc_root comes out of here with two references, one for
+ * root->reloc_root, and another for being on the rc->reloc_roots list.
  */
 int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root)
@@ -1555,7 +1572,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 
 	ret = __add_reloc_root(reloc_root);
 	BUG_ON(ret < 0);
-	root->reloc_root = reloc_root;
+	root->reloc_root = btrfs_grab_root(reloc_root);
 	return 0;
 }
 
@@ -1576,6 +1593,13 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	reloc_root = root->reloc_root;
 	root_item = &reloc_root->root_item;
 
+	/*
+	 * We are probably ok here, but __del_reloc_root() will drop its ref of
+	 * the root.  We have the ref fro root->reloc_root, but just in case
+	 * hold it while we update the reloc root.
+	 */
+	btrfs_grab_root(reloc_root);
+
 	/* root->reloc_root will stay until current relocation finished */
 	if (fs_info->reloc_ctl->merge_reloc_tree &&
 	    btrfs_root_refs(root_item) == 0) {
@@ -1597,7 +1621,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	ret = btrfs_update_root(trans, fs_info->tree_root,
 				&reloc_root->root_key, root_item);
 	BUG_ON(ret);
-
+	btrfs_put_root(reloc_root);
 out:
 	return 0;
 }
@@ -2297,19 +2321,28 @@ static int clean_dirty_subvols(struct reloc_control *rc)
 			 */
 			smp_wmb();
 			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
-
 			if (reloc_root) {
-
+				/*
+				 * btrfs_drop_snapshot drops our ref we hold for
+				 * ->reloc_root.  If it fails however we must
+				 * drop the ref ourselves.
+				 */
 				ret2 = btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
-				if (ret2 < 0 && !ret)
-					ret = ret2;
+				if (ret2 < 0) {
+					btrfs_put_root(reloc_root);
+					if (!ret)
+						ret = ret2;
+				}
 			}
 			btrfs_put_root(root);
 		} else {
 			/* Orphan reloc tree, just clean it up */
 			ret2 = btrfs_drop_snapshot(root, NULL, 0, 1);
-			if (ret2 < 0 && !ret)
-				ret = ret2;
+			if (ret2 < 0) {
+				btrfs_put_root(root);
+				if (!ret)
+					ret = ret2;
+			}
 		}
 	}
 	return ret;
@@ -4698,7 +4731,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 		err = __add_reloc_root(reloc_root);
 		BUG_ON(err < 0); /* -ENOMEM or logic error */
-		fs_root->reloc_root = reloc_root;
+		fs_root->reloc_root = btrfs_grab_root(reloc_root);
 		btrfs_put_root(fs_root);
 	}
 
@@ -4888,6 +4921,10 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pending_snapshot *pending,
 /*
  * called after snapshot is created. migrate block reservation
  * and create reloc root for the newly created snapshot
+ *
+ * This is similar to btrfs_init_reloc_root(), we come out of here with two
+ * references held on the reloc_root, one for root->reloc_root and one for
+ * rc->reloc_roots.
  */
 int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 			       struct btrfs_pending_snapshot *pending)
@@ -4920,7 +4957,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 
 	ret = __add_reloc_root(reloc_root);
 	BUG_ON(ret < 0);
-	new_root->reloc_root = reloc_root;
+	new_root->reloc_root = btrfs_grab_root(reloc_root);
 
 	if (rc->create_reloc_tree)
 		ret = clone_backref_node(trans, rc, root, reloc_root);
-- 
2.24.1

