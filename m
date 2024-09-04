Return-Path: <linux-btrfs+bounces-7823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9BA96C865
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 22:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473E41F26A31
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 20:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2415D14F10E;
	Wed,  4 Sep 2024 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="c9b5TyRY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C735814A4E1
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2024 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481760; cv=none; b=VSXO/VDdodpBdBVJXEcf1/xj1IqDUYm/+xYoGa5ueSFETkJ4vHKBonHkALdxeX3jRl50PUaH6HgI/wdJViDpGH1zgTXQ/mXAZ1hbjIvlb9TEwaxMThkszsAzYKpiktKgFzz6axlqzTnFdRoy6Lh2RJCIeZ2jo8x/vLha8cF8ktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481760; c=relaxed/simple;
	bh=Xn48LHyloGlt4wSB8hOBR2UrfV1ArFm69qZkTTQGfyU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUAxzx/yGMNsh9b4GmasXd4TSer0+T3PLq8cD03qgXicBIJTOy3eaO2Kk/5Np47zBicE6yfC4jgH+9fnb41+mfbK770ajshnNrUG3FoMsq2t4eYwU9A8dsHkGgNNtCMq+8wpmzcIUZs7TB+vazQgW9BVA9LswWmpcJtCrgqGJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=c9b5TyRY; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-846d1ba933eso898967241.2
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2024 13:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481757; x=1726086557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5YjJnCjztcen/Z+X5lHX0n7xhNQ/QripYlvqYqvblA=;
        b=c9b5TyRY4mkxF15us7zoWMx4fOYKG7wCeHZWdlUSoiFqod73427S7sVCK03G/Bx2Gx
         KkxnP+FzN96Vo6dMexkii/9tFzgkv9R7lgxFfqVNWdlPW5AI+SG4EQPHa06Z7IMOfccH
         4uIemTuV7zHVw8fwb/+1s/Ash9WswS/5bOhB7f4u7Z4Wy0hxRdYl0YgJxXQ6Qy9id6io
         KdyNwjgYQURhmc1QTaRC872P1Wsbvkk6sv2IHZj/GccJp/G5q54xVQM+g7qdYAqIYu5O
         xqrNEhkhFrUUHKK0NJN/onWDi+jUZPclYYwqnSFdjafrsfZYtCaTXXmqUOu9ZfTsI3b1
         Flbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481757; x=1726086557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5YjJnCjztcen/Z+X5lHX0n7xhNQ/QripYlvqYqvblA=;
        b=jzYuW6HVhKV0hF+85tlbv/D2UmL/ISt8aE172WdqJcE8uX/uMfp2HtZSQXAloA6GYJ
         lHgObBspQmBFKyvuIh12HCcS2FwN56hFMTVd9kHz8HxHEww9aUs4LirWcaUOcsPMKdi9
         sTb2R8XdqIcre/t5EWPwijOMrRIaChIw9bLVFfsr7fBd4ugViZqHP8dRtVwe7Jhm2l/r
         LoANFtd/IxBp1RXIgNOOoRLyVSJasCe6yFKhfYkLyWqoG6+yf3jsXK9gscxdvnKxbPmo
         +hCgqn9v69GoQ/beC/4Ib6/ZR+H8pFS6P6hExBFqp2mum0fOWFlf+lF5xK/2WPxMuplx
         4G1A==
X-Forwarded-Encrypted: i=1; AJvYcCVVzVDkE8PxeGpzr5t0vMmPA4Yh0jSWEMlWxZcxNwfR1I8K+w5Ck/esgXHgDkqH22QaLQ5+o6mHj1v2bA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2rqf/ECcpMTXCFjMAMPga/pQ/TGayyhKK6NCm0s9PwZCFWGrM
	u07ARPErTzp74aebRcEyngveiz7avJCSKZA8qU1znZW/7PLJACsLODP+v/Q+Bgs=
X-Google-Smtp-Source: AGHT+IHvcict8JxrlQWrQU5plI6x5zmPl5v4oP6wc1pvF95llWkCs8Ce7IJ9EEARO1WLH0fb9o1Srw==
X-Received: by 2002:a05:6102:c91:b0:498:d39d:9b7c with SMTP id ada2fe7eead31-49a77940af7mr14221150137.2.1725481757506;
        Wed, 04 Sep 2024 13:29:17 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98f00acf7sm15095385a.107.2024.09.04.13.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:16 -0700 (PDT)
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
Subject: [PATCH v5 02/18] fsnotify: introduce pre-content permission event
Date: Wed,  4 Sep 2024 16:27:52 -0400
Message-ID: <a96217d84dfebb15582a04524dc9821ba3ea1406.1725481503.git.josef@toxicpanda.com>
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

The new FS_PRE_ACCESS permission event is similar to FS_ACCESS_PERM,
but it meant for a different use case of filling file content before
access to a file range, so it has slightly different semantics.

Generate FS_PRE_ACCESS/FS_ACCESS_PERM as two seperate events, same as
we did for FS_OPEN_PERM/FS_OPEN_EXEC_PERM.

FS_PRE_MODIFY is a new permission event, with similar semantics as
FS_PRE_ACCESS, which is called before a file is modified.

FS_ACCESS_PERM is reported also on blockdev and pipes, but the new
pre-content events are only reported for regular files and dirs.

The pre-content events are meant to be used by hierarchical storage
managers that want to fill the content of files on first access.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c             |  2 +-
 include/linux/fsnotify.h         | 27 ++++++++++++++++++++++++---
 include/linux/fsnotify_backend.h | 13 +++++++++++--
 security/selinux/hooks.c         |  3 ++-
 4 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 272c8a1dab3c..1ca4a8da7f29 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -621,7 +621,7 @@ static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 23);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 25);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 278620e063ab..7600a0c045ba 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -133,12 +133,13 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 
 #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
 /*
- * fsnotify_file_area_perm - permission hook before access to file range
+ * fsnotify_file_area_perm - permission hook before access/modify of file range
  */
 static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 					  const loff_t *ppos, size_t count)
 {
-	__u32 fsnotify_mask = FS_ACCESS_PERM;
+	struct inode *inode = file_inode(file);
+	__u32 fsnotify_mask;
 
 	/*
 	 * filesystem may be modified in the context of permission events
@@ -147,7 +148,27 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	 */
 	lockdep_assert_once(file_write_not_started(file));
 
-	if (!(perm_mask & MAY_READ))
+	/*
+	 * Generate FS_PRE_ACCESS/FS_ACCESS_PERM as two seperate events.
+	 */
+	if (perm_mask & MAY_READ) {
+		int ret = fsnotify_file(file, FS_ACCESS_PERM);
+
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Pre-content events are only reported for regular files and dirs.
+	 */
+	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode))
+		return 0;
+
+	if (perm_mask & MAY_WRITE)
+		fsnotify_mask = FS_PRE_MODIFY;
+	else if (perm_mask & (MAY_READ | MAY_ACCESS))
+		fsnotify_mask = FS_PRE_ACCESS;
+	else
 		return 0;
 
 	return fsnotify_file(file, fsnotify_mask);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 8be029bc50b1..200a5e3b1cd4 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -56,6 +56,9 @@
 #define FS_ACCESS_PERM		0x00020000	/* access event in a permissions hook */
 #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
 
+#define FS_PRE_ACCESS		0x00080000	/* Pre-content access hook */
+#define FS_PRE_MODIFY		0x00100000	/* Pre-content modify hook */
+
 /*
  * Set on inode mark that cares about things that happen to its children.
  * Always set for dnotify and inotify.
@@ -77,8 +80,14 @@
  */
 #define ALL_FSNOTIFY_DIRENT_EVENTS (FS_CREATE | FS_DELETE | FS_MOVE | FS_RENAME)
 
-#define ALL_FSNOTIFY_PERM_EVENTS (FS_OPEN_PERM | FS_ACCESS_PERM | \
-				  FS_OPEN_EXEC_PERM)
+/* Content events can be used to inspect file content */
+#define FSNOTIFY_CONTENT_PERM_EVENTS (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | \
+				      FS_ACCESS_PERM)
+/* Pre-content events can be used to fill file content */
+#define FSNOTIFY_PRE_CONTENT_EVENTS  (FS_PRE_ACCESS | FS_PRE_MODIFY)
+
+#define ALL_FSNOTIFY_PERM_EVENTS (FSNOTIFY_CONTENT_PERM_EVENTS | \
+				  FSNOTIFY_PRE_CONTENT_EVENTS)
 
 /*
  * This is a list of all events that may get sent to a parent that is watching
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 55c78c318ccd..2997edf3e7cd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3406,7 +3406,8 @@ static int selinux_path_notify(const struct path *path, u64 mask,
 		perm |= FILE__WATCH_WITH_PERM;
 
 	/* watches on read-like events need the file:watch_reads permission */
-	if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_CLOSE_NOWRITE))
+	if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_PRE_ACCESS |
+		    FS_CLOSE_NOWRITE))
 		perm |= FILE__WATCH_READS;
 
 	return path_has_perm(current_cred(), path, perm);
-- 
2.43.0


