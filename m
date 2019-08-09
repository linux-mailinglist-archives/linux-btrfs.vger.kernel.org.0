Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B3E87B3A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 15:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436491AbfHINdn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Aug 2019 09:33:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37264 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436480AbfHINdm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Aug 2019 09:33:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id s14so1189471qkm.4
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Aug 2019 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2i4ZX3MimWmcuE9B8CpC/8aTTvyW6mqqZ/EC7X8p8bk=;
        b=iryLCL+yYkFg+4ugeL+mUyNZOmeD6supHDTO5d90Gk0CMNkAGfx3ULvi58yot++bQr
         NOe8duicr9+5A/beWokXLqAfskSZhvIMlECK3He/u1o96lRud8aw2t/hcXlhZzdr1PVE
         4M6g9EmZcotCPlT807Yen7ga6eQlctvItyCYGVlNG4H5LQaNVDCvcoPfocFd7wZB3sAW
         IyrHmU5lvWKggpM9QGSi0Ii3xNr7cAIxAONPxGZ4URKfpXfbmrQspcpccgxGawtsAcUD
         /0odKke08iskXy4BiFWldry+96gvXFpHJ4rZkve9Z7rAshFVkJSTtQAqna5ktlGzzfJY
         4xMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2i4ZX3MimWmcuE9B8CpC/8aTTvyW6mqqZ/EC7X8p8bk=;
        b=b4Ccrh4CBrjgNBOnhzRUMRtFc0EFJgMIeXPsYkWB4Tz0J1YWX205NIkRMh16x5fZsb
         +dzb1F3Uyp5acpKaxA1LvZ7blX6nyglpPcEylcN2cbSajtRoe6wReQD22qTNaJbYCgeK
         ld9Hv8Y5yiqli0vyzRj5nTTYH7iB6CLADjcQFf5rBXmgRTKx4rGu06lVofDd9tHvAypv
         Yj86vJZ5lcyBNOkl+Qdv9hPBJJYsNGcDAXn7Kk906SkHkn8KLgYeJOeeCYdtwifn+82H
         3s3xpvrj1TkBroWvC3Bru9AGgp+qQ5kjwuk1YDKUaPITm8gsErEsDJxkJZ4fTMKOPPA0
         BHOA==
X-Gm-Message-State: APjAAAVnNhBNzu8OluLRzsPsSZvtW9oUlrF4Hm5gcBkz6BsYDFoDrPaY
        Ej1J3Ba4QzlVTQu3yWdo2pP6xJvr/3W+6g==
X-Google-Smtp-Source: APXvYqxqv/urEkvSY9C18hyp43eX0OKmFnFBxrjhYjw7PdMPJz5zcnCQyowIKlIcsrx1/khVkc8TtA==
X-Received: by 2002:a37:7d02:: with SMTP id y2mr15826120qkc.419.1565357621484;
        Fri, 09 Aug 2019 06:33:41 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g35sm52455797qtg.92.2019.08.09.06.33.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 06:33:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/7] btrfs: remove orig_bytes from reserve_ticket
Date:   Fri,  9 Aug 2019 09:33:27 -0400
Message-Id: <20190809133327.26509-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190809133327.26509-1-josef@toxicpanda.com>
References: <20190809133327.26509-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we do not do partial filling of tickets simply remove
orig_bytes, it is no longer needed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 15 ---------------
 fs/btrfs/space-info.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 163400a39e81..d9c16c17fb5b 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -820,7 +820,6 @@ static int wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 
 {
 	DEFINE_WAIT(wait);
-	u64 reclaim_bytes = 0;
 	int ret = 0;
 
 	spin_lock(&space_info->lock);
@@ -841,13 +840,7 @@ static int wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 		ret = ticket->error;
 	if (!list_empty(&ticket->list))
 		list_del_init(&ticket->list);
-	if (ticket->bytes && ticket->bytes < ticket->orig_bytes)
-		reclaim_bytes = ticket->orig_bytes - ticket->bytes;
 	spin_unlock(&space_info->lock);
-
-	if (reclaim_bytes)
-		btrfs_space_info_add_old_bytes(fs_info, space_info,
-					       reclaim_bytes);
 	return ret;
 }
 
@@ -873,7 +866,6 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 {
 	struct reserve_ticket ticket;
 	u64 used;
-	u64 reclaim_bytes = 0;
 	int ret = 0;
 	bool pending_tickets;
 
@@ -907,7 +899,6 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	 * the list and we will do our own flushing further down.
 	 */
 	if (ret && flush != BTRFS_RESERVE_NO_FLUSH) {
-		ticket.orig_bytes = orig_bytes;
 		ticket.bytes = orig_bytes;
 		ticket.error = 0;
 		init_waitqueue_head(&ticket.wait);
@@ -954,16 +945,10 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	priority_reclaim_metadata_space(fs_info, space_info, &ticket);
 	spin_lock(&space_info->lock);
 	if (ticket.bytes) {
-		if (ticket.bytes < orig_bytes)
-			reclaim_bytes = orig_bytes - ticket.bytes;
 		list_del_init(&ticket.list);
 		ret = -ENOSPC;
 	}
 	spin_unlock(&space_info->lock);
-
-	if (reclaim_bytes)
-		btrfs_space_info_add_old_bytes(fs_info, space_info,
-					       reclaim_bytes);
 	ASSERT(list_empty(&ticket.list));
 	return ret;
 }
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 9ae5cae52fde..ebc5b407a954 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -70,7 +70,6 @@ struct btrfs_space_info {
 };
 
 struct reserve_ticket {
-	u64 orig_bytes;
 	u64 bytes;
 	int error;
 	struct list_head list;
-- 
2.21.0

