Return-Path: <linux-btrfs+bounces-4364-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FCE8A860A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279671F22C8A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378981422D5;
	Wed, 17 Apr 2024 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="3SDmYmO4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CCE1422BF
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364577; cv=none; b=XIS06+8ZFfiTYagCkx7kscAT58vouzAvyydP922+6hzUMT4QJfaSCf8fNz0ZwyoVMkd/iRqRdZ1BQBU7NQ9g4burPfod+SqAPBmF9IUWRF8WY9y4DKqlaaH/Ake0tWyxVr0ByUbt1UvTHNlfUvnCx1aSQyEwW/m8l96ZyWGbkow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364577; c=relaxed/simple;
	bh=Y/gwUlYFE7XZUYr6RVyHboVF9XH8QXiMUBqwlD483Mg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V23Swfkq/TGvzRZEkgY4BoSEyqApKbFQYbc7qEaLkZO+xbo1mlUjp3v8PTDihWqimeVptDkNWBHrdgtEN5zCc3BGRJ+2PTgqjVOfalh6w8xl2qByaEZYnL5XwSlOn1sLmQ9gbrYtfOE6MOt+m9BaK59zicaZja7Wtf1BXvdJPSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=3SDmYmO4; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c728a8035eso895543b6e.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364575; x=1713969375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Is08mh5q7jLBmz9q8sss+4lFjRXXFzHZn7k/nmeAvTs=;
        b=3SDmYmO4h1Mhp+rNcIdUeXNMxhXJq+OaztObOKxRNjaQG1CpFoOagPWs2X2sherGbv
         0+U82JwmGWBYQiSibW/81COo26C/cF26qRml3RCzmFNeVGnDkaPO88K+9ltCcy3NTLAr
         0AybQXtB1mVXcUbc81XWl/fUJxlANL8iYu9gf1dvTwTUutldd6yNeBkZTBXez7RQcHIx
         rQaWg6Eu783BKxHEwQDUSEL9f+noBka5WViyYp4PtfvDyXM/iv5r8ZQIwiupjfHIRo/o
         oMvZXvrZ3cVppeTSQjnKz8Tg3VX/OOzjLCUCXc+/U/0G0u4z4IjchjJJMAi06gi9vxyU
         Jwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364575; x=1713969375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Is08mh5q7jLBmz9q8sss+4lFjRXXFzHZn7k/nmeAvTs=;
        b=gP6L/B+wk1AGscn1P2/hMl6bmbMd3k+lA0w2uMyepfMP9VswMlALFwvA/2FsBqEGT7
         FxJ9ykQrI1TKx5fGZlddmNrAHozZOTMD8Mmvoe/Pm8cuN+xKhgsGuwyfCGDFYBzVnS//
         384HEPgPBI/2gHJvgjbgGDG6LqTDmq09/rXavmS1fc0dFzCP7Op/uLX0fu7+3kRjKuzp
         4J89F3yqU8xPRJgeMmo+HTH+fILpTZ0ZaTIj8ExG3eT4bQOPmpLlx6076vZoiB3xTtFL
         lz20p7AKeONmzsNatuDGlwr3REYQPkYHeWy8/McTCoiSatek9MT9sUOJexF43nxbhi99
         jzaA==
X-Gm-Message-State: AOJu0YzdFLU1gZBnM3JbbeiwIAXG9ZjDaoIA7aSduG3QeMt8CPs/BO5w
	ljy/gbsxlamqV1vQAWUyn6LU/JkuyUqPMR0wXtUYatqmap5NvLar5aVYdNlSiHgPwK3zimGufeL
	f
X-Google-Smtp-Source: AGHT+IGfTvNU8p5PUsvclA0VUACF52egFMeXmlxeL0DCYUyZjMCFLZVF/UKwn9f5Dn0q/bREgw39cA==
X-Received: by 2002:a05:6808:b27:b0:3c7:79c:72c9 with SMTP id t7-20020a0568080b2700b003c7079c72c9mr13597740oij.54.1713364575105;
        Wed, 17 Apr 2024 07:36:15 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id f4-20020a05620a20c400b0078d4732d92fsm8421929qka.115.2024.04.17.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 07/17] btrfs: push extent lock into run_delalloc_nocow
Date: Wed, 17 Apr 2024 10:35:51 -0400
Message-ID: <60f8e6362e50086d796d8cdd44031d9496398b08.1713363472.git.josef@toxicpanda.com>
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

run_delalloc_nocow is a bit special as it walks through the file extents
for the inode and determines what it can nocow and what it can't.  This
is the more complicated area for extent locking, so start with this
function.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2083005f2828..f14b3cecce47 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1977,6 +1977,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	 */
 	ASSERT(!btrfs_is_zoned(fs_info) || btrfs_is_data_reloc_root(root));
 
+	lock_extent(&inode->io_tree, start, end, NULL);
+
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
@@ -2249,11 +2251,6 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
 	int ret;
 
-	/*
-	 * We're unlocked by the different fill functions below.
-	 */
-	lock_extent(&inode->io_tree, start, end, NULL);
-
 	/*
 	 * The range must cover part of the @locked_page, or a return of 1
 	 * can confuse the caller.
@@ -2266,6 +2263,11 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 		goto out;
 	}
 
+	/*
+	 * We're unlocked by the different fill functions below.
+	 */
+	lock_extent(&inode->io_tree, start, end, NULL);
+
 	if (btrfs_inode_can_compress(inode) &&
 	    inode_need_compress(inode, start, end) &&
 	    run_delalloc_compressed(inode, locked_page, start, end, wbc))
-- 
2.43.0


