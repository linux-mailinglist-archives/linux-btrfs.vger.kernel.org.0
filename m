Return-Path: <linux-btrfs+bounces-6744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF8493D904
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC8C1F24867
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EB813C9C8;
	Fri, 26 Jul 2024 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RtNs3rjI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9283F4F218
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022603; cv=none; b=MyxanR4KAX/judN1nCZI3r9h2kdHmI0wEfNPbIQxOu5KLk6hxm19XDZ8TLa3k2FXcldWic99ZgZ0MoVgEiKcyoieBUWGbU/4BQ22GfY+eCt6O3VAu7vPFQ+6NJvTgwfqZAqjVE80atdIBx9/eyU2njjX9OShNjIYtPQivhMiGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022603; c=relaxed/simple;
	bh=QAFuT0+trk+M2G01o+RweEYRjOkwm7WV6LU8Et2zAAA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OL015ULPdJx1fEg/T/ir3towTF141W0JeRj6NcjKInKDdqiRDPshySnw1qgouruH8AsuNbUYPpE+iOluyBprOaKVJG4/e7B5Y+9rkwlDei2ICLoLJG4I4oD8KD7fa6JYLg+UXW8gKYUV98x3HuqWIT0+9MadRmghpYqTK6xV+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RtNs3rjI; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6518f8bc182so369617b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022600; x=1722627400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8vayj1vlgmUc4MmgD2SMk6LO/kHTwhSl8jAJKCgvng=;
        b=RtNs3rjIAyDgqPpm7+KUJ9hGCOjSERAQSVYme8I3R8jrcQzIucWjJmmoAZ4cqzZhwo
         d4CAmh2ARA6DqGz/Fkc8c6KZmoXoE0KRcbRQxARcedWcyrPtzkpcGFh0mbGU5fTGq7Us
         bHiOAwF+8Ui8t37aCD43N7yw8rphsqqbfaZLS+V7c9XIAgHO+5xqbFw2EUGHJTL0L9Og
         5AZqlOGX1chHKVhL3Myxcya30FexLNUVIFHb1OVoTphb7h21WOYf0N9jf9CCoWwNb5Fn
         mChF5vThtZgRIPNCo0GObV65WDm1tZNst56hnAJA7Nn8B+NKcgbg+XYeiyOjkhll4gSr
         W2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022600; x=1722627400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8vayj1vlgmUc4MmgD2SMk6LO/kHTwhSl8jAJKCgvng=;
        b=Xyq+ifLpeXJo2jvjFNEY0r8S1Npd/V//57NOBSgAE2SO8EXQlYHcPUSAlnj/AtPUT6
         3YoC8Ni7Q3KI+/BaFCra8uM6gKS2rPjOx9+ZLKOj4HAeu+dN8cJg1ar8yAKCrnMiXYDb
         aSea5wW7+j5MrrHArAqF7VqE6Ak3AWG90r+zzfsM5Z+G4S8XbqEr+CiY8LNlgxMgATQ0
         TuU6USzcdNM9TI2SJlnSqw9NE5++KnBOHHu1rS+a8wAnjqOAnbSVjkxrTekML3Fvh3Tx
         A80M/oRWRerrmpesiJb0/3R0WtIt7YJ4Wn84mQ251FsK2y44o4ng4965RY1h4b96AaRq
         YBhg==
X-Gm-Message-State: AOJu0Yzu+JAaaGrO+7QRTmjxTtsncI6R5h/LiAW7Vx0wUVEgxG7QNCS4
	pObElvQDMVgfHBzKFi1CJhmXaJw6si0vxSfSg5kGelib7kYjjNv6KGLfmkheOoGXQc7Dj4UXmcp
	v
X-Google-Smtp-Source: AGHT+IGV/DSDh7JuYsp1tAcOhckyl+ZNvgSuD+EA/NgUwCn+PjnqQ22tYZ4nq3+1xMYkJ+GlDA7yAw==
X-Received: by 2002:a81:e307:0:b0:61a:d0d8:75f6 with SMTP id 00721157ae682-67a2dee65e9mr5455517b3.24.1722022600331;
        Fri, 26 Jul 2024 12:36:40 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b02492dsm10085947b3.80.2024.07.26.12.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 03/46] btrfs: convert end_page_read to take a folio
Date: Fri, 26 Jul 2024 15:35:50 -0400
Message-ID: <ce72986b4a01c352898429cbb22afd4923558637.1722022376.git.josef@toxicpanda.com>
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

We have this helper function to set the page range uptodate once we're
done reading it, as well as run fsverity against it.  Half of these
functions already take a folio, just rename this to end_folio_read and
then rework it to take a folio instead, and update everything
accordingly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4b7d1881d023..2d6b1bc74109 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -406,30 +406,31 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			       start, end, page_ops);
 }
 
-static bool btrfs_verify_page(struct page *page, u64 start)
+static bool btrfs_verify_folio(struct folio *folio, u64 start, u32 len)
 {
-	if (!fsverity_active(page->mapping->host) ||
-	    PageUptodate(page) ||
-	    start >= i_size_read(page->mapping->host))
+	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
+
+	if (!fsverity_active(folio->mapping->host) ||
+	    btrfs_folio_test_uptodate(fs_info, folio, start, len) ||
+	    start >= i_size_read(folio->mapping->host))
 		return true;
-	return fsverity_verify_page(page);
+	return fsverity_verify_folio(folio);
 }
 
-static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
+static void end_folio_read(struct folio *folio, bool uptodate, u64 start, u32 len)
 {
-	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
-	struct folio *folio = page_folio(page);
+	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
 
-	ASSERT(page_offset(page) <= start &&
-	       start + len <= page_offset(page) + PAGE_SIZE);
+	ASSERT(folio_pos(folio) <= start &&
+	       start + len <= folio_pos(folio) + PAGE_SIZE);
 
-	if (uptodate && btrfs_verify_page(page, start))
+	if (uptodate && btrfs_verify_folio(folio, start, len))
 		btrfs_folio_set_uptodate(fs_info, folio, start, len);
 	else
 		btrfs_folio_clear_uptodate(fs_info, folio, start, len);
 
-	if (!btrfs_is_subpage(fs_info, page->mapping))
-		unlock_page(page);
+	if (!btrfs_is_subpage(fs_info, folio->mapping))
+		folio_unlock(folio);
 	else
 		btrfs_subpage_end_reader(fs_info, folio, start, len);
 }
@@ -642,7 +643,7 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 		}
 
 		/* Update page status and unlock. */
-		end_page_read(folio_page(folio, 0), uptodate, start, len);
+		end_folio_read(folio, uptodate, start, len);
 		endio_readpage_release_extent(&processed, BTRFS_I(inode),
 					      start, end, uptodate);
 	}
@@ -1048,13 +1049,13 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			iosize = PAGE_SIZE - pg_offset;
 			memzero_page(page, pg_offset, iosize);
 			unlock_extent(tree, cur, cur + iosize - 1, NULL);
-			end_page_read(page, true, cur, iosize);
+			end_folio_read(page_folio(page), true, cur, iosize);
 			break;
 		}
 		em = __get_extent_map(inode, page, cur, end - cur + 1, em_cached);
 		if (IS_ERR(em)) {
 			unlock_extent(tree, cur, end, NULL);
-			end_page_read(page, false, cur, end + 1 - cur);
+			end_folio_read(page_folio(page), false, cur, end + 1 - cur);
 			return PTR_ERR(em);
 		}
 		extent_offset = cur - em->start;
@@ -1123,7 +1124,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			memzero_page(page, pg_offset, iosize);
 
 			unlock_extent(tree, cur, cur + iosize - 1, NULL);
-			end_page_read(page, true, cur, iosize);
+			end_folio_read(page_folio(page), true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -1131,7 +1132,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		/* the get_extent function already copied into the page */
 		if (block_start == EXTENT_MAP_INLINE) {
 			unlock_extent(tree, cur, cur + iosize - 1, NULL);
-			end_page_read(page, true, cur, iosize);
+			end_folio_read(page_folio(page), true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -2551,7 +2552,7 @@ static bool folio_range_has_eb(struct btrfs_fs_info *fs_info, struct folio *foli
 			return true;
 		/*
 		 * Even there is no eb refs here, we may still have
-		 * end_page_read() call relying on page::private.
+		 * end_folio_read() call relying on page::private.
 		 */
 		if (atomic_read(&subpage->readers))
 			return true;
-- 
2.43.0


