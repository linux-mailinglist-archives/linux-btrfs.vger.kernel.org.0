Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC4F14D40E
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgA2XvA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:51:00 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34411 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgA2XvA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:51:00 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so633430qvf.1
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=N4sITncSg1QJua1/izpFWTmBE+xXPLntDYngJgd9OMM=;
        b=p0Wb483lidvhKPyXGNV9GkSQqxJLJKay3x65z8QeVG81hTZ4UnUlKFz1+tndhk4say
         IUvVL5qHUqguHEofbL3h0qdid1v1CPhlpP/fy/1eoCuVN2kQWNkvVOeIuKPbsG1i4pKN
         oMYEKgByhpgAlN9E2VqczQQG58r1K2bjHLl0z4dn/FPV5/vJlNE2FfduSoc1y8pIGdJT
         6f58ER2iapODNf1M937kil84fRGGZ3czgGgaLsDefJ0p3Fo7P+JCEDvudkAWDjOLlClb
         IRjBbRWe5n4Fb6Ic7C81ePjWiNuoJeg72ccMDP9QcIufobFyV3LBZoIv+I4BAUUFpXrN
         59TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4sITncSg1QJua1/izpFWTmBE+xXPLntDYngJgd9OMM=;
        b=as03EK6PWhlDHsBkezsFtNThkp6xbo/aj4bKDSmQelCfQZumNpjmG2bu4js8mxrE8J
         KWJLTthrxMNIu/f/EPIotSnkFyoK5JtpYJa4Qeq3TyTWRn0ra1an++g4CfoLYZx+32FU
         Je1Ez9yll3LAzAtJsDKe9lWhtxVXtYWxj2xivwS1Hj7N8JT24oOz3ZCszOGgdoKIj/y7
         +XuqRx+1lQoqM7jWCy9CmNO9gWW447/0HpfrJsmKqZ7nwVsGZeZv1V45MvmpGxKoyhX2
         78LFiV0FXk7MFZbvGM2z+jNB8iQ4K63sda8I4Jid57FgvSno4UfJGbKl+ivF+qDvAThi
         VAng==
X-Gm-Message-State: APjAAAVBmBp5BXVrG3VU1ZLV6swWIBy2eU8SL2910BuOJAs/MNDtAUjg
        wRnZOXBA/rdPSTyv67EWeK6LZvFMpgBQDg==
X-Google-Smtp-Source: APXvYqyxljXo8MJx4kPj0lzdce96gbKfnnJ6caH/kZ08YRBbW66+Mp/LRCsa75Nqfmusx53zZQPo6A==
X-Received: by 2002:a0c:bd2c:: with SMTP id m44mr1785059qvg.248.1580341857325;
        Wed, 29 Jan 2020 15:50:57 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p19sm1840960qkm.69.2020.01.29.15.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/20] btrfs: use the same helper for data and metadata reservations
Date:   Wed, 29 Jan 2020 18:50:22 -0500
Message-Id: <20200129235024.24774-19-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that data reservations follow the same pattern as metadata
reservations we can simply rename __reserve_metadata_bytes to
__reserve_bytes and use that helper for data reservations.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 49 +++++++++++++------------------------------
 1 file changed, 14 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a456139c698d..bbdf20253180 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1050,10 +1050,9 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
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
@@ -1153,8 +1152,8 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	int ret;
 
-	ret = __reserve_metadata_bytes(fs_info, block_rsv->space_info,
-				       orig_bytes, flush);
+	ret = __reserve_bytes(fs_info, block_rsv->space_info, orig_bytes,
+			      flush);
 	if (ret == -ENOSPC &&
 	    unlikely(root->orphan_cleanup_state == ORPHAN_CLEANUP_STARTED)) {
 		if (block_rsv != global_rsv &&
@@ -1186,38 +1185,18 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
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
-		btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo,
-						      bytes);
-		ret = 0;
-	}
-	spin_unlock(&data_sinfo->lock);
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

