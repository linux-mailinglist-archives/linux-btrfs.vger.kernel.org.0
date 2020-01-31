Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD0AD14F4DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgAaWgu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:50 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:40499 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAaWgt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:49 -0500
Received: by mail-qv1-f65.google.com with SMTP id dp13so4039965qvb.7
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=33hR81qqU939Th9PD2Iibmlu9uXeO2M0EG13L9JDzGI=;
        b=ZC3/uUmbX2Tsjbc+X1IkqnxsGYH8PWnii0CpbhTpF5KeyLT9mpsI9MocsHF8o2Mr/H
         RTSH1kbQhg6Mw2BWcskzlglKERNE06HWPPkbvEXOuVircZqeKhyfIyc+YVtNHmazT4n2
         iI6pmojMfLsbMBfSF4I4zi+dRTVyt9JLvquGhJDCGi5nnhgjHckfZJSkbxX+I6MRmJ06
         /by/n95lIaroKn3pwdATJJ6qNhNg65wuJIxW/tgfr8U/IL1MMUnX0eP/Cz4EptF5LwW6
         EYRsEK7jF+DJxHhU45h+wHiwKPUReH+VopY1OMi3WsIw+zIcKxysux1VNarmt03SVwxg
         7xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=33hR81qqU939Th9PD2Iibmlu9uXeO2M0EG13L9JDzGI=;
        b=niGkmKIBb1BQfc7WLt/7ji7KpBOeA/IpZ+11uFT8m6OYvrksOQ6LGfk9o9y52Y63Gh
         UMo9GvZxjkq26bVsY4GZAMnlxoG5WUjcF04cqyRqPvkJhDSvSTHASV8zQZGS+/phzrng
         CSomUDkEfRtkXZrzXfDkB0FGl1LUNc7WeZSCBZw8Sm0HFvaxgAxHfQrQ09v96zMop87g
         NgO0HaS2k5qPhBG8Uv4xdu/ayHOuSG+El3qnt6cTDF4QS1vKjUA/eupTJVqrlIUAwQa8
         7B9UraT/t/1WxDOKqy9QmsbWHgZSIcWrSrgJRBN4IxWZuTkfEouKvMZjAMjJrh2gUR15
         6UoQ==
X-Gm-Message-State: APjAAAVAriPxch2zKQQfK7rrP8K9QTmg8tEpOiWV3NAXJtJJ6qdNPjgT
        IdhzFVQJhKhOH1L1R6OOyrFHUVa+LLsPdA==
X-Google-Smtp-Source: APXvYqwQDJ6A+1G8I1jDDUUNuw031skL0hyursEOeisXJK3KiOtysFB9DwPNrjcNHBgBUUAijgoA/Q==
X-Received: by 2002:a0c:f513:: with SMTP id j19mr12575699qvm.206.1580510207581;
        Fri, 31 Jan 2020 14:36:47 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v10sm5568289qtq.58.2020.01.31.14.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/23] btrfs: drop the commit_cycles stuff for data reservations
Date:   Fri, 31 Jan 2020 17:36:08 -0500
Message-Id: <20200131223613.490779-19-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
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
index 13a3692a0122..3060754a3341 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -858,7 +858,6 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 					int states_nr)
 {
 	int flush_state = 0;
-	int commit_cycles = 2;
 
 	while (!space_info->full) {
 		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
@@ -869,21 +868,9 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
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
@@ -892,11 +879,6 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
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

