Return-Path: <linux-btrfs+bounces-4371-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0626D8A8611
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF401F22772
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530C5142651;
	Wed, 17 Apr 2024 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="nFEy1zF4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A95F1428E9
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364585; cv=none; b=FFqly3j4/klRm5UngtbjRF06EP3jErdsMCTYOzzJfAXg71HKQKppG2oE/IWdPiq9m30omq3wRGRjUSCQ648TT05aRliLwgIL65+PqHtc2fhsx5ThFkGuQtBlXaPQTHQt5MzNT9J6lfDgZ67fBMRlMuJk4NNfAGk0Mk7L4ehgaMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364585; c=relaxed/simple;
	bh=S4DB2KyL24PDQ3QrHKRE6kBeakEA6gyS7cGLqSjFUfA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6uugy2SlF47gBJMD07pw8TqHWn43wUhJKK5Eock/lAi5WZSYge8gWx2Q0apsaGV1q8R5sRbey7h4LknhkgymOaGGbO1LvGxqQMoJIJSyhka70YYimeC/+C9QnVyZvwV/K1gRU+8tX0g8Q2YTrgAuWsZTu7AynjdrA2i4Uf7t2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=nFEy1zF4; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6969388c36fso26104966d6.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364583; x=1713969383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltGptI0NULH55aKTgcoIDOFsYFDmCyE/kf+mo9mKdyQ=;
        b=nFEy1zF4mGuwBnW806713IDBEWubhEO7hd2zauWN7tOrb2Uf6Fog2QpEbECriwIHe8
         VzMfYymt7roj3TOVkl30svYf0WJNRetR+6N94TVypD5F6MB/T6hFOknKw9Pk/W/YLzZz
         DX1eZo+cuXMG+qv5EgGVYSsdlpSd7/hRfzEOVSv0LAAWsyWD8QXHcB3DSCgvokZv8maI
         LVH++Sf9OrlUkBksHaie/RZ/R/7VZnwDVsE+/XyAivVTOr0WU5spoK6PpaVwZDWtnYZa
         jeQJc/UHbr7ziwp9x0tD1MCMnIMsEKowOvWIHhKeqfa+7hPQpn5k8Gjo5HAXENgQttgi
         3ZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364583; x=1713969383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltGptI0NULH55aKTgcoIDOFsYFDmCyE/kf+mo9mKdyQ=;
        b=TjbcDhyr744NkuOV2amjWpO9ISqeOx6rmQVrf7O1+eLb8I/bCpdgpsYdreGQoIQLxs
         pOhmqzf+rSjLWl4Ydrwx3149+HpumeIQw9ESEDvu2IbrnWHOSWD/T95sLSRrubEABD1u
         73crpDbipc3vJTFlI0qXt46rUbMRTWMkbc2s2g6G/El0B2bmXrXJIXjwhBHvvQEv8sic
         vZ/vCoIdrrtmcjRPwZXikhthgAxdHn1CDjqO9ntBQT/FDGIulHC+Jgi3+Cl0TQz0iDEq
         uzxZcmOxYm5m7H+y4sDEjYGnBp5aExNeCXHiWMw45X0okV5SCD9x2qnZCB+uv7QCgQdX
         pXSQ==
X-Gm-Message-State: AOJu0Yx6MJ/DXrEf4FyrY6JtXgtAyPeCWjdZfqB3WEiB3+qcdG/15G7h
	zoLzQolzUcAn8/89IAkj6COwYpiTfbLLwzt4DocFKA1YnTHF9wS5lePd2HQHHLTDQJqxzzoOyNh
	/
X-Google-Smtp-Source: AGHT+IHBHon1uARnY0WEspELQjNgDm3pAnrT/gZeJD3EYDnM2rPA4l7D5eGgllPhqJeoyzaXz39HHQ==
X-Received: by 2002:a0c:f64e:0:b0:699:2754:2e8b with SMTP id s14-20020a0cf64e000000b0069927542e8bmr17580063qvm.39.1713364582917;
        Wed, 17 Apr 2024 07:36:22 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e19-20020a056214163300b00691873a7748sm8396643qvw.128.2024.04.17.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:22 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 14/17] btrfs: move can_cow_file_range_inline() outside of the extent lock
Date: Wed, 17 Apr 2024 10:35:58 -0400
Message-ID: <258a6eaf5c9b672fdadea6264e3fb9b795e1a179.1713363472.git.josef@toxicpanda.com>
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

These checks aren't reliant on the extent lock.  Move this up into
cow_file_range_inline(), and then update encoded writes to call this
check before calling __cow_file_range_inline().  This will allow us to
skip the extent lock if we're not able to inline the given extent.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fcad740b1e28..07bdad6f1be0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -661,6 +661,9 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
  * conditionally insert an inline extent into the file.  This
  * does the checks required to make sure the data is small enough
  * to fit as an inline extent.
+ *
+ * If being used directly, you must have already checked we're allowed to cow
+ * the range by getting true from can_cow_file_range_inline().
  */
 static noinline int __cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
 					    u64 size, size_t compressed_size,
@@ -676,9 +679,6 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode, u64 offse
 	int ret;
 	struct btrfs_path *path;
 
-	if (!can_cow_file_range_inline(inode, offset, size, compressed_size))
-		return 1;
-
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -750,6 +750,9 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
 	u64 size = min_t(u64, i_size_read(&inode->vfs_inode), end + 1);
 	int ret;
 
+	if (!can_cow_file_range_inline(inode, offset, size, compressed_size))
+		return 1;
+
 	lock_extent(&inode->io_tree, offset, end, &cached);
 	ret = __cow_file_range_inline(inode, offset, size, compressed_size,
 				      compress_type, compressed_folio,
@@ -10250,7 +10253,8 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 
 	/* Try an inline extent first. */
 	if (encoded->unencoded_len == encoded->len &&
-	    encoded->unencoded_offset == 0) {
+	    encoded->unencoded_offset == 0 &&
+	    can_cow_file_range_inline(inode, start, encoded->len, orig_count)) {
 		ret = __cow_file_range_inline(inode, start, encoded->len,
 					      orig_count, compression, folios[0],
 					      true);
-- 
2.43.0


