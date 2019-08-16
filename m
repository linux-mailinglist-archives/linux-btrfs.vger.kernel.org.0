Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D89AB9048F
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 17:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfHPPUc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 11:20:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37095 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfHPPUb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 11:20:31 -0400
Received: by mail-qk1-f195.google.com with SMTP id s14so5062319qkm.4
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ldgz5KIxke3jzqUaPc7l5V8q7twuRCp8/4jzuyZ5FYo=;
        b=D2BMpZR2k3DYlO/2B6h2ahZg3iBwhrgMlUcMD4aOw1Pmea+DKOZ0ZYWoj+vcau/z05
         pR+2R8rB6tNhSccmvUDYmNIccV0OIS1Ug3EStMLYo7UQjbeiUoVb5boaoCwWL+rm016a
         kTRDb/MAR9NdiyBNQ8ePJ3MtZteE4M7wT3q9ESyT4MJFVSHDovESrkBCjlxL18QOumKK
         HSlO1DpUKMjK9NdcF1v8ESwHRlHM9zjP8f2bt/xUMgQLnLQ8EDVrztcmEWCp6Pl9CKPD
         w8lXGEn+epyYzUC6A+UWOPh4HHLUEw04y42AH9dBDDLA0oBk5PXZEdNBlFxHKepcrXVh
         eZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldgz5KIxke3jzqUaPc7l5V8q7twuRCp8/4jzuyZ5FYo=;
        b=Gb8s+qlOgJ5CoUG3BcMrXPbKVIImOxWB04IYOrFqyVGB3T2jYiaUKRfjYmBfkFi90y
         fDcUrtHnRd99j7mQ055+veHe5L0qj7KSihgoWqTU+NLiid0v7DASFlMJFbdVCsWJWJPg
         6AYJ4bkrRjUgVsF7HGYUSDDyWgoYepXyOq/HC7L+UvAfZ8/NJ7PVhlkJW+ZARcrwnxSS
         ydw9kyhER/BuScObQ1U1VArQMlNg/MsGS2M/E2I3c1vQG0bY0TwyVuxTArUhh2TmRA5g
         BgJ9jiMv8F6CFmvubJGimrRDoQ69aGATEFXX80WjHQbFUtRv47d0Y5PZzmCWw0EfbSJs
         qiiQ==
X-Gm-Message-State: APjAAAWCl4+eG2u3SktjVsH4DNds0OTBgtNxbNUNi4Ljh4U3WOiOiaKe
        xYpHu8BBqO3yu27aWHy4qxTiNfc7l0akOQ==
X-Google-Smtp-Source: APXvYqz6wfExQmzZo/FtcLgcZdIU+TU9Enw53CxbQqXm2rHY5SbVBYUBH6CZ5VvZqKWn5/ELx6Pc9A==
X-Received: by 2002:a37:717:: with SMTP id 23mr9152401qkh.267.1565968830629;
        Fri, 16 Aug 2019 08:20:30 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w10sm2969643qts.37.2019.08.16.08.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 08:20:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/5] btrfs: add enospc debug messages for ticket failure
Date:   Fri, 16 Aug 2019 11:20:19 -0400
Message-Id: <20190816152019.1962-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816152019.1962-1-josef@toxicpanda.com>
References: <20190816152019.1962-1-josef@toxicpanda.com>
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
---
 fs/btrfs/space-info.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3d3f301bae26..2819fa91c4f0 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -256,14 +256,9 @@ do {									\
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
-
-	spin_lock(&info->lock);
 	btrfs_info(fs_info, "space_info %llu has %llu free, is %sfull",
 		   info->flags,
 		   info->total_bytes - btrfs_space_info_used(info, true),
@@ -273,7 +268,6 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 		info->total_bytes, info->bytes_used, info->bytes_pinned,
 		info->bytes_reserved, info->bytes_may_use,
 		info->bytes_readonly);
-	spin_unlock(&info->lock);
 
 	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
 	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
@@ -281,6 +275,19 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
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
 
@@ -685,6 +692,11 @@ static bool wake_all_tickets(struct btrfs_fs_info *fs_info,
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
@@ -705,6 +717,10 @@ static bool wake_all_tickets(struct btrfs_fs_info *fs_info,
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

