Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F05715115D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgBCUu2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:28 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34251 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgBCUu2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:28 -0500
Received: by mail-qk1-f195.google.com with SMTP id g3so7101563qka.1
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UCKwbA1DFbxJ1Jc5tBULr5K2ntsdL8gyXZF5no1yEHA=;
        b=jUdDPvK+9b1HDd4QRhcmOsWyhGBVPzVo5AATXYQcSu1hyhgvAdDZLuLSO2Kp3Ftq0k
         eqslyJ0wDuiKH1JIgThGRIWkgSCoFkV6N8w1oq4VnoOi9sv9pGi9PcX5sv4YvkQMnDBh
         VVVLcgxY7BipmeyEj2z3wAK5y0hF1iP/rMJuFhRHIzimbGSVv5yBLxsnCDvpCW/Bc4wH
         n6JhHw9wr7V+6euBClDcnPtbhFs5pmpFg9A1lV5P48rI3/BbLK/GQQa0A9YWtatp2Wsn
         5K6cY2IaBxzaVdQOQgQBff9bi0bU941oX4Wl62AdqmmqRswPUvKxI0GOExNfnROGPUnp
         GfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCKwbA1DFbxJ1Jc5tBULr5K2ntsdL8gyXZF5no1yEHA=;
        b=WLiThvMqOYFw+/8b4Jrfy1ePuQbfcJqXDdDI1Dc9JzMA99V9HgWJCaYfyDRaixyLxN
         b/kaj6WQoGaNVqY6VVWSVRNweQdP7PpNuosbiwQKFG2Fa/MV7VMAYRyDK5Ry1izuLzUZ
         FV9V4NVrRoNS6CmpgrpfKloE8LI56VU9g+qFMWDN3Uo1NjeDv6u8EGn9kelz02FQn/MK
         JJy58WdTEPGqcpi67UTHziPIBuEn8q1eq3HGHpwIMIaqSF+hk4GKQuzu6J+M3Zamx5RG
         0SP5BIIfFcO73T41TujYFjnaPXni3/2wEktEa0U5gjGGp9xfsdh1ZJRPeJ0Lp7RgIiUa
         X2jw==
X-Gm-Message-State: APjAAAULbfpX4pAG9kF/w1tMqPhnNT+IMafjPNYvDQOxIT8C2c4uUIWc
        jaWnsRB6KZfvIgcAGQaIdfZH9+2wBxWZ9Q==
X-Google-Smtp-Source: APXvYqw5V1D9xuqyC2skrEpP39vbf1AhMWE/OJtR/3umwBvsWdfLH+3rh6IziF7ldNgxJv2Jij8RKA==
X-Received: by 2002:a37:5805:: with SMTP id m5mr9477570qkb.450.1580763025355;
        Mon, 03 Feb 2020 12:50:25 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e64sm10569974qtd.45.2020.02.03.12.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 19/24] btrfs: don't pass bytes_needed to may_commit_transaction
Date:   Mon,  3 Feb 2020 15:49:46 -0500
Message-Id: <20200203204951.517751-20-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was put into place in order to mirror the way data flushing handled
committing the transaction.  Now that we do not loop on committing the
transaction simply force a transaction commit if we are data.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 8c5543328ec4..d20c338f2780 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -412,14 +412,14 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
  * will return -ENOSPC.
  */
 static int may_commit_transaction(struct btrfs_fs_info *fs_info,
-				  struct btrfs_space_info *space_info,
-				  u64 bytes_needed)
+				  struct btrfs_space_info *space_info)
 {
 	struct reserve_ticket *ticket = NULL;
 	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_block_rsv;
 	struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
 	struct btrfs_trans_handle *trans;
 	u64 reclaim_bytes = 0;
+	u64 bytes_needed;
 	u64 cur_free_bytes = 0;
 	bool do_commit = false;
 
@@ -428,12 +428,10 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 		return -EAGAIN;
 
 	/*
-	 * If we are data and have passed in U64_MAX we just want to
-	 * unconditionally commit the transaction to match the previous data
-	 * flushing behavior.
+	 * If we are data just force the commit, we aren't likely to do this
+	 * over and over again.
 	 */
-	if ((space_info->flags & BTRFS_BLOCK_GROUP_DATA) &&
-	   bytes_needed == U64_MAX) {
+	if (space_info->flags & BTRFS_BLOCK_GROUP_DATA) {
 		do_commit = true;
 		goto check_pinned;
 	}
@@ -451,7 +449,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	else if (!list_empty(&space_info->tickets))
 		ticket = list_first_entry(&space_info->tickets,
 					  struct reserve_ticket, list);
-	bytes_needed = (ticket) ? ticket->bytes : bytes_needed;
+	bytes_needed = (ticket) ? ticket->bytes : 0;
 
 	if (bytes_needed > cur_free_bytes)
 		bytes_needed -= cur_free_bytes;
@@ -584,7 +582,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		btrfs_wait_on_delayed_iputs(fs_info);
 		break;
 	case COMMIT_TRANS:
-		ret = may_commit_transaction(fs_info, space_info, num_bytes);
+		ret = may_commit_transaction(fs_info, space_info);
 		break;
 	default:
 		ret = -ENOSPC;
-- 
2.24.1

