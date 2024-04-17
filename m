Return-Path: <linux-btrfs+bounces-4372-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3629F8A8613
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678251C20BE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84137142900;
	Wed, 17 Apr 2024 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="1zjt0FGw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA9714265A
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364586; cv=none; b=NyCGNK6xsOSYh0H8GuoKVK5IowKoK6lF54tsjOE6hqOgxEO2ZqxiywNqNMXUDr65QTw3Iiih2PR72Xc7WWQ8oMiQl+ADIpH0nHTDDgXVeM+FZCOfgsDLd+PpkuV7D0C46mIm34bUVAPf/g8paLlTmMcN10xekqpfsshUPamO+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364586; c=relaxed/simple;
	bh=MGTATfq0PPuX1WHLcU2cuFlCB4SjIhuYg5gcTDpSSsw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uy7GM2zyLSR0BH/Q8B+tekqxazwfOwwPUfYYzWHunCE+ZqmepsEbvwMaiGdWFODaGyfoo5su9w/h2MmzF3188zmq+LnDNWhjeZ3Vjt+FFgkHihEWUJ/6aytjIGUCoi10rR5WAUdtwUDbIT/NaJV8qsVuK1TYfylcvU8vnfDwj1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=1zjt0FGw; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78f05341128so27524985a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364584; x=1713969384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LMzRYIyEoeGd2D2KPyCGUgzPh7V3w4v3izx882BOpoo=;
        b=1zjt0FGwrQUgW4dEAsnXGTDtRYPUDe4aOr59pyF9CI+NCymGB8TjRjOtkQjZkxP2wE
         FjcXegf/iRakFYDYPQDsI/h5KyEvYJQgzEFS5mCoqaPl2lUvly3kbq3THkk6+snIyKRO
         QCsJPPq25bs9dFk8bUWIIn9TJflpLO4NAHCFatcHkGW6afB4X5sohYSRX/SHq4SbABOd
         AuK2SSe/e4nXksXJi/C2j4KUn6qUFeB4PaVeOWWtHwxDTVBpBXoJdClNXLJZQrLgPR9h
         21iqiqJsEq6DZL3Djz5NPqbmDoId8PUfhz+4NAI6wQOVXlnREvAkEHU3RMegp1k//aIW
         xY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364584; x=1713969384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMzRYIyEoeGd2D2KPyCGUgzPh7V3w4v3izx882BOpoo=;
        b=BW4ChL7+dIGhfFYXvHMNwdzzW9yKy5wqupiDLM2T20uv9zjSMQoUI/4jSpPvvb4cBB
         o0PyLqYO+m36/zqVk4bUfk8anJT6Y9RQ/WjD5X3RX9Qp3g4rbUtgKgcrMYX9MltmCI/N
         toQzdGFh7c8p9Vyk7gC138nevtWC1Ir3nwS/gel4G5sWc1Z3i6WoobjrIrZWspBn7ygp
         1ZqmukMVva/XP0DamqmwNLpqJdqZzyYDibP0fbWcgaB9n96nfDdvoFLfYpww1/lXXVXw
         pnBRjEYFw3nEtmxuFF3RmiL++97uEeCGuo9MxC6I2Dyxk54YyU1CXmWmvQj2LRIvROWa
         hNXw==
X-Gm-Message-State: AOJu0YwyWeKRXNGMO5jeN7RaFMhXxOCZiV10X4fmdb/5h2VoGN5rQLcJ
	ttMjGjq9IaAfysYRscZ2N9NFdxSTxD8UT/xaaSAjy6z6Czcrlf6Ckyc363fAmey0phov8UdevcO
	V
X-Google-Smtp-Source: AGHT+IH4FbYC2bppPjGjTYZ4MWlSIKV9loXpqP5mbqJcM/RW78mVURNReFHKTnxmgUe5ivtj5hL5sA==
X-Received: by 2002:a05:620a:471f:b0:78d:777e:c11f with SMTP id bs31-20020a05620a471f00b0078d777ec11fmr22568339qkb.57.1713364584097;
        Wed, 17 Apr 2024 07:36:24 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v23-20020a05620a0a9700b0078ebb13a03csm8415405qkg.67.2024.04.17.07.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 15/17] btrfs: push lock_extent down in cow_file_range()
Date: Wed, 17 Apr 2024 10:35:59 -0400
Message-ID: <88e255b855e917caa3ca7c2ffca2f3d974a6cce6.1713363472.git.josef@toxicpanda.com>
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

Now that we've got the extent lock pushed into cow_file_range() we can
push it further down into the allocation loop.  This allows us to only
hold the extent lock during the dropping of the extent map range and
inserting the ordered extent.

This makes the error case a little trickier as we'll now have to lock
the range before clearing any of the other extent bits for the range,
but this is the error path so is less performance critical.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 07bdad6f1be0..3cd092fab31d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1371,8 +1371,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		}
 	}
 
-	lock_extent(&inode->io_tree, start, end, NULL);
-
 	alloc_hint = get_extent_allocation_hint(inode, start, num_bytes);
 
 	/*
@@ -1429,6 +1427,9 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		extent_reserved = true;
 
 		ram_size = ins.offset;
+
+		lock_extent(&inode->io_tree, start, start + ram_size - 1, NULL);
+
 		em = create_io_em(inode, start, ins.offset, /* len */
 				  start, /* orig_start */
 				  ins.objectid, /* block_start */
@@ -1438,6 +1439,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 				  BTRFS_COMPRESS_NONE, /* compress_type */
 				  BTRFS_ORDERED_REGULAR /* type */);
 		if (IS_ERR(em)) {
+			unlock_extent(&inode->io_tree, start,
+				      start + ram_size - 1, NULL);
 			ret = PTR_ERR(em);
 			goto out_reserve;
 		}
@@ -1448,6 +1451,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 					0, 1 << BTRFS_ORDERED_REGULAR,
 					BTRFS_COMPRESS_NONE);
 		if (IS_ERR(ordered)) {
+			unlock_extent(&inode->io_tree, start,
+				      start + ram_size - 1, NULL);
 			ret = PTR_ERR(ordered);
 			goto out_drop_extent_cache;
 		}
@@ -1549,6 +1554,13 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 					     locked_page, 0, page_ops);
 	}
 
+	/*
+	 * At this point we're unlocked, we want to make sure we're only
+	 * clearing these flags under the extent lock, so lock the rest of the
+	 * range and clear everything up.
+	 */
+	lock_extent(&inode->io_tree, start, end, NULL);
+
 	/*
 	 * For the range (2). If we reserved an extent for our delalloc range
 	 * (or a subrange) and failed to create the respective ordered extent,
-- 
2.43.0


