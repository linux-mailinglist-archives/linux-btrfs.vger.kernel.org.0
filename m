Return-Path: <linux-btrfs+bounces-4361-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6C18A8607
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E135283871
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B738F1422B2;
	Wed, 17 Apr 2024 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VjBScrWD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF0013A265
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364574; cv=none; b=p/tP+DjIY6rp7UKv3ZAoeVyfOqdyhB1dA0rwRoaom1RKfgTGH848TUCietyYLRTCYWCISS6zSRP7hcfBacnpmTraA8CizolXHpJBtNLrNBemH3sfIV8DIkA/fARdV9oTT7QPu0568UT+xNwXaqEjS03gC4VPpLDm5zUUMcymQtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364574; c=relaxed/simple;
	bh=I1xVg9V0xkJ521mQAQsZ3RUBKq0wbHpWGCZpKnkczcg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXp7Yok4i2jdTnJQSD9TN9LziR1D8yFA455GV4Db5JOY8rcKoeNN1fP/2dR0AvcuuUUFtofvVhslNtoSyv7vaYrexc9jeqP1obQXZyKuc68PnB1XbIxSL7T2IUr2Ky+5GY4s7VlnplIDVkXwtG7SHnDCNFwcubJ+C65u2AKQzsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VjBScrWD; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c6f785208dso1155056b6e.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364571; x=1713969371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bA84v0pPcuZ2Frux1fDIjQ1ZzIwYtepSYbiQ4b6xNkQ=;
        b=VjBScrWDo+erTf7t37BzXY4sQXz+NW5FEHsOWeVP/Hc7/vGOu0l/PnLJPaVh1VfQzV
         +4qjtGwkVZRHe4HqylZrBh8BZYZUEFMERt7pE9K4HRi9TjwuEfZeB0FrNquWve0XC+sG
         ySj33f8l6/FGU9Es4f8tlP6cX9AvRxMS/9fPGRqOd9owL8B2LeWmkUWUq4jL9Wm8uhcf
         oIMsc/OWf2zkw5VViug85BCYKN+5P5nS0LKmzYMkWMJgTxAf9p0APiNKLeCms15yBipG
         RhKeBOxmTQttezb6QrZ/iip80To5TDrPXntxF7o0UR/g4FKgpCrkdATf29t9BAiqFeJC
         HalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364571; x=1713969371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bA84v0pPcuZ2Frux1fDIjQ1ZzIwYtepSYbiQ4b6xNkQ=;
        b=YX330J5qezMNh7THuDwvU0M/4tIGZllOGGw/piNjuGG3IIRJUl72YN/bRS1E4UL7WZ
         ji+Tqf/sOwQyorjLYZ3EbypoN2C7d9DeHyPnzQSDMpDzqQAAhhxv4TA3VJRBFZUmb1xe
         9vq2J0V4VhzDUnNLeUrOdUr5p+uYpoVyIF9CPyaI1nxFzkQk//kemddCUGUpzDrBcuPL
         8Dpu4J5x6BRzYLqipwq5PuWxzrbpj7cfTQB7pyy9AHd3FonX5zJ44RjSjYHHuhWMrpa5
         yZYFuqVWXK0d2tIllVYvLNx+9ryxSROFfI2BEvjnl0ErXAD4N4NubtNcNZO5zOzFisdz
         VEbA==
X-Gm-Message-State: AOJu0YwxhhiJG0LB1pZeTUTjU8p7pohEfES4xnPtUe2+FmjnGKnZic+a
	WBtua1TwcOKGrD44CLmXVbjHJf/iNoYnI3Z18P5dKfATnOg6jCCEj0OcdoTGbsmsM4LXnDFyPWQ
	f
X-Google-Smtp-Source: AGHT+IFTdMWri6fRspQOnzf17KkkIAGrVPKae4UieuZfLRY5coeRUXGHcbQlNXfONDLHUfV6bU/bCA==
X-Received: by 2002:a05:6808:6284:b0:3c6:7b8:62e9 with SMTP id du4-20020a056808628400b003c607b862e9mr17676744oib.25.1713364571391;
        Wed, 17 Apr 2024 07:36:11 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c13-20020ac86e8d000000b00434a041d310sm8101305qtv.16.2024.04.17.07.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:11 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 04/17] btrfs: move extent bit and page cleanup into cow_file_range_inline
Date: Wed, 17 Apr 2024 10:35:48 -0400
Message-ID: <2d2d537ce3d1843f344ebb88d55f6e830c7fdb28.1713363472.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713363472.git.josef@toxicpanda.com>
References: <cover.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We duplicate the extent cleanup for cow_file_range_inline() in the cow
and compressed case.  The encoded case doesn't need to do cleanup the
same way, so rename cow_file_range_inline to __cow_file_range_inline and
then make cow_file_range_inline handle the extent cleanup appropriately,
and update the callers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 104 +++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 19579439f7f6..6fd866a793bb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -662,11 +662,11 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
  * does the checks required to make sure the data is small enough
  * to fit as an inline extent.
  */
-static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
-					  u64 size, size_t compressed_size,
-					  int compress_type,
-					  struct folio *compressed_folio,
-					  bool update_i_size)
+static noinline int __cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
+					    u64 size, size_t compressed_size,
+					    int compress_type,
+					    struct folio *compressed_folio,
+					    bool update_i_size)
 {
 	struct btrfs_drop_extents_args drop_args = { 0 };
 	struct btrfs_root *root = inode->root;
@@ -737,6 +737,33 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
 	return ret;
 }
 
+static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
+					  u64 end,
+					  size_t compressed_size,
+					  int compress_type,
+					  struct folio *compressed_folio,
+					  bool update_i_size, bool locked)
+{
+	unsigned long clear_flags = EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
+		EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING;
+	u64 size = min_t(u64, i_size_read(&inode->vfs_inode), end + 1);
+	int ret;
+
+	ret = __cow_file_range_inline(inode, offset, size, compressed_size,
+				      compress_type, compressed_folio,
+				      update_i_size);
+	if (ret > 0)
+		return ret;
+
+	if (locked)
+		clear_flags |= EXTENT_LOCKED;
+
+	extent_clear_unlock_delalloc(inode, offset, end, NULL, clear_flags,
+				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
+				     PAGE_END_WRITEBACK);
+	return ret;
+}
+
 struct async_extent {
 	u64 start;
 	u64 ram_size;
@@ -1005,36 +1032,15 @@ static void compress_file_range(struct btrfs_work *work)
 	 * extent for the subpage case.
 	 */
 	if (total_in < actual_end)
-		ret = cow_file_range_inline(inode, start, actual_end, 0,
-					    BTRFS_COMPRESS_NONE, NULL, false);
+		ret = cow_file_range_inline(inode, start, end, 0,
+					    BTRFS_COMPRESS_NONE, NULL, false,
+					    false);
 	else
-		ret = cow_file_range_inline(inode, start, actual_end,
-					    total_compressed, compress_type,
-					    folios[0], false);
+		ret = cow_file_range_inline(inode, start, end, total_compressed,
+					    compress_type, folios[0], false, false);
 	if (ret <= 0) {
-		unsigned long clear_flags = EXTENT_DELALLOC |
-			EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
-			EXTENT_DO_ACCOUNTING;
-
 		if (ret < 0)
 			mapping_set_error(mapping, -EIO);
-
-		/*
-		 * inline extent creation worked or returned error,
-		 * we don't need to create any more async work items.
-		 * Unlock and free up our temp pages.
-		 *
-		 * We use DO_ACCOUNTING here because we need the
-		 * delalloc_release_metadata to be done _after_ we drop
-		 * our outstanding extent for clearing delalloc for this
-		 * range.
-		 */
-		extent_clear_unlock_delalloc(inode, start, end,
-					     NULL,
-					     clear_flags,
-					     PAGE_UNLOCK |
-					     PAGE_START_WRITEBACK |
-					     PAGE_END_WRITEBACK);
 		goto free_pages;
 	}
 
@@ -1344,29 +1350,21 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
 
 	if (!no_inline) {
-		u64 actual_end = min_t(u64, i_size_read(&inode->vfs_inode),
-				       end + 1);
-
 		/* lets try to make an inline extent */
-		ret = cow_file_range_inline(inode, start, actual_end, 0,
-					    BTRFS_COMPRESS_NONE, NULL, false);
-		if (ret == 0) {
+		ret = cow_file_range_inline(inode, start, end, 0,
+					    BTRFS_COMPRESS_NONE, NULL, false,
+					    true);
+		if (ret <= 0) {
 			/*
-			 * We use DO_ACCOUNTING here because we need the
-			 * delalloc_release_metadata to be run _after_ we drop
-			 * our outstanding extent for clearing delalloc for this
-			 * range.
+			 * We succeeded, return 1 so the caller knows we're done
+			 * with this page and already handled the IO.
+			 *
+			 * If there was an error then cow_file_range_inline() has
+			 * already done the cleanup.
 			 */
-			extent_clear_unlock_delalloc(inode, start, end,
-				     NULL,
-				     EXTENT_LOCKED | EXTENT_DELALLOC |
-				     EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
-				     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
-				     PAGE_START_WRITEBACK | PAGE_END_WRITEBACK);
-			ret = 1;
+			if (ret == 0)
+				ret = 1;
 			goto done;
-		} else if (ret < 0) {
-			goto out_unlock;
 		}
 	}
 
@@ -10236,9 +10234,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	/* Try an inline extent first. */
 	if (encoded->unencoded_len == encoded->len &&
 	    encoded->unencoded_offset == 0) {
-		ret = cow_file_range_inline(inode, start, encoded->len,
-					    orig_count, compression, folios[0],
-					    true);
+		ret = __cow_file_range_inline(inode, start, encoded->len,
+					      orig_count, compression, folios[0],
+					      true);
 		if (ret <= 0) {
 			if (ret == 0)
 				ret = orig_count;
-- 
2.43.0


