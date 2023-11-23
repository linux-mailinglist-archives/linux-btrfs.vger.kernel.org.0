Return-Path: <linux-btrfs+bounces-324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA127F634C
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 16:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F028B21777
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 15:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B033E490;
	Thu, 23 Nov 2023 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XdqnoFa6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BC2D53;
	Thu, 23 Nov 2023 07:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700754486; x=1732290486;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Iv2Qzs4D9MzjAZ/+msRXyW+jC+y0zttCg1ew3aqF+2U=;
  b=XdqnoFa6SrYGCG6WtVw4QcggNxU+Zqsb1fSRmWEMaIT7CCW389TDj9c7
   sM8y36pNpBLGE0eSozRH1dLlSotoAZVGxcah6XIdvL/BEJqyjuOx8tn5F
   /3sB501+EVDpZuZ3nPiizqCsW15FKixmYsNcs4e1LEVXnbsvGYynx/Wwx
   avQSLgqzSYejdTwf5sZ2U8qqH6qcilIFPqtmQ6Cxn5rb1YAnOvf06/KNY
   TC+ANC7BZkm3AhBnu7d2lRHsePbtTBbA9gUrjkQv7BKGxcxXHrniDkP/u
   ewq+jIuqHoco1/WE6CVFbfpWppc90hTc/l8IfT3b2iNFu3uqtA84LNb2V
   A==;
X-CSE-ConnectionGUID: Vhq+0gP4QhqPhldSfqOCjw==
X-CSE-MsgGUID: OusHH5ePR4udevI2Xk1IYA==
X-IronPort-AV: E=Sophos;i="6.04,222,1695657600"; 
   d="scan'208";a="3129205"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Nov 2023 23:47:32 +0800
IronPort-SDR: yNSpfGHBkWSFijbzS2oZZ9uxivi5cNW88Z1XYcrF9DyAM3uh1j5tj4H6jq0ZRB9k/WjTKexBOH
 +L8NfEElF5MIirn1hD0LmhywCRXdOsiDH4rTUqsz9UpzL22A8r3TlXsg0kvQc3vdn8h9QMPg88
 Mr84cqxgvDgycivn+XuVNHAK08ymayVdspbhVrLZNjCESvd5r/s7TM8tjiw/vtfy0x9C7Tumsq
 +LSG8JT2/10znpBImqrjYDN+o1IssTrYHiWOkwjjyCPz6hSgb7mOVFTuqrRVT0+j37x3fEnSQy
 1Xo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2023 06:58:48 -0800
IronPort-SDR: 1PUIqR2s/9Ebt5mkbwQHyzg38pV/M8VUbJyDLr0N/g57npTB6w5L+mfhlIOI/ptILjgzxWhZzh
 DxBhermHVSngyJ+gAVltCBd6X6V9rIbOqhQoWtAyx4WnoMjAGVC/ewvGltK03WQxYRxaSbOvAo
 m0zwViSajrK7JnP8VvmfWp/q1A1tHYvhaxHSSxNwupgTO7pXN+hmE4I7VGy+BSvN9qLoCqiJLE
 TUdlkbxGh1WU8+z0wVkaOOAUkdByLZZ2iDEagu8Ud00+E3GUTvo5mZk1m5vHwB0OyVwcBBkTwY
 +rE=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2023 07:47:31 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 23 Nov 2023 07:47:19 -0800
Subject: [PATCH v2 5/5] btrfs: reflow btrfs_free_tree_block
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-josef-generic-163-v2-5-ed1a79a8e51e@wdc.com>
References: <20231123-josef-generic-163-v2-0-ed1a79a8e51e@wdc.com>
In-Reply-To: <20231123-josef-generic-163-v2-0-ed1a79a8e51e@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700754443; l=4954;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=Iv2Qzs4D9MzjAZ/+msRXyW+jC+y0zttCg1ew3aqF+2U=;
 b=wBKec1gxRq/i9SilagPHNs70jWLvaxWae6ekUc2QGDkIjfdCvJRtWv2CFHXJdevEZTz4yce1d
 bFonXlHMBy+CsXhi6FcwJXSE5yrygMMK8EjIGN7QtY1j23VdHUsyt16
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Reflow btrfs_free_tree_block() so that there is one level of indentation
needed.

This patch has no functional changes.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c | 97 +++++++++++++++++++++++++-------------------------
 1 file changed, 49 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4044102271e9..093aaf7aeb3a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3426,6 +3426,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_ref generic_ref = { 0 };
+	struct btrfs_block_group *cache;
 	int ret;
 
 	btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
@@ -3439,64 +3440,64 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 		BUG_ON(ret); /* -ENOMEM */
 	}
 
-	if (last_ref && btrfs_header_generation(buf) == trans->transid) {
-		struct btrfs_block_group *cache;
-		bool must_pin = false;
-
-		if (root_id != BTRFS_TREE_LOG_OBJECTID) {
-			ret = check_ref_cleanup(trans, buf->start);
-			if (!ret)
-				goto out;
-		}
+	if (!last_ref)
+		return;
 
-		cache = btrfs_lookup_block_group(fs_info, buf->start);
+	if (btrfs_header_generation(buf) != trans->transid)
+		goto out;
 
-		if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
-			pin_down_extent(trans, cache, buf->start, buf->len, 1);
-			btrfs_put_block_group(cache);
+	if (root_id != BTRFS_TREE_LOG_OBJECTID) {
+		ret = check_ref_cleanup(trans, buf->start);
+		if (!ret)
 			goto out;
-		}
+	}
 
-		/*
-		 * If there are tree mod log users we may have recorded mod log
-		 * operations for this node.  If we re-allocate this node we
-		 * could replay operations on this node that happened when it
-		 * existed in a completely different root.  For example if it
-		 * was part of root A, then was reallocated to root B, and we
-		 * are doing a btrfs_old_search_slot(root b), we could replay
-		 * operations that happened when the block was part of root A,
-		 * giving us an inconsistent view of the btree.
-		 *
-		 * We are safe from races here because at this point no other
-		 * node or root points to this extent buffer, so if after this
-		 * check a new tree mod log user joins we will not have an
-		 * existing log of operations on this node that we have to
-		 * contend with.
-		 */
-		if (test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags))
-			must_pin = true;
+	cache = btrfs_lookup_block_group(fs_info, buf->start);
 
-		if (must_pin || btrfs_is_zoned(fs_info)) {
-			pin_down_extent(trans, cache, buf->start, buf->len, 1);
-			btrfs_put_block_group(cache);
-			goto out;
-		}
+	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
+		pin_down_extent(trans, cache, buf->start, buf->len, 1);
+		btrfs_put_block_group(cache);
+		goto out;
+	}
 
-		WARN_ON(test_bit(EXTENT_BUFFER_DIRTY, &buf->bflags));
+	/*
+	 * If there are tree mod log users we may have recorded mod log
+	 * operations for this node.  If we re-allocate this node we
+	 * could replay operations on this node that happened when it
+	 * existed in a completely different root.  For example if it
+	 * was part of root A, then was reallocated to root B, and we
+	 * are doing a btrfs_old_search_slot(root b), we could replay
+	 * operations that happened when the block was part of root A,
+	 * giving us an inconsistent view of the btree.
+	 *
+	 * We are safe from races here because at this point no other
+	 * node or root points to this extent buffer, so if after this
+	 * check a new tree mod log user joins we will not have an
+	 * existing log of operations on this node that we have to
+	 * contend with.
+	 */
 
-		btrfs_add_free_space(cache, buf->start, buf->len);
-		btrfs_free_reserved_bytes(cache, buf->len, 0);
+	if (test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags)
+		     || btrfs_is_zoned(fs_info)) {
+		pin_down_extent(trans, cache, buf->start, buf->len, 1);
 		btrfs_put_block_group(cache);
-		trace_btrfs_reserved_extent_free(fs_info, buf->start, buf->len);
+		goto out;
 	}
+
+	WARN_ON(test_bit(EXTENT_BUFFER_DIRTY, &buf->bflags));
+
+	btrfs_add_free_space(cache, buf->start, buf->len);
+	btrfs_free_reserved_bytes(cache, buf->len, 0);
+	btrfs_put_block_group(cache);
+	trace_btrfs_reserved_extent_free(fs_info, buf->start, buf->len);
+
 out:
-	if (last_ref) {
-		/*
-		 * Deleting the buffer, clear the corrupt flag since it doesn't
-		 * matter anymore.
-		 */
-		clear_bit(EXTENT_BUFFER_CORRUPT, &buf->bflags);
-	}
+
+	/*
+	 * Deleting the buffer, clear the corrupt flag since it doesn't
+	 * matter anymore.
+	 */
+	clear_bit(EXTENT_BUFFER_CORRUPT, &buf->bflags);
 }
 
 /* Can return -ENOMEM */

-- 
2.41.0


