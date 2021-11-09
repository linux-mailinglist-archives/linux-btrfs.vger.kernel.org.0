Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9407F44B01B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 16:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhKIPO6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 10:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhKIPO6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 10:14:58 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FA9C061764
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Nov 2021 07:12:11 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id t11so1458617qtw.3
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 07:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PY+Tb/hXONSwfiHE9mGSVdCqtFpHa6qIEurbMEgXjn0=;
        b=46w2wPzLRC9wy+WuZgoAPM/F67hly+HbYHbbR4a0HcIwweReyy6ZT7Ajl1e7TW23Mv
         ygofiQMAEZV3+r1xgi7i4q2VYZ9F1S44YSE1tPHOqNDlcHiA93lYFVsc5bWvOdWPVZ+m
         GhJI71Nnb1VPsKkwG7QOMkHGPG6RegLgekDCTyIQeHnHKFUQFksEJ0FRfDNP9AGYMlTc
         Tb7lF+pwt6erpikSTNvMGxGgbhxyad42+ejYLS+xvKqLzddGUk9zM9xeBXGk7VDDuluj
         Yi5qtSpGWB8yGDBAn7WrzWnSoqYa3fLfFoVXdsMlzH7KWccnYKgfu9EFn7sAc+9Db69d
         +VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PY+Tb/hXONSwfiHE9mGSVdCqtFpHa6qIEurbMEgXjn0=;
        b=279l8U69WvgcSjqvc3CJCzqWqAYNKi64aOuRkvqhPWqZESWUz4DexX3MHRa7AVWb4Q
         Q2SQeu6+245jtziCcFxC8wYQyFp5bmu6EyztFm49XYGTV8HCD/fFJb+QaJ1k99RYanxC
         tDVl18QLZ6IFUp47QUA58lqZhm7/+gamcS0asq4LT6UsQ7BLQUt9lP4m8NKwcuq+zWaU
         xKaIEdIIr9FDjhhIpqzul+FKTgjed1gL9Q7d3IaTmM1/o8D4ZjFZRpv8T99BAUQNGyvD
         mV/IOPLf3rIitmyluglH6NWjemRCRTWSbRpBf0So1s6mV6DHCAYDwDY49QFRC4wvUTDC
         /X2Q==
X-Gm-Message-State: AOAM5310AUtRztpF9crN3AunzJUN+a6ucJ16Wd2ptdlv0EuU6s/83SF4
        k3pY93kv1/YkvEOWefyUYO1HICzoKpgfBQ==
X-Google-Smtp-Source: ABdhPJwQTIDF7mZab5Yb2SQwD9/MVCd0tlF5YtR4H5GwUZNQD/wQkKgkPmWhyx2F0W4arbjV/Gw8GQ==
X-Received: by 2002:ac8:5855:: with SMTP id h21mr9222862qth.8.1636470730482;
        Tue, 09 Nov 2021 07:12:10 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q4sm12746389qtw.19.2021.11.09.07.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 07:12:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 1/7] btrfs: handle priority ticket failures in their respective helpers
Date:   Tue,  9 Nov 2021 10:12:01 -0500
Message-Id: <78469f9381de3b91f689d419cb0d632346d294b8.1636470628.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636470628.git.josef@toxicpanda.com>
References: <cover.1636470628.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently the error case for the priority tickets is handled where we
deal with all of the tickets, priority and non-priority.  This is ok in
general, but it makes for some awkward locking.  We take and drop the
space_info->lock back to back because of these different types of
tickets.

Rework the code to handle priority ticket failures in their respective
helpers.  This allows us to be less wonky with our space_info->lock
usage, and means that the main handler simply has to check
ticket->error, as the ticket is guaranteed to be off any list and
completely handled by the time it exits one of the handlers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 46 ++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 48d77f360a24..9d6048f54097 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1260,7 +1260,7 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 				int states_nr)
 {
 	u64 to_reclaim;
-	int flush_state;
+	int flush_state = 0;
 
 	spin_lock(&space_info->lock);
 	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
@@ -1268,10 +1268,9 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 		spin_unlock(&space_info->lock);
 		return;
 	}
-	spin_unlock(&space_info->lock);
 
-	flush_state = 0;
-	do {
+	while (flush_state < states_nr) {
+		spin_unlock(&space_info->lock);
 		flush_space(fs_info, space_info, to_reclaim, states[flush_state],
 			    false);
 		flush_state++;
@@ -1280,23 +1279,38 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 			spin_unlock(&space_info->lock);
 			return;
 		}
-		spin_unlock(&space_info->lock);
-	} while (flush_state < states_nr);
+	}
+
+	/*
+	 * We must run try_granting_tickets here because we could be a large
+	 * ticket in front of a smaller ticket that can now be satisfied with
+	 * the available space.
+	 */
+	ticket->error = -ENOSPC;
+	remove_ticket(space_info, ticket);
+	btrfs_try_granting_tickets(fs_info, space_info);
+	spin_unlock(&space_info->lock);
 }
 
 static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 					struct btrfs_space_info *space_info,
 					struct reserve_ticket *ticket)
 {
+	spin_lock(&space_info->lock);
 	while (!space_info->full) {
+		spin_unlock(&space_info->lock);
 		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE, false);
 		spin_lock(&space_info->lock);
 		if (ticket->bytes == 0) {
 			spin_unlock(&space_info->lock);
 			return;
 		}
-		spin_unlock(&space_info->lock);
 	}
+
+	ticket->error = -ENOSPC;
+	remove_ticket(space_info, ticket);
+	btrfs_try_granting_tickets(fs_info, space_info);
+	spin_unlock(&space_info->lock);
 }
 
 static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
@@ -1378,25 +1392,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 		break;
 	}
 
-	spin_lock(&space_info->lock);
 	ret = ticket->error;
-	if (ticket->bytes || ticket->error) {
-		/*
-		 * We were a priority ticket, so we need to delete ourselves
-		 * from the list.  Because we could have other priority tickets
-		 * behind us that require less space, run
-		 * btrfs_try_granting_tickets() to see if their reservations can
-		 * now be made.
-		 */
-		if (!list_empty(&ticket->list)) {
-			remove_ticket(space_info, ticket);
-			btrfs_try_granting_tickets(fs_info, space_info);
-		}
-
-		if (!ret)
-			ret = -ENOSPC;
-	}
-	spin_unlock(&space_info->lock);
 	ASSERT(list_empty(&ticket->list));
 	/*
 	 * Check that we can't have an error set if the reservation succeeded,
-- 
2.26.3

