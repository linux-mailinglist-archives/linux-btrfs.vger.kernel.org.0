Return-Path: <linux-btrfs+bounces-16204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DA2B30626
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DBE624E85
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F9338A60E;
	Thu, 21 Aug 2025 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="UFw/f9q7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2DB350D74
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807623; cv=none; b=kdKcmoR+Ism0CvdkEnBykIJQarEL55s3g67LQ1fGPJoI/gJLYF6y9MWmrFHUV+NrYqMc0smGt4AzFMlUoYOt9CEZggxwK27Fr9Kc80Pm+83b0dTkYSO47DLsskQ7VUy9WK5qDgSz4+F0WjVBf4dKCV85CfzIwhMZf67Q9BGKxbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807623; c=relaxed/simple;
	bh=xDF1BZHRgll8r9ePxqTRE8AusjqiPqbehJhffi4bwTQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSijc9RolAhSbS92f9YkFEUdPMPUGLHScBLj5bdr8H+gcv/pY7hS/Lm3kECUZIyrK9RxFwYJmu42l/SiqH76xjVk3G/fMCC10Hspf90nsIfcjoazYPnNn0enKYmlSRgDYRKNqMjs/yF7KIIT5Xh6HUWL3oVctwd2DBRMim/goJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=UFw/f9q7; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d60593000so11283067b3.3
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807619; x=1756412419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9fMeApSwNvWbdSWinLhDcYIQNpYIQGmK7DG9fmCNOo=;
        b=UFw/f9q7rNOO7csqpfrpBUX8Yil6NoEd+jVMWPAmOlWWZtO4XgrbNArARt6aWsBw0J
         VATF149SG1I9kkYLkXacDZY57Eyz3qqW72N5QPPivl6AxRg9oMM3y6jESni/hOT1GV/T
         1LWEA+w4IXJtpHjz4KHXtcI07haMRMYONdAX3WcVA7qVJMfL+XYjNscQ72hAJZM6aX1d
         7x6OdRzm0xY2DJRgBSt70xWwQORWs/djAbQakZgjy2xMCuyVeu7i4wP/X1dTftmWaOLq
         8uaA3/MHDgfaNcIPmBMoE0wgTTXadmUEexvLvSKkIohRXL4l5aKp9mge/zZjsntggD32
         ZaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807619; x=1756412419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9fMeApSwNvWbdSWinLhDcYIQNpYIQGmK7DG9fmCNOo=;
        b=Vh3aCfxJBKaonIMYAKTxIww+bP7sjoFFBnVKIDBpUISL2QnsHSYqSVjon/3muyfoO7
         y8BtXKPqe4n6bZaJWYNh3ZOUEyNMfwmwFeVfVgVmPSZTRyZWJ50wsDjinmTgrj/StSIO
         R7lgg8VwZuYDj05aPk0v7S3ged2D2HGbrytdV0ciXci+MxivBWbWy05QJk7gZCawOOqb
         LXdV+JlhwgKpXPiI1vkLoaAeqly9NIHhwBo8R48a1Vh9OaZfck4pT3TKd1AY7/dW44LN
         Cu6ow+VoAf2uJo2oFuOZ21vpu6t55x2s9cI0icvBct7X2zckAekdTZc89GhsfyNKbjnN
         Kghw==
X-Forwarded-Encrypted: i=1; AJvYcCVR/2sIQfbALFMAQ8bfOGLzetH//nhrlbnwocB87azXiX5vlKgEDA3J86HkK5HB+5VR4YAgp4IIBRxWMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXGjZ7XPq/ahy3GUACcxgklxVD3vLIk+NBL7E9D1jcR6rXxOHN
	bYCwxBAXljZOTd5Hhl6ZDM/qyj3A3HXg1reJFwr9jLsX7KQVb87bozMuAripGk1tFBs=
X-Gm-Gg: ASbGncs6qSIVO8wCiEpHB+m6C+IiBxXYoreJysZ2dwMGK1nTv4lZh3m91CSw3ZDdCxr
	lS155vZJaLWLagQncWQERniLImTdHZev8DAVTRBx41YmDliNOnlnp+cb5nV5KYbsY1Vuq1Uxm6G
	K6hcJidLCeGIlkRjhLgG7iuox8BLk+T5WItiyyjea0W7dJyz8nENnE70WaGNeRgLHbvAU6SEPBE
	9zgWIj6u5omMhJLow/K54CO3UjpPpFJkfbX8tW6Qk3704R2NaRaJdk+06LYD+FcmjXeDNFxwKpR
	nEfjAiqIenKGJt2JK7Nl3lygm8DAoRi5tmKdYzxsX3q6iIv2ZhTnKKQDsFnDVinipPqNhQ/ie4c
	vEZ/8rZNK5QKdkDDaiieGGczi8mcPO+q3iPkGNFxjVQtjdeASicwQ+Kg/JTnPum2vDgcBgQ==
X-Google-Smtp-Source: AGHT+IFvKOM/RTV7+esqnfgkT3+zba4GE5pNwWEUHiiv9ICW/Oer0zq0k7w/85TozYi/lPW8a3I+MQ==
X-Received: by 2002:a05:690c:6e12:b0:71f:b944:1041 with SMTP id 00721157ae682-71fdc542caemr6096967b3.50.1755807618684;
        Thu, 21 Aug 2025 13:20:18 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f52c8b347csm50305d50.6.2025.08.21.13.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:17 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 02/50] fs: make the i_state flags an enum
Date: Thu, 21 Aug 2025 16:18:13 -0400
Message-ID: <02211105388c53dc68b7f4332f9b5649d5b66b71.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjusting i_state flags always means updating the values manually. Bring
these forward into the 2020's and make a nice clean macro for defining
the i_state values as an enum, providing __ variants for the cases where
we need the bit position instead of the actual value, and leaving the
actual NAME as the 1U << bit value.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/fs.h | 234 +++++++++++++++++++++++----------------------
 1 file changed, 122 insertions(+), 112 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9a1ce67eed33..e741dc453c2c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -665,6 +665,127 @@ is_uncached_acl(struct posix_acl *acl)
 #define IOP_MGTIME	0x0020
 #define IOP_CACHED_LINK	0x0040
 
+/*
+ * Inode state bits.  Protected by inode->i_lock
+ *
+ * Four bits determine the dirty state of the inode: I_DIRTY_SYNC,
+ * I_DIRTY_DATASYNC, I_DIRTY_PAGES, and I_DIRTY_TIME.
+ *
+ * Four bits define the lifetime of an inode.  Initially, inodes are I_NEW,
+ * until that flag is cleared.  I_WILL_FREE, I_FREEING and I_CLEAR are set at
+ * various stages of removing an inode.
+ *
+ * Two bits are used for locking and completion notification, I_NEW and I_SYNC.
+ *
+ * I_DIRTY_SYNC		Inode is dirty, but doesn't have to be written on
+ *			fdatasync() (unless I_DIRTY_DATASYNC is also set).
+ *			Timestamp updates are the usual cause.
+ * I_DIRTY_DATASYNC	Data-related inode changes pending.  We keep track of
+ *			these changes separately from I_DIRTY_SYNC so that we
+ *			don't have to write inode on fdatasync() when only
+ *			e.g. the timestamps have changed.
+ * I_DIRTY_PAGES	Inode has dirty pages.  Inode itself may be clean.
+ * I_DIRTY_TIME		The inode itself has dirty timestamps, and the
+ *			lazytime mount option is enabled.  We keep track of this
+ *			separately from I_DIRTY_SYNC in order to implement
+ *			lazytime.  This gets cleared if I_DIRTY_INODE
+ *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set. But
+ *			I_DIRTY_TIME can still be set if I_DIRTY_SYNC is already
+ *			in place because writeback might already be in progress
+ *			and we don't want to lose the time update
+ * I_NEW		Serves as both a mutex and completion notification.
+ *			New inodes set I_NEW.  If two processes both create
+ *			the same inode, one of them will release its inode and
+ *			wait for I_NEW to be released before returning.
+ *			Inodes in I_WILL_FREE, I_FREEING or I_CLEAR state can
+ *			also cause waiting on I_NEW, without I_NEW actually
+ *			being set.  find_inode() uses this to prevent returning
+ *			nearly-dead inodes.
+ * I_WILL_FREE		Must be set when calling write_inode_now() if i_count
+ *			is zero.  I_FREEING must be set when I_WILL_FREE is
+ *			cleared.
+ * I_FREEING		Set when inode is about to be freed but still has dirty
+ *			pages or buffers attached or the inode itself is still
+ *			dirty.
+ * I_CLEAR		Added by clear_inode().  In this state the inode is
+ *			clean and can be destroyed.  Inode keeps I_FREEING.
+ *
+ *			Inodes that are I_WILL_FREE, I_FREEING or I_CLEAR are
+ *			prohibited for many purposes.  iget() must wait for
+ *			the inode to be completely released, then create it
+ *			anew.  Other functions will just ignore such inodes,
+ *			if appropriate.  I_NEW is used for waiting.
+ *
+ * I_SYNC		Writeback of inode is running. The bit is set during
+ *			data writeback, and cleared with a wakeup on the bit
+ *			address once it is done. The bit is also used to pin
+ *			the inode in memory for flusher thread.
+ *
+ * I_REFERENCED		Marks the inode as recently references on the LRU list.
+ *
+ * I_WB_SWITCH		Cgroup bdi_writeback switching in progress.  Used to
+ *			synchronize competing switching instances and to tell
+ *			wb stat updates to grab the i_pages lock.  See
+ *			inode_switch_wbs_work_fn() for details.
+ *
+ * I_OVL_INUSE		Used by overlayfs to get exclusive ownership on upper
+ *			and work dirs among overlayfs mounts.
+ *
+ * I_CREATING		New object's inode in the middle of setting up.
+ *
+ * I_DONTCACHE		Evict inode as soon as it is not used anymore.
+ *
+ * I_SYNC_QUEUED	Inode is queued in b_io or b_more_io writeback lists.
+ *			Used to detect that mark_inode_dirty() should not move
+ *			inode between dirty lists.
+ *
+ * I_PINNING_FSCACHE_WB	Inode is pinning an fscache object for writeback.
+ *
+ * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
+ *			i_count.
+ *
+ * Q: What is the difference between I_WILL_FREE and I_FREEING?
+ *
+ * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
+ * upon. There's one free address left.
+ */
+
+/*
+ * As simple macro to define the inode state bits, __NAME will be the bit value
+ * (0, 1, 2, ...), and NAME will be the bit mask (1U << __NAME). The __NAME_SEQ
+ * is used to reset the sequence number so the next name gets the next bit value
+ * in the sequence.
+ */
+#define INODE_BIT(name)			\
+	__ ## name,			\
+	name = (1U << __ ## name),	\
+	__ ## name ## _SEQ = __ ## name
+
+enum inode_state_bits {
+	INODE_BIT(I_NEW),
+	INODE_BIT(I_SYNC),
+	INODE_BIT(I_LRU_ISOLATING),
+	INODE_BIT(I_DIRTY_SYNC),
+	INODE_BIT(I_DIRTY_DATASYNC),
+	INODE_BIT(I_DIRTY_PAGES),
+	INODE_BIT(I_WILL_FREE),
+	INODE_BIT(I_FREEING),
+	INODE_BIT(I_CLEAR),
+	INODE_BIT(I_REFERENCED),
+	INODE_BIT(I_LINKABLE),
+	INODE_BIT(I_DIRTY_TIME),
+	INODE_BIT(I_WB_SWITCH),
+	INODE_BIT(I_OVL_INUSE),
+	INODE_BIT(I_CREATING),
+	INODE_BIT(I_DONTCACHE),
+	INODE_BIT(I_SYNC_QUEUED),
+	INODE_BIT(I_PINNING_NETFS_WB),
+};
+
+#define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
+#define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
+#define I_DIRTY_ALL (I_DIRTY | I_DIRTY_TIME)
+
 /*
  * Keep mostly read-only and often accessed (especially for
  * the RCU path lookup and 'stat' data) fields at the beginning
@@ -723,7 +844,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	u32			i_state;
+	enum inode_state_bits	i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -2484,117 +2605,6 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 	};
 }
 
-/*
- * Inode state bits.  Protected by inode->i_lock
- *
- * Four bits determine the dirty state of the inode: I_DIRTY_SYNC,
- * I_DIRTY_DATASYNC, I_DIRTY_PAGES, and I_DIRTY_TIME.
- *
- * Four bits define the lifetime of an inode.  Initially, inodes are I_NEW,
- * until that flag is cleared.  I_WILL_FREE, I_FREEING and I_CLEAR are set at
- * various stages of removing an inode.
- *
- * Two bits are used for locking and completion notification, I_NEW and I_SYNC.
- *
- * I_DIRTY_SYNC		Inode is dirty, but doesn't have to be written on
- *			fdatasync() (unless I_DIRTY_DATASYNC is also set).
- *			Timestamp updates are the usual cause.
- * I_DIRTY_DATASYNC	Data-related inode changes pending.  We keep track of
- *			these changes separately from I_DIRTY_SYNC so that we
- *			don't have to write inode on fdatasync() when only
- *			e.g. the timestamps have changed.
- * I_DIRTY_PAGES	Inode has dirty pages.  Inode itself may be clean.
- * I_DIRTY_TIME		The inode itself has dirty timestamps, and the
- *			lazytime mount option is enabled.  We keep track of this
- *			separately from I_DIRTY_SYNC in order to implement
- *			lazytime.  This gets cleared if I_DIRTY_INODE
- *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set. But
- *			I_DIRTY_TIME can still be set if I_DIRTY_SYNC is already
- *			in place because writeback might already be in progress
- *			and we don't want to lose the time update
- * I_NEW		Serves as both a mutex and completion notification.
- *			New inodes set I_NEW.  If two processes both create
- *			the same inode, one of them will release its inode and
- *			wait for I_NEW to be released before returning.
- *			Inodes in I_WILL_FREE, I_FREEING or I_CLEAR state can
- *			also cause waiting on I_NEW, without I_NEW actually
- *			being set.  find_inode() uses this to prevent returning
- *			nearly-dead inodes.
- * I_WILL_FREE		Must be set when calling write_inode_now() if i_count
- *			is zero.  I_FREEING must be set when I_WILL_FREE is
- *			cleared.
- * I_FREEING		Set when inode is about to be freed but still has dirty
- *			pages or buffers attached or the inode itself is still
- *			dirty.
- * I_CLEAR		Added by clear_inode().  In this state the inode is
- *			clean and can be destroyed.  Inode keeps I_FREEING.
- *
- *			Inodes that are I_WILL_FREE, I_FREEING or I_CLEAR are
- *			prohibited for many purposes.  iget() must wait for
- *			the inode to be completely released, then create it
- *			anew.  Other functions will just ignore such inodes,
- *			if appropriate.  I_NEW is used for waiting.
- *
- * I_SYNC		Writeback of inode is running. The bit is set during
- *			data writeback, and cleared with a wakeup on the bit
- *			address once it is done. The bit is also used to pin
- *			the inode in memory for flusher thread.
- *
- * I_REFERENCED		Marks the inode as recently references on the LRU list.
- *
- * I_WB_SWITCH		Cgroup bdi_writeback switching in progress.  Used to
- *			synchronize competing switching instances and to tell
- *			wb stat updates to grab the i_pages lock.  See
- *			inode_switch_wbs_work_fn() for details.
- *
- * I_OVL_INUSE		Used by overlayfs to get exclusive ownership on upper
- *			and work dirs among overlayfs mounts.
- *
- * I_CREATING		New object's inode in the middle of setting up.
- *
- * I_DONTCACHE		Evict inode as soon as it is not used anymore.
- *
- * I_SYNC_QUEUED	Inode is queued in b_io or b_more_io writeback lists.
- *			Used to detect that mark_inode_dirty() should not move
- * 			inode between dirty lists.
- *
- * I_PINNING_FSCACHE_WB	Inode is pinning an fscache object for writeback.
- *
- * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
- *			i_count.
- *
- * Q: What is the difference between I_WILL_FREE and I_FREEING?
- *
- * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
- * upon. There's one free address left.
- */
-#define __I_NEW			0
-#define I_NEW			(1 << __I_NEW)
-#define __I_SYNC		1
-#define I_SYNC			(1 << __I_SYNC)
-#define __I_LRU_ISOLATING	2
-#define I_LRU_ISOLATING		(1 << __I_LRU_ISOLATING)
-
-#define I_DIRTY_SYNC		(1 << 3)
-#define I_DIRTY_DATASYNC	(1 << 4)
-#define I_DIRTY_PAGES		(1 << 5)
-#define I_WILL_FREE		(1 << 6)
-#define I_FREEING		(1 << 7)
-#define I_CLEAR			(1 << 8)
-#define I_REFERENCED		(1 << 9)
-#define I_LINKABLE		(1 << 10)
-#define I_DIRTY_TIME		(1 << 11)
-#define I_WB_SWITCH		(1 << 12)
-#define I_OVL_INUSE		(1 << 13)
-#define I_CREATING		(1 << 14)
-#define I_DONTCACHE		(1 << 15)
-#define I_SYNC_QUEUED		(1 << 16)
-#define I_PINNING_NETFS_WB	(1 << 17)
-
-#define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
-#define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
-#define I_DIRTY_ALL (I_DIRTY | I_DIRTY_TIME)
-
 extern void __mark_inode_dirty(struct inode *, int);
 static inline void mark_inode_dirty(struct inode *inode)
 {
-- 
2.49.0


