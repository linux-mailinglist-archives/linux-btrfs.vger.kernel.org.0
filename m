Return-Path: <linux-btrfs+bounces-14789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3631AAE084E
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 16:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1A63B7640
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B61728B418;
	Thu, 19 Jun 2025 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="iQPG8qTL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E828B26FA58;
	Thu, 19 Jun 2025 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342008; cv=none; b=LSnhSUBwYEgcErXRLg9WohNJHzI5BKT3gIWiCXqQdaD5epqBjSs6pB9La91q0027bSaKahlsLWMmOD6DSHkLs65KonFB2EYktfl5JuNO0bnGXeXWhmr/2ogKw40Keo+gwdr36XDZUCgywRClmpDnn6+cDhg/Nyx0QKiMfCsdUlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342008; c=relaxed/simple;
	bh=NYBkuq0cnX17OM4U0p5kofF8HhaPNGilDGSLVZI+Bz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fe1nBp0cAw3mwvut5CcAIpLVuk75xZ9YTyOp1MTUR3P2wnQF/IJsOUKF3tljdN3zvruNCyzQFh9fKcdqSM/0qtQDzOkdcfkFOKaa6xKvXiNf+9qaxIkj/OBX5ZC56Q8wWQhFHEf1OY1irIalbThSt1LXVhZSVOHUjoKw39ipql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=iQPG8qTL; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bNMq55XVsz9tFm;
	Thu, 19 Jun 2025 16:06:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1750342001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PGfE/9y3eqH7Zr/2zxMvSStMMitvqBr+4f1cr+9I1IM=;
	b=iQPG8qTLKrmvkILdtOt3CNspdU0SD0GDyKlQ1BnXkMRLG6VW3EIIHcadxZg0n1z+nwrAyq
	R4IvC2brbZ5iWgAopHBw1lM3sSkmqy/JMOa292dYp4Vtdo/sc9ZbWxjuO/3Go9ze3EGS7A
	U1sz4UdgszLlEAVHlbk9T3wwZcRNL9soG2XaxRRNBz4rByuaApK8WHuqvQRP1SASzVMjZK
	UY1LJ/B5uK1mJkAeZn+tFe96gnpAJJt26s7Ojsy9JKJrt22zBCAEx8B0BBFY7srZ0mAk5/
	cCn4h3IBEDbjWk/+6xQm7rM9F7xIukfa+ikRRmcheTsWqEhEEF5U8VNi5VR4jQ==
From: Brahmajit Das <listout@listout.xyz>
To: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	kees@kernel.org
Subject: [PATCH] btrfs: replace deprecated strcpy with strscpy
Date: Thu, 19 Jun 2025 19:36:23 +0530
Message-ID: <20250619140623.3139-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bNMq55XVsz9tFm

strcpy is deprecated due to lack of bounds checking. This patch replaces
strcpy with strscpy, the recommended alternative for null terminated
strings, to follow best practices.

There are instances where strscpy cannot be used such as where both the
source and destination are character pointers. In that instance we can
use scnprintf or a memcpy.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 fs/btrfs/ioctl.c   | 2 +-
 fs/btrfs/send.c    | 2 +-
 fs/btrfs/volumes.c | 2 +-
 fs/btrfs/xattr.c   | 5 +++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 913acef3f0a9..203f309f00b1 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4200,7 +4200,7 @@ static int btrfs_ioctl_set_fslabel(struct file *file, void __user *arg)
 	}
 
 	spin_lock(&fs_info->super_lock);
-	strcpy(super_block->label, label);
+	strscpy(super_block->label, label);
 	spin_unlock(&fs_info->super_lock);
 	ret = btrfs_commit_transaction(trans);
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 2891ec4056c6..66ee9e1b1e96 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -758,7 +758,7 @@ static int send_header(struct send_ctx *sctx)
 {
 	struct btrfs_stream_header hdr;
 
-	strcpy(hdr.magic, BTRFS_SEND_STREAM_MAGIC);
+	strscpy(hdr.magic, BTRFS_SEND_STREAM_MAGIC);
 	hdr.version = cpu_to_le32(sctx->proto);
 	return write_buf(sctx->send_filp, &hdr, sizeof(hdr),
 					&sctx->send_off);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 89835071cfea..ec5304f19ac2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -215,7 +215,7 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
 	u32 size_bp = size_buf;
 
 	if (!flags) {
-		strcpy(bp, "NONE");
+		memcpy(bp, "NONE", 4);
 		return;
 	}
 
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 3e0edbcf73e1..6b3485112840 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -12,6 +12,7 @@
 #include <linux/posix_acl_xattr.h>
 #include <linux/iversion.h>
 #include <linux/sched/mm.h>
+#include <linux/string.h>
 #include "ctree.h"
 #include "fs.h"
 #include "messages.h"
@@ -516,8 +517,8 @@ static int btrfs_initxattrs(struct inode *inode,
 			ret = -ENOMEM;
 			break;
 		}
-		strcpy(name, XATTR_SECURITY_PREFIX);
-		strcpy(name + XATTR_SECURITY_PREFIX_LEN, xattr->name);
+		scnprintf(name, sizeof(name), "%s%s", XATTR_SECURITY_PREFIX,
+			  xattr->name);
 
 		if (strcmp(name, XATTR_NAME_CAPS) == 0)
 			clear_bit(BTRFS_INODE_NO_CAP_XATTR, &BTRFS_I(inode)->runtime_flags);
-- 
2.50.0


