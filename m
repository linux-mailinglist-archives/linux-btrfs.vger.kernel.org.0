Return-Path: <linux-btrfs+bounces-9709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EC49CF011
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6672837BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BF3126C17;
	Fri, 15 Nov 2024 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="MdOweBIp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968271D6DB1
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684689; cv=none; b=rmwLaqbwEoftHHjHSsVQsFL2Eeke9x8W7NdHSQoRLa0VX55zpFVIVPqsVEWT0w6vnO6DJtji9gpQg4hvuPsvgUvKaAwZYOBK2ZrSa6r363BUtdcxKXp5AZKKTmgNx+PihWKJMJfWJiQ2N3pSMNo7z4u3HGhq/k9FHm0m+7wxl2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684689; c=relaxed/simple;
	bh=1WvRI87ybBbAcRK4/nzciaftKH4dEBSZtNpGXoA1brQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtBgF/2/77IW1WvCBINVDp1gEcDRAf4S0AWZEUCOZAfe9PQ9dfVfYygbdf1tF5PYj22Uy65oUb5L31VA7Kzz5CyykNn0X4SRbfojGevGJkL6dhFqVKxM2MpYqrR5UpAz5BRfkp7YmebUqT6yrrSOaxINokSCNIQdryACI7KfsJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=MdOweBIp; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ea7c26e195so9549097b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 07:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684686; x=1732289486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KY5fZdmP1liuAXJOZsCM4eyAqIeREr5VHEr0FLOlUs=;
        b=MdOweBIplt7nuQIKikOwYXqEJ8g90ibqCZfv9yHf0UnFqfKXC5EGqjIpp63xZDwLzo
         O4s2h0iIBRc1+cgz4z3XxTUnZQKnKQfN68E+3Ukakjd9JhMDoZwHw4CVHcc9c3WRvFpR
         z8nXNdSkV2UH2wOwtqiT8nq21zb4oSDc6ZsTbxOvT8oyE65unjqx2D79/X54aRKpSr1D
         nSFgfDD6Rk2cICVoqSid9mcz8xn7/pUQ7Xntn0T6Vx+iXPZidCX8IJ0Ap3ECQYNY88pz
         UWb4pYUTKGQZwoMAypNwllBebf8OPaa3vOOHEWM+eUBymHRVPG5aUmGriY/ZXVoMeOSK
         Gwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684686; x=1732289486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KY5fZdmP1liuAXJOZsCM4eyAqIeREr5VHEr0FLOlUs=;
        b=B8Hym5gDzvoICCJWD3jjmhyYmRVGntGUV3lIqB1FoxGm31v0zODGV9JHeAL9hiL0i2
         +K4n8wisL98cAj1u3W1cEvxU47nhGSnduW6RAA7M/qp+sCsWZYO6D9x4enSE8IDICYE8
         SA5DfBBsOsd87TOP+ovubVCgFE8ogV5v3/rYJRXs+FUf2cS7lz6xeZYSDyZoazPeJUKN
         mHNBrSyMr+sDjFEW9155VzTF0QGSWLnGbYHi51OODvYUy/S0bbiKj14E+Ocvg4ngNC0M
         Jj+1ReATA8PrtjXY/iKJaNK3xBlVgU7QeG3FPIxUDWqmFk1YVNn/1SUJeqak1Zr4dr3R
         Y4Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUyNEEe5W65EWiUg025dRt/Qrrp/s4qOJteMVmh8kn7XldYL5njBcEBMXGx+ob3hR4svKixlMEDj0srTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbWSd5YhdSt0s6gP3lejXIRnf24zGPwXoTgaFGeS7j0DnPAyC+
	XgqX65M3dwMmb4F7WD8u2GaOMhpAezpBLR9WP0Igvj9LOXr03F7eGy2HsHXMHiY=
X-Google-Smtp-Source: AGHT+IHdSr7sIuKVmbedcInH94EUveWdRZ8jZfw4hoXsU2FWCk1ayn1ufjs9+AX7MxAWuqGyDVgHDQ==
X-Received: by 2002:a05:690c:360b:b0:6ea:34b1:62e3 with SMTP id 00721157ae682-6ee55a2f60cmr35106257b3.7.1731684686563;
        Fri, 15 Nov 2024 07:31:26 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee44070647sm7648387b3.53.2024.11.15.07.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:25 -0800 (PST)
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
Subject: [PATCH v8 03/19] fsnotify: add helper to check if file is actually being watched
Date: Fri, 15 Nov 2024 10:30:16 -0500
Message-ID: <2ddcc9f8d1fde48d085318a6b5a889289d8871d8.1731684329.git.josef@toxicpanda.com>
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

So far, we set FMODE_NONOTIFY_ flags at open time if we know that there
are no permission event watchers at all on the filesystem, but lack of
FMODE_NONOTIFY_ flags does not mean that the file is actually watched.

To make the flags more accurate we add a helper that checks if the
file's inode, mount, sb or parent are being watched for a set of events.

This is going to be used for setting FMODE_NONOTIFY_HSM only when the
specific file is actually watched for pre-content events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c             | 36 +++++++++++++++++++++++++-------
 include/linux/fsnotify_backend.h |  7 +++++++
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index f976949d2634..33576a848a9f 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -193,16 +193,38 @@ static bool fsnotify_event_needs_parent(struct inode *inode, __u32 mnt_mask,
 	return mask & marks_mask;
 }
 
-/* Are there any inode/mount/sb objects that are interested in this event? */
-static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
-					   __u32 mask)
+/* Are there any inode/mount/sb objects that watch for these events? */
+static inline __u32 fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
+					    __u32 events_mask)
 {
 	__u32 marks_mask = READ_ONCE(inode->i_fsnotify_mask) | mnt_mask |
 			   READ_ONCE(inode->i_sb->s_fsnotify_mask);
 
-	return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
+	return events_mask & marks_mask;
 }
 
+/* Are there any inode/mount/sb/parent objects that watch for these events? */
+__u32 fsnotify_file_object_watched(struct file *file, __u32 events_mask)
+{
+	struct dentry *dentry = file->f_path.dentry;
+	struct dentry *parent;
+	__u32 marks_mask, mnt_mask =
+		READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
+
+	marks_mask = fsnotify_object_watched(d_inode(dentry), mnt_mask,
+					     events_mask);
+
+	if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED)))
+		return marks_mask;
+
+	parent = dget_parent(dentry);
+	marks_mask |= fsnotify_inode_watches_children(d_inode(parent));
+	dput(parent);
+
+	return marks_mask & events_mask;
+}
+EXPORT_SYMBOL_GPL(fsnotify_file_object_watched);
+
 /*
  * Notify this dentry's parent about a child's events with child name info
  * if parent is watching or if inode/sb/mount are interested in events with
@@ -221,7 +243,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	struct dentry *parent;
 	bool parent_watched = dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED;
 	bool parent_needed, parent_interested;
-	__u32 p_mask;
+	__u32 p_mask, test_mask = mask & ALL_FSNOTIFY_EVENTS;
 	struct inode *p_inode = NULL;
 	struct name_snapshot name;
 	struct qstr *file_name = NULL;
@@ -229,7 +251,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 
 	/* Optimize the likely case of nobody watching this path */
 	if (likely(!parent_watched &&
-		   !fsnotify_object_watched(inode, mnt_mask, mask)))
+		   !fsnotify_object_watched(inode, mnt_mask, test_mask)))
 		return 0;
 
 	parent = NULL;
@@ -248,7 +270,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	 * Include parent/name in notification either if some notification
 	 * groups require parent info or the parent is interested in this event.
 	 */
-	parent_interested = mask & p_mask & ALL_FSNOTIFY_EVENTS;
+	parent_interested = p_mask & test_mask;
 	if (parent_needed || parent_interested) {
 		/* When notifying parent, child should be passed as data */
 		WARN_ON_ONCE(inode != fsnotify_data_inode(data, data_type));
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 3ecf7768e577..99d81c3c11d7 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -855,8 +855,15 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
 	INIT_LIST_HEAD(&event->list);
 }
 
+__u32 fsnotify_file_object_watched(struct file *file, __u32 mask);
+
 #else
 
+static inline __u32 fsnotify_file_object_watched(struct file *file, __u32 mask)
+{
+	return 0;
+}
+
 static inline int fsnotify(__u32 mask, const void *data, int data_type,
 			   struct inode *dir, const struct qstr *name,
 			   struct inode *inode, u32 cookie)
-- 
2.43.0


