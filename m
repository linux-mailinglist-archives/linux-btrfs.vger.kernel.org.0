Return-Path: <linux-btrfs+bounces-6771-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ACF93D91F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7EA81F21297
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C5714F118;
	Fri, 26 Jul 2024 19:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xVCgmUzo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDE214EC5B
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022631; cv=none; b=H8FyPd+uktnMe2hJ8ecSv2TT23OnHMnx1fbHWb5uLbq0ONT3R8fCXytCl4u24EibctBGO8PB4RVY14FHeK8b6g+RQlX2DDcBoyLjRbeUiC3k0aTzKY/C24vrH/AJ+Ivhep+pcBh+NytgaCmEnTgCO+UarOZagrmm3UeElO2UQlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022631; c=relaxed/simple;
	bh=5G3U3TSmXg9RnPpmk+o2t+UGa6n6SKoz9RZLNzI3E0c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwgKxoExmGJN2mmjSmwq16Jby7CwR0GwGA8BJjKhGXcMkZEHjv4AQdo0dDSFhA82aoEYZ2dQrtT4oF/TY2bNGQRqEU+cp1G1xz0N29ygwqEIxRZS5kQB2x8kwp03tbavy0Bw9hFRVF+cIMWV6enFkVJsPr0qKtLvznkZ3wnVkUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xVCgmUzo; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e08724b2a08so42284276.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022628; x=1722627428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNZL01EEV5y58njT3yEegxRNXw4HWHN23T70fkxL78k=;
        b=xVCgmUzolCnEmd2NUPmiAeeDR45Do6Iyaq866ho2eD8JxuRRSnXZHRfwqNmo7bs143
         y2WSwED9PO4UmZAFKArriKSM+EqHnVzH1fyRM4zOE9HmagrDsPvJrykZeGCWU6A7LUX2
         Q3/aJ3siYrO+WME9D2VMW96icKChYnLxjSdhYaZWJhKFJAxTlid5S4s3PqZ1XZs1+NDn
         lFMRODVsZQg3fQlPWEqgUJ8An8nRc2UXKnaHCJRA+oV1uJO8Z1+nCCgY7mgIwshGqND6
         PyXdd0iTe946rqT1Ov23JtT7RB8oDlTbWaxYrRLaWrd/LOH0OjGGAPk/3kNydAFvvQBK
         2Ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022628; x=1722627428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNZL01EEV5y58njT3yEegxRNXw4HWHN23T70fkxL78k=;
        b=mkzgJZEHsQDO2h8bm6OctVngh9tsFeOhANh2/sbcKCZ3xgANEJRsPhxwKvJ1Jyo2Jq
         YMQpVvHULqb0NasphYgb5e04OZ8GJ+pg3fen6LUKIx86rl6qtZ1Wb93qbAQmeQMZmu8m
         GrjHi+9v/sLjc0ODrpiBJhpm8CRnklpZOi5UclgY/FcHCB3Z6fjeMXrul4O/b8SmTsSk
         9Sj6dFRZ0qduWKiKpeBltdQ+9zKtCIfQswo011vXF1jyFBAY9hcTPr+FL8QiwEanRB4q
         yXt/fX2a7WGd36jY8mN16/zXGaB4UFXVaY862OL6I/n91vNCJBCjdfJp5uNj1MUQN/AS
         /XDg==
X-Gm-Message-State: AOJu0YyMws1BaFgX0tmBmUgLRqQj3b8ZOKSo//8PtzXiW9KLtSJ8l/iS
	CNwAPEqwmqXvUfmyDUerJwisQgpxle3ytx/2zAsoNKUCCSxs78O3GFS2CI0LD28gYzEmIzKcGTk
	s
X-Google-Smtp-Source: AGHT+IHvBRN35YhK0a8IV+BvKDIwOsZjdr3S4AfnnS42YkYqV0NXTgVmo7roM4HfjXbnRE4LlW6gvg==
X-Received: by 2002:a25:df42:0:b0:e0b:3e24:88c3 with SMTP id 3f1490d57ef6-e0b545a5fadmr937537276.35.1722022628266;
        Fri, 26 Jul 2024 12:37:08 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b2a70e96csm837885276.42.2024.07.26.12.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:07 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 29/46] btrfs: convert btrfs_cleanup_ordered_extents to use folios
Date: Fri, 26 Jul 2024 15:36:16 -0400
Message-ID: <ffa53bd82cea4f66582fa9a5f4f625dde4fc1277.1722022377.git.josef@toxicpanda.com>
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

We walk through pages in this function and clear ordered, and the
function for this uses folios. Update the function to use a folio for
this whole operation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a95bbe602a90..d1c81a368b52 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -399,7 +399,7 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 	unsigned long index = offset >> PAGE_SHIFT;
 	unsigned long end_index = (offset + bytes - 1) >> PAGE_SHIFT;
 	u64 page_start = 0, page_end = 0;
-	struct page *page;
+	struct folio *folio;
 
 	if (locked_page) {
 		page_start = page_offset(locked_page);
@@ -421,9 +421,9 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 			index++;
 			continue;
 		}
-		page = find_get_page(inode->vfs_inode.i_mapping, index);
+		folio = __filemap_get_folio(inode->vfs_inode.i_mapping, index, 0, 0);
 		index++;
-		if (!page)
+		if (IS_ERR(folio))
 			continue;
 
 		/*
@@ -431,9 +431,9 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 		 * range, then btrfs_mark_ordered_io_finished() will handle
 		 * the ordered extent accounting for the range.
 		 */
-		btrfs_folio_clamp_clear_ordered(inode->root->fs_info,
-						page_folio(page), offset, bytes);
-		put_page(page);
+		btrfs_folio_clamp_clear_ordered(inode->root->fs_info, folio,
+						offset, bytes);
+		folio_put(folio);
 	}
 
 	if (locked_page) {
-- 
2.43.0


