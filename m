Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10129DC1F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 11:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407911AbfJRJ6p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 05:58:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:40258 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403993AbfJRJ6l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 05:58:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A369B586;
        Fri, 18 Oct 2019 09:58:40 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 4/4] btrfs: remove pointless indentation in btrfs_read_sys_array()
Date:   Fri, 18 Oct 2019 11:58:23 +0200
Message-Id: <20191018095823.15282-5-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191018095823.15282-1-jthumshirn@suse.de>
References: <20191018095823.15282-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of checking if we've read a BTRFS_CHUNK_ITEM_KEY from disk and
then process it we could just bail out early if the read disk key wasn't a
BTRFS_CHUNK_ITEM_KEY.

This removes a level of indentation and makes the code nicer to read.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/volumes.c | 71 +++++++++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4c630356bb30..08a2d1f6ec41 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6805,48 +6805,49 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 		sb_array_offset += len;
 		cur_offset += len;
 
-		if (key.type == BTRFS_CHUNK_ITEM_KEY) {
-			chunk = (struct btrfs_chunk *)sb_array_offset;
-			/*
-			 * At least one btrfs_chunk with one stripe must be
-			 * present, exact stripe count check comes afterwards
-			 */
-			len = btrfs_chunk_item_size(1);
-			if (cur_offset + len > array_size)
-				goto out_short_read;
-
-			num_stripes = btrfs_chunk_num_stripes(sb, chunk);
-			if (!num_stripes) {
-				btrfs_err(fs_info,
-					"invalid number of stripes %u in sys_array at offset %u",
-					num_stripes, cur_offset);
-				ret = -EIO;
-				break;
-			}
+		if (key.type != BTRFS_CHUNK_ITEM_KEY) {
+			btrfs_err(fs_info,
+			    "unexpected item type %u in sys_array at offset %u",
+				  (u32)key.type, cur_offset);
+			ret = -EIO;
+			break;
+		}
 
-			type = btrfs_chunk_type(sb, chunk);
-			if ((type & BTRFS_BLOCK_GROUP_SYSTEM) == 0) {
-				btrfs_err(fs_info,
-			    "invalid chunk type %llu in sys_array at offset %u",
-					type, cur_offset);
-				ret = -EIO;
-				break;
-			}
+		chunk = (struct btrfs_chunk *)sb_array_offset;
+		/*
+		 * At least one btrfs_chunk with one stripe must be
+		 * present, exact stripe count check comes afterwards
+		 */
+		len = btrfs_chunk_item_size(1);
+		if (cur_offset + len > array_size)
+			goto out_short_read;
 
-			len = btrfs_chunk_item_size(num_stripes);
-			if (cur_offset + len > array_size)
-				goto out_short_read;
+		num_stripes = btrfs_chunk_num_stripes(sb, chunk);
+		if (!num_stripes) {
+			btrfs_err(fs_info,
+				  "invalid number of stripes %u in sys_array at offset %u",
+				  num_stripes, cur_offset);
+			ret = -EIO;
+			break;
+		}
 
-			ret = read_one_chunk(&key, sb, chunk);
-			if (ret)
-				break;
-		} else {
+		type = btrfs_chunk_type(sb, chunk);
+		if ((type & BTRFS_BLOCK_GROUP_SYSTEM) == 0) {
 			btrfs_err(fs_info,
-			    "unexpected item type %u in sys_array at offset %u",
-				  (u32)key.type, cur_offset);
+				  "invalid chunk type %llu in sys_array at offset %u",
+				  type, cur_offset);
 			ret = -EIO;
 			break;
 		}
+
+		len = btrfs_chunk_item_size(num_stripes);
+		if (cur_offset + len > array_size)
+			goto out_short_read;
+
+		ret = read_one_chunk(&key, sb, chunk);
+		if (ret)
+			break;
+
 		array_ptr += len;
 		sb_array_offset += len;
 		cur_offset += len;
-- 
2.16.4

