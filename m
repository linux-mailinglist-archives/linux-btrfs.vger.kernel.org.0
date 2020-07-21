Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1039F2282A5
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgGUOsw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUOsw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:48:52 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC8BC061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:48:51 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b79so5731908qkg.9
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vs3i9LzD56v11E05dWCdQT5i8zTQ9ZQcrb8VJ73zgOw=;
        b=WbRAbfJDXZ2+8FOC6MUhtJaBLgQ+QUGDe0pD9kZEFfYQCe9qQBhq7E7s9H+ovFX6y+
         zMfUSk0kFUsfBql70iQLhY/U6nAUAyW3s0VFp9StTjkPN3zSHrjkaBBejyG66O+QVnRy
         8BYFhJuIiiq9XdPM8TGXZHIvZQ530XLE+rEbZmX2tJD6VzB1go3le7URRvWecLGz4xay
         aim+EHNZWnlAkNwhIK8TasH9wmP3yDDq1kx4aSRPRCCh9IY4bv1wp1+uTZu1IIdilnYr
         +TQilEAqWxCRSRAFVXCXHN7HROw1z0vNosJLQMJk6XTVS0egOfkv2wRA0QgRcBn1mcMU
         1oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vs3i9LzD56v11E05dWCdQT5i8zTQ9ZQcrb8VJ73zgOw=;
        b=ovFlrNpMqoapa4KFRUpbsrNah6+P8aqglom4N8pRasKfe3dXiP9ZB9DQxc3arRiXtN
         RFxVrsD648nts8KckXlJDDGSrn+q158gTPHzbAQ6hrXcsupULh1mQuMEIU7x84+pYOTp
         rD1VYOaKN7OAZeWHuxBSl2vBpdgezXs5fNWEEfgfOHB/LUmc1TVl8cl9oqrEazqcYvZX
         Dpr11Cw51b+VFsYfur9O+3ThJ8dTWDP6ORE4NhKklfaCGwPO8z7Yckt/1gyfcW6AopKa
         xr6avSV7JTslwLaJo5xfFTDoeRLKO2mb8DgNBwXkvlb4lsTLLzK1mhlUQC0mebUyA7Kp
         J9zw==
X-Gm-Message-State: AOAM533S42D9cyPcQicn1ksBZaa44PokJmrbfQWoRjmOzHRQLtyHcsvZ
        rUTuBzp0jtQuI5pE6HrGJkPHPmgiLjTOEw==
X-Google-Smtp-Source: ABdhPJwLf7gyre6VLs38o1+/0UaaLNbkc3hBqpDa/5k63tSsR0ffGp+FCF54zvw3oUCHs5wAPhTf3Q==
X-Received: by 2002:a37:6d2:: with SMTP id 201mr25730843qkg.187.1595342930565;
        Tue, 21 Jul 2020 07:48:50 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x36sm22384998qtb.78.2020.07.21.07.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:48:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: kill update_block_group_flags
Date:   Tue, 21 Jul 2020 10:48:45 -0400
Message-Id: <20200721144846.4511-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721144846.4511-1-josef@toxicpanda.com>
References: <20200721144846.4511-1-josef@toxicpanda.com>
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
index 884de28a41e4..652b35d5a773 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2194,54 +2194,6 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
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
@@ -2287,7 +2239,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 		 * If we are changing raid levels, try to allocate a
 		 * corresponding block group with the new raid level.
 		 */
-		alloc_flags = update_block_group_flags(fs_info, cache->flags);
+		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
 		if (alloc_flags != cache->flags) {
 			ret = btrfs_chunk_alloc(trans, alloc_flags,
 						CHUNK_ALLOC_FORCE);
@@ -2314,7 +2266,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
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

