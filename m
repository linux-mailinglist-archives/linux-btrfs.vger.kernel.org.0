Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCFA11761A
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 20:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLITqN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 14:46:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44521 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLITqN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 14:46:13 -0500
Received: by mail-pf1-f195.google.com with SMTP id d199so7742285pfd.11
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 11:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=oSPwiLMsUvlEQTTA+9Mu0hqDV7OMwIBvhZSpCKN33rU=;
        b=iaGOyeJStpj4qLZ7WrZC5HMbZSG3oK2NnFona9Z1EHppf83jV3N5kRGXNBtgWBtMf6
         q4cOwbPBLA3pAsB8qoNdPyYVTAV2EN7Yl1IBnE9WLbtvTEj3B4nXw9uSnFS3l18O2Zu0
         xtqnxt+wrvT/enT7vMwaG3b6nw67QXbHUlQHV2M5/YRn1iEicHz+JMWjxW2lh+7pyBF2
         g+X1rNrFRMN+PKGZ6ILZs1SeFJQvz8hB6Gll5kpsCI3Vsz4VFc1xySct59sDclLF/ELb
         EKVt8jdohxeLa/4haholKSodBlMP6vmZ53Z8sVpnNC2wK2xscPh2VF4wVaIOOoHAgTw6
         fhVQ==
X-Gm-Message-State: APjAAAWYEir3k6TrsTEqJd7mPGJnuHFiIVWiedGxuPrZmxozf+r4CD4/
        EfyTrzoHDT1JEtale5X70wY=
X-Google-Smtp-Source: APXvYqz+tO92/pXr5dXzE60OJNqDPi1YHHBlmL11YrJbgk+SWDEPpMFp8DoYJQDGiEXl5lcUszv5Aw==
X-Received: by 2002:a62:7711:: with SMTP id s17mr22980097pfc.88.1575920772924;
        Mon, 09 Dec 2019 11:46:12 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id b190sm282956pfg.66.2019.12.09.11.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 11:46:12 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 02/22] btrfs: rename DISCARD opt to DISCARD_SYNC
Date:   Mon,  9 Dec 2019 11:45:47 -0800
Message-Id: <d863e6b6b3025dfaa17ac051288a05a6f0470bd9.1575919745.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
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
 fs/btrfs/extent-tree.c | 2 +-
 fs/btrfs/inode.c       | 2 +-
 fs/btrfs/super.c       | 8 ++++----
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 66fa39632cde..be1938dc94fd 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1349,7 +1349,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_unlock(&space_info->lock);
 
 		/* DISCARD can flip during remount */
-		trimming = btrfs_test_opt(fs_info, DISCARD);
+		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC);
 
 		/* Implicit trim during transaction commit. */
 		if (trimming)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ea49e4b52cd2..51a303441802 100644
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
index 2a7dff22c3b7..9c8ff4307b7c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2923,7 +2923,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 			break;
 		}
 
-		if (btrfs_test_opt(fs_info, DISCARD))
+		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
 			ret = btrfs_discard_extent(fs_info, start,
 						   end + 1 - start, NULL);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1ab13943cdf0..03629edca205 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3250,7 +3250,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		    clear_reserved_extent &&
 		    !test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags) &&
 		    !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags)) {
-			if (ret && btrfs_test_opt(fs_info, DISCARD))
+			if (ret && btrfs_test_opt(fs_info, DISCARD_SYNC))
 				btrfs_discard_extent(fs_info,
 						ordered_extent->start,
 						ordered_extent->disk_len, NULL);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f452a94abdc3..08ac6a7a67f0 100644
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

