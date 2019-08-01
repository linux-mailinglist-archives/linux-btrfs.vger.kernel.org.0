Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD1A7E54A
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 00:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389413AbfHAWTq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 18:19:46 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33164 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbfHAWTp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Aug 2019 18:19:45 -0400
Received: by mail-qk1-f195.google.com with SMTP id r6so53360349qkc.0
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Aug 2019 15:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=39tRD4ERVlmwGjOdzj80UbySnKVSDHkeFPViDOFUU98=;
        b=egRSNp08vcH9TwEGJ9fT2bekcUqC9r1/oSNi4/MPsC+A031hBSvIyyPec90l8L9LeR
         EbZ8PuQc50UUeQKIg9Xmy76iTb6KdIh4k9D1+oi+uBy8hZmC7ljscF8uJ6J3msIgOYFW
         IklGJB39G1ftY/N1+kcFduxb75ECSClth0xEgUUnOVx86xhyBu63Kh93wn3+ZkDN0m8J
         wNZUW0XLMbxYMaFvcmao6BUbs5a5ttN/+HXMwO17TEQBM+4dF1iksdhrbfYZh8xG0WVX
         l70EO+zaH8wNH5+eMU3VE+Fb3NFIhuetnuYPFJgBklFCH1H+qjBnisK+VvyY5xv3TL6Y
         3p7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39tRD4ERVlmwGjOdzj80UbySnKVSDHkeFPViDOFUU98=;
        b=lhmYzo9m4wcHKG6ZHOZW8iEn+XBKFIKrFDIIR0Gh0z3nkY2fKH+Bm4cYGImJHVlcos
         4xEjGBIE0gT0B+KM3x7opPd/hlm8o/Nyt78Fb6mh1BK4RwNTX1ijnxb9xzjFiNRjORmO
         kwNbAsRI3QlTKeHaKcLaSeDJgoRggEsXfPnoTK6Qv29mU+8bH4HyyqeK/iTVsnS/xKAU
         yg7Zlx55TzSmBv/tvSgGjHh7mZE8IF+Fe03LiU2YjYDY1Jjc3iP/uKU7k+sId4YpEIm/
         2TwxrM14wp5onsOVwjWYoDdgFYh0M/q47lpj1/hM6i/an0w5uZFrvb9gl9m09ml5b1Gk
         FIvg==
X-Gm-Message-State: APjAAAUhq0sTiO2JjGyprve5tKtRcsP6jYydSfl0MB5iJpI2IXlMSOKj
        3WqivjrCMJcbx49tl4F8kWv4izLOrH0=
X-Google-Smtp-Source: APXvYqzvzqwrVAHyAIjhxckQKiGx6EWsWEJvvwhlTT75Z8qRS29+ThIXEngOEnsLqL3/6Fpo0+3v9g==
X-Received: by 2002:a37:9185:: with SMTP id t127mr88303570qkd.482.1564697984434;
        Thu, 01 Aug 2019 15:19:44 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c5sm44386466qta.5.2019.08.01.15.19.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:19:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/5] btrfs: factor out the ticket flush handling
Date:   Thu,  1 Aug 2019 18:19:35 -0400
Message-Id: <20190801221937.22742-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801221937.22742-1-josef@toxicpanda.com>
References: <20190801221937.22742-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're going to make this logic a little more complicated for evict, so
factor the ticket flushing/waiting code out of __reserve_metadata_bytes.
This has no functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 64 ++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ce7ae1cd1153..71749b355136 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -923,6 +923,47 @@ static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 	spin_unlock(&space_info->lock);
 }
 
+/**
+ * handle_reserve_ticket - do the appropriate flushing and waiting for a ticket
+ * @fs_info - the fs_info for the fs.
+ * @space_info - the space_info for the reservation.
+ * @ticket - the ticket for the reservation.
+ * @flush - how much we can flush.
+ *
+ * This does the work of figuring out how to flush for the ticket, waiting for
+ * the reservation, and returning the appropriate error if there is one.
+ */
+static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
+				 struct btrfs_space_info *space_info,
+				 struct reserve_ticket *ticket,
+				 enum btrfs_reserve_flush_enum flush)
+{
+	u64 reclaim_bytes = 0;
+	int ret;
+
+	if (flush == BTRFS_RESERVE_FLUSH_ALL)
+		wait_reserve_ticket(fs_info, space_info, ticket);
+	else
+		priority_reclaim_metadata_space(fs_info, space_info, ticket);
+
+	spin_lock(&space_info->lock);
+	ret = ticket->error;
+	if (ticket->bytes || ticket->error) {
+		if (ticket->bytes < ticket->orig_bytes)
+			reclaim_bytes = ticket->orig_bytes - ticket->bytes;
+		list_del_init(&ticket->list);
+		if (!ret)
+			ret = -ENOSPC;
+	}
+	spin_unlock(&space_info->lock);
+
+	if (reclaim_bytes)
+		btrfs_space_info_add_old_bytes(fs_info, space_info,
+					       reclaim_bytes);
+	ASSERT(list_empty(&ticket->list));
+	return ret;
+}
+
 /**
  * reserve_metadata_bytes - try to reserve bytes from the block_rsv's space
  * @root - the root we're allocating for
@@ -945,7 +986,6 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 {
 	struct reserve_ticket ticket;
 	u64 used;
-	u64 reclaim_bytes = 0;
 	int ret = 0;
 
 	ASSERT(orig_bytes);
@@ -1017,27 +1057,7 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	if (!ret || flush == BTRFS_RESERVE_NO_FLUSH)
 		return ret;
 
-	if (flush == BTRFS_RESERVE_FLUSH_ALL)
-		wait_reserve_ticket(fs_info, space_info, &ticket);
-	else
-		priority_reclaim_metadata_space(fs_info, space_info, &ticket);
-
-	spin_lock(&space_info->lock);
-	ret = ticket.error;
-	if (ticket.bytes || ticket.error) {
-		if (ticket.bytes < orig_bytes)
-			reclaim_bytes = orig_bytes - ticket.bytes;
-		list_del_init(&ticket.list);
-		if (!ret)
-			ret = -ENOSPC;
-	}
-	spin_unlock(&space_info->lock);
-
-	if (reclaim_bytes)
-		btrfs_space_info_add_old_bytes(fs_info, space_info,
-					       reclaim_bytes);
-	ASSERT(list_empty(&ticket.list));
-	return ret;
+	return handle_reserve_ticket(fs_info, space_info, &ticket, flush);
 }
 
 /**
-- 
2.21.0

