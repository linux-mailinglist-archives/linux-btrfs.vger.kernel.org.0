Return-Path: <linux-btrfs+bounces-9447-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1849C469E
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 21:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417CC1F25C33
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 20:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5651BE23C;
	Mon, 11 Nov 2024 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ecMCd6g6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4E61C3318
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 20:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356370; cv=none; b=sEvOSJrFBDOn0OHzHDqX1OBtEmuyyJituG1NzHzikqFjZUuZrKO+XlAyktaOkI5wiH0QITyeyeZ/wYwe5zqoA3quhPjEZLrMH8tGTHk+tdxYaJxCSbscEA2AtHzaXeafKwqXI4zF9Po1jb/MEnRxarOftO9O+zv8xUBwLAeUhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356370; c=relaxed/simple;
	bh=+GaW79ihYPcVt/7H2tBMApB0qt54+8GxTgU7k9z6Kks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odnR59rAbXapwmeW9+QG71+6niRTlGLM9WyzABH+4FlAt/CT2Nn/ru1Y9GRvuPIfAG7UjHsnY8AShw2m+jS68AROTb5flNw9M+d+Z0/PksjE/wxRjHuWlDeja3r9jwU5E4SekLONTpW9bTpSbUNfnKprLW82OhFcMWLkfdNM4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ecMCd6g6; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460da5a39fdso37362001cf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 12:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356367; x=1731961167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxzNxKWQS223qRTjvLG5E3r4Xe02F6POoSVqC+sjeek=;
        b=ecMCd6g6+CRWRMGZZap3eaMKIsWFTbfBXssJ5U7Crenx5zgp48uEmJdG9Ja9rMO2+O
         oQIaN18EVkYDNccBvdMmukip4cUC+psREXW/PUUdNTQ3JGA+LiDQqDBZj3MftvIQ6c4K
         4mqDI2ZR7VsyWqgRwvLPlL9JdOkrVRa1nFXIStZ+6J6PlKxpx+cF7W/DaxeYzV2bFReT
         YFBLkY+Ll1EDiVkwYCx4T/QbSSqyhvBJX2oK2/1d31yz2YAwd021jrpeboYql7Vib3X6
         4bhP2pxDEo2h1E04a3+inH3JUpEnROauL1dD43s24AefpxsDhkSnJK2dw4OOvViTvRHK
         xUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356367; x=1731961167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxzNxKWQS223qRTjvLG5E3r4Xe02F6POoSVqC+sjeek=;
        b=lXGE1wIR0sXRmMKvuR1JHuN+UwBsG1JK4ORrmvhhdNFVezAcg4n89K9UIySIfEEw+W
         qjSbL3R3TJwJlpPtLn1Jl/SFwJkMvhrk8rJBFM+X/5YGPRrCJQkB79K2xWEQsLiQbztS
         jfRdDGwp/SnZ8spQD8cEdmNgpkaB8ilFIr9kI02whYVupG3HAro52L/2wXvfSAMnCv1a
         YKN7lJLqT3XOvwXfC3/UJQECXmh1QnMp0s6HXCsmNgC/1ccrAe1V40K04xKju43oXoJI
         nAIJLXw1S8Z/b2qgmz4ZSNg4vP7/S/Gm5OMeZpXLDkfJC+C0ixh/hghR5pyfpQOuQuMp
         gb6g==
X-Forwarded-Encrypted: i=1; AJvYcCUW/qiieqUKLta0iGg7LkXQ52p8+D0BvNGLxSE1ZTGrMdCxG0z3RIwZMrnIdhgTB68GB/VzwbR0/lNw7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8UalJrP5gfOYY8+Z3AmjkV/2JhAt7+SYXf2CznJTGLDHwF4DD
	pRPA9TUeuswJTzT9XKJJIbnWAIwNv2sLCBO3ZLsS6czkz36Gb3zulRMjGsnbqeY=
X-Google-Smtp-Source: AGHT+IErujsxQUzTbV6poIIfui4YaoHywzZ9+iKLxxl+cBzfLZ4qZlTFt050wM/IYDovGmekQNr9vg==
X-Received: by 2002:a05:622a:8d:b0:460:8d16:e8cc with SMTP id d75a77b69052e-46309331aa3mr187305441cf.16.1731356367498;
        Mon, 11 Nov 2024 12:19:27 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff580e2asm66683971cf.67.2024.11.11.12.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:26 -0800 (PST)
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
Subject: [PATCH v6 11/17] fanotify: add a helper to check for pre content events
Date: Mon, 11 Nov 2024 15:18:00 -0500
Message-ID: <0b76f68806fefceae2618e5f135765e429b23025.1731355931.git.josef@toxicpanda.com>
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

We want to emit events during page fault, and calling into fanotify
could be expensive, so add a helper to allow us to skip calling into
fanotify from page fault.  This will also be used to disable readahead
for content watched files which will be handled in a subsequent patch.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fsnotify.c             | 16 ++++++++++++++++
 include/linux/fsnotify_backend.h | 14 ++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 0696c1771b2a..a49c42c6ce01 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -203,6 +203,22 @@ static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
 	return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
 }
 
+#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	__u32 mnt_mask = real_mount(file->f_path.mnt)->mnt_fsnotify_mask;
+
+	if (!(inode->i_sb->s_iflags & SB_I_ALLOW_HSM))
+		return false;
+
+	return fsnotify_object_watched(inode, mnt_mask,
+				       FSNOTIFY_PRE_CONTENT_EVENTS);
+}
+EXPORT_SYMBOL_GPL(fsnotify_file_has_pre_content_watches);
+#endif
+
+
 /*
  * Notify this dentry's parent about a child's events with child name info
  * if parent is watching or if inode/sb/mount are interested in events with
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index abd292edb48c..e3a4a8e06fa0 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -896,6 +896,15 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
 	INIT_LIST_HEAD(&event->list);
 }
 
+#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+bool fsnotify_file_has_pre_content_watches(struct file *file);
+#else
+static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	return false;
+}
+#endif /* CONFIG_FANOTIFY_ACCESS_PERMISSIONS */
+
 #else
 
 static inline int fsnotify(__u32 mask, const void *data, int data_type,
@@ -934,6 +943,11 @@ static inline u32 fsnotify_get_cookie(void)
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


