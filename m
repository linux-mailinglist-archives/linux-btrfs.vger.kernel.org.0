Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE94836B9
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 18:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387860AbfHFQ2p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 12:28:45 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45154 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387676AbfHFQ2p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 12:28:45 -0400
Received: by mail-qk1-f195.google.com with SMTP id s22so63424587qkj.12
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2019 09:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oR37e6cLJp6cBJer6KLq5Wr0yOz/TfBlIbWSaUUYuyo=;
        b=K3mLjPoULNf4U49pKZoOnjgmMn4/Okd9mZNgvhYAzsYrGVIHUcFf7/GaGlM0yE+ISH
         VTwGj9msTt3LXpxl2B5Ba2n5ZALUWiaT8vnEPBgcUUvZwEKvx3G/d3t1p+0UHOygdfqe
         yQApyNmZOmbGZ6UfQ7qRk9ZNtq3P8ib/ihgBGw9QTDe0Fiy5nkK5WpoMTea5T69Rk0KB
         1OeiXM+oiI5Fyrw25N6hHdcMnvYwtnOSF8FdSrVe9Wa6RTkNFAnrNKIAzNnhO5NGGUH5
         ZJN1aSk9jragoxQ6OGNg4JEK3gorogLvZibVvSbMjCZfbwHs1cICct1R/FnzjTXme+Md
         n/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oR37e6cLJp6cBJer6KLq5Wr0yOz/TfBlIbWSaUUYuyo=;
        b=OtnYL4XMkHiYdpwKz0vmUxKJg4Wd5vaMKxsXioljZpVC7qyGptzRSJbTcXZGYRdk1M
         +GVJ+fmc/GRfORZjKC2lq6rOTO0rPvCMGBzeUzimmKHjdZSjf8mmSNsh61bIVYeOIFRP
         tmJNFyuF9qMAYV9fWvfZofWY8JoGcvae4UloNlPyf8O9bsNpwSbtfdJs97X0scsaHxxS
         XAOmaFDSU+fEMj9pjNOire4lolI7lvEtCa+te83WXy+1kOq3DQ28Zqtycx7t4cKlBaE0
         NKb8SjdM4hPQAxA08ZZ5LPaHh17HcBaPL0lUpDvzNMBRV4cJLyAoGz/jvB2oy2WOAcY/
         P+/A==
X-Gm-Message-State: APjAAAXxdWZrZgXR8oIEDzs40bogn2YXJn3GYSE9NsboQyMf8UaY2sUt
        0nmXKhvfIzhVcKP2rJqfG7V2qw==
X-Google-Smtp-Source: APXvYqxVp9I8DCyXlzhByU8lW+qIDrcpcqiLz/1hVwF5+0B8dYyJE9L8dI9W0UBSEVI2fg4loS7YnA==
X-Received: by 2002:ae9:ea0b:: with SMTP id f11mr4189868qkg.142.1565108923729;
        Tue, 06 Aug 2019 09:28:43 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m44sm46779646qtm.54.2019.08.06.09.28.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 09:28:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 02/15] btrfs: temporarily export inc_block_group_ro
Date:   Tue,  6 Aug 2019 12:28:24 -0400
Message-Id: <20190806162837.15840-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806162837.15840-1-josef@toxicpanda.com>
References: <20190806162837.15840-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is used in a few logical parts of the block group code, temporarily
export it so we can move things in pieces.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.h |  2 ++
 fs/btrfs/extent-tree.c | 15 ++++++++-------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 80b388ece277..26c5bf876737 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -185,4 +185,6 @@ static inline int btrfs_block_group_cache_done(
 		cache->cached == BTRFS_CACHE_ERROR;
 }
 
+int __btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache,
+			       int force);
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 90348105991d..54dc910eb6c8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6836,7 +6836,8 @@ static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
  * data in this block group. That check should be done by relocation routine,
  * not this function.
  */
-static int inc_block_group_ro(struct btrfs_block_group_cache *cache, int force)
+int __btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache,
+			       int force)
 {
 	struct btrfs_space_info *sinfo = cache->space_info;
 	u64 num_bytes;
@@ -6946,14 +6947,14 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
 			goto out;
 	}
 
-	ret = inc_block_group_ro(cache, 0);
+	ret = __btrfs_inc_block_group_ro(cache, 0);
 	if (!ret)
 		goto out;
 	alloc_flags = get_alloc_profile(fs_info, cache->space_info->flags);
 	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
 		goto out;
-	ret = inc_block_group_ro(cache, 0);
+	ret = __btrfs_inc_block_group_ro(cache, 0);
 out:
 	if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
 		alloc_flags = update_block_group_flags(fs_info, cache->flags);
@@ -7486,7 +7487,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 
 		set_avail_alloc_bits(info, cache->flags);
 		if (btrfs_chunk_readonly(info, cache->key.objectid)) {
-			inc_block_group_ro(cache, 1);
+			__btrfs_inc_block_group_ro(cache, 1);
 		} else if (btrfs_block_group_used(&cache->item) == 0) {
 			ASSERT(list_empty(&cache->bg_list));
 			btrfs_mark_bg_unused(cache);
@@ -7507,11 +7508,11 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		list_for_each_entry(cache,
 				&space_info->block_groups[BTRFS_RAID_RAID0],
 				list)
-			inc_block_group_ro(cache, 1);
+			__btrfs_inc_block_group_ro(cache, 1);
 		list_for_each_entry(cache,
 				&space_info->block_groups[BTRFS_RAID_SINGLE],
 				list)
-			inc_block_group_ro(cache, 1);
+			__btrfs_inc_block_group_ro(cache, 1);
 	}
 
 	btrfs_add_raid_kobjects(info);
@@ -8051,7 +8052,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_unlock(&block_group->lock);
 
 		/* We don't want to force the issue, only flip if it's ok. */
-		ret = inc_block_group_ro(block_group, 0);
+		ret = __btrfs_inc_block_group_ro(block_group, 0);
 		up_write(&space_info->groups_sem);
 		if (ret < 0) {
 			ret = 0;
-- 
2.21.0

