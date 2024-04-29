Return-Path: <linux-btrfs+bounces-4611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E688B59F2
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F81428CE31
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B5074E09;
	Mon, 29 Apr 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JuvY6HMZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A5374BE2
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397407; cv=none; b=lk/dLrTQ1PNsu3/sBVbI6IQUlLjtiuHq8JlwHxOb0K5VvGj6Fli7PFwD0c3Tt45fPSs6+c24aG7LL4iOFEGtLTZ+cD3WHl//5dz4MK9uj+1BVt0tJr1atfXVbeQYdDUjc+OKGJdBJoYD7cHdlggmm5OFvnhvMb4Sz34kY9eBu08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397407; c=relaxed/simple;
	bh=ozJn28uetYl5jqiL3j5NZpx3Fnew0O9VQZ9vES2z1mY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vfa3mqbA/NVj/Sp/k96MjqLaARTwedTd8y1aIx596Nmzzh+hiVPdGLQhZTRDKXDVC+Gt9ASGS6htqH1gPECNHpQtIb4yqGjKsUq3NsNsUkzXAPOV9m1VjPia2nyBGkOG1YPwdgdynLYMqsX3N+fU+8wLxnYgREAT4KrcMQOGNZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JuvY6HMZ; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c84bb69c6fso2385063b6e.3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714397405; x=1715002205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Zwz3T/FubqPGoNBdrjMLwZUNRumqym3HUPrJS3Jpvc=;
        b=JuvY6HMZSyHIqTbNVqLuyXr/9eRxTZ0D6jOZGlZVPQWBioql7fJcQhHagVdm4bKzQH
         qm9ukigYOHBlvJDqQ1FSlopf17VIy0j5D4PWTjEeOMoPX8eedoDbIOF/Vd0r6YUAL/w7
         fSiJvFMlroisYh2u+JtY0yBjvyDiOH4ysxprQnTOTvHtNPnIQFQYnGD1MR2JM3H8ciX2
         zH1qPHQw5SlVumJdMocCuVhT2/9EUILGbfQrZWfSfc4vwBaaLzZ5kQqDfMv/MVEby9CI
         Q71PHxW4FHan3UTJLRPT81K8tijdS2GW78lJxIcAF/i8hM5SC3rLX7Jh6O9x9ew/NbeX
         YaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397405; x=1715002205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Zwz3T/FubqPGoNBdrjMLwZUNRumqym3HUPrJS3Jpvc=;
        b=bA42rB566e+Eao2CRggICa0RHW1Cnmgq0w0x9txWAOQiQBzhOvO9LyRxyptDD65Dso
         w5Ien02IoNu6mD+MZNJJ88RnR5chLoG7sIW3SoJbQgjzRv5G11b5uFa7fq4waj3wlrku
         r3Kv9Fh32ByBMU68Nlvu9ah+UcrXCXsDtZvORITxnPLZ7zO4Okj5EUHunJxu1Sc6Vm7a
         ufstJGqTG/opPhVdnEbgyuBIRJjwEgkHeHpDBbLuE9HeUYIaI9AyvP6eEXBvNVDI38D/
         zHV9GKxLdgdUH8HwhIJGbcGI9ipSrZNGZpXAeCRE4ibI4mo5pCION2KiGA5K0OQyC5nJ
         yH+Q==
X-Gm-Message-State: AOJu0YwRr0febv4aUppCIGZcfZNqDQI2U1oKFU2q3BGBKTYtaVnk9hr5
	T60bAwiXJlcn6fYnb3otOspdfxjk2ge6LZ0H3jNrjVTVAT18xAT0RyIKRRUYB6lKoyxuKoSSYhi
	P
X-Google-Smtp-Source: AGHT+IFdIqD10ClN5fuRnd1jLLTh+vVjqKJRfekuRan3hXM8k/nW5EWTWdpwy7kpH5127kIx9vbWIA==
X-Received: by 2002:a05:6808:10d5:b0:3c8:63b3:777c with SMTP id s21-20020a05680810d500b003c863b3777cmr5623268ois.30.1714397405176;
        Mon, 29 Apr 2024 06:30:05 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g12-20020a0cf08c000000b006913aa64629sm10368812qvk.22.2024.04.29.06.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:30:04 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 08/15] btrfs: extract the reference dropping code into it's own helper
Date: Mon, 29 Apr 2024 09:29:43 -0400
Message-ID: <411124bc3bfdedd085596a8ab645cc43b44c21d9.1714397223.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714397222.git.josef@toxicpanda.com>
References: <cover.1714397222.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a big chunk of code in do_walk_down that will conditionally
remove the reference for the child block we're currently evaluating.
Extract it out into it's own helper and call that from do_walk_down
instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 162 +++++++++++++++++++++++------------------
 1 file changed, 92 insertions(+), 70 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4c6647760aa5..bf59e2f00ff8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5509,6 +5509,95 @@ static int check_next_block_uptodate(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
+/*
+ * If we determine that we don't have to visit wc->level - 1 then we need to
+ * determine if we can drop our reference.
+ *
+ * If we are UPDATE_BACKREF then we will not, we need to update our backrefs.
+ *
+ * If we are DROP_REFERENCE this will figure out if we need to drop our current
+ * reference, skipping it if we dropped it from a previous incompleted drop, or
+ * dropping it if we still have a reference to it.
+ */
+static int maybe_drop_reference(struct btrfs_trans_handle *trans,
+				struct btrfs_root *root,
+				struct btrfs_path *path,
+				struct walk_control *wc,
+				struct extent_buffer *next,
+				u64 owner_root)
+{
+	struct btrfs_ref ref = {
+		.action = BTRFS_DROP_DELAYED_REF,
+		.bytenr = next->start,
+		.num_bytes = root->fs_info->nodesize,
+		.owning_root = owner_root,
+		.ref_root = btrfs_root_id(root),
+	};
+	int level = wc->level;
+	int ret;
+
+	/* We are UPDATE_BACKREF, we're not dropping anything. */
+	if (wc->stage == UPDATE_BACKREF)
+		return 0;
+
+	if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
+		ref.parent = path->nodes[level]->start;
+	} else {
+		ASSERT(btrfs_root_id(root) ==
+		       btrfs_header_owner(path->nodes[level]));
+		if (btrfs_root_id(root) !=
+		    btrfs_header_owner(path->nodes[level])) {
+			btrfs_err(root->fs_info,
+				  "mismatched block owner");
+			return -EIO;
+		}
+	}
+
+	/*
+	 * If we had a drop_progress we need to verify the refs are set as
+	 * expected.  If we find our ref then we know that from here on out
+	 * everything should be correct, and we can clear the
+	 * ->restarted flag.
+	 */
+	if (wc->restarted) {
+		ret = check_ref_exists(trans, root, next->start, ref.parent,
+				       level - 1);
+		if (ret <= 0)
+			return ret;
+		ret = 0;
+		wc->restarted = 0;
+	}
+
+	/*
+	 * Reloc tree doesn't contribute to qgroup numbers, and we have already
+	 * accounted them at merge time (replace_path), thus we could skip
+	 * expensive subtree trace here.
+	 */
+	if (btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
+	    wc->refs[level - 1] > 1) {
+		u64 generation = btrfs_node_ptr_generation(path->nodes[level],
+							   path->slots[level]);
+
+		ret = btrfs_qgroup_trace_subtree(trans, next, generation, level - 1);
+		if (ret) {
+			btrfs_err_rl(root->fs_info,
+				     "Error %d accounting shared subtree. Quota is out of sync, rescan required.",
+				     ret);
+		}
+	}
+
+	/*
+	 * We need to update the next key in our walk control so we can
+	 * update the drop_progress key accordingly.  We don't care if
+	 * find_next_key doesn't find a key because that means we're at
+	 * the end and are going to clean up now.
+	 */
+	wc->drop_level = level;
+	find_next_key(path, level, &wc->drop_progress);
+
+	btrfs_init_tree_ref(&ref, level - 1, 0, false);
+	return btrfs_free_extent(trans, &ref);
+}
 
 /*
  * helper to process tree block pointer.
@@ -5607,76 +5696,9 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		wc->reada_slot = 0;
 	return 0;
 skip:
-	if (wc->stage == DROP_REFERENCE) {
-		struct btrfs_ref ref = {
-			.action = BTRFS_DROP_DELAYED_REF,
-			.bytenr = bytenr,
-			.num_bytes = fs_info->nodesize,
-			.owning_root = owner_root,
-			.ref_root = btrfs_root_id(root),
-		};
-		if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
-			ref.parent = path->nodes[level]->start;
-		} else {
-			ASSERT(btrfs_root_id(root) ==
-			       btrfs_header_owner(path->nodes[level]));
-			if (btrfs_root_id(root) !=
-			    btrfs_header_owner(path->nodes[level])) {
-				btrfs_err(root->fs_info,
-						"mismatched block owner");
-				ret = -EIO;
-				goto out_unlock;
-			}
-		}
-
-		/*
-		 * If we had a drop_progress we need to verify the refs are set
-		 * as expected.  If we find our ref then we know that from here
-		 * on out everything should be correct, and we can clear the
-		 * ->restarted flag.
-		 */
-		if (wc->restarted) {
-			ret = check_ref_exists(trans, root, bytenr, ref.parent,
-					       level - 1);
-			if (ret < 0)
-				goto out_unlock;
-			if (ret == 0)
-				goto no_delete;
-			ret = 0;
-			wc->restarted = 0;
-		}
-
-		/*
-		 * Reloc tree doesn't contribute to qgroup numbers, and we have
-		 * already accounted them at merge time (replace_path),
-		 * thus we could skip expensive subtree trace here.
-		 */
-		if (btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
-		    wc->refs[level - 1] > 1) {
-			ret = btrfs_qgroup_trace_subtree(trans, next,
-							 generation, level - 1);
-			if (ret) {
-				btrfs_err_rl(fs_info,
-					     "Error %d accounting shared subtree. Quota is out of sync, rescan required.",
-					     ret);
-			}
-		}
-
-		/*
-		 * We need to update the next key in our walk control so we can
-		 * update the drop_progress key accordingly.  We don't care if
-		 * find_next_key doesn't find a key because that means we're at
-		 * the end and are going to clean up now.
-		 */
-		wc->drop_level = level;
-		find_next_key(path, level, &wc->drop_progress);
-
-		btrfs_init_tree_ref(&ref, level - 1, 0, false);
-		ret = btrfs_free_extent(trans, &ref);
-		if (ret)
-			goto out_unlock;
-	}
-no_delete:
+	ret = maybe_drop_reference(trans, root, path, wc, next, owner_root);
+	if (ret)
+		goto out_unlock;
 	wc->refs[level - 1] = 0;
 	wc->flags[level - 1] = 0;
 	wc->lookup_info = 1;
-- 
2.43.0


