Return-Path: <linux-btrfs+bounces-6765-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2553993D919
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B45F8B2412E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E4B38DEE;
	Fri, 26 Jul 2024 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ChlF9Ck3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E38114A4D9
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022625; cv=none; b=minYKHEB8MxrDvTlLLcj19SbZ0kX5G1mrfiVU8Ta1lwyI0S5dZQSWqSDdL6X6vDpwUncYC/7H8fjKagTKY4aw9gM1OIciJ5Vui0nwGnurOLGea5I8RsX1dhFpKzq+Vs99LxdSF6238xfWGV2obYf/SFO5u3LIW0/jHcnBJMtO1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022625; c=relaxed/simple;
	bh=G5QmXgbeZN7sW1CiPFlxbcRq8RJ/9s+FS97PZ8BDM4M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUUEkUmbJ0b5kkVBkixan3hMYdNjJbTfqFFudxuer+1dKiNp9Sh3yEqT65MXzUKo3vumCr21XlgLejzNiExsrKTe8w2MR17vcf4DMbj7lIl9pJlX18Of8E0mne6/ZCE6g0GevLvcC3SseiTErqvdJb/M2jMqqQ1ZiouvPb06rnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ChlF9Ck3; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-65f7bd30546so309327b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022623; x=1722627423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAl883lvg1XhBMGcxrpSf80GLO9WAjlmZP6Mki4ERcs=;
        b=ChlF9Ck3yskJyfChDaM/l5nanSu0xv57VlhNNT5cN6881P028g3/xqw1r9TVbcrr4T
         YsfdC2GTa1YNIli+mJsea/bJHhK4eEwOJc8rfadm5o2sT+MCUt0dzb695JoFerYxJR0s
         mVOhFWNu3lvVINnIk57lAFGOmQLnLVIZ+c/Rt7mPhwH/JyLkxJsW/Pr9UQ2i5IvzUB0y
         TJLpWEt+8zJJ3ptRAKWu3G/MkOH2qvvylznOGQNKQMqtwRbhIE2T/U3jChULTE1ZFaED
         TxRKwVon4fxk9Y2GGDfOQKwaqd10LOlOxVtjwhB3QWeFlPVa++o1RN6/9c8AfzT7Y7PL
         aitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022623; x=1722627423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAl883lvg1XhBMGcxrpSf80GLO9WAjlmZP6Mki4ERcs=;
        b=jWplKiV7XhmaWvu2zqrK8tKK3/ZnZAFnLToguymRNcPTvvc4X2X63nJVhfEEbXhG4N
         JKMf49ZJSsUh+H4fhTN6BJKQVek+e7+AryUf65w8gvXCJMmtcpAYjDfZIgdsT7FM+IG4
         tSMQ8GW8jYcoxD4zSKYYlUOScMTrOcdNirR7N/R7cHnDMia8+UnVVUvJU/RBC/Fx6tqR
         DOnyeeedYKcnFQ+6AFmZzNWKBykBpQkM92dL7Sch6mkTstRv2GbY2H4/Q/oHxUAYEf5x
         3FpqAnoGtskjcvISGpO/ahEE/bPtZyTVFFSicJYKn+FYby4pWwuT7vSZEQu3EQQepUID
         1UDA==
X-Gm-Message-State: AOJu0YzUBqMTT6hM/LdmIxFLCMQwHEeBLPM9KZFHcLtD1FIr1aDWVds/
	ZitRJI0pKkLKde0MGJsMhXkiSMJr0X99CsXK86ByWxJJiOyqy+K3lsJ/yx2dlCLNKrZcCGHOAF9
	T
X-Google-Smtp-Source: AGHT+IFlp+s5uPPcrU5scxQnYuwRuSI/3N3ts/PEWCqCIy78q8oZ9OoFLX52GvooCKNBi8CeyKzR+Q==
X-Received: by 2002:a0d:d003:0:b0:64b:b7e:3313 with SMTP id 00721157ae682-67a2aa8d551mr5943577b3.13.1722022622827;
        Fri, 26 Jul 2024 12:37:02 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756795e987sm9925517b3.39.2024.07.26.12.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:02 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 24/46] btrfs: convert run_delalloc_cow to take a folio
Date: Fri, 26 Jul 2024 15:36:11 -0400
Message-ID: <73b6c02da1433a120f243616086e6ae751893b7e.1722022376.git.josef@toxicpanda.com>
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

We pass the folio into extent_write_locked_range, go ahead and take a
folio to pass along, and update the callers to pass in a folio.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0b44a250e5b8..db0aa7ece99c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -116,7 +116,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr);
 static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback);
 
 static noinline int run_delalloc_cow(struct btrfs_inode *inode,
-				     struct page *locked_page, u64 start,
+				     struct folio *locked_folio, u64 start,
 				     u64 end, struct writeback_control *wbc,
 				     bool pages_dirty);
 
@@ -1135,7 +1135,8 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 	};
 
 	wbc_attach_fdatawrite_inode(&wbc, &inode->vfs_inode);
-	ret = run_delalloc_cow(inode, locked_page, start, end, &wbc, false);
+	ret = run_delalloc_cow(inode, page_folio(locked_page), start, end,
+			       &wbc, false);
 	wbc_detach_inode(&wbc);
 	if (ret < 0) {
 		btrfs_cleanup_ordered_extents(inode, locked_page, start, end - start + 1);
@@ -1746,7 +1747,7 @@ static bool run_delalloc_compressed(struct btrfs_inode *inode,
  * covered by the range.
  */
 static noinline int run_delalloc_cow(struct btrfs_inode *inode,
-				     struct page *locked_page, u64 start,
+				     struct folio *locked_folio, u64 start,
 				     u64 end, struct writeback_control *wbc,
 				     bool pages_dirty)
 {
@@ -1754,13 +1755,12 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 	int ret;
 
 	while (start <= end) {
-		ret = cow_file_range(inode, locked_page, start, end, &done_offset,
-				     true, false);
+		ret = cow_file_range(inode, &locked_folio->page, start, end,
+				     &done_offset, true, false);
 		if (ret)
 			return ret;
-		extent_write_locked_range(&inode->vfs_inode,
-					  page_folio(locked_page), start,
-					  done_offset, wbc, pages_dirty);
+		extent_write_locked_range(&inode->vfs_inode, locked_folio,
+					  start, done_offset, wbc, pages_dirty);
 		start = done_offset + 1;
 	}
 
@@ -2311,8 +2311,8 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 		return 1;
 
 	if (zoned)
-		ret = run_delalloc_cow(inode, locked_page, start, end, wbc,
-				       true);
+		ret = run_delalloc_cow(inode, page_folio(locked_page), start,
+				       end, wbc, true);
 	else
 		ret = cow_file_range(inode, locked_page, start, end, NULL,
 				     false, false);
-- 
2.43.0


