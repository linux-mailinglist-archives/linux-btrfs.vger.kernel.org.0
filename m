Return-Path: <linux-btrfs+bounces-6769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3584793D91D
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F511C23177
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7935A143C6C;
	Fri, 26 Jul 2024 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XKx10GLt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6B014D452
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022629; cv=none; b=MikGo+mtqk7n4pFQt875z66gvRWMlWLzeiS6K9Udf8/yAu/lkigRZj0YlG/0JiMgxhdFvGW9mwTcv1nrE2sUG3wcnqS3ksSxoVR/LGR0ZSrZfkmXJJNX5/BVIzlUOdekDhFPin4FuHwhEmjttOVETI3lFEsvm+2ufZlFA0OuqLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022629; c=relaxed/simple;
	bh=Lbzscw7kPcK8mkNODc2TNedVk7EESONz8/mxZ7ackbw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YL0w0vTGUw9+g4gs+ufe4ANtRu3QOZOPkWhTgE10ShrAybeJLlFYrUROH3dFNabh0HqzSkyGGQ8GlRNcK0+klaFYmIoBspYeRnA8fCTO4T6AaqKsHw6EoEftmKgIHYic3McsdChRsjr0c99hQQaJQZ8F6jqLbh06i47ep7Xcc2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XKx10GLt; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-65f9708c50dso380687b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022627; x=1722627427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L96GEfBJihYonB/f3nQJxYnSMQmpL2icIBjt4xmg9mE=;
        b=XKx10GLtiDvBwNxiQDJZUrYp+oqueu92RLjQzWgB4SGHT5iMTpULVTdkOLIea9bzwR
         Q0e/BFP1SlnXdEhv5wr1EjL8+xtHc154nycWmby6QRBvrizW9XIFauxBVrjwQrD4PQaV
         g8BBbthKAV5Qq7I89A8485OIbvnWZb92F+uM7x+KeJfnw2ZzciQEoPtSSjMMXy2UH4oI
         t20CK4p8ITcZWm4DdDhYLxsGTK10FhXZGaqtCwL53FYmGkebziKWnCySvh126Km7TKd+
         gvO6MTDdcd/oOfbiYcvHjUUtYuV86ZSXqfFrgjBXrUVz5Ene29QzGHtEJTslX4DqcacX
         TKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022627; x=1722627427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L96GEfBJihYonB/f3nQJxYnSMQmpL2icIBjt4xmg9mE=;
        b=t8HuiNQE0s55Oe44yjAmmMglmm49IDXhDhdIgLCNDnh0LCgZPzVqG6SWDBf4qey8ZG
         lI9TKkg7tcWlWgf/wxeMZan9KdnBIf3gdFohYYPzVWwnamTxOi9IFlBVyTVWxGBp/GXn
         Ylq+UV+rWDXrRc8WoFjntf9zoDI2A43VdRN+cAAIsiiaFCJsbFbgt546tHnnj3cTaq6u
         PYOJPtPAemCrc0157R+2B+Wlc+N14TxZBJR9wQJVpe3m4bX5ORcSgdEpto2N86Zuq0lp
         PJaQGJnJGFXoAZzzo4ca9GDnEiRdoKG7pVaNMTZuoNEGXxsphulprz6+hYnfAyW1Ydmo
         blow==
X-Gm-Message-State: AOJu0YyOmDHDDbJlqUQrTiK2a6kPZptmFB/f+yN2OjwvhIdrFwB/542l
	pPflBMlUhTByaBlpM6u11jVDXcoP/BP0BZ7GVg5Srla6nBwlErxREnc6Vk1ty+JW0vDt9463J6O
	A
X-Google-Smtp-Source: AGHT+IH7Ff8GwzE2cYfgqwSfd2bSVybcPwFwCi3snf4klVFSgbj+voxWYYrZz8XWz3qY4ORzUUErfg==
X-Received: by 2002:a05:690c:6d8a:b0:64a:489c:4fbc with SMTP id 00721157ae682-67a0a8f4c59mr9438277b3.46.1722022627334;
        Fri, 26 Jul 2024 12:37:07 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd90fesm9841827b3.20.2024.07.26.12.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:07 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 28/46] btrfs: convert run_delalloc_nocow to take a folio
Date: Fri, 26 Jul 2024 15:36:15 -0400
Message-ID: <617a72ec73fd6c1b850ab36fde82e53075c03c38.1722022377.git.josef@toxicpanda.com>
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

Now all of the functions that use locked_page in run_delalloc_nocow take
a folio, update it to take a folio and update the caller.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d8ff1bb188e1..a95bbe602a90 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1989,7 +1989,7 @@ static int can_nocow_file_extent(struct btrfs_path *path,
  * blocks on disk
  */
 static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
-				       struct page *locked_page,
+				       struct folio *locked_folio,
 				       const u64 start, const u64 end)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -2152,8 +2152,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		 * NOCOW, following one which needs to be COW'ed
 		 */
 		if (cow_start != (u64)-1) {
-			ret = fallback_to_cow(inode, page_folio(locked_page),
-					      cow_start, found_key.offset - 1);
+			ret = fallback_to_cow(inode, locked_folio, cow_start,
+					      found_key.offset - 1);
 			cow_start = (u64)-1;
 			if (ret) {
 				btrfs_dec_nocow_writers(nocow_bg);
@@ -2208,8 +2208,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		btrfs_put_ordered_extent(ordered);
 
 		extent_clear_unlock_delalloc(inode, cur_offset, nocow_end,
-					     page_folio(locked_page),
-					     &cached_state,
+					     locked_folio, &cached_state,
 					     EXTENT_LOCKED | EXTENT_DELALLOC |
 					     EXTENT_CLEAR_DATA_RESV,
 					     PAGE_UNLOCK | PAGE_SET_ORDERED);
@@ -2231,8 +2230,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 	if (cow_start != (u64)-1) {
 		cur_offset = end;
-		ret = fallback_to_cow(inode, page_folio(locked_page), cow_start,
-				      end);
+		ret = fallback_to_cow(inode, locked_folio, cow_start, end);
 		cow_start = (u64)-1;
 		if (ret)
 			goto error;
@@ -2259,7 +2257,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 		lock_extent(&inode->io_tree, cur_offset, end, &cached);
 		extent_clear_unlock_delalloc(inode, cur_offset, end,
-					     page_folio(locked_page), &cached,
+					     locked_folio, &cached,
 					     EXTENT_LOCKED | EXTENT_DELALLOC |
 					     EXTENT_DEFRAG |
 					     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
@@ -2300,7 +2298,8 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 		 start >= page_offset(locked_page) + PAGE_SIZE));
 
 	if (should_nocow(inode, start, end)) {
-		ret = run_delalloc_nocow(inode, locked_page, start, end);
+		ret = run_delalloc_nocow(inode, page_folio(locked_page), start,
+					 end);
 		goto out;
 	}
 
-- 
2.43.0


