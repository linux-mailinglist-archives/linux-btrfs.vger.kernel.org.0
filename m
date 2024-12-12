Return-Path: <linux-btrfs+bounces-10325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEED9EF417
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 18:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9A916AACF
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7976E2397A7;
	Thu, 12 Dec 2024 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiF20FG6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E7A238E27;
	Thu, 12 Dec 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021995; cv=none; b=sPIyLMt5VNful2BYcsbLfp8dprOTlsPuSoyHwMvPQx5dT29hpyjJBvGQfIizNPjCTx6wUYfwLUbF/lb1bLVtg/EC575NlKTNyeOxx8XUj+Z2hHCUDSveLcGPXn+MtapZURIXWuoaLt5fHu9raQCWntGNCv1oqlyYqocgfb3yQjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021995; c=relaxed/simple;
	bh=10mTZ6Baz1w4vZT0DsoF5FMFN4WwL6kq6s4V2xKqoBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I17EuTrYaGRdj8IJ5RVcx7UxbZOjLaYcKTktMzKWQwuUA4LMC4ddayRwhNkNcK0z8Kn6L7HMQQi5mnx1iamNqn2XOKh+hzJ+oBai3O5GWiLRUGtsDr1TPyX7oa7jzTeBYd5L4X/m7EJtJRuau2DsWmRFEotDgUm6gwz87DHN5kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiF20FG6; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a8aed87a0dso2781075ab.3;
        Thu, 12 Dec 2024 08:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734021993; x=1734626793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoQjUEiKcHT4k34GxlmM0v6sAaxxYb6I9s5NiJskeoc=;
        b=EiF20FG6ft07gzpayrW9qvk5F6gpl/q8NrFP8ot6pQlXq/TMPaNmhdjakeu+yxjYs4
         fgAjPxBLzx8EHfQdJY5fYkVLssejkOtviZwtM4+C6+ln6j1CTNae/EHa64bcZNx0KPRF
         KL9M0N1sivqAi88GDSh0ObAM1FiOsDgr59UH2Fy2iWg7U8jbnkr9BDMShQ6rlJ3TbbOI
         JRoQ6rssbyaz8E9QSyVLnv/bqmkuihU2VAm8SzVIIV4v4pnlU0IYXaG3yQyfreiKmwKb
         tpGg176cEnhwux2XRgDxvXN3x8cRfICP+r/KUi6+/PkpDBnO+GpyjYF9VYBqqeeNKufk
         TH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734021993; x=1734626793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoQjUEiKcHT4k34GxlmM0v6sAaxxYb6I9s5NiJskeoc=;
        b=DUcizYz1xig9tcIE1+l5DCND3pkbR2lBSXuKEsCoYf6edUwG8sujkxT2Y2CYdGoQWK
         gQ7V0Y8vcMta3zNLfN9QUWXQr3a5/M01YWpywu/ofnRAhtjkTFzT0R5SC4RVKTk7lLD9
         USt8YL+m2u+s3g6OW2Gl/OeFhdm/yIzc1Uy7tNymoLWjO74SZp5JLBzE92xW8hC315UF
         LVto/LseUm58iQ5CKnjeG81g49OuJjyxWUXdmgEK2H5R0fX2Ya0gZad2p9I+61gBCGkB
         lD1WW5U4JaqF1j/PFARDaaTaRAyWn1BBk08TjD7Y2rszZdbzT3yLtJuDWuYGDK+G5iGA
         v7yg==
X-Forwarded-Encrypted: i=1; AJvYcCU6bjSc4N1nMW0rTNRIxNA2xC2RmWxD6Kb0Jf2pno+5gzygK3TpXwkJL6O6Q9CJg+ccXJm6NMeSfFGW7u3V@vger.kernel.org, AJvYcCXKiKbcNBtRVs4ex+HQX5xpE+dqNsfsv05DZyqZoNk/bIDaZf5b0y5OclNgA3C7cQj7sHANvcb4TNbvrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEooYmo6dOTD8wifbKYC3d0Ch57DsvnydJAitx/apofGJj5OIl
	0LtE3BhXgqlkv5WR5ECQKr/6ud96D8eTBwmmtUivR6M5/44DY5YT
X-Gm-Gg: ASbGncuHcGB6bagGc9qByXtZGFWPJhCT0xWkW3TWJGnb8l1A4AqdWy42vEdfdWOTcaw
	KeKABbcK7f09mpPYyh3MIKoWpRE0J+VcSuVI4sZdwk1X6HRq9JKw6oxCpNjnyWmUOX1C/vKxqxM
	9CjdCOHVyi2zuSA5Vvhc+v/ndaIKD13tWqOyQO+02D5zfWhrWk5/V5hfh/hDWPo/FdC2pkyeUIn
	v6jWyDnxY8zgSeus1LPDX3ZmztGUiGVVImDnUyMOyjnQXEI3sLezXWHc/pSCaki4Q==
X-Google-Smtp-Source: AGHT+IEsvgNYAMP0uwm8jj3s6kfFQKRCgcMH2TkFySt9PcCsQ4XvyWG8v+6JD49yxKWn1jeK1hcwgw==
X-Received: by 2002:a05:6e02:1547:b0:3a7:e7a9:8a78 with SMTP id e9e14a558f8ab-3ae57ef8aebmr8023145ab.17.1734021993014;
        Thu, 12 Dec 2024 08:46:33 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a808e1e29esm44346245ab.56.2024.12.12.08.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:46:31 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: dsterba@suse.cz,
	peterz@infradead.org,
	oleg@redhat.com,
	mhiramat@kernel.org,
	linux-kernel@vger.kernel.org
Cc: beckerlee3@gmail.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	lkp@intel.com
Subject: [PATCH 1/6] rbtree: add rb_find_add_cached() to rbtree.h
Date: Thu, 12 Dec 2024 10:46:18 -0600
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


