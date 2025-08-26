Return-Path: <linux-btrfs+bounces-16407-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAA2B36EA4
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570F01BC0A83
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F57370581;
	Tue, 26 Aug 2025 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="A5otpevE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5908736CC8E
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222909; cv=none; b=GUxhj7ByMpfzHrJWKdu+qMeqtHvNvg/RBRMWYqEeBOw88RVDgfnWHF/rCI8yRyguvL7eceY9MYcrX3/c9TRmYgtHLkB9bgsXlK8C3DH1kjb+KpZBZrqJPvr9mAfQb6MDyAndgrUpZvjMNJQTrzuEKWM1R4o5wQdfSiC74uqkBaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222909; c=relaxed/simple;
	bh=m+sUlUspLqIWAgATvlSwBwWt4KCBlddh6LFbQXfkBEM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F41kg3DVXsOnHrcxZUos/l3fQWyUSyH970fFmK3oJpPgdsxuQOUgDjo+5oJ6ZUncxGdzd/zPkUwty6tXaOOPjCy+CHAwn4RXFvSuIBHWQX5eWIqCCEXvOgdYpnj7gRXGleEJtmLq0KOqEpHDXKc5ZCWktvN3jczit0E6X0rnyas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=A5otpevE; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d60110772so49949007b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222907; x=1756827707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alkILxWqr/LmCgOsh2PuAUd8yboXHrvMnPHss+yxiwA=;
        b=A5otpevEudPAs2Kt9rfSBPzBPiuKCs+hcdFzHIZEMFDr1jJwHa8At7JaBTOxPGWb7l
         v1kQmy5SiVNZl1bbfjo2pzkMkzWV2dwJIYb/bzQbs8u2KncqvyNeBR9NfrC3YF4NX0xH
         j+l/FRJvAzTa8zz77CZLmsunLOGJWALjzm/ykm21a2+bG+U4e3uIQ0uh8oAQSk1nZhBG
         7ilc5GnvNR88mBjDCc7Rso17LapQx/KfqTobIwQ+V7GXSCNK3muZ9YPvBTcSVQMgf0Jk
         bJp8gbWdBuKgm80egAPoot3L8ezkAw7lKXN195FwxZP90Noa62N0NOxbxXwH/l62alv7
         23Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222907; x=1756827707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alkILxWqr/LmCgOsh2PuAUd8yboXHrvMnPHss+yxiwA=;
        b=FVjOX8tbtsL9jtjSZbR++tcCV6rpRjFyVmat14yAIttK3jr9YIAgJVGs/9qx9gB7vG
         fEQomWOYEKyMmbzYo4UekAgNHXBZe80drZxyAlkCZcz/Jn9N4wmzeRDGBjvjkVlmI+D9
         F/DS6VSN9bf1oF7ykH66EMakGkysIqGmPPDRhfvkZLZ//yPY6SJ0izul3IKlBU+pHzsF
         nzNOYPXH9MhlR4TkrJPrG9XBhWwLZRvX/6z6aVBTGT5H+Wkk9TszH5B0DI2tMgcjhWxK
         ZY6qgsQuTFA2Rcaa1RK22L+Ly70D9l2u+2kt3wzNhwJppLGu0l0m89C8ecBJPgy6EiDF
         NA/w==
X-Forwarded-Encrypted: i=1; AJvYcCX7CXAao+TMyHASVmKoYH19PsakYwvpFGFaRyXQ9FRvHEPv7LWcs69M2qbpoH9LkF1fjXzR520L8EjsWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFyMSZDBg2Qj9BFH5OXwj99xgYjlqLSF0HkBVUIN+E/BOObKv4
	kJ4JeKQYRqUOhejLmhfOh0/TCqc9/yqRsW3nWYsU5xTpxQsHeBXYHK81h8ZbxWwYHLk=
X-Gm-Gg: ASbGnctmKoRGEerY85kCNJeKYvyiXRsUzPYUd4QYxHAX6PrUjDxZN0bHBXF0Fr6p1g/
	IR4bahmEwc2CFTSDxWVC47zmNRZ2G/OHPxWts0w60iHtSqxChAME9dybDiZf3EDhfVefqdr6uZT
	4ojnz/8u7KVpCQt23wSDHuWczkT0gqi3jeNqBjvB9b8iiEC4P1/UOdOIoRu46YPIs9UBll5JN+o
	OxTL0q8Z7bpt3mHQbRXcQtHMRzeDWpn/OjvE11B9rF18JQp96R3hhhqw8dLu31Q3lU2OPOAlNqa
	nxNtJYWlTgMJw4EBAIWPgHdW7hTyGlqiAOC+9IP4EGCh+rvPaQY3P1fK3ZhX2jqgNv2IPs7iM3T
	Q9rg6Ol636DKjbp53WYptaudgEKYhqWTFdCw9FlLVjJocMsWit8bmV5e7oku4OUtpIuAw+A==
X-Google-Smtp-Source: AGHT+IHEY7UiuwZsDzTPmXSQVgcvtXTUxA/hqZfermlmHJkxzpNIVBJ6NmVxvNzn0Yu9TKer1jXgcw==
X-Received: by 2002:a05:690c:5:b0:71a:42a3:7b47 with SMTP id 00721157ae682-71fdc10b936mr194714767b3.0.1756222907406;
        Tue, 26 Aug 2025 08:41:47 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18b4198sm25314047b3.66.2025.08.26.08.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:46 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 40/54] notify: remove I_WILL_FREE|I_FREEING checks in fsnotify_unmount_inodes
Date: Tue, 26 Aug 2025 11:39:40 -0400
Message-ID: <2d97e6a9ac8347779762684ddd720fa8ec53a7c7.1756222465.git.josef@toxicpanda.com>
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

We can now just use igrab() to make sure we've got a live inode and
remove the I_WILL_FREE|I_FREEING checks.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fsnotify.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 46bfc543f946..25996ad2a130 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -46,33 +46,15 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		/*
-		 * We cannot __iget() an inode in state I_FREEING,
-		 * I_WILL_FREE, or I_NEW which is fine because by that point
-		 * the inode cannot have any associated watches.
-		 */
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
+		if (inode->i_state & I_NEW) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-
-		/*
-		 * If i_count is zero, the inode cannot have any watches and
-		 * doing an __iget/iput with SB_ACTIVE clear would actually
-		 * evict all inodes with zero i_count from icache which is
-		 * unnecessarily violent and may in fact be illegal to do.
-		 * However, we should have been called /after/ evict_inodes
-		 * removed all zero refcount inodes, in any case.  Test to
-		 * be sure.
-		 */
-		if (!icount_read(inode)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&sb->s_inode_list_lock);
 
 		iput(iput_inode);
-- 
2.49.0


