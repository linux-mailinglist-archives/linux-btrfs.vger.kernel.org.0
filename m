Return-Path: <linux-btrfs+bounces-9544-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3229C5FB6
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 19:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB612881FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 18:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17FC219CBF;
	Tue, 12 Nov 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xZh82DyE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647AE218D7B
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434210; cv=none; b=bx4F5JUatqF//r2BZgRqEtDZvFfQ/0MLAgnfidp5wQIRgxEDRPZvtHWM43F0prY5V7GX/MYtwYNI62I8wPho8gtcdX53JDoTiMiDqDk4vPKrYe6wV5If/8G1OExthD/yVHSm91ZEzpcqvpDZHB3L7pQGZN3Iwct+Phk9sB92e64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434210; c=relaxed/simple;
	bh=0OfIuamYNVk+lhv7pqAeL2IG3+lqQpmr2GpFM9JML+4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCbnMI36spvaw+GcBK0/0TTLNgYVWGbwv8RFXDFImh+tk4TemHjd/SQsW1FA9ldBcrjM1ahH8142/Ny9/Y97fAH8KiidbtB4VUbyUxe3LZgoTRM1kwaWmeIB7CtXzdip31fJL2Yc/uMkHiNF5DRdL4MEs/0PgscO4OxYIb6gbg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xZh82DyE; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e30cef4ac5dso5665611276.0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 09:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434208; x=1732039008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxllZcuqFsIN/uRNUgqvpvAOYGEhEd5YYx/k8ZgfJq8=;
        b=xZh82DyEJFn9i4GSo5mjjRTQlX4unRAP1jtidGz1qErKc22xczvRgJBsmuZ/sKNgCZ
         YThOmv3IyefDp31CGUsuWy7wOWP7RIZKfsD9k9lcJZMhVJEDPP7QUIJe52KPYbuCFMYX
         s2/u/GLlYGgLr1vcJHBnASXRvDNd/INQTqxLoyH4o7kzNoqxyQP/K88JLHxdaUu8dxz9
         pJ3kjQKZPY76aB1Dlga5DVGCbS9EaXw9GJCj6/6vKnSaQJ1761MW0ILyJTiXx6NH2SMl
         zr3Q7ZRI2cAOrJDlRb8YPpOI5GAm1AOklQEIMOpwciLKVDePNfjt5PRj6lhP5jZkmePv
         ZXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434208; x=1732039008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxllZcuqFsIN/uRNUgqvpvAOYGEhEd5YYx/k8ZgfJq8=;
        b=dz3AzuvPlmHtZr1f1meI+FSrJt7INDRmCfo5U7g8/TBcGFl7ZAMvk2/TB1wOpTkJgw
         /CLxUyqMf6VW3/SE1XlwWj9VEpofOBWxdPGINZqww2HUyth2tVrphp4G+ePlHKZ01JdV
         gYqwzPXaM4E9xygcbWv9/3/jKnEcrUe+l18imqxW203bbZNwP8fkfBGhG6WoAlt53E3T
         6OF/e6NOa48P+Jm+HkM6Cos59UlRl6SCj3u1KeUlHFmE4m3P3P4fwH9xnLu09KheliGJ
         08OaBIp337dUI3vSr1JRwSsf7ZowigcVEY8c1YdWQe/5pwTa34hZb/QNSZ35U88/R/lO
         x1Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWxynUYgmde9mt7uYRcJZojJlbA/WhTCkqJ6Fo/pCYosivbLPcEzdrZV/IL4OL34NMn9G/1gGS3EN5IbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmVWd8FEdKX7VwaBkl+UYt4whFu3mdC+hyXG232QvWRA6ureR
	4tOHREJNjGg3KAQIiSZSqRM2rmIEp2I0l8aAnlMF5TtLjrIwFLx/5Nrfn+V5mQU=
X-Google-Smtp-Source: AGHT+IHPp+fFKmqCSpROu5xxKnzv3LT3agPlNIkaHlSKePfsW7xMW1BrUYUNoa9bR5mHCiwMC/SWmQ==
X-Received: by 2002:a05:6902:b1d:b0:e29:48ad:b845 with SMTP id 3f1490d57ef6-e35dc547994mr3050460276.22.1731434207100;
        Tue, 12 Nov 2024 09:56:47 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336ef2652csm2885436276.22.2024.11.12.09.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:46 -0800 (PST)
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
Subject: [PATCH v7 12/18] fanotify: add a helper to check for pre content events
Date: Tue, 12 Nov 2024 12:55:27 -0500
Message-ID: <44afe46517b379b6b998a35ba99dd2e1f55a2c7d.1731433903.git.josef@toxicpanda.com>
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

We want to emit events during page fault, and calling into fanotify
could be expensive, so add a helper to allow us to skip calling into
fanotify from page fault.  This will also be used to disable readahead
for content watched files which will be handled in a subsequent patch.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fsnotify.c             | 12 ++++++++++++
 include/linux/fsnotify_backend.h | 26 ++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index cab5a1a16e57..17047c44cf91 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -203,6 +203,18 @@ static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
 	return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
 }
 
+#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+bool fsnotify_file_object_watched(struct file *file, __u32 mask)
+{
+	struct inode *inode = file_inode(file);
+	__u32 mnt_mask = real_mount(file->f_path.mnt)->mnt_fsnotify_mask;
+
+	return fsnotify_object_watched(inode, mnt_mask, mask);
+}
+EXPORT_SYMBOL_GPL(fsnotify_file_object_watched);
+#endif
+
+
 /*
  * Notify this dentry's parent about a child's events with child name info
  * if parent is watching or if inode/sb/mount are interested in events with
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index abd292edb48c..a92d59b66f93 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -896,6 +896,27 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
 	INIT_LIST_HEAD(&event->list);
 }
 
+#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+bool fsnotify_file_object_watched(struct file *file, __u32 mask);
+
+static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	if (!(file->f_mode & FMODE_NOTIFY_PERM))
+		return false;
+
+	if (!(file_inode(file)->i_sb->s_iflags & SB_I_ALLOW_HSM))
+		return false;
+
+	return fsnotify_file_object_watched(file, FSNOTIFY_PRE_CONTENT_EVENTS);
+}
+
+#else
+static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	return false;
+}
+#endif /* CONFIG_FANOTIFY_ACCESS_PERMISSIONS */
+
 #else
 
 static inline int fsnotify(__u32 mask, const void *data, int data_type,
@@ -934,6 +955,11 @@ static inline u32 fsnotify_get_cookie(void)
 static inline void fsnotify_unmount_inodes(struct super_block *sb)
 {}
 
+static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	return false;
+}
+
 #endif	/* CONFIG_FSNOTIFY */
 
 #endif	/* __KERNEL __ */
-- 
2.43.0


