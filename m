Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67EAF104614
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 22:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKTVva (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 16:51:30 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39421 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfKTVva (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 16:51:30 -0500
Received: by mail-qt1-f194.google.com with SMTP id t8so1267640qtc.6
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 13:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vVFM0CGUjTXwEfXZV7LYlw7CpQh9XPkzU2+n70imR/Y=;
        b=ZiqT8SywEnZ/8XCnSAQ2TD0B+NCZDLJ7+miZnZlYMJuStA3oFInmYbMI79+/gVAHIm
         XtBppaLRMS9upMvrEAvsg+0EmcED4ijxY53Gkjtz0H9ldkihF1g6zDwntwz/oazdmytQ
         41ae80ZFadzMph/d4i+jL7TYVV28WRRwrakWTzylRkf+4gYbN/s+OMESgkj/Sm7qRKQ8
         ncH9u4opuYXUv1J7N17tHVoNXpeTyzE4VviFBMd7HevsbKKKLGG5GBTpSTQuET4qq7QN
         S3OAJFGpkHjFGLmOSe1WL6mX/Wl3bCAEjg/Ylhsh9KB6PxpXEbmi+L4GAH9G/U9h72Wy
         Nx/Q==
X-Gm-Message-State: APjAAAXxsVyH1Sh0c+i5e/CEpJDfr7TKizV/NuVLh5doK3Y/MWaAk4ll
        Ux2V4GeTO8zgnYJkAObIxjE=
X-Google-Smtp-Source: APXvYqzSYvidnJcVBXKlcsAixuzB++mQNFj7OP3RJDhgPBOgCthfdCk07zycwxCA1J/HOYpWjxBTcw==
X-Received: by 2002:aed:37c6:: with SMTP id j64mr5099311qtb.364.1574286689323;
        Wed, 20 Nov 2019 13:51:29 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id t16sm303820qkm.73.2019.11.20.13.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 13:51:28 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 02/22] btrfs: rename DISCARD opt to DISCARD_SYNC
Date:   Wed, 20 Nov 2019 16:51:01 -0500
Message-Id: <12065da7887aea2c53ae7b0faa324fef22f3038a.1574282259.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
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
index 153f71a5bba9..de25648d972d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2923,7 +2923,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 			break;
 		}
 
-		if (btrfs_test_opt(fs_info, DISCARD))
+		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
 			ret = btrfs_discard_extent(fs_info, start,
 						   end + 1 - start, NULL);
 
@@ -4165,7 +4165,7 @@ static int __btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
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

