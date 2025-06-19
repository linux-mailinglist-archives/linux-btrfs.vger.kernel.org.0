Return-Path: <linux-btrfs+bounces-14791-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6584AE0AAD
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 17:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DCF3B2843
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 15:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512F52376E1;
	Thu, 19 Jun 2025 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="HXcEiL4F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE6230D2B;
	Thu, 19 Jun 2025 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347567; cv=none; b=UfWJ7Wj4N+r1sSRd/m4S74PGdh4Uv6BxrLArVlUq4tzcU6+X3XTW/7Oo76VW00z0bMpDVSByjsKpYDTr/qCTyo8EXtrR7Svw4GrUYXvAeTf+AKoXbjIw21cnGkMmlHunDFLoXiuyTvAGk75ZbVruPr/dd+ASdfhosvVvvm7ugpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347567; c=relaxed/simple;
	bh=qxV9hp1a8ZF4P94sZw7lHvgtIx4B1viS8RZ4vq5iY2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arWG2wr3h/QhItaTBWOpTJDBsKetREHaYtkyKShxkfbTUkQUvwXR6GGJp2JrkvRIQsWc4zgFqf2EvubMtJewJnAz4nYGv+8JhxEuMsC9oDiMiTFASgDwHJoIN/XyilcHKMWjuetwff8lEiuNzkHGum53/x04d9+J8jZ3oVI7Wvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=HXcEiL4F; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bNPsv15r1z9sWN;
	Thu, 19 Jun 2025 17:39:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1750347555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iyxqy2niN0GbXPgxFJlByz5vrpTZKnSAb9ajOCJIkdw=;
	b=HXcEiL4FDW8dnX6q1b6ZQ0zM3Ksl5Sr6zLInpzC/FwwltGMxF/rrM91qbG9rfIh66j+rhK
	s87hZu7qNtUl7Hv+hRQOP2rJbDM+DM/ser3nOkAqiGG5DroCugG3lZ/UA88dNI2Nflr4SP
	l7TVi+38nZg5SWGl5TBqaZjYfNzBftirqVceVgF2KTaa1YEetl+i64a59dUE1dSF743RLX
	UNSbSc/O1sFfwOUgFrgyzF2FwrcrszbLCI7bNLMFLkJP3GqIaHD3LWa83cqPDQTcHiS6Yi
	u+4b1OC5a4Oj/Cf5GXh3xHvUrQmnyyXIKk8Kt1hlFgVMmMHBSFIvECIMNovhjg==
From: Brahmajit Das <listout@listout.xyz>
To: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	kees@kernel.org,
	ailiop@suse.com
Subject: [PATCH v2] btrfs: replace deprecated strcpy with strscpy
Date: Thu, 19 Jun 2025 21:09:04 +0530
Message-ID: <20250619153904.25889-1-listout@listout.xyz>
In-Reply-To: <20250619140623.3139-1-listout@listout.xyz>
References: <20250619140623.3139-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strcpy is deprecated due to lack of bounds checking. This patch replaces
strcpy with strscpy, the recommended alternative for null terminated
strings, to follow best practices.

There are instances where strscpy cannot be used such as where both the
source and destination are character pointers. In that instance we can
use sysfs_emit or a memcpy.

Update in v2: using sysfs_emit instead of scnprintf

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88

Suggested-by: Anthony Iliopoulos <ailiop@suse.com>
Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 fs/btrfs/ioctl.c   | 2 +-
 fs/btrfs/send.c    | 2 +-
 fs/btrfs/volumes.c | 2 +-
 fs/btrfs/xattr.c   | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

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
index 3e0edbcf73e1..9f652932895c 100644
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
@@ -516,8 +517,7 @@ static int btrfs_initxattrs(struct inode *inode,
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


