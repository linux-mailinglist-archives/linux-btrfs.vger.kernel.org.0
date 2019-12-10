Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E7811812B
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 08:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfLJHOS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 02:14:18 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:59307 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727370AbfLJHOS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 02:14:18 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 47XBBZ5CJ4z8tXq;
        Tue, 10 Dec 2019 08:14:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1575962054; bh=aqGXbbE9Uhsc+9kAuBRnI1xAxrRoisJcOmQrT+T6Q08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=Ew+99IvCUEOotk9GnmPAGTtcP/Xfoe3RDpyCLDex0Ax2PDaECSFhYS39BOLQiAEA4
         V0FTfC/1hf+eXpX/7yYCyObDxEbJLqpLdknEwih0UpSXqFJA5QZ2wBrOQqxB0Jxqsc
         8SZGS1fqxMPGhi3sRrFzN5hBYknub2X7ZFDhMnL/Sbo3qQr+MZbyMuJX3UWIGV4brP
         VlNECi43HVi3RTj5LRCOOptpCnAk0QX35CZppbqjIm0rzQviXk9uA/4zj2Kojo6p5k
         GA6iJ3hiFFZGLlKiIlWsqasjl6qEaCCUBe/4X2ptvVP7hte1AvWwnlVSIXMEK6QXkl
         W+qxo3/0e1wGQ==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.22.146
Received: from localhost.localdomain (firewall.henke.stw.uni-erlangen.de [131.188.22.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19NAS9euBl6HCpbr/Sdyta2SCcWNRzfa4s=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 47XBBX10c4z8v9f;
        Tue, 10 Dec 2019 08:14:12 +0100 (CET)
From:   Sebastian <sebastian.scherbel@fau.de>
To:     dsterba@suse.com
Cc:     josef@toxicpanda.com, clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@i4.cs.fau.de,
        Sebastian Scherbel <sebastian.scherbel@fau.de>,
        Ole Wiedemann <ole.wiedemann@fau.de>
Subject: [PATCH 5/5] fs_btrfs_block-group: code cleanup
Date:   Tue, 10 Dec 2019 08:13:57 +0100
Message-Id: <20191210071357.5323-6-sebastian.scherbel@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210071357.5323-1-sebastian.scherbel@fau.de>
References: <20191210071357.5323-1-sebastian.scherbel@fau.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sebastian Scherbel <sebastian.scherbel@fau.de>

This patch changes several instances in block-group where the coding style
is not in line with the Linux kernel guidelines to improve readability.

1. bare use of 'unsigned' replaced by 'unsigned int'
2. code indentation fixed
3. lines with more than 80 characters are broken into sensible chunks,
unless exceeding the limit significantly increases readability
4. tabs are used for indentations where possible

Signed-off-by: Sebastian Scherbel <sebastian.scherbel@fau.de>
Co-developed-by: Ole Wiedemann <ole.wiedemann@fau.de>
Signed-off-by: Ole Wiedemann <ole.wiedemann@fau.de>
---
 fs/btrfs/block-group.c | 21 +++++++++++++--------
 fs/btrfs/block-group.h |  8 ++++----
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6934a5b8708f..22bc97515e96 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -97,7 +97,7 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
 
 static u64 get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags)
 {
-	unsigned seq;
+	unsigned int seq;
 	u64 flags;
 
 	do {
@@ -259,7 +259,8 @@ struct btrfs_block_group *btrfs_next_block_group(
 
 		spin_unlock(&fs_info->block_group_cache_lock);
 		btrfs_put_block_group(cache);
-		cache = btrfs_lookup_first_block_group(fs_info, next_bytenr); return cache;
+		cache = btrfs_lookup_first_block_group(fs_info, next_bytenr);
+		return cache;
 	}
 	node = rb_next(&cache->cache_node);
 	btrfs_put_block_group(cache);
@@ -447,7 +448,8 @@ static void fragment_free_space(struct btrfs_block_group *block_group)
  * used yet since their free space will be released as soon as the transaction
  * commits.
  */
-u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end)
+u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start,
+		       u64 end)
 {
 	struct btrfs_fs_info *info = block_group->fs_info;
 	u64 extent_start, extent_end, size, total_added = 0;
@@ -670,7 +672,8 @@ static noinline void caching_thread(struct btrfs_work *work)
 	btrfs_put_block_group(block_group);
 }
 
-int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only)
+int btrfs_cache_block_group(struct btrfs_block_group *cache,
+			    int load_cache_only)
 {
 	DEFINE_WAIT(wait);
 	struct btrfs_fs_info *fs_info = cache->fs_info;
@@ -1696,7 +1699,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 
 	ASSERT(key->type == BTRFS_BLOCK_GROUP_ITEM_KEY);
 
-	cache = btrfs_create_block_group_cache(info, key->objectid, key->offset);
+	cache = btrfs_create_block_group_cache(info, key->objectid,
+					       key->offset);
 	if (!cache)
 		return -ENOMEM;
 
@@ -2023,8 +2027,8 @@ static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
  *
  * @cache:		the destination block group
  * @do_chunk_alloc:	whether need to do chunk pre-allocation, this is to
- * 			ensure we still have some free space after marking this
- * 			block group RO.
+ *			ensure we still have some free space after marking this
+ *			block group RO.
  */
 int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 			     bool do_chunk_alloc)
@@ -2082,7 +2086,8 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 		goto unlock_out;
 	if (!ret)
 		goto out;
-	alloc_flags = btrfs_get_alloc_profile(fs_info, cache->space_info->flags);
+	alloc_flags = btrfs_get_alloc_profile(fs_info,
+					      cache->space_info->flags);
 	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
 		goto out;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 9b409676c4b2..d4e9d2d88542 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -139,9 +139,9 @@ struct btrfs_block_group {
 	 * Incremented while holding the spinlock *lock* by a task checking if
 	 * it can perform a nocow write (incremented if the value for the *ro*
 	 * field is 0). Decremented by such tasks once they create an ordered
-	 * extent or before that if some error happens before reaching that step.
-	 * This is to prevent races between block group relocation and nocow
-	 * writes through direct IO.
+	 * extent or before that if some error happens before reaching that
+	 * step. This is to prevent races between block group relocation and
+	 * nocow writes through direct IO.
 	 */
 	atomic_t nocow_writers;
 
@@ -186,7 +186,7 @@ bool btrfs_inc_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr);
 void btrfs_dec_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr);
 void btrfs_wait_nocow_writers(struct btrfs_block_group *bg);
 void btrfs_wait_block_group_cache_progress(struct btrfs_block_group *cache,
-				           u64 num_bytes);
+					   u64 num_bytes);
 int btrfs_wait_block_group_cache_done(struct btrfs_block_group *cache);
 int btrfs_cache_block_group(struct btrfs_block_group *cache,
 			    int load_cache_only);
-- 
2.20.1

