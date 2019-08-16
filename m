Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9A59048E
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 17:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfHPPUa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 11:20:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34072 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfHPPUa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 11:20:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id q4so6500911qtp.1
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=B467Ri0de2wq/UqSeJ7pK5/0NTpfGHZiwnmW7UyKD1Q=;
        b=VWk2pgxM2NkeOCIwNshDX24JmNnvPPl7obnqnEp6F514wR88zWwphEZiWWEDnB1NHJ
         BasGD65O+N++c/5Kn8D7Xf5digmOE/FFgpaTUUEFC/h8iFWPF8XmEgnZV92StZuxkGeZ
         Z54dnnyb5PIPy7OqnRe3zUTN3Gi3/2tnGwVK7EXgtqucK9jswTzRiuFSeEAHiQ4V8mna
         Z3xv3m+kQ57o7ppuqQM+0t/mBnLWvS1H/Tqxzx4q09XGM0FY/aAtz012TuNBYd5l6BDw
         GMqKXapfw6/vXNq8U6dVlpPqmP1kuWeuwO8JW+ou2Dk8l7vOasXV84KxOMmoFFAJ9xyI
         Ljsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B467Ri0de2wq/UqSeJ7pK5/0NTpfGHZiwnmW7UyKD1Q=;
        b=MtOz5kr+Qj4VCFyRV1csPx48Nga9jMPSDkPwgRQdY6AN61E37GwK4q1gbtXvSGicB2
         UOb+ICC3AwNY/CZeAGkiNHBEI0taIFmGDK9CX7ULpMZrzPQl4cCZPr3ljvosbjoOxOdx
         BukKN+spWXVdvuOqkoE6Azkvxe9SW0VjqTElMDytFBT0BhtOpXEXQxd9iUtdIc3rXrYS
         bWkjXqZSYacdcUcFg07Yw9x0rn588HrcyoylhuCfedvtGGUtTpiy7BVJJy/Tfq889ywO
         ZKb8MOuIKjRPQCHeEs+rlPEir4hLxvfrPNm+Q8MbzccNSo1x90SgcKURacB49JAA64e9
         nXsQ==
X-Gm-Message-State: APjAAAWPj+AcZNPqUSJRML3+jCBWNQ5DJ2AwZc4Y3zdlSWUXJu1DPAJq
        u8RNo6elHTQ11C83gb983enU3Jh2mXnwew==
X-Google-Smtp-Source: APXvYqzw2L8m1/U7AUDT/4ZERliusz+D5AqFhOHM+Jj5QMezVhagX/hTbVa9Tf1boF2R6oxOJFqijw==
X-Received: by 2002:a0c:e64e:: with SMTP id c14mr2175112qvn.117.1565968828930;
        Fri, 16 Aug 2019 08:20:28 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k2sm2875245qtq.84.2019.08.16.08.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 08:20:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/5] btrfs: do not account global reserve in can_overcommit
Date:   Fri, 16 Aug 2019 11:20:18 -0400
Message-Id: <20190816152019.1962-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816152019.1962-1-josef@toxicpanda.com>
References: <20190816152019.1962-1-josef@toxicpanda.com>
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
---
 fs/btrfs/space-info.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 9c5f81074cd5..3d3f301bae26 100644
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

