Return-Path: <linux-btrfs+bounces-14804-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E46CFAE10CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 03:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B0F4A055B
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 01:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012D9127E18;
	Fri, 20 Jun 2025 01:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="KjMSAlLN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74981732;
	Fri, 20 Jun 2025 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750383846; cv=none; b=YTpzSbWffa6ZISG2Zq2T9LxjG+uOdYAzhnyb5WrtBD6snQY3dp5dkY4L4fTONN/EerD5lJht8JNP9sQomCT8DpLklodHIBTjNPrIsG1WhlCLalTle5yVjj+rcczP/TmPWMu16VQKJS/f5UDDuR2Qjg/7x5zHjt3MdpsmGSIncoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750383846; c=relaxed/simple;
	bh=w5UyrN+SuZwEfjWfesGpMrFPbJHMelfyEA6KKc0vkg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLUMbYJbzdGO2Q2Lme/sFfVX9CnBvYkA8bSl0ZBEnMw7DCD38qbS3R6TdHlUrU/qRrUX/wbwdwHrcwglcUL5XpoSa4ImGqdRm5RtAcycvxaGHIUNZf5KgVC+XUMlY5jsk6jTaWtN2nUZDDjDN2mXcvjfA+fcj1UvIIwec+5aYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=KjMSAlLN; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bNgHf55lTz9t13;
	Fri, 20 Jun 2025 03:43:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1750383838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ReyDaSDnoCABIPvUwxxhMqIgZ0PT/aNafZvKYT1HmI=;
	b=KjMSAlLNnLSRDxHYRa0+aTvTCbuzwYGRdb1KdPTkWt44JuV89ZQ9BJisaq06Y4vpgIkeIX
	ZNpKyG1bcfOwFj8vts5JILpIttJQVSpDYLp86lcU/0JjuQolY9EAU/iFykWQRzj0DrLzmt
	R6g6K2VwMFEGeBjS5Hz//PaJwXi0VjgVjc016E0GVnoRNDDAzqkiriH7wEzUVMhbMmC+EE
	vWq8iH+560zu4/8Yaciosr9pJazC/7qdhkHTihCdFqxUsov1jtlkpK2+yuJRR3mQGQ7yjK
	fH88Wl8go65zDcMKxw57jcEe9HV/qqxIXylnOyz5ClQILxisyo5z90yOzwAKPg==
From: Brahmajit Das <listout@listout.xyz>
To: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	kees@kernel.org,
	ailiop@suse.com,
	Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v3] btrfs: replace deprecated strcpy with strscpy
Date: Fri, 20 Jun 2025 07:13:44 +0530
Message-ID: <20250620014344.27589-1-listout@listout.xyz>
In-Reply-To: <20250619153904.25889-1-listout@listout.xyz>
References: <20250619153904.25889-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bNgHf55lTz9t13

strcpy is deprecated due to lack of bounds checking. This patch replaces
strcpy with strscpy, the recommended alternative for null terminated
strings, to follow best practices.

There are instances where strscpy cannot be used such as where both the
source and destination are character pointers. In that instance we can
use sysfs_emit or a memcpy.

Update in v2: using sysfs_emit instead of scnprintf
Update in v3: Removed string.h in xattr, since we are not using any
fucntions from string.h and fixed length in memcpy in volumes.c

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88

Suggested-by: Anthony Iliopoulos <ailiop@suse.com>
Suggested-by: Mark Harmstone <mark@harmstone.com>
Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 fs/btrfs/ioctl.c   | 2 +-
 fs/btrfs/send.c    | 2 +-
 fs/btrfs/volumes.c | 2 +-
 fs/btrfs/xattr.c   | 3 +--
 4 files changed, 4 insertions(+), 5 deletions(-)

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
index 89835071cfea..86a898bb2fbb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -215,7 +215,7 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
 	u32 size_bp = size_buf;
 
 	if (!flags) {
-		strcpy(bp, "NONE");
+		memcpy(bp, "NONE", 5);
 		return;
 	}
 
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 3e0edbcf73e1..49fd8a49584a 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -516,8 +516,7 @@ static int btrfs_initxattrs(struct inode *inode,
 			ret = -ENOMEM;
 			break;
 		}
-		strcpy(name, XATTR_SECURITY_PREFIX);
-		strcpy(name + XATTR_SECURITY_PREFIX_LEN, xattr->name);
+		sysfs_emit(name, "%s%s", XATTR_SECURITY_PREFIX, xattr->name);
 
 		if (strcmp(name, XATTR_NAME_CAPS) == 0)
 			clear_bit(BTRFS_INODE_NO_CAP_XATTR, &BTRFS_I(inode)->runtime_flags);
-- 
2.50.0


