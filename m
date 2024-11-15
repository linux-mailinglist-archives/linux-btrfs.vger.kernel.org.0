Return-Path: <linux-btrfs+bounces-9719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ED29CF031
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81921F28AB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294821EABBB;
	Fri, 15 Nov 2024 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="cjESmci0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4741E5729
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684706; cv=none; b=p0mKZTVQm8IWmhmIYJS9RKAWAdu5F5VevmACIZfBoQ2TYtR2SKLQRrrnWP0hyVFuoYoDb4YdFDdkDjHGDkz2Cz/B8U35cO1d80LzKuHxZ+uIF6BJOjzTaucuP0boZSQ6yNc9KZdMBYvvUGw3q9ZJkj5WBRp4YLMri+5AELsmq+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684706; c=relaxed/simple;
	bh=S8KtXYKv5KBhFWGf/VgvN+plHsknP1dZU8l0VOqJqrs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvpBgIM6seMk8pV75Gaskusv8hdkHY6+kBGh0fwra7OlhjUdZi2/FkHOzSRxnhC4zCG/TPOrs6pDSdO6jHRpONExYQd39CyeEfSyhe6gGMeXfr4+QflTKXJrGIISl2Vo+izkiyvd1HIgEGgZ6tIJCPlsuv+40/dfoqD7W/daDvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=cjESmci0; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ea5f68e17aso22355007b3.3
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 07:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684703; x=1732289503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLlpuiMn0030yB3+s74DQOOZuZXxBi++zrJRvWIMp3o=;
        b=cjESmci0eXPgddC80zNMv3Udj7cRoLwt04JjPWZFgXE4tKyGTzGiIXhCUbbHYZ/69n
         qn0lkya+Xq+oZD3R8S8/rNjn5yQRNFm/czvtmqDhXcWfUkd79+KiJfkkphomJ3lAZZYu
         Km5G3flx5Xr/fzAiuLt7WRo/QpUlfd20+JLLfDmXL7wFdciCvHVIMgKoyJPgVpu/J5O6
         OV3oGaUHK15lyJoJN1eQDK/MWqmxEUPDFxiRFtpL28Sfi/76yjooWM3hqemO22YEwMz6
         6hDZdzNz2zC2UWbYuUwBxl7aNfehFbAPBl88uD4mRStfZWWH8MrmHitXlVNApIQFc1ge
         TBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684703; x=1732289503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLlpuiMn0030yB3+s74DQOOZuZXxBi++zrJRvWIMp3o=;
        b=jfkLJrQ8WoGSCB//taIF4HBVlo4f7EQgNRwSwn1xmG4V84SLXVQc77rYnDqxMb9zBm
         vWiLsL61W2+cNk7G/t2CdWDpty2AwloAzEOkoAWgPMFzG9vhn44c/tG/mnXn3NR9yRKY
         AVU8I0yFlOwGhrlCYkA0/e45hYM34RaXsltx7iS4BtSgBVCDIQX66YJyB2RmxSFFLN6b
         PRUmNCtF/J4nzmWVtyBlEE+t9edSzUiuqM/3ecsuu1PgYdW8ay1B1qJ3v5zW2g0/wOY7
         rmWSrzSoAH8SaeIZAHqszzVjfepT+00n5lZGzt8VhjVPp3+jixqiw7sPduRZN6A5EEqv
         cQWA==
X-Forwarded-Encrypted: i=1; AJvYcCWJGyTR6A2CXjO/yMj69nloozgsVa0S1Lfro0jlOTnZSoNa+EHoWhfiHIRsupscodCUpXBXABv8yfHpLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq203A9E7f0mVgPJ5Kqle6ZoTyu8WE3NqjwmlZHx2yK3z3B1jl
	hq9vFmTPtDsuDgXuejBv7kas2sM1SbndNXd5kXwzF2QT0R6vkgRcWLjB6EoiTNo=
X-Google-Smtp-Source: AGHT+IHLmXNsFgoxeQH2zoAuWGXM6iZ0/bFoZDUBvajKhRUeKgJ2+BFXj02LrLEKz+I9Qy3GGhxCnw==
X-Received: by 2002:a05:690c:6806:b0:6dc:7877:1ea3 with SMTP id 00721157ae682-6ee55a6c9ebmr38646357b3.17.1731684703143;
        Fri, 15 Nov 2024 07:31:43 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee4400c7dasm7862627b3.24.2024.11.15.07.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:42 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v8 13/19] fanotify: add a helper to check for pre content events
Date: Fri, 15 Nov 2024 10:30:26 -0500
Message-ID: <657f50e37d6d8f908c13f652129bcdd34ed7f4a9.1731684329.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731684329.git.josef@toxicpanda.com>
References: <cover.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

We want to emit events during page fault, and calling into fanotify
could be expensive, so add a helper to allow us to skip calling into
fanotify from page fault.  This will also be used to disable readahead
for content watched files which will be handled in a subsequent patch.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 08893429a818..d5a0d8648000 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -178,6 +178,11 @@ static inline void file_set_fsnotify_mode(struct file *file)
 	}
 }
 
+static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	return file && unlikely(FMODE_FSNOTIFY_HSM(file->f_mode));
+}
+
 /*
  * fsnotify_file_area_perm - permission hook before access to file range
  */
@@ -264,6 +269,11 @@ static inline void file_set_fsnotify_mode(struct file *file)
 {
 }
 
+static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	return false;
+}
+
 static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 					  const loff_t *ppos, size_t count)
 {
-- 
2.43.0


