Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBB687B37
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 15:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407116AbfHINdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Aug 2019 09:33:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38329 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407113AbfHINdh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Aug 2019 09:33:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id n11so95747393qtl.5
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Aug 2019 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dc4VGYSL3vPuuhr6wvTNO6eGeiRn3vdOpe3URcAf/2Y=;
        b=GjRg6msoyFQPL/TeUlESOfZDBO9evJC2k6om/G2gSUHd0ELTnceBRslxnYMyoo0qSp
         t07wjIRSvyRRl/45d3bUqO3/z1+mGJXtP6H37ryqw79vlc3DQN7POXq5nRF82wnSUcEt
         XsMId70ErjEozwf+nJVdFJqqtA8Vf/9ORhFWG2umjvWEGQ/sZujRUSPuiMud+hjKvzcD
         0ifBQGLUGz5xOkpB3GS/SGoEtNJL1W5xEr1s+rraPNTOohPWhupFEMLX9U97fSBEQ9U4
         htfZrcex3+HlLd7plBEi+kTQGUkICm4/n6ub9OmRb8stomxIPbRLJx+VygooCsP6X+kK
         YDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dc4VGYSL3vPuuhr6wvTNO6eGeiRn3vdOpe3URcAf/2Y=;
        b=gdWTPTvOqk+QBR+w+Nu31K920OHfxBKTLZU78jumKzeYVWpFHSJY1pstv/NRkWeSzm
         Z90IqXWBPMi9qIih5pBOZYerUR9eiB7NxLlZ52xL4vTKBNsM9MSmSGTUzreEis7iDBpU
         X1HuT/S39OW1NsdzrW9zB3Ma+CqimAciNivHIJXKRNsQaGberp2IlrFby48uYPZkvgrW
         JA+0DlVk6BKAUKkX7mjuQL4DrnoAlh6nvhlf0Y+1O54Rr8z+kklnarLlmJAQ54nKQxv1
         H4g69Fz6r9iboYYnJJPpI/nZdshxjjMaE/Uvv1q7NCI0bXhHOZWXJkMgp2YJJeh5eIXR
         Iakw==
X-Gm-Message-State: APjAAAUAtuUAHWINmdqxTGVKGscIZCuCfyFA+7A6wIKJl5OO9E2GPMyN
        VjlBVyvWgqqlGXSktdDVSAyas9iuSEnI/w==
X-Google-Smtp-Source: APXvYqzzY22yCQiK/RgGZleMRl2exjsr6rl/gg/ulAWzSqJfRxkUFFIfJHVJR9xDwBnyISQs5btL1A==
X-Received: by 2002:a05:6214:10ea:: with SMTP id q10mr18064027qvt.4.1565357616492;
        Fri, 09 Aug 2019 06:33:36 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j6sm2122907qkd.26.2019.08.09.06.33.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 06:33:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/7] btrfs: rework btrfs_space_info_add_old_bytes
Date:   Fri,  9 Aug 2019 09:33:24 -0400
Message-Id: <20190809133327.26509-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190809133327.26509-1-josef@toxicpanda.com>
References: <20190809133327.26509-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If there are pending tickets and we are overcommitted we will simply
return free'd reservations to space_info->bytes_may_use if we cannot
overcommit any more.  This is problematic because we assume any free
space would have been added to the tickets, and so if we go from an
overcommitted state to not overcommitted we could have plenty of space
in our space_info but be unable to make progress on our tickets because
we only refill tickets from previous reservations.

Instead of doing this partial filling of tickets dance we need to simply
add our space to the space_info, and then do the normal check to see if
we can satisfy the whole reservation.  If we can then we wake up the
ticket and carry on.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 43 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 780be5df31b4..5f123b36fdcd 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -233,52 +233,41 @@ void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
 				    struct btrfs_space_info *space_info,
 				    u64 num_bytes)
 {
-	struct reserve_ticket *ticket;
 	struct list_head *head;
-	u64 used;
 	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_NO_FLUSH;
-	bool check_overcommit = false;
 
 	spin_lock(&space_info->lock);
 	head = &space_info->priority_tickets;
+	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
 
-	/*
-	 * If we are over our limit then we need to check and see if we can
-	 * overcommit, and if we can't then we just need to free up our space
-	 * and not satisfy any requests.
-	 */
-	used = btrfs_space_info_used(space_info, true);
-	if (used - num_bytes >= space_info->total_bytes)
-		check_overcommit = true;
 again:
-	while (!list_empty(head) && num_bytes) {
-		ticket = list_first_entry(head, struct reserve_ticket,
-					  list);
-		/*
-		 * We use 0 bytes because this space is already reserved, so
-		 * adding the ticket space would be a double count.
-		 */
-		if (check_overcommit &&
-		    !can_overcommit(fs_info, space_info, 0, flush, false))
-			break;
-		if (num_bytes >= ticket->bytes) {
+	while (!list_empty(head)) {
+		struct reserve_ticket *ticket;
+		u64 used = btrfs_space_info_used(space_info, true);
+
+		ticket = list_first_entry(head, struct reserve_ticket, list);
+
+		/* Check and see if our ticket can be satisified now. */
+		if ((used + ticket->bytes <= space_info->total_bytes) ||
+		    can_overcommit(fs_info, space_info, ticket->bytes, flush,
+				   false)) {
+			btrfs_space_info_update_bytes_may_use(fs_info,
+							      space_info,
+							      ticket->bytes);
 			list_del_init(&ticket->list);
-			num_bytes -= ticket->bytes;
 			ticket->bytes = 0;
 			space_info->tickets_id++;
 			wake_up(&ticket->wait);
 		} else {
-			ticket->bytes -= num_bytes;
-			num_bytes = 0;
+			break;
 		}
 	}
 
-	if (num_bytes && head == &space_info->priority_tickets) {
+	if (head == &space_info->priority_tickets) {
 		head = &space_info->tickets;
 		flush = BTRFS_RESERVE_FLUSH_ALL;
 		goto again;
 	}
-	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
 	spin_unlock(&space_info->lock);
 }
 
-- 
2.21.0

