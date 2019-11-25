Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7567109036
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 15:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfKYOkS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 09:40:18 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40825 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfKYOkR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 09:40:17 -0500
Received: by mail-qt1-f194.google.com with SMTP id o49so17388009qta.7
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 06:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NXH6bfXf0p1+6RGHwfnfT9ebQuIcW/n6BUAqh20ZvUs=;
        b=mo/H71Y3XVIq1Gx27/ktndS8gJ9/2lpSAjV5ZLD+oz7Bc8ztuQ2GlA+mJDED9FE0Q/
         8NfG5tqd64coU0xkwJMiOseVsAWZnDsX2AjWfEkhtwgvyesGIvDbAtKcGOoipEXE4Bb8
         G9mvDa/R9LZrgoJFCUw/QHJEuLT9u4QBrZBxqb/EVE9V8AA5uJMj2Ca7PkxryrdF2ge4
         SQcx4NSgNxzupBBER0nNPO+/nE5OF5eJ07/3M8y0+BiCmH1t6JsyuD1pNPb6Mp8oj3Cb
         hFbXgeM5NxgtuNNzdqyG00w+UNmEdoLNbD1mXGCePaIvL3Yzytf3aziVN/qRPzQKjTwA
         97Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXH6bfXf0p1+6RGHwfnfT9ebQuIcW/n6BUAqh20ZvUs=;
        b=XWpc2YKPaqJjncLmvbyj3VKF6+UTfg6tjjBkvuOpEAQ/fTJeIK/HhHZQJ+ABHUHxWD
         5/wxPKld1BEm7AkxsGtx9OdRUu1N3FaqF7Kyk7QO3zUy9gcuFhbpLtNPTd8bYw7ABxHk
         04/U7vYRVVXYP5ZQyPpzAea9mStptEhZ4c62W+LagJp9rXL4D2Egr9ytiu+MQBa3jS6n
         oa/it2XrQEp2mrBmMY/aoXmvqRcJOLa4oXWNYDSE7tkP608OQe6lcNz/AY2nZM89xKP4
         pC8pePcMtpvkF2dFHGKYXnOuFVIPIY6YpGPaFBoBCWYCmTy17AzXuQ+jMf7x976AMjyp
         pD1A==
X-Gm-Message-State: APjAAAVMFQQuYhX2ZxjzdsAmNIfnYWRQ6OSa6ORk/9fr27Z5k3HmCXvs
        zRxTdQ8eHjJnqkkq883wKOltAa7a8tPcyg==
X-Google-Smtp-Source: APXvYqx53BmK9QGXz/B48Ofb4YyWJPz3ot8/k8UMr/M59d+G5jfLC7hsJOvPH14AtoeBlwyiCHIPvQ==
X-Received: by 2002:ac8:4451:: with SMTP id m17mr19056244qtn.176.1574692816421;
        Mon, 25 Nov 2019 06:40:16 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i10sm3934944qtj.19.2019.11.25.06.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:40:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com, wqu@suse.com
Subject: [PATCH 1/4] btrfs: don't pass system_chunk into can_overcommit
Date:   Mon, 25 Nov 2019 09:40:08 -0500
Message-Id: <20191125144011.146722-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191125144011.146722-1-josef@toxicpanda.com>
References: <20191125144011.146722-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have the space_info, we can just check its flags to see if it's the
system chunk space info.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f09aa6ee9113..df5fb68df798 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -161,8 +161,7 @@ static inline u64 calc_global_rsv_need_space(struct btrfs_block_rsv *global)
 
 static int can_overcommit(struct btrfs_fs_info *fs_info,
 			  struct btrfs_space_info *space_info, u64 bytes,
-			  enum btrfs_reserve_flush_enum flush,
-			  bool system_chunk)
+			  enum btrfs_reserve_flush_enum flush)
 {
 	u64 profile;
 	u64 avail;
@@ -173,7 +172,7 @@ static int can_overcommit(struct btrfs_fs_info *fs_info,
 	if (space_info->flags & BTRFS_BLOCK_GROUP_DATA)
 		return 0;
 
-	if (system_chunk)
+	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
 		profile = btrfs_system_alloc_profile(fs_info);
 	else
 		profile = btrfs_metadata_alloc_profile(fs_info);
@@ -227,8 +226,7 @@ void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
 
 		/* Check and see if our ticket can be satisified now. */
 		if ((used + ticket->bytes <= space_info->total_bytes) ||
-		    can_overcommit(fs_info, space_info, ticket->bytes, flush,
-				   false)) {
+		    can_overcommit(fs_info, space_info, ticket->bytes, flush)) {
 			btrfs_space_info_update_bytes_may_use(fs_info,
 							      space_info,
 							      ticket->bytes);
@@ -626,8 +624,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 
 static inline u64
 btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
-				 struct btrfs_space_info *space_info,
-				 bool system_chunk)
+				 struct btrfs_space_info *space_info)
 {
 	struct reserve_ticket *ticket;
 	u64 used;
@@ -643,13 +640,13 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 
 	to_reclaim = min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
 	if (can_overcommit(fs_info, space_info, to_reclaim,
-			   BTRFS_RESERVE_FLUSH_ALL, system_chunk))
+			   BTRFS_RESERVE_FLUSH_ALL))
 		return 0;
 
 	used = btrfs_space_info_used(space_info, true);
 
 	if (can_overcommit(fs_info, space_info, SZ_1M,
-			   BTRFS_RESERVE_FLUSH_ALL, system_chunk))
+			   BTRFS_RESERVE_FLUSH_ALL))
 		expected = div_factor_fine(space_info->total_bytes, 95);
 	else
 		expected = div_factor_fine(space_info->total_bytes, 90);
@@ -665,7 +662,7 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 
 static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
 					struct btrfs_space_info *space_info,
-					u64 used, bool system_chunk)
+					u64 used)
 {
 	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
 
@@ -673,8 +670,7 @@ static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
 	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
 		return 0;
 
-	if (!btrfs_calc_reclaim_metadata_size(fs_info, space_info,
-					      system_chunk))
+	if (!btrfs_calc_reclaim_metadata_size(fs_info, space_info))
 		return 0;
 
 	return (used >= thresh && !btrfs_fs_closing(fs_info) &&
@@ -765,8 +761,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 
 	spin_lock(&space_info->lock);
-	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info,
-						      false);
+	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
 	if (!to_reclaim) {
 		space_info->flush = 0;
 		spin_unlock(&space_info->lock);
@@ -785,8 +780,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 			return;
 		}
 		to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info,
-							      space_info,
-							      false);
+							      space_info);
 		if (last_tickets_id == space_info->tickets_id) {
 			flush_state++;
 		} else {
@@ -858,8 +852,7 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 	int flush_state;
 
 	spin_lock(&space_info->lock);
-	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info,
-						      false);
+	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
 	if (!to_reclaim) {
 		spin_unlock(&space_info->lock);
 		return;
@@ -990,8 +983,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 				    struct btrfs_space_info *space_info,
 				    u64 orig_bytes,
-				    enum btrfs_reserve_flush_enum flush,
-				    bool system_chunk)
+				    enum btrfs_reserve_flush_enum flush)
 {
 	struct reserve_ticket ticket;
 	u64 used;
@@ -1013,8 +1005,7 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	 */
 	if (!pending_tickets &&
 	    ((used + orig_bytes <= space_info->total_bytes) ||
-	     can_overcommit(fs_info, space_info, orig_bytes, flush,
-			   system_chunk))) {
+	     can_overcommit(fs_info, space_info, orig_bytes, flush))) {
 		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
 						      orig_bytes);
 		ret = 0;
@@ -1054,8 +1045,7 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 		 * the async reclaim as we will panic.
 		 */
 		if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags) &&
-		    need_do_async_reclaim(fs_info, space_info,
-					  used, system_chunk) &&
+		    need_do_async_reclaim(fs_info, space_info, used) &&
 		    !work_busy(&fs_info->async_reclaim_work)) {
 			trace_btrfs_trigger_flush(fs_info, space_info->flags,
 						  orig_bytes, flush, "preempt");
@@ -1092,10 +1082,9 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	int ret;
-	bool system_chunk = (root == fs_info->chunk_root);
 
 	ret = __reserve_metadata_bytes(fs_info, block_rsv->space_info,
-				       orig_bytes, flush, system_chunk);
+				       orig_bytes, flush);
 	if (ret == -ENOSPC &&
 	    unlikely(root->orphan_cleanup_state == ORPHAN_CLEANUP_STARTED)) {
 		if (block_rsv != global_rsv &&
-- 
2.23.0

