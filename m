Return-Path: <linux-btrfs+bounces-16384-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3771AB36E4B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258108E383B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C983435E4D1;
	Tue, 26 Aug 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Yeu5pdjD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6D632143C
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222878; cv=none; b=D5F/YFcv4DAYrrju/wRi6Rtr3H7i9J8M+ysTGCZwUUrqPZYpNg+3wTB6aef+1MhX2n7q/kBf0gMHKRQ+jo48QeVUUPBTlLuRhj7cKMfqjJWdd85EYWyiIVfZOmApFaNsXhy7hA6ZgMV5YoCyO/JaLEGd3Zl1b0lZHHZdF7z5F7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222878; c=relaxed/simple;
	bh=vkTzvz/W4398BCzhJaUNVJSxSUNoVuE4vBSu4sXgDQw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDLavNCl5L9C0Clg7oDO5jcJRfxsZWpJCPFuukWkI0b2yKTL8377F6zTmwTPEVOnRMmpIuMDl6OciOIAes180svC8j8pyPwTydMWL1zPIH0wvISuOjFD+4EZvgCgiqD2wIR3x+G+PzSqAx7V7Q0dEYZbaKKyN/d4yQ/PIamxiqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Yeu5pdjD; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d6051aeafso47651997b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222873; x=1756827673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJd+d9fGr0UltZkVFy/kO4XbRfY+EPSOK7xeYoY5Vpg=;
        b=Yeu5pdjDdDX9sHhysQ1uSJhmFzwnWWdYneDhpIHE6blybPIZRfQTXo5SU3l+pDSYDB
         deev64xwgAsUwrfusk/Zhyi88tS8CvC0eAemJJNGynrVRUzRZnyUK+H3Is976l4hzDy2
         B4FpvkWLxJ7cc8uLr6oMdazKVSMRfuoyoq45lfRQF3BoUfyZVbWoB+MUL/jNPvEsuwxL
         4/xRSLy1/8DRgS1U+F3nudj0vZYXb9V4bezeMEYQUF5ZVlwjC4450Au6Dl0LZdt/Jrwn
         sSvN33peHmP8XfwmWo2XvohOJNo6UhDGzqg5Zqy/WbFCdbDyde1CvOkEv5BAjol+m6nX
         +ffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222873; x=1756827673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJd+d9fGr0UltZkVFy/kO4XbRfY+EPSOK7xeYoY5Vpg=;
        b=Sv3hyJmDH+Db2upbQKWAOkYZvABYMKcu+ErXgGHlWpQ2xFe/kxs3X9TgVfOeXmn8cc
         HmzJvwA7oQFVQ7QaAFxvZ3Z7/A1SdUsS/uYLHbUZ+Qd/4BqQORuxvMSGiTm0gDxacP2e
         LVXwJBMhvL0RwnNgHn6Kz8wKxpitwpggJT9GCoZiXtT99hXGWagRWvIwqNgH//FMKz+E
         OWhiuQAi24DwHvujwK1UgkpZhqzGlUMoBxM83wfnhiXS7jTbI1YiM/3E2ASXHM0K3vRT
         wLFIjRkgGxUL5oZzNpa+ebvE5Ym3DhIxvU73poPhypDXhelieQZQiGIZnW24CJKuK3Iw
         JvKg==
X-Forwarded-Encrypted: i=1; AJvYcCXW1AL9lG60JEHKJf3trYOa5Yml+Tp5pJ+9r/NV3m3yUKlDamUI8QkqR3+ovajRFepCmE1bk2CQxjce5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJrEgghbPSA5cI3NBuiYHFxc/vqwA0QdCyVRH189VA1lUoMOc6
	VHiMNZUsxeZUbK9hN76q2egO9wLMZzlnAQpgKrNlmcb0IWpyIMS/2MjQajmx9DkZikQ=
X-Gm-Gg: ASbGncu65FxbnpqkMucmv2f09YcG85GKtY/3D2tMIVtA6DbDKedIqDVFiRtw8d/EE4l
	0fqkBQ4hdOqqCpdOXXU6Yu46vcbyh/N8KjmXdyUFpCPuQyn4MOUZvK0NmkycVgYKQhcwmVY+a4w
	bHhXsK4oQ9ymt6/AXhdUdodcKSkygaW4ojZzqMcHmcHwgWUQlar+zpOxNDRdcbwSnTBoXg+9/72
	KaDU82BkkbwvDRGwtmiJDeHjrwtnSjr78imyMqpMYEXMzUcgGU4blCDr1q+RwtJWDdUkBkNInfT
	l/Kt0Pwp78wJUAFNDc6IstsWxGU2q2Cc2EFh70BNsjCfsKSMl74NyefZ+a+MkGb4UqMTP/BF5D8
	5ZWZmuLd8spMOnjnhVgrchvJtj7zQo+3uiw31JwNWqPb1+UCsVt5hBclVWvynSadBDjbYWQ==
X-Google-Smtp-Source: AGHT+IHactrTikZ7jBRDCL1JZgH1mVdSWJ6FyyCGF3S7ZcAICNXpADGqeqy8Nq82lRQHu7tbjtoUGQ==
X-Received: by 2002:a05:690c:6109:b0:71f:b944:1028 with SMTP id 00721157ae682-71fdc537dafmr188258197b3.49.1756222873272;
        Tue, 26 Aug 2025 08:41:13 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7213f47d0b0sm157887b3.72.2025.08.26.08.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 17/54] fs: remove the inode from the LRU list on unlink/rmdir
Date: Tue, 26 Aug 2025 11:39:17 -0400
Message-ID: <3552943716349efa4ff107bb590ac6b980183735.1756222465.git.josef@toxicpanda.com>
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

We can end up with an inode on the LRU list or the cached list, then at
some point in the future go to unlink that inode and then still have an
elevated i_count reference for that inode because it is on one of these
lists.

The more common case is the cached list. We open a file, write to it,
truncate some of it which triggers the inode_add_lru code in the
pagecache, adding it to the cached LRU.  Then we unlink this inode, and
it exists until writeback or reclaim kicks in and removes the inode.

To handle this case, delete the inode from the LRU list when it is
unlinked, so we have the best case scenario for immediately freeing the
inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/namei.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 138a693c2346..e56dcb5747e4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4438,6 +4438,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry)
 {
+	struct inode *inode = dentry->d_inode;
 	int error = may_delete(idmap, dir, dentry, 1);
 
 	if (error)
@@ -4447,11 +4448,11 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 		return -EPERM;
 
 	dget(dentry);
-	inode_lock(dentry->d_inode);
+	inode_lock(inode);
 
 	error = -EBUSY;
 	if (is_local_mountpoint(dentry) ||
-	    (dentry->d_inode->i_flags & S_KERNEL_FILE))
+	    (inode->i_flags & S_KERNEL_FILE))
 		goto out;
 
 	error = security_inode_rmdir(dir, dentry);
@@ -4463,12 +4464,21 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 		goto out;
 
 	shrink_dcache_parent(dentry);
-	dentry->d_inode->i_flags |= S_DEAD;
+	inode->i_flags |= S_DEAD;
 	dont_mount(dentry);
 	detach_mounts(dentry);
 
 out:
-	inode_unlock(dentry->d_inode);
+	/*
+	 * The inode may be on the LRU list, so delete it from the LRU at this
+	 * point in order to make sure that the inode is freed as soon as
+	 * possible.
+	 */
+	spin_lock(&inode->i_lock);
+	inode_lru_list_del(inode);
+	spin_unlock(&inode->i_lock);
+
+	inode_unlock(inode);
 	dput(dentry);
 	if (!error)
 		d_delete_notify(dir, dentry);
@@ -4653,8 +4663,18 @@ int do_unlinkat(int dfd, struct filename *name)
 		dput(dentry);
 	}
 	inode_unlock(path.dentry->d_inode);
-	if (inode)
+	if (inode) {
+		/*
+		 * The LRU may be holding a reference, remove the inode from the
+		 * LRU here before dropping our hopefully final reference on the
+		 * inode.
+		 */
+		spin_lock(&inode->i_lock);
+		inode_lru_list_del(inode);
+		spin_unlock(&inode->i_lock);
+
 		iput(inode);	/* truncate the inode here */
+	}
 	inode = NULL;
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
-- 
2.49.0


