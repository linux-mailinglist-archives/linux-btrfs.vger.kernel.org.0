Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6460114F4DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgAaWgs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:48 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33955 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAaWgr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:47 -0500
Received: by mail-qt1-f196.google.com with SMTP id h12so6746300qtu.1
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uIXnSRIo56eU+s2OzaeIRmu/GBcbXO8fptF5VEIM4I0=;
        b=FuFPgpFGLQX4ynFuyJ+fK7/Aohq3iHmZH0+5ASFRw4CqlIba3jXyYb/K+tKW19Aa60
         kZPiaVXkP/W1oZMhI4UAyaslcaCCdmnT5DkAjRclryDqNEMLqdHFkoxWhGRmKWBoA/aq
         49xvycL/A8RBsEJ9ouoTsITWDx+jIgOUrZe7T0n75YtPGuN7XCwMm9QcKNLxjd6Fk+07
         N9RCXYtB+U8+WHg8BHA6vTi+jwVxOdguSOkRPlNafIioNvfzPlRwillHB04EVEuFW4Or
         ZMFIQ4dNir8xAu58y+RKYcApmPgi1h8b9GmawH1IBQ7w/t/4qMCtQ4asnucsLxQrMabv
         Wrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIXnSRIo56eU+s2OzaeIRmu/GBcbXO8fptF5VEIM4I0=;
        b=RkSvLvVxMuTrn3jpp5do7n69Cc/392su4rEEDuG1qzyTBVuA253xuuZyX8oiginHyL
         rh1k7BqRuZXmlSp24tZfXkp+ru1wVF8njvMRa+E7ZAsaDllk4dW3VPYwjnT5rPbCURFj
         II5rQ43S/aXX13VF3+Mh+rjlDbnm97VPiqKAUNx+cK7JfmUDATf0ijgkuSVAouPqfhd1
         jOMTIR2CHGNOq4iisS2iCl7UJr487euoGPpDKX/8IaLNX8cdldDjcWlnUL7iO7nh36Ka
         rXy05B/W5JtMjRrBnaTemkDb7eLib0/mq+6zyzcWKuwvh2X6HqKFCqt52WasrWhEzvcS
         eDRA==
X-Gm-Message-State: APjAAAV+7eHBnw6N4kaDUho8uU9Xri3RjzNDE+j2zQ4WCmzO5qfCcI8k
        qfhRuyp/EAQGSREJpOOGbhJ3Omj2MHTbug==
X-Google-Smtp-Source: APXvYqy66JWY79v6syRY0RwHl2iun1rSQsGTYz1v6sbnCxs4wA09QNwDQaZ0tLkrjGBEbDzHXk3Qog==
X-Received: by 2002:ac8:6f73:: with SMTP id u19mr12986458qtv.102.1580510205952;
        Fri, 31 Jan 2020 14:36:45 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 69sm5198054qkk.106.2020.01.31.14.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/23] btrfs: use the same helper for data and metadata reservations
Date:   Fri, 31 Jan 2020 17:36:07 -0500
Message-Id: <20200131223613.490779-18-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
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
 fs/btrfs/space-info.c | 48 +++++++++++++------------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 97379524bac8..13a3692a0122 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1016,10 +1016,9 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
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
@@ -1119,8 +1118,8 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	int ret;
 
-	ret = __reserve_metadata_bytes(fs_info, block_rsv->space_info,
-				       orig_bytes, flush);
+	ret = __reserve_bytes(fs_info, block_rsv->space_info, orig_bytes,
+			      flush);
 	if (ret == -ENOSPC &&
 	    unlikely(root->orphan_cleanup_state == ORPHAN_CLEANUP_STARTED)) {
 		if (block_rsv != global_rsv &&
@@ -1152,37 +1151,18 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
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

