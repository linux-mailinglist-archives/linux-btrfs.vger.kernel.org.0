Return-Path: <linux-btrfs+bounces-10136-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C360D9E883D
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 23:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBFF281016
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 22:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AF8194C96;
	Sun,  8 Dec 2024 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbcN9lF6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E3189BB8
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733697520; cv=none; b=NKzc9EY6tZ18MYl7SxHvQEEqt/aA5Al6oWboAwPwz+nucYDaE+jR5skTT+xuVoxXpHhuNke0d0wkMB9kDtfc0bUMtAQSMZ3ecQ6uMGhMEks0UTaX/X8/mPBDZcwUFm8cFTdLdPRHw6CKNeGOxY/ocXrMP+nYFf3VzdmWPsLYNXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733697520; c=relaxed/simple;
	bh=05GCcyXxJ2eTFQTX4Kbu9m1mQPBf99uRcBdANIrBWnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIlSkIb5/VAAQBMUrSDJNuhKYqeTuzm7F9FL2zvUa51gVrsbA20zCfl5BmYuXIzgylJ1VVEvVVDGFTwoHotnkeApu1f4kYZq99L5HPXaG9KBQrSjM5062vznAcLftMcnSBnCzyV64cLAlVsc2ALm+SsYZARbwzyhekbRIpW3PbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbcN9lF6; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8418ecda126so147427539f.3
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2024 14:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733697518; x=1734302318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJKvlp5Sn/YQp30OI6Ka3qfGrvzee09Si+MDeuzoUqA=;
        b=nbcN9lF6oWheX5KWHMO3xPz8+JCF5p+Xrh8uAqH4+S13cpCE1l4ga5BAMCrfVozZBk
         OB5/Yqtj3s/E8enkuVR41BqEN9tY/mnbR5AV5ilwd7NHPGcUH8JzQ+llUn3qsmruxXom
         VQrvPruhx33T6y+FVPKNz3/pjr5GWD3OnyES3pRwiDjradSnENTvo5MovR09ICDzMwps
         Jtde3JbwMYemFn3sLZs3A+oao3BRmXdmkqjFPollIAX8ZrmkaNkzsVjucrLrox6BWHOY
         6rBrKQoLkr6DkDPv9io9/NTw0XhOWZioyJOxbwhrckaLQlgcDwLpSe7810BhLF+BgKQF
         aMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733697518; x=1734302318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJKvlp5Sn/YQp30OI6Ka3qfGrvzee09Si+MDeuzoUqA=;
        b=H6lEgGKkKZwncOsWSWCo4BxbTdM78pNTbgrscFL5G8g0fJuDiKvhICdYQwdr4AVkqT
         0ww3SiRWe5dzBZ0iEKcA0LFHZES+ZcF7OapD145Jn9gC5IN4tK8dZB3Dxj8s2IGZiiho
         8h72jUXGQz8eYhHgV4zkrJHdQvU+idlo9LweDsJkS/jYZwXIMChOEMt0GoVxstztGUad
         8A0mtbGdZmhpAjzQFGa0Ip9FGMgnM+rlMVxwO2FDziqQSe7pJC6sbTzmrLZVHBy5DASg
         pXY6qjFrzRo+sv6GZ1J7YZ/dY/QDEO/9gHWg7FJCUEX7sSbG0XKs0LYOwGQPcYiKdXlE
         QfIQ==
X-Gm-Message-State: AOJu0YwhaxHDTiaebC/bCJXnMACfnVFzgyxrLdREtfUDRlap7Gg7aP2I
	72lKpmnhcnJZxC7zz7GIv8BDyWZhhkBYkS5ZbYF1XlQTo4zDMys/GeFZkA==
X-Gm-Gg: ASbGncuHGFkwILW853VIzPjTINZ5RJYQn/9xQjBqaWro9Yp1FAc0VO8fX07FBFzrySW
	nHyU+iebom5ljzSRQ6ZZNLzSeP77jKk1YC+uT6/pDMVJkNLNUEQ3kiSvYKJVqCeliPdWgWnI+R1
	QUq+czPeQ96JsaTrKK4pJC+NAu2y66DDv8j81CkUnBz33OlYdAHNQ4f0yUvvyRz1kUiFXFl5Nj6
	rmGvfmFV65lrbBYEebHVMbzwx4XPV8thB58R/yZwKMlwEMZr3UwgWC/4+c=
X-Google-Smtp-Source: AGHT+IEiLDP7igajZVratffIuCGL7/lpYG3PzTCQ446rBvLlqWTD2GBLfkMMLApqDYMdiClq4+QD/A==
X-Received: by 2002:a05:6e02:1c8f:b0:3a7:fd5a:8b8a with SMTP id e9e14a558f8ab-3a811d9cdc4mr135370015ab.12.1733697517804;
        Sun, 08 Dec 2024 14:38:37 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a8f162d6dcsm12704745ab.67.2024.12.08.14.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 14:38:37 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] rbtree: add rb_find_add_cached() to rbtree.h
Date: Sun,  8 Dec 2024 16:38:00 -0600
Message-ID: <037f7b7055cb8a25ed8f18eda8010fbc9ebcec0c.1733695544.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733695544.git.beckerlee3@gmail.com>
References: <cover.1733695544.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds rb_find_add_cached() as a helper function for use with
red-black trees. This will be used in btrfs to reduce boilerplate code.

Reviewed-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
Tested-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
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


