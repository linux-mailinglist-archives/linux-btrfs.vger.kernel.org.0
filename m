Return-Path: <linux-btrfs+bounces-19947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 743BFCD4B5F
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 06:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FF74300C291
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 05:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76DF1F875A;
	Mon, 22 Dec 2025 05:15:56 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m49212.qiye.163.com (mail-m49212.qiye.163.com [45.254.49.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11D71CFBA
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766380556; cv=none; b=lBCki5o1yeZK/VthAhyUrcOCV7a4gmgLChM5800uSeFSsU5HFCFc/aAD7jqHP/uy2guGTOJKr8O97aPLrTYlaUkuv0h9vMbrDl5+aC92svclQwQnrHgIdzvTblcYvSk76nC3KpZADbGY9C1g+yh6pK+wrx262TQ037VTBTyCqgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766380556; c=relaxed/simple;
	bh=dp+d0W7FLXCsR4soqj8Jh25wjqFzgpSXm1mHhImsPhg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YnDDAbHVGKxjymBGb81c00n2nU8d5fCLXM+ghfK/4Jm4dA/Zep+wNi9nAIsrNVgA3gy/Yrk9zLMkiUiwNyrJYQBfKuem2mt7s/HSsiGquRru0+5Mex+hTKrNip4P+z8SBzbrS0/hEl06bkHw/2QSk5moI6EwDJYKkQWhtXf6OJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.254.49.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 14a23cbe2;
	Mon, 22 Dec 2025 12:00:01 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: clm@fb.com,
	dsterba@suse.com,
	Johannes.Thumshirn@wdc.com
Cc: linux-btrfs@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH v2] btrfs: replace is_data_bbio() with is_data_inode() for direct usage
Date: Mon, 22 Dec 2025 11:59:42 +0800
Message-Id: <20251222035942.1482587-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b4436cfc60229kunm256bbc7887e426
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHR5DVhhITUsYQkMeQxlLQ1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

After commit 81cea6cd7041 ("btrfs: remove btrfs_bio::fs_info by
extracting it from btrfs_bio::inode"), the btrfs_bio::inode field is
mandatory for all btrfs_bio allocations. The NULL check is redundant and
can be removed.

Replace all calls to is_data_bbio() in bio.c

Link: https://lore.kernel.org/linux-btrfs/20251219084316.1164580-1-zhen.ni@easystack.cn
Suggested-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
Changes in v2:
- Replace all calls to is_data_bbio() in bio.c
---
 fs/btrfs/bio.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index fa1d321a2fb8..f48911a1b6d5 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -26,15 +26,10 @@ struct btrfs_failed_bio {
 	atomic_t repair_count;
 };
 
-/* Is this a data path I/O that needs storage layer checksum and repair? */
-static inline bool is_data_bbio(const struct btrfs_bio *bbio)
-{
-	return bbio->inode && is_data_inode(bbio->inode);
-}
-
 static bool bbio_has_ordered_extent(const struct btrfs_bio *bbio)
 {
-	return is_data_bbio(bbio) && btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE;
+	return is_data_inode(bbio->inode) &&
+	       btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE;
 }
 
 /*
@@ -372,7 +367,7 @@ static void simple_end_io_work(struct work_struct *work)
 
 	if (bio_op(bio) == REQ_OP_READ) {
 		/* Metadata reads are checked and repaired by the submitter. */
-		if (is_data_bbio(bbio))
+		if (is_data_inode(bbio->inode))
 			return btrfs_check_read_bio(bbio, bbio->bio.bi_private);
 		return btrfs_bio_end_io(bbio, bbio->bio.bi_status);
 	}
@@ -406,7 +401,7 @@ static void btrfs_raid56_end_io(struct bio *bio)
 
 	btrfs_bio_counter_dec(bioc->fs_info);
 	bbio->mirror_num = bioc->mirror_num;
-	if (bio_op(bio) == REQ_OP_READ && is_data_bbio(bbio))
+	if (bio_op(bio) == REQ_OP_READ && is_data_inode(bbio->inode))
 		btrfs_check_read_bio(bbio, NULL);
 	else
 		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
@@ -772,7 +767,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	 * our bio to the physical disk location, so we need to save the
 	 * original bytenr so we know what we're checksumming.
 	 */
-	if (bio_op(bio) == REQ_OP_WRITE && is_data_bbio(bbio))
+	if (bio_op(bio) == REQ_OP_WRITE && is_data_inode(bbio->inode))
 		bbio->orig_logical = logical;
 
 	map_length = min(map_length, length);
@@ -796,7 +791,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	 * Save the iter for the end_io handler and preload the checksums for
 	 * data reads.
 	 */
-	if (bio_op(bio) == REQ_OP_READ && is_data_bbio(bbio)) {
+	if (bio_op(bio) == REQ_OP_READ && is_data_inode(bbio->inode)) {
 		bbio->saved_iter = bio->bi_iter;
 		ret = btrfs_lookup_bio_sums(bbio);
 		status = errno_to_blk_status(ret);
@@ -810,7 +805,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 			bio->bi_opf |= REQ_OP_ZONE_APPEND;
 		}
 
-		if (is_data_bbio(bbio) && bioc && bioc->use_rst) {
+		if (is_data_inode(bbio->inode) && bioc && bioc->use_rst) {
 			/*
 			 * No locking for the list update, as we only add to
 			 * the list in the I/O submission path, and list
-- 
2.20.1


