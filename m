Return-Path: <linux-btrfs+bounces-6944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E01CB944409
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 08:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FA06B25B8A
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 06:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C01158528;
	Thu,  1 Aug 2024 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="R6VeuOMO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C8r5zmEO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AE41917F0
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492792; cv=none; b=ZBepOZ7tlWTs1DKB/87aSJFPsVpK4PfOrHRNfWmjqUOn4/bwI17MsA3xPEqZRuTQ7xpP+2Zb5z0BCMcwY953RySO36Hs5YI3f1yZwy0Y1ZfoXXOEYfij+gLDhaHd/iVExRcnWklONDXpWYy2C71gHnBJSiJggMZH45SqbCg85n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492792; c=relaxed/simple;
	bh=jCkyxY+3zt9fqhMIZJKzuJ8Y30x6j443ZKqQiS5zRkM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3D0jmUSgbkGjduw2z7+XwR+kFDFnF9H0Q3Nq4cfCZTOmtGFp0oaIh3r18ABJKDAC0nBrZ2n8ryK+3XpEE9YGtAcnTw3oOJl3EAuVYnfAUl+PPg0m3sCGY2Gq1S/0ItX1K3DWUFHcPoxrw9AOIgP422Mi5YQ+UU4OKtoQEBXo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=R6VeuOMO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C8r5zmEO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A48E01F8CD
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 06:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722492789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eah/21p0rbBYFdSOT0GLsxkLQs0cs+cd65xHoE/CQ4Q=;
	b=R6VeuOMOcFQjxwMB0amQ9XDUB1XdomIpxILcp5uQQ1g4UkPomwYFfNbCvhtzGFAgEj0gyh
	tEq25ZNFcL8fGU5SxnwiVkg3EMnizduQDsNXVfpc8T7wf7sb0zdM99oueJal1ndkaD36Fy
	nNeb+hOHuU7sOxoXZ8KWi8P73XFRZ2U=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=C8r5zmEO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722492788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eah/21p0rbBYFdSOT0GLsxkLQs0cs+cd65xHoE/CQ4Q=;
	b=C8r5zmEObKTZdTLJx8ScrdZAjPzLIGrJW6TbFhpjWukMfN6ySmofi0vfvhN1J1SIuuuEI5
	bf17Q3LvXU4wCtv+AyEfp3dHulXGEBdYKNcN/zjjkd50WPqD6G5uwIr6MIzxfCq1Vv/kyA
	ZzCgbvLIC9AULhkaUNEW0Jh6PQj9NOI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C807B13946
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 06:13:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qAdJIHMnq2ZkaQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 01 Aug 2024 06:13:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/5] btrfs-progs: rootdir: warn about hard links
Date: Thu,  1 Aug 2024 15:42:38 +0930
Message-ID: <f12f7dfb97b7cfbe5e6cfc7e929d674e1444cfec.1722492491.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722492491.git.wqu@suse.com>
References: <cover.1722492491.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A48E01F8CD
X-Spam-Score: -2.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim]

The recent rework changes how we detect hard links.

[OLD BEHAVIOR]
We trusted st_nlink and st_ino, reuse them without extra sanity
checks.

That behavior has problems handling cross mount-point or hard links out
of the rootdir cases.

[NEW BEHAVIOR]
The new refactored code will treat every inode, no matter if it's a
hardlink, as a new inode.

This means we will break the hard link detection, and every hard link
will be created as a different inode.

For the most common use case, like populating a rootfs, it's toally
fine.

[EXTRA WARNING]
But for cases where the user have extra hard links inside the rootdir,
output a warning just to inform the end user.

This will not cause any content difference, just breaking the hard links
into new inodes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/rootdir.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 3db32982550b..05787dc3f46c 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -419,6 +419,21 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 	u64 ino;
 	int ret;
 
+	/*
+	 * Hard link need extra detection code, not supported for now, but
+	 * it's not to break anything but splitting the hard links into
+	 * new inodes.
+	 * And we do not even know if the hard links are inside the rootdir.
+	 *
+	 * So here we only need to do extra warning.
+	 *
+	 * On most filesystems st_nlink of a directory is the number of
+	 * subdirs, including "." and "..", so skip directory inodes.
+	 */
+	if (unlikely(!S_ISDIR(st->st_mode) && st->st_nlink > 1))
+		warning("'%s' has extra hard links, they will be converted into new inodes.",
+			full_path);
+
 	/* The rootdir itself. */
 	if (unlikely(ftwbuf->level == 0)) {
 		u64 root_ino = btrfs_root_dirid(&root->root_item);
-- 
2.45.2


