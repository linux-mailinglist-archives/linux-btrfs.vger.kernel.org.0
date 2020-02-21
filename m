Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2614916896E
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 22:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBUVlP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 16:41:15 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:37229 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgBUVlO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 16:41:14 -0500
Received: by mail-qv1-f66.google.com with SMTP id ci20so292720qvb.4
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2020 13:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DGrn23qLl2XKdbhFDsLDQYXeTHJHhrtCAi16aPkbn/I=;
        b=OWCspPB40Ku1E2NHRtLehL35gRSEBqmjoHX0nh90C8Cz1xdZNqAgCmXGxjZY7NMqgH
         Rsx4yfYunjS6glfcDVdEHJLNbJIJNZuhp2PwDGTJ7Xpu+9Z830xGl8AVYGt4JUJuwrub
         d6Mv1h6Z5NHUP/9JIwuglxck+q1O01GR00BFdrIyaKHrFDDjqRoMTB2IACPp0aRa1IhQ
         sclu7Wg/bR8mcNReBbJs1TNH91eQWfNPp+K0LkHFBQmxXluxnaWL57ffoFpoxu0cldqK
         tmpUngIykMWLDIM7A/U8bQA+D7W+PAzLT1UN6bA6j4rxxDTR58/eIMGoi5qDG6eIDIBZ
         jN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DGrn23qLl2XKdbhFDsLDQYXeTHJHhrtCAi16aPkbn/I=;
        b=M1P/QJ6MrUWFXXBgfu6InB843gysoNtmVFB49dMSCXYRuPkY17T34K3N3Kgb/aq1sU
         V3z/3yqx+nCp1IppBwcZapG9QCI5VH6NyQBKrVTKqgQ78zuZD9/4FNd0/RzanpcLvzEv
         XdlDirpLY3V85601b1tBElqgmZHVrZWaQjlJfatfT3/oOnz0E2FnFWtOJG5ZxCiw4VVq
         PQ0G5/hZf7deT8vAvyu5K/b9u8Ohg3yGjk/lAWF4e9rbwpbNIGTdjEtXc6+G28h4NEd2
         lr1XUcgMWh2H3yP7pouEBdAmRTHKXLUBfdBYhFhExY1dedyu6eQJkRIjf02f0qZPh40H
         yn9A==
X-Gm-Message-State: APjAAAVNt9VuEuT01N4vubkNz0RXQN6ezjAKKPjzkEMyr2VCYQADZ5Dx
        zualQ0FHSb+j/4oFtiKo4heFx+0mOr8=
X-Google-Smtp-Source: APXvYqyK4U6ac5UynHu3zH9pU4POyayWUn6VziqDwUt7yig89ptyLE8S4oumc2KjB27h3pxBBOJdwA==
X-Received: by 2002:a0c:eed2:: with SMTP id h18mr32599865qvs.184.1582321273059;
        Fri, 21 Feb 2020 13:41:13 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c10sm2154753qkb.4.2020.02.21.13.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 13:41:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fix btrfs_calc_reclaim_metadata_size calculation
Date:   Fri, 21 Feb 2020 16:41:10 -0500
Message-Id: <20200221214110.3958008-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I noticed while running my snapshot torture test that we were getting a
lot of metadata chunks allocated with very little actually used.
Digging into this we would commit the transaction, still not have enough
space, and then force a chunk allocation.

I noticed that we were barely flushing any delalloc at all, despite the
fact that we had around 13gib of outstanding delalloc reservations.  It
turns out this is because of our btrfs_calc_reclaim_metadata_size()
calculation.  It _only_ takes into account the outstanding ticket sizes,
which isn't the whole story.  In this particular workload we're slowly
filling up the disk, which means our overcommit space will suddenly
become a lot less, and our outstanding reservations will be well more
than what we can handle.  However we are only flushing based on our
ticket size, which is much less than we need to actually reclaim.

So fix btrfs_calc_reclaim_metadata_size() to take into account the
overage in the case that we've gotten less available space suddenly.
This makes it so we attempt to reclaim a lot more delalloc space, which
allows us to make our reservations and we no longer are allocating a
bunch of needless metadata chunks.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 44 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f216ab72f5fc..26e1c492b9b5 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -306,25 +306,20 @@ static inline u64 calc_global_rsv_need_space(struct btrfs_block_rsv *global)
 	return (global->size << 1);
 }
 
-int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
-			 struct btrfs_space_info *space_info, u64 bytes,
-			 enum btrfs_reserve_flush_enum flush)
+static inline u64
+calc_available_free_space(struct btrfs_fs_info *fs_info,
+			  struct btrfs_space_info *space_info,
+			  enum btrfs_reserve_flush_enum flush)
 {
 	u64 profile;
 	u64 avail;
-	u64 used;
 	int factor;
 
-	/* Don't overcommit when in mixed mode. */
-	if (space_info->flags & BTRFS_BLOCK_GROUP_DATA)
-		return 0;
-
 	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
 		profile = btrfs_system_alloc_profile(fs_info);
 	else
 		profile = btrfs_metadata_alloc_profile(fs_info);
 
-	used = btrfs_space_info_used(space_info, true);
 	avail = atomic64_read(&fs_info->free_chunk_space);
 
 	/*
@@ -345,6 +340,22 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 		avail >>= 3;
 	else
 		avail >>= 1;
+	return avail;
+}
+
+int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
+			 struct btrfs_space_info *space_info, u64 bytes,
+			 enum btrfs_reserve_flush_enum flush)
+{
+	u64 avail;
+	u64 used;
+
+	/* Don't overcommit when in mixed mode. */
+	if (space_info->flags & BTRFS_BLOCK_GROUP_DATA)
+		return 0;
+
+	used = btrfs_space_info_used(space_info, true);
+	avail = calc_available_free_space(fs_info, space_info, flush);
 
 	if (used + bytes < space_info->total_bytes + avail)
 		return 1;
@@ -735,6 +746,7 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 {
 	struct reserve_ticket *ticket;
 	u64 used;
+	u64 avail;
 	u64 expected;
 	u64 to_reclaim = 0;
 
@@ -742,6 +754,20 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 		to_reclaim += ticket->bytes;
 	list_for_each_entry(ticket, &space_info->priority_tickets, list)
 		to_reclaim += ticket->bytes;
+
+	avail = calc_available_free_space(fs_info, space_info,
+					  BTRFS_RESERVE_FLUSH_ALL);
+	used = btrfs_space_info_used(space_info, true);
+
+	/*
+	 * We may be flushing because suddenly we have less space than we had
+	 * before, and now we're well over-committed based on our current free
+	 * space.  If that's the case add in our overage so we make sure to put
+	 * appropriate pressure on the flushing state machine.
+	 */
+	if (space_info->total_bytes + avail < used)
+		to_reclaim += used - (space_info->total_bytes + avail);
+
 	if (to_reclaim)
 		return to_reclaim;
 
-- 
2.24.1

