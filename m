Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2F3454E64
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbhKQUXK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240650AbhKQUXF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:05 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDBBC061766
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:06 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id v2so2885420qve.11
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mr/qxi8LZKYtL1UDp9JV8wqH9H2ofq9cHo044ox5hNY=;
        b=ry6+oXpCRsTrQ7LebQ4uAijV1tQh2IxULh+lPfuC7YSzb/kqkTFW/xgEQq4eOyWV/9
         vaGniA3WDrTfkDdJUU+Hc1l2FoCLUM2tmKCb8ZbFYJpiFnBaGavauWa9/O+CDXv+PZjo
         u7R2y/l+jGOx6gwMgn4xbwEchX42onsuiQWFn5UPoy48Y9mnsbBzdmPMhU4yk9WBzsK+
         DUv89bRXg6eExiIK9stZHI4T2/6vq+9Zih4Xf4Bu2MU7Nsgzdozm1aOM5Rk7MJAqecU7
         YJkkwjC6MQsZGOvmoJsh8VoEgvIoipjJtih6lg3lWhOly8y+8iki6EH5wPmvs7+sPYC8
         hkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mr/qxi8LZKYtL1UDp9JV8wqH9H2ofq9cHo044ox5hNY=;
        b=J1nJdiz1gZ9Upft7+DSzwxjR6T8m6d9n6iLgqlfk3B6htRrqhEmjYMkac3AwlsBVtR
         d79ynpipEd8LxEhteNaqW5kfUFWxv7UDBEOz19WB7Cce9kP4DmZ5tHb7vbBmOaQn6Xd0
         zJGeaS9SVguy6ryx3Cghh+f9BENHtoWJkb3mzVBEZ1oeCsdfP/EMNlbf6nvyzqKnnP1o
         jEubwqUW5PdAydOGxNPx5v+v+xmaB9NqOHj2oSRAYNI27uJMngVkutdAFQ+UiINuLzUb
         ggx7+v7hHFK/kWyt9ruDd8eYanIyBdVu5N5ibrLQ+PdzBgFJDHit+ro2Lqe86iLH5UeK
         TG6w==
X-Gm-Message-State: AOAM532r3f6N5YAKlYjNIcOZSn0mTMfUnmXL7BxHD2Qeduy5RHlJKlvV
        WMmpUztfstrVrZzicSpZPweFBmNE79C49Q==
X-Google-Smtp-Source: ABdhPJxkV6G0LeKV++akmYtcod1tHejzrg07lXp4iAuClQSM8tf2WhGDaCZVP/4bf3Xek0TidbHnYg==
X-Received: by 2002:a05:6214:f62:: with SMTP id iy2mr57514876qvb.25.1637180405601;
        Wed, 17 Nov 2021 12:20:05 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:05 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 05/17] btrfs: support different disk extent size for delalloc
Date:   Wed, 17 Nov 2021 12:19:15 -0800
Message-Id: <3bdadb3fb344495323fbb4a098fe97c08d967a31.1637179348.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Currently, we always reserve the same extent size in the file and extent
size on disk for delalloc because the former is the worst case for the
latter. For BTRFS_IOC_ENCODED_WRITE writes, we know the exact size of
the extent on disk, which may be less than or greater than (for
bookends) the size in the file. Add a disk_num_bytes parameter to
btrfs_delalloc_reserve_metadata() so that we can reserve the correct
amount of csum bytes. No functional change.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ctree.h          |  3 ++-
 fs/btrfs/delalloc-space.c | 18 ++++++++++--------
 fs/btrfs/file.c           |  3 ++-
 fs/btrfs/inode.c          |  4 ++--
 fs/btrfs/relocation.c     |  2 +-
 5 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9fd677f2ce15..2e7f74060a14 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2823,7 +2823,8 @@ void btrfs_subvolume_release_metadata(struct btrfs_root *root,
 				      struct btrfs_block_rsv *rsv);
 void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes);
 
-int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes);
+int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
+				    u64 disk_num_bytes);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end);
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index bca438c7c972..ec96f1b342e0 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -267,11 +267,11 @@ static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
 }
 
 static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
-				    u64 num_bytes, u64 *meta_reserve,
-				    u64 *qgroup_reserve)
+				    u64 num_bytes, u64 disk_num_bytes,
+				    u64 *meta_reserve, u64 *qgroup_reserve)
 {
 	u64 nr_extents = count_max_extents(num_bytes);
-	u64 csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, num_bytes);
+	u64 csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, disk_num_bytes);
 	u64 inode_update = btrfs_calc_metadata_size(fs_info, 1);
 
 	*meta_reserve = btrfs_calc_insert_metadata_size(fs_info,
@@ -285,7 +285,8 @@ static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
 	*qgroup_reserve = nr_extents * fs_info->nodesize;
 }
 
-int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
+int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
+				    u64 disk_num_bytes)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -315,6 +316,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	}
 
 	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
+	disk_num_bytes = ALIGN(disk_num_bytes, fs_info->sectorsize);
 
 	/*
 	 * We always want to do it this way, every other way is wrong and ends
@@ -326,8 +328,8 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	 * everything out and try again, which is bad.  This way we just
 	 * over-reserve slightly, and clean up the mess when we are done.
 	 */
-	calc_inode_reservations(fs_info, num_bytes, &meta_reserve,
-				&qgroup_reserve);
+	calc_inode_reservations(fs_info, num_bytes, disk_num_bytes,
+				&meta_reserve, &qgroup_reserve);
 	ret = btrfs_qgroup_reserve_meta_prealloc(root, qgroup_reserve, true);
 	if (ret)
 		return ret;
@@ -346,7 +348,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	spin_lock(&inode->lock);
 	nr_extents = count_max_extents(num_bytes);
 	btrfs_mod_outstanding_extents(inode, nr_extents);
-	inode->csum_bytes += num_bytes;
+	inode->csum_bytes += disk_num_bytes;
 	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
 	spin_unlock(&inode->lock);
 
@@ -451,7 +453,7 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 	ret = btrfs_check_data_free_space(inode, reserved, start, len);
 	if (ret < 0)
 		return ret;
-	ret = btrfs_delalloc_reserve_metadata(inode, len);
+	ret = btrfs_delalloc_reserve_metadata(inode, len, len);
 	if (ret < 0)
 		btrfs_free_reserved_data_space(inode, *reserved, start, len);
 	return ret;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 11204dbbe053..5fbf0a2aba2e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1749,7 +1749,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					 fs_info->sectorsize);
 		WARN_ON(reserve_bytes == 0);
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-				reserve_bytes);
+						      reserve_bytes,
+						      reserve_bytes);
 		if (ret) {
 			if (!only_release_metadata)
 				btrfs_free_reserved_data_space(BTRFS_I(inode),
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1afadc7afff3..0c5b9832f975 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5050,7 +5050,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 			goto out;
 		}
 	}
-	ret = btrfs_delalloc_reserve_metadata(inode, blocksize);
+	ret = btrfs_delalloc_reserve_metadata(inode, blocksize, blocksize);
 	if (ret < 0) {
 		if (!only_release_metadata)
 			btrfs_free_reserved_data_space(inode, data_reserved,
@@ -7812,7 +7812,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		struct extent_map *em2;
 
 		/* We can NOCOW, so only need to reserve metadata space. */
-		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len);
+		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len);
 		if (ret < 0) {
 			/* Our caller expects us to free the input extent map. */
 			free_extent_map(em);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a455a1ead0d6..fa8dcc3375b5 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2996,7 +2996,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 
 		/* Reserve metadata for this range */
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-						      clamped_len);
+						      clamped_len, clamped_len);
 		if (ret)
 			goto release_page;
 
-- 
2.34.0

