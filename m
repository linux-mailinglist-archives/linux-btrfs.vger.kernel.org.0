Return-Path: <linux-btrfs+bounces-6756-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD91693D910
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219152820EF
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CD6149DEA;
	Fri, 26 Jul 2024 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="pit8l/zx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD22149C6C
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022615; cv=none; b=qRTHexOMJiDiU+OioZMdRVVqbEDcojpu0S/+gbsrjbg0VnKYcmZb4CvE3rqj4CRogXFhdlMPVK9OFuwWfY+Oo6xG1/z+2a64jgLvcOnLol2+WvtIIEobatCRW+HjZRTHAJuUT+Mrm6adsEC/606sfob/wazRnD9ZOx1CrcM0Tno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022615; c=relaxed/simple;
	bh=VDAooYh9HjQiFLV6TCEASkVboELzoqk0Tb5yUcdzMkk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I92iEMzLr6u2nxg56wBBlKPnzqYH8AzzGZqRlM+ZxgqjPjQsm6F0WxuRKMuWFlOOo4/uzZ6eBX7NEDY0n7lhyDOh4u2C+2IjsFzTiYp/96yE+WsQtR/5nQWmNV0aHsKrlQG1g3NZEePpbxAekCzlw5KRWR7HpxtkiTxr5hb+Atg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=pit8l/zx; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-64b29539d86so333327b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022613; x=1722627413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9uqAo0sphthKfqbM6Qkv/CNluSZdkXHFpbAPOmW6TFg=;
        b=pit8l/zxoCxnSFezlWzpV9UbODLOYZDt3MsUcGqbVU8f6DZZ3OFS2uGz5jVhUH0FiI
         oRTw+rdyxycImieaI8dL9afWpeB+v2doknBTd1+skfMq0iNiyHZoinLGb3SgcJxc+0sP
         JK8hgStVu2tZ80f5XbqCf8Vv3AzufsqyRWQBMcBzo5l9Z7g4c90vgEcqqYtaYesrNZn/
         flVz++TskfrreXIQ7NvStcNrCD6G/FikcUede92ZZfqNVpSTfdihIqG3QGRLv+XlnzkT
         03gCWfqi+3W5VyJVhQawBtZfncGWaoK8mvBY5MN56bDsP61dy7CozT8IWYhrYmQgpOs0
         P+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022613; x=1722627413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uqAo0sphthKfqbM6Qkv/CNluSZdkXHFpbAPOmW6TFg=;
        b=IS3b5OOLIedPnMS6KZY1KJfOcU7w1qdy8CqUxhYM4UAOOhHXP8lrhZs8wAmWWctkiA
         Bgo/e964iF0oDy29Kd7LTfMjNa5kgXnFT+jU9M5FmCk+B1N5VTTd++L36NEl8KMaHUpb
         PVDObtLJOjjF9RogPoTVogdAKrsApIYpRphFjPSEgTE9df9rTk3vDpg6FPmpko+Xaylc
         0+CpQi8OmzwkESFOktpyo9yrGf5VhSXsv6xo/P/e8mbcQ5SJXqtIzMDdkCt/Xyp69ViA
         kvtywQyq3yuKxwe9JXrDlutWiC/KrkFwbTXmeacgDkEum0X0+7RbfQ0DH6cBBq7aWkPD
         pq4Q==
X-Gm-Message-State: AOJu0Yz7I/LPVrsYuN1XKCD9ClehLpnDwQ+ZNWGwjuAmFgielxLbhbn4
	kjvnhPltXLfWF0ZsrPULDVqQZ+UMCPQDXwTCGfgVDqn8vBO8OrlPyYer/c02yDZj3eJvQDvuGnU
	W
X-Google-Smtp-Source: AGHT+IFamfSyok7zp3qArQGV2boXonqTd6WsfRGaQAr81rRnhHPd/FxVI7Qo7z3IFclXp437Az7ejA==
X-Received: by 2002:a0d:f444:0:b0:653:ffe7:d641 with SMTP id 00721157ae682-67a0afb6583mr8384287b3.45.1722022613003;
        Fri, 26 Jul 2024 12:36:53 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b9be42fsm9744097b3.105.2024.07.26.12.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 15/46] btrfs: convert btrfs_mark_ordered_io_finished to take a folio
Date: Fri, 26 Jul 2024 15:36:02 -0400
Message-ID: <903924f0155d9652b950b650a69f634b9341aa35.1722022376.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722022376.git.josef@toxicpanda.com>
References: <cover.1722022376.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only need a folio now, make it take a folio as an argument and update
all of the callers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c    | 8 ++++----
 fs/btrfs/inode.c        | 7 ++++---
 fs/btrfs/ordered-data.c | 9 ++++-----
 fs/btrfs/ordered-data.h | 4 ++--
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 58ff09368eb9..56bf87ac5f6c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1428,8 +1428,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		u32 iosize;
 
 		if (cur >= i_size) {
-			btrfs_mark_ordered_io_finished(inode, &folio->page, cur,
-						       len, true);
+			btrfs_mark_ordered_io_finished(inode, folio, cur, len,
+						       true);
 			/*
 			 * This range is beyond i_size, thus we don't need to
 			 * bother writing back.
@@ -1569,7 +1569,7 @@ static int __extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ct
 		folio_end_writeback(folio);
 	}
 	if (ret) {
-		btrfs_mark_ordered_io_finished(BTRFS_I(inode), &folio->page,
+		btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
 					       page_start, PAGE_SIZE, !ret);
 		mapping_set_error(folio->mapping, ret);
 	}
@@ -2331,7 +2331,7 @@ void extent_write_locked_range(struct inode *inode, const struct page *locked_pa
 			btrfs_folio_clear_writeback(fs_info, folio, cur, cur_len);
 		}
 		if (ret) {
-			btrfs_mark_ordered_io_finished(BTRFS_I(inode), &folio->page,
+			btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
 						       cur, cur_len, !ret);
 			mapping_set_error(mapping, ret);
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 26dc2c3ac903..a8744d2c6a97 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1144,7 +1144,8 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 
 			set_page_writeback(locked_page);
 			end_page_writeback(locked_page);
-			btrfs_mark_ordered_io_finished(inode, locked_page,
+			btrfs_mark_ordered_io_finished(inode,
+						       page_folio(locked_page),
 						       page_start, PAGE_SIZE,
 						       !ret);
 			mapping_set_error(locked_page->mapping, ret);
@@ -2802,8 +2803,8 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		 * to reflect the errors and clean the page.
 		 */
 		mapping_set_error(page->mapping, ret);
-		btrfs_mark_ordered_io_finished(inode, page, page_start,
-					       PAGE_SIZE, !ret);
+		btrfs_mark_ordered_io_finished(inode, page_folio(page),
+					       page_start, PAGE_SIZE, !ret);
 		clear_page_dirty_for_io(page);
 	}
 	btrfs_folio_clear_checked(fs_info, page_folio(page), page_start, PAGE_SIZE);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index e97747956040..eb9b32ffbc0c 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -449,8 +449,8 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 /*
  * Mark all ordered extents io inside the specified range finished.
  *
- * @page:	 The involved page for the operation.
- *		 For uncompressed buffered IO, the page status also needs to be
+ * @folio:	 The involved folio for the operation.
+ *		 For uncompressed buffered IO, the folio status also needs to be
  *		 updated to indicate whether the pending ordered io is finished.
  *		 Can be NULL for direct IO and compressed write.
  *		 For these cases, callers are ensured they won't execute the
@@ -460,7 +460,7 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
  * extent(s) covering it.
  */
 void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
-				    struct page *page, u64 file_offset,
+				    struct folio *folio, u64 file_offset,
 				    u64 num_bytes, bool uptodate)
 {
 	struct rb_node *node;
@@ -524,8 +524,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 		ASSERT(end + 1 - cur < U32_MAX);
 		len = end + 1 - cur;
 
-		if (can_finish_ordered_extent(entry, page_folio(page), cur, len,
-					      uptodate)) {
+		if (can_finish_ordered_extent(entry, folio, cur, len, uptodate)) {
 			spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
 			btrfs_queue_ordered_fn(entry);
 			spin_lock_irqsave(&inode->ordered_tree_lock, flags);
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 90c1c3c51ae5..4e152736d06c 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -166,8 +166,8 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 				 struct folio *folio, u64 file_offset, u64 len,
 				 bool uptodate);
 void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
-				struct page *page, u64 file_offset,
-				u64 num_bytes, bool uptodate);
+				    struct folio *folio, u64 file_offset,
+				    u64 num_bytes, bool uptodate);
 bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
 				    u64 file_offset, u64 io_size);
-- 
2.43.0


