Return-Path: <linux-btrfs+bounces-3483-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3A3881B9A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 04:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDBE61F21E50
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 03:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E29EB641;
	Thu, 21 Mar 2024 03:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LpH5erQA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LpH5erQA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7EB6FC5
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 03:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710992405; cv=none; b=TuubQgZu6iU41CJkDOZ9FIs6WxGsankiLY6yxqNcQwjgLxfWUvAClbS+VVd1y0kv/eZ4cC1EpcBWHyeSuhK6fI4x0et45WSTf4w8zViFxqJXuL85wUNy862IMnrtn9VUvESpx48LSgjVz24Uu6JybXNMh+C1eKClyc9WmJmABOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710992405; c=relaxed/simple;
	bh=Zk2jWTXFZuyg4TyluJlyuqOBLm5bVtyfRusRMx5VZjc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ULUF6dfnuHUxMYRwn8ak1Y102jCpDpZ1b/LmEUEpXlBnu/qiWthiwDfrXKhz717ClBuR2RT9rmRvjed7l7RTgfXCfCmrf9liuX2s2N4C7e2rccnP5CplKFwSZLNM1gFhlei44i1Ia5L+PC/AXkacOulZz1zKvmwDcVuv3SVKN+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LpH5erQA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LpH5erQA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F1865C7AB
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 03:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710992401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G7NobBe1HgQ4BSRJq+L3PWLVMg/c4Ys+rQ6sY/HFhB0=;
	b=LpH5erQA0KhIdY/+vXWM3+70OMcTtXG2v5nCJbLfBAfWbPNq7TLyA/gDDJWD4i+rmjL90d
	E4sLmkf/4mSvlI1eHks7ZLHbA53F6m43ds0qUYzkbJG+p24HRq94wo1zWrG8RuAT4SM+VL
	xWvQMf3UbPDxJGo0ftxvMqinOUvoT1I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710992401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G7NobBe1HgQ4BSRJq+L3PWLVMg/c4Ys+rQ6sY/HFhB0=;
	b=LpH5erQA0KhIdY/+vXWM3+70OMcTtXG2v5nCJbLfBAfWbPNq7TLyA/gDDJWD4i+rmjL90d
	E4sLmkf/4mSvlI1eHks7ZLHbA53F6m43ds0qUYzkbJG+p24HRq94wo1zWrG8RuAT4SM+VL
	xWvQMf3UbPDxJGo0ftxvMqinOUvoT1I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AE2713432
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 03:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id izLdExCs+2UnIwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 03:40:00 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: reflink: disable cross-subvolume clone/dedupe for simple quota
Date: Thu, 21 Mar 2024 14:09:38 +1030
Message-ID: <74730c411b0fd87484c8d894878c5cd8bac1d434.1710992258.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.61
X-Spamd-Result: default: False [3.61 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.20)[-0.979];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.10)[65.19%]
X-Spam-Flag: NO

Unlike the full qgroup, simple quota no longer makes backref walk to
properly make accurate accounting for each subvolume.

Instead it goes a much faster and much simpler way, anything modified by
the subvolume would be accounted to that subvolume.

Although it brings some small accuracy problem, mostly related to shared
extents between different subvolumes, the reduced overhead is more than
good enough.

Considering there are only 2 ways to share extents between subvolumes:

- Snapshotting
- Cross-subvolume clone/dedupe

And since snapshotting is the core functionality of btrfs, we will never
disable that.

But on the other hand, cross-subvolume snapshotting is not so critical,
and disabling that for simple quota would improve the accuracy of it,
I'd say it's worthy to do that.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/reflink.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
---
[REASON FOR RFC]
I'm not sure how important the cross-subvolume clone functionality is in
real-world.

But considering squota is mostly designed for container usage, in that
case disabling cross-subvolume clone should be completely fine.

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 08d0fb46ceec..906cb6166b67 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -15,6 +15,7 @@
 #include "file-item.h"
 #include "file.h"
 #include "super.h"
+#include "qgroup.h"
 
 #define BTRFS_MAX_DEDUPE_LEN	SZ_16M
 
@@ -350,6 +351,19 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 	u64 last_dest_end = destoff;
 	u64 prev_extent_end = off;
 
+	/*
+	 * If squota is enabled, disable cloning between different subvolumes.
+	 *
+	 * As clone/reflink/dedupe is the only other way to share data between
+	 * different subvolumes other than snapshotting.
+	 * With it disabled, squota can be way more accurate.
+	 */
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE) {
+		if (BTRFS_I(src)->root->root_key.objectid !=
+		    BTRFS_I(inode)->root->root_key.objectid)
+			return -EXDEV;
+	}
+
 	ret = -ENOMEM;
 	buf = kvmalloc(fs_info->nodesize, GFP_KERNEL);
 	if (!buf)
-- 
2.44.0


