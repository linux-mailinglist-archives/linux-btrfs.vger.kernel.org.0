Return-Path: <linux-btrfs+bounces-10255-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8889ED404
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 18:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7E52832B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 17:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E885E1FF1C7;
	Wed, 11 Dec 2024 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiQk2FZY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51E01FF1D0
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939289; cv=none; b=BgGfp4RnrFIKe9CWD+f92xMI6rSwULV9B+vqz+c1fCXazVkAU+RFsz2RxAu1NTSlHtEBsHrKMRSHhym2teqjy02RRmqTRIToGyPTq8ocDIRepT16+xZVUxEBaCAIY4TXxmGhNmYQ/i+byhHVzNwOk1EVoMh22Gw4w/MFxcIRkVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939289; c=relaxed/simple;
	bh=10mTZ6Baz1w4vZT0DsoF5FMFN4WwL6kq6s4V2xKqoBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCyWr8iG69pZZBp0mu0KKl/VjNEncJ29P+W98KdSueQ251fmUcb+x2r1EvheG08/X5sBVQPAuo2MQxq5WyzV29eSnJ34txAgtCyhwvSE5D1qtRwVh2pEUED4XndYLYAE6MeGCJ/j6UmcaSGdVgvFIsLceDcLqVcFr1uNVzDD/x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiQk2FZY; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-84192e4788dso235576239f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 09:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733939287; x=1734544087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoQjUEiKcHT4k34GxlmM0v6sAaxxYb6I9s5NiJskeoc=;
        b=iiQk2FZYlZejiybE5Mj3PLX/lRxkSCyfp0G6hZmGIhO1ml+F2q83lMlPmiLiCZRDO9
         FemeETbCyNJz5wXBB4SxueVotiMmqIuhHt73S9KvdqcTaZw/uJE+nM8Ti5LJIQhLntSJ
         XnMR5ZTD9CC7zZujdrmgmdfXUSPCwW8fEhIRvNBICAFvYL/Q+vDuYxOacRLpYiXu6Byt
         Yu2ssqqs1Fvi7COhuVC8F81LOKQ1PpiE9ckXl4NpXR8Cjhz3qs1EfNK+InlpPampOnL5
         GIGN937aLxjPyljvhJfdlJE0hGLeg0YfwCotszkCRcVqALW/Gp85rTg3AZkvIHXcGpyp
         2TYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733939287; x=1734544087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoQjUEiKcHT4k34GxlmM0v6sAaxxYb6I9s5NiJskeoc=;
        b=bsKdjzqN4n/Omnb9JIoOaO66jYxrG3V1MFTsqjU1Kkxe/OYdSSYBaZ5xyOkY4AB83/
         qlyuqnaGB6NVBBq5acJKZRqe4HHYi1kxWMprkO8c26YUgO1dfuMRLBCCRFTSMPNZqFKL
         WE4UUMSDhgVdy29+Kzh9DvpCGcNvilPMfEPx/n4gaDAU/WQEMU1GKSnmkFY/LB7vctkF
         BiJUTibXk8wgOupZ/RromeQA+VmE0I8vVPNvaDWC51AUuye05+7nU3BfI9wR6H1S1kQ6
         FYUFmaRP6SAgQduJDjUVFu8weyGMvRBEZxCs6eh3kO6rYcuqzsUGa907NuaR3j1HLy17
         N9qA==
X-Forwarded-Encrypted: i=1; AJvYcCWZuEpSXQCwhY31bpL+qSzTXVqY2/4NJm4ffarqBjeFFHEFdkICBEyEWCK9/FsktOkjC08a3guACT3Fyg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5+Rxa5uVoZ2hbpMs6j9McJM1P9zuBa/Gzj9ndmDRfRYx2zvSM
	UI7FQt7XJnNqn8G7zcmdxCXKkCDWizb6q8Mh3eMIr6vd6gL7CprpvqzmrtujkLg=
X-Gm-Gg: ASbGncsM4P0ME9cfeKFlg4y2TbHG/h+cPBeu9YU0Gx/WKljLrJDa+i0P5RgJohSS1jx
	8G/yqa4iT9fEdk8vqzA/lJcu5IloNzdXV+51+ygbEAGxDhHxA/yV5MBWzt/vtGAyQ3GGi5bTm8w
	CqdwOti2LSF6CIkRwPra5jSdhhNuDZUqGCY+F/LP6M03y2mRC9seYD87eJl+1r3A5rve+6AOURy
	BfKeAqwnCLAmHyaqaBpc+83CBjakWQGuDOIqP42USeaY2fK//7neHgvgRGPHoU=
X-Google-Smtp-Source: AGHT+IH69BOOoy2fz1wD9KgMNdJfrwJoVi/CrO8K0VgYeuPucjqk60n4YgQMAYpD19ZYyBWYgImzlQ==
X-Received: by 2002:a05:6602:6c05:b0:83a:9820:f26b with SMTP id ca18e2360f4ac-844d741e564mr64441639f.2.1733939286658;
        Wed, 11 Dec 2024 09:48:06 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844c317e930sm77069139f.41.2024.12.11.09.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 09:48:05 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: lkp@intel.com
Cc: beckerlee3@gmail.com,
	linux-btrfs@vger.kernel.org,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/6] rbtree: add rb_find_add_cached() to rbtree.h
Date: Wed, 11 Dec 2024 11:47:54 -0600
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


