Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC1C5836C1
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 18:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbfHFQ26 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 12:28:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46272 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387893AbfHFQ26 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 12:28:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so85093058qtn.13
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2019 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RnXREa8RVoocEwkNCkNI2GYWcey90wZ0QRnkNMZk7Pw=;
        b=RLEXVzA5xar3CR3oPTrQ3FVXpKE3UrcfDSaWOk6r4RQpIPdpHUYd1ShUskUd9+qZ3R
         8MTmTpY4lPKqF2ZEZugoUz07mSZZDl3eo14e8WQQJUEa2s7nksbth0N2IkPJFMNg7vqJ
         v3pDIPx0GTeZaHEDrYOVayGlrQmsI6I7Ml7GkV9GKJ4U5nHfLp1F9F/xFZ2nLgL1bR+w
         oIgl6kXtQyQ2M6uYlX/DfLLogfymDxwUhaCeyn6oImM7+K3sxCC5YadL06UAgFSpM6HY
         gkXGPi5jF56//2AuZb+LiJqQrjuZhYkoyecbJOZmiCNxx+a3pj7VZykFg2kgORamsGPl
         AutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RnXREa8RVoocEwkNCkNI2GYWcey90wZ0QRnkNMZk7Pw=;
        b=TjLIuPzpzUoiFkZsPLKlgd2GLyaPCL6UkatxAJD1g0g2u8p+Ue2KFfCO9ftp02zfmb
         Kcw6TQlmb2h2USubavx6zHH5plg6WbPR2jzEXcUp/fS/yZFVxFaKPQEcDOkcluOeAqj3
         KHps1ihjb+zjLUk7fIgic/nYEKfUnEtJJm5pX0XAT/Xcryx9iFTKoFVH4UOAn90zxZjN
         lcapHNNtJ1nIa5cYDcjCXgi4SuCiqrfeEjBVCKivUi8SVU47eMLLs06a4sqwSK0FD/9i
         tyZu75lPGZRA4DkeddJOwD/UbNuNG6hGFGlbCBC8a0CbtVB/XwrZUxWIJVqa+sXQVvzl
         rNvA==
X-Gm-Message-State: APjAAAW5lGBKuG19E+qHrtfPbNKRbZLQt90++BxX0blE+tnQf3KJn4Lm
        JcePL+JW82rja6voplp4AreFBA==
X-Google-Smtp-Source: APXvYqzX8+W52dkJli/ZnL0t34Y35HCo4/iPhmXBio6LxASjFBjd1HvanzWcuqIMcwO4IbLuISw7tw==
X-Received: by 2002:ac8:47d5:: with SMTP id d21mr4032765qtr.360.1565108936528;
        Tue, 06 Aug 2019 09:28:56 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q17sm34048370qtl.13.2019.08.06.09.28.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 09:28:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 09/15] btrfs: export block group accounting helpers
Date:   Tue,  6 Aug 2019 12:28:31 -0400
Message-Id: <20190806162837.15840-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806162837.15840-1-josef@toxicpanda.com>
References: <20190806162837.15840-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Want to move these functions into block-group.c, so export them.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.h |  6 ++++++
 fs/btrfs/extent-tree.c | 21 ++++++++++-----------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index f23da9d82525..e17effab028f 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -193,6 +193,12 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache);
 int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans);
 int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans);
 int btrfs_setup_space_cache(struct btrfs_trans_handle *trans);
+int btrfs_update_block_group(struct btrfs_trans_handle *trans,
+			     u64 bytenr, u64 num_bytes, int alloc);
+int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
+			     u64 ram_bytes, u64 num_bytes, int delalloc);
+void btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
+			       u64 num_bytes, int delalloc);
 
 static inline int btrfs_block_group_cache_done(
 		struct btrfs_block_group_cache *cache)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7f65958efc40..6959debccd35 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2914,8 +2914,8 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	return ret;
 }
 
-static int update_block_group(struct btrfs_trans_handle *trans,
-			      u64 bytenr, u64 num_bytes, int alloc)
+int btrfs_update_block_group(struct btrfs_trans_handle *trans,
+			     u64 bytenr, u64 num_bytes, int alloc)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_block_group_cache *cache = NULL;
@@ -3215,8 +3215,8 @@ btrfs_inc_block_group_reservations(struct btrfs_block_group_cache *bg)
  * reservation and the block group has become read only we cannot make the
  * reservation and return -EAGAIN, otherwise this function always succeeds.
  */
-static int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
-				    u64 ram_bytes, u64 num_bytes, int delalloc)
+int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
+			     u64 ram_bytes, u64 num_bytes, int delalloc)
 {
 	struct btrfs_space_info *space_info = cache->space_info;
 	int ret = 0;
@@ -3249,9 +3249,8 @@ static int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
  * A and before transaction A commits you free that leaf, you call this with
  * reserve set to 0 in order to clear the reservation.
  */
-
-static void btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
-				      u64 num_bytes, int delalloc)
+void btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
+			       u64 num_bytes, int delalloc)
 {
 	struct btrfs_space_info *space_info = cache->space_info;
 
@@ -3824,7 +3823,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 
-		ret = update_block_group(trans, bytenr, num_bytes, 0);
+		ret = btrfs_update_block_group(trans, bytenr, num_bytes, 0);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out;
@@ -4904,7 +4903,7 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	ret = update_block_group(trans, ins->objectid, ins->offset, 1);
+	ret = btrfs_update_block_group(trans, ins->objectid, ins->offset, 1);
 	if (ret) { /* -ENOENT, logic error */
 		btrfs_err(fs_info, "update block group failed for %llu %llu",
 			ins->objectid, ins->offset);
@@ -4994,8 +4993,8 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	ret = update_block_group(trans, extent_key.objectid,
-				 fs_info->nodesize, 1);
+	ret = btrfs_update_block_group(trans, extent_key.objectid,
+				       fs_info->nodesize, 1);
 	if (ret) { /* -ENOENT, logic error */
 		btrfs_err(fs_info, "update block group failed for %llu %llu",
 			extent_key.objectid, extent_key.offset);
-- 
2.21.0

