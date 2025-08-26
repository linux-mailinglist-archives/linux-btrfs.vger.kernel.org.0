Return-Path: <linux-btrfs+bounces-16381-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 472A8B36E23
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB3A7B3963
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FAE35AAD4;
	Tue, 26 Aug 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XJ9/DEcN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB135691F
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222873; cv=none; b=fJFy34FpqymDdeTsiML24SBwe7uXJXUV3+MP/V0Q6IE49ENpp0JcYI0+fpwmGvGsrkVFbQMkAFHGQKOWm3BYDhNaRO4mzwMlOHXl8fuEMMKDrm6+vog0UMEVA+J00IMG9ffCsyeqUk825zTtHMJXUk3xTiLSHhKRV0YuxPnsB+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222873; c=relaxed/simple;
	bh=FA4pnJGDj2WWMNOvHLCse6jtjaoFkVIeDGC7hvLCkWU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1YIs7XVC8F4I5RMxl2T22uf8JZF2cGZ8j4fajwum5HyzIEhJDRwxro9ogzqjbsXSv2jqDTTg5FVqvKjX2WmGKYASwZBlnILGdrLiYigDQIZ42L3tevOtsX1OZpcq5Srkqzswj8eRNjKi/7P3+emRPbipzGC2uUV2BEB+6Ct3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XJ9/DEcN; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71e6f84b77eso46752257b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222869; x=1756827669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLdcB47dkfNQdTeXRI/sI229k/Gfes/tUPt2j0scFsc=;
        b=XJ9/DEcNUEHQwOFIq/SM/WNqWBK1LldbFQf18UvrTfLDRHTqSMHqgM36WJQPU8qJij
         iUXTpLTeSwsLrYIAhL8OokEqeiWQfrHaysZ0gzCJanqZlmmLJJrLaRn3tVo+HSf77pOd
         Xy8PawTbcPp9L0G/T26aimhlIctgT6qQxRsvoDBpiXzHIERLO+JBC9nzskGSa5tMOK+3
         uenri5AcfE1dEdRnn90FJLLVNNiUeVI129Urpu2zKwJYssYG/pX5xJiZARmq8oR/QazE
         BA9zTBzeGakH6L7cOKnqMHvhUa4pTqbDig67KQZmnIMTTVaNW9zEuYA8Gnu5NTfwI2oo
         tGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222869; x=1756827669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLdcB47dkfNQdTeXRI/sI229k/Gfes/tUPt2j0scFsc=;
        b=mRP1RXyKWNKf2MVmIQyP08bS2IP12BZHQyqJ0lI8Pf1DGKAvCIJ1ZBL1WUeQh6u2J0
         8CW8Upe+SsDTUi8vIrAwLHXkGlBDcOE3ebZRa3w1vcp+2+uTAr2tofB5WOJMfMFsSoGv
         Jfv03kU51JN6haJ+6hwpUrV/jrVKPlb8TMaRj0MLXQ+Y2pfIJzZTxigrqC5xbngH0Opl
         Rot3cqDv8Zmpx/e2rZiWL+WLXyAR1PdYfCxsZhsKgIj1YVYta8FihT0fXRPr6THxTW67
         wxCSuqKJqWXwyzVMj7+pC/A5HE7wMdiYjBbq21cdISXABbzdpV3J363KWsYlsK+BvcYY
         WOYA==
X-Forwarded-Encrypted: i=1; AJvYcCUS+Uzgq8A7l27qyY6971ogZvGaLdYwl23Bb/C4ZrW+6OaaMZfuK3P32mc5E/jN3feHxHpHHj1Ns6q8vg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8+1hvF4q74YJH4TD6cP2918Df7B+Y30SSW+DJCkzUFQ/ldwYa
	RbnFuu8Z30McXI7AlME58fauCFS9asEJAAuY8Jq1HztmtSRHFdfy79WQiXin/6Dr6HM=
X-Gm-Gg: ASbGncvNUkjkewPDi6VoD/F1T4aZtkFU8PL2b3NdxDLQynDzWknPXOMZK1vWOo/yWw6
	wtJy+VsK5ylkFZWL9CLFnrCtH3LyxDF8A8JtJjEtieFodX7E2/2nv4t5ppMgOqOwx3BWLIGyO9j
	IkRJSx/iASqjbvFquKe98i53YMcZGWc8b3etjggBnsowq3J0OX+JBeZfaBIdDSfbT7/PKM2zLj1
	u+ADkZpOngot69t3vdq0kX+gmvOGu0rDz7n+xv8gu3/unzY43WUBQoLZ2qy/Xotyko6Tr8fn/BP
	g+I/20tP7nDUtMpXb1F95bEfk18outPrvJtTJmae2cAtRtVINGmjRVADQEJsjtlYMSuNtUga+Sc
	Nx/kA9nWpHcUVMhNsdGWXd8k8wGdEEPNnGV4mziAHqYe5lg0dcfl9BoIGuQM=
X-Google-Smtp-Source: AGHT+IG7MZng2S3yfXz9RiSpcnEbolik5Fao0RvRUykpH7SsGkbQuT3EZKEQ9Q+IU3F6hJQRrb8W9g==
X-Received: by 2002:a05:690c:64c8:b0:720:c20:dc2e with SMTP id 00721157ae682-7200c20e228mr88571567b3.31.1756222868952;
        Tue, 26 Aug 2025 08:41:08 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff188b0f1sm25302847b3.42.2025.08.26.08.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:08 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 14/54] fs: add an I_LRU flag to the inode
Date: Tue, 26 Aug 2025 11:39:14 -0400
Message-ID: <be838041953ae727e4ae9629dc1fa55c3dd09f2a.1756222465.git.josef@toxicpanda.com>
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

We will be adding another list for the inode to keep track of inodes
that are being cached for other reasons. This is necessary to make sure
we know which list the inode is on, and to differentiate it from the
private dispose lists.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c                       | 7 +++++++
 include/linux/fs.h               | 8 +++++++-
 include/trace/events/writeback.h | 3 ++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index ddaf282f7c25..15ff3a0ff7ee 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -545,6 +545,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 
 	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
 		iobj_get(inode);
+		inode->i_state |= I_LRU;
 		this_cpu_inc(nr_unused);
 	} else if (rotate) {
 		inode->i_state |= I_REFERENCED;
@@ -574,7 +575,11 @@ void inode_add_lru(struct inode *inode)
 
 static void inode_lru_list_del(struct inode *inode)
 {
+	if (!(inode->i_state & I_LRU))
+		return;
+
 	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
+		inode->i_state &= ~I_LRU;
 		iobj_put(inode);
 		this_cpu_dec(nr_unused);
 	}
@@ -955,6 +960,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	    (inode->i_state & ~I_REFERENCED) ||
 	    !mapping_shrinkable(&inode->i_data)) {
 		list_lru_isolate(lru, &inode->i_lru);
+		inode->i_state &= ~I_LRU;
 		spin_unlock(&inode->i_lock);
 		this_cpu_dec(nr_unused);
 		return LRU_REMOVED;
@@ -991,6 +997,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 
 	WARN_ON(inode->i_state & I_NEW);
 	inode->i_state |= I_FREEING;
+	inode->i_state &= ~I_LRU;
 	list_lru_isolate_move(lru, &inode->i_lru, freeable);
 	spin_unlock(&inode->i_lock);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 023ad47685be..e12c09b9fcaf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -744,6 +744,11 @@ is_uncached_acl(struct posix_acl *acl)
  * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
  *			i_count.
  *
+ * I_LRU		Inode is on the LRU list and has an associated LRU
+ *			reference count. Used to distinguish inodes where
+ *			->i_lru is on the LRU and those that are using ->i_lru
+ *			for some other means.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  *
  * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
@@ -774,7 +779,8 @@ enum inode_state_flags_t {
 	I_CREATING		= (1U << 14),
 	I_DONTCACHE		= (1U << 15),
 	I_SYNC_QUEUED		= (1U << 16),
-	I_PINNING_NETFS_WB	= (1U << 17)
+	I_PINNING_NETFS_WB	= (1U << 17),
+	I_LRU			= (1U << 18)
 };
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 1e23919c0da9..486f85aca84d 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -28,7 +28,8 @@
 		{I_DONTCACHE,		"I_DONTCACHE"},		\
 		{I_SYNC_QUEUED,		"I_SYNC_QUEUED"},	\
 		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\
-		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"}	\
+		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"},	\
+		{I_LRU,			"I_LRU"}		\
 	)
 
 /* enums need to be exported to user space */
-- 
2.49.0


