Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 533DF163D66
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 08:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgBSHEw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 02:04:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:54780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgBSHEw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 02:04:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D1F96ACAE;
        Wed, 19 Feb 2020 07:04:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Samir Benmendil <me@rmz.io>
Subject: [PATCH 1/2] btrfs-progs: check: Detect file extent end overflow
Date:   Wed, 19 Feb 2020 15:04:42 +0800
Message-Id: <20200219070443.43189-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a report about tree-checker rejecting some leaves due to bad
EXTENT_DATA.

The offending EXTENT_DATA looks like:
	item 72 key (1359622 EXTENT_DATA 475136) itemoff 11140 itemsize 53
		generation 954719 type 1 (regular)
		extent data disk byte 0 nr 0
		extent data offset 0 nr 18446744073709486080 ram 18446744073709486080
		extent compression 0 (none)

Add such check to both original and lowmem mode to detect such problem.

Reported-by: Samir Benmendil <me@rmz.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c          | 4 ++++
 check/mode-common.h   | 7 +++++++
 check/mode-lowmem.c   | 7 +++++++
 check/mode-original.h | 1 +
 4 files changed, 19 insertions(+)

diff --git a/check/main.c b/check/main.c
index d02dd1636852..f71bf4f74129 100644
--- a/check/main.c
+++ b/check/main.c
@@ -597,6 +597,8 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
 		fprintf(stderr, ", odd file extent");
 	if (errors & I_ERR_BAD_FILE_EXTENT)
 		fprintf(stderr, ", bad file extent");
+	if (errors & I_ERR_FILE_EXTENT_OVERFLOW)
+		fprintf(stderr, ", file extent end overflow");
 	if (errors & I_ERR_FILE_EXTENT_OVERLAP)
 		fprintf(stderr, ", file extent overlap");
 	if (errors & I_ERR_FILE_EXTENT_TOO_LARGE)
@@ -1595,6 +1597,8 @@ static int process_file_extent(struct btrfs_root *root,
 		num_bytes = btrfs_file_extent_num_bytes(eb, fi);
 		disk_bytenr = btrfs_file_extent_disk_bytenr(eb, fi);
 		extent_offset = btrfs_file_extent_offset(eb, fi);
+		if (u64_add_overflow(key->offset, num_bytes))
+			rec->errors |= I_ERR_FILE_EXTENT_OVERFLOW;
 		if (num_bytes == 0 || (num_bytes & mask))
 			rec->errors |= I_ERR_BAD_FILE_EXTENT;
 		if (num_bytes + extent_offset >
diff --git a/check/mode-common.h b/check/mode-common.h
index edf9257edaf0..daa5741e1d67 100644
--- a/check/mode-common.h
+++ b/check/mode-common.h
@@ -173,4 +173,11 @@ static inline u32 btrfs_type_to_imode(u8 type)
 
 	return imode_by_btrfs_type[(type)];
 }
+
+static inline bool u64_add_overflow(u64 a, u64 b)
+{
+	if (a > (u64)-1 - b)
+		return true;
+	return false;
+}
 #endif
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 630fabf66919..d257a44f3086 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2085,6 +2085,13 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 		err |= INVALID_GENERATION;
 	}
 
+	/* Extent end shouldn't overflow */
+	if (u64_add_overflow(fkey.offset, extent_num_bytes)) {
+		error(
+	"file extent end over flow, file offset %llu extent num bytes %llu",
+			fkey.offset, extent_num_bytes);
+		err |= FILE_EXTENT_ERROR;
+	}
 	/*
 	 * Check EXTENT_DATA csum
 	 *
diff --git a/check/mode-original.h b/check/mode-original.h
index b075a95c9757..07d741f4a1b5 100644
--- a/check/mode-original.h
+++ b/check/mode-original.h
@@ -186,6 +186,7 @@ struct unaligned_extent_rec_t {
 #define I_ERR_MISMATCH_DIR_HASH		(1 << 18)
 #define I_ERR_INVALID_IMODE		(1 << 19)
 #define I_ERR_INVALID_GEN		(1 << 20)
+#define I_ERR_FILE_EXTENT_OVERFLOW	(1 << 21)
 
 struct inode_record {
 	struct list_head backrefs;
-- 
2.25.0

