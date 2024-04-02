Return-Path: <linux-btrfs+bounces-3838-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFF6895F5A
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 00:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE1C1C230FE
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 22:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31D915ECE2;
	Tue,  2 Apr 2024 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mVC3Aj5y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295C215ECD2
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095695; cv=none; b=IkSXqDXCiHMwsjYPBgy1VH0RSiLt82gQVL1A+KqBfpYYVhf3N1xk0kGaCuUpkYR1gGN7/cCLWcIxt2d/HHyy+k6Ik/doeHZgAPT1SuItUjafnLCRvX0/K9uaPb8zHP/z+BSO+6Y1YwiVmGh0n9Zj8DRLjhIXTPCz/g2eiq0pF/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095695; c=relaxed/simple;
	bh=DYnZRZur7rmeAGSOy90AIzOHK83dJ862UxZlk7swF+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sV2NQE1G3IMjWWdMKi9IjJKP+jFl8wJsi2KDc3Zq+CrgZ2A+OUPW9XHqe0gT0dD8or789lAr9l9HTAl2yAOBKPOlZ8JvFrwfFGApCBZQFczXh2Np9lwWVyrkG/VTCWMeWjA8gs/RFDNNmJ1L3iSAXlvxBg7hTpPp9Yc8QvQrtGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mVC3Aj5y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B1385C3FC
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712095692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M33JOYoHXp3rxcdR5EghkqmQpwg8VHsxga6OrR63qQg=;
	b=mVC3Aj5ySNK36uA6zreVDNtURtNvVsxwB/ABZBd0KhHnW35pWejNqwXJHrwpNUF56EJhwz
	hhXd/uUL2eaU8u1bXrbYoihoZy3/+YuO3onm3Oyd4XpwR2wE+hVlVxvd05GPvVWisGby7e
	zblCExsk540u1asfp6j1f4rtjDv4STw=
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 488EC13A90
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2Jb2OsqBDGYIdwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 02 Apr 2024 22:08:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/5] btrfs-progs: tune: properly open zoned devices for RW
Date: Wed,  3 Apr 2024 08:37:38 +1030
Message-ID: <d9fb28d562242fe4d1b347c64c687b425f3304c1.1712095635.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712095635.git.wqu@suse.com>
References: <cover.1712095635.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -1.80
X-Spam-Level: 
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
index 0fbf37dd4800..cfb5b5d6e323 100644
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
@@ -194,6 +195,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	u64 super_flags = 0;
 	int quota = 0;
 	int fd = -1;
+	int oflags = O_RDWR;
 
 	btrfs_config_init();
 
@@ -337,7 +339,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
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


