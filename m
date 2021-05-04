Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AC13725CD
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 May 2021 08:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhEDG0b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 May 2021 02:26:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:50002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229773AbhEDG0b (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 May 2021 02:26:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620109536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCJKM2so6H8ZM5ZlrYUoneYOfLoDK1Ni16iBDweOlKk=;
        b=AaEGJtoP5vM41PjkYIumiz+Wb31rD+DfkEqVP8MqbV7SOdkbtoSQOiJI6EsRmuqWKmpCcH
        h2Xe6b5QV8au3+xJh+AnRyQuXmrNXzABfgKX/8CBSrttskTEsTdNcPkbLI08QNYJJgDaw1
        ykm2z1kyVhy/I5Be9KZBvp5zml5soz4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20560AF1E
        for <linux-btrfs@vger.kernel.org>; Tue,  4 May 2021 06:25:36 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs-progs: check/lowmem: detect and report mixed inline and regular extents properly
Date:   Tue,  4 May 2021 14:25:24 +0800
Message-Id: <20210504062525.152540-4-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210504062525.152540-1-wqu@suse.com>
References: <20210504062525.152540-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When lowmem mode check is executed on a filesystem with mixed inline and
regular extent, it reports the error as file extent gap:

  [4/7] checking fs roots
  ERROR: root 5 EXTENT_DATA[257 4096] gap exists, expected: EXTENT_DATA[257 707]
  ERROR: errors found in fs roots
  found 135168 bytes used, error(s) found

Not detecting the mixed extent types.

[CAUSE]
The offending fs has the following data extents:

        item 9 key (257 INODE_REF 256) itemoff 15703 itemsize 14
                index 2 namelen 4 name: file
        item 10 key (257 EXTENT_DATA 0) itemoff 14975 itemsize 728
                generation 7 type 0 (inline)
                inline extent data size 707 ram_bytes 707 compression 0 (none)
        item 11 key (257 EXTENT_DATA 4096) itemoff 14922 itemsize 53
                generation 7 type 2 (prealloc)
                prealloc data disk byte 102457344 nr 4096
                prealloc data offset 0 nr 4096

The mixed extent type error is obvious, but for inline extent,
check_file_extent_inline() will increase the extent_end by inline size.

However for such mixed case, the regular extent will only start
sectorsize, leaving lowmem check only to report a hole gap.

[FIX]
This patch will fix it by:
- Introduce @found_inline parameter to detect mixed extent types
- Increase @end by sectorsize for check_file_extent_inline()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 2531fde858b2..ed71833eb21e 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2003,7 +2003,12 @@ static int check_file_extent_inline(struct btrfs_root *root,
 			}
 		}
 	}
-	*end += extent_num_bytes;
+	/*
+	 * For inline extent, we expect no more extents. But if there are
+	 * regular extents after inlined extent, they should start at
+	 * sectorsize, not the inline size.
+	 */
+	*end += root->fs_info->sectorsize;
 	*size += extent_num_bytes;
 
 	return err;
@@ -2022,7 +2027,7 @@ static int check_file_extent_inline(struct btrfs_root *root,
  */
 static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 			     unsigned int nodatasum, u64 isize, u64 *size,
-			     u64 *end)
+			     u64 *end, bool *found_inline)
 {
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_key fkey;
@@ -2058,9 +2063,25 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 	}
 
 	/* Check inline extent */
-	if (extent_type == BTRFS_FILE_EXTENT_INLINE)
+	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
+		*found_inline = true;
 		return check_file_extent_inline(root, path, size, end);
+	}
 
+	/*
+	 * Here we hit a regular/prealloc file extent, if this inode already
+	 * has an inline extent, we have mixed inline and regular extents.
+	 */
+	if (*found_inline) {
+		err |= FILE_EXTENT_ERROR;
+		error(
+		"root %llu inode %llu has mixed inline and regular extents",
+		      root->objectid, fkey.objectid);
+		/*
+		 * We still want to continue checking, as mixed inline and
+		 * regular is just a minor problem.
+		 */
+	}
 	/* Check REG_EXTENT/PREALLOC_EXTENT */
 	gen = btrfs_file_extent_generation(node, fi);
 	disk_bytenr = btrfs_file_extent_disk_bytenr(node, fi);
@@ -2606,6 +2627,7 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 	int slot;
 	int ret;
 	int err = 0;
+	bool found_inline = false;
 	char namebuf[BTRFS_NAME_LEN] = {0};
 	u32 name_len = 0;
 
@@ -2726,7 +2748,8 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 					key.offset);
 			}
 			ret = check_file_extent(root, path, nodatasum, isize,
-						&extent_size, &extent_end);
+						&extent_size, &extent_end,
+						&found_inline);
 			err |= ret;
 			break;
 		case BTRFS_XATTR_ITEM_KEY:
-- 
2.31.1

