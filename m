Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0FF140C17
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgAQOIa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:08:30 -0500
Received: from mail-qv1-f41.google.com ([209.85.219.41]:41511 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQOIa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:08:30 -0500
Received: by mail-qv1-f41.google.com with SMTP id x1so10749072qvr.8
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 06:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DeqixwVBUugAP5dgaxnwgS8L02pkJbMi5DEVoP8N1bg=;
        b=quenGNFqUZY19i/w9yyjpbP3cAtfBMsGZFM8fTaRqpQJuyKqNncCCrm4nkGfpEzK0V
         85ZZ+KnrWJd0gB5C5co7/1L/KewCw+Ll1TzqSn7k/gfXtrdTE/W/3rVMXxkYREUKFcag
         FGpWWWFfGLhqX209XtUfv1PatwSurFgAYzs+6rd/NFTV3aq5/cDq4S5kqQxGjfwGOuYA
         aHgJZ4IXwFgXLOpBhtqQ6oAm7WgElH1PNzusiIw4s72YCXP1L9en3QRPnBYvkpzoBHsB
         EGT1tD2ygZlxpdeepR5leBc83A2Ef9Mjhmh1aACw81AgZz5kTNFMMkU6LDHM+QhtnSUr
         W62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DeqixwVBUugAP5dgaxnwgS8L02pkJbMi5DEVoP8N1bg=;
        b=e0AZZt7U42zFwhX3Fi3hKVfPcVizqWkSgOXomulsqD55/McnsCfaZhWEIn5WirL+NG
         ILMrFzFXBECC5t0veBUXL2G/8VSy3hwMAFCWf8Rn+gce3TBJ2xQ+O2KW7xzySC1kvmUE
         8mgaS6Mq6cvEmSc/W833Dpqp/Etuqvn9+cOQ7tCA5zltZ0A72beAeD8b4Ss2YSJZP9KE
         nGC0aGEzyl4Qmvxk4549xqLxEWBLMA832H01+BtKCq5hN1tb2Mf5S/aR9qULXVArv2bQ
         tzsfbaTP0BYbQm1EP8ynYqQngdnrYxRk63y6QD0oH+NM9FPj0nIa+HQU0JgigkByXhSY
         hjkw==
X-Gm-Message-State: APjAAAWfkNk3i+H7NAIunTWNrWWmrplWff8/ECGD05mli3AYD/uG4Syn
        iG+KG2d9g/BSVBqyST59u9bc9a+8XDrFNw==
X-Google-Smtp-Source: APXvYqztNHSnGgYc4om4ZZGnYcKxzABTE/U/h0XLGaCg5pG8Fc/zEpVnuS6xtazCxw2k5dfBnWjDTA==
X-Received: by 2002:a05:6214:1348:: with SMTP id b8mr7879117qvw.137.1579270108391;
        Fri, 17 Jan 2020 06:08:28 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l85sm11855032qke.103.2020.01.17.06.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:08:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][RESEND] btrfs: kill update_block_group_flags
Date:   Fri, 17 Jan 2020 09:08:26 -0500
Message-Id: <20200117140826.42616-1-josef@toxicpanda.com>
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
- Just rebased onto misc-next.

 fs/btrfs/block-group.c | 52 ++----------------------------------------
 1 file changed, 2 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7e71ec9682d0..77ec0597bd17 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2132,54 +2132,6 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
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
@@ -2225,7 +2177,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 		 * If we are changing raid levels, try to allocate a
 		 * corresponding block group with the new raid level.
 		 */
-		alloc_flags = update_block_group_flags(fs_info, cache->flags);
+		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
 		if (alloc_flags != cache->flags) {
 			ret = btrfs_chunk_alloc(trans, alloc_flags,
 						CHUNK_ALLOC_FORCE);
@@ -2252,7 +2204,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
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

