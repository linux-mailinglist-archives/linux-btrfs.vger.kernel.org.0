Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B97109460
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfKYTrK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:47:10 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45693 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKYTrK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:47:10 -0500
Received: by mail-qv1-f67.google.com with SMTP id d12so4313410qvv.12
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=N9XQfNKUrr4KUDi52D3y8Z8sSeAmDjEppgNn+T9Ok6E=;
        b=a/MZzpjh6vgoto9MTLgY6lN0S34239gB5c25ZY0oOwi+Sxe99dRRDhmy4DHcnWhgw6
         5CyFkwaoz6oWHllU8G73Kl5Lc7WRz+nQZQ5ns7uDHjOuTy83n8uFMHviGrbcnzAcQHI6
         2bwL52Uf450RP32qAbIOuc/BLVqjt4kqlCGnpIm2YhKvaSZlZz1vF+RdF03y+paHCk9Q
         1PjRlqGoZdq+oRu1RTxHbsUQwovxIo+qPLnGnU4MY+rZXI9tR0n4/Dv0H9iSHAYJiNOs
         kjPoTBJ8FZXig4V5m8BP00gUy0Uw/LlErRWV3UVEjn3WNmHORRrJdPkgVeKmj/xQsBBg
         jMDw==
X-Gm-Message-State: APjAAAVP+TTnbTodptUXvqacl6mf8IKgBjNi74JDa8YN9TvBSwHqO2EV
        3ybbKbwh30wo4lBWfEBG3xA=
X-Google-Smtp-Source: APXvYqz4Om016St8yQ/zZbQUvhCfpw82Oe61Q3Pno59YmLwfrGKqk985Qq1YhoD8ddG8OKFJHumGNg==
X-Received: by 2002:a0c:ef48:: with SMTP id t8mr28829051qvs.38.1574711229258;
        Mon, 25 Nov 2019 11:47:09 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id o13sm4481033qto.96.2019.11.25.11.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 11:47:08 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 02/22] btrfs: rename DISCARD opt to DISCARD_SYNC
Date:   Mon, 25 Nov 2019 14:46:42 -0500
Message-Id: <13176a36da6ac927826120e01fc643e6ea55ab9d.1574709825.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
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
index 6934a5b8708f..6064be2d5556 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1363,7 +1363,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_unlock(&space_info->lock);
 
 		/* DISCARD can flip during remount */
-		trimming = btrfs_test_opt(fs_info, DISCARD);
+		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC);
 
 		/* Implicit trim during transaction commit. */
 		if (trimming)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b2e8fd8a8e59..8ac3b2deef4a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1170,7 +1170,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_FLUSHONCOMMIT       (1 << 7)
 #define BTRFS_MOUNT_SSD_SPREAD		(1 << 8)
 #define BTRFS_MOUNT_NOSSD		(1 << 9)
-#define BTRFS_MOUNT_DISCARD		(1 << 10)
+#define BTRFS_MOUNT_DISCARD_SYNC	(1 << 10)
 #define BTRFS_MOUNT_FORCE_COMPRESS      (1 << 11)
 #define BTRFS_MOUNT_SPACE_CACHE		(1 << 12)
 #define BTRFS_MOUNT_CLEAR_CACHE		(1 << 13)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 18df434bfe52..f979f4c1a385 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2923,7 +2923,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 			break;
 		}
 
-		if (btrfs_test_opt(fs_info, DISCARD))
+		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
 			ret = btrfs_discard_extent(fs_info, start,
 						   end + 1 - start, NULL);
 
@@ -4181,7 +4181,7 @@ static int __btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 	if (pin)
 		pin_down_extent(cache, start, len, 1);
 	else {
-		if (btrfs_test_opt(fs_info, DISCARD))
+		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
 			ret = btrfs_discard_extent(fs_info, start, len, NULL);
 		btrfs_add_free_space(cache, start, len);
 		btrfs_free_reserved_bytes(cache, len, delalloc);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a98c3c71fc54..f131fb9f0f69 100644
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

