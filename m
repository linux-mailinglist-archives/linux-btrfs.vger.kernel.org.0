Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D71F2CED43
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfJGUR4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:17:56 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41014 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGUR4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:17:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id p10so13890234qkg.8
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=mX/ZOP+xwUvm9kyq1kt0/WmL3ZO5jZwqkXSGicUVRV8=;
        b=cBmwJ2z/fmLfVCD7/WHymKefAjZdUdi0kG9suI1DkRKIKN5JU6523lAT+ezlZcDMP/
         tj/IVWsBimepkLejQ4vNSrdV03+xB0O26vMX4atZJdNCXiXlglTR78+3V7rvmZp+37ep
         qEkpt4GryRZIEqMfAlxdZ5iL6l/OshhoiMM2gAj9CrDogbitNfw2c1qQcBdSVQIYVc9M
         19RDeP54jc2WF9XU/Mmvu6OCIq9zeO3jrsNPWSamfUprApkupR1xAC3a18UtR4Ps6nn9
         AZyjWPAd9EUMgSpAE4I/UMuVE5z2e9rXVLAVrvXC4jKkSq8KdsXATfECFbOoAjwlFTRv
         muiw==
X-Gm-Message-State: APjAAAUwiTJmVZzRetfThgrHDTG8jjBhNgs4ow8qUSpPlh1OxeUmgmmh
        DQSZej10Tzkx+FhnAlyvo9I=
X-Google-Smtp-Source: APXvYqzuLSnTsLJ3M9qPPPG7j0k3xqDxttSZjK2K5C31YnH2SGjjb8wsQrBYA0rE8fA+P7/8BF5BKg==
X-Received: by 2002:a37:67c6:: with SMTP id b189mr24773475qkc.472.1570479475482;
        Mon, 07 Oct 2019 13:17:55 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm6904005qtm.42.2019.10.07.13.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 13:17:54 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 02/19] btrfs: rename DISCARD opt to DISCARD_SYNC
Date:   Mon,  7 Oct 2019 16:17:33 -0400
Message-Id: <e2c7ca7b48bc3a5a219329f7d086ab1cfd7330a3.1570479299.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series introduces async discard which will use the flag
DISCARD_ASYNC, so rename the original flag to DISCARD_SYNC as it is
synchronously done in transaction commit.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
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

