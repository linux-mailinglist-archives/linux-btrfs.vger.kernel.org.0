Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FE42189B5
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbgGHOA5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbgGHOA4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:56 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FC1C08C5CE
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:56 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so34523108qtg.4
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HYvFTR2wkUcDKdml4Bzn2R6cx4pTZvSFMrHCayhIgeY=;
        b=Mr5qqmiH9QrWMRU2lz1gEjLPOFc2wMgaTFgrfyyM6RpgDS+UI28fltDw7gGhFzQcs2
         fbr1cTNXG9f7wC3nAFoVDQSczxYxMs+4epS8kGY0Z0B4ufDzQxpHga/uAg3EXd9ZGZFL
         LpT4vOF56CcryDzhyG+bIpS8db8jFj5I374d59ysmwXNLbYuEZWYBq1B/VKX78kKiRZL
         YYqIW4gnObMnI0joSSAh86JT9u0xA28B6yQbH+R8rbOtuuCv05C8bczHQT50H51yLInY
         jh3wAYUeyJJPM6kiuYAa79jCk4ibz8Sg/TLR0AHe4eVNkoYER0pGBR2m4LOnlZX5Xf1b
         KDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HYvFTR2wkUcDKdml4Bzn2R6cx4pTZvSFMrHCayhIgeY=;
        b=Oc35aBg0mVWoA8NGIFBz01J4+E3DI29VQb74Mcnaw+QoiocOzNkSVCiD40mBZeN+A3
         yy5RUqBleW7NKeXPiGFyQSlkRRWNMAjR4SoVG3LfLMPoE+oJEqQXLt9L/+jCAb1uTOkv
         275mcj47e5TiEDV3Z9EFp22CTGu+BnVaMnuzsei/qZdxaN5EHi9nS6IRAeG5X9Q4+Nsm
         gmKc/esHu5DgbKyIaMGKbpU/kt+u24YW/3JCIn74+lR/eOXKaeoIHhivqgvK0ZoDs7dM
         AU9P28HOfc7QdjQ/KtajojswvJij5hMHDIJ9WeY9lAtHwKQsnFaiNKf7ofK1eIDTi7Tv
         2cKg==
X-Gm-Message-State: AOAM5309WtzgxLXJxWXSJnVnCrlwSmPNjU+cxasqY8o1nEWkgb84Z+2X
        /C4QpojNnl088MWIG7EXfc49kEtSXm94Jw==
X-Google-Smtp-Source: ABdhPJxsN9plOPJbViKqNftGfIcSOcOg6QzKSRWqFGtJDQ2BPNhlqLJelrsmcOtroOH9eUjGMoGW1g==
X-Received: by 2002:ac8:3fac:: with SMTP id d41mr57082119qtk.98.1594216855533;
        Wed, 08 Jul 2020 07:00:55 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x3sm29112611qkd.62.2020.07.08.07.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 18/23] btrfs: drop the commit_cycles stuff for data reservations
Date:   Wed,  8 Jul 2020 10:00:08 -0400
Message-Id: <20200708140013.56994-19-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
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

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 605be9f4fcac..5efb3eb9253d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1077,7 +1077,6 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 					int states_nr)
 {
 	int flush_state = 0;
-	int commit_cycles = 2;
 
 	while (!space_info->full) {
 		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
@@ -1088,21 +1087,9 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
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
@@ -1111,11 +1098,6 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
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

