Return-Path: <linux-btrfs+bounces-7826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B31396C86E
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 22:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14489287F5F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 20:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D748B15B562;
	Wed,  4 Sep 2024 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="W9s0SA7W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B611547C0
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2024 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481766; cv=none; b=ETqu6Uu0GgrVruFf3czD9tBXesScKOan2zsdh1xvaplJXMRd6ZIn+tEaQjfgurtg9h8ioO3IwWVnDXlYRQMZ5xjNL7qtxDicuoJNfFr0BaR7mS5jyz3qc+rkwKBNyxTqU7le8B+7/aJOr5n5eJEAreGJhXP9DSHm5GZxgU07c0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481766; c=relaxed/simple;
	bh=pD+LVjuiFGqxiYXNcE7SFfWih4a6NzbE/J64a1HUTSE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qq+JRXKwnSEoeN0rxsJgi2gK1UQ7T8jb1RW53Upl/dAyMCqVNIhW7dp/FSjNlDzygphf97FVwtZ+F2tYsBwOMKSehnCaycDa3ARFYsW8R3Xd3op0CrOWRDdqmEMVzkVfRHPvZ4zK3ZVVLBFaGHNAFgytPvWDCnS41VjxG1McnVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=W9s0SA7W; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a80fe481a9so2348385a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2024 13:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481763; x=1726086563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03GJ1k40z8a5Psi/RqpgoqHfW5s1FJwp4eQtJBRMqtc=;
        b=W9s0SA7Wi+MA0art6xUELvad0zxjyj1ET9iOuQYhV5qoPRTJO9sVOqrQXJ+c5ZO8PV
         X/rZzl/oWdg1e5vJS+tcXoRYOH2lr7XNSWH+1WLA4IY9ClG1+uHBYtXxT284Yalvnazu
         nbP4LfVT/R+ILe8q9y62aekUl9M8zQAgaWbU1/0DN2Jg6+Ft17o8DduQgQVYeQufePy8
         IEPoOJA6j/lYuQx4XnSPru1QGgnnXOSC9B/Qk81QPT9Oh2OJjcem9OpZA0cy8y32deT5
         MXvzhu7whd6LlQx734mowlRfgaOzifTkWR7o6OpDK+3db52f5lpHMCGYZeeW5EpGiNmN
         d+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481763; x=1726086563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03GJ1k40z8a5Psi/RqpgoqHfW5s1FJwp4eQtJBRMqtc=;
        b=w5Rm4yXkuUca5HyjB87NIQH6F+K749ct5cy9geeQpP0frPnMLfFRWTEWiuYXze8aKj
         GD/af3sDwlnYCkiSlobCJ1T/GxDoQzS8jsrp/fDyNCwPaEPfyh5KudtDyfztjYH8ctdZ
         Zc8gwkhcnQDH7X/sbK5c4eRMzv1WAu4U7PoIIwQPEjxJWOFiBd54ZnyWo7IPYeybbDdo
         zmAlMez3SExxPYXH3uLO8mlJgRrlV47U8RjoZ+HN0/GlRiC4YoQk7mf5U5wohIpxepzM
         N+ZKCMT+SiU7FXRbCkzdbxg0Qv2akjhSHgtv5EZzgSoNVBALBH8p++SLgBGHSit5kZA9
         9aCw==
X-Forwarded-Encrypted: i=1; AJvYcCW/pCBdMO1nApbnnAgqtovAEw4a1sFx7z1ZHs2TWR7rJE/78H8fcatLsf4iexSkNiiuEst7E+xNGYD7Jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiifE1SaxlB9uODbCT2jqqP9pxYhVdPdnqmO6mlrZHV9Geazsg
	PtL/HJiM1tNU36Hj6Vz9Us4BjzyWaYYlEk/PUjd37QFlHVwc+S8tjfvK4D5cZqM=
X-Google-Smtp-Source: AGHT+IGvPgs+n6cvUE85SbneJf41dyWf81pG4sPn/0S6fFjWTLzcLSXA4cf6j/r1vB6Kg6DKnHidAQ==
X-Received: by 2002:a05:620a:44ca:b0:79c:b8c:8e2b with SMTP id af79cd13be357-7a81d641ed8mr2000168185a.3.1725481762573;
        Wed, 04 Sep 2024 13:29:22 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98efeaffdsm15457285a.83.2024.09.04.13.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:22 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 05/18] fanotify: introduce FAN_PRE_MODIFY permission event
Date: Wed,  4 Sep 2024 16:27:55 -0400
Message-ID: <5142d1715dfecf58bc0a77eb410ca21d95e71cfc.1725481503.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725481503.git.josef@toxicpanda.com>
References: <cover.1725481503.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

Generate FAN_PRE_MODIFY permission event from fsnotify_file_perm()
pre-write hook to notify fanotify listeners on an intent to make
modification to a file.

Like FAN_PRE_ACCESS, it is only allowed with FAN_CLASS_PRE_CONTENT
and unlike FAN_MODIFY, it is only allowed on regular files.

Like FAN_PRE_ACCESS, it is generated without sb_start_write() held,
so it is safe to perform filesystem modifications in the context of
event handler.

This pre-content event is meant to be used by hierarchical storage
managers that want to fill the content of files on first write access.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 fs/notify/fanotify/fanotify.c      | 3 ++-
 fs/notify/fanotify/fanotify_user.c | 2 ++
 include/linux/fanotify.h           | 3 ++-
 include/uapi/linux/fanotify.h      | 1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 7dac8e4486df..b163594843f5 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -911,8 +911,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
 	BUILD_BUG_ON(FAN_PRE_ACCESS != FS_PRE_ACCESS);
+	BUILD_BUG_ON(FAN_PRE_MODIFY != FS_PRE_MODIFY);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 22);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 23);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index c294849e474f..3a7101544f30 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1673,6 +1673,8 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
 		if (!is_dir && !d_is_reg(path->dentry))
 			return -EINVAL;
+		if (is_dir && mask & FAN_PRE_MODIFY)
+			return -EISDIR;
 	}
 
 	return 0;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 5c811baf44d2..ae6cb2688d52 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -92,7 +92,8 @@
 #define FANOTIFY_CONTENT_PERM_EVENTS (FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
 				      FAN_ACCESS_PERM)
 /* Pre-content events can be used to fill file content */
-#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS)
+#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS | FAN_PRE_MODIFY)
+#define FANOTIFY_PRE_MODIFY_EVENTS   (FAN_PRE_MODIFY)
 
 /* Events that require a permission response from user */
 #define FANOTIFY_PERM_EVENTS	(FANOTIFY_CONTENT_PERM_EVENTS | \
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index bcada21a3a2e..ac00fad66416 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -27,6 +27,7 @@
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
 
 #define FAN_PRE_ACCESS		0x00080000	/* Pre-content access hook */
+#define FAN_PRE_MODIFY		0x00100000	/* Pre-content modify hook */
 
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
-- 
2.43.0


