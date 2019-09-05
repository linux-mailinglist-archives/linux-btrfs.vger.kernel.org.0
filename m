Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02FD1A9C69
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 09:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfIEH6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Sep 2019 03:58:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:47970 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731660AbfIEH6L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Sep 2019 03:58:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B1E0EAD6B
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2019 07:58:10 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/6] btrfs-progs: check: Export btrfs_type_to_imode
Date:   Thu,  5 Sep 2019 15:57:55 +0800
Message-Id: <20190905075800.1633-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190905075800.1633-1-wqu@suse.com>
References: <20190905075800.1633-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function will be later used by common mode code, so export it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c        | 15 ---------------
 check/mode-common.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/check/main.c b/check/main.c
index 2e16b4e6f05b..902279740589 100644
--- a/check/main.c
+++ b/check/main.c
@@ -2448,21 +2448,6 @@ out:
 	return ret;
 }
 
-static u32 btrfs_type_to_imode(u8 type)
-{
-	static u32 imode_by_btrfs_type[] = {
-		[BTRFS_FT_REG_FILE]	= S_IFREG,
-		[BTRFS_FT_DIR]		= S_IFDIR,
-		[BTRFS_FT_CHRDEV]	= S_IFCHR,
-		[BTRFS_FT_BLKDEV]	= S_IFBLK,
-		[BTRFS_FT_FIFO]		= S_IFIFO,
-		[BTRFS_FT_SOCK]		= S_IFSOCK,
-		[BTRFS_FT_SYMLINK]	= S_IFLNK,
-	};
-
-	return imode_by_btrfs_type[(type)];
-}
-
 static int repair_inode_no_item(struct btrfs_trans_handle *trans,
 				struct btrfs_root *root,
 				struct btrfs_path *path,
diff --git a/check/mode-common.h b/check/mode-common.h
index 161b84a8deb0..6c8d6d7578a6 100644
--- a/check/mode-common.h
+++ b/check/mode-common.h
@@ -156,4 +156,19 @@ static inline bool is_valid_imode(u32 imode)
 }
 
 int recow_extent_buffer(struct btrfs_root *root, struct extent_buffer *eb);
+
+static inline u32 btrfs_type_to_imode(u8 type)
+{
+	static u32 imode_by_btrfs_type[] = {
+		[BTRFS_FT_REG_FILE]	= S_IFREG,
+		[BTRFS_FT_DIR]		= S_IFDIR,
+		[BTRFS_FT_CHRDEV]	= S_IFCHR,
+		[BTRFS_FT_BLKDEV]	= S_IFBLK,
+		[BTRFS_FT_FIFO]		= S_IFIFO,
+		[BTRFS_FT_SOCK]		= S_IFSOCK,
+		[BTRFS_FT_SYMLINK]	= S_IFLNK,
+	};
+
+	return imode_by_btrfs_type[(type)];
+}
 #endif
-- 
2.23.0

