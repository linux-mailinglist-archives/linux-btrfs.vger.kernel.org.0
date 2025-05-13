Return-Path: <linux-btrfs+bounces-13980-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1837AB5FD0
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 01:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1418646C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 23:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6717E204F9B;
	Tue, 13 May 2025 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JWzKJ5Qd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JWzKJ5Qd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8411F4C6C
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747178085; cv=none; b=ai1kF95J5NDIZtd2ruOzLUE1mersdOXE05oWIahItOgP1VVizP7nJrZKX3x5tfC2mjXcTKigmxHtZv6MlzMuAtQyUG00gytBXLM/dLt7iE7HTJnWtYBOuu0UA1Rgdm2scpOs572KDM3KfrctdFl2DVZE70qMULsiExB5j9l3GRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747178085; c=relaxed/simple;
	bh=lt2/cSFlp6ecHpjJdJCHQsLG4Di0dWDZFz+Ho3p/zOk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Dao2czJ9g3xbZzqSqbZ9AAqYH5J9ry1hpKnDtlJMrVNUZIiT54O2ePW6UWEVC33g7B3toyo2GDtvZYTqKPGwuOGAy7B+jdrDFMAv2fmXwB2vDJo0az3iKQWTyBAbhcIZyPPUFtDAAgYM/aBvdiGBeSTSBaAcOL5wkFztjPzNI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JWzKJ5Qd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JWzKJ5Qd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B415211E8
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 23:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747178081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gvm14DjWHiM85Pjit2BT0OwbOuYnV1vFjfkJdW8sBKE=;
	b=JWzKJ5QdueUMRHMd1+YcN8NnS7J2Mk9X1hzwR7Zt78eu0CojL0u6xIEYvmP21QzDj108OC
	RxK2HU3AsBichtKLw/B7/37cnfyLJuecPYQKaKak2jEjvzL7JhblZ3v6TYkAhkh4pA6Lpt
	mURytGpl5QuWDN/mX2jk4mdP3W1buso=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=JWzKJ5Qd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747178081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gvm14DjWHiM85Pjit2BT0OwbOuYnV1vFjfkJdW8sBKE=;
	b=JWzKJ5QdueUMRHMd1+YcN8NnS7J2Mk9X1hzwR7Zt78eu0CojL0u6xIEYvmP21QzDj108OC
	RxK2HU3AsBichtKLw/B7/37cnfyLJuecPYQKaKak2jEjvzL7JhblZ3v6TYkAhkh4pA6Lpt
	mURytGpl5QuWDN/mX2jk4mdP3W1buso=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8878C137E8
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 23:14:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cNDSEmDSI2iABAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 23:14:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: replace: fix an unexpected new line when replace failed
Date: Wed, 14 May 2025 08:44:18 +0930
Message-ID: <76f6e03df7209fd09af92c36a572489e2009abc5.1747178054.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4B415211E8
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action

[BUG]
When a device replace failed, e.g. try to replace a device on a RO
mounted btrfs, the error message is incorrectly broken into two lines:

 [adam@btrfs-vm ~]$ sudo btrfs replace start -fB 1 /dev/test/scratch3  /mnt/btrfs/
 Performing full device TRIM /dev/mapper/test-scratch3 (10.00GiB) ...
 ERROR: ioctl(DEV_REPLACE_START) failed on "/mnt/btrfs/": Read-only file system

 [adam@btrfs-vm ~]$

Note the newline after the "Read-only file system" error message.

[CAUSE]
Inside cmd_replace_start(), if the ioctl failed we need to handle the
error messages different depeneding on start_args.result.

If the result is not BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_RESULT we will
append extra info to the error message.

But the initial error message is using error(), which implies a newline.

This results the above incorrectly splitted error message.

[FIX]
Instead of manually appending an extra reason to the existing error
message, just do different output depending on the start_args.result in
the first place.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/replace.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/cmds/replace.c b/cmds/replace.c
index 5f1222b241da..887c3251a725 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -319,12 +319,11 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	ret = ioctl(fdmnt, BTRFS_IOC_DEV_REPLACE, &start_args);
 	if (do_not_background) {
 		if (ret < 0) {
-			error("ioctl(DEV_REPLACE_START) failed on \"%s\": %m", path);
-			if (start_args.result != BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_RESULT)
-				pr_stderr(LOG_DEFAULT, ", %s\n",
-					replace_dev_result2string(start_args.result));
+			if (start_args.result == BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_RESULT)
+				error("ioctl(DEV_REPLACE_START) failed on \"%s\": %m", path);
 			else
-				pr_stderr(LOG_DEFAULT, "\n");
+				error("ioctl(DEV_REPLACE_START) failed on \"%s\": %m, %s",
+				      path, replace_dev_result2string(start_args.result));
 
 			if (errno == EOPNOTSUPP)
 				warning("device replace of RAID5/6 not supported with this kernel");
-- 
2.49.0


