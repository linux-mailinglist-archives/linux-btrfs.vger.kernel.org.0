Return-Path: <linux-btrfs+bounces-477-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E028014DE
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 21:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A4C281E6B
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 20:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A784559B4C;
	Fri,  1 Dec 2023 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="EorRAG1o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1gd3Hg6s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927D612A
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 12:59:02 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 093E65C00CC;
	Fri,  1 Dec 2023 15:59:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 01 Dec 2023 15:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1701464342; x=
	1701550742; bh=Keo4pSmq6Ov+O26COeoleO/K3gBkI9DfMuCHwSIrBBs=; b=E
	orRAG1oOYKfYvDJU5nsg0+eadtSV42NWIngmyIiJZ73KMk6+GDf7MSl9pFmT5ADN
	0NYdqfs258qFJF2YEojqiZLVSyGuAohQG3l/he9XizL/0hRIRYje3u/GSVd6XgG0
	AYtO3AdjkO7UATE9pTxKEFB0FWgS2ozNGprhra6L832DqbcI4M30gM27vuK29smh
	wV6cb0U5MyIJRdXxQ5upI2WkP/ISsenL+Mc3ToSqx9j/yEDVccXj8ULgCPUdje1R
	VjVM3KiUt8Gj3S9jgK1UbnqKgmB200ga3RAjFjamXYxOZpXNGRXJtVODfWXSW/HT
	4ps9ebGpDw457/m7u3khQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1701464342; x=1701550742; bh=K
	eo4pSmq6Ov+O26COeoleO/K3gBkI9DfMuCHwSIrBBs=; b=1gd3Hg6s9eKuANQ+s
	cnJo7P2HQjsQUVG6aw9JTd4HzWyDX5XfQWaMJ0v9eCZgIZa7d/0GvsL3dvDGs+eq
	a+6S7w2J/93qiA3vQ4JpZzllyPFUb7BTW4Uhyba8UOXtC9mqnpm50+Rajvyx/SRA
	YK1Pt2h9aVNwJqo5tWwy8jj2b9avc65XRdmMqoqa3If8d1nzpuTpYdD+MCqBI05B
	IU49FwnWC+qwjbjKUu0Ldhv0BRD+E7jODMhwTSoJhbgpZeYqglkrDquHKKQADLER
	wUZhYPTTZuTiBglY07fGGgy7oAJFSR7slreNhLURRZzzquaQIoPYn/Bp9UYVAeCk
	rbGvQ==
X-ME-Sender: <xms:FUlqZeUpBx6alPsbyUtXosP13fIxZgeVKi_PhcMen0UqQIciZ6s1cA>
    <xme:FUlqZamwwrV5-b6rkDmuD1ovIwquyqwEVbLLT1MWagZ7xEL87nLWcc0ZvQEp4ROvv
    u3TiLkc74K89854QVw>
X-ME-Received: <xmr:FUlqZSZmya86NV1xhfJ8ABp1psz468BIAvv0frj-Tpdl3f-AU4umi1wyN9aTm_yzYDRTLneFLaSRTAkOy0CYLTsntBk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:FUlqZVUOci6NvN_iPR_v0sznsltSothraoMdBKNx_0oinifBrqQR8g>
    <xmx:FUlqZYk8EGjOd3fyvC22jCMDVg2pS3C0yoD_p95lJ47Ah7fMLpt9_A>
    <xmx:FUlqZad4fwJqfrX2H9Ba7XINu6R9DTC0B2GcihdGmhQuBABP7Fx5Mg>
    <xmx:FklqZfvhMkXj99LvQ5yQvDVq9CNjloZPKNYzHBGgo1nc5uFumfWUVw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:59:01 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/5] btrfs: fix qgroup_free_reserved_data int overflow
Date: Fri,  1 Dec 2023 13:00:10 -0800
Message-ID: <98d6609df5dc669df4025c257c28077f44b21e04.1701464169.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701464169.git.boris@bur.io>
References: <cover.1701464169.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reserved data counter and input parameter is a u64, but we
inadvertantly accumulate it in an int. Overflowing that int results in
freeing the wrong amount of data and breaking rsv accounting.

Unfortunately, this overflow rot spreads from there, as the qgroup
release/free functions rely on returning an int to take advantage of
negative values for error codes.

Therefore, the full fix is to return the "released" or "freed" amount by
a u64* argument and to return 0 or negative error code via the return
value.

Most of the callsites simply ignore the return value, though some
of them handle the error and count the returned bytes. Change all of
them accordingly.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/delalloc-space.c |  2 +-
 fs/btrfs/file.c           |  2 +-
 fs/btrfs/inode.c          | 16 ++++++++--------
 fs/btrfs/ordered-data.c   |  7 ++++---
 fs/btrfs/qgroup.c         | 25 +++++++++++++++----------
 fs/btrfs/qgroup.h         |  4 ++--
 6 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 51453d4928fa..2833e8ef4c09 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -199,7 +199,7 @@ void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 	start = round_down(start, fs_info->sectorsize);
 
 	btrfs_free_reserved_data_space_noquota(fs_info, len);
-	btrfs_qgroup_free_data(inode, reserved, start, len);
+	btrfs_qgroup_free_data(inode, reserved, start, len, NULL);
 }
 
 /*
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e9c4b947a5aa..7a71720aaed2 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3192,7 +3192,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 			qgroup_reserved -= range->len;
 		} else if (qgroup_reserved > 0) {
 			btrfs_qgroup_free_data(BTRFS_I(inode), data_reserved,
-					       range->start, range->len);
+					       range->start, range->len, NULL);
 			qgroup_reserved -= range->len;
 		}
 		list_del(&range->list);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f8647d8271b7..e79a047aa5d1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -697,7 +697,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
 	 * And at reserve time, it's always aligned to page size, so
 	 * just free one page here.
 	 */
-	btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE);
+	btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE, NULL);
 	btrfs_free_path(path);
 	btrfs_end_transaction(trans);
 	return ret;
@@ -5141,7 +5141,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 		 */
 		if (state_flags & EXTENT_DELALLOC)
 			btrfs_qgroup_free_data(BTRFS_I(inode), NULL, start,
-					       end - start + 1);
+					       end - start + 1, NULL);
 
 		clear_extent_bit(io_tree, start, end,
 				 EXTENT_CLEAR_ALL_BITS | EXTENT_DO_ACCOUNTING,
@@ -8076,7 +8076,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 		 *    reserved data space.
 		 *    Since the IO will never happen for this page.
 		 */
-		btrfs_qgroup_free_data(inode, NULL, cur, range_end + 1 - cur);
+		btrfs_qgroup_free_data(inode, NULL, cur, range_end + 1 - cur, NULL);
 		if (!inode_evicting) {
 			clear_extent_bit(tree, cur, range_end, EXTENT_LOCKED |
 				 EXTENT_DELALLOC | EXTENT_UPTODATE |
@@ -9513,7 +9513,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	struct btrfs_path *path;
 	u64 start = ins->objectid;
 	u64 len = ins->offset;
-	int qgroup_released;
+	u64 qgroup_released = 0;
 	int ret;
 
 	memset(&stack_fi, 0, sizeof(stack_fi));
@@ -9526,9 +9526,9 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	btrfs_set_stack_file_extent_compression(&stack_fi, BTRFS_COMPRESS_NONE);
 	/* Encryption and other encoding is reserved and all 0 */
 
-	qgroup_released = btrfs_qgroup_release_data(inode, file_offset, len);
-	if (qgroup_released < 0)
-		return ERR_PTR(qgroup_released);
+	ret = btrfs_qgroup_release_data(inode, file_offset, len, &qgroup_released);
+	if (ret < 0)
+		return ERR_PTR(ret);
 
 	if (trans) {
 		ret = insert_reserved_file_extent(trans, inode,
@@ -10423,7 +10423,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	btrfs_delalloc_release_metadata(inode, disk_num_bytes, ret < 0);
 out_qgroup_free_data:
 	if (ret < 0)
-		btrfs_qgroup_free_data(inode, data_reserved, start, num_bytes);
+		btrfs_qgroup_free_data(inode, data_reserved, start, num_bytes, NULL);
 out_free_data_space:
 	/*
 	 * If btrfs_reserve_extent() succeeded, then we already decremented
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 8d4ab5ecfa5d..c68fb78b7454 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -152,11 +152,12 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 {
 	struct btrfs_ordered_extent *entry;
 	int ret;
+	u64 qgroup_rsv = 0;
 
 	if (flags &
 	    ((1 << BTRFS_ORDERED_NOCOW) | (1 << BTRFS_ORDERED_PREALLOC))) {
 		/* For nocow write, we can release the qgroup rsv right now */
-		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes);
+		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &qgroup_rsv);
 		if (ret < 0)
 			return ERR_PTR(ret);
 	} else {
@@ -164,7 +165,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 		 * The ordered extent has reserved qgroup space, release now
 		 * and pass the reserved number for qgroup_record to free.
 		 */
-		ret = btrfs_qgroup_release_data(inode, file_offset, num_bytes);
+		ret = btrfs_qgroup_release_data(inode, file_offset, num_bytes, &qgroup_rsv);
 		if (ret < 0)
 			return ERR_PTR(ret);
 	}
@@ -182,7 +183,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	entry->inode = igrab(&inode->vfs_inode);
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
-	entry->qgroup_rsv = ret;
+	entry->qgroup_rsv = qgroup_rsv;
 	entry->flags = flags;
 	refcount_set(&entry->refs, 1);
 	init_waitqueue_head(&entry->wait);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index ce446d9d7f23..a953c16c7eb8 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4057,13 +4057,14 @@ int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 
 /* Free ranges specified by @reserved, normally in error path */
 static int qgroup_free_reserved_data(struct btrfs_inode *inode,
-			struct extent_changeset *reserved, u64 start, u64 len)
+				     struct extent_changeset *reserved,
+				     u64 start, u64 len, u64 *freed_ret)
 {
 	struct btrfs_root *root = inode->root;
 	struct ulist_node *unode;
 	struct ulist_iterator uiter;
 	struct extent_changeset changeset;
-	int freed = 0;
+	u64 freed = 0;
 	int ret;
 
 	extent_changeset_init(&changeset);
@@ -4104,7 +4105,9 @@ static int qgroup_free_reserved_data(struct btrfs_inode *inode,
 	}
 	btrfs_qgroup_free_refroot(root->fs_info, root->root_key.objectid, freed,
 				  BTRFS_QGROUP_RSV_DATA);
-	ret = freed;
+	if (freed_ret)
+		*freed_ret = freed;
+	ret = 0;
 out:
 	extent_changeset_release(&changeset);
 	return ret;
@@ -4112,7 +4115,7 @@ static int qgroup_free_reserved_data(struct btrfs_inode *inode,
 
 static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 			struct extent_changeset *reserved, u64 start, u64 len,
-			int free)
+			u64 *released, int free)
 {
 	struct extent_changeset changeset;
 	int trace_op = QGROUP_RELEASE;
@@ -4128,7 +4131,7 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 	/* In release case, we shouldn't have @reserved */
 	WARN_ON(!free && reserved);
 	if (free && reserved)
-		return qgroup_free_reserved_data(inode, reserved, start, len);
+		return qgroup_free_reserved_data(inode, reserved, start, len, released);
 	extent_changeset_init(&changeset);
 	ret = clear_record_extent_bits(&inode->io_tree, start, start + len -1,
 				       EXTENT_QGROUP_RESERVED, &changeset);
@@ -4143,7 +4146,8 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 		btrfs_qgroup_free_refroot(inode->root->fs_info,
 				inode->root->root_key.objectid,
 				changeset.bytes_changed, BTRFS_QGROUP_RSV_DATA);
-	ret = changeset.bytes_changed;
+	if (released)
+		*released = changeset.bytes_changed;
 out:
 	extent_changeset_release(&changeset);
 	return ret;
@@ -4162,9 +4166,10 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
  * NOTE: This function may sleep for memory allocation.
  */
 int btrfs_qgroup_free_data(struct btrfs_inode *inode,
-			struct extent_changeset *reserved, u64 start, u64 len)
+			   struct extent_changeset *reserved,
+			   u64 start, u64 len, u64 *freed)
 {
-	return __btrfs_qgroup_release_data(inode, reserved, start, len, 1);
+	return __btrfs_qgroup_release_data(inode, reserved, start, len, freed, 1);
 }
 
 /*
@@ -4182,9 +4187,9 @@ int btrfs_qgroup_free_data(struct btrfs_inode *inode,
  *
  * NOTE: This function may sleep for memory allocation.
  */
-int btrfs_qgroup_release_data(struct btrfs_inode *inode, u64 start, u64 len)
+int btrfs_qgroup_release_data(struct btrfs_inode *inode, u64 start, u64 len, u64 *released)
 {
-	return __btrfs_qgroup_release_data(inode, NULL, start, len, 0);
+	return __btrfs_qgroup_release_data(inode, NULL, start, len, released, 0);
 }
 
 static void add_root_meta_rsv(struct btrfs_root *root, int num_bytes,
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 855a4f978761..15b485506104 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -358,10 +358,10 @@ int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
 /* New io_tree based accurate qgroup reserve API */
 int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len);
-int btrfs_qgroup_release_data(struct btrfs_inode *inode, u64 start, u64 len);
+int btrfs_qgroup_release_data(struct btrfs_inode *inode, u64 start, u64 len, u64 *released);
 int btrfs_qgroup_free_data(struct btrfs_inode *inode,
 			   struct extent_changeset *reserved, u64 start,
-			   u64 len);
+			   u64 len, u64 *freed);
 int btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
 			      enum btrfs_qgroup_rsv_type type, bool enforce);
 int __btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
-- 
2.42.0


