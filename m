Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77F43ACE7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 17:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbhFRPUt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 11:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFRPUt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 11:20:49 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E877C06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 08:18:39 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id j184so11797424qkd.6
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MrdZaXS4R0WpMqM67X2JNI+f37niQhgCpFKg8JB7f/I=;
        b=ggMjffK6Vjq38b5vEO6ORv0yQdSGRpZsaXiPIwSNAVv871lmrXcF55eU4ivd4Ylr3X
         g3uwPvG8Yl6xXqgn0+sCsXwtHi0N/qwbw0xkqPKc4nrXB8Yd0g3QPOHdqMFhiTVYKDUW
         0C3wiZxIpApYwvp0XmyiS8H96OPbk6DrFDKWxId/x3VHdngFxF6t5BYVSYu0RLvRcnOA
         Nq0QcDjXHw4HxsnYUqI1Lf0SqshFNfLM+JVSeuFwK+50zpX4CMLcw2M4Is++hyFSTMxX
         M6Hzi8kKSHNTKXbus8A4JgmwFpC2wNNUim3VQXavq0jpEz2euTkAz/6hQDAWOoQx4Vec
         mzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MrdZaXS4R0WpMqM67X2JNI+f37niQhgCpFKg8JB7f/I=;
        b=bWTDZCumD6QdFGdt+wnEmx16P7fp99NoboT7F6fzs5P/C41Ik74DeW2bRrnjJ6wvbJ
         qp1/IunWpU6QWnPs1xYabXluBHSZGT7msrYXRorLLiGtEkd3Wb4yq8Pj1fH0MSMlkudr
         +djU5u5VxqTeDkBkEiexXW93mGlFucXzikS69AXULoOA8L4ezWirdd3SPc4AKOLCEH8m
         aG6MbtvBK9ZONmarhDsrj3BBlghS5+dLio+58F0gjlWzxNmmkdOub+IheDHK2YfC5ONS
         aZKORfM6Dx6gonI3i08J4YGFd1I5FV4IERVY9JSSZVyQ71OG07uymP63iEGFGA0PvVX/
         tQDA==
X-Gm-Message-State: AOAM532SWBxXjBDMgirxUFWClzU1vbaYcaZ+B/tX69cHyHEK05/WjNLQ
        bqYzXjFtzLfy9yGQbw9iVl9gf/BCkyJgIg==
X-Google-Smtp-Source: ABdhPJzKFKzKbwxvrzrrdXlSSl079oiTwIDlpIconLVjp2bV1svpaX4fKr4ADA4ZYVOfZPjLAZCMtA==
X-Received: by 2002:a05:620a:1322:: with SMTP id p2mr9590823qkj.91.1624029518464;
        Fri, 18 Jun 2021 08:18:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g11sm3425824qko.58.2021.06.18.08.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 08:18:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/4] btrfs: rip the first_ticket_bytes logic from fail_all_tickets
Date:   Fri, 18 Jun 2021 11:18:31 -0400
Message-Id: <ce0d241437de6d1bec0a821c8d01e6c2e04ed7c5.1624029337.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1624029337.git.josef@toxicpanda.com>
References: <cover.1624029337.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was a trick implemented to handle the case where we had a giant
reservation in front of a bunch of little reservations in the ticket
queue.  If the giant reservation was too large for the transaction
commit to make a difference we'd ENOSPC everybody out instead of
committing the transaction.  This logic was put in to force us to go
back and re-try the transaction commit logic to see if we could make
progress.

Instead now we know we've committed the transaction, so any space that
would have been recovered is now available, and would be caught by the
btrfs_try_granting_tickets() in this loop, so we no longer need this
code and can simply delete it.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 5645f9667d90..e969cba0f3b7 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -879,7 +879,6 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 {
 	struct reserve_ticket *ticket;
 	u64 tickets_id = space_info->tickets_id;
-	u64 first_ticket_bytes = 0;
 
 	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(fs_info, "cannot satisfy tickets, dumping space info");
@@ -895,21 +894,6 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 		    steal_from_global_rsv(fs_info, space_info, ticket))
 			return true;
 
-		/*
-		 * may_commit_transaction will avoid committing the transaction
-		 * if it doesn't feel like the space reclaimed by the commit
-		 * would result in the ticket succeeding.  However if we have a
-		 * smaller ticket in the queue it may be small enough to be
-		 * satisfied by committing the transaction, so if any
-		 * subsequent ticket is smaller than the first ticket go ahead
-		 * and send us back for another loop through the enospc flushing
-		 * code.
-		 */
-		if (first_ticket_bytes == 0)
-			first_ticket_bytes = ticket->bytes;
-		else if (first_ticket_bytes > ticket->bytes)
-			return true;
-
 		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
 			btrfs_info(fs_info, "failing ticket with %llu bytes",
 				   ticket->bytes);
-- 
2.26.3

