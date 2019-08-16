Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4F7903DA
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 16:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfHPOT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 10:19:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42613 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfHPOT7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 10:19:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id t12so6232585qtp.9
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cmW3UFbBlGjTisynlbpiDbAThhD0Rx5sNFO09Vwh2QA=;
        b=kbGYW7j+gwhURgChF/lNPWA2EyVCJ5ob6ILG2GWm/6E6qB+LEHPtMPsGySU93qxNcp
         gWXKk68DtU5JQ5CzvaNQrODzWSiy8v9QGd1Y8TOQaxo0sCU327M5f6qm59mnY78A1hSd
         jn/x2q0xQKhp7mUwlgs3+LyfYfsvx4jLQqzWZjXMiPQxH8FyKwoFNM8SGHaLjYP4w2EG
         3YlST8Yyjs46k/uBuhFSIbPBB01z8vwNjFsqwZnzfihC25OxpV0F9dz6vGH28DRFzq7X
         uKre7wMFyvoA1gb7WUZ1Bthw6awnvQTPAKuN3z0Wi/kfIetHebP6IeDUnPryrLBn4pXc
         T1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cmW3UFbBlGjTisynlbpiDbAThhD0Rx5sNFO09Vwh2QA=;
        b=V9yQP/1fJIzULfvvZjz0u3iHydx3lQog23yqZ3d9g/UwGBA0flJi4bwjUFiGF5ivg5
         KxuRTz88mE+1z8rPBLCWh8Ch/rAl4YVzlYSjrbFDJRijSJHnsjhzXyAIVdbsjsPBNUqF
         6kW4fF8VcHgNpX48UbRvptPx54y3rxiyPu8PdTXiN0MkfvOFBl3BMTTeaOddSEsq1D7j
         FeKOJgVkBuCphjNYBx4pXrsFYhDOHzv9av7JbL5vUt6bc7r7lNsrGz/DtRb8eyYjKApX
         PoxuysKVJM1rfH2WH18QugPRA0cNHhmmefWoQEifmgzTpidr5I3bJzdnXThj7VBHsLjS
         j6Lw==
X-Gm-Message-State: APjAAAWp/SivbzcEHx/qyarLzp3K/PEYOyWKdxe91AAQtG0G/MGC0US2
        uCFnVIkQW4iumieLTJxaSWvxLNL/toTeMA==
X-Google-Smtp-Source: APXvYqzxVcgUi/1KHTz8+bAtFXRTGSeb5PlTd43iXRdUxbR3wqRwWaxQZ/w7ozY61s+vr6A9yEh3ew==
X-Received: by 2002:aed:359d:: with SMTP id c29mr9251781qte.4.1565965198120;
        Fri, 16 Aug 2019 07:19:58 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b127sm3066866qkc.22.2019.08.16.07.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 07:19:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/8] btrfs: do not allow reservations if we have pending tickets
Date:   Fri, 16 Aug 2019 10:19:45 -0400
Message-Id: <20190816141952.19369-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816141952.19369-1-josef@toxicpanda.com>
References: <20190816141952.19369-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we already have tickets on the list we don't want to steal their
reservations.  This is a preparation patch for upcoming changes,
technically this shouldn't happen today because of the way we add bytes
to tickets before adding them to the space_info in most cases.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index e9406b2133d1..d671d6476eed 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -938,6 +938,7 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	u64 used;
 	u64 reclaim_bytes = 0;
 	int ret = 0;
+	bool pending_tickets;
 
 	ASSERT(orig_bytes);
 	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_ALL);
@@ -945,14 +946,17 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	spin_lock(&space_info->lock);
 	ret = -ENOSPC;
 	used = btrfs_space_info_used(space_info, true);
+	pending_tickets = !list_empty(&space_info->tickets) ||
+		!list_empty(&space_info->priority_tickets);
 
 	/*
 	 * Carry on if we have enough space (short-circuit) OR call
 	 * can_overcommit() to ensure we can overcommit to continue.
 	 */
-	if ((used + orig_bytes <= space_info->total_bytes) ||
-	    can_overcommit(fs_info, space_info, orig_bytes, flush,
-			   system_chunk)) {
+	if (!pending_tickets &&
+	    ((used + orig_bytes <= space_info->total_bytes) ||
+	     can_overcommit(fs_info, space_info, orig_bytes, flush,
+			   system_chunk))) {
 		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
 						      orig_bytes);
 		trace_btrfs_space_reservation(fs_info, "space_info",
-- 
2.21.0

