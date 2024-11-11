Return-Path: <linux-btrfs+bounces-9443-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94429C4692
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 21:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D4A28818B
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 20:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23271B6CF2;
	Mon, 11 Nov 2024 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LrRfVU1R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775281BD9D4
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356363; cv=none; b=JhHGfRxQaq2Zoig8WSKgvnRxkQmOtpAfCU2tGKJ/ihial/QyK20lvGdJWQy7wV6yg67aPBYb1xRIl9rUOR47jx2bl2KjVg3MM9wULEZHdLSp63Vv/miNAYfMqPsv2Z/YLOHkGGQwR79FkVqkxAV6KIkO6WIJuxC593EP9MBq8Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356363; c=relaxed/simple;
	bh=Oq5L9ja3IMF4doQvebDweKCtXLQGr/nS40VPvwfrn/Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQAKesrntZr9bZZjDL5n2/JZZReTMvTn6Ks2VCQiU/B/KRkVyv1fIxiHxEIQXTfE5a8X1yRKXBFaMcg78UiAcPErjMzGbw/EIkUKNCfGupF6ZLxlOQo9F7D3Bkj+doI/cqU2MRj7mX7QFeI23sQZFUzwsTVb6yWoW62vIFfKfXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LrRfVU1R; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e60f6ea262so2283757b6e.1
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 12:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356360; x=1731961160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZOrOsZ4U8Z1PLuT0mm2pKda/bBg1AqKhK+ePUzLSNs=;
        b=LrRfVU1RcDXxsSzvUORvas3nCPwBCE+myjYCFjRCd/EhPGiryTYmn8CNbZq80JW+ZW
         /iKOFToqNE8TxBCgtYf9QpLWAdcg1ig0Tt7N8uzvWKsgKmlEFz437JnZenKqapCbIpoE
         1/TZgUPMZzt3e3aOTwOtWtZ5WW5h0ngRl1pKu8su8vpo3eZWuwKYwiaOo6/TFLGeA2lI
         6SQTdj0ziAZ27k4VkhpqsGsdw6zsa8rmD8HEnkWDtRwlHVEeUqufzAK1nzsYyZwXIcb4
         YyjJrALB5soyd7YuFuqC3Sb2KMWaSybOmSrf9aFJIGztkrg5XGKf1C/H9BZNaaJsUE8V
         s7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356360; x=1731961160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZOrOsZ4U8Z1PLuT0mm2pKda/bBg1AqKhK+ePUzLSNs=;
        b=u2s/5pblHN7I3KLn96D7YMqInnv4NPD4KAsXcaraqnPaQ1GOO75jtJ5zaodfxzT80e
         9DzN4SemUSVrNQ2aZr1tg+7iFj7meeZE7Hmh1ZLOOqY21sDTTMwuPDhJrBtqj6hQaMHK
         H2MENn7XQvoQMsZ8M0oLK60NNKphdtbPZ1BrsrqrytIRnVJoVP8ywMCxS4yrCCfmG3lP
         clFPQhm7xLWb2jG97KZ1FfMENoRK/kC5b8TX5lojmHIC+UUfnn3CgPNKij8xwFoBo97F
         fgmsZuHLFAjGEFDqJ3Y3qZ3PwqerBiujVXXeUZwsZ3jYRVa+YT1V+WUCLtzEmwZJR3Q3
         5rmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrS+SLdLliXSZMmKDfhT9avGRnCOQFSDvIiGAwtuNhQwH418MP74U9eLVlTk7jFoa8XLEeK1RkkAbZUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRFqOwhGxM8KBuk0YXctJl1p6lDrfmAyAhEtqN4g8mBxqFXDVk
	oZQ5pi35xDrwcC5nzaUmMhZ1sQrEhSyuZ4NTUdhPQGXRPnqf1v8gMvTo9Nw4rA4=
X-Google-Smtp-Source: AGHT+IHipOS2ybKSG81rwkOStrwkrxpZJxan2OC6U26/iyaDXrZO7WYlZi5blzqVcMk5sSNReEzGJQ==
X-Received: by 2002:a05:6808:1305:b0:3e6:40b3:e525 with SMTP id 5614622812f47-3e7947734bbmr9745673b6e.41.1731356360425;
        Mon, 11 Nov 2024 12:19:20 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961ecdcbsm63623066d6.31.2024.11.11.12.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:19 -0800 (PST)
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
Subject: [PATCH v6 07/17] fsnotify: generate pre-content permission event on truncate
Date: Mon, 11 Nov 2024 15:17:56 -0500
Message-ID: <95769c056a65cbc2d6ca6aa1fb66918acbe5ad0e.1731355931.git.josef@toxicpanda.com>
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

Generate FS_PRE_ACCESS event before truncate, without sb_writers held.

Move the security hooks also before sb_start_write() to conform with
other security hooks (e.g. in write, fallocate).

The event will have a range info of the page surrounding the new size
to provide an opportunity to fill the conetnt at the end of file before
truncating to non-page aligned size.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/open.c                | 31 +++++++++++++++++++++----------
 include/linux/fsnotify.h | 32 ++++++++++++++++++++++----------
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index c822f88d4c1d..51103ba339d0 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -81,14 +81,18 @@ long vfs_truncate(const struct path *path, loff_t length)
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
-	error = mnt_want_write(path->mnt);
-	if (error)
-		goto out;
-
 	idmap = mnt_idmap(path->mnt);
 	error = inode_permission(idmap, inode, MAY_WRITE);
 	if (error)
-		goto mnt_drop_write_and_out;
+		return error;
+
+	error = fsnotify_truncate_perm(path, length);
+	if (error)
+		return error;
+
+	error = mnt_want_write(path->mnt);
+	if (error)
+		return error;
 
 	error = -EPERM;
 	if (IS_APPEND(inode))
@@ -114,7 +118,7 @@ long vfs_truncate(const struct path *path, loff_t length)
 	put_write_access(inode);
 mnt_drop_write_and_out:
 	mnt_drop_write(path->mnt);
-out:
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_truncate);
@@ -175,11 +179,18 @@ long do_ftruncate(struct file *file, loff_t length, int small)
 	/* Check IS_APPEND on real upper inode */
 	if (IS_APPEND(file_inode(file)))
 		return -EPERM;
-	sb_start_write(inode->i_sb);
+
 	error = security_file_truncate(file);
-	if (!error)
-		error = do_truncate(file_mnt_idmap(file), dentry, length,
-				    ATTR_MTIME | ATTR_CTIME, file);
+	if (error)
+		return error;
+
+	error = fsnotify_truncate_perm(&file->f_path, length);
+	if (error)
+		return error;
+
+	sb_start_write(inode->i_sb);
+	error = do_truncate(file_mnt_idmap(file), dentry, length,
+			    ATTR_MTIME | ATTR_CTIME, file);
 	sb_end_write(inode->i_sb);
 
 	return error;
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 1e87a54b88b6..fbcdddb9601a 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -132,17 +132,14 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 }
 
 #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
-static inline int fsnotify_pre_content(const struct file *file,
+static inline int fsnotify_pre_content(const struct path *path,
 				       const loff_t *ppos, size_t count)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *inode = d_inode(path->dentry);
 	struct file_range range;
 	const void *data;
 	int data_type;
 
-	if (file->f_mode & FMODE_NONOTIFY)
-		return 0;
-
 	/*
 	 * Pre-content events are only reported for regular files and dirs
 	 * if there are any pre-content event watchers on this sb.
@@ -155,18 +152,17 @@ static inline int fsnotify_pre_content(const struct file *file,
 
 	/* Report page aligned range only when pos is known */
 	if (ppos) {
-		range.path = &file->f_path;
+		range.path = path;
 		range.pos = PAGE_ALIGN_DOWN(*ppos);
 		range.count = PAGE_ALIGN(*ppos + count) - range.pos;
 		data = &range;
 		data_type = FSNOTIFY_EVENT_FILE_RANGE;
 	} else {
-		data = &file->f_path;
+		data = path;
 		data_type = FSNOTIFY_EVENT_PATH;
 	}
 
-	return fsnotify_parent(file->f_path.dentry, FS_PRE_ACCESS,
-			       data, data_type);
+	return fsnotify_parent(path->dentry, FS_PRE_ACCESS, data, data_type);
 }
 
 /*
@@ -184,11 +180,14 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	 */
 	lockdep_assert_once(file_write_not_started(file));
 
+	if (file->f_mode & FMODE_NONOTIFY)
+		return 0;
+
 	/*
 	 * read()/write and other types of access generate pre-content events.
 	 */
 	if (perm_mask & (MAY_READ | MAY_WRITE | MAY_ACCESS | MAY_OPEN)) {
-		int ret = fsnotify_pre_content(file, ppos, count);
+		int ret = fsnotify_pre_content(&file->f_path, ppos, count);
 
 		if (ret)
 			return ret;
@@ -204,6 +203,14 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	return fsnotify_file(file, FS_ACCESS_PERM);
 }
 
+/*
+ * fsnotify_truncate_perm - permission hook before file truncate
+ */
+static inline int fsnotify_truncate_perm(const struct path *path, loff_t length)
+{
+	return fsnotify_pre_content(path, &length, 0);
+}
+
 /*
  * fsnotify_file_perm - permission hook before file access (unknown range)
  */
@@ -235,6 +242,11 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	return 0;
 }
 
+static inline int fsnotify_truncate_perm(const struct path *path, loff_t length)
+{
+	return 0;
+}
+
 static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
 	return 0;
-- 
2.43.0


