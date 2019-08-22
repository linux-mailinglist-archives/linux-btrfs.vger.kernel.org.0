Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 890A299FBB
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733308AbfHVTTQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:19:16 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35770 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731916AbfHVTTP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:19:15 -0400
Received: by mail-yw1-f66.google.com with SMTP id g19so2865940ywe.2
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JCeHqJn5hWvaulbgtXjkznoD3Mwz4/wqiCtYVGAepqY=;
        b=RqBjyseQ5T84wAZ2DjZPXraqeIYlpFmR0NBlno5XEgLxD2D/5fFe7GY+dgnR1VLiQN
         VG565eF1QWxQ2f2zmVgfWAO/YUtgaaQU+qegO5p80mZMJ63AWEHoJBPSyFQeJ7TeKmkN
         XgcZ98tnI97PylD0B6z4+0DgDp6adIeU1uMslp1FRssFQdmp/H8qPCBkX8gt9p7OZwcX
         xFoCqmjBihjCyCyAuZbzn/psFwwm2auAMcbPZ4+pJ3lriM99Vt/K0WL2PbxpkgmUx6M8
         lg4sCD9dvjLWs45ES8dcaZqoQrD1RcKlTASt6qYZdINQPVDY1qLz1P1WHvJyCxzyP83d
         5BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JCeHqJn5hWvaulbgtXjkznoD3Mwz4/wqiCtYVGAepqY=;
        b=akuMdLRIAtLO0AOI68gVWsA+cHJq9BvSDvh0tu3xPngMqssbQTLAiFSb07H/0qbvEv
         DglUaphAL/tZx+j78t8a6ByAzpLlc5LqDw68gL77s2ROEaRn6jnioH+BVJEzp62IpGkx
         TT4uH68LAoLWZI6q1D1T0C99OuGGDmD9/nrUshGmFKOz9/uV/WXu13dyPT67oFfG5Gs3
         5OVLmrpcnCwVN/KMIEPRDnLrG3GTKZQCkKWJrf89nOfqXKtlyvEXywDAHg0Im29kjzq/
         kdiQph2iHeXrOumuHVPXC36exRVL+ap9BS8CwRDqYbtI6+8ViSFRlFkBw8MfU5AunpwC
         FTxA==
X-Gm-Message-State: APjAAAW6PfuXtfmq5nQJ1kOk4KgGgMqM/HzpALsAXaQ/iDjLdCYKAASd
        R//KXUZYwUva3rJxdSqwMT6dsg==
X-Google-Smtp-Source: APXvYqwsg83PICBhpSErb+tOCAbi5H307mm9NqnRLAcMYsg9r99XQp1FLrWZmIb9dXVDFwM7+FfkBA==
X-Received: by 2002:a81:9945:: with SMTP id q66mr718953ywg.47.1566501554988;
        Thu, 22 Aug 2019 12:19:14 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b202sm125748ywb.78.2019.08.22.12.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:19:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 5/5] btrfs: add enospc debug messages for ticket failure
Date:   Thu, 22 Aug 2019 15:19:04 -0400
Message-Id: <20190822191904.13939-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191904.13939-1-josef@toxicpanda.com>
References: <20190822191904.13939-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When debugging weird enospc problems it's handy to be able to dump the
space info when we wake up all tickets, and see what the ticket values
are.  This helped me figure out cases where we were enospc'ing when we
shouldn't have been.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/space-info.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3053b3e91b34..54d0f34682d8 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -258,14 +258,11 @@ do {									\
 	spin_unlock(&__rsv->lock);					\
 } while (0)
 
-void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
-			   struct btrfs_space_info *info, u64 bytes,
-			   int dump_block_groups)
+static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
+				    struct btrfs_space_info *info)
 {
-	struct btrfs_block_group_cache *cache;
-	int index = 0;
+	lockdep_assert_held(&info->lock);
 
-	spin_lock(&info->lock);
 	btrfs_info(fs_info, "space_info %llu has %llu free, is %sfull",
 		   info->flags,
 		   info->total_bytes - btrfs_space_info_used(info, true),
@@ -275,7 +272,6 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 		info->total_bytes, info->bytes_used, info->bytes_pinned,
 		info->bytes_reserved, info->bytes_may_use,
 		info->bytes_readonly);
-	spin_unlock(&info->lock);
 
 	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
 	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
@@ -283,6 +279,19 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv);
 	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv);
 
+}
+
+void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
+			   struct btrfs_space_info *info, u64 bytes,
+			   int dump_block_groups)
+{
+	struct btrfs_block_group_cache *cache;
+	int index = 0;
+
+	spin_lock(&info->lock);
+	__btrfs_dump_space_info(fs_info, info);
+	spin_unlock(&info->lock);
+
 	if (!dump_block_groups)
 		return;
 
@@ -681,6 +690,11 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 	u64 tickets_id = space_info->tickets_id;
 	u64 first_ticket_bytes = 0;
 
+	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
+		btrfs_info(fs_info, "cannot satisfy tickets, dumping space info");
+		__btrfs_dump_space_info(fs_info, space_info);
+	}
+
 	while (!list_empty(&space_info->tickets) &&
 	       tickets_id == space_info->tickets_id) {
 		ticket = list_first_entry(&space_info->tickets,
@@ -701,6 +715,10 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 		else if (first_ticket_bytes > ticket->bytes)
 			return true;
 
+		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
+			btrfs_info(fs_info, "failing ticket with %llu bytes",
+				   ticket->bytes);
+
 		list_del_init(&ticket->list);
 		ticket->error = -ENOSPC;
 		wake_up(&ticket->wait);
-- 
2.21.0

