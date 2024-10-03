Return-Path: <linux-btrfs+bounces-8504-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A3098F2FC
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 17:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 454D7B231AB
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 15:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878A41AB514;
	Thu,  3 Oct 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="q7TzmETC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328ED1A76B5
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970208; cv=none; b=ED6G69rcpgC/As12SNr5dfsh9JuuZO+93KvR8rbwxhObSgkjwuVqhNZffc4mRtwcxLqohyuWg5vRA8rZe1Y7X3SpLCuzYFObJc8oOqgr4yLdLX3cBvAeMuZXbzE/twyVbRccKhOCSi/rUP1qY8r0wssRRs6HhkwDAu7DSbFdGkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970208; c=relaxed/simple;
	bh=R0JhbifZVieTJpVINcFJY19S3egy1wQ4r1QSogH6fLE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7Y4EdsKEhw5by1cAbjK16AXyMlx+iVrNtSBTixzeVIF1ieF9TMcB3+C4tMqvgw7EzuNe9IzoVj1JEbaLoYaSFLrsdwXyiu+jkXTNgZLlwBlSXIngZXrpLNt3OKJcxSi8v8JeY5HpPhhZdTmZzdjUQxDApccvFsjN8A5QyMgXMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=q7TzmETC; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a9ae8fc076so114167585a.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 08:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727970206; x=1728575006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhJDB34ReB7dQ/Cso5qNIuVekLq2Z2xP/+XXr3qWEr4=;
        b=q7TzmETCUFmOyPs1vEBKglLD5s4zveej7SESeihfnlVpmicaHrtT/7sw2eM4GMpX+s
         WhsXRc7eKCKAjI5hWuxbuZ99JqQ05I1rDn4lXsswA/IuMh6KRwRD+7ieYPcstUSMMQTn
         ZKEeWJwgatQCZEUdOvOrN/RQwwsJujA2Gawx4k7NOrATnG/FS68NUTxmBgVkV8uxOfWZ
         usXuGd1Jc43vvii4fuyIcKYkCQCDAiGMhZwVIP1wxG2Fh+YG0jzibS2+tXQCa9hpRSYP
         xbU5K0h1k5ifyXN1KpiLxxAoXXVsOMY8zxtLqNO3dTIZPf92crXRaDiGj0IvmcsKiDUq
         4p5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970206; x=1728575006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhJDB34ReB7dQ/Cso5qNIuVekLq2Z2xP/+XXr3qWEr4=;
        b=m7ys9CL8O+QKY7u5j+i+Dn3a0nSCNUd/CXiLzWCKpE9RWpKfiYcL+I4fMB/nWTHlAL
         CWx6Oji4NE9z0gMd+JxeaQc8BQUh7FAQaiGC0oQVBgPVyn9wZUqa18Hd5DhAYApFjMtL
         tfjBrAxNmCPml+0ygyW4oS7W2ATQ7LilNqr2NqLh5UlHjgzK8TwUwF6/c0FQl8DqjSDO
         GfwW7jlKbZBL62zTFGubo6R1ojo4hEjRjmQXk/yp9+XdAfZl3pyvQcSLYGaB34rAnFHp
         WN0YsCiW/NJ3yQ24YSXrqfAo7jPWICsTDMFPdLgzMG7Cc2DV0ep1yntGTRRsrhpR1lBJ
         Aq1w==
X-Gm-Message-State: AOJu0YwGgZUw/ycmEDvuCSgp1+4fFResKD2eurX8nzWT42LTDsgRLtm3
	q0/kJxS9vKvT/UtprABfP0LssTU76gPpQC4VcR2ebp5g1kfW7U3JYUcJklAyRTKFMEGMZg2SoBR
	T
X-Google-Smtp-Source: AGHT+IEu9HrD2X/GNOroYXnWZn48Om4QT4ecwvuB92VbTAEQyTRU/N3XFFOHYb0KRq9tEc6ZZspnXA==
X-Received: by 2002:a05:620a:470c:b0:7a9:bc46:2d13 with SMTP id af79cd13be357-7ae626ac2e3mr1174284685a.7.1727970205757;
        Thu, 03 Oct 2024 08:43:25 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b29e3f8sm60207085a.17.2024.10.03.08.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:43:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 05/10] btrfs: remove clone_backref_node
Date: Thu,  3 Oct 2024 11:43:07 -0400
Message-ID: <19a6a6da2ff2bd5a9b55b1e5fbccec346f7daa3a.1727970063.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727970062.git.josef@toxicpanda.com>
References: <cover.1727970062.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we no longer maintain backref cache across transactions, and this
is only called when we're creating the reloc root for a newly created
snapshot in the transaction critical section, we will end up doing a
bunch of work that will just get thrown away when we start the
transaction in the relocation loop.  Delete this code as it no longer
does anything for us.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 91 +------------------------------------------
 1 file changed, 1 insertion(+), 90 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6b2308671d83..7de94e55234c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -469,92 +469,6 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
 	return node;
 }
 
-/*
- * helper to add backref node for the newly created snapshot.
- * the backref node is created by cloning backref node that
- * corresponds to root of source tree
- */
-static int clone_backref_node(struct btrfs_trans_handle *trans,
-			      struct reloc_control *rc,
-			      const struct btrfs_root *src,
-			      struct btrfs_root *dest)
-{
-	struct btrfs_root *reloc_root = src->reloc_root;
-	struct btrfs_backref_cache *cache = &rc->backref_cache;
-	struct btrfs_backref_node *node = NULL;
-	struct btrfs_backref_node *new_node;
-	struct btrfs_backref_edge *edge;
-	struct btrfs_backref_edge *new_edge;
-	struct rb_node *rb_node;
-
-	rb_node = rb_simple_search(&cache->rb_root, src->commit_root->start);
-	if (rb_node) {
-		node = rb_entry(rb_node, struct btrfs_backref_node, rb_node);
-		if (node->detached)
-			node = NULL;
-		else
-			BUG_ON(node->new_bytenr != reloc_root->node->start);
-	}
-
-	if (!node) {
-		rb_node = rb_simple_search(&cache->rb_root,
-					   reloc_root->commit_root->start);
-		if (rb_node) {
-			node = rb_entry(rb_node, struct btrfs_backref_node,
-					rb_node);
-			BUG_ON(node->detached);
-		}
-	}
-
-	if (!node)
-		return 0;
-
-	new_node = btrfs_backref_alloc_node(cache, dest->node->start,
-					    node->level);
-	if (!new_node)
-		return -ENOMEM;
-
-	new_node->lowest = node->lowest;
-	new_node->checked = 1;
-	new_node->root = btrfs_grab_root(dest);
-	ASSERT(new_node->root);
-
-	if (!node->lowest) {
-		list_for_each_entry(edge, &node->lower, list[UPPER]) {
-			new_edge = btrfs_backref_alloc_edge(cache);
-			if (!new_edge)
-				goto fail;
-
-			btrfs_backref_link_edge(new_edge, edge->node[LOWER],
-						new_node, LINK_UPPER);
-		}
-	} else {
-		list_add_tail(&new_node->lower, &cache->leaves);
-	}
-
-	rb_node = rb_simple_insert(&cache->rb_root, new_node->bytenr,
-				   &new_node->rb_node);
-	if (rb_node)
-		btrfs_backref_panic(trans->fs_info, new_node->bytenr, -EEXIST);
-
-	if (!new_node->lowest) {
-		list_for_each_entry(new_edge, &new_node->lower, list[UPPER]) {
-			list_add_tail(&new_edge->list[LOWER],
-				      &new_edge->node[LOWER]->upper);
-		}
-	}
-	return 0;
-fail:
-	while (!list_empty(&new_node->lower)) {
-		new_edge = list_entry(new_node->lower.next,
-				      struct btrfs_backref_edge, list[UPPER]);
-		list_del(&new_edge->list[UPPER]);
-		btrfs_backref_free_edge(cache, new_edge);
-	}
-	btrfs_backref_free_node(cache, new_node);
-	return -ENOMEM;
-}
-
 /*
  * helper to add 'address of tree root -> reloc tree' mapping
  */
@@ -4484,10 +4398,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 	new_root->reloc_root = btrfs_grab_root(reloc_root);
-
-	if (rc->create_reloc_tree)
-		ret = clone_backref_node(trans, rc, root, reloc_root);
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.43.0


