Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4540587B33
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 15:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407106AbfHINdd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Aug 2019 09:33:33 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35543 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405928AbfHINdd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Aug 2019 09:33:33 -0400
Received: by mail-qk1-f194.google.com with SMTP id r21so71672266qke.2
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Aug 2019 06:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cmW3UFbBlGjTisynlbpiDbAThhD0Rx5sNFO09Vwh2QA=;
        b=2NAsjxh/FUv3AyboEhnMVTxE08NUyym0a+du9hraJnT6INtCtVBXjsarF0HnfYVE1m
         u4gWuDhlyJWY7qRjVAZzHOvmWiiEyRP6baQK+yqJlNdAEePCf3i/ETf/EYurGoEQr2Ge
         U9oSPlr40D+wjQ51v8erlDV33ySybLv0cjNKWtY0SuZ5X6a7hPmQ8EvZOICVAqH0L1w/
         yqWSc67m2NKn7rG2/QdN09VNEbnW4HzNG0Y0HaumMrViYlSiBHNHCl3QN2BVgEJW+hRu
         BtQ+o9OAcLWobnrnDLG0eKIEDgiVtJc7Mp9v4/T3n0uyNTVZnaIWTlyArAUNMilLbMvZ
         JVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cmW3UFbBlGjTisynlbpiDbAThhD0Rx5sNFO09Vwh2QA=;
        b=eZHtzSAIHnmDpuZoJVIx31Rar+D7YzKi1iJB2bQie1VH+BN7a61xbMIEoLnWUr6udO
         DcwhcaEHYOICqD5gQExBbqu3hU1YRPZ78Sds9nf9olDOzUZj6BqySy39633uE9AOi85w
         fmQIa8pSwG6wuqPs+dKlafyxb0/Qn8xXGS9fgG7cTqIjyAl7HJ0eMeHFKm0+/BA0csTw
         WEDnO5QbTmz+NAcul/dRAkLIh8QNYXENhKouCMMbhWs8gOHIeUm87t9iiRM5LA2QflnG
         UKDxqNFtmz2VRiXLHo9Vl9lWVATsLbSCs4g5rqW+6ULBKhLgxuim1uJ1Tjdg3wuzCjTt
         IpVA==
X-Gm-Message-State: APjAAAUALHeH0Z4beSkAoj6yMF9U1UhYE9yXZmTfwRPfOTzeGFYtG/pD
        NhmyI7gNR8YTjimZ6V7LyRfkHEclyscTDA==
X-Google-Smtp-Source: APXvYqxogfwHcfBarQsXn7sgtytCFm51wKs9CSBhFTaJ4En3y3+iz/snyGRbzU2ugG5MNzQ3fAzcmA==
X-Received: by 2002:a37:ef1a:: with SMTP id j26mr8570537qkk.474.1565357611458;
        Fri, 09 Aug 2019 06:33:31 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f12sm1024118qkm.18.2019.08.09.06.33.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 06:33:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/7] btrfs: do not allow reservations if we have pending tickets
Date:   Fri,  9 Aug 2019 09:33:21 -0400
Message-Id: <20190809133327.26509-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190809133327.26509-1-josef@toxicpanda.com>
References: <20190809133327.26509-1-josef@toxicpanda.com>
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

