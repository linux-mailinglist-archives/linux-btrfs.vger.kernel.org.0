Return-Path: <linux-btrfs+bounces-9668-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 076C79C92BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 20:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819901F235DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 19:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173411AA1EB;
	Thu, 14 Nov 2024 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="QpwlG2zi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE417588
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614278; cv=none; b=g81JI8B1QXPgEtyS8FqclEo3a947KjNSUBGreGmo+yIbtEPhm5z6fQ1t6Qr3+axANiPIYUbV/HfIP6N4ww6kGxnN2IAjvY8FYKaDIFrmzfBBhHHlm0J+7jHTbDrY7oYXSHrcjbtXD4hR0t99uQOFggfOWXX2lLDYmNkaAtULnbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614278; c=relaxed/simple;
	bh=aFCmMxXh9+FiRSIzv7iQoJtuiQmUgdnnegLS+EnxSD4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g31tNFdMz/xEpSIrwqyDeDTzsvtOLtRAJZ/LbLMkKEuI61/ATBCvVVV1mbIECimehR7lcgwmVoJJGpdFcU3Jy+SNWiBgt5O/WebwzH1La0PQoHWtAjGuWUsBsUYSoJDyuWaef60hOjx5J2AFqDoKzwOjchY8uPUBTSbxYLOn3HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=QpwlG2zi; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e380f16217cso1104263276.1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 11:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731614275; x=1732219075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvHaG17u9XT6YIVlLpeuA2JcuwB02UhaTWo9xr0qVhM=;
        b=QpwlG2zib7Op9C1W19oKJJzqqCspUlzNaWoaZnKoOZ4fiPDi9/Ni4EiaEQAWXQR2pG
         i2lUd4hyFlCS4Bk++J0VXMO6asQlk3Jd76vVUm2rM7WbCOXxoygc3wx/fhKm4/8fZlfa
         DiQzz7oEIhp0ShB+6jMEoertn+Jklzn3GfLfgo9oNe+PnkY47uv1rBzUVGCStee0tIH0
         512fLEpW40dhw6onpsEgLIWo2lVtKANIy6HrzemIlSKlJzsveyQhu2HKACbZnLlm3cqI
         CCriNmG7w0SqQ0Gg8a8vgKCzZ0apzMJmFhAw6R2HWX1wPEtSx8cCsehma2DR7dIjrcH8
         DijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731614275; x=1732219075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvHaG17u9XT6YIVlLpeuA2JcuwB02UhaTWo9xr0qVhM=;
        b=o9cTp9pTCoPZcZPznWJsYkOJyNop46JLk6vtdVjgIiQSh1/gAQ8mRuvWV9uSdsYe32
         pQ95Ce9nnzvKLB7gQ6i/S3OKVbtaHZFDp10bX8Wh9jYdtBOPQZCG3ErJNa9h0Jp13sKh
         SFsrR+y0Icb60MgwPCcKm7EqIoLaM+uSNKpfkoMpUQiTxd0aUIusE+/QYPCQbJKmB9+W
         936Am2Kslm8VNy4apWn3RZ//fos+nnAncDTiKm7oxTLvo6RR5WCGsQwHfEM5b4KXYg3a
         8ypGmwhQTBWgkgcxLE1P0sFySdlHbG+TlHjx2KrMcWM0E1LiWZ0JFr8WBwXTQgsNj4Hv
         RXdw==
X-Gm-Message-State: AOJu0YxRPx0MHwXMoJ8Fzj1fk8YkMD1Y52o0Rv1WP5494OVwfmtW0brg
	6ZIINCGQbQYiD2j84UaPZiTy1SN6tt7IJEMFnCc4hcp/CGmhCjHUv6F3loM581FJA3wboKgkOO2
	T
X-Google-Smtp-Source: AGHT+IHwzHMIolSnBMEpkSQHh6kl/ZjJJ8OSbf5OBfAcL0D2L3uUrodU43rr5+rgO2MKI55yGJaOPA==
X-Received: by 2002:a05:6902:2607:b0:e38:131e:e990 with SMTP id 3f1490d57ef6-e38263a1bbfmr49071276.32.1731614274870;
        Thu, 14 Nov 2024 11:57:54 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38152f1b88sm485636276.32.2024.11.14.11.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:57:54 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: move select_delayed_ref and export it
Date: Thu, 14 Nov 2024 14:57:48 -0500
Message-ID: <7e8aaf2cda4467e52b0438fa7d617f29e15c7620.1731614132.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731614132.git.josef@toxicpanda.com>
References: <cover.1731614132.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This helper is how we select the delayed ref to run once we've selected
the delayed ref head.  I need this exported to add a unit test for
delayed refs, and it's more natural home is in delayed-ref.c.  Rename it
to btrfs_select_delayed_ref and move it into delayed-ref.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 27 +++++++++++++++++++++++++++
 fs/btrfs/delayed-ref.h |  2 ++
 fs/btrfs/extent-tree.c | 26 +-------------------------
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 0d878dbbabba..63e0a7f660da 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -555,6 +555,33 @@ void btrfs_delete_ref_head(const struct btrfs_fs_info *fs_info,
 		delayed_refs->num_heads_ready--;
 }
 
+struct btrfs_delayed_ref_node *btrfs_select_delayed_ref(
+		struct btrfs_delayed_ref_head *head)
+{
+	struct btrfs_delayed_ref_node *ref;
+
+	lockdep_assert_held(&head->mutex);
+	lockdep_assert_held(&head->lock);
+
+	if (RB_EMPTY_ROOT(&head->ref_tree.rb_root))
+		return NULL;
+
+	/*
+	 * Select a delayed ref of type BTRFS_ADD_DELAYED_REF first.
+	 * This is to prevent a ref count from going down to zero, which deletes
+	 * the extent item from the extent tree, when there still are references
+	 * to add, which would fail because they would not find the extent item.
+	 */
+	if (!list_empty(&head->ref_add_list))
+		return list_first_entry(&head->ref_add_list,
+				struct btrfs_delayed_ref_node, add_list);
+
+	ref = rb_entry(rb_first_cached(&head->ref_tree),
+		       struct btrfs_delayed_ref_node, ref_node);
+	ASSERT(list_empty(&ref->add_list));
+	return ref;
+}
+
 /*
  * Helper to insert the ref_node to the tail or merge with tail.
  *
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 611fb3388f82..ca9111a5779d 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -402,6 +402,8 @@ struct btrfs_delayed_ref_head *btrfs_select_ref_head(
 		struct btrfs_delayed_ref_root *delayed_refs);
 void btrfs_unselect_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
 			     struct btrfs_delayed_ref_head *head);
+struct btrfs_delayed_ref_node *btrfs_select_delayed_ref(
+		struct btrfs_delayed_ref_head *head);
 
 int btrfs_check_delayed_seq(struct btrfs_fs_info *fs_info, u64 seq);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 43a771f7bd7a..f765c74c14d9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1803,30 +1803,6 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static inline struct btrfs_delayed_ref_node *
-select_delayed_ref(struct btrfs_delayed_ref_head *head)
-{
-	struct btrfs_delayed_ref_node *ref;
-
-	if (RB_EMPTY_ROOT(&head->ref_tree.rb_root))
-		return NULL;
-
-	/*
-	 * Select a delayed ref of type BTRFS_ADD_DELAYED_REF first.
-	 * This is to prevent a ref count from going down to zero, which deletes
-	 * the extent item from the extent tree, when there still are references
-	 * to add, which would fail because they would not find the extent item.
-	 */
-	if (!list_empty(&head->ref_add_list))
-		return list_first_entry(&head->ref_add_list,
-				struct btrfs_delayed_ref_node, add_list);
-
-	ref = rb_entry(rb_first_cached(&head->ref_tree),
-		       struct btrfs_delayed_ref_node, ref_node);
-	ASSERT(list_empty(&ref->add_list));
-	return ref;
-}
-
 static struct btrfs_delayed_extent_op *cleanup_extent_op(
 				struct btrfs_delayed_ref_head *head)
 {
@@ -1959,7 +1935,7 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 	lockdep_assert_held(&locked_ref->mutex);
 	lockdep_assert_held(&locked_ref->lock);
 
-	while ((ref = select_delayed_ref(locked_ref))) {
+	while ((ref = btrfs_select_delayed_ref(locked_ref))) {
 		if (ref->seq &&
 		    btrfs_check_delayed_seq(fs_info, ref->seq)) {
 			spin_unlock(&locked_ref->lock);
-- 
2.43.0


