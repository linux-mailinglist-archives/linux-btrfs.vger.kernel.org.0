Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6F417E9EB
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 21:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgCIUXe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 16:23:34 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:46876 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgCIUXd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 16:23:33 -0400
Received: by mail-qv1-f65.google.com with SMTP id m2so5008324qvu.13
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 13:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CQmzWklwMZ2eC7GGZTJ/d27x7JCQ1D70I7B2Iq10RRE=;
        b=aKH5n5VfjBlDFORTkNE8SgSznUwLhvpuvsf4fCOZXW9QOrtFSHoVMg7AHLdbGGZmNm
         MXqfcwC5l6HjtMwTNkIDlPYzufEWFmpcxRhWRZQ7zNCJnSqO8ARDyHL8VvPznuMxTUg/
         onNV02LcATMEbCJY8NiatUAVPlYIr7u12bUHlq4zo1dI1YegD8sLlcmIVOj9SRFWGLQc
         Ioyh1BQKiXS5XwL6GhbqLL/+rJAy6OomoXNq0hKcc3cmWsVOJ/tQYsASoFdA6zB5HHNF
         nrjoxi9QO7x7qwFUPo4EKKZ5dLImlj7SGMvtRHycO1MF0aC5svvjbo6XF3eoI5++/47h
         97DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQmzWklwMZ2eC7GGZTJ/d27x7JCQ1D70I7B2Iq10RRE=;
        b=LCfCKUM9AJR5FleQNeZPF3+Aw8KlphLpRIXkCYkze1zwrEyA1M7s12So4ZUY9FLowR
         NqoEEoyv2f/MUmU8Ou1u3b9QNPd+Gfyb95xh5Lxyi8Wj/+b6OkTzAp2nphp/AixLHz8t
         mXBt92/9FIDimEzr0zUOZ8TmfBQSyufgZfuLI7y9Kt42spO42662Pv2GrZKxYJPzCfSn
         ePBJx+SB1znfztRYdIRVCoqopMaGWyx3B4tyXNTtpcYKywLqEJGOqIVLw2ACyhhb4A8H
         wXUw5AVyrk+Sj9p0akNnqahzg/22fscqG1TFBWdgMwkraWxcGxwNHL6eIf6mkDlc0iaF
         kCfQ==
X-Gm-Message-State: ANhLgQ3Jimifb+DoI/4tBXWMMrDoaPR+wlLZWPgdgukC49TRpaAp8GnD
        DCKDbR8HztEGq9QHlaUxDcpno3TmT50=
X-Google-Smtp-Source: ADFU+vuX7qXvHLs01FnqLd8dgx9kr0ua+oI5izzEYDVLfPMVf7IKmxg9nbM2htcJVFlppo+CiSFVYw==
X-Received: by 2002:a05:6214:983:: with SMTP id dt3mr16278628qvb.145.1583785412442;
        Mon, 09 Mar 2020 13:23:32 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k202sm10146947qke.134.2020.03.09.13.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:23:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/5] btrfs: only check priority tickets for priority flushing
Date:   Mon,  9 Mar 2020 16:23:21 -0400
Message-Id: <20200309202322.12327-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309202322.12327-1-josef@toxicpanda.com>
References: <20200309202322.12327-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In debugging a generic/320 failure on ppc64, Nikolay noticed that
sometimes we'd ENOSPC out with plenty of space to reclaim if we had
committed the transaction.  He further discovered that this was because
there was a priority ticket that was small enough to fit in the free
space currently in the space_info.

This is problematic because we prioritize priority tickets, refilling
them first as new space becomes available.  However this leaves a corner
where we could fail to satisfy a priority ticket when we would have
otherwise succeeded.

Consider the case where there's no flushing left to happen other than
commit the transaction, and there are tickets on the normal flushing
list.  The priority flusher comes in, and assume there's enough space
left in the space_info to satisfy this request.  We will still be added
to the priority list and go through the flushing motions, and eventually
fail returning an ENOSPC.

Instead we should only add ourselves to the list if there's something on
the priority_list already.  This way we avoid the incorrect ENOSPC
scenario.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d198cfd45cf7..77ea204f0b6a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1276,6 +1276,17 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+/*
+ * This returns true if this flush state will go through the ordinary flushing
+ * code.
+ */
+static inline bool is_normal_flushing(enum btrfs_reserve_flush_enum flush)
+{
+	return (flush == BTRFS_RESERVE_FLUSH_DATA) ||
+		(flush == BTRFS_RESERVE_FLUSH_ALL) ||
+		(flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
+}
+
 /**
  * reserve_metadata_bytes - try to reserve bytes from the block_rsv's space
  * @root - the root we're allocating for
@@ -1311,8 +1322,17 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 	spin_lock(&space_info->lock);
 	ret = -ENOSPC;
 	used = btrfs_space_info_used(space_info, true);
-	pending_tickets = !list_empty(&space_info->tickets) ||
-		!list_empty(&space_info->priority_tickets);
+
+	/*
+	 * We don't want NO_FLUSH allocations to jump everybody, they can
+	 * generally handle ENOSPC in a different way, so treat them the same as
+	 * normal flushers when it comes to skipping pending tickets.
+	 */
+	if (is_normal_flushing(flush) || (flush == BTRFS_RESERVE_NO_FLUSH))
+		pending_tickets = !list_empty(&space_info->tickets) ||
+			!list_empty(&space_info->priority_tickets);
+	else
+		pending_tickets = !list_empty(&space_info->priority_tickets);
 
 	/*
 	 * Carry on if we have enough space (short-circuit) OR call
@@ -1338,9 +1358,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		ticket.error = 0;
 		init_waitqueue_head(&ticket.wait);
 		ticket.steal = (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
-		if (flush == BTRFS_RESERVE_FLUSH_ALL ||
-		    flush == BTRFS_RESERVE_FLUSH_DATA ||
-		    flush == BTRFS_RESERVE_FLUSH_ALL_STEAL) {
+		if (is_normal_flushing(flush)) {
 			list_add_tail(&ticket.list, &space_info->tickets);
 			if (!space_info->flush) {
 				space_info->flush = 1;
-- 
2.24.1

