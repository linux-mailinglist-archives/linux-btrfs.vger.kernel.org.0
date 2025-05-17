Return-Path: <linux-btrfs+bounces-14101-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8E6ABAA7D
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 May 2025 15:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A937C17DC4A
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 May 2025 13:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73F71F55FA;
	Sat, 17 May 2025 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0ipUb5Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79527A957
	for <linux-btrfs@vger.kernel.org>; Sat, 17 May 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747489652; cv=none; b=HMHDlTiAPFD0q9QE1p7gAUOzBDFD4pT/axC7DmwTkUuyhJxYrSLLPtTqoES/2MlvAOUyak3DUndgZFETR0E9FUHa91lWlSxyz5ooJfIk259Bp+UxpnChrgboDaKXl9cX66jyslj7bCRkTfyhtjaWEqG2P5Gb9bogEhw87UkSwUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747489652; c=relaxed/simple;
	bh=+9yGuiYqKFpI6vIQIyg5uPAFqoBFsv+7yD/BOmayG6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfGhfyGvh/ApsRx28V4sPQny80DiCQLFmY1m7LDuJzWrn9uCgvFzH/aL9lblzPexeaDmtAcX2tFdBf5ptEeiKXUdO4uBtiEO3Kvrdqe6ebsuyxj55aZ5l2+hDYhc9fPPY2Q4FJNMUxWxfmXjT0XfXu9/0QolocqfdzJFxfDotjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0ipUb5Q; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-30e7d9e9a47so266169a91.3
        for <linux-btrfs@vger.kernel.org>; Sat, 17 May 2025 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747489650; x=1748094450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53vwS7lAa1NFsxXE5+tsyhuLFDMXlHeAtMDPKHXZUUM=;
        b=E0ipUb5QzSWyhSt7KB+57ML+O+WoKu+yIvq//cmw08i6qFw8bQGmwaz21wQ0QyP5Vw
         J1sX18SvvKeBI5D4BFB99H0uGP8xxgwNNKkM/pKdYOV1OVDkQhazEg1fLP2eC+xIL6PD
         blfrARW1VI26N/C8VyJTxAIQCKAxOyVGnVSvuy9BjPpT9/4eIQ3gzaYjlIXxLpHbfTse
         S1Y1nkWycAISpI+mmvpb1XoHdyrIrHBt4zTt2w/DavWdH54t71KKDzCY6YyZsXN4t/Mc
         aTiCwecKp9t5OG2z1WkfwlKsSIX+egB/tku8Pf0u7KutGGB8U8ThiF5LEHZmAiGGsupm
         aPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747489650; x=1748094450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53vwS7lAa1NFsxXE5+tsyhuLFDMXlHeAtMDPKHXZUUM=;
        b=ftpo3gn1RrjKVAue1IZBjkeK/du3yXWWjZZemobKYbCV8UHgEidN6AmrD3R2j0dvll
         Mbn9AdQVMLpS/Lsoz9ZbyY59fOJmqapVWlFr5e0y2UjEPzPeBn4Q3eRYU5MjB89ZffBA
         bhjh3LkrZAuOxxYpzH4mok1jzr7uWIYQ2zfAf1b2jM9DDFxH7MkBOtSA2Mxnu17Ig+eW
         1VH/FErepNxfxe9jWiKQPKYpzeOa6AcqzC5QbPustR8ax4vPfbIgmSWWnVQk3DQkrqEO
         KdRlFDXcUC7yH7IYqVlIBqqOMMh4k0Dg7g5joCyKuCYO0PhFHVjE7950zcjsTYwEnvao
         CTGA==
X-Gm-Message-State: AOJu0YzF9gtWFHTkfBrpNcKC6u2isb+YGnBZXDdw3AeeDZt/k1gfKi28
	0FTKuIWGlXrjr3w/VZ5u4Rfticp5aXllFyy03nBM6yS+lVLN0pJtPevz
X-Gm-Gg: ASbGncs8j9zOyB7s5vpi73xe0Y5EUPf+fXYKMZl0koZ5LePV/vpcTAwx2cVP0cbqIp7
	OoIz7oKhI7HUAjLeKcZVNHmNtj1Z61znfxbhHD6JBO1AM5sbpuLawreC71gK4fyZPYguH0Ab6rv
	lUXvwcZRADgqBMTW05TCCTCRJ4QXoGylcBgDQptfm0bt7K6ZTgEkENS66z278wsDGYMAuV2Wv24
	lxYRdK+B9FeyZKz/5pQXvzs5spI3ly2P0HgjTBMf/2hc/tFzP3LWM/7JBiZyaiQuXMJdEs3OZsQ
	lfLQK63YAy2vOe7vcwR3iXK43ponmaWj8HartrADyCrRGWtbFQ==
X-Google-Smtp-Source: AGHT+IHKF7gS8d59qbQQWjlBHpAvTXmv8pCOqmzLgBhjBqoyLfG/F2F19ye/8+9hmahu+wHtK7nM5Q==
X-Received: by 2002:a17:902:dacc:b0:223:5525:622f with SMTP id d9443c01a7336-231d43882f0mr33205405ad.1.1747489649545;
        Sat, 17 May 2025 06:47:29 -0700 (PDT)
Received: from SaltyKitkat.. ([154.3.35.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eba501sm30651205ad.173.2025.05.17.06.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 06:47:29 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: sunk67188@gmail.com
Cc: linux-btrfs@vger.kernel.org,
	dsterba@suse.cz
Subject: [PATCH v3] btrfs: remove nonzero lowest level handling in btrfs_search_forward()
Date: Sat, 17 May 2025 21:47:12 +0800
Message-ID: <20250517134723.25843-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2803405.mvXUDI8C0e@saltykitkat>
References: <2803405.mvXUDI8C0e@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 323ac95bce44 ("Btrfs: don't read leaf blocks containing only
checksums during truncate") changed the condition from `level == 0` to
`level == path->lowest_level`, while its origional purpose is just to do
some leaf nodes handling (calling btrfs_item_key_to_cpu()) and skip some
code that doesn't fit leaf nodes.

After changing the condition, the code path
1. also handle the non-leaf nodes when path->lowest_level is nonzero,
   which is wrong. However, it seems that btrfs_search_forward() is never
   called with a nonzero path->lowest_level, which makes this bug not
   found before.
2. makes the later if block with the same condition, which is origionally
   used to handle non-leaf node (calling btrfs_node_key_to_cpu()) when
   lowest_level is not zero, dead code.

Considering this function is never called with a nonzero
path->lowest_path for years and the code handling this case is wrongly
implemented, the path->lowest_level related logic is fully removed.

Related dead codes are also removed, and related goto logic is replaced
with if conditions, which makes the code easier to read for new comers.

This changes the behavior when btrfs_search_forward() is called with
nonzero path->lowest_level: now we will get a warning, and still use
0 as lowest_level. But since this never happens in the current codebase,
and the previous behavior is wrong. So the behavior change of behavior
will not be a problem.

The bevavior of the function called with a zero path->lowest_level, which
is acturally how this function is used in current codebase, should be the
same with previous version.

Fix: commit 323ac95bce44 ("Btrfs: don't read leaf blocks containing only checksums during truncate")
Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c | 58 ++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a2e7979372cc..32844277f2cd 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4592,8 +4592,9 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
  * into min_key, so you can call btrfs_search_slot with cow=1 on the
  * key and get a writable path.
  *
- * This honors path->lowest_level to prevent descent past a given level
- * of the tree.
+ * This does not honor path->lowest_level any more because this
+ * function is never called with a nonzero path->lowest_level and the
+ * implementation of handling it in this function is broken for years.
  *
  * min_trans indicates the oldest transaction that you are interested
  * in walking through.  Any nodes or leaves older than min_trans are
@@ -4615,6 +4616,7 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 	int keep_locks = path->keep_locks;
 
 	ASSERT(!path->nowait);
+	WARN_ON(path->lowest_level > 0);
 	path->keep_locks = 1;
 again:
 	cur = btrfs_read_lock_root_node(root);
@@ -4636,38 +4638,29 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 			goto out;
 		}
 
-		/* at the lowest level, we're done, setup the path and exit */
-		if (level == path->lowest_level) {
-			if (slot >= nritems)
-				goto find_next_key;
-			ret = 0;
-			path->slots[level] = slot;
-			/* Save our key for returning back. */
-			btrfs_item_key_to_cpu(cur, min_key, slot);
-			goto out;
-		}
-		if (sret && slot > 0)
-			slot--;
-		/*
-		 * check this node pointer against the min_trans parameters.
-		 * If it is too old, skip to the next one.
-		 */
-		while (slot < nritems) {
-			u64 gen;
-
-			gen = btrfs_node_ptr_generation(cur, slot);
-			if (gen < min_trans) {
+		if (level > 0) {
+			/*
+			 * Not at the lowest level and not a perfect match,
+			 * go one slot back if possible to search lower level.
+			 */
+			if (sret && slot > 0)
+				slot--;
+			/*
+			 * Check this node pointer against the min_trans parameters.
+			 * If it is too old, skip to the next one.
+			 */
+			while (slot < nritems) {
+				if (btrfs_node_ptr_generation(cur, slot) >= min_trans)
+					break;
 				slot++;
-				continue;
 			}
-			break;
 		}
-find_next_key:
+
+		path->slots[level] = slot;
 		/*
-		 * we didn't find a candidate key in this node, walk forward
-		 * and find another one
+		 * We didn't find a candidate key in this node, walk forward
+		 * and find another one.
 		 */
-		path->slots[level] = slot;
 		if (slot >= nritems) {
 			sret = btrfs_find_next_key(root, path, min_key, level,
 						  min_trans);
@@ -4678,12 +4671,13 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 				goto out;
 			}
 		}
-		if (level == path->lowest_level) {
+		/* At the lowest level, we're done. Set the key and exit. */
+		if (level == 0) {
 			ret = 0;
-			/* Save our key for returning back. */
-			btrfs_node_key_to_cpu(cur, min_key, slot);
+			btrfs_item_key_to_cpu(cur, min_key, slot);
 			goto out;
 		}
+		/* Search down to a lower level. */
 		cur = btrfs_read_node_slot(cur, slot);
 		if (IS_ERR(cur)) {
 			ret = PTR_ERR(cur);
-- 
2.49.0


