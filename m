Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD15151E2B
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBDQUW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:22 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46200 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgBDQUV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:21 -0500
Received: by mail-qk1-f193.google.com with SMTP id g195so18441468qke.13
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4r9mhYEg7+E9GIg6lQVsRtZwgDZq7uBhRtiVZn9/Sa8=;
        b=Q7XB0MNdvIMJNWxj6oEEh3p3Kp1tz5oQTLokSbihnrRsXQjzL3Y96k3UNJayrHCKD0
         sY5ng/nZvdsC+ccGJMi/DCP97qI2ZVk589AdrBYPw/jje5Fy3eptsVerNyOIaQq+pl3q
         ciBVlBQtMmZqJsV2R0M1+GIJ4KbZS6uxrUSDht+nEDvttw3HZ0WV3cv1FAsczjqC1URV
         1SRp5VyaklfsTBIQ3a4B0CeY9yX3T7BBUi26jiQVZ8FmDNDsbZJat0nzYaHLoO7/bomF
         W3HxO3qXK2IrcPRmaimBN9zPg3yo2YZKgM02nyLiEctnA34x1f7yan1g+ZTqCniGguhN
         6gyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4r9mhYEg7+E9GIg6lQVsRtZwgDZq7uBhRtiVZn9/Sa8=;
        b=JFotU94usZnAB7nng9CgKOjjs/qB31cw2gwY0Y/flDtnfg1CeLafcusTgvA+MeYba2
         fYvm0fc6ro9dAZBgwYKB4oA4qQvS+/6UiYkiSPbYWWDKxN1F7RPYU6dV7dzZVEFduDZU
         wJRNQlPC0GE/zTR3CGxhBtAqI6Sf82t6gj3LnL66XcERR4l5GAp+bV9k5+wjiJjzSb8d
         XzKIMpxTF6dvBVIPSwtM5kqTcA8UT9LzmW3K4RXr6pTRoDozIBY/Njn/vM/PyFjdxxv2
         XDIylFP3Mz2JhumsMSwSZ3kpumSbR/eAyaUVQVNzIctv+dSM4dch/CowBOosxNYhg7HX
         6JVw==
X-Gm-Message-State: APjAAAVsRsL3SMI8Z206GSuVcXCRMYdX0pvnltTRJAB/3YqrkChLSPuK
        TJIf7gDrrSeRfeC8xRRcsUNJJkLnnNJzBg==
X-Google-Smtp-Source: APXvYqxPnuDeMIIsTPxKKDx6lK/IbBoeBxXl2Uu4CYHbeAolKdjKjXbiGOSGdcc2ZNqeOa1hhAzWpg==
X-Received: by 2002:a37:a485:: with SMTP id n127mr29256864qke.81.1580833218902;
        Tue, 04 Feb 2020 08:20:18 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z26sm12121301qtj.12.2020.02.04.08.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:20:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 15/23] btrfs: use ticketing for data space reservations
Date:   Tue,  4 Feb 2020 11:19:43 -0500
Message-Id: <20200204161951.764935-16-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
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
 fs/btrfs/space-info.c | 125 ++++++++++++++++++++++--------------------
 1 file changed, 67 insertions(+), 58 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 6b71f6d3a348..5e7454577407 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -852,6 +852,54 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
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
@@ -917,6 +965,15 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
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
@@ -1096,78 +1153,30 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
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

