Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4CDE26A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 00:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436899AbfJWWxW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 18:53:22 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38279 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436897AbfJWWxW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 18:53:22 -0400
Received: by mail-qk1-f196.google.com with SMTP id p4so21509905qkf.5
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 15:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=nzwN4IK5YKxmE037L+54s3sfbyFlSCFhP+t6D5sD1Rg=;
        b=PxoOFq06W5RbFhdVkc1RLAkSHvV8ZDcl/MsC74Ryc1PWEsDTb4P5zVGCbITgWM3d6E
         tEaY5tv337Uqvz+2OZkkq0dnIcGbt5cJGlPXVadu6Mh5HDzvbYdX6w96ujebyBRuDaQz
         3Ybbo/Xp7+E7FL5W+58eucTRrtRroEgWqZJ4N5AgBTtVgVn+Xok+3CQ2Nu04SpBLe5SC
         iwI0OHUR6bejnLvRqmD8WUVN+pIZXobREVWIaxWkZazSCDl73IioAokACKC/+rJDgX/g
         hSZA5m7CAPsTk+9tGfblQJ0pMbjwgZ1AoFV8GK+FaB2sU9MiIJUV3AYuursewWe8TJYK
         AXhA==
X-Gm-Message-State: APjAAAWAhf3AoIM2fkRSyjbNMgMNUF8ZoszS8sVMCUWcBzjp8scc8ZnK
        tAowxg4bNGRO1J/8D2RoYNc=
X-Google-Smtp-Source: APXvYqxLKDgHA0v29WaQI+rqVeBpOByKF/Av4nlzGGzGLnFcn7/UzZsFIPziIN/U6oiXHCEzWtdbig==
X-Received: by 2002:a37:a892:: with SMTP id r140mr7459173qke.178.1571871201170;
        Wed, 23 Oct 2019 15:53:21 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j4sm11767542qkf.116.2019.10.23.15.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 15:53:20 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 02/22] btrfs: rename DISCARD opt to DISCARD_SYNC
Date:   Wed, 23 Oct 2019 18:52:56 -0400
Message-Id: <6c7c82ffdc8bcf0fbc1aa940542d8c0abc782629.1571865774.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series introduces async discard which will use the flag
DISCARD_ASYNC, so rename the original flag to DISCARD_SYNC as it is
synchronously done in transaction commit.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/block-group.c | 2 +-
 fs/btrfs/ctree.h       | 2 +-
 fs/btrfs/extent-tree.c | 4 ++--
 fs/btrfs/super.c       | 8 ++++----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index bf7e3f23bba7..afe86028246a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1365,7 +1365,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_unlock(&space_info->lock);
 
 		/* DISCARD can flip during remount */
-		trimming = btrfs_test_opt(fs_info, DISCARD);
+		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC);
 
 		/* Implicit trim during transaction commit. */
 		if (trimming)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 19d669d12ca1..1877586576aa 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1171,7 +1171,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_FLUSHONCOMMIT       (1 << 7)
 #define BTRFS_MOUNT_SSD_SPREAD		(1 << 8)
 #define BTRFS_MOUNT_NOSSD		(1 << 9)
-#define BTRFS_MOUNT_DISCARD		(1 << 10)
+#define BTRFS_MOUNT_DISCARD_SYNC	(1 << 10)
 #define BTRFS_MOUNT_FORCE_COMPRESS      (1 << 11)
 #define BTRFS_MOUNT_SPACE_CACHE		(1 << 12)
 #define BTRFS_MOUNT_CLEAR_CACHE		(1 << 13)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 49cb26fa7c63..77a5904756c5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2903,7 +2903,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 			break;
 		}
 
-		if (btrfs_test_opt(fs_info, DISCARD))
+		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
 			ret = btrfs_discard_extent(fs_info, start,
 						   end + 1 - start, NULL);
 
@@ -4146,7 +4146,7 @@ static int __btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 	if (pin)
 		pin_down_extent(cache, start, len, 1);
 	else {
-		if (btrfs_test_opt(fs_info, DISCARD))
+		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
 			ret = btrfs_discard_extent(fs_info, start, len, NULL);
 		btrfs_add_free_space(cache, start, len);
 		btrfs_free_reserved_bytes(cache, len, delalloc);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1b151af25772..a02fece949cb 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -695,11 +695,11 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 				   info->metadata_ratio);
 			break;
 		case Opt_discard:
-			btrfs_set_and_info(info, DISCARD,
-					   "turning on discard");
+			btrfs_set_and_info(info, DISCARD_SYNC,
+					   "turning on sync discard");
 			break;
 		case Opt_nodiscard:
-			btrfs_clear_and_info(info, DISCARD,
+			btrfs_clear_and_info(info, DISCARD_SYNC,
 					     "turning off discard");
 			break;
 		case Opt_space_cache:
@@ -1322,7 +1322,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",nologreplay");
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
-	if (btrfs_test_opt(info, DISCARD))
+	if (btrfs_test_opt(info, DISCARD_SYNC))
 		seq_puts(seq, ",discard");
 	if (!(info->sb->s_flags & SB_POSIXACL))
 		seq_puts(seq, ",noacl");
-- 
2.17.1

