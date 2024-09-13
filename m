Return-Path: <linux-btrfs+bounces-8011-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F27B6978A91
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 23:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B0528317D
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 21:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01606154C09;
	Fri, 13 Sep 2024 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/ulXfDQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C1D126BFE
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726262881; cv=none; b=sNjtPGn9YrP3QoJ3OfXKlpySQdp8Z1A01zfF38hktQpuvAoZjR7b0BZ8gICbU7UJGr0qFDuFzegY9+DJeE74V3oonW8eOLhykkFULBz1/llAk2gcahxC4O/C3i13RPTHaG474YVJKdaNP4pucEo/AFYExQqnPVSOfkMGAm8O7xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726262881; c=relaxed/simple;
	bh=lI31/9wjux2QFG00msZIjgioDg3pJS2ReGNzs0r0qME=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TFgB2fyq/OGnDffxHOczth8BSGkyfzUHjabfbp9rO41oQWUbgZ81NLvLy7EelHW8KHdQbMmibV+nJiAXqPysdDPjxsyvYTsN4QWgLNt9RdK2lYM4DNzS7WsvnCqX/DhoNfB2fChAkBAAKMEkn7PzyyTJ9Y4tk4gs8fSCXkdWCLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/ulXfDQ; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-277c28fac92so931710fac.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 14:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726262878; x=1726867678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VolWcbyVvPMFtJvkbwPNtoPMtbo0+wlSnTxocPbT02o=;
        b=Q/ulXfDQs2rKvnhluITnk6iziq1tuJtA7Iz7tbJkiLh0rB5njc4dV6KEFKVGDbYMzm
         ktro4xWf3hTN27EesgxEm1l4GQIcwpxiXDaSorr5zbwjIotZkoh/108qTxKd/zI8ZrXi
         PKpnonT663QvUsF793NrL1EzcpTo5sgF1jgg2PyA5qqy0B2fAd0SBpSIqXs0JoXBk/2J
         +p/Rcl5A5L/TzFdFqioiMkXFajPkX/rl+hRFTrHWDM/gD2uOchK1Mspnq3T5n9sXxUKJ
         HaIhE/qYImLWnLHL7RqnuMhQjCZutc8zMGDJFah82Fsygil7YkOMy9RQBITlzOwGef7h
         icCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726262878; x=1726867678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VolWcbyVvPMFtJvkbwPNtoPMtbo0+wlSnTxocPbT02o=;
        b=rnUWZSGLlIHb5cycKnWD24Y3opNKHPUDY9bap0mbQ0HnOaWyhI+F/897HSyq205TCI
         BzV9jNdm1x+Wc/mDjzf7mv2TnlUe8q6sTKWdRBcrph3+5qbQ4OfAL6qLw7+mgzE+zp6Y
         4dHyEhFJEqent/QtCitpxMQqNAKnkERWNvRZqLNaBg/WWYHn5jgroZOBVG9hIQGrZpDW
         /Crsjl5/qKQ3XVWCu3b89IbxQyMAKVQBreFhmLQFtLmSSBjqFRL8jpBdgCENlqEwFSu2
         JeHe1tuCT1cO2noV02D2mFhjZQ/2jS5uxzZp9UvkgUyPUe2FD4EuxZmjr2OIO69uubhF
         RZeA==
X-Gm-Message-State: AOJu0Yz/7Neoj4bupGMp3wCq+nLV0fk5IVOG86fKrmbCy6dQtj4ZzOaV
	oBf4yPmO0yFn4jwgU1P7R/1EwPNY1dpnrwP9Yy0oBNG9nQqk6YJLJglpfks1
X-Google-Smtp-Source: AGHT+IH4WkwO2YbrmqM3uQ1ivbHU5u3WevKgzPT1MDshCDp2/nMVgnm66sY5AV2QFBy5XPuNmFi3PQ==
X-Received: by 2002:a05:687c:2c52:b0:261:19a6:41ae with SMTP id 586e51a60fabf-27c68bd631fmr2768615fac.30.1726262878490;
        Fri, 13 Sep 2024 14:27:58 -0700 (PDT)
Received: from localhost (fwdproxy-eag-002.fbsv.net. [2a03:2880:3ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-27c956738d6sm72040fac.15.2024.09.13.14.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 14:27:58 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: set flag to message when ratelimited
Date: Fri, 13 Sep 2024 14:26:06 -0700
Message-ID: <0628fc55984c3507c5365d4e1d5ed96d28693939.1726261774.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set RATELIMIT_MSG_ON_RELEASE flag to send a message when being
ratelimited. During some recent debugging not realizing that
logs were being ratelimited caused some confusion so making
sure there is a warning seems prudent.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/messages.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index 77752eec125d9..22316067bde75 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -199,14 +199,22 @@ static const char * const logtypes[] = {
  * messages doesn't cause more important ones to be dropped.
  */
 static struct ratelimit_state printk_limits[] = {
-	RATELIMIT_STATE_INIT(printk_limits[0], DEFAULT_RATELIMIT_INTERVAL, 100),
-	RATELIMIT_STATE_INIT(printk_limits[1], DEFAULT_RATELIMIT_INTERVAL, 100),
-	RATELIMIT_STATE_INIT(printk_limits[2], DEFAULT_RATELIMIT_INTERVAL, 100),
-	RATELIMIT_STATE_INIT(printk_limits[3], DEFAULT_RATELIMIT_INTERVAL, 100),
-	RATELIMIT_STATE_INIT(printk_limits[4], DEFAULT_RATELIMIT_INTERVAL, 100),
-	RATELIMIT_STATE_INIT(printk_limits[5], DEFAULT_RATELIMIT_INTERVAL, 100),
-	RATELIMIT_STATE_INIT(printk_limits[6], DEFAULT_RATELIMIT_INTERVAL, 100),
-	RATELIMIT_STATE_INIT(printk_limits[7], DEFAULT_RATELIMIT_INTERVAL, 100),
+	RATELIMIT_STATE_INIT_FLAGS(printk_limits[0], DEFAULT_RATELIMIT_INTERVAL,
+				   100, RATELIMIT_MSG_ON_RELEASE),
+	RATELIMIT_STATE_INIT_FLAGS(printk_limits[1], DEFAULT_RATELIMIT_INTERVAL,
+				   100, RATELIMIT_MSG_ON_RELEASE),
+	RATELIMIT_STATE_INIT_FLAGS(printk_limits[2], DEFAULT_RATELIMIT_INTERVAL,
+				   100, RATELIMIT_MSG_ON_RELEASE),
+	RATELIMIT_STATE_INIT_FLAGS(printk_limits[3], DEFAULT_RATELIMIT_INTERVAL,
+				   100, RATELIMIT_MSG_ON_RELEASE),
+	RATELIMIT_STATE_INIT_FLAGS(printk_limits[4], DEFAULT_RATELIMIT_INTERVAL,
+				   100, RATELIMIT_MSG_ON_RELEASE),
+	RATELIMIT_STATE_INIT_FLAGS(printk_limits[5], DEFAULT_RATELIMIT_INTERVAL,
+				   100, RATELIMIT_MSG_ON_RELEASE),
+	RATELIMIT_STATE_INIT_FLAGS(printk_limits[6], DEFAULT_RATELIMIT_INTERVAL,
+				   100, RATELIMIT_MSG_ON_RELEASE),
+	RATELIMIT_STATE_INIT_FLAGS(printk_limits[7], DEFAULT_RATELIMIT_INTERVAL,
+				   100, RATELIMIT_MSG_ON_RELEASE),
 };
 
 void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
-- 
2.43.5


