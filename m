Return-Path: <linux-btrfs+bounces-258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C787F33D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 17:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25362B22338
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 16:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261A65B21E;
	Tue, 21 Nov 2023 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oD1XuMxl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FDDCB;
	Tue, 21 Nov 2023 08:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700584362; x=1732120362;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KYqF9Y5hRQDC61iuaRlo/mKWBf6FC4946cc3kDbAJmc=;
  b=oD1XuMxl2CvXEXzm4Aylf06lD7TVp70xA22QmDKQ+9pIGskW0vlIEuTS
   pZZXXp9QjQjFWxoNMHV+YUpuZZcvzPRB+Hs4ttTnzMcD1SvReUmeOCgYx
   b49OE1cMYTgnVrBsz0n8HBOLnVq6D+hbEZCOz0i6oi1b+/P1pT0a87Oub
   lUYPMwZtup+AYG1VT3PKSk2+wPEfYsZkUEfrjmNb4BCXWacXnAzqUrdiW
   af24ksLEvGqywpuUyrtOTO1MxRI+dkGmNdsKvBTAfwHEW0JHx3Win+wnR
   MLxLUON6jUElR0LdWV5+i8zGDeye9zAsZK5DJATrhTkoozCECtaEQOopf
   A==;
X-CSE-ConnectionGUID: ugCgiAD8QXWlw5+6DlZFsg==
X-CSE-MsgGUID: QJXf+cY3Q8OAyQwC/1SwFA==
X-IronPort-AV: E=Sophos;i="6.04,216,1695657600"; 
   d="scan'208";a="3076051"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2023 00:32:41 +0800
IronPort-SDR: j3l+E8rPcpsZUg/+pFEc3TAkRf+tmcAyBRYNx5XsLIV8rU6xGGVtUFfXiR0w12KVMRKPl1Jjbd
 Q/i0mvWHJUfdbOViDK+VP4QAQ1yErNGpMq0f4fmw+EIJEZsbOB9Dz+vmUqbLcyWAolVaLYASLj
 ZPaym0LGmQZRxfs7BIY13h0+k9WkQI6N1eCJsJOCDOO6YcrFiNBtERy/PmOVOnZm+vqvPusFAA
 7oBCspVk59ZXf31mIJKvC0lT53oRY0HbCDMrT4jRyXU5OY3zIx4lvV/EFALIjskv5cxZtEplQe
 oqc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2023 07:38:20 -0800
IronPort-SDR: ca2BAHrdk9ddzxV8YKca5R7ndER5uM47/utscY1m97ayjWTHF8noM5kSAjcshucyYxkcV3ar9A
 ueOz0/s9oYfylSYDx0q7PzepthzOG3ULzr8RJre3veOnMOzFa0IuWXxnaIqCOqYI2lM58+1LZ7
 usMEgLVkJ7BF4uhutJf0TDa1GlEo19VKhPLefsIaDnkLmcM9n6hs3rEz1cMrgh98qcMwdmCg67
 xToNewAOuNRwnLU1PV7KXHovu3x5Ul1oKbsKLeyZ1OPCFuR6oNKqYM2nhJ5b2YLhZ68bSR/Atb
 A+E=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Nov 2023 08:32:41 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 21 Nov 2023 08:32:34 -0800
Subject: [PATCH 5/5] btrfs: reflow btrfs_free_tree_block
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-josef-generic-163-v1-5-049e37185841@wdc.com>
References: <20231121-josef-generic-163-v1-0-049e37185841@wdc.com>
In-Reply-To: <20231121-josef-generic-163-v1-0-049e37185841@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700584354; l=4860;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=KYqF9Y5hRQDC61iuaRlo/mKWBf6FC4946cc3kDbAJmc=;
 b=wmuqCBrp/etRWMbyM6GgwtlfU9ST83Bn9NyF3BoTDRms6V2Z6xSEOFGRsRFmplvg4yHqXru2+
 X+4GWpr2gZiC2u/kworslxXGYqhqze4MdHgeIbchpvrAg67LolKQUBF
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Reflow btrfs_free_tree_block() so that there is one level of indentation
needed.

This patch has no functional changes.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c | 97 +++++++++++++++++++++++++-------------------------
 1 file changed, 49 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 6beff11e692e..06818fe90fff 100644
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


