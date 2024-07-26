Return-Path: <linux-btrfs+bounces-6763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C849393D917
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8C7285DF8
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E9014A4FB;
	Fri, 26 Jul 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Cf1CbdEA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F4B14A090
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022623; cv=none; b=MDCnOC0jrncY6DH9w87dc63KtD1dk9czecyEDhffrT9lH6Lqt/zKcoDwZQPAHVq3snAbttfTTXmLBF8/vIbGWj4eF397nXbOt86d9cwyM2T5JRHdcjMYcJpWzTlFlxAXAOLZUVsNpuqMEHLIDwDrN9+nWtNpPaptcO/7i5PjKvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022623; c=relaxed/simple;
	bh=c/ufI9B2NqkYuGfheJ3QX0CMLoX2hZOxlxuTMxg1grc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFB0Vps+DuM4Rlab2kDjqExcaLQ/aCXMEefQd/0SzyoITACWurL4QozjqwWvW6YO1junocht3yglQ5jBGsgnrb1cx0FvsqJhh3wOsrJ74F+eA9pj9j3gQIqJbu7fJVdVwLUuF0BTG6iYfmOOnQIzLeKF+b3MwO05TdZ43eVOM2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Cf1CbdEA; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0871f82ff8so29635276.3
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022621; x=1722627421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZSLg3LGOqD0LLTl1IMwMID+6rjptKfBMm6YofAfBuc=;
        b=Cf1CbdEAvtT2l/yhri1kxUqnO4nvLv6oLSlgCPfcuW//v9Y/oIG9mjz9qh4YLNZS9y
         qtKjM5Xnvjl3Fim4k27s/x9u4O4Vz1VJxQMuAyhQDLadrnknx23eMOkNs2LCqugXlLm5
         DcGlLjjcu9Pve8avZCaHSy3UM3QACZUXkXsC49QG0rQCZ8itHzy6953fcGitTwrebJYv
         mVH02ZSPDv6/ic2bGYIQpiZKSbeNPF/nyTpXtSNJWCmCduKXxQwtr0idXWcMLOE2dtOT
         Kfa/GN2yQJAxlnar0p3DcP3c/YOu8zdWWMzGb1uBXUn9z2AGs2ZrVWtLVlHZsfcTk9nc
         Fh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022621; x=1722627421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZSLg3LGOqD0LLTl1IMwMID+6rjptKfBMm6YofAfBuc=;
        b=MGTVv5a7YEyfkWzk9rPZWTABlRcb8a/oS/lFBfoKiGDAKjtNy8XIAVWxWwAvq5aJPy
         VPnOX6N6MsNvzPMlBK2xY7QpYbiXeGQyvy6vbGBdllgt0im7WMEWf9eNGEYvUhaUREyM
         eIPJIWdUOIVof0kp0Y2mtemgJ/UDmkLNFfbW67l6X9EzBGtRzf0lIvSLwSV8QzJ2VtRH
         tR2ML31OQNVg3nrgYKs7/YW/VqWtRQ1YhysMvR1o1WCMjzMjr2Tw0yT2XJKVfro3RrAz
         6YbmE7M0Q42JQOogPvDWYkem2lxBtFWW9r5kfUxrPdNWCZctLbyOtt2xvMJsErtQwyw5
         q6dA==
X-Gm-Message-State: AOJu0YxaDDmTbYtssvsU8HUEywxTXFBGL+4IRk7L6/xLnHc5gMavOl3I
	XtvsHUcqJFK+AroVYwDUeUzWk0n+vX8X9bb8KjeDbQvVuXDEW+CWQkBKFg0GMtD5NKt+mb83AY3
	p
X-Google-Smtp-Source: AGHT+IEoEUaXmvbzUkaHDMFErdB7+ZYDb+LfhbzAtEM3CQTfzzNDaKSv4aSekFAeypMs0FifqzZyVA==
X-Received: by 2002:a25:7413:0:b0:e05:ed3c:47cd with SMTP id 3f1490d57ef6-e0b544feef4mr834833276.20.1722022620890;
        Fri, 26 Jul 2024 12:37:00 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b2a70d291sm844512276.52.2024.07.26.12.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:00 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 22/46] btrfs: convert extent_clear_unlock_delalloc to take a folio
Date: Fri, 26 Jul 2024 15:36:09 -0400
Message-ID: <79fd01116f9f1648fb37aebf5e3a74065bb80014.1722022376.git.josef@toxicpanda.com>
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

Instead of taking the locked page, take the locked folio so we can pass
that into __process_folios_contig.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c |  6 +++---
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/inode.c     | 25 ++++++++++++++-----------
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b944dcd9e941..6036fd6b9b79 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -394,14 +394,14 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 }
 
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
-				  const struct page *locked_page,
+				  const struct folio *locked_folio,
 				  struct extent_state **cached,
 				  u32 clear_bits, unsigned long page_ops)
 {
 	clear_extent_bit(&inode->io_tree, start, end, clear_bits, cached);
 
-	__process_folios_contig(inode->vfs_inode.i_mapping,
-				page_folio(locked_page), start, end, page_ops);
+	__process_folios_contig(inode->vfs_inode.i_mapping, locked_folio, start,
+				end, page_ops);
 }
 
 static bool btrfs_verify_folio(struct folio *folio, u64 start, u32 len)
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 1dd295e1b5a5..5d36031578ff 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -354,7 +354,7 @@ void set_extent_buffer_dirty(struct extent_buffer *eb);
 void set_extent_buffer_uptodate(struct extent_buffer *eb);
 void clear_extent_buffer_uptodate(struct extent_buffer *eb);
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
-				  const struct page *locked_page,
+				  const struct folio *locked_folio,
 				  struct extent_state **cached,
 				  u32 bits_to_clear, unsigned long page_ops);
 int extent_invalidate_folio(struct extent_io_tree *tree,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a8744d2c6a97..199f783680e2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -743,10 +743,10 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode,
 	if (ret == 0)
 		locked_page = NULL;
 
-	extent_clear_unlock_delalloc(inode, offset, end, locked_page, &cached,
-				     clear_flags,
-				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
-				     PAGE_END_WRITEBACK);
+	extent_clear_unlock_delalloc(inode, offset, end,
+				     page_folio(locked_page), &cached,
+				     clear_flags, PAGE_UNLOCK |
+				     PAGE_START_WRITEBACK | PAGE_END_WRITEBACK);
 	return ret;
 }
 
@@ -1501,7 +1501,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		page_ops |= PAGE_SET_ORDERED;
 
 		extent_clear_unlock_delalloc(inode, start, start + ram_size - 1,
-					     locked_page, &cached,
+					     page_folio(locked_page), &cached,
 					     EXTENT_LOCKED | EXTENT_DELALLOC,
 					     page_ops);
 		if (num_bytes < cur_alloc_size)
@@ -1560,7 +1560,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		if (!locked_page)
 			mapping_set_error(inode->vfs_inode.i_mapping, ret);
 		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
-					     locked_page, NULL, 0, page_ops);
+					     page_folio(locked_page), NULL, 0,
+					     page_ops);
 	}
 
 	/*
@@ -1583,7 +1584,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	if (extent_reserved) {
 		extent_clear_unlock_delalloc(inode, start,
 					     start + cur_alloc_size - 1,
-					     locked_page, &cached,
+					     page_folio(locked_page), &cached,
 					     clear_bits,
 					     page_ops);
 		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
@@ -1598,8 +1599,9 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 */
 	if (start < end) {
 		clear_bits |= EXTENT_CLEAR_DATA_RESV;
-		extent_clear_unlock_delalloc(inode, start, end, locked_page,
-					     &cached, clear_bits, page_ops);
+		extent_clear_unlock_delalloc(inode, start, end,
+					     page_folio(locked_page), &cached,
+					     clear_bits, page_ops);
 		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
 	}
 	return ret;
@@ -2207,7 +2209,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		btrfs_put_ordered_extent(ordered);
 
 		extent_clear_unlock_delalloc(inode, cur_offset, nocow_end,
-					     locked_page, &cached_state,
+					     page_folio(locked_page),
+					     &cached_state,
 					     EXTENT_LOCKED | EXTENT_DELALLOC |
 					     EXTENT_CLEAR_DATA_RESV,
 					     PAGE_UNLOCK | PAGE_SET_ORDERED);
@@ -2256,7 +2259,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 		lock_extent(&inode->io_tree, cur_offset, end, &cached);
 		extent_clear_unlock_delalloc(inode, cur_offset, end,
-					     locked_page, &cached,
+					     page_folio(locked_page), &cached,
 					     EXTENT_LOCKED | EXTENT_DELALLOC |
 					     EXTENT_DEFRAG |
 					     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
-- 
2.43.0


