Return-Path: <linux-btrfs+bounces-6774-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD09393D922
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC6A1C227B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAAD152191;
	Fri, 26 Jul 2024 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="eppE/qSc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627D91411C7
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022634; cv=none; b=XqQce2VTAXQFe8YLgYyN/DE8mAAArVC0Alv41PZPQSXVH83wULEo84NbCvwa7eaQqppTwHdi4dvWBiKhVwvwUGcEN0Gkyv1lBofkRRnaTWzdi/KVfvGwL/cU25xP4GR1gASa4WHFdAG0XyJNeUqTo9I8YL/eWWVrEh+uqFs1MYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022634; c=relaxed/simple;
	bh=agAlbopw3nRwca0vCu1M+C9rFYflBTTLqwpHyyIqx9w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFqafyH6p1ZAj2tad1IYrayzPFNpdWuo2/JRdy6ZpqWhHI3IzRQjymAVLrf/cW4W49h01zmI5lhgwAZcLpLtzu0BNFzyZWhzSCCfaVrF53jY1t4rDVuiHpS0Cj/HF7V4WVmofEqFbnwAjcxGZpByvr0GkTPso/KBPsfhWeXiKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=eppE/qSc; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso40018276.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022632; x=1722627432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62w1ABzJsgX2xh/QeMOLQvJI5/rE2l7TUavNj7Crc2g=;
        b=eppE/qScgU+R1tW8W1NuQDfb+EZpS4au6F55EV0S+BQnHR//p55StRCnmSNcoJ2e1j
         2LFawlpZdaZWpCxF7mMcBpZ13Zz5lymChEwDXbylIRhKyYMQwH4bHYcCFBvldOn+jd1j
         nunSnvy01XfAYwLFNv7HirG5eodFDyl/X+trhNaHhEV9zCInQKBKutDwu+I4FYkAFlrI
         0QnDMFAR2sxOps6v0kBeS+vxY9THYh8TH/D4/uWwGTkaGDK5IW+wz8mpE8L8qrQ1Xp1+
         +D/RYG5TE7Ilh6oZirdPPFJSQuiGPYVvvUWJ4GEn3bl3pxwXqeopjor0himF91QXcGR7
         QHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022632; x=1722627432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62w1ABzJsgX2xh/QeMOLQvJI5/rE2l7TUavNj7Crc2g=;
        b=RxFB/92w0XegoHnqtaxavg27FIHb0qMvvV/RsPJSRFbrKuczcvXCL/1ypIFaT5Fklb
         ZHzZCspnZCNkMGbtVDKItcDRyIJjMR89FpFm6KV2+UZixcmOqDBN8sy6Wu/ncEHjU+WF
         k62aWwEDSlvCZfhAhAY1iO4F+T8clZUkO+UnjfXxIHQ8s8mJYfFPk+Juylhb7tJZ+qvD
         FNN0kY3ybEtqYk1deqBpdG2wTT6/c1QKvM1tn130fPcTpywXhJNQB9fqOg+9hWGtNhNl
         6lcZ93eLDeCDZLo/N8y1XftlVxyLAc2Cs3FFoHtVPU+AdtCKkIfm/KmFIa/6kp85rAUM
         I5WA==
X-Gm-Message-State: AOJu0YyY4hnxRFoGMn48LwNAoONDVnhwFgKO6uz0arN75dw4GxvxJQza
	WPcfzP2sXh52qYewrnAWkhuCn1FHM5b3m4mZNASnoqqB3YfkYq8CNAh4ySs7Lk96QST21pihnUW
	2
X-Google-Smtp-Source: AGHT+IGEbwn5Fo3oeQAyt3pWxzDKH9yeASjE+Np8Z04en932H4588TIOtm1O9aO/8/+kCxZW++PUTQ==
X-Received: by 2002:a25:e0d7:0:b0:e0b:3a3a:8734 with SMTP id 3f1490d57ef6-e0b5465c93dmr749682276.56.1722022632327;
        Fri, 26 Jul 2024 12:37:12 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b29f1b971sm846572276.7.2024.07.26.12.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 33/46] btrfs: convert async_chunk to hold a folio
Date: Fri, 26 Jul 2024 15:36:20 -0400
Message-ID: <bdf00909bebe0108ce43b6ff027aa5a6869e39b0.1722022377.git.josef@toxicpanda.com>
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

Instead of passing in the page for ->locked_page, make it hold a
locked_folio and then update the users of async_chunk to act
accordingly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a16b9aba7f96..fbb21deef54c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -762,7 +762,7 @@ struct async_extent {
 
 struct async_chunk {
 	struct btrfs_inode *inode;
-	struct page *locked_page;
+	struct folio *locked_folio;
 	u64 start;
 	u64 end;
 	blk_opf_t write_flags;
@@ -1167,7 +1167,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	struct btrfs_ordered_extent *ordered;
 	struct btrfs_file_extent file_extent;
 	struct btrfs_key ins;
-	struct page *locked_page = NULL;
+	struct folio *locked_folio = NULL;
 	struct extent_state *cached = NULL;
 	struct extent_map *em;
 	int ret = 0;
@@ -1178,19 +1178,20 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		kthread_associate_blkcg(async_chunk->blkcg_css);
 
 	/*
-	 * If async_chunk->locked_page is in the async_extent range, we need to
+	 * If async_chunk->locked_folio is in the async_extent range, we need to
 	 * handle it.
 	 */
-	if (async_chunk->locked_page) {
-		u64 locked_page_start = page_offset(async_chunk->locked_page);
-		u64 locked_page_end = locked_page_start + PAGE_SIZE - 1;
+	if (async_chunk->locked_folio) {
+		u64 locked_folio_start = folio_pos(async_chunk->locked_folio);
+		u64 locked_folio_end = locked_folio_start +
+			folio_size(async_chunk->locked_folio) - 1;
 
-		if (!(start >= locked_page_end || end <= locked_page_start))
-			locked_page = async_chunk->locked_page;
+		if (!(start >= locked_folio_end || end <= locked_folio_start))
+			locked_folio = async_chunk->locked_folio;
 	}
 
 	if (async_extent->compress_type == BTRFS_COMPRESS_NONE) {
-		submit_uncompressed_range(inode, async_extent, locked_page);
+		submit_uncompressed_range(inode, async_extent, &locked_folio->page);
 		goto done;
 	}
 
@@ -1205,7 +1206,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		 * non-contiguous space for the uncompressed size instead.  So
 		 * fall back to uncompressed.
 		 */
-		submit_uncompressed_range(inode, async_extent, locked_page);
+		submit_uncompressed_range(inode, async_extent,
+					  &locked_folio->page);
 		goto done;
 	}
 
@@ -1714,10 +1716,10 @@ static bool run_delalloc_compressed(struct btrfs_inode *inode,
 			 */
 			wbc_account_cgroup_owner(wbc, &locked_folio->page,
 						 cur_end - start);
-			async_chunk[i].locked_page = &locked_folio->page;
+			async_chunk[i].locked_folio = locked_folio;
 			locked_folio = NULL;
 		} else {
-			async_chunk[i].locked_page = NULL;
+			async_chunk[i].locked_folio = NULL;
 		}
 
 		if (blkcg_css != blkcg_root_css) {
-- 
2.43.0


