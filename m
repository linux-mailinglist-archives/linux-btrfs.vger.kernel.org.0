Return-Path: <linux-btrfs+bounces-6749-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BB193D909
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1591C229E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E481474D7;
	Fri, 26 Jul 2024 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="vq2G8wRj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4A1143C6A
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022608; cv=none; b=HucHQXa7pag7PLUXGDqprSe05bC0MLzUqxYL2JA8SopIFkxYIr7K2Qs6pdVhtx26z9mIV/ZwhNkqJjsvY3wHFLsM2/B+v09VqTGaCDTAtrY94+ZIbFbUayT2XXFe7trCdR3UQUyl0it2Ksd+TbnvpYt1ptVmG+dsadlYhFmesGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022608; c=relaxed/simple;
	bh=smJ3oJGi/hR7bVqUSKm5VxzskmNoj2QriIrYoBI2+xg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRvP+pofL/fr6uO7vw29+B0E8mg9U0k9eKpM2WPS5HdYOb6H3kx8ReOf8kxmeDrzJqCTYDQGfR+bA7CsOvn3FjJLRXVrfGna2qGsjhnxm3/g3D3XZD23zLGzvKX6rvC6mHwFoLJgFIJdp7eEjUyfxEXTAPwttnJq9q6AD5+FCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=vq2G8wRj; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-66ca536621cso365387b3.3
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022606; x=1722627406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=su8I1Qi4RIXhQjrMv08oU20JDQbK08zGBUZyC/v4mMg=;
        b=vq2G8wRjUzMe7Z3gYKq4Z5g0CWixIFbhZonWZ6qNUQ1dIHsiZoOQwgPVgM/xmWpinv
         0qxhjrAlFpKZXbw557S/La2BQJ6Zqdgs+I+IBsBSrbglKpchNvF8gfFFG+apakdX2hkX
         F+BqeMuD2UsQL4aQs2dh3Jk1mMGEVc6kAzbKqPJw75RzJDa+b1mT48YgZQ5MIjMT+gdF
         o62Q2b2pfS/ENlwqvZIBV3z75gO9W5313pP45C3fzUxE8dYPS0P8kcT3VTBvD0m4QmRd
         gmIiDKdFyRoh+DMhihiDeakJiS4F+dAGM+A8e3HefbkC98pUvUeaDhAiDf92L/8GDMAY
         8F3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022606; x=1722627406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=su8I1Qi4RIXhQjrMv08oU20JDQbK08zGBUZyC/v4mMg=;
        b=ElEKGQZgJma1c7/gJVQxWt8GUw7kaHFZHt/9ApxkuPxaLMEDJ+ZZbXU2n6QibxWPwp
         LxHKVLkzwbOmUnai331VC65L4QD2a0Ge9M0vvmix0iYiSZPT6BLVcF8Y5LZCb85V7Scq
         jSymwOZvSjmmGsKkcrSHDTTG7bJvP5iaBxFrPgP3GEPMTowdaLMD66UEVpwmk3S76EfQ
         eApx5LhmWtikVxunKK3qoH6APcdAD2Ro1zBXHsI6TlHNHyivQi9uFsCimFlLqsalM6XG
         2gpYKt969jr3yz3RCmK+AIdxigjJ7PjlBllom5uc9F4E0RqvR3Ipboj+XaycoZCg2lon
         rkBA==
X-Gm-Message-State: AOJu0YzXjJ0hYwqGW0XxoGJLNLtK+JE04Tu28UcSt/HzhdoWSwXFumSv
	eP0mKEVqTeUOnCJQoHEI0oLwXqZmOGtzq8Q2Ee6s12CgOX8LBtu3rZ4iG6U9D1soaAWpWuq/ZaH
	c
X-Google-Smtp-Source: AGHT+IGJdsMl9fnb9+j11YbwHFM/3LOMiUeKFMT1ApKCV0emioVh1skissxa4yz3Ol4qwmiMkFUzGg==
X-Received: by 2002:a05:690c:ed3:b0:631:4dc:f6e5 with SMTP id 00721157ae682-67a090a5ef6mr9225397b3.36.1722022605767;
        Fri, 26 Jul 2024 12:36:45 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b9bd90dsm9852267b3.104.2024.07.26.12.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:45 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 08/46] btrfs: convert __extent_writepage_io to take a folio
Date: Fri, 26 Jul 2024 15:35:55 -0400
Message-ID: <206c887fcee49fbcf0a246f55256b9f56b3f63c4.1722022376.git.josef@toxicpanda.com>
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

__extent_writepage_io uses page everywhere, but a lot of these functions
take a folio.  Convert it to use the folio based helpers, and then
change it to take a folio as an argument and update its callers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 50 ++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index eed2be8afb15..63ec7efd307f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1393,10 +1393,10 @@ static void find_next_dirty_byte(const struct btrfs_fs_info *fs_info,
  * < 0 if there were errors (page still locked)
  */
 static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
-				 struct page *page, u64 start, u32 len,
-				 struct btrfs_bio_ctrl *bio_ctrl,
-				 loff_t i_size,
-				 int *nr_ret)
+						    struct folio *folio,
+						    u64 start, u32 len,
+						    struct btrfs_bio_ctrl *bio_ctrl,
+						    loff_t i_size, int *nr_ret)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 cur = start;
@@ -1407,14 +1407,14 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	int ret = 0;
 	int nr = 0;
 
-	ASSERT(start >= page_offset(page) &&
-	       start + len <= page_offset(page) + PAGE_SIZE);
+	ASSERT(start >= folio_pos(folio) &&
+	       start + len <= folio_pos(folio) + folio_size(folio));
 
-	ret = btrfs_writepage_cow_fixup(page);
+	ret = btrfs_writepage_cow_fixup(&folio->page);
 	if (ret) {
 		/* Fixup worker will requeue */
-		redirty_page_for_writepage(bio_ctrl->wbc, page);
-		unlock_page(page);
+		folio_redirty_for_writepage(bio_ctrl->wbc, folio);
+		folio_unlock(folio);
 		return 1;
 	}
 
@@ -1428,21 +1428,21 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		u32 iosize;
 
 		if (cur >= i_size) {
-			btrfs_mark_ordered_io_finished(inode, page, cur, len,
-						       true);
+			btrfs_mark_ordered_io_finished(inode, &folio->page, cur,
+						       len, true);
 			/*
 			 * This range is beyond i_size, thus we don't need to
 			 * bother writing back.
 			 * But we still need to clear the dirty subpage bit, or
-			 * the next time the page gets dirtied, we will try to
+			 * the next time the folio gets dirtied, we will try to
 			 * writeback the sectors with subpage dirty bits,
 			 * causing writeback without ordered extent.
 			 */
-			btrfs_folio_clear_dirty(fs_info, page_folio(page), cur, len);
+			btrfs_folio_clear_dirty(fs_info, folio, cur, len);
 			break;
 		}
 
-		find_next_dirty_byte(fs_info, page, &dirty_range_start,
+		find_next_dirty_byte(fs_info, &folio->page, &dirty_range_start,
 				     &dirty_range_end);
 		if (cur < dirty_range_start) {
 			cur = dirty_range_start;
@@ -1478,33 +1478,33 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		em = NULL;
 
 		btrfs_set_range_writeback(inode, cur, cur + iosize - 1);
-		if (!PageWriteback(page)) {
+		if (!folio_test_writeback(folio)) {
 			btrfs_err(inode->root->fs_info,
-				   "page %lu not writeback, cur %llu end %llu",
-			       page->index, cur, end);
+				   "folio %lu not writeback, cur %llu end %llu",
+			       folio->index, cur, end);
 		}
 
 		/*
 		 * Although the PageDirty bit is cleared before entering this
 		 * function, subpage dirty bit is not cleared.
 		 * So clear subpage dirty bit here so next time we won't submit
-		 * page for range already written to disk.
+		 * folio for range already written to disk.
 		 */
-		btrfs_folio_clear_dirty(fs_info, page_folio(page), cur, iosize);
+		btrfs_folio_clear_dirty(fs_info, folio, cur, iosize);
 
-		submit_extent_folio(bio_ctrl, disk_bytenr, page_folio(page),
-				    iosize, cur - page_offset(page));
+		submit_extent_folio(bio_ctrl, disk_bytenr, folio,
+				    iosize, cur - folio_pos(folio));
 		cur += iosize;
 		nr++;
 	}
 
-	btrfs_folio_assert_not_dirty(fs_info, page_folio(page), start, len);
+	btrfs_folio_assert_not_dirty(fs_info, folio, start, len);
 	*nr_ret = nr;
 	return 0;
 
 out_error:
 	/*
-	 * If we finish without problem, we should not only clear page dirty,
+	 * If we finish without problem, we should not only clear folio dirty,
 	 * but also empty subpage dirty bits
 	 */
 	*nr_ret = nr;
@@ -1556,7 +1556,7 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 	if (ret)
 		goto done;
 
-	ret = __extent_writepage_io(BTRFS_I(inode), page, page_offset(page),
+	ret = __extent_writepage_io(BTRFS_I(inode), folio, folio_pos(folio),
 				    PAGE_SIZE, bio_ctrl, i_size, &nr);
 	if (ret == 1)
 		return 0;
@@ -2308,7 +2308,7 @@ void extent_write_locked_range(struct inode *inode, const struct page *locked_pa
 		if (pages_dirty && page != locked_page)
 			ASSERT(PageDirty(page));
 
-		ret = __extent_writepage_io(BTRFS_I(inode), page, cur, cur_len,
+		ret = __extent_writepage_io(BTRFS_I(inode), page_folio(page), cur, cur_len,
 					    &bio_ctrl, i_size, &nr);
 		if (ret == 1)
 			goto next_page;
-- 
2.43.0


