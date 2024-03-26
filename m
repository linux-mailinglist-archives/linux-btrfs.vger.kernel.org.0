Return-Path: <linux-btrfs+bounces-3582-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46E888B5FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 01:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899141F3BC43
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 00:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C51E7F6;
	Tue, 26 Mar 2024 00:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iLu9ybSD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iLu9ybSD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB2023B1
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711412599; cv=none; b=TQN4b0WBLakdXSVI/Z1QCSLJt60iBN4zkTxNiY/Epe7uSEr/8J4BKr7pfaTTsDUHVvicPhC4X6+J4vWt7MBj0/8Rh2J8wGLD51e0BXS7X/X8E6jyzVewbCWNVxXoUzGhKCbIkIboXr0cp+FQ9VGX5DLn7NdHtAAyfPGhnaC7V3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711412599; c=relaxed/simple;
	bh=TLoZzAJgFtclxdz+bVm4I/xypgDh65k1pLqIZ4rMdiM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXXJbFWn4cSJyngn0Yosl/gUbLsjCibWmN1R4nyfbwbKA0k6DFhLzhNJqPCuGTHuvcBYLvNYQ0Bb35ViOKzJjbb7V4FEwKwWJ4JdtOJ4zIfXyKUx55Eb5n30AP79s60XyYY22oJfQXt9M5LCh5Ekh++zqSPI32fXIj23CuIZQlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iLu9ybSD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iLu9ybSD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B0B8822590
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711412595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yn0I+VPJzKyPgs88lBqX0OtuZejhij5xS0iXaj0iFkA=;
	b=iLu9ybSDQQsRURjuggMODp65YHOdGjULVIMrC/23/63Kt6uJLkMSU/F+yolV3HKY9xqrnv
	Wwsm/lIf5e4nWceUNzgwmJzgdFZ7j2S2lTvg+WqPGO+MXotDz1QmZiYYui4FVM/nodAHZC
	9I0qCDAEeDHwhxQMMeev1+1VuK1S5CQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711412595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yn0I+VPJzKyPgs88lBqX0OtuZejhij5xS0iXaj0iFkA=;
	b=iLu9ybSDQQsRURjuggMODp65YHOdGjULVIMrC/23/63Kt6uJLkMSU/F+yolV3HKY9xqrnv
	Wwsm/lIf5e4nWceUNzgwmJzgdFZ7j2S2lTvg+WqPGO+MXotDz1QmZiYYui4FVM/nodAHZC
	9I0qCDAEeDHwhxQMMeev1+1VuK1S5CQ=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EDE7713586
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UITWJ3IVAmbOJAAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs-progs: tune: properly open zoned devices for RW
Date: Tue, 26 Mar 2024 10:52:44 +1030
Message-ID: <e9b5485ae6d5c11196e0fb0c611f256dbf606171.1711412540.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711412540.git.wqu@suse.com>
References: <cover.1711412540.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 3.82
X-Spamd-Result: default: False [3.82 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.08)[-0.400];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[14.73%]
X-Spam-Level: ***
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

[BUG]
There is a report that, for zoned devices btrfstune is unable to convert
it to block group tree.

 # btrfstune /dev/nullb0 --convert-to-block-group-tree
 Error reading 1342193664, -1
 Error reading 1342193664, -1
 ERROR: cannot read chunk root
 ERROR: open ctree failed

[CAUSE]
For read-write opened zoned devices, all the read/write has to be
aligned to its sector size.

However btrfs stores its metadata by extent_buffer::data[], which has
all the structures before it, thus never aligned to zoned device sector
size.

Normally we would require btrfs_pread() and btrfs_pwrite() to do the
extra alignment, but during open_ctree(), we are not aware if a device
is zoned or not.

Thus we rely on if the fd is opened with O_DIRECT flag, if the fd has
O_DIRECT, then we would temporarily set fs_info->zoned for chunk tree
read.

Unforunately not all open_ctree_fd() callers have the flags set
properly, and btrfstune is one of the missing call site.

This makes all the read not properly aligned and cause read failure.

[FIX]
Just manually check if the target device is a zoned one, and set
O_DIRECT accordingly.

Issue: #765
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tune/main.c b/tune/main.c
index aa9f39d987ec..397549837c18 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -29,6 +29,7 @@
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/free-space-tree.h"
+#include "kernel-shared/zoned.h"
 #include "common/utils.h"
 #include "common/open-utils.h"
 #include "common/device-scan.h"
@@ -193,6 +194,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	u64 super_flags = 0;
 	int quota = 0;
 	int fd = -1;
+	int oflags = O_RDWR;
 
 	btrfs_config_init();
 
@@ -336,7 +338,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		}
 	}
 
-	fd = open(device, O_RDWR);
+	if (zoned_model(device) == ZONED_HOST_MANAGED)
+		oflags |= O_DIRECT;
+	fd = open(device, oflags);
 	if (fd < 0) {
 		error("mount check: cannot open %s: %m", device);
 		ret = 1;
-- 
2.44.0


