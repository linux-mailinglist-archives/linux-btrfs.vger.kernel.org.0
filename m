Return-Path: <linux-btrfs+bounces-16246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA81B3071B
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF0C6416CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD49392A55;
	Thu, 21 Aug 2025 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KvXv2mkc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA32C391956
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807687; cv=none; b=Wfdi3rSCMsMJux3Fw5TPa4SveGoyXHG/HNhk1XL/PixWOzIMNbWDF0hsf6pSheKqlNuXjJyHu2Tr+9VVXm7UDQbF2NqgXTQE4Ns3HAS4DQck5b0CJWocFGrsXPa11BY68hAfdqPxZeZl9rBxLeoup8G923UdWht2xX6S2JAQo4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807687; c=relaxed/simple;
	bh=i4hePIMWRF5Mzc731oRxQkAAktt67HnoQ6nCM1aZbyw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwJdH94vtgoxvgNyfsqQMBZ20BvRSYJuEUdVqhelxq9LhFMlU5emswYnesOnNc5tUfVWKiF+Iap7fuBGx2GklHiAOOJG3SwYdDDABeYNZqx6Gg6ZPUwrXpckR6oQaHmQVl5JmlQVAE6dUjPjmhVL02NQ5Y/6JeQMe2obU6UBJJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KvXv2mkc; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e95026b33eeso1473749276.1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807685; x=1756412485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ag9tvG0VI18Yk1eq/2xT5jiAIgHSAzuzC353p9H0cHc=;
        b=KvXv2mkcwwtjYomjJXpU7AH9jjeFpZ+w4rnpP2bRduLCuMXcWm7ON3fJpdvhkPRdz6
         nXDB/vfXkpukTP9Vz2l+YEqtf//LPg12OIgaOAMSgpYC4yfXj9drbE+ByoZLXGEQjYFU
         WmIDh1nWva4SitZVFIh7z5wJvQn4b9K79CQtgVwQgCOD3n31Ke3A7hcZhJikZgdQdFWa
         OYuEFMithHzKj9RuH6okpoxgbWMuwiBr8Kd6gaqPnY0guii9GuoZ72B4rWoQhAVVFq+J
         salYIDUSGGCrwhQ3utJg6MTnbg5Gl6tAstLrwHUOleXUh9E9T//WfShqX2at3ggNX0BP
         zYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807685; x=1756412485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ag9tvG0VI18Yk1eq/2xT5jiAIgHSAzuzC353p9H0cHc=;
        b=veqf8rlZIhXqn0EMaqCTExQExk2BmjVVa4l7Qqp76UnJfBf0jK2EvQUXcco6g1Hh3H
         EP/k09amY8C3QbMqgoodFgBTJXPwz90jtluxszSGbU5K+on1oNGRcAgni+zGcOQPayIu
         xL8GWYvRjHLgY/4nc+i8b/2xF3HpSvbAvC3Zdh4WxXEbANiusX2QyZ/Jqss3z0TC65I6
         TxkB7G2kXIfVrz8GVK6lKtIk51h4iEouTczrszx2Zavb82WQBAlGOf4BoqIvrM1I9iWj
         I6OQTuuvino9ElPvBuOEH1dl/zD4Lnd7vFFoU55i1eP/2OP83U4DRr5xSjUNh1KqnOLe
         d3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUupq6RdVXLZ6P+BPyMUHNpKERkS6j1W7mbaps+1I5IblQOhE1WGOW4wVX4ucT8Vo/I2fY724+k91s5oA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFgdJkt7ukRmQ739s+coC6IVzAOJdu9mcGpYT7mo3aHxjBng5F
	6wyveJNzjKkiYlLHw/PPZ6ZXAV8yQibJpJdMUpTiVD7vefcz0z537Su4O0USgYD02Xk=
X-Gm-Gg: ASbGncvHrBNxle/GIUm01Q/294gxUb+g3gDprtELp+4JaXwMS/y6hJqSTPwxhRoJYnl
	jxaNyHtdg7dtz6sU6KDDU+frdtDlN0xuvxpdaZS6vfZQz4oDoH0prnVXKImzWAU+Ku0IL+aMhQ8
	94xGC/+SQg3qM3ylya/fnOU8K6EVAQTEoPHhJTklg+8luZnYzjnZYIQa0e2GPZMZYSGh7RJtl+P
	SJLEtgAn/MLQ5LVgqnPKp7Q/BTGdVgrqmx5Gg1gmvhnL9Ye313xiRiUHInfNAG2hShxCZmpGw87
	CsRYmfwJxivx9JVVbQ+uqBFG3GM6wjV5LP3bgWPk8HPU5zE8xx6lpSgQ9K7+BXyTwWwXvr2bZnu
	6Ss4wc+FfeD3qP3lqOVIHpnXBMlrmMCJ5b2hzQP4CqLxTsyHWaZER+nlaHx11uiHbTb8bEm49he
	YT4elN
X-Google-Smtp-Source: AGHT+IEBylvc7AHp4BniCBq5Q1DyNIynT9BLRz0rP2zm0l1TKcTJo/hsMPaTkP6ZgkuFyU8mOePjTg==
X-Received: by 2002:a05:6902:701:b0:e95:1521:3d93 with SMTP id 3f1490d57ef6-e951d08e7c5mr623429276.15.1755807684641;
        Thu, 21 Aug 2025 13:21:24 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9348b2c51fsm4962060276.7.2025.08.21.13.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 45/50] pnfs: use i_count refcount to determine if the inode is going away
Date: Thu, 21 Aug 2025 16:18:56 -0400
Message-ID: <8b63d783e7896e857380857ec4c40a00e17d8d73.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the I_FREEING and I_CLEAR check in PNFS and replace it with a
i_count reference check, which will indicate that the inode is going
away.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfs/pnfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index a3135b5af7ee..042a5f152068 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -317,7 +317,7 @@ pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 			WARN_ONCE(1, "NFS: BUG unfreed layout segments.\n");
 		pnfs_detach_layout_hdr(lo);
 		/* Notify pnfs_destroy_layout_final() that we're done */
-		if (inode->i_state & (I_FREEING | I_CLEAR))
+		if (refcount_read(&inode->i_count) == 0)
 			wake_up_var_locked(lo, &inode->i_lock);
 		spin_unlock(&inode->i_lock);
 		pnfs_free_layout_hdr(lo);
-- 
2.49.0


