Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01DC2172BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgGGPnW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgGGPnW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:43:22 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE85C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:43:22 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id j80so38546403qke.0
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G9f1vvaCUtFJNzvH+33kN/DhJJU7is1uTY6EG9KbLBM=;
        b=s4gl3/8GbiJMhh22bGpZW7Dd7kUbw5pcsFiRy5eZ23AREjdolTg6RoJhGKeB7NFB5K
         i45q0l2KWVA4f90zTCFOUTFHrNCbD9/VxyzzZUFQzX+PWr7+3ITnDKUjaYd1+3u7ZeBS
         ZvI08Q+ChMa9svgj2LhOsNQ1Wc0zTGZ/Cvh1zRNj57r+sZ7SaET/tkhlaKDimrJ/j10z
         GIg2uHb4NiQfCocRLtT7LJgdpBXddPP1Q9Y2hkaca0E4A5Ad7l9gfhcG8TQwadnh1hYj
         E7jqTWIlP1mX/XWg536gU8v9qLIn6NBdiu+qSpcIhLdvq5CrjtdxkAuZ6Sza/ttwxJVg
         RUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G9f1vvaCUtFJNzvH+33kN/DhJJU7is1uTY6EG9KbLBM=;
        b=T7SHzR76MOXm2Oxucy2zVuGMwTk9MkQz8fDt+FdrbC5eXKR96gK/LA+5HFEWG+DffI
         0ydHBPsPx/mdHMpFgzbtAyqmq31efsKOo25qnYDDuPS2kfwHxyJjlasbVM6sy/VvAE3L
         KKfwiSPVOaZkigcBSiGKjyT5Th7zJ7yJSB94BU9D7yNCIO2FluE2Nq26YztJGZCeOLaG
         HCDqi5quRzzKACeXSG7LQrT6/uLFIoOo1eQNvqtKWmiFEMbQ7eLQltHtojrthK/UTK74
         wdrzXw+WSOJCwpdLL787cL31fx6qHuSGgDppLwJTdhEpDIOarTjYFL1WWCiZyZHFDQHw
         pCTg==
X-Gm-Message-State: AOAM532Y1qvVdb2AvlZ5ZuDeuCFY3X8sqhnLEnI20b/1ghHUBDk9bm8+
        CfqONvJw1WrddutxbEP/eAe42m0U/beZ5Q==
X-Google-Smtp-Source: ABdhPJyHUu48ZTBV46bHvxewGwuA2CKQ03GLd5b+yUkustcbQLjgETz2UbylzKKgG2MUUJhNxcfgTA==
X-Received: by 2002:a05:620a:7ea:: with SMTP id k10mr51836498qkk.418.1594136601069;
        Tue, 07 Jul 2020 08:43:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g17sm18309815qto.73.2020.07.07.08.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:43:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 16/23] btrfs: serialize data reservations if we are flushing
Date:   Tue,  7 Jul 2020 11:42:39 -0400
Message-Id: <20200707154246.52844-17-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
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
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 7fdd571a6031..abb57ab6bfc9 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1402,13 +1402,17 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
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

