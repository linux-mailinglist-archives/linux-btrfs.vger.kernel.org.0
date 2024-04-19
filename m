Return-Path: <linux-btrfs+bounces-4446-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02BF8AB4F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD801C221B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D76713CA99;
	Fri, 19 Apr 2024 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="OCtfy1ft"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3525213C9B7
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550646; cv=none; b=iRTrpbg9mgbMq0qka1PSGyIGl8kGZTmtnasz4DvTGqeTcgZAPJMpeeU/p379ReezIXF2OR0iT9AMxZzJG86RFuDIH3eC++TY/lAwvQkuWuzue2bX+GxGz9Nv9u/xlU/olTctnNouk2uOUOrkMRyCSPvmZ0UNqzn8n6jeWTOt51s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550646; c=relaxed/simple;
	bh=9V1jrNqGT4ZaVoFUuXe/yvpYV2aIif5YUidm2WO9u4s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGfEeALKkSQLlUzDvWC/apZwTa2HZlJiR/ymPOh+fGmB7fsC3gkM5pR4jFAPIWG7mMgTpAmaeqyY1K22hGTAbVKRJRYLqYwoGN0hDA1m4ugyD+djf8xu2dkV1onWiRYbfpLDVrE/+b1Y8y5G9WjeZ92ALTA9VPFB7vZx8p5KTdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=OCtfy1ft; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5aa2551d33dso1360362eaf.0
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713550644; x=1714155444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCf7JUkjr9rRK3v84J+022TilJaTvc2e9eYvXNXyTas=;
        b=OCtfy1ftBA4ORmvTsrfAIZcqR1tHl27R+K95QJoN05CGYtljrQqE8nH8nNeelkcBPO
         YTLagEKcZkaNyqjI3aCsixRkmDgo6OEzGi0jGczVHG3xVjHcDP0WEtoKLw6pOS6fRBFq
         rnxsCRuE4pxjYbo6o2XENzILP2WC7rmiX6xjOzPXcPC5QqYFIiNq/3PNew6uVRQH4tMz
         KZxV2/N/eFj35jlJkB5PklB+2gW4Wdi2hQQ6EZtONZRKoCqAMuP2EpOeVBS5S/+cuJkH
         KNAaslAWYjKJrM8YnxQBzuf20aaznHesSOEqeLAWyqwgnVJgHecPx/EIxaF5GYzFHSuJ
         bZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550644; x=1714155444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCf7JUkjr9rRK3v84J+022TilJaTvc2e9eYvXNXyTas=;
        b=ur3IAOK1fetEO+H9ilnzCbKE24ideHpjf5PlJWZvjvCaYWZphkgt1CzCdYh2PokAqb
         tSXOfCLBQGWYT6DfWC9T1FTfpVEQUxtBZ9XlSEJUiDe7eKdtYX5epTGAVpma4+24KWrk
         B9aYzKXfdn7vToxPRMc7ixDf3/U84ICyFwzEhyPJUtzZc4KcUT5u0WbeceKf0V3kEfzO
         2gXsiwuxX8/n0hVr7q7oLAK913c3KHoYP1C4iSeuQCkypyDURLnXJG+p743ddlCox35E
         aALAcgtia6OYcmcWmkLRZ4YSXXNoC1SmiboZKDxVOajSrSoNbbCb9lgaW7zdCzj/SCvP
         2O0g==
X-Gm-Message-State: AOJu0Yxc6M95qPIxN8wq00IQ0Qm7VKjpFGU+9pQKwgCi4ZDdmY/A8Lw8
	0ukzbFgCIZGYixkDqI4M+5CUFjyqFJ3qwPK1+yospk8kyXfL+hf4Atu+8yHiVx8g+tn8eLKk0tw
	b
X-Google-Smtp-Source: AGHT+IGaIuFiw9LUy/3oubU07vr5MZmFlmuQbZHmjkncNkU9JlWcuT81c/E5pLuGV2G5JfzJqGmW1A==
X-Received: by 2002:a05:6358:5bd0:b0:17f:2811:921c with SMTP id i16-20020a0563585bd000b0017f2811921cmr3719626rwf.27.1713550644174;
        Fri, 19 Apr 2024 11:17:24 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o7-20020a0c8c47000000b0069b4cc9780fsm1782512qvb.2.2024.04.19.11.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:17:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 08/15] btrfs: extract the reference dropping code into it's own helper
Date: Fri, 19 Apr 2024 14:17:03 -0400
Message-ID: <b87a28aa7c81c868cf544069cbd8f43591b9536e.1713550368.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713550368.git.josef@toxicpanda.com>
References: <cover.1713550368.git.josef@toxicpanda.com>
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
index 0f3c1ce27d17..17dabedda997 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5510,6 +5510,95 @@ static int check_next_block_uptodate(struct btrfs_trans_handle *trans,
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
@@ -5608,76 +5697,9 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
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


