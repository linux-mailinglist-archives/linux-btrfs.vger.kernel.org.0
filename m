Return-Path: <linux-btrfs+bounces-8501-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7349C98F2F4
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 17:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B92E1F22C35
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931101AAE27;
	Thu,  3 Oct 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="MkGJ4i1M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F551A704C
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970204; cv=none; b=FdaNOXnb5rcnxbkYmx3tlsSoF8+4ols5aB0uWiqP2q5u80v293W1xOxLt2wPODJEoDYuHh2gc2Sk10Q5I4jdYiD6I3/rN0dETr7wnHByB7wM+1ZpyIC/m449MMtZ+ryu5kpnN80zzZ+ogD4dfnefJAml9nnD5m7v6tI0RwzButM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970204; c=relaxed/simple;
	bh=5gD+B7AbEDeZXrWFRBaQb41DQ04mzuC1RXm031w6V/Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MuxnQUTus8MpzTtocg9jVGPregj64206Xox6lr5XTWT+vDu1PX9x0jd0KdoZZ4i+G8mYaDOV196ABBH7nPM2/xslb2duD+KpBpJWToYvM/IV+x/ZsGepSMKHKw7fTaGidonyZWEiE51T9miWPvO2qO55BAk60DlkVk0AmdTRdi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=MkGJ4i1M; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cb399056b4so9034086d6.0
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 08:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727970201; x=1728575001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wdPQAB1FTb7S1tvD/OywsaJyCqlsWezBshNy8mjVi0=;
        b=MkGJ4i1MvuuVh6DhJfH/uy+LvVv7VoQ6eC9k7xGCibfw0bFMALvEGGW1aqHcjrtfF7
         MzM05Yo/VbDLUmAFRtNr6HLiFueSWJAk3v+DxeNDNjICFXrb0BJd9L8JtvJenV/au/kM
         EaM6Ckq+sL7p8MMiqtLpfPwmt1gKwA8/f57v3LcKFR2zoDH8oBexLTxQ3HUP9zdA+FHP
         reyt9pJmrn80rYyax80tQ/ok+XUe15i7zS8pX9HAIfRobDfwiXZkzMlKqBoSFHgvsv5K
         j/cSxzDyq17+5Da1jnW73pNZPikLtjXkLUeL0/a7fhDXzDsXlHFkUfdM1m6DTO9YzEHi
         r8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970201; x=1728575001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wdPQAB1FTb7S1tvD/OywsaJyCqlsWezBshNy8mjVi0=;
        b=aYRzpWthLFkl1d3dDjVByzbWAJdGJQBQOGvArCIO1hnhK7alM4lXZLozxyPgE8n0/q
         NXqxZXz7tEryjjzsB2RlSBDfu1JGSVuz1oV2rmR8z/1wImo32XmzRgK8GXTXdw+2s0JJ
         mJZ2vq374JtmoonHleC/n2+NsFr/ilCCtr4tNJgni2e3mYXi1DqFY1pCgA/eeXBgp7Ns
         iUjlwXOanw04/IWZGWudYr04p0B93ensMqIBmG57XBR3w2AOokrFnC4rg6zCE6x67en2
         Bi6+NZptZpFVYaRbktS0qmOyjaK7Z+ZZfqatu9lSiKKi1rZmo8pVGFOhhFNM08WCQfQY
         QkgA==
X-Gm-Message-State: AOJu0YwlPvPRtWQBUliFImkUNT9dW86PeGOwJeoiCV+U8CODabeuh5v0
	vVucDBOuI9+J+aGT41vQ79yHVRvKDlnR5qey9MUSaLAXfxyct7CCGhvGOWD2PRlU/d+tROC4Pmd
	j
X-Google-Smtp-Source: AGHT+IHlJRsvfPRk2Xh7gYxAx3lTw0eZM0zDxnO+XS8f8nA+hFkk4xVtiR4NTFmepM07+dhyF8zOxA==
X-Received: by 2002:a05:6214:5408:b0:6cb:5aa6:97a with SMTP id 6a1803df08f44-6cb81a37809mr113703956d6.24.1727970201521;
        Thu, 03 Oct 2024 08:43:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb93825f60sm7345276d6.140.2024.10.03.08.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:43:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 02/10] btrfs: remove the changed list for backref cache
Date: Thu,  3 Oct 2024 11:43:04 -0400
Message-ID: <53461c08f218c675481446a79c242b687dea345f.1727970063.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727970062.git.josef@toxicpanda.com>
References: <cover.1727970062.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we're not updating the backref cache when we switch transids we
can remove the changed list.

We're going to keep the new_bytenr field because it serves as a good
sanity check for the backref cache and relocation, and can prevent us
from making extent tree corruption worse.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c    |  2 --
 fs/btrfs/backref.h    |  2 --
 fs/btrfs/relocation.c | 22 ++++++++--------------
 3 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index f8e1d5b2c512..881bb5600b55 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3021,7 +3021,6 @@ void btrfs_backref_init_cache(struct btrfs_fs_info *fs_info,
 	cache->rb_root = RB_ROOT;
 	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
 		INIT_LIST_HEAD(&cache->pending[i]);
-	INIT_LIST_HEAD(&cache->changed);
 	INIT_LIST_HEAD(&cache->detached);
 	INIT_LIST_HEAD(&cache->leaves);
 	INIT_LIST_HEAD(&cache->pending_edge);
@@ -3189,7 +3188,6 @@ void btrfs_backref_release_cache(struct btrfs_backref_cache *cache)
 	}
 	ASSERT(list_empty(&cache->pending_edge));
 	ASSERT(list_empty(&cache->useless_node));
-	ASSERT(list_empty(&cache->changed));
 	ASSERT(list_empty(&cache->detached));
 	ASSERT(RB_EMPTY_ROOT(&cache->rb_root));
 	ASSERT(!cache->nr_nodes);
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index e8c22cccb5c1..a810253d7b8a 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -393,8 +393,6 @@ struct btrfs_backref_cache {
 	struct list_head pending[BTRFS_MAX_LEVEL];
 	/* List of backref nodes with no child node */
 	struct list_head leaves;
-	/* List of blocks that have been COWed in current transaction */
-	struct list_head changed;
 	/* List of detached backref node. */
 	struct list_head detached;
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3c89e79d0259..ac3658dce6a3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2113,14 +2113,13 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 		if (next->new_bytenr != root->node->start) {
 			/*
 			 * We just created the reloc root, so we shouldn't have
-			 * ->new_bytenr set and this shouldn't be in the changed
-			 *  list.  If it is then we have multiple roots pointing
-			 *  at the same bytenr which indicates corruption, or
-			 *  we've made a mistake in the backref walking code.
+			 * ->new_bytenr set yet. If it is then we have multiple
+			 *  roots pointing at the same bytenr which indicates
+			 *  corruption, or we've made a mistake in the backref
+			 *  walking code.
 			 */
 			ASSERT(next->new_bytenr == 0);
-			ASSERT(list_empty(&next->list));
-			if (next->new_bytenr || !list_empty(&next->list)) {
+			if (next->new_bytenr) {
 				btrfs_err(trans->fs_info,
 	"bytenr %llu possibly has multiple roots pointing at the same bytenr %llu",
 					  node->bytenr, next->bytenr);
@@ -2131,8 +2130,6 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 			btrfs_put_root(next->root);
 			next->root = btrfs_grab_root(root);
 			ASSERT(next->root);
-			list_add_tail(&next->list,
-				      &rc->backref_cache.changed);
 			mark_block_processed(rc, next);
 			break;
 		}
@@ -2442,7 +2439,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 
 	if (!ret && node->pending) {
 		btrfs_backref_drop_node_buffer(node);
-		list_move_tail(&node->list, &rc->backref_cache.changed);
+		list_del_init(&node->list);
 		node->pending = 0;
 	}
 
@@ -2605,8 +2602,7 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 			/*
 			 * This block was the root block of a root, and this is
 			 * the first time we're processing the block and thus it
-			 * should not have had the ->new_bytenr modified and
-			 * should have not been included on the changed list.
+			 * should not have had the ->new_bytenr modified.
 			 *
 			 * However in the case of corruption we could have
 			 * multiple refs pointing to the same block improperly,
@@ -2616,8 +2612,7 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 			 * normal user in the case of corruption.
 			 */
 			ASSERT(node->new_bytenr == 0);
-			ASSERT(list_empty(&node->list));
-			if (node->new_bytenr || !list_empty(&node->list)) {
+			if (node->new_bytenr) {
 				btrfs_err(root->fs_info,
 				  "bytenr %llu has improper references to it",
 					  node->bytenr);
@@ -2640,7 +2635,6 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 			btrfs_put_root(node->root);
 			node->root = btrfs_grab_root(root);
 			ASSERT(node->root);
-			list_add_tail(&node->list, &rc->backref_cache.changed);
 		} else {
 			path->lowest_level = node->level;
 			if (root == root->fs_info->chunk_root)
-- 
2.43.0


