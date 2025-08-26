Return-Path: <linux-btrfs+bounces-16401-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33786B36EA1
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887EE980D52
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B21D369999;
	Tue, 26 Aug 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xpekYlcu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A938369354
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222901; cv=none; b=ZZpdBQ+St8VpOOLOUa+aUpD8Anly8sqWBP+mEjKWSFr+T3vHMFqxZuoknp5DdwDiMBfOkZr7pX0XNVPcr1nIgEvlyDc6F/7jCqKrcO4m9cmHe9VvOiB6UbK5gYJFornfG839FQe6mvSQxKonpWPpRWw2KhN7XVHhdWehXxAl9eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222901; c=relaxed/simple;
	bh=sLtWG4tBwYzFayC8el4qA8KAx3MpBYf6WBWbOygRAvQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYpcZio8662jA/FD4zMZsP1BloZY30qiwvf8vT7R/OSML69sVBgXKq3uISZqIZ+Hz65ASmWPrsm7Oxj7+TLAaTnunleN8FfVBNQenGY9fDfCGilPLyseXBsEGOujHxUj5oeTjTpbHTcK0domlP6LcD96nzRIq4EOGS/3zNGanZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xpekYlcu; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d60504788so47005867b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222898; x=1756827698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kMEWwVY5zqmZ8rO1Ng8kME7oWtjO/CBjlFvprNCTeU=;
        b=xpekYlcupzksEPwfTAr3kLtByk1OmAAg2qRR+9hPoBCjq48w6teVYU1+bGy1ngIHtQ
         pS3JCgiGYSNooy4fC38/ecutCCbMOjpqwKwNThPu7bWur6lunTlXmpiEyt/uumFPVL1M
         DM7+VOFKcPnwWDbL+JULui3OtXjDt3U/N+cOT2wfto4W0H1URPi4Ep67HkSNMBZgq+32
         Uq1rcHzlnQm7PIXxj46rtjEJK+E6+YqyHvDLNb5siK1Vw4WEtR4N+2uhwmTV8eE7/RHm
         IZDKT4xAG+9PCuWHQtwChrxqbS5QI4hNoGd5E37ZyaHgnG6VBsRZiQQhJc1wxlLg2k5b
         BLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222898; x=1756827698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kMEWwVY5zqmZ8rO1Ng8kME7oWtjO/CBjlFvprNCTeU=;
        b=FooRSZeg1rf4YeOuMpWSCW90PtYUYctY4IkS6Hj/lpWc2oTi7UFZ0STJfHuTqEr82j
         WOx6+4RaBf75UtdYjS76yXp0X4OtcgoqeBZl3TS7ISxMc6MzcQYzi9uncksjxS9nNuj/
         ZOIAuRymq6wOe4Epvxn8Gy/nzb405fJLFHh8xriipeWilULklQTqIvMzYrUrvf2+r7Tr
         FMiWs7lxDlpZlrP0M7AyWToILAFl/2y0c/kDSDZNms6fywp3c7KYMyWoFdHiFycEK7h0
         hBjdBX1ChAxPujAI0ceG3TcvKw2Z7kNn+K87aEe/fbMvvfSkeFFuJDAOL9dFy8mPXHQb
         rDsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXof4d8KN39z0r2HeTHTHzxj6+f+AYVRdj4HxqlrdIgeOC/CvtpfVQDTIe7wIdh3W1OTpRIAFBEjAOS3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPKFXVbFYxBRrx9hcOqdOrv2ZM7rHIUbcG6oDkvPF6DMCrq6Hp
	mj44O4PgNk3c+9CX8D9/uVHpY78yTHIeBWQ4R8s2BpYAVpYFttFZMGtO14VB+IPk2gM=
X-Gm-Gg: ASbGncuknfX1K7m+XJWrNiImH4uzZEDD/ALt4eCcMl3CMneip3l8C3ynTk669omJHbK
	8fKqeCVilq1alMZLpwqdY9kt3RhiiVN73gVfVj9/a5MzXvnezwoeCDrqV44VOv8L/y87QlgMPbU
	wsZng3kYoW0EYGymYDEGeOYXxURlLU2WKnIq1Pn0Pk+r9NzuPO2rv18pGDIl4MwZMkqvvx981g2
	72SspOXlfDJ+pMASkcshMjzYDDIZqmAHLBmtdau7z0G41Z9n9JePWRu018QwbBfQ+OamJYHVyqZ
	/A5AfB6oWIaN3nNPZ9q/mYOk5OrLY6EdQcJJp8OiPIkhWJEsAX+ce4xKtNXsveenyH/n+OMCvD/
	Se8E/brkxFW5wCczZvGI1rg++lQ0P04kVfM0riut5ryhMwSt/mlrUFQDIXYHpczFdcZ9p3MFBNd
	gmfhIq
X-Google-Smtp-Source: AGHT+IEh6w4J98zHKB0KJJey1JZ+RYFPa+jSq6TTzIF+srA6iK+yY8jmdv8EqkOy5QUDc4KAmX6MNA==
X-Received: by 2002:a05:690c:968b:b0:71b:f56a:d116 with SMTP id 00721157ae682-71fdc2d2454mr170681447b3.2.1756222898334;
        Tue, 26 Aug 2025 08:41:38 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18821e5sm25327457b3.44.2025.08.26.08.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:37 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 34/54] fs: use igrab in drop_pagecache_sb
Date: Tue, 26 Aug 2025 11:39:34 -0400
Message-ID: <b46f72a94ae09aa801b3bc2a80d331ffe0648534.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just use igrab to see if the inode is valid instead of checking
I_FREEING|I_WILL_FREE.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/drop_caches.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 019a8b4eaaf9..852ccf8e84cb 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -23,18 +23,15 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		/*
-		 * We must skip inodes in unusual state. We may also skip
-		 * inodes without pages but we deliberately won't in case
-		 * we need to reschedule to avoid softlockups.
-		 */
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode->i_state & I_NEW) ||
 		    (mapping_empty(inode->i_mapping) && !need_resched())) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&sb->s_inode_list_lock);
 
 		invalidate_mapping_pages(inode->i_mapping, 0, -1);
-- 
2.49.0


