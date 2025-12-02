Return-Path: <linux-btrfs+bounces-19449-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ADFC9A8E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 08:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CFFB3460B6
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 07:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A680E302CC6;
	Tue,  2 Dec 2025 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrzZf/9F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4191D514E
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764661789; cv=none; b=mLy/CGtZJXGnUjD/HpxpyomNM43bv+1PtY07Fe/17KnN5n4oN0c75m7onVDNnFcHuMsUWGiA9S3TRKGY+MzxkqHfWkWb/L7MQcY8fJBvbW6v/A3RPwgiLRUD0IVWva4/6k2jq42C6MOC5ncnKtuN2NInn6yDr2bisl6lVpVGO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764661789; c=relaxed/simple;
	bh=k2Sp+wBaOkFrso6NGPFr0k9/Gz9OhN2TLA/rbRgOOik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6Se4jsW3wZqnltrZG4SQbuHydMf2kDbk23W+k6Jz57RycSb0LTO91m6cPgMqlj+QUJvyBWC1aKVP8n7+3sVDsDdImtUk9FsOGekby6z9eW6rMYfAfAxttFoGdba/uuvVcj46Zg/jzXOOBWdJ2DSpgrOZS1DM8cAYIfv0+3MmhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrzZf/9F; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-297dfb8a52dso7371365ad.0
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Dec 2025 23:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764661787; x=1765266587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qviwB2uTgeCNqqajmf6sHdc2PHS5TA2BGQT4/8ZAsOs=;
        b=UrzZf/9F8duwxHleYdJt+VDW7Uxz7WCxTi+jMnJ6kk8GztE+tWTuwdHn3TW31+/8R/
         NsN2BxjyuEIQ05pDIeXdU7kbSe1gf3+bO/PwYLZ/lvA8VwEfaCNw8L/rxAAdxIHyizPW
         +FlI6nbP7n/FUB1Gud2/YoTLobfCchMqpHFoaj1faJJ8JU/z4+NOYC/ixumFa3CNExbw
         rjzNKexhz5JZHNRNVMJ0C6uQ8fcy467JsF6KLFH5m07mtbKIVbWulUur4TqVhavX/AnA
         rb1U7blMFINjoA+YHZl1P2bSVQSlLzILXdeQbeyZRgSKdYPqB0dbigEum8l/UgwNLBEA
         fGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764661787; x=1765266587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qviwB2uTgeCNqqajmf6sHdc2PHS5TA2BGQT4/8ZAsOs=;
        b=TiWF4besTYD3bEnPMmDNsIB8pJ+lvVEscC0CjYQJjBfqotDSqQ96SSti+DTf2ALRvX
         OVxhYZEdzHQPNnvGHi6y6enXOzEx93ImMZ73o9MHqg2DHOYRl+ytaXP35OLxKTqJ3DXU
         aNhhzBovKdOFU/ftx/+e6lQKMxFJMqnszGXvgYkjAKcGLmeWeLELE+tWGjPHdHDbmB24
         fWyMjrQesvELGrlrnwjXWCzDgpGE8gNFA5IWy6O/cxqc1LnXY127YqvBQs2OjWdgINry
         vbFa3NLFxP9aOvoZEMyXVu+AHNP9ikApYSGnjwkR3Hja0KejzQUqcevmNIHdQH4w/wFf
         CxSA==
X-Gm-Message-State: AOJu0YyfKXNe9hRVU6WhaandsULokt/cv/QH1XjZabDRxVBt3ExviXIx
	QREmiXfQFJ+mEe1nQJavRpWtROPzCHmaXNgJBLTjR1HiF1j9yTkm7uto/Iht0s78Fv9LcA==
X-Gm-Gg: ASbGncvYZ1D/S3JAwOpolNYou6O3aRMEa3jIyK1Nl16sYuFsXzH1pLnwu1nB8ttfkqm
	P/OXBFmNiPOYKbpJlGq/q4vLB2yh58sorphLGaJFZZ60/O197wi8BwEPpTAd6LxsvlIIREr88rE
	oS1PEpx9dZdrz48TmnXAtXFl+PjN36Odr5xZ5kGCLRXvNiqFpdbxg4UibqC+kTA+wuAt3BHjVkz
	IYpaK34Hd3SqOhfPkrBCzjoalfB3vIFRUJ+E5jO7UKEXcEbdACypEijb7pI3ph66iVAqRu2Mwg/
	ZJZF5g1TIu4+sYSMu93HBeecQ+arNvMzOrQ42j0ZDk+Smk+aGJ5ZoDFmb+OWcdghO0qBykYTsfe
	LHPOP3VE9fQ0EW1pG4F/+onWXytJBYi75EuKpXp9ysybgAcB0aeRhmSs7c+ry0yxqKGO/bsFqAK
	7hgioYJRvsfCnVXQJY30mQmRgatFrwS0W6PAJIYGx77l9QiRCOr2k=
X-Google-Smtp-Source: AGHT+IEZMez4d10nsFmG545CWvdhAhqtrDnHVXlMKlbA6iqLl9H+jIKbYxILRJ3K/oU2Ij7kAy1LVw==
X-Received: by 2002:a17:903:2ec6:b0:298:9a1:88e8 with SMTP id d9443c01a7336-29b7022ca2bmr242027635ad.5.1764661786609;
        Mon, 01 Dec 2025 23:49:46 -0800 (PST)
Received: from SaltyKitkat (tk2-102-53910.vs.sakura.ne.jp. [59.106.191.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb277f9sm142787785ad.46.2025.12.01.23.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 23:49:46 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH] btrfs: drop @update_ref for btrfs_drop_snapshot()
Date: Tue,  2 Dec 2025 15:47:20 +0800
Message-ID: <20251202074930.6672-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of making every caller decide @update_ref, let
btrfs_drop_snapshot() figure it out itself using @for_reloc and
backref_rev of the root node.

Callers that passed 'false' for for_reloc now get the right
behaviour automatically; callers that passed 'true' continue to
skip the update because for_reloc implies !update_ref.

Fix the comment accordingly. Also fix the comment which is rewritten
wrongly in commit 67e78f983e6a1("btrfs: convert several int parameters to bool")

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/extent-tree.c | 10 ++++++----
 fs/btrfs/extent-tree.h |  2 +-
 fs/btrfs/relocation.c  |  4 ++--
 fs/btrfs/transaction.c |  6 +-----
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index dc4ca98c3780..b794ddeb497a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6047,15 +6047,14 @@ static noinline int walk_up_tree(struct btrfs_trans_handle *trans,
  * referenced by the tree.
  *
  * when a shared tree block is found. this function decreases its
- * reference count by one. if update_ref is true, this function
+ * reference count by one. If for_reloc is false, this function
  * also make sure backrefs for the shared block and all lower level
  * blocks are properly updated.
  *
- * If called with for_reloc set, may exit early with -EAGAIN
+ * If called with for_reloc == false, may exit early with -EAGAIN
  */
-int btrfs_drop_snapshot(struct btrfs_root *root, bool update_ref, bool for_reloc)
+int btrfs_drop_snapshot(struct btrfs_root *root, bool for_reloc)
 {
-	const bool is_reloc_root = (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID);
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_path *path;
 	struct btrfs_trans_handle *trans;
@@ -6066,6 +6065,9 @@ int btrfs_drop_snapshot(struct btrfs_root *root, bool update_ref, bool for_reloc
 	const u64 rootid = btrfs_root_id(root);
 	int ret = 0;
 	int level;
+	const bool is_reloc_root = (rootid == BTRFS_TREE_RELOC_OBJECTID);
+	const bool update_ref = (!for_reloc &&
+				 btrfs_header_backref_rev(root->node) >= BTRFS_MIXED_BACKREF_REV);
 	bool root_dropped = false;
 	bool unfinished_drop = false;
 
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index e970ac42a871..b38220744a06 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -155,7 +155,7 @@ int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans,
 			      const struct extent_buffer *eb);
 int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
 int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans, struct btrfs_ref *generic_ref);
-int btrfs_drop_snapshot(struct btrfs_root *root, bool update_ref, bool for_reloc);
+int btrfs_drop_snapshot(struct btrfs_root *root, bool for_reloc);
 int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root,
 			struct extent_buffer *node,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 0765e06d00b8..34621666f06e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1483,7 +1483,7 @@ static int clean_dirty_subvols(struct reloc_control *rc)
 				 * ->reloc_root.  If it fails however we must
 				 * drop the ref ourselves.
 				 */
-				ret2 = btrfs_drop_snapshot(reloc_root, false, true);
+				ret2 = btrfs_drop_snapshot(reloc_root, true);
 				if (ret2 < 0) {
 					btrfs_put_root(reloc_root);
 					if (!ret)
@@ -1493,7 +1493,7 @@ static int clean_dirty_subvols(struct reloc_control *rc)
 			btrfs_put_root(root);
 		} else {
 			/* Orphan reloc tree, just clean it up */
-			ret2 = btrfs_drop_snapshot(root, false, true);
+			ret2 = btrfs_drop_snapshot(root, true);
 			if (ret2 < 0) {
 				btrfs_put_root(root);
 				if (!ret)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 89ae0c7a610a..545930840a4a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2652,11 +2652,7 @@ int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info)
 
 	btrfs_kill_all_delayed_nodes(root);
 
-	if (btrfs_header_backref_rev(root->node) <
-			BTRFS_MIXED_BACKREF_REV)
-		ret = btrfs_drop_snapshot(root, false, false);
-	else
-		ret = btrfs_drop_snapshot(root, true, false);
+	ret = btrfs_drop_snapshot(root, false);
 
 	btrfs_put_root(root);
 	return (ret < 0) ? 0 : 1;
-- 
2.51.2


