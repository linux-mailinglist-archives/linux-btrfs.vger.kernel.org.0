Return-Path: <linux-btrfs+bounces-4810-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3208BEB46
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0613528232F
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 18:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634C216D9C3;
	Tue,  7 May 2024 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="wPSVknv2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888216D9A3
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105555; cv=none; b=Hvmj5TxEJjxFz4AhvE+u1GkX4W0IfvOPOdBjp1s6BWZneq6dvi9WnKmqhgDvfEh6TnrY3XoRu6v1Bx8HQ/y88JiLNz5Qq1uZkHNnvSUwBT6CwrtTWfSAG1CRD/tTvPvTJ0dOMun7iCLRMhQ4xz93xCPRqeqQRja7QvaN3hB9RVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105555; c=relaxed/simple;
	bh=ozJn28uetYl5jqiL3j5NZpx3Fnew0O9VQZ9vES2z1mY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCW1izf7+UrlC1j5sJm4uOhHS63Y1bUtu0WcsWzpwdpsrEd//y+VsDy2BPE8FTDSg5m17h+vs0XdLnjUhpIUDf1kLqUIASVkd4j6m6rs5vjhkFhn+LeCffVa3SjRME8x8yjHcLta2ck58u2Lhp2n4i4iUYPVzxKwrpXxZ9RKNkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=wPSVknv2; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-ddda842c399so3595713276.3
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715105553; x=1715710353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Zwz3T/FubqPGoNBdrjMLwZUNRumqym3HUPrJS3Jpvc=;
        b=wPSVknv2fY5K8Uc3onI7bHlkjRez4lFZpAoJi0vTI/s6IgfMG/eoQyoc/+9XsKxSYl
         IZ2rx2mku0aX55cPLgHWuaxrmKEQ40BoLimIrLh9SSVGk83bhQlnlev3yt6NHNRMOR/5
         /fvfaouwPRTTVyli8aZASZH9tsVfbAzIXoXp2mhqbMt7pF5bbooslzuxs8ZpRD6FVbzG
         0y4mpvyAdxBDQbUpPv/H7YCaODFzyP6swJozyZnfMhBezNsL2KuF3iM6CAPbWyQvlAQv
         uuvhm8w/8R8Kr7kN7XBFhsLAxme6gXaIGFsX6zUzW5a2KqIcw2K/vhKJRongsFIvjx95
         wwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105553; x=1715710353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Zwz3T/FubqPGoNBdrjMLwZUNRumqym3HUPrJS3Jpvc=;
        b=WMvUrrf3ad0Z9ll1S+TmSFVF55HHqqygmYtm4VusWVkD6wuDBCTGD7qp85dJ+/GYxY
         KSSaM0zQMkIEqS9Nl3TZGR52OjSBrcs5Aawy7ieF+QJ3wfHh3ptr7WpjRL+FHJOjp9gS
         bdhXfSqnrsXGAzFkxOOssP6anrLIQ5ng+NQZVfMyaufPEPco79A9NyQXIkyjYr2CoBtJ
         nWsVlH7RN9g+6QJVxKRfJkH7lmcRQlbflM19iG/TS82sYCErFAqxKFBQBX9yb4dTe6q0
         nO52kqE61+kRMk+97+VG6kd/vKxRYS7JgdBxj5W1fJ4dQbauhdQ1Xs6+purNmuaJ3TkW
         7EKA==
X-Gm-Message-State: AOJu0YzBeu2f6Jsbf6b91NDL1LwqDwBDHnJpUrVu4qWz8x10GTWGmTpl
	QfhFX2HQQpkm8Jc4asexEFhR5Iiks3G9FFlS19VF1e1uhy+YQA9ZiWVnCIFF4Me+TBpxZjGOdMr
	6
X-Google-Smtp-Source: AGHT+IHXFHFi7r35/Dvn9zLGPado0I83Mdpqrizd4TrgYEBG6jGugDoVNA2gwAQX/rCh/EDCzMqkdg==
X-Received: by 2002:a25:c5ce:0:b0:de6:86f:c6a4 with SMTP id 3f1490d57ef6-debb9dbaca2mr605840276.44.1715105552960;
        Tue, 07 May 2024 11:12:32 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z2-20020a256642000000b00de8347331dcsm2690420ybm.55.2024.05.07.11.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:12:32 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 08/15] btrfs: extract the reference dropping code into it's own helper
Date: Tue,  7 May 2024 14:12:09 -0400
Message-ID: <f6907b7026ebac0e7226af2e2ede21d7dec5b4db.1715105406.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715105406.git.josef@toxicpanda.com>
References: <cover.1715105406.git.josef@toxicpanda.com>
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


