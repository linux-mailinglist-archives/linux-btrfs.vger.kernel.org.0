Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAA84B15F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343730AbiBJTKg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343724AbiBJTKe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:34 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DDA10BA
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:35 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y8so9222155pfa.11
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rw1biYAnRjYUCnV9Pn4BbD09yYt/EIi9jnt7jmf9VOk=;
        b=HtXT6kbtolQBYg1YnlqMdzF8b5onpVlZH1+LJFgZoIm41yay0Ig+cOSXPm1t9Mvj+p
         R9myaH42Qj8A5xGbBlZIYqCN68WIgAHfZxjMxjvjE+yLjchsmgeh6TDYUvy7c04lMnYV
         fhxE5Xw03G8YoBdW4XhfUZ1CckeqZcaqT6rxONHhfXxoYjaYIj0i0S+LUol0Fclmsci0
         1AIM4X08/FJkT2tHjEwkpT7Yy47cPACJj9EYv9SjrSYQcab1ECcKH7eYlgf6pGz5bYvW
         dyZK0NDrATJPOurKwYX42T+dglG86UgCBIriECmIYklhBmCS2PGp0XA0k0avIP2m04eA
         t29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rw1biYAnRjYUCnV9Pn4BbD09yYt/EIi9jnt7jmf9VOk=;
        b=fVNW/CLQcCtAJW6IX2x4kvmf/WWdd0SHlN1In1yyX1ovD2Vs5w8ZBFRvfTd6D5ckHj
         NrwhxzpZZzKNOwOgACslRaPmUa9FziyvYbgRABuvjBhdxJAhmDBW0Il52rHZz/Fkpcjx
         bhYQ5HEIbQb3w9IPrGLdlz8Vaa4R8stQYwE4Bn6FscFGXn66zgy0EM+53yz7UgJxLucm
         OR56SSUtGmeuyxLkGEuWNU5h5O8XHouG0PsHNG9kr4igH/ADugVsRcyb1P02ACpPWCcp
         irr4wtIJFacHRqIEAcju8mEhs9IkhVELeUvX1TBHIZ/dR2pZHlZSjqZ4zLV2nrCg1Jj8
         VYiw==
X-Gm-Message-State: AOAM531DjWcASy0cxWBbZL0RPYm7EyFHoAbPyExc+XlA94cbm6+P6Oww
        YHURGk4hR8P4IC9ToeN3DqBQQpCZ4ZPTtw==
X-Google-Smtp-Source: ABdhPJxDDbNaUerYJD5R4eVtw+hPN/vnHXeySVkJVvnN6tvrx9WRTuJ5tpS5yU60gyACpS+fb1zOUw==
X-Received: by 2002:a63:fc21:: with SMTP id j33mr962530pgi.557.1644520234611;
        Thu, 10 Feb 2022 11:10:34 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:34 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 05/17] btrfs: support different disk extent size for delalloc
Date:   Thu, 10 Feb 2022 11:09:55 -0800
Message-Id: <ee2fdf8fc42c3943b4fd4fdacd7efdcd76d29c4d.1644519257.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644519257.git.osandov@fb.com>
References: <cover.1644519257.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 65c0d67cd286..a1660f5a8ec6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2877,7 +2877,8 @@ void btrfs_subvolume_release_metadata(struct btrfs_root *root,
 				      struct btrfs_block_rsv *rsv);
 void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes);
 
-int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes);
+int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
+				    u64 disk_num_bytes);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end);
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index fb46a28f5065..bd8267c4687d 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -270,11 +270,11 @@ static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
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
@@ -288,7 +288,8 @@ static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
 	*qgroup_reserve = nr_extents * fs_info->nodesize;
 }
 
-int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
+int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
+				    u64 disk_num_bytes)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -318,6 +319,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	}
 
 	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
+	disk_num_bytes = ALIGN(disk_num_bytes, fs_info->sectorsize);
 
 	/*
 	 * We always want to do it this way, every other way is wrong and ends
@@ -329,8 +331,8 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
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
@@ -349,7 +351,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	spin_lock(&inode->lock);
 	nr_extents = count_max_extents(num_bytes);
 	btrfs_mod_outstanding_extents(inode, nr_extents);
-	inode->csum_bytes += num_bytes;
+	inode->csum_bytes += disk_num_bytes;
 	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
 	spin_unlock(&inode->lock);
 
@@ -454,7 +456,7 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 	ret = btrfs_check_data_free_space(inode, reserved, start, len);
 	if (ret < 0)
 		return ret;
-	ret = btrfs_delalloc_reserve_metadata(inode, len);
+	ret = btrfs_delalloc_reserve_metadata(inode, len, len);
 	if (ret < 0) {
 		btrfs_free_reserved_data_space(inode, *reserved, start, len);
 		extent_changeset_free(*reserved);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c462896122dc..1b3e083adae0 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1746,7 +1746,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
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
index 55fa13221f5c..5acdbde17574 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4697,7 +4697,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 			goto out;
 		}
 	}
-	ret = btrfs_delalloc_reserve_metadata(inode, blocksize);
+	ret = btrfs_delalloc_reserve_metadata(inode, blocksize, blocksize);
 	if (ret < 0) {
 		if (!only_release_metadata)
 			btrfs_free_reserved_data_space(inode, data_reserved,
@@ -7467,7 +7467,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		struct extent_map *em2;
 
 		/* We can NOCOW, so only need to reserve metadata space. */
-		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len);
+		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len);
 		if (ret < 0) {
 			/* Our caller expects us to free the input extent map. */
 			free_extent_map(em);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f5465197996d..9a6fb5c37022 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2997,7 +2997,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 
 		/* Reserve metadata for this range */
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-						      clamped_len);
+						      clamped_len, clamped_len);
 		if (ret)
 			goto release_page;
 
-- 
2.35.1

