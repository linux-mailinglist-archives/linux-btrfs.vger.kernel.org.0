Return-Path: <linux-btrfs+bounces-10526-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8559F5E9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 07:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65DD1882A51
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 06:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC871552E4;
	Wed, 18 Dec 2024 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uULn5lnU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uULn5lnU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8299019A
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734503479; cv=none; b=WSxIAFhIcWuTt7I+4sNHldpi/e8l9Ek/6zS+BlGhq9sFbQZHVyzFos21+z4bCmImGBCPAjwHuXMgTsLluClQwZnhNEHAftfaPftsOcwTpq6o9Bj9z+JB2KE2FHroAGGTYettj05u1FyaMkGJL8J4TGpIvp8WM6XbqShxJMzO964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734503479; c=relaxed/simple;
	bh=raJkxDe4mcJrbcCuLY0xsePinX0UhSQAxPD2S2A8fL4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QOLSBBf0xSKaCeO21OgLQyf+V5b4gzEKFKmk15ChikE/EcwfoYrcsaHf0FKczj+Bv/iO+AK9Oi2pVooQ7nZ97GFE9U2MOm2X4G3/Te2YHlWPT+XfRZxmvrmUDuO3PfVNRoZh6vgCD1SxynGitI/B+Ob/vLlj75FqMr8aQyyukGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uULn5lnU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uULn5lnU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 776881F396
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 06:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734503475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZpEaaSqqIAejt2OhcYA32/cfXmhbZGAji1wLTzCQFHk=;
	b=uULn5lnUAK85eOAu/zmzVNjxAR9sK2b5jEpgglNA2Hj3vzzeYgm0MMjDOvPZL1Joq0Pkdr
	pUdVxG7h8qlR0DLNPt57wsprsOudK1hZqGol/rqfkHZuL/lrf+SFM0B6v0/iv1IUIwNdRo
	KXlhAwmL9hSqs+0x4H2y0cBbbMDMVB4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uULn5lnU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734503475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZpEaaSqqIAejt2OhcYA32/cfXmhbZGAji1wLTzCQFHk=;
	b=uULn5lnUAK85eOAu/zmzVNjxAR9sK2b5jEpgglNA2Hj3vzzeYgm0MMjDOvPZL1Joq0Pkdr
	pUdVxG7h8qlR0DLNPt57wsprsOudK1hZqGol/rqfkHZuL/lrf+SFM0B6v0/iv1IUIwNdRo
	KXlhAwmL9hSqs+0x4H2y0cBbbMDMVB4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2F64137CF
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 06:31:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OroEGDJsYmfvEwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 06:31:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: sysfs: fix direct super block member read
Date: Wed, 18 Dec 2024 17:00:56 +1030
Message-ID: <67a25027c7d05f33c71015b60fcfb75d89ac0ab9.1734503454.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 776881F396
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The following sysfs entries are reading super block member directly,
which can have a different endian and cause wrong values:

- sys/fs/btrfs/<uuid>/nodesize
- sys/fs/btrfs/<uuid>/sectorsize
- sys/fs/btrfs/<uuid>/clone_alignment

Thankfully those values (nodesize and sectorsize) are always aligned
inside the btrfs_super_block, so it won't trigger unaligned read errors,
just endian problems.

Fix them by using the native cached members instead.

Fixes: df93589a1737 ("btrfs: export more from FS_INFO to sysfs")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index fdcbf650ac31..7f09b6c9cc2d 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1118,7 +1118,7 @@ static ssize_t btrfs_nodesize_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return sysfs_emit(buf, "%u\n", fs_info->super_copy->nodesize);
+	return sysfs_emit(buf, "%u\n", fs_info->nodesize);
 }
 
 BTRFS_ATTR(, nodesize, btrfs_nodesize_show);
@@ -1128,7 +1128,7 @@ static ssize_t btrfs_sectorsize_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return sysfs_emit(buf, "%u\n", fs_info->super_copy->sectorsize);
+	return sysfs_emit(buf, "%u\n", fs_info->sectorsize);
 }
 
 BTRFS_ATTR(, sectorsize, btrfs_sectorsize_show);
@@ -1180,7 +1180,7 @@ static ssize_t btrfs_clone_alignment_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return sysfs_emit(buf, "%u\n", fs_info->super_copy->sectorsize);
+	return sysfs_emit(buf, "%u\n", fs_info->sectorsize);
 }
 
 BTRFS_ATTR(, clone_alignment, btrfs_clone_alignment_show);
-- 
2.47.1


