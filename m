Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 130B213164B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 17:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgAFQuT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 11:50:19 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:40066 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgAFQuS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 11:50:18 -0500
Received: by mail-qk1-f170.google.com with SMTP id c17so39993665qkg.7
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2020 08:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1UHJZpXLDXNFV1R+vYyun3qScvCkLU7TZ0quzcane2E=;
        b=w8sISshzEMzMT6r+r0c/4r0LqCaWCqxknDjkdWH8A8xwslhNg2Njqif/YELyk0Py3e
         PVKWGRAWmF8VMtzCLiNhDUbiDB6t9BeJ2WRqb0G/BnCLt98J9IjjTODH2OC4Ule4H7KB
         jEHnMv52WCm7KFkkbURx+Es8uUc6z0ie8B3u0It5RTV2Xxh8Y5XVhrFY6Sn5FmYfQDzJ
         SuEQBubB9VS00eieBPr8knd+42pJPusai1STes+y8iauesRzLhQMdllQOhQRRgDCoz8k
         878IUWgXhDeaNLj8xPgQMy5+tbc+EzZy6YtRwiUCnbqNG/RtjOWqd25hvgA0qcbNDWxH
         z8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1UHJZpXLDXNFV1R+vYyun3qScvCkLU7TZ0quzcane2E=;
        b=WEiKa+jD07OQw9Ej3W4cRD15EFxTa8737pRerlLoaeWxYwJLzy0RTqmsY167ljDny1
         xIXTeuyNMdTdWVJWboGg5ZEdX3zHM5t1039Z89GeJgwpS2XziPGbIND60Hlgw1sXMYnd
         Ihxp6KHLw6mFDpJmGN7X6BSkbevUjiARbPZ4MiGcyJLaItfOg8RqH4UyMrWl8iI5837+
         A/Iod+geChj6wEayw8KWbOmRFpFKt2EpnAsYCMGZc9DZxsck4Afm4L5hJWh4IIyofTHr
         JZ/s7TQtGoF+WBnNHImnVOEWYW/PF6pAsINGhQq2gYcHeCea9iWu3jB2QnGOA7YMsEYi
         kqmw==
X-Gm-Message-State: APjAAAVtenERJ74TxxvW1PozYWnQns5EOSf5ucozntBRSSqcasHyPPcc
        zd68AW5V4gnMf/YS9w9JAVpzpPfaIDmc1Q==
X-Google-Smtp-Source: APXvYqx0+xKunR1qWx/pBckSyvm9EBn6rsVsSD4X4NZI1i1akq8zrZrPAquCsr2C3+jffVT7+mFBbw==
X-Received: by 2002:a05:620a:1136:: with SMTP id p22mr84144163qkk.8.1578329416909;
        Mon, 06 Jan 2020 08:50:16 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v5sm23514969qth.70.2020.01.06.08.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 08:50:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: kill update_block_group_flags
Date:   Mon,  6 Jan 2020 11:50:15 -0500
Message-Id: <20200106165015.18985-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
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
index c79eccf188c5..0257e6f1efb1 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1975,54 +1975,6 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
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
 int btrfs_inc_block_group_ro(struct btrfs_block_group *cache)
 
 {
@@ -2058,7 +2010,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache)
 	 * if we are changing raid levels, try to allocate a corresponding
 	 * block group with the new raid level.
 	 */
-	alloc_flags = update_block_group_flags(fs_info, cache->flags);
+	alloc_flags = get_alloc_profile(fs_info, cache->flags);
 	if (alloc_flags != cache->flags) {
 		ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 		/*
@@ -2082,7 +2034,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache)
 	ret = inc_block_group_ro(cache, 0);
 out:
 	if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
-		alloc_flags = update_block_group_flags(fs_info, cache->flags);
+		alloc_flags = get_alloc_profile(fs_info, cache->flags);
 		mutex_lock(&fs_info->chunk_mutex);
 		check_system_chunk(trans, alloc_flags);
 		mutex_unlock(&fs_info->chunk_mutex);
-- 
2.23.0

