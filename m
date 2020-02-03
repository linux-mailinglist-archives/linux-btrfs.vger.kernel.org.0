Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4EB151159
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgBCUuX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:23 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38870 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbgBCUuX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:23 -0500
Received: by mail-qt1-f196.google.com with SMTP id c24so12610070qtp.5
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WrGaT6IeF0I7JJ883nQaZdbcGwQKIfB0x9CWoix+ibE=;
        b=KSvm7xOF3iibEZ/bJ2QITew43Y4Y6Onjh574FCDqm+pNI5OhPWBxi15WQiTb++rKsJ
         u7wOHt97sYGTp6EWdwwF27SX4qlPb3nFBzR7wlLptgS0mre+zWnSx3+hFWylH0gSh+5Z
         EMNPX4gDiwiBsuJMWg5AoPb184qyuBB+9DG3ttBvacsO/SV8MY9+zu3Lwawff+yIuEU4
         4V/3zC+atgza6aLzs0PLDY/fIDIfeCdzDD8sbI+Mjyw2D175U/C7nyPT2DMzjv4PT7lG
         ixrBQ1f4k9jjXBZ6vTGDHAw3w2Bh8a8mAROvJLUloQJ+07FIY1thkU9uiS+2hwcCMAiT
         uL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WrGaT6IeF0I7JJ883nQaZdbcGwQKIfB0x9CWoix+ibE=;
        b=d5cCvq0lJAvOkSkOYd3xhiOKLDRaxj8QfYll75uGqprTVPh8LLz16qSMmP+qwc1nvT
         i+VfrMG+IyBrtDwsKzq38zX4QnnoAugncju4ClTZWaq58ZmrjUoVmW6HdOMkHLvaxt1p
         S3PWR90kQFGs3uWjQYT1Lp/txHEvZ4gLJ1D6bPeepGQOI3ZeasRgIeTODwaY5cL2uNom
         /I4nLid0f3L/uMQ8XcqyqkcH0rUENGGetAj00C5aIaCRA06Y2YhoJmEhckH2+R2s61+D
         PAIW/MWstY3Wl/UVfITx1ptxX0XhslJvaNYMGLq1wWQR9KBqW9K5+2da9X5eNpRjEuT5
         0A9A==
X-Gm-Message-State: APjAAAVlTgk9MxixQLY8ID3lBLYlTZ30MGFuZz7E0ePvrf1ZLqAMwqie
        8hTsKmDVGhsBCEEGXPoX3HNMOvt85tJLJQ==
X-Google-Smtp-Source: APXvYqwP4VaZFbop6vm35ainaGc2mAYk50fDfceMMYmUxkRtSnn0fHEL4pFB4OOz4/QGPc6frAyRjA==
X-Received: by 2002:ac8:7b9a:: with SMTP id p26mr25442903qtu.281.1580763020678;
        Mon, 03 Feb 2020 12:50:20 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c45sm10975787qtd.43.2020.02.03.12.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 16/24] btrfs: serialize data reservations if we are flushing
Date:   Mon,  3 Feb 2020 15:49:43 -0500
Message-Id: <20200203204951.517751-17-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nikolay reported a problem where generic/371 would fail sometimes with a
slow drive.  The gist of the test is that we fallocate a file in
parallel with a pwrite of a different file.  These two files combined
are smaller than the file system, but sometimes the pwrite would ENOSPC.

A fair bit of investigation uncovered the fact that the fallocate
workload was racing in and grabbing the free space that the pwrite
workload was trying to free up so it could make its own reservation.
After a few loops of this eventually the pwrite workload would error out
with an ENOSPC.

We've had the same problem with metadata as well, and we serialized all
metadata allocations to satisfy this problem.  This wasn't usually a
problem with data because data reservations are more straightforward,
but obviously could still happen.

Fix this by not allowing reservations to occur if there are any pending
tickets waiting to be satisfied on the space info.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 5e7454577407..5ee4c6a318aa 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1155,13 +1155,17 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
 	u64 used;
 	int ret = -ENOSPC;
+	bool pending_tickets;
 
 	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_DATA);
 
 	spin_lock(&data_sinfo->lock);
 	used = btrfs_space_info_used(data_sinfo, true);
+	pending_tickets = !list_empty(&data_sinfo->tickets) ||
+		!list_empty(&data_sinfo->priority_tickets);
 
-	if (used + bytes > data_sinfo->total_bytes) {
+	if (pending_tickets ||
+	    used + bytes > data_sinfo->total_bytes) {
 		struct reserve_ticket ticket;
 
 		init_waitqueue_head(&ticket.wait);
-- 
2.24.1

