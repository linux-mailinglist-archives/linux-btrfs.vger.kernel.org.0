Return-Path: <linux-btrfs+bounces-16419-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C5DB36EDA
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C2C189CA64
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B6A37C0FA;
	Tue, 26 Aug 2025 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="I/6Jgln0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A912374280
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222928; cv=none; b=DtbSIUrChj2HTz4i9fvkALfPJE+/L49xYXyLXzG70vtufNKr+qerCGSg7+hXKPwTWDAf1oX/zsoeq3IALL4Ts1U2bPkz/ghgeLkdOOL1ZgIa4BZRlyskMG4atzKnjRxw/9MYOFN+i/fzofUItAJesoRCQI5NSTyTcvyhIFtSQD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222928; c=relaxed/simple;
	bh=Ffmr4JTkv27v+liTs0kkXy3C+53ffmU7vF0ZQ1aEiXc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTPDexKmVjLcXwF/NiGQYAbj26t0Dc4s05iZorBDaiDHWDRa9xZiqcf4fVYNi94W1Z4OgpcKTsSH7ImRpaCJgqIhKpx+3qMV7K/MdlZRHQSF03L1l0PZcphvIzfHhZd5bf3qjApt1zP3WH5ZzHVDk3SlIZmC9CBwTgo+EOuNgks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=I/6Jgln0; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d60504bf8so47175097b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222924; x=1756827724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HLyRObaU9jZ8RwNXAUwhurh4zdCe0Fhft2bwk7GfT4=;
        b=I/6Jgln0cG2bh2mGc11G74JBjW1t+n5PRa3TUMlPCvvHcColS3Cqe9j+xrQwu6L8Ci
         CEBVQBKHU1HB1lYcMI3FkxR1E/qvL3S5qIFOdVA9FFhfjQT2gxl7df0m8NUp0lb42qSv
         sykWm3mZd7oCAUx3+RC0Tdt9SJK/IRcyyEUOddIVXW4OrTkTeVpDQcSdIyAuwuQgTmOs
         iWH8kA6AMF/RDz5avn0Wi4uw1xmGC6Lyy4zr46M/1984rSm5eoODhPwMQP84p6p1gKgy
         JFbybNr2QtBbp2Oxzfj92lMpGzfoIBEZFwF+BpclIGK4dkQ94IvyUG0zbbcFMToxbjeq
         FtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222924; x=1756827724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HLyRObaU9jZ8RwNXAUwhurh4zdCe0Fhft2bwk7GfT4=;
        b=t2eQlhuh8T2JataJLdgBLN5kFWcDRhRRuzeaLTUdEzD7MtHNCcQHoMDoOl8apxig+Q
         M9Fpoe2FcAg2z92oQktbW9qJehQA6P9gRzaJHXcSzGAcDlLJOMhd+OUOdrHXCSuWFMro
         FtXCPYvOVsiWTtx0ueNdou2rlrRigPV13WU9yXlP02whkmWrP4NRIJVhjBNYSX6bd8Zt
         v8chYLB68xkitiKqDdryK0/KxjjcXbLTfALOD9x+/i/Cr0dS+2rWb3k4x2sHU/mlb5Ip
         2F8K8dLhp+QldG8D3wvfoR5ooV7PUeGUwi53RrtQObMLwEAGidpDt2zLAcNvOozK3d9E
         SCNw==
X-Forwarded-Encrypted: i=1; AJvYcCXWnGVJL+Up0U2GX/4ciy8DBgVFAZeqx97q6Of0Oe0ehVHpdT03+tZLxKRFv2/KqdDPQZkO4wOY1vB4xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXIPKtf3eXs1McfIrMLPnlvhXMi8OxFQAmoV+N+5myBEdnGsWI
	r7RKwGScBNyOCaERDlTeuvH5jdcZvVuhV8UHTwqhg8UEL5airWTrGAAYQP7TBnSLrIfs5eCW8bN
	feayh
X-Gm-Gg: ASbGncuhLSRR9QrIDyj0s10FD1vSbfVilqSz2TFV8GO+MJsC83aQ7dYKGk7itTxU/g1
	F08urt9PHHJ8lZyjuM0xv3bc1NowCV/QFvB0j4uidTBBT3nKpIfoEmZVXQl47LDPZusNz5sIjnb
	s2ny+tg6lvCkquJJjditqaTUz99V7bhIu43fUJFMxkz0ZLZS+fveB21uY/RIlvIQhmPkLM7kkIF
	Ma+ChimnSxsMqzOY0h4RQIYcAS9QWRNfDmszoprgBqN55ePj8EhUSlFamWR2NZyVA5znOwJ4O4S
	M1t2ms6lsCBkuYcYrUuPugzItMZHjQlAO+BqOwzY/+ISlrCOXd0EQ4cYZv+A+QV1IPf9pVvkz1u
	dWqlPrcmJHHXFykQG43guGvLX2i27SYvOpQ9L35ZkQ+7dfONyfktPe0LGCwNDmhCqsKZ79Q==
X-Google-Smtp-Source: AGHT+IFMLfYa3CL7W+FWw++FhCAdSL3BTb4bfQUlcZeFOcHyrUecb66hD5/zCWc9JbB+KBZRXjgThw==
X-Received: by 2002:a05:690c:9a82:b0:712:cc11:af8 with SMTP id 00721157ae682-71fdc3d602emr194004547b3.27.1756222923514;
        Tue, 26 Aug 2025 08:42:03 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5fbb1a885absm419091d50.4.2025.08.26.08.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:42:02 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 51/54] fs: remove I_FREEING|I_WILL_FREE
Date: Tue, 26 Aug 2025 11:39:51 -0400
Message-ID: <8b9be971cd6ea2e19584ae3852169f01e7855ca7.1756222465.git.josef@toxicpanda.com>
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

Now that we're using the i_count reference count as the ultimate arbiter
of whether or not an inode is life we can remove the I_FREEING and
I_WILL_FREE flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c                       |  8 ++---
 include/linux/fs.h               | 56 +++++++++++++-------------------
 include/trace/events/writeback.h |  2 --
 3 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index da38c9fbb9a7..8f61761ca021 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -862,7 +862,7 @@ void clear_inode(struct inode *inode)
 	BUG_ON(inode->i_state & I_CLEAR);
 	BUG_ON(!list_empty(&inode->i_wb_list));
 	/* don't need i_lock here, no concurrent mods to i_state */
-	inode->i_state = I_FREEING | I_CLEAR;
+	inode->i_state = I_CLEAR;
 }
 EXPORT_SYMBOL(clear_inode);
 
@@ -926,7 +926,7 @@ static void evict(struct inode *inode)
 	 * This also means we don't need any fences for the call below.
 	 */
 	inode_wake_up_bit(inode, __I_NEW);
-	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
+	BUG_ON(inode->i_state != I_CLEAR);
 }
 
 static void iput_evict(struct inode *inode);
@@ -1959,7 +1959,6 @@ static void iput_final(struct inode *inode, bool drop)
 
 	state = inode->i_state;
 	if (!drop) {
-		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
 		spin_unlock(&inode->i_lock);
 
 		write_inode_now(inode, 1);
@@ -1967,10 +1966,7 @@ static void iput_final(struct inode *inode, bool drop)
 		spin_lock(&inode->i_lock);
 		state = inode->i_state;
 		WARN_ON(state & I_NEW);
-		state &= ~I_WILL_FREE;
 	}
-
-	WRITE_ONCE(inode->i_state, state | I_FREEING);
 	spin_unlock(&inode->i_lock);
 
 	evict(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 531a6d0afa75..2a7e7fc96431 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -672,8 +672,8 @@ is_uncached_acl(struct posix_acl *acl)
  * I_DIRTY_DATASYNC, I_DIRTY_PAGES, and I_DIRTY_TIME.
  *
  * Four bits define the lifetime of an inode.  Initially, inodes are I_NEW,
- * until that flag is cleared.  I_WILL_FREE, I_FREEING and I_CLEAR are set at
- * various stages of removing an inode.
+ * until that flag is cleared.  I_CLEAR is set when the inode is clean and ready
+ * to be freed.
  *
  * Two bits are used for locking and completion notification, I_NEW and I_SYNC.
  *
@@ -697,24 +697,18 @@ is_uncached_acl(struct posix_acl *acl)
  *			New inodes set I_NEW.  If two processes both create
  *			the same inode, one of them will release its inode and
  *			wait for I_NEW to be released before returning.
- *			Inodes in I_WILL_FREE, I_FREEING or I_CLEAR state can
- *			also cause waiting on I_NEW, without I_NEW actually
- *			being set.  find_inode() uses this to prevent returning
+ *			Inodes with an i_count == 0 or I_CLEAR state can also
+ *			cause waiting on I_NEW, without I_NEW actually being
+ *			set.  find_inode() uses this to prevent returning
  *			nearly-dead inodes.
- * I_WILL_FREE		Must be set when calling write_inode_now() if i_count
- *			is zero.  I_FREEING must be set when I_WILL_FREE is
- *			cleared.
- * I_FREEING		Set when inode is about to be freed but still has dirty
- *			pages or buffers attached or the inode itself is still
- *			dirty.
  * I_CLEAR		Added by clear_inode().  In this state the inode is
- *			clean and can be destroyed.  Inode keeps I_FREEING.
+ *			clean and can be destroyed.
  *
- *			Inodes that are I_WILL_FREE, I_FREEING or I_CLEAR are
- *			prohibited for many purposes.  iget() must wait for
- *			the inode to be completely released, then create it
- *			anew.  Other functions will just ignore such inodes,
- *			if appropriate.  I_NEW is used for waiting.
+ *			Inodes that have i_count == 0 or I_CLEAR are prohibited
+ *			for many purposes.  iget() must wait for the inode to be
+ *			completely released, then create it anew.  Other
+ *			functions will just ignore such inodes, if appropriate.
+ *			I_NEW is used for waiting.
  *
  * I_SYNC		Writeback of inode is running. The bit is set during
  *			data writeback, and cleared with a wakeup on the bit
@@ -752,8 +746,6 @@ is_uncached_acl(struct posix_acl *acl)
  * I_CACHED_LRU		Inode is cached because it is dirty or isn't shrinkable,
  *			and thus is on the s_cached_inode_lru list.
  *
- * Q: What is the difference between I_WILL_FREE and I_FREEING?
- *
  * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
  * upon. There's one free address left.
  */
@@ -771,20 +763,18 @@ enum inode_state_flags_t {
 	I_DIRTY_SYNC		= (1U << 3),
 	I_DIRTY_DATASYNC	= (1U << 4),
 	I_DIRTY_PAGES		= (1U << 5),
-	I_WILL_FREE		= (1U << 6),
-	I_FREEING		= (1U << 7),
-	I_CLEAR			= (1U << 8),
-	I_REFERENCED		= (1U << 9),
-	I_LINKABLE		= (1U << 10),
-	I_DIRTY_TIME		= (1U << 11),
-	I_WB_SWITCH		= (1U << 12),
-	I_OVL_INUSE		= (1U << 13),
-	I_CREATING		= (1U << 14),
-	I_DONTCACHE		= (1U << 15),
-	I_SYNC_QUEUED		= (1U << 16),
-	I_PINNING_NETFS_WB	= (1U << 17),
-	I_LRU			= (1U << 18),
-	I_CACHED_LRU		= (1U << 19)
+	I_CLEAR			= (1U << 6),
+	I_REFERENCED		= (1U << 7),
+	I_LINKABLE		= (1U << 8),
+	I_DIRTY_TIME		= (1U << 9),
+	I_WB_SWITCH		= (1U << 10),
+	I_OVL_INUSE		= (1U << 11),
+	I_CREATING		= (1U << 12),
+	I_DONTCACHE		= (1U << 13),
+	I_SYNC_QUEUED		= (1U << 14),
+	I_PINNING_NETFS_WB	= (1U << 15),
+	I_LRU			= (1U << 16),
+	I_CACHED_LRU		= (1U << 17)
 };
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 6949329c744a..58ee61f3d91d 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -15,8 +15,6 @@
 		{I_DIRTY_DATASYNC,	"I_DIRTY_DATASYNC"},	\
 		{I_DIRTY_PAGES,		"I_DIRTY_PAGES"},	\
 		{I_NEW,			"I_NEW"},		\
-		{I_WILL_FREE,		"I_WILL_FREE"},		\
-		{I_FREEING,		"I_FREEING"},		\
 		{I_CLEAR,		"I_CLEAR"},		\
 		{I_SYNC,		"I_SYNC"},		\
 		{I_DIRTY_TIME,		"I_DIRTY_TIME"},	\
-- 
2.49.0


