Return-Path: <linux-btrfs+bounces-2830-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F49868822
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 05:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DA628445D
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 04:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18E4D131;
	Tue, 27 Feb 2024 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QRnWBCVm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QRnWBCVm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C766C3717F
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 04:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709007106; cv=none; b=G7DFJekZ+JvtL71HUwnHg9Gjo8YTp04zp/gJmXIBs8VuOxD73cpAmcbUDhsoJewQEI6N1qUvyFbpJ4Sc4p0SNMT+BInt1RhmbRidUjptv14EsTCsbqWt51QVoSORrxbOS6tAwwNa+GSceJP5U239UwpYMMTnMAvs08394wNJwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709007106; c=relaxed/simple;
	bh=45XMya2WieG9gdCKQu4xBY3F12mCRAqDjDy9FfVb5ns=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZB58zb44q5AMaXNX2TLh4W+B64i34jZ6kWY5bxXAUkLygFqVlJ4RNpCGc1GoKCQZgph6VtXYm4+TWTATTiFdqCoseRe92neZx2tPXunz8Vc1u7bp5mmaW+z2DXuqBkeJNZac8Ch92lmBeVae6Sx5b6VwAPd9FSVDqq9zdJVbcrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QRnWBCVm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QRnWBCVm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2BEBE1FB8C
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 04:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709007095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WfsZAaOYu8CRDvQMSomPYSvvWreg8iebnytnH7RtNr4=;
	b=QRnWBCVmfr3trY062nq30H9/27cYpf8RfDemuzGbh5jgBm/6178CG27yyNbpiIHHEC1vOG
	4KMbeVx518xef6Ku0wWr4I1axx9xtC9jbZH4nNb2pELaVMqwnbe9Y9FXUJebb037x/CW6l
	L4OSGpEB3afFvycP9CLktHp4QHJ7lY4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709007095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WfsZAaOYu8CRDvQMSomPYSvvWreg8iebnytnH7RtNr4=;
	b=QRnWBCVmfr3trY062nq30H9/27cYpf8RfDemuzGbh5jgBm/6178CG27yyNbpiIHHEC1vOG
	4KMbeVx518xef6Ku0wWr4I1axx9xtC9jbZH4nNb2pELaVMqwnbe9Y9FXUJebb037x/CW6l
	L4OSGpEB3afFvycP9CLktHp4QHJ7lY4=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 67CFB13479
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 04:11:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UfAfCPZg3WU3eAAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 04:11:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: subvolume: output the prompt line only when the ioctl succeeded
Date: Tue, 27 Feb 2024 14:41:16 +1030
Message-ID: <7d1ce9fe71dac086bb0037b517e2d932bb2a5b04.1709007014.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

[BUG]
With the latest kernel patch to reject invalid qgroupids in
btrfs_qgroup_inherit structure, "btrfs subvolume create" or "btrfs
subvolume snapshot" can lead to the following output:

 # mkfs.btrfs -O quota -f $dev
 # mount $dev $mnt
 # btrfs subvolume create -i 2/0 $mnt/subv1
 Create subvolume '/mnt/btrfs/subv1'
 ERROR: cannot create subvolume: No such file or directory

The "btrfs subvolume" command output the first line, seemingly to
indicate a successful subvolume creation, then followed by an error
message.

This can be a little confusing on whether if the subvolume is created or
not.

[FIX]
Fix the output by only outputting the regular line if the ioctl
succeeded.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/subvolume.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 00c5eacfa694..1549adaca642 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -229,7 +229,6 @@ static int create_one_subvolume(const char *dst, struct btrfs_qgroup_inherit *in
 		goto out;
 	}
 
-	pr_verbose(LOG_DEFAULT, "Create subvolume '%s/%s'\n", dstdir, newname);
 	if (inherit) {
 		struct btrfs_ioctl_vol_args_v2	args;
 
@@ -253,6 +252,7 @@ static int create_one_subvolume(const char *dst, struct btrfs_qgroup_inherit *in
 		error("cannot create subvolume: %m");
 		goto out;
 	}
+	pr_verbose(LOG_DEFAULT, "Create subvolume '%s/%s'\n", dstdir, newname);
 
 out:
 	close(fddst);
@@ -754,16 +754,8 @@ static int cmd_subvolume_snapshot(const struct cmd_struct *cmd, int argc, char *
 	if (fd < 0)
 		goto out;
 
-	if (readonly) {
+	if (readonly)
 		args.flags |= BTRFS_SUBVOL_RDONLY;
-		pr_verbose(LOG_DEFAULT,
-			   "Create a readonly snapshot of '%s' in '%s/%s'\n",
-			   subvol, dstdir, newname);
-	} else {
-		pr_verbose(LOG_DEFAULT,
-			   "Create a snapshot of '%s' in '%s/%s'\n",
-			   subvol, dstdir, newname);
-	}
 
 	args.fd = fd;
 	if (inherit) {
@@ -784,6 +776,15 @@ static int cmd_subvolume_snapshot(const struct cmd_struct *cmd, int argc, char *
 
 	retval = 0;	/* success */
 
+	if (readonly)
+		pr_verbose(LOG_DEFAULT,
+			   "Create a readonly snapshot of '%s' in '%s/%s'\n",
+			   subvol, dstdir, newname);
+	else
+		pr_verbose(LOG_DEFAULT,
+			   "Create a snapshot of '%s' in '%s/%s'\n",
+			   subvol, dstdir, newname);
+
 out:
 	close(fddst);
 	close(fd);
-- 
2.43.2


