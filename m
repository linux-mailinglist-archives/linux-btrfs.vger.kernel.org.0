Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1362281FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgGUOXK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbgGUOXK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:23:10 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D7EC061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:09 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z15so12615662qki.10
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46HbDWQcKmcttSQB7AW4PupurGGvNNNEWKfXAY7s/Ks=;
        b=N6fOeYmx1KX9h9Ur+xgavuZWVuF3zF6WG7WH5sadDx9DbqK/VP/j+VRiEpjvb2QUtk
         ywSHBvAyIzN5u6WGAkEy+Xvch+LB+eKlZXHTdOktUGm3sk3UKwDWtoybLHsE9R2uMzTG
         hc9n4t9O3DRNEl35edwUUZa395LeJNN15kLu2oEt1CrJSchl0CijqJNIPPyjb1iR0prz
         Kf3pNsUABGZ+U6WWL075FORIkQSvD2hW33cisa4CY8b/UghSTivZj+xYAwYEGdnIpZhC
         gYtotpxm2EobAYzo581oC/m+Lzqu1JjL/T0RI4GQp/ENONfHX4LuVoJF3kHqyrrrU4Ga
         wy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46HbDWQcKmcttSQB7AW4PupurGGvNNNEWKfXAY7s/Ks=;
        b=lbqqJxCHcJkDFQUrHiUaLsrUrDhUFnjsAj3HQFo1LP76vymVVA1WZJY4LxxocRyp9E
         C9H+1g5WtsfaqgmNqdcFhww/khJua/YLSlXFQZweD0Y59f9OSYe6QQ8piWWsys+Oh2bG
         lDNeyANcjFptK5wB3EhwFKrjIFSq2VsOtSGDVjC7RGGy3fXeZbbWrm9buvXaojPxDtBN
         UNegBylN31IQn+tbNHxfpC86QUsAZNHiJxKhR0PLalBnawJRzBWHk25hnZhTyPSPn/4S
         vvn5JhU3JTOGzSm7QPbLJOL3u2h6RLvUtiBgLo3KQHtK4ZabGPSirDhN62Rl1lnZoazc
         LcQA==
X-Gm-Message-State: AOAM5318cfNv2SH4kO7EZa06F+DLW/ZppRPdmR8yhumZkomX64Jx9iQm
        AWpUDjYHNzPCM98b33VpJpbjiBC+Wso66A==
X-Google-Smtp-Source: ABdhPJwl0mne9GjuIm9TfBm2n59apwiiyTvfmmH9btPrLhUULOf38rw8VPZnIXjCzoHcnNl4wrjitw==
X-Received: by 2002:a37:7683:: with SMTP id r125mr27179468qkc.39.1595341388713;
        Tue, 21 Jul 2020 07:23:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 142sm2640826qki.35.2020.07.21.07.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:23:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 16/23] btrfs: serialize data reservations if we are flushing
Date:   Tue, 21 Jul 2020 10:22:27 -0400
Message-Id: <20200721142234.2680-17-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
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
index a107370d144c..afdc774cebe9 100644
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

