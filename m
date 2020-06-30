Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25AB20FB8E
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 20:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbgF3SRZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 14:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgF3SRY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 14:17:24 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9071EC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 11:17:24 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id o38so16333948qtf.6
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A+z7zjFaz3LxRQaL+B8Njg0/a1c0ho+fApL/2BSuzKo=;
        b=HCbQgrhFVLuIXT2NyC8id4dfOeYv4l6QgWPAFVAwtWwNtRl1Ge0RmsGUkqrX2QOQuH
         X0qKhS/4A3ZKtNJUkV8ovrltYCNZY5Lr5akaD17Fryv8wqFIByXPh6HaobTz6voTvVcY
         xEKEoEVf6ojlbeHZV84J0bYgTrm0QLEAhl6rV5d6LdD74ol6SBdMZs1DI3XYnmpQJKxi
         8uUOAwyTyoJQwK0avscRfgGrOIRl2rzbSYCgwkCrNZ3kjlxcR+ta9qrhUkRopBWplqYL
         Oq2RQzxteCLA2oDYX/Zq+ePlmv3vaA05aQcQRXvXTeWJfnESoKcLq4kB9gTcR0MXN7P0
         wvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A+z7zjFaz3LxRQaL+B8Njg0/a1c0ho+fApL/2BSuzKo=;
        b=YPHBKGtot/CSZAl2rLhQWnwrOS1Tln4QlK6CEN+Cx6HdL1A3bQb75H3AndRLUNOq6q
         VhYnTtnXadrABVdA9QD6vZ/IlUI0JnOg4xT6IdJxBKHxfYIt43XnhcupR+9CuHKZIrMn
         EZUWJ9HM8lAqdR+huhMeeRCn/UQ14Fe8ucrJ5TUjXjukJSj/bONgevjFevUFuDQhomPd
         cKJwcaGNjI8PIa1KFQ3xcgjNPbvg8C7qixFxH+fuxP4QuWquXBd7zMlrJIJuNOu8m1F7
         l9uMT7d64xQUS6ZJ6gbJMpRncv2iJ5bVmD5lKmSTsAhVDC+3ODkTeIQZJXDVVFOBooYb
         +S6w==
X-Gm-Message-State: AOAM530O29UfJfQrfQUhYAdJSxLWI+jn7EuPZ5NABAMZ3toMHXrJ8x0p
        +Eib67m12hsi+kUVIA1YvXBjam/f22oK6w==
X-Google-Smtp-Source: ABdhPJy91Lo5wpvMdKhJXLuIJCO+hdky8rNrwlhcGuwBVxnKsQfmGqjKbflkCPSpDU0CGJSbRcp7pg==
X-Received: by 2002:ac8:7b38:: with SMTP id l24mr22887915qtu.122.1593541043248;
        Tue, 30 Jun 2020 11:17:23 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y143sm3816434qka.22.2020.06.30.11.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 11:17:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        holger@applied-asynchrony.com
Subject: [PATCH 1/2] btrfs: kill update_block_group_flags
Date:   Tue, 30 Jun 2020 14:17:18 -0400
Message-Id: <20200630181719.3190860-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs/061 has been failing consistently for me recently with a
transaction abort.  We run out of space in the system chunk array, which
means we've allocated way too many system chunks than we need.

Chris added this a long time ago for balance as a poor mans restriping.
If you had a single disk and then added another disk and then did a
balance, update_block_group_flags would then figure out which RAID level
you needed.

Fast forward to today and we have restriping behavior, so we can
explicitly tell the fs that we're trying to change the raid level.  This
is accomplished through the normal get_alloc_profile path.

Furthermore this code actually causes btrfs/061 to fail, because we do
things like mkfs -m dup -d single with multiple devices.  This trips
this check

alloc_flags = update_block_group_flags(fs_info, cache->flags);
if (alloc_flags != cache->flags) {
	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);

in btrfs_inc_block_group_ro.  Because we're balancing and scrubbing, but
not actually restriping, we keep forcing chunk allocation of RAID1
chunks.  This eventually causes us to run out of system space and the
file system aborts and flips read only.

We don't need this poor mans restriping any more, simply use the normal
get_alloc_profile helper, which will get the correct alloc_flags and
thus make the right decision for chunk allocation.  This keeps us from
allocating a billion system chunks and falling over.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 52 ++----------------------------------------
 1 file changed, 2 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 09b796a081dd..b111885482e5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2242,54 +2242,6 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	return 0;
 }
 
-static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
-{
-	u64 num_devices;
-	u64 stripped;
-
-	/*
-	 * if restripe for this chunk_type is on pick target profile and
-	 * return, otherwise do the usual balance
-	 */
-	stripped = get_restripe_target(fs_info, flags);
-	if (stripped)
-		return extended_to_chunk(stripped);
-
-	num_devices = fs_info->fs_devices->rw_devices;
-
-	stripped = BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID56_MASK |
-		BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10;
-
-	if (num_devices == 1) {
-		stripped |= BTRFS_BLOCK_GROUP_DUP;
-		stripped = flags & ~stripped;
-
-		/* turn raid0 into single device chunks */
-		if (flags & BTRFS_BLOCK_GROUP_RAID0)
-			return stripped;
-
-		/* turn mirroring into duplication */
-		if (flags & (BTRFS_BLOCK_GROUP_RAID1_MASK |
-			     BTRFS_BLOCK_GROUP_RAID10))
-			return stripped | BTRFS_BLOCK_GROUP_DUP;
-	} else {
-		/* they already had raid on here, just return */
-		if (flags & stripped)
-			return flags;
-
-		stripped |= BTRFS_BLOCK_GROUP_DUP;
-		stripped = flags & ~stripped;
-
-		/* switch duplicated blocks with raid1 */
-		if (flags & BTRFS_BLOCK_GROUP_DUP)
-			return stripped | BTRFS_BLOCK_GROUP_RAID1;
-
-		/* this is drive concat, leave it alone */
-	}
-
-	return flags;
-}
-
 /*
  * Mark one block group RO, can be called several times for the same block
  * group.
@@ -2335,7 +2287,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 		 * If we are changing raid levels, try to allocate a
 		 * corresponding block group with the new raid level.
 		 */
-		alloc_flags = update_block_group_flags(fs_info, cache->flags);
+		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
 		if (alloc_flags != cache->flags) {
 			ret = btrfs_chunk_alloc(trans, alloc_flags,
 						CHUNK_ALLOC_FORCE);
@@ -2362,7 +2314,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	ret = inc_block_group_ro(cache, 0);
 out:
 	if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
-		alloc_flags = update_block_group_flags(fs_info, cache->flags);
+		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
 		mutex_lock(&fs_info->chunk_mutex);
 		check_system_chunk(trans, alloc_flags);
 		mutex_unlock(&fs_info->chunk_mutex);
-- 
2.24.1

