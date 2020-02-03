Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE31315115A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgBCUuX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:23 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39052 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgBCUuX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:23 -0500
Received: by mail-qk1-f195.google.com with SMTP id w15so15679985qkf.6
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZe2kP455/ATqac4Vhhr79go7HfXorhPo150Xj/AiO0=;
        b=g5Kd+XnR+KrT7+wlvea8Vn8V88q1fm/lEjREdmo2d1UOEhJgMB1TjBUk11ghJniSKN
         ++FhNyoAy3h3yBcAtbM0OhghYTrb3q9WaPdYVC3XeNJ36yL2VM+VXh46Hg5GtG3fg9rl
         5HZ+Uj7O06bmkf0x1UYNKPktUsS9BcTjPoPEP/8MSYQc/JQSLkrRl257E2nU+OpMw8dm
         feLY3mWuitvt7ErtV1rojkUlLeVnXJNE+hSBbTH+YM5qmD6jByiUvvSvsKMAumuFcXVu
         e8Cekznku96UGRkVc84w0QnntNB7gcEY4QOQyHfRmaN8tBBK4rT+jyCdmq3ly+ymi2eN
         qg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZe2kP455/ATqac4Vhhr79go7HfXorhPo150Xj/AiO0=;
        b=sLHQoxLS98LDDQk1ejgwqRFP6+sEU1kUX4gvxvuXad+LfWmjcsCaahsRAvr5lIwA7k
         MMDH8DS7MkxrQPEGeQGkQwIWiTQb0ZBuYSXVkQiKzNh1lD5fc4t54gia+GO5UvsA7C3F
         KbHFNMDl086ftL1mzQRbuaR8t+YODPI8rjMZe9k0x/06E1sRvp3AbkD95XDyI8LuE9E3
         MXd2NBt0wbW3YHNaVgZc0jdqs6i7hupwJt2u+KYukQt3aFW3LfcKnOUcXMju6JWQwFsJ
         zuEw+zdKDveUC3fmqq+TaKGyXI7DG0eoTWk/3L2OyMaOjLJ0QSUAZcc2I/4Zdgsh9Wbd
         qkJA==
X-Gm-Message-State: APjAAAUwihVbhS0t9Y3h2vmnOfsAe+ROb65uov0stsy0Tz/J0BF36u72
        z4MruBREMes770n44S3kxMKLoyNNcVneEQ==
X-Google-Smtp-Source: APXvYqz5EFhjqeFIDZ/lQC7eIS/2/0fp7UfpvS33tB+E52PxXiXfisqMOqUPz+OZGFOARXLQTOndVw==
X-Received: by 2002:a37:354:: with SMTP id 81mr25589943qkd.276.1580763022249;
        Mon, 03 Feb 2020 12:50:22 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c18sm9887841qkk.5.2020.02.03.12.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 17/24] btrfs: use the same helper for data and metadata reservations
Date:   Mon,  3 Feb 2020 15:49:44 -0500
Message-Id: <20200203204951.517751-18-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that data reservations follow the same pattern as metadata
reservations we can simply rename __reserve_metadata_bytes to
__reserve_bytes and use that helper for data reservations.

Things to keep in mind, btrfs_can_overcommit() returns 0 for data,
because we can never overcommit.  We also will never pass in FLUSH_ALL
for data, so we'll simply be added to the priority list and go straight
into handle_reserve_ticket.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 48 +++++++++++++------------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 5ee4c6a318aa..225f7f8a0503 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1017,10 +1017,9 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
  * regain reservations will be made and this will fail if there is not enough
  * space already.
  */
-static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info,
-				    u64 orig_bytes,
-				    enum btrfs_reserve_flush_enum flush)
+static int __reserve_bytes(struct btrfs_fs_info *fs_info,
+			   struct btrfs_space_info *space_info, u64 orig_bytes,
+			   enum btrfs_reserve_flush_enum flush)
 {
 	struct reserve_ticket ticket;
 	u64 used;
@@ -1120,8 +1119,8 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	int ret;
 
-	ret = __reserve_metadata_bytes(fs_info, block_rsv->space_info,
-				       orig_bytes, flush);
+	ret = __reserve_bytes(fs_info, block_rsv->space_info, orig_bytes,
+			      flush);
 	if (ret == -ENOSPC &&
 	    unlikely(root->orphan_cleanup_state == ORPHAN_CLEANUP_STARTED)) {
 		if (block_rsv != global_rsv &&
@@ -1153,37 +1152,18 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 			     enum btrfs_reserve_flush_enum flush)
 {
 	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
-	u64 used;
-	int ret = -ENOSPC;
-	bool pending_tickets;
+	int ret;
 
+	ASSERT(flush == BTRFS_RESERVE_FLUSH_DATA ||
+	       flush == BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE);
 	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_DATA);
 
-	spin_lock(&data_sinfo->lock);
-	used = btrfs_space_info_used(data_sinfo, true);
-	pending_tickets = !list_empty(&data_sinfo->tickets) ||
-		!list_empty(&data_sinfo->priority_tickets);
-
-	if (pending_tickets ||
-	    used + bytes > data_sinfo->total_bytes) {
-		struct reserve_ticket ticket;
-
-		init_waitqueue_head(&ticket.wait);
-		ticket.bytes = bytes;
-		ticket.error = 0;
-		list_add_tail(&ticket.list, &data_sinfo->priority_tickets);
-		spin_unlock(&data_sinfo->lock);
-
-		ret = handle_reserve_ticket(fs_info, data_sinfo, &ticket,
-					    flush);
-	} else {
-		btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, bytes);
-		ret = 0;
-		spin_unlock(&data_sinfo->lock);
-	}
-	if (ret)
-		trace_btrfs_space_reservation(fs_info,
-					      "space_info:enospc",
+	ret = __reserve_bytes(fs_info, data_sinfo, bytes, flush);
+	if (ret == -ENOSPC) {
+		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
 					      data_sinfo->flags, bytes, 1);
+		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
+			btrfs_dump_space_info(fs_info, data_sinfo, bytes, 0);
+	}
 	return ret;
 }
-- 
2.24.1

