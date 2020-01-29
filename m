Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD3414D410
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgA2XvC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:51:02 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46352 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgA2XvC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:51:02 -0500
Received: by mail-qk1-f194.google.com with SMTP id g195so1140054qke.13
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wpRCXuT4RVl0aWPQz0eOjhO1Vktmv1x8Dohk2ie2oyw=;
        b=VTCAW6nR23y+uho/MC5AErYip8MTqQRDW+oKGvH3CfQpxZu4aeYLaHFcfG50IprH/U
         dK8QIO1yqXcD6wslpYlH+vxiDmUxOlVbhgAAOvGDtrkPab2/Fo7ctziP7raTueeXdejT
         oY7wFGWjsMZolWhtokpVoeht8Hv8+Ac7Uds9V6ZEF6aIIs7nWVcN6fukh1c2gyZ9j4vW
         hLQjILEfrvugipNbGtVOqfgA0h/6ilmGmPIoPmm9qD6QJ2O6JW0fANg7Dg1JnI7mA9xj
         HM2KvXPjH2LR67X99fPcCneJ1B734epvQeJBTzNXDcxOqJj4zhNihPzEqzHuUMv0NRVJ
         mduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wpRCXuT4RVl0aWPQz0eOjhO1Vktmv1x8Dohk2ie2oyw=;
        b=FjpxlTEobAPOwNb0KHrQb/xCJC+ZxEtljBPEZCFSXuP6Heua2fiSKfrRWWp8c4E+lQ
         RWhVAKbLGZ+7t3dKkgqx+jK1cNgZ+WlWi1IYD9wMcIDmklOGw9BWIna0wA0qliURYRQD
         6JQSXWmTTZ35Jhan7dy7/SHQ352OKAeLcW9kKOPvstzSCWvi+avSj4T9lqXFeNI/38g8
         x/zXxUm2OcU7LqBB6+b6TotRFV8Zc7oA/JNFg/44mXUIZcs/SPIEGnTVPysNIaCp3IrD
         epWywsyJh5Iw6qTRtY2K2ob1WfK83rXVQjHBIfClZZ19IqI4TemwOCiOPQwIbbN8KJsb
         v9Iw==
X-Gm-Message-State: APjAAAWIGNOPomlE2HsAF6Ucx2+vHjVvvxH95Cvigo7Ti8U7XEWKFMRe
        jsAe0L31Tf2SaY1D8BiQPsDikFOq6Pcj1g==
X-Google-Smtp-Source: APXvYqyg5x2niigZucJoVbY6EexYU4HTBTL01I/hEcnq7mdZ6/OR/tr9nd5Pnu3dJGFNaCNtJ6oEmg==
X-Received: by 2002:a05:620a:100d:: with SMTP id z13mr2591404qkj.475.1580341860466;
        Wed, 29 Jan 2020 15:51:00 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 184sm1799299qkl.81.2020.01.29.15.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 20/20] btrfs: kill the priority_reclaim_space helper
Date:   Wed, 29 Jan 2020 18:50:24 -0500
Message-Id: <20200129235024.24774-21-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that only the metadata stuff is using the helper, merge it into the
priority metadata reclaim loop.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index b47eca433c62..6db8ca1419cd 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -917,27 +917,6 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 	COMMIT_TRANS,
 };
 
-static int priority_reclaim_space(struct btrfs_fs_info *fs_info,
-				  struct btrfs_space_info *space_info,
-				  struct reserve_ticket *ticket,
-				  u64 to_reclaim,
-				  const enum btrfs_flush_state *states,
-				  int states_nr)
-{
-	int flush_state = 0;
-	do {
-		flush_space(fs_info, space_info, to_reclaim, states[flush_state]);
-		flush_state++;
-		spin_lock(&space_info->lock);
-		if (ticket->bytes == 0) {
-			spin_unlock(&space_info->lock);
-			return 0;
-		}
-		spin_unlock(&space_info->lock);
-	} while (flush_state < states_nr);
-	return -ENOSPC;
-}
-
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info,
 				struct reserve_ticket *ticket,
@@ -945,6 +924,7 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 				int states_nr)
 {
 	u64 to_reclaim;
+	int flush_state = 0;
 
 	spin_lock(&space_info->lock);
 	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
@@ -953,8 +933,17 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 		return;
 	}
 	spin_unlock(&space_info->lock);
-	priority_reclaim_space(fs_info, space_info, ticket, to_reclaim,
-			       states, states_nr);
+
+	do {
+		flush_space(fs_info, space_info, to_reclaim, states[flush_state]);
+		flush_state++;
+		spin_lock(&space_info->lock);
+		if (ticket->bytes == 0) {
+			spin_unlock(&space_info->lock);
+			return;
+		}
+		spin_unlock(&space_info->lock);
+	} while (flush_state < states_nr);
 }
 
 static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
-- 
2.24.1

