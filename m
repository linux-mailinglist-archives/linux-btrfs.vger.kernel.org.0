Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53374151E2D
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgBDQUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:25 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35190 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbgBDQUZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:25 -0500
Received: by mail-qk1-f194.google.com with SMTP id q15so18539980qki.2
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g1mvZ2GvrKyYA6Wty/CVUu9u8I0lfJTo7RWi/hcMV0k=;
        b=cYVIMJax/dwUfFEtLEkEAAYOlDpaDbz2Z/hIreXqj14ZgdH6tGjdKzEoryWC3Svj90
         6ebaz1mvVdnAJOUb7YhxtRA2QXSVt0eWskUE+xpvLc8EmcUMAS0/qxeH59DG4vF8Gtvr
         8fxg2oJcsaDs8HSEbTE9HeydnetxYl8IHuJ/PTzpO1VNztWt9pRwZw5eboOb24tBkEHs
         oesou1oYVgQn1rvuh3XLaq6dCf9qMtxcTpGa5Zky8f2hznM2OQFHzhVOYSGnEe+PKIKG
         NXKBy9eSYRS60bPKfE3r9Ew888DYYSYMQ3FT+RqBWPN9FaXsci6wDXZEm03H81ZmwJnn
         BbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g1mvZ2GvrKyYA6Wty/CVUu9u8I0lfJTo7RWi/hcMV0k=;
        b=RO9/2rHCDXmOyisXx5goZVuHtUM+htnYhT8crsyMIG9F95+H2kWSMNF3AGOMl2Ke2O
         o/rQ6NvXFSNVGKO4W0d7KJrXFJIUktbBN252lkv/DTdqRH6qoa1jc7ozK29KrcSx13y1
         vW77/SM3Q60VjQeNWGYt3YSUDxU2trdGwwgfNW1lBDdDwStVpgHAXInX9myLZYxW8n2z
         K/hlhpk0Kagvw63t18pPDQ89XWqjwmEfk68bersbp3pGNSf6UJom5rZisWRP2yhNiXec
         Ab62tqogQkAwj03xUiHOSl9Vh/b7PRkuCPRgYtEZvmEdfoUgTLNgMyc8i2JEZdGsZnxr
         yWtw==
X-Gm-Message-State: APjAAAXdjol4HNLHJLiNKmsp9w4oYEaldoKI+KdJyqGOB9DvXsGqH95A
        XscGOObFNvpz7w3gUuotm69Rb95v7YNL9A==
X-Google-Smtp-Source: APXvYqzdJouCYzOzZ9UffqAVp87mtiUGgI84bGSNVZxOzLBLCbunQiR0YDfWIczkmL5/YeJUu3Q9ww==
X-Received: by 2002:a05:620a:12c8:: with SMTP id e8mr28984135qkl.380.1580833222330;
        Tue, 04 Feb 2020 08:20:22 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 69sm11265006qkk.106.2020.02.04.08.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:20:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 17/23] btrfs: use the same helper for data and metadata reservations
Date:   Tue,  4 Feb 2020 11:19:45 -0500
Message-Id: <20200204161951.764935-18-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
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
Tested-by: Nikolay Borisov <nborisov@suse.com>
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

