Return-Path: <linux-btrfs+bounces-9444-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228909C4695
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 21:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D047528847A
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 20:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F6A1C2333;
	Mon, 11 Nov 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jYledgT9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082F11BDAAE
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356364; cv=none; b=nSSif29GlVhAAaZws6g8+rzJdUSuwJZJdzXyC6ujulQ1lK/FlOhkW5GCiWqn5l4FklpmTrsIEa+LqmF3qUzVlxSMHvywBy+VN5CIpLarpHl/0boOCBU/GfeRwcBYMp3e4Qfiftb1utaNyhYUCtScnR/P6d7MAJJkjzkzOdszqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356364; c=relaxed/simple;
	bh=kD4ulmGxIpQmCyeh9f4ZPmJ121zBS/vQk1SfQ8U2dVM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQw/LDQOY7IYBdn9vI6NWhJc3h9UjcuhNDWnu3h5CGSaXIVkUuoyloRHPczYz7oBjW87vxbM7rgn6VOVxVGPTZcLnbPMqCM9/S6Jot5NwOsgUKrj+IUj1WQNArExjOwWILs/yRsnsDI92riDyOrmDuQlAmsR61h5mgLBlx+/E8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jYledgT9; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-718186b5c4eso2345733a34.2
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 12:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356362; x=1731961162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIr6hfiIJt6Z0W2/VohDEaflGJcbA2BZOCByAdmo7A4=;
        b=jYledgT9O3ZtEcrDQGenFjbRUib7hLXZpEoosj3W26PZjx1qFark3WDbt6HvN+1M5y
         8d6pyYnyGYcZJa2SjI5W4ztmzXwtrjkYU2qP+ZYjd1j2qvEqwhkBS6IruSrFucSrFMRP
         4kzuHtUGGebGlMJXx7BXXzxnopg4IUibWZ7WWOCW3/FW4js6M1KY1Go5Vceo3uMkK6nR
         bOFvSRROJupEchLdhmfaIEN4HFtXQUx+mu9+WbzTeSV42rPsnEYjCMFz4NXpak8mD2zk
         DVFiNPQSc7Mzhm/TjwcyOSCgmC60IJ4q3lYD3DW3vbOxTvlUAGSnFJDepryF3lJaR+fE
         P1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356362; x=1731961162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIr6hfiIJt6Z0W2/VohDEaflGJcbA2BZOCByAdmo7A4=;
        b=MQKEJgvYWNhdgLDy8zmB8mQ/yILOUPA6spUzUDtn/47sEyOlEdNZqnAwO/rmilJUPO
         sFFxkuNPl0Nq2PV3zZyzRnjIzMMZ01s/00+5TsQ38EZj+zkExzXEMKcRxSXAENKvTGxJ
         jkNEzIU/EQ8bXim8z6Lz/L/fy10eZ6TLCsRmqAO9GOnsY9a/IQVt8pwb6xebp282b9w2
         vTbd+ZyUmnNSLkPrZx+G7BVpOT+nYg7BbTCtFdRhIHgBvvkTdeTfMMewUNmWSQULtWVv
         ouy9eEWhcGvx30crlXfrIN1ermxKj4mB22k91AhQ3iR3M9LPX8GzWtz9n5ktEo/u8Qag
         sg8w==
X-Forwarded-Encrypted: i=1; AJvYcCXDy15UXW3+fEkPHwubau05OLFIMGYZ44wEPw6xWHxJ5jOR1j3SpSKe6JigoDoOKJrzBIO6RiIbPIDYhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YynLCJ/Q+/nWoZz/QpzQqAdAupGnmZAJB0QoY6GQtm3O4hEiZzY
	qmxZ8adOQyglVlbmvU7oX2uit/hKJQkuElLJDBpdAOuRSvEScGfFvtZvz8ZrIDk=
X-Google-Smtp-Source: AGHT+IG9bGBtdAa/UNjAV/reMXpITXA7+6iabefhDuqPBQRMez+d/kh/izRimXSRfAf9RRVXnEpYWw==
X-Received: by 2002:a05:6358:5d8a:b0:1c2:f482:5c0b with SMTP id e5c5f4694b2df-1c641f66059mr620325055d.24.1731356362041;
        Mon, 11 Nov 2024 12:19:22 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961f4a0fsm63335146d6.41.2024.11.11.12.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:21 -0800 (PST)
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
Subject: [PATCH v6 08/17] fanotify: introduce FAN_PRE_ACCESS permission event
Date: Mon, 11 Nov 2024 15:17:57 -0500
Message-ID: <e990d0aa3eb8489b1f4a67a3616774a6e295c4d4.1731355931.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731355931.git.josef@toxicpanda.com>
References: <cover.1731355931.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

Similar to FAN_ACCESS_PERM permission event, but it is only allowed with
class FAN_CLASS_PRE_CONTENT and only allowed on regular files and dirs.

Unlike FAN_ACCESS_PERM, it is safe to write to the file being accessed
in the context of the event handler.

This pre-content event is meant to be used by hierarchical storage
managers that want to fill the content of files on first read access.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      |  3 ++-
 fs/notify/fanotify/fanotify_user.c | 22 +++++++++++++++++++---
 include/linux/fanotify.h           | 14 ++++++++++----
 include/uapi/linux/fanotify.h      |  2 ++
 4 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index c1e4ae221093..5e05410ddb9f 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -917,8 +917,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
+	BUILD_BUG_ON(FAN_PRE_ACCESS != FS_PRE_ACCESS);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 21);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 22);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 0ae4cd87e712..da9cf09565ce 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1639,11 +1639,23 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 				     unsigned int flags)
 {
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
+	bool is_dir = d_is_dir(path->dentry);
 	/* Strict validation of events in non-dir inode mask with v5.17+ APIs */
 	bool strict_dir_events = FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID) ||
 				 (mask & FAN_RENAME) ||
 				 (flags & FAN_MARK_IGNORE);
 
+	/*
+	 * Filesystems need to opt-into pre-content evnets (a.k.a HSM)
+	 * and they are only supported on regular files and directories.
+	 */
+	if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
+		if (!(path->mnt->mnt_sb->s_iflags & SB_I_ALLOW_HSM))
+			return -EINVAL;
+		if (!is_dir && !d_is_reg(path->dentry))
+			return -EINVAL;
+	}
+
 	/*
 	 * Some filesystems such as 'proc' acquire unusual locks when opening
 	 * files. For them fanotify permission events have high chances of
@@ -1676,7 +1688,7 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	 * but because we always allowed it, error only when using new APIs.
 	 */
 	if (strict_dir_events && mark_type == FAN_MARK_INODE &&
-	    !d_is_dir(path->dentry) && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
+	    !is_dir && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
 		return -ENOTDIR;
 
 	return 0;
@@ -1780,11 +1792,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 
 	/*
-	 * Permission events require minimum priority FAN_CLASS_CONTENT.
+	 * Permission events are not allowed for FAN_CLASS_NOTIF.
+	 * Pre-content permission events are not allowed for FAN_CLASS_CONTENT.
 	 */
 	ret = -EINVAL;
 	if (mask & FANOTIFY_PERM_EVENTS &&
-	    group->priority < FSNOTIFY_PRIO_CONTENT)
+	    group->priority == FSNOTIFY_PRIO_NORMAL)
+		goto fput_and_out;
+	else if (mask & FANOTIFY_PRE_CONTENT_EVENTS &&
+		 group->priority == FSNOTIFY_PRIO_CONTENT)
 		goto fput_and_out;
 
 	if (mask & FAN_FS_ERROR &&
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 89ff45bd6f01..c747af064d2c 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -89,6 +89,16 @@
 #define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE | \
 				 FAN_RENAME)
 
+/* Content events can be used to inspect file content */
+#define FANOTIFY_CONTENT_PERM_EVENTS (FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
+				      FAN_ACCESS_PERM)
+/* Pre-content events can be used to fill file content */
+#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS)
+
+/* Events that require a permission response from user */
+#define FANOTIFY_PERM_EVENTS	(FANOTIFY_CONTENT_PERM_EVENTS | \
+				 FANOTIFY_PRE_CONTENT_EVENTS)
+
 /* Events that can be reported with event->fd */
 #define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
 
@@ -104,10 +114,6 @@
 				 FANOTIFY_INODE_EVENTS | \
 				 FANOTIFY_ERROR_EVENTS)
 
-/* Events that require a permission response from user */
-#define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
-				 FAN_OPEN_EXEC_PERM)
-
 /* Extra flags that may be reported with event or control handling of events */
 #define FANOTIFY_EVENT_FLAGS	(FAN_EVENT_ON_CHILD | FAN_ONDIR)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 79072b6894f2..7596168c80eb 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -27,6 +27,8 @@
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
 /* #define FAN_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
+#define FAN_PRE_ACCESS		0x00100000	/* Pre-content access hook */
+
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
 #define FAN_RENAME		0x10000000	/* File was renamed */
-- 
2.43.0


