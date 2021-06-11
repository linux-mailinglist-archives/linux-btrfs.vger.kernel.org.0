Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDDA3A4402
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 16:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhFKO02 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 10:26:28 -0400
Received: from mail-qv1-f49.google.com ([209.85.219.49]:33429 "EHLO
        mail-qv1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhFKO01 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 10:26:27 -0400
Received: by mail-qv1-f49.google.com with SMTP id l3so9554310qvl.0
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 07:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jguRLqyoY0BLNK40bNclOF99S1l9fUwa49OWi7NY7bk=;
        b=hnoRCjhEfGTwcz15wKU6CridYMwp9py2h/xuiRRYFs16e7IOpY+sCp4RPbCyYFsxuG
         quRvKAwIhJNiix15w5aPJXOKRQRl/x8KnzsogjI1GiDZQX74Uf9g7nYnOijWyDn2ETmJ
         YwXVxrvWR+lkO0e2u8J+hsu9/s1rePmvcbOuoDDN23Z+qXnNySpQcQylacw5jleeDAdK
         beMfqmyjPeoEezCN378/RCUTH0K0ZKUWcyoB7W6C+HMerJ08Xod9F1iUeDYlBs3lXjPX
         duJBv0nYpnvW7PAtB8MeqO2j6BdZdwX7laTXR0msxWzMA93gCGNvQcXqjkBEK5HnHyWY
         mUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jguRLqyoY0BLNK40bNclOF99S1l9fUwa49OWi7NY7bk=;
        b=Hg8lz1fij9D2l7JFXpLHVTfdOiBwauZcfkjFJW9KY3+c1K+RFy8sXsgBfRECkyQ3y2
         clffehEWwJIOsw1kVOJrSjMPdF5wcCivYz3BN2uqo9f/eBDNqu8TbHKXo/wd8ubh28S0
         2TgIdV+3Z/YZkSEU6w77YpYbSdt6+7J17WwLaRyLe+cojrgbVhf5NPzsrs9yG/v/gyXI
         U/3PW7MMKQ9x/ncyutBOUaY3gA3Iw3KV+QJhS7FZ+X5qcaV6mBT30VlN9+mMwZMhHGxr
         7cBJFefg/tp9Bx6XTUvrUAqjZ9hP2XBsKeMynxi1rGnZGrk3s9+us3CujAp2yIbuLXTw
         2IZQ==
X-Gm-Message-State: AOAM532RS7Cw/d6VtREb1qNuPMc8tcFKVAEvaGXg+lwymTJ6KD/wol/U
        BVc5lWHh8NYJwwY7jw6SW1bnVipx8IyWGw==
X-Google-Smtp-Source: ABdhPJywpaP+on7dVFPclq6BA4WfpHklQwxlH1iQNA1IeYFDdG0NwFpFX6MLk6c5nUvv2+xzhFNttw==
X-Received: by 2002:ad4:5227:: with SMTP id r7mr4992144qvq.41.1623421395079;
        Fri, 11 Jun 2021 07:23:15 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f9sm4637217qkl.46.2021.06.11.07.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 07:23:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs: rip the first_ticket_bytes logic from fail_all_tickets
Date:   Fri, 11 Jun 2021 10:23:09 -0400
Message-Id: <7b31dc91dbdb59dfb3fec45a6d16309d7f0b9c4f.1623421213.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1623421213.git.josef@toxicpanda.com>
References: <cover.1623421213.git.josef@toxicpanda.com>
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a4cfc8feadf1..a2bf13206d8b 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -873,7 +873,6 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 {
 	struct reserve_ticket *ticket;
 	u64 tickets_id = space_info->tickets_id;
-	u64 first_ticket_bytes = 0;
 
 	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(fs_info, "cannot satisfy tickets, dumping space info");
@@ -889,21 +888,6 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 		    steal_from_global_rsv(fs_info, space_info, ticket))
 			return true;
 
-		/*
-		 * may_commit_transaction will avoid committing the transaction
-		 * if it doesn't feel like the space reclaimed by the commit
-		 * would result in the ticket succeeding.  However if we have a
-		 * smaller ticket in the queue it may be small enough to be
-		 * satisified by committing the transaction, so if any
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

