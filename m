Return-Path: <linux-btrfs+bounces-6759-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19A593D913
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC4C284E40
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4C7149E17;
	Fri, 26 Jul 2024 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="aSntczgv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F80149DFC
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022618; cv=none; b=AoB29YdaQd8l+NTX/+CaExhnzHjPC9afMxCDEENyT9JFmp11ynqC6fhBEo7aoaOVGdS1av5Ud4LZniPLQ8Ogu3S0PIMh3yQIqS/jXFK0LnpS9gfhjqaD8Z1QPocOiI6mSRXoqyVg6wH6cRWyyPmlnqwi6TwEY9RKB0sZ9SvdYxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022618; c=relaxed/simple;
	bh=jTlEh59LEmakLdi5ZAwgkrRCYD9VBYtOVU5S3mmV/0k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mj/c5wmITwY+dIB9U297xfLqadEO6QPy+xJ0fXrDDwVuh38RH2bn9yMO6E+IOyuWk05bzABNfweGnbeOEU0YHx/OMhR+vJEYFzQcmVwp8DGImNuTtL9mdItU+tZPGrXc6HdO13VPDDFski2jW9X1oPtXwnlVYcDTyuq2S9t4Oqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=aSntczgv; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-664ccd158b0so358767b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022616; x=1722627416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35e2ClCxEe/wCEeaddbhCpQMYPr9dVCHVaST0yK0vPs=;
        b=aSntczgvIkE7rFbu7EtrAtGgWI9hYfBZ1ot2pkAw986Alg3DnBI0WcO0bt2j7y8kJ5
         KZDvnFR7iDqTSSAsuRsOc5PcB+zYbqJD8Ou67WpbqS0W4+YWxeqAXXPdsrGk433txDTs
         toWEUcZfrugC6QXfro88pW4+Nh8p46o6ZfiLSJLheZIOVQYe40WelIadBTCoKD3lnenm
         KX3bVDaMGB3RqEsmxO/Wh2ccqxG+eW4Fsz0z1tFABccSJhXPYO0Pl02Uzd3yWQaqajr4
         oeSSYpUxFNBv28OskWSi3wzOEh/VK5H3yLPHpsPZ2IGGG+syRHVHax+f0xxUSBoEcK+w
         d/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022616; x=1722627416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35e2ClCxEe/wCEeaddbhCpQMYPr9dVCHVaST0yK0vPs=;
        b=Cj2Ft3tgVUZhFRNxwg9Jkg0qsyi8O5WJ8dLSTv97KA1s+7YR+rbqL4An0RWdCY7z8r
         yiPDv8wIuQwtCWCo/urQKb2f0/bOsW4fX3xJeuuPG4VinaCTJaPvc8rBkudPtZ5r2pmY
         tnnXpAO2819TAYoGxocEO8HqVZDPep+/JREtFMZFB1pOZDzlBS+PGt/XJ8hxD2DYRBws
         97jeyysMRGVBqp0Fiyj07qxYYJ218CDurUXOA5/jwums+2FSY8GYIoXc4KevSEg1f5RT
         nD2car3JFYkEGDD6gQ3HnhIhx2jCMy3Q7+Wt4UDpjp0HUD0JZFkqxJzZ36FeGgpjGiBg
         S5iA==
X-Gm-Message-State: AOJu0Yz1PmCIq/Mi78MUmB9aVSop0Suvlvcv5AX92Fdk7YCJxoVb56tY
	0tOaXOQeOLTut1N5rfKKt/+keTy5TYIq1U7zfOSzZm2Tdai1b2hjVx4SKTRbeDf3G9EBnN+O2Uf
	j
X-Google-Smtp-Source: AGHT+IGQAtVNHduZS3iV+tTGUwdRXw1ZeW1n+rozJgOTy5Ss4tDczRpldf+iblV34RkxNgoEOkPsWA==
X-Received: by 2002:a81:5c83:0:b0:644:2639:8645 with SMTP id 00721157ae682-67a07989c5bmr9400747b3.26.1722022616445;
        Fri, 26 Jul 2024 12:36:56 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756795e824sm9961457b3.37.2024.07.26.12.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:56 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 18/46] btrfs: convert lock_delalloc_pages to take a folio
Date: Fri, 26 Jul 2024 15:36:05 -0400
Message-ID: <effca02ec8cbc257f3acadb9d9f4a82d930c464c.1722022376.git.josef@toxicpanda.com>
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

Also rename lock_delalloc_pages => lock_delalloc_folios in the process,
now that it exclusively works on folios.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index def12bb8b34d..33c45b6e8969 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -230,10 +230,9 @@ static noinline void __unlock_for_delalloc(const struct inode *inode,
 			       PAGE_UNLOCK);
 }
 
-static noinline int lock_delalloc_pages(struct inode *inode,
-					const struct page *locked_page,
-					u64 start,
-					u64 end)
+static noinline int lock_delalloc_folios(struct inode *inode,
+					 const struct folio *locked_folio,
+					 u64 start, u64 end)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct address_space *mapping = inode->i_mapping;
@@ -243,7 +242,7 @@ static noinline int lock_delalloc_pages(struct inode *inode,
 	u64 processed_end = start;
 	struct folio_batch fbatch;
 
-	if (index == locked_page->index && index == end_index)
+	if (index == locked_folio->index && index == end_index)
 		return 0;
 
 	folio_batch_init(&fbatch);
@@ -257,23 +256,22 @@ static noinline int lock_delalloc_pages(struct inode *inode,
 
 		for (i = 0; i < found_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
-			struct page *page = folio_page(folio, 0);
 			u32 len = end + 1 - start;
 
-			if (page == locked_page)
+			if (folio == locked_folio)
 				continue;
 
 			if (btrfs_folio_start_writer_lock(fs_info, folio, start,
 							  len))
 				goto out;
 
-			if (!PageDirty(page) || page->mapping != mapping) {
+			if (!folio_test_dirty(folio) || folio->mapping != mapping) {
 				btrfs_folio_end_writer_lock(fs_info, folio, start,
 							    len);
 				goto out;
 			}
 
-			processed_end = page_offset(page) + PAGE_SIZE - 1;
+			processed_end = folio_pos(folio) + folio_size(folio) - 1;
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
@@ -283,7 +281,8 @@ static noinline int lock_delalloc_pages(struct inode *inode,
 out:
 	folio_batch_release(&fbatch);
 	if (processed_end > start)
-		__unlock_for_delalloc(inode, locked_page, start, processed_end);
+		__unlock_for_delalloc(inode, &locked_folio->page, start,
+				      processed_end);
 	return -EAGAIN;
 }
 
@@ -356,8 +355,8 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 		delalloc_end = delalloc_start + max_bytes - 1;
 
 	/* step two, lock all the folioss after the folios that has start */
-	ret = lock_delalloc_pages(inode, &locked_folio->page,
-				  delalloc_start, delalloc_end);
+	ret = lock_delalloc_folios(inode, locked_folio, delalloc_start,
+				   delalloc_end);
 	ASSERT(!ret || ret == -EAGAIN);
 	if (ret == -EAGAIN) {
 		/* some of the folios are gone, lets avoid looping by
-- 
2.43.0


