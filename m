Return-Path: <linux-btrfs+bounces-7366-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D311E95A252
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 18:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548B22871A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 16:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1191314F9DA;
	Wed, 21 Aug 2024 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2aZVEozO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB36B14C5A4
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256131; cv=none; b=E+yZLEfme2R4BT3Bzw9Jtspx5C6LAcawYZ5kxJuHYxQCiRWvCWavxJmbuq94Prc/WSE2t9uLEmjcqrr3e8z63EW1xoubFeZYOMahnHqKIltDAcyl9LJFamDa+Nh4cr4A9M4vBWj+DAib2MKBloQStVf/rmEI4PTsTqp1Nnu8MuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256131; c=relaxed/simple;
	bh=ek+YnISNLCkr94REAIlDaJPta9nkySQcBN6LBQmyefk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7/7OpR5454yTOAVZJeuRXyBmQ4RsbJoQl/YyR+VMlNqv1g23P5mHTD4Ghf2a4LamVjkNrt2Z32m5c7Tdb1jM6l6KWK5SHaac0zPucbzvNQkCTgeJjEuVL2AvCDvXjsm0Zh0xqV8y6hcbuEqYH5CPzwXKTIBczQ3USswqMX0qjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=2aZVEozO; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-69df49d92b8so63550157b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 09:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724256127; x=1724860927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVo/r/XTSk0LReYd69ratXomFBFmGj3FiEQW0Pg38Qc=;
        b=2aZVEozO3ejeaIIOyxBlL29oiP6B+3KvqijtXh8uAiWGUTvVS96GYgYHmhVSVbzfad
         RRXtLmjIZqxIE/xn5TL2ZvzA2idREQxnQ0AgRiMcfw2EG2C8STlXqH4zC+6rWxp/u+mh
         IRNunB5QgxXMiE9iMtiJQrJD6nYm2zrOioFskzknhFYF88vSIDvpDcwU4zuJObx7qxZY
         tfK0a0Gc90aUBx7AQngDbJBPEMJhzKHQLJfojeGjrdJrr1VpISfjqGNUyf9DfRHu6Rjl
         b5ksjwF7gc8u+ghdU7CgNQXM0OlPvmAvJ/d9fepsdPDR5piN28/JoW7vqMUvybfekd4X
         WYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724256127; x=1724860927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVo/r/XTSk0LReYd69ratXomFBFmGj3FiEQW0Pg38Qc=;
        b=ARFOb5Rt/dCu/l3GD9PJjDA0qK2jDjUmeNc+zkS5eonYJuzhNQ4pC+vf9/idaaNyXA
         guYv2AcTx/k0U8kWttkZld9IrMIJ7xuXQLcca1fqcf1HyAXtfAwJANt5VfqCjHqmOegi
         59DV0w5Z07FNIfR39dXqbg0siLo4y3B+eueQtiTeZuhBTwKjmSmd5rS4hit7NIHX1ddF
         qwnEGX+49ZJgxbtCLL3AqWqMZZIDqqi0jXy0JQyeU+Ffvxl9A5ThG1VI9xVxADdC9FFE
         lNOIDMH9Km+VH3pO4r0JAtoVg/sIh6O5rFDtCXpS1DFpIBhLMH3T9dpzD3vQTUozemFU
         KQ2A==
X-Gm-Message-State: AOJu0YwFQVKK25oH1ZLvq7m67QAhomu655N9xuf7dsAjbCd/wp6GVqPl
	p4N5SuPUXq426n2MO5vSsfOsxwRFooMJEcM64GVA09OCAR6/i3trn4EZmdMTRQsYjKfMXIhOOFY
	m
X-Google-Smtp-Source: AGHT+IH1Q+Ne/lTYbC74+eMzKsLejfXPJU/u4jMV7kbsRheHsjNdLVjtVgfZC7wI9rTZb8+LiwY+tQ==
X-Received: by 2002:a05:690c:7093:b0:6b6:4d2e:1fe4 with SMTP id 00721157ae682-6c09d7e77b3mr40018447b3.19.1724256127435;
        Wed, 21 Aug 2024 09:02:07 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6b9d327a582sm10804837b3.123.2024.08.21.09.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:02:07 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/3] btrfs: introduce EXTENT_DIO_LOCKED
Date: Wed, 21 Aug 2024 12:01:59 -0400
Message-ID: <15f44426712f2443bf335604e78839ab715a83ed.1724255475.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724255475.git.josef@toxicpanda.com>
References: <cover.1724255475.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support dropping the extent lock during a read we need a way
to make sure that direct reads and direct writes for overlapping ranges
are protected from each other.  To accomplish this introduce another
lock bit specifically for direct io.  Subsequent patches will utilize
this to protect direct IO operations.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 52 ++++++++++++++++++---------------------
 fs/btrfs/extent-io-tree.h | 38 +++++++++++++++++++++++++---
 2 files changed, 58 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index c54c5d7a5cd5..383e55e0f62e 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -126,7 +126,7 @@ void extent_io_tree_init(struct btrfs_fs_info *fs_info,
  * Empty an io tree, removing and freeing every extent state record from the
  * tree. This should be called once we are sure no other task can access the
  * tree anymore, so no tree updates happen after we empty the tree and there
- * aren't any waiters on any extent state record (EXTENT_LOCKED bit is never
+ * aren't any waiters on any extent state record (EXTENT_LOCK_BITS are never
  * set on any extent state when calling this function).
  */
 void extent_io_tree_release(struct extent_io_tree *tree)
@@ -141,7 +141,7 @@ void extent_io_tree_release(struct extent_io_tree *tree)
 	rbtree_postorder_for_each_entry_safe(state, tmp, &root, rb_node) {
 		/* Clear node to keep free_extent_state() happy. */
 		RB_CLEAR_NODE(&state->rb_node);
-		ASSERT(!(state->state & EXTENT_LOCKED));
+		ASSERT(!(state->state & EXTENT_LOCK_BITS));
 		/*
 		 * No need for a memory barrier here, as we are holding the tree
 		 * lock and we only change the waitqueue while holding that lock
@@ -399,7 +399,7 @@ static void merge_next_state(struct extent_io_tree *tree, struct extent_state *s
  */
 static void merge_state(struct extent_io_tree *tree, struct extent_state *state)
 {
-	if (state->state & (EXTENT_LOCKED | EXTENT_BOUNDARY))
+	if (state->state & (EXTENT_LOCK_BITS | EXTENT_BOUNDARY))
 		return;
 
 	merge_prev_state(tree, state);
@@ -445,7 +445,7 @@ static struct extent_state *insert_state(struct extent_io_tree *tree,
 	struct rb_node *parent = NULL;
 	const u64 start = state->start - 1;
 	const u64 end = state->end + 1;
-	const bool try_merge = !(bits & (EXTENT_LOCKED | EXTENT_BOUNDARY));
+	const bool try_merge = !(bits & (EXTENT_LOCK_BITS | EXTENT_BOUNDARY));
 
 	set_state_bits(tree, state, bits, changeset);
 
@@ -616,9 +616,6 @@ static void set_gfp_mask_from_bits(u32 *bits, gfp_t *mask)
  * inserting elements in the tree, so the gfp mask is used to indicate which
  * allocations or sleeping are allowed.
  *
- * Pass 'wake' == 1 to kick any sleepers, and 'delete' == 1 to remove the given
- * range from the tree regardless of state (ie for truncate).
- *
  * The range [start, end] is inclusive.
  *
  * This takes the tree lock, and returns 0 on success and < 0 on error.
@@ -647,8 +644,8 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	if (bits & EXTENT_DELALLOC)
 		bits |= EXTENT_NORESERVE;
 
-	wake = (bits & EXTENT_LOCKED) ? 1 : 0;
-	if (bits & (EXTENT_LOCKED | EXTENT_BOUNDARY))
+	wake = (bits & EXTENT_LOCK_BITS) ? 1 : 0;
+	if (bits & (EXTENT_LOCK_BITS | EXTENT_BOUNDARY))
 		clear = 1;
 again:
 	if (!prealloc) {
@@ -862,7 +859,7 @@ static void cache_state(struct extent_state *state,
 			struct extent_state **cached_ptr)
 {
 	return cache_state_if_flags(state, cached_ptr,
-				    EXTENT_LOCKED | EXTENT_BOUNDARY);
+				    EXTENT_LOCK_BITS | EXTENT_BOUNDARY);
 }
 
 /*
@@ -1063,7 +1060,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	int ret = 0;
 	u64 last_start;
 	u64 last_end;
-	u32 exclusive_bits = (bits & EXTENT_LOCKED);
+	u32 exclusive_bits = (bits & EXTENT_LOCK_BITS);
 	gfp_t mask;
 
 	set_gfp_mask_from_bits(&bits, &mask);
@@ -1812,12 +1809,11 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			   u32 bits, struct extent_changeset *changeset)
 {
 	/*
-	 * We don't support EXTENT_LOCKED yet, as current changeset will
-	 * record any bits changed, so for EXTENT_LOCKED case, it will
-	 * either fail with -EEXIST or changeset will record the whole
-	 * range.
+	 * We don't support EXTENT_LOCK_BITS yet, as current changeset will
+	 * record any bits changed, so for EXTENT_LOCK_BITS case, it will either
+	 * fail with -EEXIST or changeset will record the whole range.
 	 */
-	ASSERT(!(bits & EXTENT_LOCKED));
+	ASSERT(!(bits & EXTENT_LOCK_BITS));
 
 	return __set_extent_bit(tree, start, end, bits, NULL, NULL, NULL, changeset);
 }
@@ -1826,26 +1822,26 @@ int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			     u32 bits, struct extent_changeset *changeset)
 {
 	/*
-	 * Don't support EXTENT_LOCKED case, same reason as
+	 * Don't support EXTENT_LOCK_BITS case, same reason as
 	 * set_record_extent_bits().
 	 */
-	ASSERT(!(bits & EXTENT_LOCKED));
+	ASSERT(!(bits & EXTENT_LOCK_BITS));
 
 	return __clear_extent_bit(tree, start, end, bits, NULL, changeset);
 }
 
-int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
-		    struct extent_state **cached)
+bool __try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+		       u32 bits, struct extent_state **cached)
 {
 	int err;
 	u64 failed_start;
 
-	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
+	err = __set_extent_bit(tree, start, end, bits, &failed_start,
 			       NULL, cached, NULL);
 	if (err == -EEXIST) {
 		if (failed_start > start)
 			clear_extent_bit(tree, start, failed_start - 1,
-					 EXTENT_LOCKED, cached);
+					 bits, cached);
 		return 0;
 	}
 	return 1;
@@ -1855,23 +1851,23 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
  * Either insert or lock state struct between start and end use mask to tell
  * us if waiting is desired.
  */
-int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
-		struct extent_state **cached_state)
+int __lock_extent(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
+		  struct extent_state **cached_state)
 {
 	struct extent_state *failed_state = NULL;
 	int err;
 	u64 failed_start;
 
-	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
+	err = __set_extent_bit(tree, start, end, bits, &failed_start,
 			       &failed_state, cached_state, NULL);
 	while (err == -EEXIST) {
 		if (failed_start != start)
 			clear_extent_bit(tree, start, failed_start - 1,
-					 EXTENT_LOCKED, cached_state);
+					 bits, cached_state);
 
-		wait_extent_bit(tree, failed_start, end, EXTENT_LOCKED,
+		wait_extent_bit(tree, failed_start, end, bits,
 				&failed_state);
-		err = __set_extent_bit(tree, start, end, EXTENT_LOCKED,
+		err = __set_extent_bit(tree, start, end, bits,
 				       &failed_start, &failed_state,
 				       cached_state, NULL);
 	}
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 9d3a52d8f59a..def953f441f9 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -19,6 +19,7 @@ enum {
 	ENUM_BIT(EXTENT_DIRTY),
 	ENUM_BIT(EXTENT_UPTODATE),
 	ENUM_BIT(EXTENT_LOCKED),
+	ENUM_BIT(EXTENT_DIO_LOCKED),
 	ENUM_BIT(EXTENT_NEW),
 	ENUM_BIT(EXTENT_DELALLOC),
 	ENUM_BIT(EXTENT_DEFRAG),
@@ -67,6 +68,8 @@ enum {
 				 EXTENT_ADD_INODE_BYTES | \
 				 EXTENT_CLEAR_ALL_BITS)
 
+#define EXTENT_LOCK_BITS	(EXTENT_LOCKED | EXTENT_DIO_LOCKED)
+
 /*
  * Redefined bits above which are used only in the device allocation tree,
  * shouldn't be using EXTENT_LOCKED / EXTENT_BOUNDARY / EXTENT_CLEAR_META_RESV
@@ -134,12 +137,22 @@ const struct btrfs_fs_info *extent_io_tree_to_fs_info(const struct extent_io_tre
 void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 			 struct extent_io_tree *tree, unsigned int owner);
 void extent_io_tree_release(struct extent_io_tree *tree);
+int __lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+		  u32 bits, struct extent_state **cached);
+bool __try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+		       u32 bits, struct extent_state **cached);
 
-int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
-		struct extent_state **cached);
+static inline int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+			      struct extent_state **cached)
+{
+	return __lock_extent(tree, start, end, EXTENT_LOCKED, cached);
+}
 
-int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
-		    struct extent_state **cached);
+static inline bool try_lock_extent(struct extent_io_tree *tree, u64 start,
+				   u64 end, struct extent_state **cached)
+{
+	return __try_lock_extent(tree, start, end, EXTENT_LOCKED, cached);
+}
 
 int __init extent_state_init_cachep(void);
 void __cold extent_state_free_cachep(void);
@@ -212,5 +225,22 @@ int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       u64 *end, u64 max_bytes,
 			       struct extent_state **cached_state);
+static inline int lock_dio_extent(struct extent_io_tree *tree, u64 start,
+				  u64 end, struct extent_state **cached)
+{
+	return __lock_extent(tree, start, end, EXTENT_DIO_LOCKED, cached);
+}
+
+static inline bool try_lock_dio_extent(struct extent_io_tree *tree, u64 start,
+				       u64 end, struct extent_state **cached)
+{
+	return __try_lock_extent(tree, start, end, EXTENT_DIO_LOCKED, cached);
+}
+
+static inline int unlock_dio_extent(struct extent_io_tree *tree, u64 start,
+				    u64 end, struct extent_state **cached)
+{
+	return __clear_extent_bit(tree, start, end, EXTENT_DIO_LOCKED, cached, NULL);
+}
 
 #endif /* BTRFS_EXTENT_IO_TREE_H */
-- 
2.43.0


