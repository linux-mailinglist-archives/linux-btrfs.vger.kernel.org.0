Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4225151E2C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBDQUX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:23 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40964 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbgBDQUX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:23 -0500
Received: by mail-qk1-f194.google.com with SMTP id d7so1751205qkk.8
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lArx9kuC8LrGimM2Sf6YfMBerKbaHEqdF+WgaGDxuU0=;
        b=mxOiYiKwOxynd76tI7rlPxHddg7IsZfIBvrZqc1L7qg6xzGwdPHgNXhhohvILzIBlM
         96OmhDQZeEPOxsQWsxXzaEaLWOCzG+17dYiBFGfLpN80QztrfQ3R9Hb/ToSdW/mxKCuc
         QMKumZ0Y5F3w/4F1nsMdll3j6KK+5bC+RF8+f1dapsQ0FnJgG3fV4FLXRKAYcm5JDhJv
         WwV5E42ItJxOewlsBf5y4iI943sMXETUS+Y6HR+wHQ7iifu1l+SGG+8pIUGHAODVqRwU
         O5SXfV5ycTEB4sXcmQ/YmYhtUuO8dwh25qRiwFmhF/sVBzPkpJOmVnqILd7ECS5V3quq
         tTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lArx9kuC8LrGimM2Sf6YfMBerKbaHEqdF+WgaGDxuU0=;
        b=RSGJKytykLtedLvKQp3zRjIewJ3HYX+gcW5e8clSzcyIzn5/F0a8YEBBkmwKeQDoC9
         D8SLXvWrfmmmGp4wHox947uo2Av5xtgqVEjaT6PVNtv/z3EIco8bwJ6WNUKfnhfMazn2
         un4kx6sfdV83FzSOIGO1JONqN6HMnPFu703tODjEhr7xlZgzt7Vl0xKbTkR295IsYT1g
         lBBRKRRY99aTaoQaU5Tu27e6l+LcQhWhB6/6GViM1GXZwtpOvCfg0Pf98BazHI3MWEWG
         Vfrolj3d7kViVum7kgv7v+BJbvRAxQ00rZ224uS8aSgI/XUXEJHJe17WvOkV/haAScZn
         KbYg==
X-Gm-Message-State: APjAAAWPM+nFTPmJNsuB+KhMtw9Zl/fSAr9jvVQRUZTVzEQF/zH5rNdR
        LQghXIgkNUwlthqzuEFr7y1arEmaslJ2Mw==
X-Google-Smtp-Source: APXvYqy/iG5ekvfvjZsdaEM0hT0KYdblg5gIqom4mkqlHg1YW7juGQW2WYlIApqp4Ui3gvSL8jPVgg==
X-Received: by 2002:a05:620a:20d0:: with SMTP id f16mr1346468qka.349.1580833220598;
        Tue, 04 Feb 2020 08:20:20 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k50sm12256734qtc.90.2020.02.04.08.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:20:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 16/23] btrfs: serialize data reservations if we are flushing
Date:   Tue,  4 Feb 2020 11:19:44 -0500
Message-Id: <20200204161951.764935-17-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
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

