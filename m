Return-Path: <linux-btrfs+bounces-16202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A617B30629
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670B51D20F28
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD74036CC87;
	Thu, 21 Aug 2025 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="3NLXyK0H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C869A350D41
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807621; cv=none; b=CV0Xu+n3z03mEnitKbhu8qinkO/yyW2nfJjDi1HAuPLmhNBHRLcAz4YNBg2bWNXd+3meF8jl4flQAgxCQLXp2uxTj92WehaNoomC9xsDG4f/t/qNYSQ/6L7XLb6b5UM5TOsMCUZkc/BMk+7HbiL1yF5gKLimYD73bVKSD5a7FiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807621; c=relaxed/simple;
	bh=DNs/TQNxWbDoZNMHMrgStYIsY8w3J4G2A2bPU67Gm8g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Alb9Qa/s3DXogtBtKJAQSSHWy5V3/BSg18VeNKc0XAnCI60PE6BvEWMONDh0aY50r5HUTHUANkdr9nsI9W69TR3yJmSX8aagWuqV/ZXW+mih4Ikg5leRftkT2MrSpfyH+ebKwU6VuvDUEE7MoTPKVXilsM3kkojnZ+jZfiOxjYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=3NLXyK0H; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e94e3c3621fso1439669276.0
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807617; x=1756412417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJtEKoNF9dskDWzZWtIeIVazPwYY+yFnFA15zXPxXm8=;
        b=3NLXyK0Hq7K7Xwb35em1fKK0/NIasNdoAasVFINs9VkpEjPFbYMXEe3FHhhrW8WAq5
         H/Acep5yoiydyITVPHy2Y2LF4v8yTlKLWqs9rSmn3AZju5ibdtaXiO65X6cxXZtevm2l
         k7IsdpNBzmu0DvPBH7+pYwyYikFaJErrRYooPjEHe2265H+GBkouLTNnbRDNrWbrb83t
         XZ0DAn8ZzuzfHMBhU44IMj3fhUZYyCckUWtPd/S3CLn7xR38U6SXBBdCJQBEzOXwNp3x
         GJrTW2TERerfIJ/DgGwX+PH9/CsiOAZm5piqclRhmYwbRe/vcPVnYBBc4rvTyNIiA6Mi
         SiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807617; x=1756412417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJtEKoNF9dskDWzZWtIeIVazPwYY+yFnFA15zXPxXm8=;
        b=hCWvuaxn/V3INFbLi5SvoX88dU5nYJ8q3Rpg0ydZG0b9OnAJGx2JJ7UUn5Inp9PXtC
         bKKAaDNyDMAr9T7C17yKKKBx8jAzh3T+gqKo36jnv7IBLZsPQguFjL8E+nbmlXyUF+sq
         GdxknxazanMHMZ52H3/HrtOduMFcQN6SDdCdF7SzriNYVV4W3z1KmwUFztWLM2a6XHd3
         0cPAVvlXCBY1Vme94dgl+UnTH6ix4oUcmysBjgxytCgzTCve75KJRsiG/xxxzfmA6oH5
         cyvxLb4P14nroMxdjq5Oo8Hjady1Lm68OdyXo3RW8E8OM2bhtyBCe4XryENa1/aNsYCh
         JmhA==
X-Forwarded-Encrypted: i=1; AJvYcCXpoQnkqolBLsYpcDWO/SPT3I/aDnvlPom19aF9SNTW9ozjnN1YUUZw0lT8B3z0IpX6Ko6YnA+8z4VZ5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWVa2nAwxsFI08kBz6eQQCvz3/d/DCd0w1DbVyncb/Ly7RRxD0
	n8Hk18n9KkIHPvxXc7cl5AfnZ+npjHOrmu32IxHO42eBvoNmtsNqdmgUIQwkbgtFU3AiYKDXglf
	XmboXBaIFgjZ4
X-Gm-Gg: ASbGncskCRtch21oE7XvYz09xu+waqtF3nbYnCFy78C/ZrVQeomf8pE+6KmAWRZ/GJ/
	rxnYiu4BOGRW5vnYl1TSZjdTlLp5RgR3M/Z2RYk2oTKK8ebXm9QclWx6cHMvun1NHGV25E71/iE
	z8dUoZ5Ndh23NQmYTwmweKh8g9a6ZoJ9ssbxi+wBguN5Nb06BwQJNcdBoEclnGaSqBKD+lJH4P8
	BeZWwppBtWzIifgpmxaupgCKUPuIO/oKLW1L2d0/gvNCGb7fqQX780kv1tZzRlI8xECrneujMXb
	dXDVfzSOdAXcWlm1JUtPk1bH5VHvCwdo9GaqhtCJLN0jaMxUMtJlo5UQmWhmuKoeBRZNseS+ck+
	chqw0s2JF6J60IyELJaff2NJbbfrP0qcfhbcRMJk4pyAL8NnneUvsmvlolthTJT6eARTVSi1JTf
	RoQtDj
X-Google-Smtp-Source: AGHT+IEGnHWDf8yEIkP/y4xLOXnB+qyW4bNlEA/MgMrDBawziV+qfA30EUGQvOnBiEpnJXh38D+Gww==
X-Received: by 2002:a05:6902:c0d:b0:e8f:caae:d581 with SMTP id 3f1490d57ef6-e951c2e0348mr1021208276.13.1755807617210;
        Thu, 21 Aug 2025 13:20:17 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e951bb562acsm225609276.9.2025.08.21.13.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:16 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 01/50] fs: add an i_obj_count refcount to the inode
Date: Thu, 21 Aug 2025 16:18:12 -0400
Message-ID: <b7ae58e099d05601fe16d310e06eea3085c23c70.1755806649.git.josef@toxicpanda.com>
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

Currently the inode's lifetime is controlled by it's main refcount,
i_count.  We overload the eviction of the inode (the final unlink) with
the deletion of the in-memory object, which leads to some hilarity when
we iput() in unfortunate places.

In order to make this less of a footgun, we want to separate the notion
of "is this inode in use by a user" and "is this inode object currently
in use", since deleting an inode is a much heavier operation that
deleting the object and cleaning up its memory.

To that end, introduce ->i_obj_count to the inode. This will be used to
control the lifetime of the inode object itself. We will continue to use
the ->i_count refcount as normal to reduce the churn of adding a new
refcount to inode. Subsequent patches will expand the usage of
->i_obj_count for internal uses, and then I will separate out the
tear down operations of the inode, and then finally adjust the refount
rules for ->i_count to be more consistent with all other refcounts.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c         | 20 ++++++++++++++++++++
 include/linux/fs.h |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index cc0f717a140d..454770393fef 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -235,6 +235,7 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
 	inode->i_flags = 0;
 	inode->i_state = 0;
 	atomic64_set(&inode->i_sequence, 0);
+	refcount_set(&inode->i_obj_count, 1);
 	atomic_set(&inode->i_count, 1);
 	inode->i_op = &empty_iops;
 	inode->i_fop = &no_open_fops;
@@ -831,6 +832,11 @@ static void evict(struct inode *inode)
 	inode_wake_up_bit(inode, __I_NEW);
 	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
 
+	/*
+	 * refcount_dec_and_test must be used here to avoid the underflow
+	 * warning.
+	 */
+	WARN_ON(!refcount_dec_and_test(&inode->i_obj_count));
 	destroy_inode(inode);
 }
 
@@ -1925,6 +1931,20 @@ void iput(struct inode *inode)
 }
 EXPORT_SYMBOL(iput);
 
+/**
+ *	iobj_put	- put a object reference on an inode
+ *	@inode: inode to put
+ *
+ *	Puts a object reference on an inode.
+ */
+void iobj_put(struct inode *inode)
+{
+	if (!inode)
+		return;
+	refcount_dec(&inode->i_obj_count);
+}
+EXPORT_SYMBOL(iobj_put);
+
 #ifdef CONFIG_BLOCK
 /**
  *	bmap	- find a block number in a file
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a346422f5066..9a1ce67eed33 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -755,6 +755,7 @@ struct inode {
 #if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
 	atomic_t		i_readcount; /* struct files open RO */
 #endif
+	refcount_t		i_obj_count;
 	union {
 		const struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
 		void (*free_inode)(struct inode *);
@@ -2804,6 +2805,7 @@ extern int current_umask(void);
 
 extern void ihold(struct inode * inode);
 extern void iput(struct inode *);
+extern void iobj_put(struct inode *inode);
 int inode_update_timestamps(struct inode *inode, int flags);
 int generic_update_time(struct inode *, int);
 
@@ -3359,6 +3361,11 @@ static inline bool is_zero_ino(ino_t ino)
 	return (u32)ino == 0;
 }
 
+static inline void iobj_get(struct inode *inode)
+{
+	refcount_inc(&inode->i_obj_count);
+}
+
 /*
  * inode->i_lock must be held
  */
-- 
2.49.0


