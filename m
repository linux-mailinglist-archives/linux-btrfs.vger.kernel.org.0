Return-Path: <linux-btrfs+bounces-6751-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1AD93D90B
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABA61C230E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139B5149018;
	Fri, 26 Jul 2024 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ayUgLa6I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2010146A7D
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022610; cv=none; b=AiDx7WmlfALMpz6dRATlQWIT909UCs0GWZ7rOZXGJaDotF5lza7sqMt3+gJY4WztgUsAD8AQwelukb/rrz7LIaA6VpTxzgcO3FyP3iGWd6XeqjoiATIU/nLCprIQjKvk9QQXDsc1z1GJeneSR23cEhsTC4/jeWLWfYuJiR/ktMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022610; c=relaxed/simple;
	bh=vRrpX6Kgy2Vbi7oe3Xoy+DLXJlW2rKujOJW0hBAuGHI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPQYHNmjQHnYzO/8csrd6CeZmhBMG4ZOC687EGowDrIR1HVNMAwZzss50i5HZpNRKGPOwGaMOYUAjsu8qzpU980DJs8Varijd3db1MWXGpV2NuA/Dx6JSSfC20o18UMtvrACRYlL+1Vv0NOJjoZytihIAMnVvMKop6f7fREXgPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ayUgLa6I; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-654cf0a069eso438247b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022608; x=1722627408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTbWb29wHaRmWuDNJdN7gFQyOcLAcSOY6phM460fSR8=;
        b=ayUgLa6ILmGgVxCOl0OCs+qBoXeeAFQ0Hro/g7s8Vnawy5qm4qBihJ6wYAEWWf73uD
         wD9oW+n9BxLDyi0m1tBWB3cJXjeTzBgGE0jw7VE8cor02uIBzL/dC7Xfl3Bvzs5a8+wH
         XvoA0wJIvwy2pg1+hO9/tGZVwo3SWEMrVd8D/xWbRCbkF+eZWx0U15eqnyPrjSZ9DsP8
         tAtw10p155+znh+OFu5VoSurvv7X+ogN665A3l0fE9tpl4dH0Qz/WtbX/pWzSy+y0K74
         MyyNONz5nXqlPSXvCwt6T5pv9xv2GVfAhrQmhgQAiAXQ7MLGOiMmOEhL9Z8aoypPRn6U
         6u5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022608; x=1722627408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTbWb29wHaRmWuDNJdN7gFQyOcLAcSOY6phM460fSR8=;
        b=dsfKa5Z1pjHWho/QkYPVp43CeXmm/j02iehfAKiUX4brZeYzY+/AJL2MA7TLtgKoT4
         bVkX1oTzPTWWklJVTgcCcMPYCvRU8omzgf2lLms0lCQtcVZeBpCsgt647xZdEF7MmATv
         0fZaJ9OE092hzMSHp1QPYXyjLjabN8q+xu9/g5g0j8LAAEdfNxFb4NlgDWgBvwIaiVue
         ADUNbakIzIhAIWiy3p2+9vIgVPaJ6spkg0q//0pxPUt24sIfjs21JtJmimxlwYhr0r8v
         jwbaiR8/fYInPDRYFzO6zzhMsSGfrpogWrL1YlYlG7NJDXu5relT2zFtgJK/PCNkanAg
         dxog==
X-Gm-Message-State: AOJu0YwS5jwBLZ7rujOd0gf2gEwqeadNAfRzIGotCC9pfvwoPMPo5EIQ
	C+YAtGFHFWq/y+n/Cf3cud2pcCB0YJv1HDIAZ0nCpX4D95jtkUn407izLM+dsCuZiuTmtw9Avjr
	8
X-Google-Smtp-Source: AGHT+IFwmGcDkU1aWw8D9eor1p8lmQDUVhY4PJUZJJi04+T1m/qU+FPt10iKKlI3qzWm/8WEAr/IIw==
X-Received: by 2002:a0d:c641:0:b0:65f:e307:d41 with SMTP id 00721157ae682-67a06a0c051mr9753907b3.16.1722022607750;
        Fri, 26 Jul 2024 12:36:47 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756795e61csm10032237b3.42.2024.07.26.12.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:47 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 10/46] btrfs: convert __extent_writepage to be completely folio based
Date: Fri, 26 Jul 2024 15:35:57 -0400
Message-ID: <b53fe9dd059e05c9179048acedb4a977dd649d30.1722022376.git.josef@toxicpanda.com>
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

Now that we've gotten most of the helpers updated to only take a folio,
update __extent_writepage to only deal in folios.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a04fc920b0e6..da60ec1e866a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1520,11 +1520,10 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
  * Return 0 if everything goes well.
  * Return <0 for error.
  */
-static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl)
+static int __extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl)
 {
-	struct folio *folio = page_folio(page);
-	struct inode *inode = page->mapping->host;
-	const u64 page_start = page_offset(page);
+	struct inode *inode = folio->mapping->host;
+	const u64 page_start = folio_pos(folio);
 	int ret;
 	int nr = 0;
 	size_t pg_offset;
@@ -1533,24 +1532,24 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 
 	trace___extent_writepage(folio, inode, bio_ctrl->wbc);
 
-	WARN_ON(!PageLocked(page));
+	WARN_ON(!folio_test_locked(folio));
 
-	pg_offset = offset_in_page(i_size);
-	if (page->index > end_index ||
-	   (page->index == end_index && !pg_offset)) {
+	pg_offset = offset_in_folio(folio, i_size);
+	if (folio->index > end_index ||
+	   (folio->index == end_index && !pg_offset)) {
 		folio_invalidate(folio, 0, folio_size(folio));
 		folio_unlock(folio);
 		return 0;
 	}
 
-	if (page->index == end_index)
-		memzero_page(page, pg_offset, PAGE_SIZE - pg_offset);
+	if (folio->index == end_index)
+		folio_zero_range(folio, pg_offset, folio_size(folio) - pg_offset);
 
-	ret = set_page_extent_mapped(page);
+	ret = set_folio_extent_mapped(folio);
 	if (ret < 0)
 		goto done;
 
-	ret = writepage_delalloc(BTRFS_I(inode), page, bio_ctrl->wbc);
+	ret = writepage_delalloc(BTRFS_I(inode), &folio->page, bio_ctrl->wbc);
 	if (ret == 1)
 		return 0;
 	if (ret)
@@ -1566,13 +1565,13 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 done:
 	if (nr == 0) {
 		/* make sure the mapping tag for page dirty gets cleared */
-		set_page_writeback(page);
-		end_page_writeback(page);
+		folio_start_writeback(folio);
+		folio_end_writeback(folio);
 	}
 	if (ret) {
-		btrfs_mark_ordered_io_finished(BTRFS_I(inode), page, page_start,
-					       PAGE_SIZE, !ret);
-		mapping_set_error(page->mapping, ret);
+		btrfs_mark_ordered_io_finished(BTRFS_I(inode), &folio->page,
+					       page_start, PAGE_SIZE, !ret);
+		mapping_set_error(folio->mapping, ret);
 	}
 
 	btrfs_folio_end_all_writers(inode_to_fs_info(inode), folio);
@@ -2229,7 +2228,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 				continue;
 			}
 
-			ret = __extent_writepage(&folio->page, bio_ctrl);
+			ret = __extent_writepage(folio, bio_ctrl);
 			if (ret < 0) {
 				done = 1;
 				break;
-- 
2.43.0


