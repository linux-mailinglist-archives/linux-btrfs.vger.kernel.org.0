Return-Path: <linux-btrfs+bounces-16418-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF84B36F00
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7BBF9852C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45B137429A;
	Tue, 26 Aug 2025 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="e3wuX2Ra"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A78374265
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222927; cv=none; b=XDpmqAun1joE4cotLjYujZKZ/6GQVlSn7ME9eQY/5HB701jEN4oyIqYl8lS5uAAYMxgOPB+ddzF/40c+LFoyVdIXk7L7lHc/hCJMiSah/NA6sAzCVqeaacncjMNsONRPYo4oW5gMfIi8Wxqzvj03XWw332iBigEgxJ/xOsu77kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222927; c=relaxed/simple;
	bh=dz7pz3D1x9bJz+zoasRoMryJ/WdU8PGe074O2/u02vw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrMGNbvw7yhrCTXJNdVm65YLLRwan1vrwZJ8Ne/vKp876MBy8iluhSSRjY0NkgOl2Np2S6qxK1AfeKM6iuzDuHk6w5eNhb/RiSyp2in6t10uANrmoNOgVQ2t7SpqvhgnRIhF4ZjNc0oG/BmAlFZtMigprlI1Ke2IaOMlvLfaGN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=e3wuX2Ra; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71e6f84b77eso46763607b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222925; x=1756827725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j69fEwdH/cEI/jfu7NSecLK4sdDP53FUdyNXftrEBYE=;
        b=e3wuX2RaS/MXYBX8vLiRu5P5U9Hz2i1uEqqtB04whMarZ27hoSjm/Fgyg6tRySZMO+
         2sGV2VPm2z9txOcNAPE0zIWsjfTb3sa8VYXsQ2Vmw/hcBqkz63FZnSTli2O6jmNfUTj1
         NQ3Oq1aXfgBOycmw8j+ZHRpqXulquQVYt99Z/fpdPd8iST/J0MfiqD0freN+eVhntQhs
         bGvUuhCZheDAa5JIFEYxxF8jPa6CqRoAel6nenCGQ1VnO3QncZYYk4At/gTKKLwt9j99
         CwFKwjHOeleVkeqiY7g7/cHvCdHGownkRCOwutw4KoJr6+Jt/OfrF5w3wGI3TAth2HmZ
         lZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222925; x=1756827725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j69fEwdH/cEI/jfu7NSecLK4sdDP53FUdyNXftrEBYE=;
        b=D15yaHyW/Lu2FOtiL63SREqQQg/URdFiz8s8m5DC/vCvKPK7fSDYAke/O0ZeEhTK0o
         Y1VejpjN8cjogG9N+fT+1cPMT9pRSVIf26qYrVCkY0ny2HRiWPYptNz5xBloqCBxHxLn
         tDGvpmOua8y3WoT25DwQ5fbm49V/LKFRJ+gHYs2gFRopNMhW0cKTc1qORCaCxi3Icsam
         erbQECYYq9YM9tKmtTZHh6tLHsbnz62uWpeJnQ2gsyLqENKMx1vmUvvLrVOKqio9chTR
         Pg/98+/ejT3JSfutchPK6ZCIPMkKdPynreEBa9DH9/B84j9y/avCEFum/krJOLoyFcf+
         vaPA==
X-Forwarded-Encrypted: i=1; AJvYcCXc2dolKWfwQz3N9/QSrooft8OqqAHt4tLKZ1PBOaZjJGoxyVxquoclbPhezaq/fZ2aobBg6KyFnvNA7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXl7PR0/ZM/kQIwugdx2pOaXYGygVBQiBNJ2JLeTgGB6TRdgD9
	rj1YUdSvCRIhK5mz/PbSgaEvIk1qjYOcPSPwr9xomlGhzPSRdik4ljYgKgyVeHg5ZrmeNBz7aN4
	S/5Zc
X-Gm-Gg: ASbGncsuwJnS4t2N6w/elPJZMl+HplzpcVXxwWmwcGMG9tt2yGQvtrJHSf9fuXVsh9U
	b/9QUNZgmh19v3XVOBQWuuU5tHeMCfe4j3sffo3gMz842El3imRO6sYtAxMZCrGV68RwbloK8Mt
	UEq7EZvvmYxzx0S9j23BqDx2bTn9VXAxtcPm+SHc9sRVtHGHEqoZDg0KlIF/kKj2N0VZmHhyvqI
	UDQcmx6EoMDbx1z3ul8aB4tFDeNLXmBrKLw1AIEtXIL8Pct3K3e7UiRUB+8h5ZsubIYgDzD73Fo
	wFj/k9bOw+hEMo7gEA9bIiXiRcs6rACuczsYmCLIt3r28WqCx7MB6F4TpCHkHcd6e1GcC+bX6Uz
	g1cqn4QhjaEnuFzQZzNs/k3ZJZj/mU2SXYFOWtUYdsEtP/CJF8PWGh+M546Y=
X-Google-Smtp-Source: AGHT+IGz1x+Q8VhYjUBX1dmi9LUurfOGbDwxfAEfBgQpfJFWyv9xn5pt9VOMnyDNVg5KM8Zj05CrGg==
X-Received: by 2002:a05:690c:3507:b0:70e:18c0:dabd with SMTP id 00721157ae682-71fdc0dca0fmr200544897b3.0.1756222924991;
        Tue, 26 Aug 2025 08:42:04 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18b3794sm25081317b3.63.2025.08.26.08.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:42:04 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 52/54] fs: remove I_REFERENCED
Date: Tue, 26 Aug 2025 11:39:52 -0400
Message-ID: <6e9872dad14133dd05f1142da46d86e456815208.1756222465.git.josef@toxicpanda.com>
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

Because we have referenced inodes on the LRU we've had to change the
behavior to make sure we remove the inode from the LRU when we reference
it.

We do this to account for the fact that we may end up with an inode on
the LRU list, and then unlink the inode. We want the last iput() in the
unlink() to actually evict the inode ideally, so we don't want it to
stick around on the LRU and be evicted that way.

With that behavior change we no longer need I_REFERENCED, as we're
always removing the inode from the LRU list on a subsequent access if
it's on the LRU.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c                       | 36 +++++++-------------------------
 include/linux/fs.h               | 22 +++++++++----------
 include/trace/events/writeback.h |  1 -
 3 files changed, 17 insertions(+), 42 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 8f61761ca021..4f77db7aca75 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -591,7 +591,12 @@ static bool inode_del_cached_lru(struct inode *inode)
 	return false;
 }
 
-static void __inode_add_lru(struct inode *inode, bool rotate)
+/*
+ * Add inode to LRU if needed (inode is unused and clean).
+ *
+ * Needs inode->i_lock held.
+ */
+void inode_add_lru(struct inode *inode)
 {
 	bool need_ref = true;
 
@@ -614,8 +619,6 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 		if (need_ref)
 			__iget(inode);
 		this_cpu_inc(nr_unused);
-	} else if (rotate) {
-		inode->i_state |= I_REFERENCED;
 	}
 }
 
@@ -630,16 +633,6 @@ struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
 }
 EXPORT_SYMBOL(inode_bit_waitqueue);
 
-/*
- * Add inode to LRU if needed (inode is unused and clean).
- *
- * Needs inode->i_lock held.
- */
-void inode_add_lru(struct inode *inode)
-{
-	__inode_add_lru(inode, false);
-}
-
 /*
  * Caller must be holding it's own i_count reference on this inode in order to
  * prevent this being the final iput.
@@ -1001,14 +994,6 @@ EXPORT_SYMBOL_GPL(evict_inodes);
 
 /*
  * Isolate the inode from the LRU in preparation for freeing it.
- *
- * If the inode has the I_REFERENCED flag set, then it means that it has been
- * used recently - the flag is set in iput_final(). When we encounter such an
- * inode, clear the flag and move it to the back of the LRU so it gets another
- * pass through the LRU before it gets reclaimed. This is necessary because of
- * the fact we are doing lazy LRU updates to minimise lock contention so the
- * LRU does not have strict ordering. Hence we don't want to reclaim inodes
- * with this flag set because they are the inodes that are out of order.
  */
 static enum lru_status inode_lru_isolate(struct list_head *item,
 		struct list_lru_one *lru, void *arg)
@@ -1039,13 +1024,6 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 		return LRU_REMOVED;
 	}
 
-	/* Recently referenced inodes get one more pass */
-	if (inode->i_state & I_REFERENCED) {
-		inode->i_state &= ~I_REFERENCED;
-		spin_unlock(&inode->i_lock);
-		return LRU_ROTATE;
-	}
-
 	/*
 	 * On highmem systems, mapping_shrinkable() permits dropping
 	 * page cache in order to free up struct inodes: lowmem might
@@ -1995,7 +1973,7 @@ static bool maybe_add_lru(struct inode *inode, bool skip_lru)
 	if (!(sb->s_flags & SB_ACTIVE))
 		return drop;
 
-	__inode_add_lru(inode, true);
+	inode_add_lru(inode);
 	return drop;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2a7e7fc96431..39cde53c1b3b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -715,7 +715,6 @@ is_uncached_acl(struct posix_acl *acl)
  *			address once it is done. The bit is also used to pin
  *			the inode in memory for flusher thread.
  *
- * I_REFERENCED		Marks the inode as recently references on the LRU list.
  *
  * I_WB_SWITCH		Cgroup bdi_writeback switching in progress.  Used to
  *			synchronize competing switching instances and to tell
@@ -764,17 +763,16 @@ enum inode_state_flags_t {
 	I_DIRTY_DATASYNC	= (1U << 4),
 	I_DIRTY_PAGES		= (1U << 5),
 	I_CLEAR			= (1U << 6),
-	I_REFERENCED		= (1U << 7),
-	I_LINKABLE		= (1U << 8),
-	I_DIRTY_TIME		= (1U << 9),
-	I_WB_SWITCH		= (1U << 10),
-	I_OVL_INUSE		= (1U << 11),
-	I_CREATING		= (1U << 12),
-	I_DONTCACHE		= (1U << 13),
-	I_SYNC_QUEUED		= (1U << 14),
-	I_PINNING_NETFS_WB	= (1U << 15),
-	I_LRU			= (1U << 16),
-	I_CACHED_LRU		= (1U << 17)
+	I_LINKABLE		= (1U << 7),
+	I_DIRTY_TIME		= (1U << 8),
+	I_WB_SWITCH		= (1U << 9),
+	I_OVL_INUSE		= (1U << 10),
+	I_CREATING		= (1U << 11),
+	I_DONTCACHE		= (1U << 12),
+	I_SYNC_QUEUED		= (1U << 13),
+	I_PINNING_NETFS_WB	= (1U << 14),
+	I_LRU			= (1U << 15),
+	I_CACHED_LRU		= (1U << 16)
 };
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 58ee61f3d91d..b419b8060dda 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -18,7 +18,6 @@
 		{I_CLEAR,		"I_CLEAR"},		\
 		{I_SYNC,		"I_SYNC"},		\
 		{I_DIRTY_TIME,		"I_DIRTY_TIME"},	\
-		{I_REFERENCED,		"I_REFERENCED"},	\
 		{I_LINKABLE,		"I_LINKABLE"},		\
 		{I_WB_SWITCH,		"I_WB_SWITCH"},		\
 		{I_OVL_INUSE,		"I_OVL_INUSE"},		\
-- 
2.49.0


