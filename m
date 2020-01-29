Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B5C14D408
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgA2Xuu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:50:50 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46327 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgA2Xuu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:50:50 -0500
Received: by mail-qk1-f195.google.com with SMTP id g195so1139554qke.13
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pptz4C3H5pDafs26YpyEwG8nGJRsg0sWF3fcdN6AgKw=;
        b=hYIQlGTmdQj34jNCRizY8K7MP1B1/g0SfRrDURtGX6whFSWxA3SyUffukWTLseL06u
         vM5qAv3ywnOjyD342/vojpcY+T651ES9ROrMwlmL8bjtZ0dubwp/swI2fAyChjNoXP7N
         NajM9+UuDz6nTW4Ka9sioBOQU41mUAWM6pWCxfYpQTdSrwJyJDtCqyY6hCp/qu+96uy2
         G/xRvLGQh9T6wA3l08F4zCJE+CFoGi2G2nDkDFvvM2WNZwh4OpTKHEFJOS6ruRQ0tJH/
         xuH2BOQToG+lJ/t+x5HD7a2aBSAIgX7PETczUx5drNbiArWwsMnLQFdLwIXdSk+UbpCD
         R+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pptz4C3H5pDafs26YpyEwG8nGJRsg0sWF3fcdN6AgKw=;
        b=f12JRia4sFdRNrDah6gKD4tzkNX8809DyGJVIAOFiG2P1xb0/4r36aAzHk4fHTt6kk
         uB957Y9Orm03KxyTXTAKyhvzrLmwXRj61WNoP1Q4Rjb3iznGrhkcb+tHk+OSjno5KjBh
         hyn/qBwHJBDJwLxhAtn58m1fx2WuPD9RcntIcDkRBcnwLah5wzJPLift+DrxM7vQF6Um
         QP4+in2XxSKnSoWWy2Vx/x1kYexFBn6NLRDxH2Nv1x98HUiFeu/B2WtPWCtWcXU7tf9J
         TJM6fs6kWRmba3MoOvvZoGs35E+3RI1fOvjfdlYyphK6b2fZ7rjOfZv2oIo8uhKZQc/G
         HVFQ==
X-Gm-Message-State: APjAAAXZGqwJ0BSxlmL7qVoxz2HbBlB6qgao05GHpeq9tB/ZASOSNRzZ
        0aNB3J3ZuybJY63Aweu4PPmo38mMgybPSA==
X-Google-Smtp-Source: APXvYqwsqSlTy8RO9YfoYESodafdEn6VBLgXvFHemNwy3a0rXiLuBZjHZazY1nKesSjhfFYpnUvgag==
X-Received: by 2002:a37:4dc1:: with SMTP id a184mr2630819qkb.62.1580341847937;
        Wed, 29 Jan 2020 15:50:47 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o17sm1899682qtq.93.2020.01.29.15.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/20] btrfs: use ticketing for data space reservations
Date:   Wed, 29 Jan 2020 18:50:16 -0500
Message-Id: <20200129235024.24774-13-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have all the infrastructure in place, use the ticketing
infrastructure to make data allocations.  This still essentially behaves
the same way as before, with the exception that we check after each
flush operation to see if our reservation has been satisfied.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 90 +++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 371af6d89259..b4c43af7b499 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -865,6 +865,27 @@ static const enum btrfs_flush_state free_space_inode_flush_states[] = {
 	ALLOC_CHUNK_FORCE,
 };
 
+
+static void priority_reclaim_space(struct btrfs_fs_info *fs_info,
+				   struct btrfs_space_info *space_info,
+				   struct reserve_ticket *ticket,
+				   u64 to_reclaim,
+				   const enum btrfs_flush_state *states,
+				   int states_nr)
+{
+	int flush_state = 0;
+	do {
+		flush_space(fs_info, space_info, to_reclaim, states[flush_state]);
+		flush_state++;
+		spin_lock(&space_info->lock);
+		if (ticket->bytes == 0) {
+			spin_unlock(&space_info->lock);
+			return;
+		}
+		spin_unlock(&space_info->lock);
+	} while (flush_state < states_nr);
+}
+
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info,
 				struct reserve_ticket *ticket,
@@ -872,7 +893,6 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 				int states_nr)
 {
 	u64 to_reclaim;
-	int flush_state;
 
 	spin_lock(&space_info->lock);
 	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
@@ -881,18 +901,8 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 		return;
 	}
 	spin_unlock(&space_info->lock);
-
-	flush_state = 0;
-	do {
-		flush_space(fs_info, space_info, to_reclaim, states[flush_state]);
-		flush_state++;
-		spin_lock(&space_info->lock);
-		if (ticket->bytes == 0) {
-			spin_unlock(&space_info->lock);
-			return;
-		}
-		spin_unlock(&space_info->lock);
-	} while (flush_state < states_nr);
+	priority_reclaim_space(fs_info, space_info, ticket, to_reclaim,
+			       states, states_nr);
 }
 
 static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
@@ -960,6 +970,16 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 						evict_flush_states,
 						ARRAY_SIZE(evict_flush_states));
 		break;
+	case BTRFS_RESERVE_FLUSH_DATA:
+		priority_reclaim_space(fs_info, space_info, ticket, U64_MAX,
+				       data_flush_states,
+				       ARRAY_SIZE(data_flush_states));
+		break;
+	case BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE:
+		priority_reclaim_space(fs_info, space_info, ticket, U64_MAX,
+				free_space_inode_flush_states,
+				ARRAY_SIZE(free_space_inode_flush_states));
+		break;
 	default:
 		ASSERT(0);
 		break;
@@ -1139,57 +1159,33 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 			     enum btrfs_reserve_flush_enum flush)
 {
 	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
-	const enum btrfs_flush_state *states;
 	u64 used;
-	int states_nr;
 	int commit_cycles = 2;
 	int ret = -ENOSPC;
 
 	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_DATA);
 
-	if (flush == BTRFS_RESERVE_FLUSH_DATA) {
-		states = data_flush_states;
-		states_nr = ARRAY_SIZE(data_flush_states);
-	} else {
-		states = free_space_inode_flush_states;
-		states_nr = ARRAY_SIZE(free_space_inode_flush_states);
+	if (flush == BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE)
 		commit_cycles = 0;
-	}
 
-	spin_lock(&data_sinfo->lock);
 again:
+	spin_lock(&data_sinfo->lock);
 	used = btrfs_space_info_used(data_sinfo, true);
 
 	if (used + bytes > data_sinfo->total_bytes) {
-		u64 prev_total_bytes = data_sinfo->total_bytes;
-		int flush_state = 1;
+		struct reserve_ticket ticket;
 
+		init_waitqueue_head(&ticket.wait);
+		ticket.bytes = bytes;
+		ticket.error = 0;
+		list_add_tail(&ticket.list, &data_sinfo->priority_tickets);
 		spin_unlock(&data_sinfo->lock);
 
-		/*
-		 * Everybody can force chunk allocation, so try this first to
-		 * see if we can just bail here and make our reservation.
-		 */
-		flush_space(fs_info, data_sinfo, bytes, ALLOC_CHUNK_FORCE);
-		spin_lock(&data_sinfo->lock);
-		if (prev_total_bytes < data_sinfo->total_bytes)
-			goto again;
-		spin_unlock(&data_sinfo->lock);
-
-		if (!commit_cycles)
+		ret = handle_reserve_ticket(fs_info, data_sinfo, &ticket,
+					    flush);
+		if (!ret || !commit_cycles)
 			goto out;
-
-		/*
-		 * Cycle through the rest of the flushing options for our flush
-		 * type, then try again.
-		 */
-		while (flush_state < states_nr) {
-			flush_space(fs_info, data_sinfo, (u64)-1,
-				    states[flush_state]);
-			flush_state++;
-		}
 		commit_cycles--;
-		spin_lock(&data_sinfo->lock);
 		goto again;
 	}
 	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, bytes);
-- 
2.24.1

