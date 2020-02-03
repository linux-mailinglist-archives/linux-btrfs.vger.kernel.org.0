Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF0215115C
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgBCUu1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:27 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46290 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgBCUu0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:26 -0500
Received: by mail-qv1-f66.google.com with SMTP id y2so7468100qvu.13
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HuSDBpvuCX+F7bi3/CaZw77Ffglwhc/jS68wIUdCPhc=;
        b=u9ZBfuon8bApPXIIuTB1+FrDWOrhBVltO4PT7nuvJ/d63PzmddVSYWy9uls59+iS59
         T7M5jVD/SAlx/O3nlpMyy3lPU5XnamQwMoXwBG63yv0+dvnNd1gxyTWBBUJcYENCXBg7
         6UzDOqUJBBQmdawbVHoUqTx4KG/bt1X/A/ItggjzoQxkrhtsgrx12CFGJGU9TIL5VgJp
         1qX25WQCqDeCw3MeAE7B+25QeEfAMFNxD0VdaUcI8j6kYau0/umLEk22FrZfiO0s97vx
         XPciIpjQMHIcNSB5hjiQMNZ7LLtg37XTzmXGmPlQtuoVpTlBIFTjuObEjdqV5DW6QxeU
         ADZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HuSDBpvuCX+F7bi3/CaZw77Ffglwhc/jS68wIUdCPhc=;
        b=dsG8ZqSX98+qyUEvLNoD5n3qsVNUIW6ZIG7Yc9y+v8E+z2Gx/Prkt4eU6Nj6nGLBWR
         HdMDSHbiRRU+Dqs1VTTROv29ojJ5cleS5kzMISNdkoHW3KxZx6Hj7whe53RwEG+cYac8
         BvzrHu1oYtdz0xZewLx4PLhzxMHxoBy1JqDgmOXDatXuN4+iWKHPAOFeRtqZvVnmcyqe
         rOL9bPnOuitq+p7e5RWWLtXvq3jSmW+G9sAEB653Zpt7uBEdwBuze2GC/jpePNENbwm6
         hn4TUS/f5a8x8BuDIvSmFb7XeCqaoUgFSWSJcb/85wKBCFiM73zGNRyAY2QoNO06oM/R
         cnhA==
X-Gm-Message-State: APjAAAVxPAX0UpQ+5qXAshG3gw4OpYi95TDjtPipWjdF7AYrIoF4N84Z
        MWUvZWbPy2AH+hrVW9ZwQTdw3mYj08Gr2Q==
X-Google-Smtp-Source: APXvYqwtmN3wVVAuJHncIjvKfhGjHjs72IYlsRgFLwqOhuFLq+YyEbVV8O4YaTgqV9tRy38tWRGJ+w==
X-Received: by 2002:ad4:518b:: with SMTP id b11mr25010184qvp.195.1580763023796;
        Mon, 03 Feb 2020 12:50:23 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h8sm10537419qtm.51.2020.02.03.12.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/24] btrfs: drop the commit_cycles stuff for data reservations
Date:   Mon,  3 Feb 2020 15:49:45 -0500
Message-Id: <20200203204951.517751-19-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was an old wart left over from how we previously did data
reservations.  Before we could have people race in and take a
reservation while we were flushing space, so we needed to make sure we
looped a few times before giving up.  Now that we're using the ticketing
infrastructure we don't have to worry about this and can drop the logic
altogether.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 225f7f8a0503..8c5543328ec4 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -859,7 +859,6 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 					int states_nr)
 {
 	int flush_state = 0;
-	int commit_cycles = 2;
 
 	while (!space_info->full) {
 		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
@@ -870,21 +869,9 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 		}
 		spin_unlock(&space_info->lock);
 	}
-again:
-	while (flush_state < states_nr) {
-		u64 flush_bytes = U64_MAX;
-
-		if (!commit_cycles) {
-			if (states[flush_state] == FLUSH_DELALLOC_WAIT) {
-				flush_state++;
-				continue;
-			}
-			if (states[flush_state] == COMMIT_TRANS)
-				flush_bytes = ticket->bytes;
-		}
 
-		flush_space(fs_info, space_info, flush_bytes,
-			    states[flush_state]);
+	while (flush_state < states_nr) {
+		flush_space(fs_info, space_info, U64_MAX, states[flush_state]);
 		spin_lock(&space_info->lock);
 		if (ticket->bytes == 0) {
 			spin_unlock(&space_info->lock);
@@ -893,11 +880,6 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 		spin_unlock(&space_info->lock);
 		flush_state++;
 	}
-	if (commit_cycles) {
-		commit_cycles--;
-		flush_state = 0;
-		goto again;
-	}
 }
 
 static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
-- 
2.24.1

