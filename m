Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE8F99FBA
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404042AbfHVTTO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:19:14 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34269 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731916AbfHVTTO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:19:14 -0400
Received: by mail-yb1-f195.google.com with SMTP id u68so2983098ybg.1
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AeR79+V8X3o9J1ucanG1LzY/IGLduXL++6IRQRmHGIE=;
        b=sRJ2PgaGBlszTXL2a2xRFH2uvv1byIQHOYOuYscxwFz5RnoSw165kuvSrWxckVSL+S
         ZmDXE9JArHZZm7tMq3XZo35yZrdDY+YE1njba6zpeW3G+qce/6KjeDuM2Q+cuaU4sr28
         EfEnQGq4MolafBYJ1OX0HismwI/P4VThsIzcOT6MgSIk2E3737VKKefyLOPoJcORoXKq
         qsa1HI1KshBXG8qaIXY+eaa5yZjihOdIZxKtE3RqfK0LmUqhdIru1dlqWbBmH71fAId6
         ULc/C1vhz/llwsmDlbnibtCf4MVK0U6wlDZGG8Ar8jGn1Oc7r8orkUigwwAeMGVTYSDy
         MxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AeR79+V8X3o9J1ucanG1LzY/IGLduXL++6IRQRmHGIE=;
        b=NdH1e0Pmsghr6qKEVHQGUSQQXX9OtGNmVMNKFyFqk6ojot1zBgAzCjCLqr4BcVv3Eh
         zmmSvXUU1a6IvbebkQTHBghFGUZOZIJ5ED8TpZzzBy1rmRSKKx1wyBZsEROFahteP3Xh
         bN2X5bwVQlXaBr/gr43qSpyHi4F/hFFhYNFA2Gahk0iqwy9nfvz7tY34ZjSnUk6tpXzn
         yAmo12P+gfSct/zXx/kACKrlznjiCwRrRtx3pHuCFzXLdZRxdUUfFg0pbmanfU45yufr
         Iv+QCVde8EpAGCBQif/M83bA0l/wxZOgShAmhfjVeZkdNRV7aQJnx0nEK5rbmzH6MxVK
         jB0w==
X-Gm-Message-State: APjAAAVE21o41cIORhPvOGouhlms/gWTc5mKkzN1vBG91Zd+jhIa7338
        DB50Kw9P8VBUY72p/1aQJtrunOOJ+iCnyQ==
X-Google-Smtp-Source: APXvYqwT4p6aCqIydgmxHjFuF6ZBMOxYPzq3v69O/nuup741wLZxk8zNRZGhDmhM9iotCpU1jfJgXg==
X-Received: by 2002:a05:6902:4f1:: with SMTP id w17mr446478ybs.36.1566501553243;
        Thu, 22 Aug 2019 12:19:13 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y3sm105861ywa.47.2019.08.22.12.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:19:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/5] btrfs: do not account global reserve in can_overcommit
Date:   Thu, 22 Aug 2019 15:19:03 -0400
Message-Id: <20190822191904.13939-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191904.13939-1-josef@toxicpanda.com>
References: <20190822191904.13939-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We ran into a problem in production where a box with plenty of space was
getting wedged doing ENOSPC flushing.  These boxes only had 20% of the
disk allocated, but their metadata space + global reserve was right at
the size of their metadata chunk.

In this case can_overcommit should be allowing allocations without
problem, but there's logic in can_overcommit that doesn't allow us to
overcommit if there's not enough real space to satisfy the global
reserve.

This is for historical reasons.  Before there were only certain places
we could allocate chunks.  We could go to commit the transaction and not
have enough space for our pending delayed refs and such and be unable to
allocate a new chunk.  This would result in a abort because of ENOSPC.
This code was added to solve this problem.

However since then we've gained the ability to always be able to
allocate a chunk.  So we can easily overcommit in these cases without
risking a transaction abort because of ENOSPC.

Also prior to now the global reserve really would be used because that's
the space we relied on for delayed refs.  With delayed refs being
tracked separately we no longer have to worry about running out of
delayed refs space while committing.  We are much less likely to
exhaust our global reserve space during transaction commit.

Fix the can_overcommit code to simply see if our current usage + what we
want is less than our current free space plus whatever slack space we
have in the disk is.  This solves the problem we were seeing in
production and keeps us from flushing as aggressively as we approach our
actual metadata size usage.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/space-info.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a43f6287074b..3053b3e91b34 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -165,9 +165,7 @@ static int can_overcommit(struct btrfs_fs_info *fs_info,
 			  enum btrfs_reserve_flush_enum flush,
 			  bool system_chunk)
 {
-	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	u64 profile;
-	u64 space_size;
 	u64 avail;
 	u64 used;
 	int factor;
@@ -181,22 +179,7 @@ static int can_overcommit(struct btrfs_fs_info *fs_info,
 	else
 		profile = btrfs_metadata_alloc_profile(fs_info);
 
-	used = btrfs_space_info_used(space_info, false);
-
-	/*
-	 * We only want to allow over committing if we have lots of actual space
-	 * free, but if we don't have enough space to handle the global reserve
-	 * space then we could end up having a real enospc problem when trying
-	 * to allocate a chunk or some other such important allocation.
-	 */
-	spin_lock(&global_rsv->lock);
-	space_size = calc_global_rsv_need_space(global_rsv);
-	spin_unlock(&global_rsv->lock);
-	if (used + space_size >= space_info->total_bytes)
-		return 0;
-
-	used += space_info->bytes_may_use;
-
+	used = btrfs_space_info_used(space_info, true);
 	avail = atomic64_read(&fs_info->free_chunk_space);
 
 	/*
-- 
2.21.0

