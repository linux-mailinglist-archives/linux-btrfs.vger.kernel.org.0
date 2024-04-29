Return-Path: <linux-btrfs+bounces-4601-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A908B5960
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1889328AF17
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3566154F8A;
	Mon, 29 Apr 2024 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="suzYDT9K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608885338A
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395825; cv=none; b=Wvtdd7JU5mSk5cHogWIqfONFasY5LhmgKCVhaVE12GncQpAfTEO52iSKJYwrcMDEGKfBxJUxlOZqrGClQG2CHfKsxwwRkMu3jfSgY4B0vcqRymD21B7f0UbexTb4mYsRV/dF2uRW8vwX/H1VHp/yUDC96/fOduoCPPoQZ1eyoUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395825; c=relaxed/simple;
	bh=2IJfTBIM652KSIMNgKbcSlTk5d9GVrskbnyugdju9fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kYE7o3cJ2oUw0qA2LzfLaJSe364kvWLIAzvN+Ut9mMAaxyzCAiI9Tt0vIYCILwEyV56Jr0/NhIZo8EDYa1tOJwSDwg5S42kLJnbkDjuOoIyLBXPaZ7pJM3ZtmrYGXPXPRDyQpPqgb4cdVK2Pi1b3JEgUAwpazwJcduYPFjszZ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=suzYDT9K; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69b4043b7b3so26635276d6.1
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714395822; x=1715000622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GVjRJtdDXahEY2rdyOWVsHU2fivTGvIxvZ94ADlD5XQ=;
        b=suzYDT9KeGtLsfXIH5oYV+P8gKpspJLBdSrq/HfS3Gr8eLSgNvc3DoduSs9Kq8MHRm
         CS2SXNKxjc/m8VBL2S5EOtgE1VjtLVTvWPVlqxlI+b17zeMt+3OreLkZGGdxIft/wghW
         yWr+jggn33Qi3FzUl8uQzbPV1xD1UBIq+ssTihJv6cak0Fd1517J+D53FIV0pKDBA8U+
         L5atrEeoD0Bwg54UvxdVCQHEFqJCuNwyZfAZZO7n5tzKllYW7okdaTalQMUKZ7KYhhlx
         CYZTi/liz4ybsBtpILSNKZz/nLYbTUQBgyabv638CcSmUIjQEGiXi/3Jey/yhmX0OovE
         lzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714395822; x=1715000622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVjRJtdDXahEY2rdyOWVsHU2fivTGvIxvZ94ADlD5XQ=;
        b=sA+cc2YVgawLybe6fZ8SqBPi6t/AvkISwUI9oHvuKoB9QzIX6VKpsyhF9tHfW6uVUE
         Pjdgo0dJsRMOiRuu6GAwu30KSDWcXxJLaEXmJlVMxxBcFWsTs4e5/V7G9GQPGT0VVoxx
         kxZP6oKx/Y9JrhbDxk36U2tK2dN8ndybBQma8U4O90CBseubgKKJjCkRlOo0oIUgOv6Q
         UmkvpwXErcTLLP/nr2vnU2ZHxCNurKZREDUIAxc8sbQXvAnuxbGlf2TPCMGR+oGHog0B
         1X9TsecBxZ2ex/ZmdNAbOzblATyK1QLynjgnAU1LLm1uJrbL1EVdRebqF4vme5Z15dHr
         fL5w==
X-Gm-Message-State: AOJu0Yy6aHJ+iBeEv/sL6C/yMtef7/uFaw4v63s1HiUF3biFpw8BPA50
	2uMIfY248nmpADEBzK7xaHTSiVZGdaPWMuw5emKTiTN3M5Gy+6kkijQlkckIFNHavpDGyRyf7Q5
	c
X-Google-Smtp-Source: AGHT+IFbqu78SqVTnuECspkSK3NbKIb3ZwyKHKnLGRl77eHid5Td5/3yS17tT1Cp/kNkH1eOE740gw==
X-Received: by 2002:a05:6214:21cd:b0:6a0:cc66:3c74 with SMTP id d13-20020a05621421cd00b006a0cc663c74mr4166700qvh.18.1714395821688;
        Mon, 29 Apr 2024 06:03:41 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i11-20020a056214030b00b006a0d4bbd78csm386515qvu.70.2024.04.29.06.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:03:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: lei lu <llfamsec@gmail.com>
Subject: [PATCH] btrfs: make sure that WRITTEN is set on all metadata blocks
Date: Mon, 29 Apr 2024 09:03:35 -0400
Message-ID: <d82bd6cef76e7beaa0d33ef48f9292f3779d015c.1714395805.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We previously would call btrfs_check_leaf() if we had the check
integrity code enabled, which meant that we could only run the extended
leaf checks if we had WRITTEN set on the header flags.

This leaves a gap in our checking, because we could end up with
corruption on disk where WRITTEN isn't set on the leaf, and then the
extended leaf checks don't get run which we rely on to validate all of
the item pointers to make sure we don't access memory outside of the
extent buffer.

However, since 732fab95abe2 ("btrfs: check-integrity: remove
CONFIG_BTRFS_FS_CHECK_INTEGRITY option") we no longer call
btrfs_check_leaf() from btrfs_mark_buffer_dirty(), which means we only
ever call it on blocks that are being written out, and thus have WRITTEN
set, or that are being read in, which should have WRITTEN set.

Add checks to make sure we have WRITTEN set appropriately, and then make
sure __btrfs_check_leaf() always does the item checking.  This will
protect us from file systems that have been corrupted and no longer have
WRITTEN set on some of the blocks.

Reported-by: lei lu <llfamsec@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-checker.c | 30 +++++++++++++++---------------
 fs/btrfs/tree-checker.h |  1 +
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index a127abbc09c3..5a7e869da230 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1797,6 +1797,11 @@ enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *leaf)
 		return BTRFS_TREE_BLOCK_INVALID_LEVEL;
 	}
 
+	if (unlikely(!btrfs_header_flag(leaf, BTRFS_HEADER_FLAG_WRITTEN))) {
+		generic_err(leaf, 0, "invalid flag for leaf, WRITTEN not set");
+		return BTRFS_TREE_BLOCK_WRITTEN_NOT_SET;
+	}
+
 	/*
 	 * Extent buffers from a relocation tree have a owner field that
 	 * corresponds to the subvolume tree they are based on. So just from an
@@ -1858,6 +1863,7 @@ enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *leaf)
 	for (slot = 0; slot < nritems; slot++) {
 		u32 item_end_expected;
 		u64 item_data_end;
+		enum btrfs_tree_block_status ret;
 
 		btrfs_item_key_to_cpu(leaf, &key, slot);
 
@@ -1913,21 +1919,10 @@ enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *leaf)
 			return BTRFS_TREE_BLOCK_INVALID_OFFSETS;
 		}
 
-		/*
-		 * We only want to do this if WRITTEN is set, otherwise the leaf
-		 * may be in some intermediate state and won't appear valid.
-		 */
-		if (btrfs_header_flag(leaf, BTRFS_HEADER_FLAG_WRITTEN)) {
-			enum btrfs_tree_block_status ret;
-
-			/*
-			 * Check if the item size and content meet other
-			 * criteria
-			 */
-			ret = check_leaf_item(leaf, &key, slot, &prev_key);
-			if (unlikely(ret != BTRFS_TREE_BLOCK_CLEAN))
-				return ret;
-		}
+		/* Check if the item size and content meet other criteria */
+		ret = check_leaf_item(leaf, &key, slot, &prev_key);
+		if (unlikely(ret != BTRFS_TREE_BLOCK_CLEAN))
+			return ret;
 
 		prev_key.objectid = key.objectid;
 		prev_key.type = key.type;
@@ -1957,6 +1952,11 @@ enum btrfs_tree_block_status __btrfs_check_node(struct extent_buffer *node)
 	int level = btrfs_header_level(node);
 	u64 bytenr;
 
+	if (unlikely(!btrfs_header_flag(node, BTRFS_HEADER_FLAG_WRITTEN))) {
+		generic_err(node, 0, "invalid flag for node, WRITTEN not set");
+		return BTRFS_TREE_BLOCK_WRITTEN_NOT_SET;
+	}
+
 	if (unlikely(level <= 0 || level >= BTRFS_MAX_LEVEL)) {
 		generic_err(node, 0,
 			"invalid level for node, have %d expect [1, %d]",
diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
index 5c809b50b2d0..01669cfa6578 100644
--- a/fs/btrfs/tree-checker.h
+++ b/fs/btrfs/tree-checker.h
@@ -53,6 +53,7 @@ enum btrfs_tree_block_status {
 	BTRFS_TREE_BLOCK_INVALID_BLOCKPTR,
 	BTRFS_TREE_BLOCK_INVALID_ITEM,
 	BTRFS_TREE_BLOCK_INVALID_OWNER,
+	BTRFS_TREE_BLOCK_WRITTEN_NOT_SET,
 };
 
 /*
-- 
2.43.0


