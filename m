Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B16A20F698
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 16:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgF3OAE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 10:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388552AbgF3OAA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 10:00:00 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE294C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 07:00:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 145so16129043qke.9
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 07:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xx2N/cJIt3WdYApbuDV2o6kZRueGF1hgYbsNJDc02iU=;
        b=cCoLTgj9sRl6Aw1qeeyUY19y3Cca3xFKqLN2Jc0G14mLWS3DEmyrZCcxzA9nhaonYg
         nrkQG3lu1jv0RLZNDJuNSNfBWZOcW7akYGHhAK/jTcGfR2JZYo8KKtjLNbIjRy4vo/ii
         qS1EYQlreWIudgSdj9bCk+DNRqxvbTWs4FpqLW30iP6uEHg/1r+oVtGUVUDjhwvA6cpn
         Pko/6+A7oFiP0DWIgoCBTGSjOyWXw4X49799an1/IZP8D7DzS1wzjiPVjJU6aMWvbwvv
         YeiUcCej6k2GhKk23204DPWC4eAhqWxrCyREsnl+sp9s/oqfaL++xBvUHx924YZUT0FW
         LTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xx2N/cJIt3WdYApbuDV2o6kZRueGF1hgYbsNJDc02iU=;
        b=XWU7uJVVWoAviAO4H0iTpj73hMgHyafTm+OyrcQJWBwX855vGojZeGbUAln7Q2qY5y
         DLZBclthEvn+ZFVbq6cCVu/TcRiSl5CYq69qecNUQA1ckj1htfjrG7hAAVAOmDGktf7U
         X4wW4+30aIK4oaLjK7CTVkMVKTokhHJ0sg5FkcHpmXEujTjzhaiOODyJqZRKYglmVsY+
         RF8CG6V/fr9pS56c7TzWvJg00cNAmkG1yhw1Wb+52IXPGdirZ0d5GbBn28Dg7jcPX4/Q
         cRhE8f8hZUSmXMiSP7xniuDNHu3/JSE4Ws6uIQjehXScZpnO9Sl8g1Vb3aDjRNK1BIaA
         AQzA==
X-Gm-Message-State: AOAM530OsXF6wyJ1/AjZHMT6rH3EdnEC1mJy7Fram1+NX4JlmzMyhrz0
        ba6vdVWMgsFUhoQm4Ce4iI5YsYzXbircpA==
X-Google-Smtp-Source: ABdhPJxxm2eYP8aLOnYolhs9VXTyaD1TmJiRQpEOkiSetcQITN4vhf08R9IRk39v7oQpudkwmMOjzQ==
X-Received: by 2002:a05:620a:782:: with SMTP id 2mr10005566qka.50.1593525599493;
        Tue, 30 Jun 2020 06:59:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j198sm3065070qke.71.2020.06.30.06.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:59:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 16/23] btrfs: serialize data reservations if we are flushing
Date:   Tue, 30 Jun 2020 09:59:14 -0400
Message-Id: <20200630135921.745612-17-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
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
index ee4747917b81..d9a6aefb3a9f 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1400,13 +1400,17 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
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

