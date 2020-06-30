Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF4520F692
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 16:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgF3OAA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 10:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387687AbgF3N76 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 09:59:58 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EABC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:58 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x62so15611233qtd.3
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZXI03dVwmDfyBQ4Mz+3HeqE9PLEvcemuppqFHIP6ego=;
        b=FZl22Sa3M98w9B/S0kqUC2Vh7AumdGDlpEa1v4n/9W3GI01duvHLTGoJGWa4QgqNpW
         /LqNf6+sY4beTNEYBU9z88pRm2/Ru+sR74MmzvfkHaAktfTe7QmhxvuHm00KElI0pNc/
         Qms7WlaorduAUtY8ww7bq29OOcBLl7q283qMdm4EKiUoqsABnWexSXAvXL4WOelGWwp8
         HT8q/DDmGElcVnD8xmJpoAeiAVO13z2kHMbVClXgAKjNkzGk+Nmn3WVPdK0Ka7qpiE3+
         5N49orHeuWfiWiMVfe+O5b+SVh5vrre7td8UwPhBcvSHXZ3Pd4BOeKnpyeh8Vz3U+OsW
         3tTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXI03dVwmDfyBQ4Mz+3HeqE9PLEvcemuppqFHIP6ego=;
        b=o2VsNcupLUKN4QfK5vPU5AJuI5TWJjrt1ybckK4K7/EdSMKmFGp1SQlq6E6wJi/H0J
         B9b3fNZexyr4HTX3AcG89twhOjQnPDKNwR7g8A4UtxL/O3QyDsDv4sTNf4vfpDArbgqV
         8Kzl6aWGwPlslDpbj2+T22jghEClsk7bflKJJ0A4/5figs6Yyx2+t2YayGZi2t0kfWJa
         Ia1B7Iq6dMeQc4G1LO/ofCsBb6X4p9iNi5pJF64rKzhievUC4H9Saruss2hdpIVcxmGL
         yC4ouw5rzMvrgOdjrWrjaxUWvkwiOuJCLGjKZHeNWbDgpP40m0pnbCQmhVUk3m4LouKu
         bUhg==
X-Gm-Message-State: AOAM533w0+XuCE4kVJTAIs2M/mvqvrpUcF4V+xMT7xvnokvJ3XK3OxA3
        IZZqEx4oyur5LsqaenunyywU+Bc6dbaY8Q==
X-Google-Smtp-Source: ABdhPJwsc6WmMSTPNaE0iWi3N1VR2+JjNlIAH+NWMvx1k247ofueKVzXCvjF8gHI5kHnKhRG7fb7lg==
X-Received: by 2002:aed:2cc5:: with SMTP id g63mr20792813qtd.59.1593525597485;
        Tue, 30 Jun 2020 06:59:57 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 21sm3198562qkj.56.2020.06.30.06.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:59:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 15/23] btrfs: use ticketing for data space reservations
Date:   Tue, 30 Jun 2020 09:59:13 -0400
Message-Id: <20200630135921.745612-16-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
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
index 799ee6090693..ee4747917b81 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1068,6 +1068,54 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
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
@@ -1134,6 +1182,15 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
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
@@ -1341,78 +1398,30 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
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

