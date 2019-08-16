Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D357B903E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 16:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfHPOUH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 10:20:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38575 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfHPOUH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 10:20:07 -0400
Received: by mail-qk1-f193.google.com with SMTP id u190so4839108qkh.5
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iPcRG/Jah6oa5oLkKTJtd5W7AMgxkAaa83xXfPFoOA8=;
        b=KPy/MS5OiVwt6MqBpbyPqkF+5sPtjsW4BjP0e3cPzNGIZTGPYLt3jgCntibl0S+JF1
         sgQQ6NYXA1gZcZu5SOmoPxkeB2CTsfjfsWdz53E5aGrBpTYHlJ8VgiXsPhBgkKzLuMqN
         Aj2xVzzEQvcKWgqspux1IgbYmu0Cp8YxxMcP6uT/trQxbYVh229OscZC2R/4XQTRxhRM
         tRkiz71VYV31HFOx5kF7c3hazX87yMAq1xv7LvxLsTdSmnvsrkx7MgVlFN96Auvt3cWj
         SmW6zlMSUJ4U5hJFU1iap+75ie08htbrPvXUta1Qz8FLgDPBMJRb+tiDauKbSwrU/Bdx
         hbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iPcRG/Jah6oa5oLkKTJtd5W7AMgxkAaa83xXfPFoOA8=;
        b=QfYmJK4MuRph28hSWgXFiEiNuv0wQDpvQRs5yerv+lsjDYJHvx5zxy1ufazH2qtU+O
         pzDfh3SW8yOEz5CijbBwAY3pcMDADgDhW3LOerGODRNb9zzpBIyj3TNNARg85EyYR0kC
         s/twtbskM+fB/KANh+IfKOJlhauitwFGPVWw2lJz0Q2dAqV20Ju86VPJmxnzOEHPEa+m
         rrY6fOgTNNFbOj2C+hJAdsD0ML0PjpBxBPmRin1qu2oQNEX2vuIdaVslNRtDb490Vv7D
         si1+U4zHBY0DG10H0/1F9KPFiFtf4w2DL9r+6wCUlAu1T13eNtMacd17iMv13edqXkNb
         pIlQ==
X-Gm-Message-State: APjAAAUeNJmNlkAyr5iHHkpcRTZ+RiPaCZ7b27ctbvMsAG9m6ygJ1pi3
        sc2plBcbhvcrlnJHof/X1erfd9+tVIplNA==
X-Google-Smtp-Source: APXvYqxSyu4ktpn7YoA7QOEpZsW0Uzk+WkbHdJRVEqtlZBZYZB1rANVHV8noGYCSpnc6+cYFLBCncA==
X-Received: by 2002:a37:64c8:: with SMTP id y191mr8925307qkb.210.1565965206296;
        Fri, 16 Aug 2019 07:20:06 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y204sm3364368qka.54.2019.08.16.07.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 07:20:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/8] btrfs: rework wake_all_tickets
Date:   Fri, 16 Aug 2019 10:19:50 -0400
Message-Id: <20190816141952.19369-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816141952.19369-1-josef@toxicpanda.com>
References: <20190816141952.19369-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we no longer partially fill tickets we need to rework
wake_all_tickets to call btrfs_try_to_wakeup_tickets() in order to see
if any subsequent tickets are able to be satisfied.  If our tickets_id
changes we know something happened and we can keep flushing.

Also if we find a ticket that is smaller than the first ticket in our
queue then we want to retry the flushing loop again in case
may_commit_transaction() decides we could satisfy the ticket by
committing the transaction.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 8a1c7ada67cb..bd485be783b8 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -676,19 +676,39 @@ static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
 		!test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state));
 }
 
-static bool wake_all_tickets(struct list_head *head)
+static bool wake_all_tickets(struct btrfs_fs_info *fs_info,
+			     struct btrfs_space_info *space_info)
 {
 	struct reserve_ticket *ticket;
+	u64 tickets_id = space_info->tickets_id;
+	u64 first_ticket_bytes = 0;
+
+	while (!list_empty(&space_info->tickets) &&
+	       tickets_id == space_info->tickets_id) {
+		ticket = list_first_entry(&space_info->tickets,
+					  struct reserve_ticket, list);
+
+		/*
+		 * may_commit_transaction will avoid committing the transaction
+		 * if it doesn't feel like the space reclaimed by the commit
+		 * would result in the ticket succeeding.  However if we have a
+		 * smaller ticket in the queue it may be small enough to be
+		 * satisified by committing the transaction, so if any
+		 * subsequent ticket is smaller than the first ticket go ahead
+		 * and send us back for another loop through the enospc flushing
+		 * code.
+		 */
+		if (first_ticket_bytes == 0)
+			first_ticket_bytes = ticket->bytes;
+		else if (first_ticket_bytes > ticket->bytes)
+			return true;
 
-	while (!list_empty(head)) {
-		ticket = list_first_entry(head, struct reserve_ticket, list);
 		list_del_init(&ticket->list);
 		ticket->error = -ENOSPC;
 		wake_up(&ticket->wait);
-		if (ticket->bytes != ticket->orig_bytes)
-			return true;
+		btrfs_try_to_wakeup_tickets(fs_info, space_info);
 	}
-	return false;
+	return (tickets_id != space_info->tickets_id);
 }
 
 /*
@@ -756,7 +776,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 		if (flush_state > COMMIT_TRANS) {
 			commit_cycles++;
 			if (commit_cycles > 2) {
-				if (wake_all_tickets(&space_info->tickets)) {
+				if (wake_all_tickets(fs_info, space_info)) {
 					flush_state = FLUSH_DELAYED_ITEMS_NR;
 					commit_cycles--;
 				} else {
-- 
2.21.0

