Return-Path: <linux-btrfs+bounces-9539-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A99A9C5FAA
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 18:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017BA1F2456E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 17:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43BD2185B8;
	Tue, 12 Nov 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="TiqP3RUy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483DD215010
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434201; cv=none; b=lBvqvtoKkfR5eze7gaej2OhOraetowL/pdzv5IkKIRUiA7NQtY5/22kBfzABenw5O5iJ/n8JKPHSm4Nuv/LXxTh5QTYIPCYTNiG8eP8IGCB9b7vOaO5dbU8eXZo7usd5/YoCIEBIwrx84FAQm/WPlNyhnotWdGq9i0GUzCqLCsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434201; c=relaxed/simple;
	bh=64cnq185QNR6dzOyatVzX6ysDD8I9dUVc8gWhEVGl4M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiwWdQKjuJogUDPE9iy9K4B2mLwfINjUXWTLZEXF9Z/jCzLYIy3BFCnFLZ8i3zn+6EdBY1QpW2hMS7GTKUxM+cIAFkaCZEKOLyPIKqzPo5r0O4SJqDzDagXLYl+nLxAEFoDevQLnPCnL9ZMmdf0HooMTr54/SM8JG1afoh7gVIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=TiqP3RUy; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ecaa45af7bso8831407b3.3
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 09:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434199; x=1732038999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/zk511lAvWJc9DDqLFXDlls0KrGnQ6iorjj31bM1x8=;
        b=TiqP3RUywJbAy1kPokHMhca+SF0rkF32q8t2qs8tsECnuYHdBjgGetgIXhipYA0Tgj
         dSjJxaO/0azpq6t5H5fnQhvFmJcjvtO0qq+6q4CJyttgUNFLAsSrDGGHqPmvrsiFKkGN
         9+mtRjeS/dT4IV7J+SRTPV1bhcrwd81JSsg48IjMKr1JgTBqpMebC5iJRXkdLyP9aiuq
         v76xRWQfXqL0c2IyeSLLuc/QFYZhMUvCnztKPebsPLmVZHsSB4l1hZHkVltjfHPL4SFJ
         CKvjhq1zARR/d6kp6g3VR59X4lrYOYje6wcsRW62oa7Jo7jRE1l8T23CIqeYyMx7jNAn
         JmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434199; x=1732038999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/zk511lAvWJc9DDqLFXDlls0KrGnQ6iorjj31bM1x8=;
        b=J09Uze3+apd6yikfBMtOE9HMGl6DnEqVsc1WgN+wUbRm15xVeqPMy+FAF18rwsVwIe
         niLkadW/lyx7cpWhFuQPrHof+avZeb2+5msPWric//Ed96XgILNpbRr/b+uNiTJ9gwVr
         88w/1D6U13Gvnp2O98GboKJmfHHT8c0KdkOyDvQ7zOjM+7IwgsDVD8QvlAVaEykNNWyJ
         rF61JfEyfYELnN5Bzwzut2c9U64LrHkUaxTW3cokQ1+pVhNM0LZxfnA76CJfD8YBJmRr
         N0yZY8uK5XuaYcIYlXWbBG4C79iHsCZNxe5QiSQ45Qdw0TY0neT/6YPZcUwglRtjaZj+
         IkkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV98lDd+4AK1hzAdulBLP1yRX13CBBBXTsvGypV/lINaKfjiWj15OKbq8jhUMtInT98DK5SXxgJ5xuUNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFhIbVgHoLz86PobddE90RmrIEZi1f2V2qlpDpQqyGGh8Y7fi
	SmkMgZq2OTjmY6AbFgCfXp91GEj7myde+QX0xlC7eVD4ljVUlIC+vt+vlou/b8Y=
X-Google-Smtp-Source: AGHT+IF3UHQJ040IIKGHttfPGwPkHcoNpKCF3umoPrbhTPK8Z7j1Ql7aKyWKk9X3oelY5giKEXNyJQ==
X-Received: by 2002:a05:690c:314:b0:6e5:bca9:cb8f with SMTP id 00721157ae682-6eaddfa3b62mr164950927b3.38.1731434199260;
        Tue, 12 Nov 2024 09:56:39 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8d5133sm26365837b3.12.2024.11.12.09.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:38 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v7 07/18] fsnotify: generate pre-content permission event on open
Date: Tue, 12 Nov 2024 12:55:22 -0500
Message-ID: <60a2309da948dc81e4c66b9e5fe3f1e2faa2010e.1731433903.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731433903.git.josef@toxicpanda.com>
References: <cover.1731433903.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

Generate pre-content event on open in addition to FS_OPEN_PERM,
but without sb_writers held and after file was truncated
in case file was opened with O_CREAT and/or O_TRUNC.

The event will have a range info of [0..0] to provide an opportunity
to fill entire file content on open.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/namei.c               | 10 +++++++++-
 include/linux/fsnotify.h |  4 +++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9d30c7aa9aa6..a1a5b10893f6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3836,7 +3836,15 @@ static int do_open(struct nameidata *nd,
 	}
 	if (do_truncate)
 		mnt_drop_write(nd->path.mnt);
-	return error;
+	if (error)
+		return error;
+
+	/*
+	 * This permission hook is different than fsnotify_open_perm() hook.
+	 * This is a pre-content hook that is called without sb_writers held
+	 * and after the file was truncated.
+	 */
+	return fsnotify_file_area_perm(file, MAY_OPEN, &file->f_pos, 0);
 }
 
 /**
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 7110bc2f5aa7..2d1c13df112c 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -193,6 +193,8 @@ static inline int fsnotify_pre_content(const struct file *file,
 
 /*
  * fsnotify_file_area_perm - permission hook before access of file range
+ *
+ * Called post open with access range [0..0].
  */
 static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 					  const loff_t *ppos, size_t count)
@@ -207,7 +209,7 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	/*
 	 * read()/write and other types of access generate pre-content events.
 	 */
-	if (perm_mask & (MAY_READ | MAY_WRITE | MAY_ACCESS)) {
+	if (perm_mask & (MAY_READ | MAY_WRITE | MAY_ACCESS | MAY_OPEN)) {
 		int ret = fsnotify_pre_content(file, ppos, count);
 
 		if (ret)
-- 
2.43.0


