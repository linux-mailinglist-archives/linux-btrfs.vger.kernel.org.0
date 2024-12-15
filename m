Return-Path: <linux-btrfs+bounces-10389-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37919F24A1
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 16:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF8E164F55
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 15:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C7E192D6A;
	Sun, 15 Dec 2024 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+e6hfIv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D05718C03E
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734276463; cv=none; b=muobCo18c2Ydn/WIhO8frKYy+RJi4tM+tBfAxclDAFqi92gXPBxTxX+KhO2LdItxxV/Y3ZE863I0Olx8a2a6rjcx947fEs28pCSW+iXDtaC9nkcMs3zLUMmJtu05aMzczLr22p1nAuIF219agCPoId/k+mUtfHE6pzKzNVk/e4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734276463; c=relaxed/simple;
	bh=S9q/gqoCGQSTBJaL/XPR7RBgfsM9yk6zCIMob2X5U4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgaoHFaZ9NZ3JxxcMSA26aF/tULetFnNva38wHm49hZjLYTYc4GjGlQ1d+/Pkcznb5QnIxHkTwRmcOVp1g7ms70hAtoI2l3+VAxf+/eqHMgeMqiDmDEomVX0c4tqnZ+d1FIy/wl8P6XA4KC/xPyZ+Nqst282zgh3+pBMGeRXT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+e6hfIv; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a813899384so11003255ab.1
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 07:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734276461; x=1734881261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rH2YDzE9BzkjH6aaDCpwyy/gxU5Y5o0kfARs9T4CMNE=;
        b=d+e6hfIvhCHpljzyKhgzHUnUQYtnz3yy9pXbW3uD1DiT6DC3xiK2rpdS3yZVOUStXr
         C/G2oOvMMBlvhNx6uj+neAlg16qZYkePaDc95i/MYv9TYqnfL2fGU+g0KFgfK29D2C+k
         4cBPk8T29cs23xry3r+GJbXyJ2MX5kRZUJbv/9kpQJw6ewmdHgtsXO1+ut+ONliBlOMb
         rvn/9bnZjUvZxzNAeiJZFaVdJiEam4Ecircr6NICqCjLfnTOhzVuuR8wPHI4TEFSZ1f2
         wEJ21YimmPBwPLW3HWNXcjDpSzaPm2uWxLq+mso7LUOmx/x0DxwlR6atTELEj86bD/5R
         XEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734276461; x=1734881261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rH2YDzE9BzkjH6aaDCpwyy/gxU5Y5o0kfARs9T4CMNE=;
        b=V8Ym21S1UaqsvevjVVvbvkUMvcN48CF7jZ7Y6zZF4ZlYgu0mtETRbUlo7sOU9lR/R3
         +hyJbrzVMp7xjZVQdvuwGopFlu+qVuPZifLP/Y+bhmZgs0YyDah+207fbQa2JkUh0j9A
         s5qjJ+xcUCZgbrKt3hDkZSwoLeutsi8fuMrHzo4TDHaLfnxGxS9sKb6rSE64nANBe1Jl
         Hf57mM1gCN6Jym3CbdwcJ8/a54r3v4CkKf2glRMovt2XLr9XkgI3Fm+AfKYcxwgFlHAX
         lkQXLg0y+GRdrpcTiJYokCu8yZmLcZgsou9KAKLHRTrJ9oxBZbntEIrAqyZVkjKim3QB
         dbkA==
X-Gm-Message-State: AOJu0Yzvia1mF2SLtmS501fz81U6pPqBoeV/7Wg78vLimPQSKMGjLyMW
	wcHQE6229RqRBrxWbxwQONLBVgw0p3rJ015+QTXeq3buvbpT9hfnjpcQ0A==
X-Gm-Gg: ASbGncuxikpUt0xLWGefIQoL8uGUzSKFWL+dzeyZ175ZDkEEE6qnaxjdCkn0N5blQ0Z
	G4z+VtnaMDEZ9Bu1diOYdLGt43qKHYLnYFtgjvhm8Wlxqq4Y0pOEOBX06W4/D+vX20FzkUpYNh4
	BoJd0Gbd8rClqzwy/EqCu0WCOhCA57SYLn2ccYWXDjDQSgr8/uAGgtJo+QXXr3Qsmgus/oByZM4
	CLihGW6XKINAoMSo18EmUB5Xvc3+R47tSaBk3aqpe79TFuHf5jxt5hfixNkj2lXAg==
X-Google-Smtp-Source: AGHT+IHIi4mEakLdanagl/CcFFc4aAZNSK4nx1lzOZIMMZAVUaqZu7xz3k4v1/fCa4LeXEb/KA1Rxg==
X-Received: by 2002:a05:6e02:190f:b0:3a7:e800:7d26 with SMTP id e9e14a558f8ab-3aff6eada72mr105154235ab.8.1734276461100;
        Sun, 15 Dec 2024 07:27:41 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e37817e7sm773846173.114.2024.12.15.07.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 07:27:40 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH v2 6/6] btrfs: update tree_insert() to use rb helpers
Date: Sun, 15 Dec 2024 09:26:29 -0600
Message-ID: <2fca678bb30eee8390f90575736461da28fc0c75.1734108739.git.beckerlee3@gmail.com>
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

update tree_insert() to use rb_find_add_cached().
add cmp_refs_node in rb_find_add_cached() to compare.

Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 fs/btrfs/delayed-ref.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 30f7079fa28e..dcacce2c2096 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -317,34 +317,27 @@ static int comp_refs(struct btrfs_delayed_ref_node *ref1,
 	return 0;
 }
 
+static int cmp_refs_node(struct rb_node *node, const struct rb_node *node2)
+{
+	struct btrfs_delayed_ref_node *ref1;
+	struct btrfs_delayed_ref_node *ref2;
+	bool check_seq = true;
+
+	ref1 = rb_entry(node, struct btrfs_delayed_ref_node, ref_node);
+	ref2 = rb_entry(node2, struct btrfs_delayed_ref_node, ref_node);
+
+	return comp_refs(ref1, ref2, check_seq);
+}
+
 static struct btrfs_delayed_ref_node* tree_insert(struct rb_root_cached *root,
 		struct btrfs_delayed_ref_node *ins)
 {
-	struct rb_node **p = &root->rb_root.rb_node;
 	struct rb_node *node = &ins->ref_node;
-	struct rb_node *parent_node = NULL;
-	struct btrfs_delayed_ref_node *entry;
-	bool leftmost = true;
-
-	while (*p) {
-		int comp;
-
-		parent_node = *p;
-		entry = rb_entry(parent_node, struct btrfs_delayed_ref_node,
-				 ref_node);
-		comp = comp_refs(ins, entry, true);
-		if (comp < 0) {
-			p = &(*p)->rb_left;
-		} else if (comp > 0) {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		} else {
-			return entry;
-		}
-	}
+	struct rb_node *exist;
 
-	rb_link_node(node, parent_node, p);
-	rb_insert_color_cached(node, root, leftmost);
+	exist = rb_find_add_cached(node, root, cmp_refs_node);
+	if (exist)
+		return rb_entry(exist, struct btrfs_delayed_ref_node, ref_node);
 	return NULL;
 }
 
-- 
2.45.2


