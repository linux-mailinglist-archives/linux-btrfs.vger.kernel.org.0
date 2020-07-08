Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39D72189B2
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgGHOAw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbgGHOAv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:51 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C75C08C5CE
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:51 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i3so34499959qtq.13
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=68CpSjdjlQOq7XkTk1wbYwbFTcHMjsYHB8jLLgt1if8=;
        b=mrDT8L4F6uwobyJI2AqkkDj+cnhkl9O7XcfPLz2j5sjuLssgvnuEqy+gfaJaQIYSJn
         qYEymOt3KX/M/PEJBQQDpMBds2vd3yGQe+OJP4neZkbOoNhvkzpjOatCpmtxwUIi8YGi
         Um7j5Lam0xymoGodmI2IxDgXIEhtVpxvHieRWmDliC1ovF1zYQAtaJV9mOKI5lHwAisF
         NArWvkJ6UqyYis1Vp9k97ht3uFSqXjYOIw56K15WEvVI50w7FYt57FhurCeME6R2M/f1
         dd1ttG1FpaeMSdVrBFshHHf3NX5IrhgZH8nR37GKgQJZEsBCItlxJUyckS71WsSHhU0R
         +VPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=68CpSjdjlQOq7XkTk1wbYwbFTcHMjsYHB8jLLgt1if8=;
        b=tWlvXIsBp3jH7wpXXJlRCiNNsP89CxePzMqCfXe5K6vrH0mAM1sQyyc2FG+hq/jaLK
         ou4/zEqdp6V+/5q4O9SsB9YRyxkJFnESgPVGsFjKmMQd7f7T3/POs5XabupAYRiIH178
         /EwY4HAfeEzn7dl+rjwaY015r+i+8jGjQ3p0sspNbWPKlmaUpN0RaeMwvMMBevE6ouxF
         YI+GQH/fmmBxb+C0y8PTPPj5cIMo3b4NvP1fY09M66nR760Xu1ZjlkvRGbpcobmCtvu2
         wy0oNjbARCSNQyRe7eDvYlJVf3mrQQdHNWCLilnQlmtWmDDj/s0GuN7OTg4RaKJCl9z2
         pNZQ==
X-Gm-Message-State: AOAM532tFx4pPFSzkiHPW+Iwi+O/PgB2YDiE8MgtYqjqYi/6YGS1Af25
        6w17n1+amYz7xXsMcYbks/euNU3u4mzsNA==
X-Google-Smtp-Source: ABdhPJz3R/iYu8zqJzQJUWcJoCmgZF3fIpy+P9Gk8QyUTG8r77ZAW+oZ0itXeeb2YiGvBFkcRktyMw==
X-Received: by 2002:ac8:408c:: with SMTP id p12mr58688382qtl.332.1594216849873;
        Wed, 08 Jul 2020 07:00:49 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x4sm23687041qkl.130.2020.07.08.07.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 15/23] btrfs: use ticketing for data space reservations
Date:   Wed,  8 Jul 2020 10:00:05 -0400
Message-Id: <20200708140013.56994-16-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have all the infrastructure in place, use the ticketing
infrastructure to make data allocations.  This still maintains the exact
same flushing behavior, but now we're using tickets to get our
reservations satisfied.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 126 +++++++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 58 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3a61cdfe4b21..a107370d144c 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1070,6 +1070,54 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 	} while (flush_state < states_nr);
 }
 
+static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
+					struct btrfs_space_info *space_info,
+					struct reserve_ticket *ticket,
+					const enum btrfs_flush_state *states,
+					int states_nr)
+{
+	int flush_state = 0;
+	int commit_cycles = 2;
+
+	while (!space_info->full) {
+		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
+		spin_lock(&space_info->lock);
+		if (ticket->bytes == 0) {
+			spin_unlock(&space_info->lock);
+			return;
+		}
+		spin_unlock(&space_info->lock);
+	}
+again:
+	while (flush_state < states_nr) {
+		u64 flush_bytes = U64_MAX;
+
+		if (!commit_cycles) {
+			if (states[flush_state] == FLUSH_DELALLOC_WAIT) {
+				flush_state++;
+				continue;
+			}
+			if (states[flush_state] == COMMIT_TRANS)
+				flush_bytes = ticket->bytes;
+		}
+
+		flush_space(fs_info, space_info, flush_bytes,
+			    states[flush_state]);
+		spin_lock(&space_info->lock);
+		if (ticket->bytes == 0) {
+			spin_unlock(&space_info->lock);
+			return;
+		}
+		spin_unlock(&space_info->lock);
+		flush_state++;
+	}
+	if (commit_cycles) {
+		commit_cycles--;
+		flush_state = 0;
+		goto again;
+	}
+}
+
 static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info,
 				struct reserve_ticket *ticket)
@@ -1136,6 +1184,15 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 						evict_flush_states,
 						ARRAY_SIZE(evict_flush_states));
 		break;
+	case BTRFS_RESERVE_FLUSH_DATA:
+		priority_reclaim_data_space(fs_info, space_info, ticket,
+					data_flush_states,
+					ARRAY_SIZE(data_flush_states));
+		break;
+	case BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE:
+		priority_reclaim_data_space(fs_info, space_info, ticket,
+					    NULL, 0);
+		break;
 	default:
 		ASSERT(0);
 		break;
@@ -1343,78 +1400,31 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 			     enum btrfs_reserve_flush_enum flush)
 {
 	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
-	const enum btrfs_flush_state *states = NULL;
 	u64 used;
-	int states_nr = 0;
-	int commit_cycles = 2;
 	int ret = -ENOSPC;
 
 	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_DATA);
 
-	if (flush == BTRFS_RESERVE_FLUSH_DATA) {
-		states = data_flush_states;
-		states_nr = ARRAY_SIZE(data_flush_states);
-	}
-
 	spin_lock(&data_sinfo->lock);
-again:
 	used = btrfs_space_info_used(data_sinfo, true);
 
 	if (used + bytes > data_sinfo->total_bytes) {
-		u64 prev_total_bytes = data_sinfo->total_bytes;
-		int flush_state = 0;
+		struct reserve_ticket ticket;
 
+		init_waitqueue_head(&ticket.wait);
+		ticket.bytes = bytes;
+		ticket.error = 0;
+		list_add_tail(&ticket.list, &data_sinfo->priority_tickets);
+		data_sinfo->reclaim_size += bytes;
 		spin_unlock(&data_sinfo->lock);
 
-		/*
-		 * Everybody can force chunk allocation, so try this first to
-		 * see if we can just bail here and make our reservation.
-		 */
-		flush_space(fs_info, data_sinfo, bytes, ALLOC_CHUNK_FORCE);
-		spin_lock(&data_sinfo->lock);
-		if (prev_total_bytes < data_sinfo->total_bytes)
-			goto again;
+		ret = handle_reserve_ticket(fs_info, data_sinfo, &ticket,
+					    flush);
+	} else {
+		btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, bytes);
+		ret = 0;
 		spin_unlock(&data_sinfo->lock);
-
-		/*
-		 * Cycle through the rest of the flushing options for our flush
-		 * type, then try again.
-		 */
-		while (flush_state < states_nr) {
-			u64 flush_bytes = U64_MAX;
-
-			/*
-			 * Previously we unconditionally committed the
-			 * transaction twice before finally checking against
-			 * pinned space before committing the final time.  We
-			 * also skipped flushing delalloc the final pass
-			 * through.
-			 */
-			if (!commit_cycles) {
-				if (states[flush_state] == FLUSH_DELALLOC_WAIT) {
-					flush_state++;
-					continue;
-				}
-				if (states[flush_state] == COMMIT_TRANS)
-					flush_bytes = bytes;
-			}
-
-			flush_space(fs_info, data_sinfo, flush_bytes,
-				    states[flush_state]);
-			flush_state++;
-		}
-
-		if (!commit_cycles)
-			goto out;
-
-		commit_cycles--;
-		spin_lock(&data_sinfo->lock);
-		goto again;
 	}
-	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, bytes);
-	ret = 0;
-	spin_unlock(&data_sinfo->lock);
-out:
 	if (ret)
 		trace_btrfs_space_reservation(fs_info,
 					      "space_info:enospc",
-- 
2.24.1

