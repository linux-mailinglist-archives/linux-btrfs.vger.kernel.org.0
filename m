Return-Path: <linux-btrfs+bounces-10384-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D0A9F249C
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 16:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D3A164E86
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 15:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE1E191F6D;
	Sun, 15 Dec 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF1BiWEi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8609918CC13
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734276455; cv=none; b=XKagQl9FHrvwceElnfqTjslayeJhR6md+OdUMVx6YkEhV597jnq/4BQK/mdQT3CL6aJ33n8KxUuQh415ivqyjONVMLvpZD607o27H4ymWFW6qnreHG7rcLBKQrfOBBpuC2RI5X6Ss1tKekVoE7v5GsUFZUljsrvZg2346WFoMNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734276455; c=relaxed/simple;
	bh=rMq8ZDKVTymRphMHn4rWAax0sOLBl/3+7bu9W6eyass=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuNnh1oxA2Nr7ybTa+2HoF4j7k0Yp+Agj8emGstmiwtGmEvlsWNobo5vpZ+UqVUqfTeRxiw9Qr2gA13dCrapU3ezjEurN/juu6Ug9y3XEXSn6CeUXseEsQLtKwg49FEiOYk6kAo35gbSySakjACjOLGjAzl4uKVLzEFX4D0ju/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF1BiWEi; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-844dac0a8f4so259209939f.2
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 07:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734276452; x=1734881252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gSeBZ8/Uq7ekf8xRKF5gqqRjbIGnCkAnvwd2y0iYAE=;
        b=WF1BiWEinJSsiv/UWoATPIK0qrwwy0S+LeWCvF8StfV+Ranf9pD0knNN8rz79cUYu1
         mJwy2/U/04/tzUCovlVVbSoEv+qEU4swnIch1aAcfNu2dDDxW7nO2WNi4hZ8/F0OkJG7
         WCWY5gYRCGzzoVnN7FKuimFTm007s2wxLp8u5EqIPG6c9/htwfSRMEw6AheKoN+5ZoeA
         NkxkRv4dSO1CqQuaRNustXIrUd1HKg8UI03haNopPbSCWhBTn3AzWstI4oQo9yDNbSVC
         LDJB6Mo3jn7BwBLAnAaO32tvclh+X91Q2bTszDIRXkhnGlyRxuN2blCZ6/1iTEHZntW6
         XyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734276452; x=1734881252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gSeBZ8/Uq7ekf8xRKF5gqqRjbIGnCkAnvwd2y0iYAE=;
        b=mi3wQ69Bx5T8SH9LnWf/U2SnaKSD4baxykMm2KxZ18g3m+lZHncd+vYkaQtR9hGnVY
         RM/7R5CxTk9ZwZaaB5lCgD9f4r1FS33JbYhQT2bVhhx+e5hFxhvTgJlGBd9MCSjU4/p0
         7Sm0IFGjSqwrglZ4uRHb8JT6zW2J6C+BaOCaocGtF9PZFJTirirAatSXfj0jlVuZiVW/
         vjhSN3jB94Em0ttWGp9VP/XkPnuvqNP4EktajZD7ICVShbPJB2nHuPMMN8djfrqQkwSx
         XUMm9kCV1sKLMZ/gcrMJLMfB8cIKJ5fV8uR/gv3PCBBGoiqNyS6oaJvD5WFekQk2YtJn
         xnUA==
X-Gm-Message-State: AOJu0YzfEf6ADmSXiOY6GLsRchl/kUORoRYqhXGsD+Nz7tx7b/bCiyP/
	P+q4Ee2myVznGq1w8HAyOgQGNYIYg9/LsE4krZRdMen9m6KrxuMD3K2x2i07
X-Gm-Gg: ASbGncs7AtMQ7uNtUxQn0jmqJJO1OAqZ5q5iTqgElZN7TulEMM7D8ZjeExr6w/LXenf
	vGF7XhStbljFaPY+ttewwuhqaWPiXRw3nFIM+o4f3Eab+G+R3g+Swccl8rDjtwP9cNkIrG0dREy
	gmRaVwj90s4sV1E4sexJ7csXpWso/3tKeHFMDMkl0d1fStSjBatKqvb3358oP/WzhMGN90+d2hn
	niYyC29v+r1iLcQQtTVqxfeTPgcby4kFNPINT0Mx1BID+nzkkNFeoz7QSOF1+jHeA==
X-Google-Smtp-Source: AGHT+IGNPBqG5D/4xfoNouKr1/aX76yvh/kMbQWeUHLKFy5qiNPMZmFWaLZ2f8qCXx1w0oLs6SOdJg==
X-Received: by 2002:a05:6602:492:b0:835:3ffe:fe31 with SMTP id ca18e2360f4ac-844e88489f9mr1001631539f.8.1734276452229;
        Sun, 15 Dec 2024 07:27:32 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e37817e7sm773846173.114.2024.12.15.07.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 07:27:31 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 1/6] rbtree: add rb_find_add_cached() to rbtree.h
Date: Sun, 15 Dec 2024 09:26:24 -0600
Message-ID: <477606e7878ec261878d6e5f6573496d19670887.1734108739.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734108739.git.beckerlee3@gmail.com>
References: <cover.1734108739.git.beckerlee3@gmail.com>
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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


