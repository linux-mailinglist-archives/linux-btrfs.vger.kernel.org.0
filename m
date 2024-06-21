Return-Path: <linux-btrfs+bounces-5899-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60972913056
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jun 2024 00:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D081F2448B
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 22:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0943816F0EC;
	Fri, 21 Jun 2024 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ZyAh5Wsx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JAcd3TV2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A96208C4
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719009135; cv=none; b=kR9/h2IMJ/qmIe8nFa6/B6S/9gBelXvqj1n/GQ6/Zv2xtyLZ5cy6EfAtEwkBwiVCkb4rc3/VZj9bmH/bVuWNe8FPfApsFvpi5vnnhmAKmSaX2uVd8o//03C0N9Frwm03WWBG1DY72tKY/LZ9sho+4RZmYlrTPAuaxauFZQ0qsJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719009135; c=relaxed/simple;
	bh=K/xZySVu2adRLtjLU3p+plTj8cnT8KLq0XlRkjwZFE4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hMrIYWwngSR72sn6QylJtFyYRGHG/hDIbXOdA7+K+kWVtQS1iyVzwIbm8g9YP3bqweDUX3tnKH9yhmpHCJTINwDcPg9QdjGOYlLE0u+rsLckOe8yB5j9g4xf7AJ4dZvdb/+iOCooxtB8Vq+7JBIMuJ1nnAR4xngXr0nkVYz2Kho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ZyAh5Wsx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JAcd3TV2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 07B1013800B8;
	Fri, 21 Jun 2024 18:32:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 21 Jun 2024 18:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1719009132; x=1719095532; bh=QZWdeEHl1EpJ9XALOoMK1
	3KgiEhQ7bfsxfIHoNyFW5c=; b=ZyAh5WsxBbsLcnxmo9+v4MPHqEcAb/co4kj58
	0lt1D9J51F/pQv7X+VPWcwCU/79TzecSnNtMALaR2Be7nvBdE2GHab8Y2kPfazGF
	2T+5FhPjbTuyzs3VYYcXbMZTOzZDnAeYZuZ8ZRkhns03JvEhfDMWq98XOz05fIBc
	Iz82IwVCxLOEED5KWPThlvMCPqliJAOucWfqXhnlVDAQBtcxprQs+Qx5xtrgWdO6
	zKjyx49HXvhE6kfz+cEydrgKK4x9vYFJQnefiv3CTAjn6GD4M1wdx6M1hvjKBnZN
	RdeN5Q4EYTR+xA8MUdgGyQWT22EpvrJee3QryFns3IFkDqS4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719009132; x=1719095532; bh=QZWdeEHl1EpJ9XALOoMK13KgiEhQ
	7bfsxfIHoNyFW5c=; b=JAcd3TV2cItd3FeoXlvfZB51csMohNqvw2CamLZDNA0C
	CyqXYcjXbusp+zFs2cysdPN7v48ix+3UvKTBBvXXNhWqTjY03ZjenVHC7qpeHsAU
	IqLMqIaPTVyVub+NI4nQLb8nqZOhhu8qYUta6zWs9s7+Y/RrkmOOAHRzHbpsUPtm
	6vO1Km6OxQpP/6lHBBLWjGMAyIE+3Nb9Tx7sQpnMv3y3amFBgZdnMCbqxlc61ntM
	QbbRKjY7E2PUd0iBF61ygDq56AfaOEa8Ev+AOWKeKutx8PTZgYvOf/kD0fIEOmar
	1Hoaw8s7T2QNCnDSSDDtpl+SaG0sOHmIHfd8IMvhSw==
X-ME-Sender: <xms:a_91ZvcwHAgVfGKX6rYC6gCICmOEN_DO_a1Tyn8OJgyeafVX_b4rPw>
    <xme:a_91ZlPfqGUnF-An1z5TZPGyvyIhBtNggUKnTaFDoZxwJVLDIkNa10ftrBL2JJBwN
    S1W485ZN1EUABHM-4c>
X-ME-Received: <xmr:a_91ZogAcNMUFVzESLJ71KXotVuf9jI6-SoGxxSuUl472LvLJiHM04DjxuissH5WpeA6liDs0dNym-Af9BIrCuIesWU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefhedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:a_91Zg_WbVn4fUs66Rf04NNcGuLdGroeY6fn8VhZ_4Auu6fTGgsyYg>
    <xmx:a_91ZrtiLVa7oBnVBgypMFdm2tAcZVa0Rv-CPr_CL5b_Btfh8OE25Q>
    <xmx:a_91ZvGnUScckbSihHsIysABbJsiQqiCxyZQqvbhUq-Gt-pO_00aLg>
    <xmx:a_91ZiOZcF1tGZDwnkpm0Lf_eSHqZWItKOJEkof49l1T-9RJvIRnPQ>
    <xmx:a_91Zk7s_XKuOkJ96SpaKeakVGhjeem5FITiPq1bNVBGpymSs1y_hlKL>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jun 2024 18:32:11 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: preallocate ulist memory for qgroup rsv
Date: Fri, 21 Jun 2024 15:31:36 -0700
Message-ID: <353894f3538d150605f0f28636249c332c1bd84a.1719009048.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When qgroups are enabled, during data reservation, we allocate the
ulist_nodes that track the exact reserved extents with GFP_ATOMIC
unconditionally. This is unnecessary, and we can follow the model
already employed by the struct extent_state we preallocate in the non
qgroups case, which should reduce the risk of allocation failures with
GFP_ATOMIC.

Add a prealloc node to struct ulist which ulist_add will grab when it is
present, and try to allocate it before taking the tree lock while we can
still take advantage of a less strict gfp mask. The lifetime of that
node belongs to the new prealloc field, until it is used, at which point
it belongs to the ulist linked list.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent-io-tree.c |  4 ++++
 fs/btrfs/extent_io.h      |  5 +++++
 fs/btrfs/ulist.c          | 21 ++++++++++++++++++---
 fs/btrfs/ulist.h          |  2 ++
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index ed2cfc3d5d8a..c54c5d7a5cd5 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -4,6 +4,7 @@
 #include <trace/events/btrfs.h>
 #include "messages.h"
 #include "ctree.h"
+#include "extent_io.h"
 #include "extent-io-tree.h"
 #include "btrfs_inode.h"
 
@@ -1084,6 +1085,9 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		 */
 		prealloc = alloc_extent_state(mask);
 	}
+	/* Optimistically preallocate the extent changeset ulist node. */
+	if (changeset)
+		extent_changeset_prealloc(changeset, mask);
 
 	spin_lock(&tree->lock);
 	if (cached_state && *cached_state) {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 96c6bbdcd5d6..8b33cfea6b75 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -215,6 +215,11 @@ static inline struct extent_changeset *extent_changeset_alloc(void)
 	return ret;
 }
 
+static inline void extent_changeset_prealloc(struct extent_changeset *changeset, gfp_t gfp_mask)
+{
+	ulist_prealloc(&changeset->range_changed, gfp_mask);
+}
+
 static inline void extent_changeset_release(struct extent_changeset *changeset)
 {
 	if (!changeset)
diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
index 183863f4bfa4..f35d3e93996b 100644
--- a/fs/btrfs/ulist.c
+++ b/fs/btrfs/ulist.c
@@ -50,6 +50,7 @@ void ulist_init(struct ulist *ulist)
 	INIT_LIST_HEAD(&ulist->nodes);
 	ulist->root = RB_ROOT;
 	ulist->nnodes = 0;
+	ulist->prealloc = NULL;
 }
 
 /*
@@ -68,6 +69,8 @@ void ulist_release(struct ulist *ulist)
 	list_for_each_entry_safe(node, next, &ulist->nodes, list) {
 		kfree(node);
 	}
+	kfree(ulist->prealloc);
+	ulist->prealloc = NULL;
 	ulist->root = RB_ROOT;
 	INIT_LIST_HEAD(&ulist->nodes);
 }
@@ -105,6 +108,12 @@ struct ulist *ulist_alloc(gfp_t gfp_mask)
 	return ulist;
 }
 
+void ulist_prealloc(struct ulist *ulist, gfp_t gfp_mask)
+{
+	if (ulist && !ulist->prealloc)
+		ulist->prealloc = kzalloc(sizeof(*ulist->prealloc), gfp_mask);
+}
+
 /*
  * Free dynamically allocated ulist.
  *
@@ -206,9 +215,15 @@ int ulist_add_merge(struct ulist *ulist, u64 val, u64 aux,
 			*old_aux = node->aux;
 		return 0;
 	}
-	node = kmalloc(sizeof(*node), gfp_mask);
-	if (!node)
-		return -ENOMEM;
+
+	if (ulist->prealloc) {
+		node = ulist->prealloc;
+		ulist->prealloc = NULL;
+	} else {
+		node = kmalloc(sizeof(*node), gfp_mask);
+		if (!node)
+			return -ENOMEM;
+	}
 
 	node->val = val;
 	node->aux = aux;
diff --git a/fs/btrfs/ulist.h b/fs/btrfs/ulist.h
index 8e200fe1a2dd..c62a372f1462 100644
--- a/fs/btrfs/ulist.h
+++ b/fs/btrfs/ulist.h
@@ -41,12 +41,14 @@ struct ulist {
 
 	struct list_head nodes;
 	struct rb_root root;
+	struct ulist_node *prealloc;
 };
 
 void ulist_init(struct ulist *ulist);
 void ulist_release(struct ulist *ulist);
 void ulist_reinit(struct ulist *ulist);
 struct ulist *ulist_alloc(gfp_t gfp_mask);
+void ulist_prealloc(struct ulist *ulist, gfp_t mask);
 void ulist_free(struct ulist *ulist);
 int ulist_add(struct ulist *ulist, u64 val, u64 aux, gfp_t gfp_mask);
 int ulist_add_merge(struct ulist *ulist, u64 val, u64 aux,
-- 
2.45.2


