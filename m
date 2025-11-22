Return-Path: <linux-btrfs+bounces-19267-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3ADC7C8A7
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 07:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5E6335AB6C
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 06:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475AB13AD26;
	Sat, 22 Nov 2025 06:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amCqD5Lt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096342C1584
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Nov 2025 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763793398; cv=none; b=VlB+w2I730TGLzZ9ueVX2PvrFG4d05+c2Hp8lwP0LHyeAkh4dDtIMEQQAoK/gYzgd91hw7I86o97B1WE8B0D+zqqTfzavVhSczJ0ctTtsTZj2IcTmaVaGijpE8VNRZGWR/yno50DhOZ06I1r3c3YQE2fbIxSkbyvfm3pNBsRJrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763793398; c=relaxed/simple;
	bh=dAafqbIFIYxpAQUXLVWB91hyobgqAbOCiV9E6S80yUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eknNigz5z/lDfjL9nax7uNuaXHwBJCF16KbSIqKFuMJMKddYWLjy8yFhqyzjFsvMohD3W7B8sQwe5RouRU61bij0xa8SyLQ+/R7yPFnw3Y4lwcpi43rErtu8jH4TYSkWmOJNjBRJYbIK7pbghk4S1vi49QwXTp8oYsHXc8qU9Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amCqD5Lt; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2960771ec71so4855255ad.0
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 22:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763793396; x=1764398196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6LUpePfyyCdDKEMGXDG/rrnwGeTQY16Mr/KlNwfQ9M=;
        b=amCqD5LtTKEpszuOYpgmP8cyphE/smpWpjAOKKKrs0M30/PqWgb69i7mMTzggK4CEx
         3Ztjg5gReKfVzFhSga91w9dirKWfQvUCDJ0pLW9BBjk5ty5vFOOAJjTH+U3XHcpy+/Ws
         6tbcBSWPtSCazRrQDhv9xRmkdzpqdYO3B756m10tu+hqf1wg0RueKHroS/cSjKKvHtzP
         bOTg0uIhWY5IzNHNmTixQAqcTAvnz+TEaOvLyi1FnY6ic447YwUnIHlzVJXn2rLkWceW
         qOkQHoWb9RJSsb3F+/y4wCP8E9DzDaKjwf13hl6CO3NTGMJLR93p202RV64qeWM/J1/c
         t31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763793396; x=1764398196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y6LUpePfyyCdDKEMGXDG/rrnwGeTQY16Mr/KlNwfQ9M=;
        b=I2lvfrsIa/vK6Q8Whoz6ErbpaZWUFubkUI/5rrZlARO1mlIsWrbajmNK4NWTRWuARu
         zVlSVtPhP19ELYCodKloYuKPd1vK9iM6FRJdLeTreYizKJdOMLUnxpwqsJ2IzGbSAj7l
         QbUnRXXrdnZaJEtXkiA6VFGDMNvdUr3VYDwz3HZqV5Kp+76jzK2mqhK0odHsOdIewMHI
         j6sJdRdKloLGxul13pWHETCy9TNMnQWFJFFHozBkN1ZGCMKtCtVO4fc2PMgeA0uBwzCT
         CAmSh8XgLIeHkE7n/anvGgo5y9112H/aFRuRHj0+3ewV2PAwCwCImf/+/DMblWuOyaWT
         v67A==
X-Gm-Message-State: AOJu0YyYx1XToLSOK3bljyFK04cKPkEP923b2UKV/cuUIw9/sHXmTfdj
	8byyJ85nzBTDXGYmTnDVE4KaYks/gxpRQcl1MOGcqw+MAKUXjc9DgeoLGeDSlivcP6MuhN4c
X-Gm-Gg: ASbGncunrWogwgbGiKLwqOBky1bBMkWwKaW9ETYFrl49jYnJUiTKY2zAfUs9V1ugUip
	YB07CK6qknwDSCJIp+nlkRmnh0NGWtksLI+788z5g6JRp0P3LSZiMnLu8EiCTT3Xr8zMlZLA7CV
	dac+wLoqg4gwoAux+QV66sCydNrdpvgZgEmnxoXbZ/suUd+RjCT5141JbGQJokFor3H8PJjtnaM
	BsjiA06nEE1vMr9KV6nFHtcJ+AQcCwN8ZE5Bm5hVkcXhjl0ZKUwZ0DJw5L4alfT3A2wk/O/mGoc
	hC3/FN1WFMlJBvBI1ng1nKzUBiiKt+//iSGc9XFWHIYfNlnN3UM6LwPae97nZMt+RmXyzmdQl9G
	EXB1mpBLioNzC6A49W+ToW4vRujk7+edMxhFpWg8w0LWgGGAd2dWdr6NVXibGCH/K6C/sT5Hi5V
	ZqXUOsK9zMwRkVzQWSsfi3GQ==
X-Google-Smtp-Source: AGHT+IF2f3cX1D6/gfY5k8LlswlFOank5WHfcfhbbH+/9qDAxd7JRHqhq9yjuclfrlOiNwZkarnZGA==
X-Received: by 2002:a17:903:2385:b0:297:ecde:770f with SMTP id d9443c01a7336-29b6ff7bf00mr27083755ad.2.1763793396307;
        Fri, 21 Nov 2025 22:36:36 -0800 (PST)
Received: from SaltyKitkat ([203.106.195.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2ada18sm75555515ad.90.2025.11.21.22.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 22:36:35 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 2/2] btrfs: simplify boolean argument for btrfs_{inc,dec}_ref
Date: Sat, 22 Nov 2025 14:00:44 +0800
Message-ID: <20251122063516.4516-4-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251122063516.4516-2-sunk67188@gmail.com>
References: <20251122063516.4516-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open-coded if/else blocks with the boolean directly and introduce
local const bool variables, making the code shorter and easier to read.

No functional change.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c       | 38 ++++++++++++--------------------------
 fs/btrfs/extent-tree.c | 17 +++++------------
 2 files changed, 17 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1b15cef86cbc..300fd8c16ad7 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -249,6 +249,7 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	int ret = 0;
 	int level;
 	struct btrfs_disk_key disk_key;
+	const bool is_reloc_root = (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID);
 	u64 reloc_src_root = 0;
 
 	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
@@ -262,7 +263,7 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	else
 		btrfs_node_key(buf, &disk_key, 0);
 
-	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID)
+	if (is_reloc_root)
 		reloc_src_root = btrfs_header_owner(buf);
 	cow = btrfs_alloc_tree_block(trans, root, 0, new_root_objectid,
 				     &disk_key, level, buf->start, 0,
@@ -276,7 +277,7 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	btrfs_set_header_backref_rev(cow, BTRFS_MIXED_BACKREF_REV);
 	btrfs_clear_header_flag(cow, BTRFS_HEADER_FLAG_WRITTEN |
 				     BTRFS_HEADER_FLAG_RELOC);
-	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID)
+	if (is_reloc_root)
 		btrfs_set_header_flag(cow, BTRFS_HEADER_FLAG_RELOC);
 	else
 		btrfs_set_header_owner(cow, new_root_objectid);
@@ -291,16 +292,9 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
-	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID) {
-		ret = btrfs_inc_ref(trans, root, cow, true);
-		if (unlikely(ret))
-			btrfs_abort_transaction(trans, ret);
-	} else {
-		ret = btrfs_inc_ref(trans, root, cow, false);
-		if (unlikely(ret))
-			btrfs_abort_transaction(trans, ret);
-	}
-	if (ret) {
+	ret = btrfs_inc_ref(trans, root, cow, is_reloc_root);
+	if (unlikely(ret)) {
+		btrfs_abort_transaction(trans, ret);
 		btrfs_tree_unlock(cow);
 		free_extent_buffer(cow);
 		return ret;
@@ -362,6 +356,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 	u64 owner;
 	u64 flags;
 	int ret;
+	const bool is_reloc_root = (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID);
 
 	/*
 	 * Backrefs update rules:
@@ -397,8 +392,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 		}
 	} else {
 		refs = 1;
-		if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID ||
-		    btrfs_header_backref_rev(buf) < BTRFS_MIXED_BACKREF_REV)
+		if (is_reloc_root || btrfs_header_backref_rev(buf) < BTRFS_MIXED_BACKREF_REV)
 			flags = BTRFS_BLOCK_FLAG_FULL_BACKREF;
 		else
 			flags = 0;
@@ -417,14 +411,13 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 	}
 
 	if (refs > 1) {
-		if ((owner == btrfs_root_id(root) ||
-		     btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID) &&
+		if ((owner == btrfs_root_id(root) || is_reloc_root) &&
 		    !(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF)) {
 			ret = btrfs_inc_ref(trans, root, buf, true);
 			if (ret)
 				return ret;
 
-			if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID) {
+			if (is_reloc_root) {
 				ret = btrfs_dec_ref(trans, root, buf, false);
 				if (ret)
 					return ret;
@@ -437,20 +430,13 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 			if (ret)
 				return ret;
 		} else {
-
-			if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
-				ret = btrfs_inc_ref(trans, root, cow, true);
-			else
-				ret = btrfs_inc_ref(trans, root, cow, false);
+			ret = btrfs_inc_ref(trans, root, cow, is_reloc_root);
 			if (ret)
 				return ret;
 		}
 	} else {
 		if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
-			if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
-				ret = btrfs_inc_ref(trans, root, cow, true);
-			else
-				ret = btrfs_inc_ref(trans, root, cow, false);
+			ret = btrfs_inc_ref(trans, root, cow, is_reloc_root);
 			if (ret)
 				return ret;
 			ret = btrfs_dec_ref(trans, root, buf, true);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 527310f3aeb3..f3d33d7a2376 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5875,18 +5875,11 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 
 	if (wc->refs[level] == 1) {
 		if (level == 0) {
-			if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
-				ret = btrfs_dec_ref(trans, root, eb, true);
-				if (ret) {
-					btrfs_abort_transaction(trans, ret);
-					return ret;
-				}
-			} else {
-				ret = btrfs_dec_ref(trans, root, eb, false);
-				if (unlikely(ret)) {
-					btrfs_abort_transaction(trans, ret);
-					return ret;
-				}
+			const bool full_backref = (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF);
+			ret = btrfs_dec_ref(trans, root, eb, full_backref);
+			if (unlikely(ret)) {
+				btrfs_abort_transaction(trans, ret);
+				return ret;
 			}
 			if (btrfs_is_fstree(btrfs_root_id(root))) {
 				ret = btrfs_qgroup_trace_leaf_items(trans, eb);
-- 
2.51.2


