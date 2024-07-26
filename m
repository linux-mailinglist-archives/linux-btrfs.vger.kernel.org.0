Return-Path: <linux-btrfs+bounces-6760-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351F093D914
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CC51F248C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF6414A086;
	Fri, 26 Jul 2024 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="r6xTzSPx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80104149E03
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022619; cv=none; b=J8hPUReQN5yFmIASqjBRqpcLtyNb4WPGD9A0H8C3CuoEZ6F9fx/+NSuppjvcZV7l13HadvhDTf2eULV4+QAeT7V7Wq7pjtxYgJ1TP3ahcuxhnm/7P+8BjGz3R+IKW9LW71Zd6DA9BK4ZcU4m/2nU+U8bHWOrf356OQNhiIYaBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022619; c=relaxed/simple;
	bh=RrKlZF4ASZs2BJuUReQ+tnscDatJQ7ZcZLq8kLvFKMY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5m10qnWVuRqureuV0VoXt82bbbkI33+a6reYEmbsKH2ecV7E8/g85lbageiH61FjecoSZCww3PLOCaxSUhro74FTJB+eYpK5VfywBGjAuHkcjFIxAOr7dRyiBZEQwTn3QfGh0ywKANsCn2KSRv5n33GbSEmt+7b4/Zq/mkf9mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=r6xTzSPx; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-66599ca3470so397707b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022617; x=1722627417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6a/M6OQLHFDbam00R0s6KpY830Mlb80NojtuH2K2MnU=;
        b=r6xTzSPxGZuZHUvYLTmYYudl+cMh3iy6U39XWh8gBWgAow0RBBGjxzparSJ84ed7At
         dR44PKFJt3VvVxwsMERRDt6nsz1vUwG6TW4U8xNjkJEH6zkBI11Q6LnsILmhlh4IXxP1
         1pAPK2XO/iMtlUu3NxOFQT5aLCMX8esreUkzXQaJcEotOxa634X694rp+4G9HN4N0VLe
         E3j2uI1AnHTIDnTznp5ycq11RY580YpVjR9tNE/Pa3PHuSa5ZKQHpwqMH/6YZr+2V3VE
         qoOCJJl6WjlzIDWhBV2M6pwIaOVS87DWrpV05Fy7ai6BrNOKSJJTBi5lEdpMOyx/DExN
         uh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022617; x=1722627417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6a/M6OQLHFDbam00R0s6KpY830Mlb80NojtuH2K2MnU=;
        b=rQ6K0+MLNAHdNgILUMJK4Wl6Alu7c6BoCSvWrImLZtegvhdN0ySQEXrIfb+8UQ//yy
         eRBwDAajW+5E0T2OSR5RFyh3rB1kdKi6PIukiAxSH5h6Q4WoVj2jvum42dp3zUw88apE
         Sq18/YObj3auHABPkd7sUOHawcX7f7bY5DW2FNjEk6oSfUnybizu3TmoUFt9b+w+kHmc
         2Ovj7B9BtftHSYHd+aCew6sFvL6bTuTBFnFEm3eeOUqgdqsuPvLN/K+ZhlI8/E1mI/LT
         QTigMnFmK62uFnhTgUr6H/7SoKlXzGLnq1XjjdEOBTFKXkLWzChXXEkB+gqqu8wKGe7f
         o8iA==
X-Gm-Message-State: AOJu0YyuCGkRSLmYSGClv3xqB+IclzK5KX4C8ps6u8WIY7oeqkggu1M7
	D0ygA162JbF36aAxo20lUqwCjSL7coVGW45/vifPCgS+21KSxSoJTFY/4Lw6ZmjcWkN0QlX5Doh
	e
X-Google-Smtp-Source: AGHT+IG7+QnB8p/VxZHVi+aJew5jvEzl5cPj9TwpMgI/beCyEkRtr68NRTaf0S3xkIZK7wm5k0CANQ==
X-Received: by 2002:a05:690c:4803:b0:664:a85d:47c6 with SMTP id 00721157ae682-67a09f4acf5mr8769167b3.33.1722022617416;
        Fri, 26 Jul 2024 12:36:57 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b9be42fsm9744337b3.105.2024.07.26.12.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:57 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 19/46] btrfs: convert __unlock_for_delalloc to take a folio
Date: Fri, 26 Jul 2024 15:36:06 -0400
Message-ID: <3129bd4787f666c793621f9c80e3f15536282381.1722022376.git.josef@toxicpanda.com>
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

All of the callers have a folio at this point, update
__unlock_for_delalloc to take a folio so that it's consistent with its
callers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 33c45b6e8969..46d26f54e9d4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -216,18 +216,18 @@ static void __process_pages_contig(struct address_space *mapping,
 }
 
 static noinline void __unlock_for_delalloc(const struct inode *inode,
-					   const struct page *locked_page,
+					   const struct folio *locked_folio,
 					   u64 start, u64 end)
 {
 	unsigned long index = start >> PAGE_SHIFT;
 	unsigned long end_index = end >> PAGE_SHIFT;
 
-	ASSERT(locked_page);
-	if (index == locked_page->index && end_index == index)
+	ASSERT(locked_folio);
+	if (index == locked_folio->index && end_index == index)
 		return;
 
-	__process_pages_contig(inode->i_mapping, locked_page, start, end,
-			       PAGE_UNLOCK);
+	__process_pages_contig(inode->i_mapping, &locked_folio->page, start,
+			       end, PAGE_UNLOCK);
 }
 
 static noinline int lock_delalloc_folios(struct inode *inode,
@@ -281,7 +281,7 @@ static noinline int lock_delalloc_folios(struct inode *inode,
 out:
 	folio_batch_release(&fbatch);
 	if (processed_end > start)
-		__unlock_for_delalloc(inode, &locked_folio->page, start,
+		__unlock_for_delalloc(inode, locked_folio, start,
 				      processed_end);
 	return -EAGAIN;
 }
@@ -383,8 +383,8 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 
 	unlock_extent(tree, delalloc_start, delalloc_end, &cached_state);
 	if (!ret) {
-		__unlock_for_delalloc(inode, &locked_folio->page,
-			      delalloc_start, delalloc_end);
+		__unlock_for_delalloc(inode, locked_folio, delalloc_start,
+				      delalloc_end);
 		cond_resched();
 		goto again;
 	}
@@ -1266,7 +1266,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			 */
 			unlock_extent(&inode->io_tree, found_start,
 				      found_start + found_len - 1, NULL);
-			__unlock_for_delalloc(&inode->vfs_inode, &folio->page,
+			__unlock_for_delalloc(&inode->vfs_inode, folio,
 					      found_start,
 					      found_start + found_len - 1);
 		}
-- 
2.43.0


