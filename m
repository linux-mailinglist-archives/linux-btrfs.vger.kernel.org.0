Return-Path: <linux-btrfs+bounces-10201-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79609EB9CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 20:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78CBC166817
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 19:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B17214209;
	Tue, 10 Dec 2024 19:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6l07+1+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92F3194080
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857635; cv=none; b=rnwM61/zvVi1gRRl7I/+G6A021E1Wv7RoHJuWEIqiRli4VzJRMeJh6tB/NRquz33/P52hr/OHUif8Qqgm0EPUFrgmzb557fMy+MzMJzu7pC9TWJZgIjJAmMWFB9htdJEWIEhQWALATqLZ21ozvjCs5DYrsO77zgaJJCIeNlvH4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857635; c=relaxed/simple;
	bh=By8mpbQ7VBmZbkBzf3n0bpLF3tVeR2hfOpb9yBxOGXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jn1In3C6ImIer4xB3KvTOtlXKRPcoL8kcVk5uhRxMaPdNvFn9qDy9lJRjv+0FvYQ5pg2Y9Y7LwjeZ8gE4g0ACztoxzTHCXk1EfSxChS19v47K+pFurid8fWz32s8xUrW8gXTZfYTglMOfN1mHKWXGVjtO+P/xhRcalykrHN7Cxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6l07+1+; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8418a2f596fso184967539f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 11:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733857633; x=1734462433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJpi7HTzmASriu0LWxSoUvvkiz2lc3vNSEY919+be6k=;
        b=N6l07+1+MWJbSxUuB+BT/4JJzFEcltagSHCcwKYCp9sjLu4GrtmnYwl/oM9fceF5as
         mrD+0iH1bTMDVypZwF4pFaC5KwpTKs+pCRfrxdrkh+aF+IFSE6CdK/M4vODwz0+cpa9D
         uXS/C8cCvblFvxS56/D4zItKlgbIRDi4gVr073YES59PY/ptd1BY3Mc2+KTY/tOMCeyE
         fC0wZNXy2pjSpNxm5rcfQYnKIdEHWe8San/So1wKkgpp4zsZGtTwBENXLZXBMFxAkYUk
         xv/U6gw3J+3sKSSFFU6R9RJ68r2vT9OnEfMg37uU+fsP7LSeOGIJe+pXT3RpM2ef05vV
         JQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733857633; x=1734462433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJpi7HTzmASriu0LWxSoUvvkiz2lc3vNSEY919+be6k=;
        b=Wt/e1tLfYWOxv9acZQrd5E/W1sMDxysyeoKbz1pYHGj/9N/FnQIfYFYYvzp7B/VZQj
         JpLOCsJ3ags88zLmpWRotQRfoFGnv0z0VStgxGWyX4D5obJ7hQhJuSxfUWlYNueSKA2W
         yURCstdIwP5qbhOiWb1TJ0vxr42T/MyVbZNy07ooyh+qw8CjTd47ygwCRTEu7pGVJCT4
         KBo/3vNohgAVPTX393w1puO/crcTlUSSbOZGDWL7MFSVAGW+I1YExeiD3yzVli4p6cBc
         /wwoHxyLvdWD5DMWlFWT98kuPlWKn/xX9v6rFhf8MqxwSFEXyxq1/ATbnxzYXNcDsi8V
         cU1Q==
X-Gm-Message-State: AOJu0YwHIKN6qJ7YmLrDQVr8jNsdB/L2i3p0KKnyF7n0EAoQ/BIxegF0
	Y6xAxyCZgNTVJeI8AjRbLpJr12QcRSJ1DeLbEawvIEqzurEwzv5I4M/Rdnl/
X-Gm-Gg: ASbGncvR5iE9+anMOTXekpUXueWJUu6cJbfuzZRGRPPoEONgnMZXr3sASuiOJPiWgd0
	U3VhW9cZ8NrRvtwNYx347a8Fm2OJ/C4LFYeB7Ln9X4Of2SnjNWCJtjfyE1SxfaBNevwH+DQL936
	w88TQH63Amm3AVcmdxaev+QWl/MINNeDbTgo9ntFZClKonwN7Tm+vJrkj2UrVlKP9ZBf0m469ne
	D20b9W9xVsc/kTDn81PbDmV3JPbaClElAW6dvfQ0Yu0s74/5Cv7gvzMVGxvhIk=
X-Google-Smtp-Source: AGHT+IHvrrak7pj0ExjTUBiv1KclUcPXD8vLwe/cXM/CvxL5Gm83lXVmjRHY9BGdIUNuS72g8cZTQA==
X-Received: by 2002:a05:6602:2ccf:b0:843:ec8d:be00 with SMTP id ca18e2360f4ac-844cb691d42mr54584839f.13.1733857632600;
        Tue, 10 Dec 2024 11:07:12 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844cb2611b5sm7044839f.38.2024.12.10.11.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:07:10 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/6] rbtree: add rb_find_add_cached() to rbtree.h
Date: Tue, 10 Dec 2024 13:06:07 -0600
Message-ID: <4768e17a808c754748ac9264b5de9e8f00f22380.1733850317.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733850317.git.beckerlee3@gmail.com>
References: <cover.1733850317.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds rb_find_add_cached() as a helper function for use with
red-black trees. Used in btrfs to reduce boilerplate code.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412092033.josUXvY4-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202412091004.4vQ7P5Kl-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202412090944.g3jpT1Cz-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202412090919.RdI1OMQg-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202412090922.LHCgRc17-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202412091036.JGaCqbvL-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202412090921.E0n0Ioce-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202412090958.CtUdYRwP-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202412090922.Cg7LuOhS-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202412090910.F5gin2Tv-lkp@intel.com/
Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 include/linux/rbtree.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 7c173aa64e1e..0d4444c0cfb3 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -210,6 +210,43 @@ rb_add(struct rb_node *node, struct rb_root *tree,
 	rb_insert_color(node, tree);
 }
 
+/**
+ * rb_find_add_cached() - find equivalent @node in @tree, or add @node
+ * @node: node to look-for / insert
+ * @tree: tree to search / modify
+ * @cmp: operator defining the node order
+ *
+ * Returns the rb_node matching @node, or NULL when no match is found and @node
+ * is inserted.
+ */
+static __always_inline struct rb_node *
+rb_find_add_cached(struct rb_node *node, struct rb_root_cached *tree,
+	    int (*cmp)(struct rb_node *, const struct rb_node *))
+{
+	bool leftmost = true;
+	struct rb_node **link = &tree->rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	int c;
+
+	while (*link) {
+		parent = *link;
+		c = cmp(node, parent);
+
+		if (c < 0) {
+			link = &parent->rb_left;
+		} else if (c > 0) {
+			link = &parent->rb_right;
+			leftmost = false;
+		} else {
+			return parent;
+		}
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color_cached(node, tree, leftmost);
+	return NULL;
+}
+
 /**
  * rb_find_add() - find equivalent @node in @tree, or add @node
  * @node: node to look-for / insert
-- 
2.45.2


