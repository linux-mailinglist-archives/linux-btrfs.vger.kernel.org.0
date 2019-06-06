Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C68A37272
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 13:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfFFLGj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 07:06:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:34874 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfFFLGj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jun 2019 07:06:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8CDAEAE54
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2019 11:06:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/9] btrfs-progs: image: Verify the superblock before restore
Date:   Thu,  6 Jun 2019 19:06:06 +0800
Message-Id: <20190606110611.27176-5-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110611.27176-1-wqu@suse.com>
References: <20190606110611.27176-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch will export disk-io.c::check_super() as btrfs_check_super()
and use it in btrfs-image for extra verification.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 disk-io.c    | 6 +++---
 disk-io.h    | 1 +
 image/main.c | 5 +++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/disk-io.c b/disk-io.c
index 151eb3b5..ffe4a8c5 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -1347,7 +1347,7 @@ struct btrfs_root *open_ctree_fd(int fp, const char *path, u64 sb_bytenr,
  * - number of devices   - something sane
  * - sys array size      - maximum
  */
-static int check_super(struct btrfs_super_block *sb, unsigned sbflags)
+int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 {
 	u8 result[BTRFS_CSUM_SIZE];
 	u32 crc;
@@ -1547,7 +1547,7 @@ int btrfs_read_dev_super(int fd, struct btrfs_super_block *sb, u64 sb_bytenr,
 		if (btrfs_super_bytenr(buf) != sb_bytenr)
 			return -EIO;
 
-		ret = check_super(buf, sbflags);
+		ret = btrfs_check_super(buf, sbflags);
 		if (ret < 0)
 			return ret;
 		memcpy(sb, buf, BTRFS_SUPER_INFO_SIZE);
@@ -1572,7 +1572,7 @@ int btrfs_read_dev_super(int fd, struct btrfs_super_block *sb, u64 sb_bytenr,
 		/* if magic is NULL, the device was removed */
 		if (btrfs_super_magic(buf) == 0 && i == 0)
 			break;
-		if (check_super(buf, sbflags))
+		if (btrfs_check_super(buf, sbflags))
 			continue;
 
 		if (!fsid_is_initialized) {
diff --git a/disk-io.h b/disk-io.h
index ddf3a380..c97aa234 100644
--- a/disk-io.h
+++ b/disk-io.h
@@ -171,6 +171,7 @@ static inline int close_ctree(struct btrfs_root *root)
 
 int write_all_supers(struct btrfs_fs_info *fs_info);
 int write_ctree_super(struct btrfs_trans_handle *trans);
+int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags);
 int btrfs_read_dev_super(int fd, struct btrfs_super_block *sb, u64 sb_bytenr,
 		unsigned sbflags);
 int btrfs_map_bh_to_logical(struct btrfs_root *root, struct extent_buffer *bh,
diff --git a/image/main.c b/image/main.c
index 80f09c21..0b7c8736 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2040,6 +2040,11 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 
 	pthread_mutex_lock(&mdres->mutex);
 	super = (struct btrfs_super_block *)buffer;
+	ret = btrfs_check_super(super, 0);
+	if (ret < 0) {
+		error("invalid superblock");
+		return ret;
+	}
 	chunk_root_bytenr = btrfs_super_chunk_root(super);
 	mdres->nodesize = btrfs_super_nodesize(super);
 	if (btrfs_super_incompat_flags(super) &
-- 
2.21.0

