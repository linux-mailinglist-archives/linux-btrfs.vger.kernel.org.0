Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46928151157
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgBCUuU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:20 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41834 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgBCUuU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:20 -0500
Received: by mail-qk1-f195.google.com with SMTP id u19so8013998qku.8
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ldwx1uIqSm9irMoQ1Fn7Eo0Is+16n2zPqC1kl1t22A=;
        b=rqUmb81IUIlH6dNCHjttOtxV+3LONhaR96w+Hhd3w9pHCdw+kkhawlBjdltI+hyE7R
         pZc9uBjfhwhYkAV5uHmvwSTW4Oq8JOj21izBlDiDENUj4145seMtD4A/vUH6wnQyy1Qp
         fu2L9UtcnsRE6WRqiQyE8CUsfP453W0KQJy09rLIQ72WpGvC83qyRqoqX6ULxRtbK799
         WSqWJcTOwAAbDDPjMWZ87A9tEHbn8GrId3ljy8lNw2HxwTw/molFWyFCCYvDgNf7bjL6
         5roaEVEgyTLgirlMVIIjQrT2AuGXfTIHYKYiKaq9jalhZLwkMHRRv5ROs7I2H7gSUsQ+
         WUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ldwx1uIqSm9irMoQ1Fn7Eo0Is+16n2zPqC1kl1t22A=;
        b=HUSJp61F9phZajjtVjIndHXBMkw/7zKHf72QKUXjMy6chABl7C49ZClsan2CUZ9ERK
         nQVSFSwQ4lYOkLuL0tdqmzNwXualV7VPK6j8tK3/zfwTjnapPbhxNjdX/YCtRUQ53f6p
         RO2tD4ODVpg29YSVHz1YvkbbK3tL6I0juRC6mKuxVV5/bkJBRrfv6DflMSKLGQ3qf7xk
         9g/DlyaSj3lNNN385dO50zaSCJ9BKCJwOCUcs3Akf4l4hR4jhHTjvEzDn8yDLLDX4sB3
         IrSsdwvaP58SdEDPt3yX1pPXWpK1OHSnQ9T8wAcRrCiroNWk/LQ3WemneS3D8vcDoJ07
         G9UA==
X-Gm-Message-State: APjAAAWmr5bmejsqp6u1KSR+InM1gbkW3j/fNza9kzTncngpO1LA8Kp5
        OficcsjQfEslvVH6uctCwO0VGJh0OTpQHQ==
X-Google-Smtp-Source: APXvYqwxAVBHBZ9f4uxYlC9wN+1BR/QMPxHHSQ/FiKoFmTLdhPsPwbe/oLNf4AqBfBhBsthY/mf0+Q==
X-Received: by 2002:a37:8307:: with SMTP id f7mr25874129qkd.2.1580763018971;
        Mon, 03 Feb 2020 12:50:18 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l17sm9881655qkk.22.2020.02.03.12.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 15/24] btrfs: use ticketing for data space reservations
Date:   Mon,  3 Feb 2020 15:49:42 -0500
Message-Id: <20200203204951.517751-16-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
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

