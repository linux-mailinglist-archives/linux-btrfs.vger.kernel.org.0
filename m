Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282E914D40B
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgA2Xuy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:50:54 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41741 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgA2Xuy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:50:54 -0500
Received: by mail-qt1-f194.google.com with SMTP id l19so1004806qtq.8
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dooZ1FfA+QrePLFnZP/btnqmiRo3tWE8NSeuFUrqIM8=;
        b=Gr9GAitSnD8NgtCB0hBpsJViFwZw1WdQy3ojBiGsY1qLvD/IUqwpGflovF6g8qskRd
         hxI38hyxZoyO22gXNN8YDfwhNMXBzXYQ0q+d+gTqiLiHb6eb/I66OuzjBFjqXdjDlFBS
         dDDl7z/UZ7FN/Wix7Ac9nrhh5ydmfo89xp04LgstAxtKXAsEDsquSLj/WbxNGin+RWe3
         tK73Fpk2zyENmcHC7vfva1uXsdBQCMuYJ2QuAX887u6NUqekiYD8XW6MeGGh6mzn+fNy
         OJ1LXnfbBBK3l/rT1UMgCfEiVqdUXHODNRqMDCHSwprcYy7rxMvjBv0cAAjCufsMI9Y5
         cfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dooZ1FfA+QrePLFnZP/btnqmiRo3tWE8NSeuFUrqIM8=;
        b=tINwxWSiI2rnYbFFnkyCTHpQx8C8m9Wym/+qQXC7kkETbsVux82xqFZ1KmSWQosaIG
         RMjprqKDJQF3DY7lEd59YX5Mfw1dqj+w0m7qsq1khQP4XTEzGKRBNEtipKEgL4HB3jaX
         8yPBowdNoYhYsp1Z3VTmW931VUskUX0kTQWPlt/GRlgEqivvBBbUJrXTbfNH+7S0bWGp
         /sGHLbml2ZgJVafjAkLTz3Sc1E/zQ1mhxlc9drYDiHGNFTkmdT4ZmRMcXCDTF25C3+Ou
         Y4gKmHyM0KrK9vNoe6Z8UpQ5P23iiIE2oX1nzjdfhdNOPDtLeCOURO3LywqeJO1PC85L
         pBPQ==
X-Gm-Message-State: APjAAAWKtvr5OVYOCkijgMSl/xuvijYxxtguwvUWZnz7IJIVGFJRbcTU
        yTeemM5xzJxhZL0/y5hHPx83LXOyD+8NKQ==
X-Google-Smtp-Source: APXvYqxtUAIYtx6sYlUWl56li+wcMO0NN/9zLV0U0ZZv2wDCymFzTrDCvh3RUTeSRLK+Wt/ML3rLoQ==
X-Received: by 2002:ac8:3946:: with SMTP id t6mr2012222qtb.278.1580341852650;
        Wed, 29 Jan 2020 15:50:52 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 4sm1824971qkv.44.2020.01.29.15.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 15/20] btrfs: serialize data reservations if we are flushing
Date:   Wed, 29 Jan 2020 18:50:19 -0500
Message-Id: <20200129235024.24774-16-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 520c91430f90..3668c2d4fadf 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1163,6 +1163,7 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 	u64 used;
 	int commit_cycles = 2;
 	int ret = -ENOSPC;
+	bool pending_tickets;
 
 	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_DATA);
 
@@ -1172,8 +1173,11 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 again:
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

