Return-Path: <linux-btrfs+bounces-7934-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6EC974E6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 11:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B3C286B1E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 09:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC5414AD0A;
	Wed, 11 Sep 2024 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MxW2vn65";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MxW2vn65"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F45339F
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046465; cv=none; b=A9P7BjwopP/Xxy7/7H8qvGBLN9mKhQl8T1UwozbZ0U99ZoGcVsYwRePmE8XifQ0SrYuokIrVlAxt3Fa3PRtSAeCidcBfeg0wQdXtVfTXlBRe/doxbNBPepi01F41nf/1O48Asb/Pe243m+FuzuWvs03WNPXzUzdOlNPrnEcRI2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046465; c=relaxed/simple;
	bh=vpdon82yKBlm+UIcQzBAEbmFMGCfBLxx7+s6LoaYGY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DhKVjnDHUn6/YV+uGlmVKKmtTV27lGKFUriudyJ10HyQ6VtiaKyoGtVfInR2oh3vqwlk1WRJxjSAmeEjT4vKesFjUWzHGPiU/GVSqi94GW+dXCVnBVeiTAp0qYGyC6gDjkYJzrHYXGo4Oc3sWofVUcFqxFft3t36089tRNx1tJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MxW2vn65; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MxW2vn65; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC6CA1F7E9;
	Wed, 11 Sep 2024 09:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726046459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R0LuxAWBdhOgE8+oPPJmiqUSAiUZ60jXWb9vkJNrfVE=;
	b=MxW2vn653j0FmE3uhgtITZs+XqRcS7/bck75+w7LSf3wrXWj5Q/6JFGx22e+qZGzLJkBVX
	wfGPCyT5Wnu369Fof28EE/q5yKq5BAnqenv1LLVxfWDuK4pI0SL6XgAGfjqnniuL1dh/TQ
	D9rKxMSvjtzBfUjypQU2CYpwT27uIng=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MxW2vn65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726046459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R0LuxAWBdhOgE8+oPPJmiqUSAiUZ60jXWb9vkJNrfVE=;
	b=MxW2vn653j0FmE3uhgtITZs+XqRcS7/bck75+w7LSf3wrXWj5Q/6JFGx22e+qZGzLJkBVX
	wfGPCyT5Wnu369Fof28EE/q5yKq5BAnqenv1LLVxfWDuK4pI0SL6XgAGfjqnniuL1dh/TQ
	D9rKxMSvjtzBfUjypQU2CYpwT27uIng=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA64E132CB;
	Wed, 11 Sep 2024 09:20:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SeOQJvpg4WblbgAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 11 Sep 2024 09:20:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: pandada8 <pandada8@gmail.com>
Subject: [PATCH] btrfs-progs: open the devices exclusively for writes
Date: Wed, 11 Sep 2024 18:50:37 +0930
Message-ID: <5c993f306f3f2f7f05ce71f00b0fcd023009ae32.1726045930.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DC6CA1F7E9
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.com:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

There is an internal report that, during btrfs-convert to block-group
tree, by accident some systemd events triggered the mount of the target
fs.

This leads to double mount (one by kernel and one by the btrfs-progs),
which seems to cause quite some problems.

To avoid such accident, exclusively opens all devices if btrfs-progs is
doing write opeartions.

Reported-by: pandada8 <pandada8@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/rescue.c             | 6 +++---
 common/filesystem-utils.c | 3 ++-
 convert/main.c            | 3 ++-
 image/image-restore.c     | 4 +++-
 mkfs/main.c               | 3 ++-
 tune/main.c               | 2 +-
 6 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/cmds/rescue.c b/cmds/rescue.c
index 6d7d526df145..5bbd47e5c2e3 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -203,7 +203,7 @@ static int cmd_rescue_zero_log(const struct cmd_struct *cmd,
 	}
 
 	root = open_ctree(devname, 0, OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL |
-			  OPEN_CTREE_NO_BLOCK_GROUPS);
+			  OPEN_CTREE_NO_BLOCK_GROUPS | OPEN_CTREE_EXCLUSIVE);
 	if (!root) {
 		error("could not open ctree");
 		return 1;
@@ -258,7 +258,7 @@ static int cmd_rescue_fix_device_size(const struct cmd_struct *cmd,
 	}
 
 	oca.filename = devname;
-	oca.flags = OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL;
+	oca.flags = OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL | OPEN_CTREE_EXCLUSIVE;
 	fs_info = open_ctree_fs_info(&oca);
 	if (!fs_info) {
 		error("could not open btrfs");
@@ -437,7 +437,7 @@ static int cmd_rescue_clear_ino_cache(const struct cmd_struct *cmd,
 		goto out;
 	}
 	oca.filename = devname;
-	oca.flags = OPEN_CTREE_WRITES;
+	oca.flags = OPEN_CTREE_WRITES | OPEN_CTREE_EXCLUSIVE;
 	fs_info = open_ctree_fs_info(&oca);
 	if (!fs_info) {
 		error("could not open btrfs");
diff --git a/common/filesystem-utils.c b/common/filesystem-utils.c
index 7e898a3d193c..05451093a9fd 100644
--- a/common/filesystem-utils.c
+++ b/common/filesystem-utils.c
@@ -94,7 +94,8 @@ static int set_label_unmounted(const char *dev, const char *label)
 	/* Open the super_block at the default location
 	 * and as read-write.
 	 */
-	root = open_ctree(dev, 0, OPEN_CTREE_WRITES);
+	root = open_ctree(dev, 0, OPEN_CTREE_WRITES |
+				  OPEN_CTREE_EXCLUSIVE);
 	if (!root) /* errors are printed by open_ctree() */
 		return -1;
 
diff --git a/convert/main.c b/convert/main.c
index 1af47260cdf6..a227cc6fef84 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1374,7 +1374,8 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 	btrfs_sb_committed = true;
 
 	root = open_ctree_fd(fd, devname, 0,
-			     OPEN_CTREE_WRITES | OPEN_CTREE_TEMPORARY_SUPER);
+			     OPEN_CTREE_WRITES | OPEN_CTREE_TEMPORARY_SUPER |
+			     OPEN_CTREE_EXCLUSIVE);
 	if (!root) {
 		error("unable to open ctree for finalization");
 		goto fail;
diff --git a/image/image-restore.c b/image/image-restore.c
index bed5e78d227d..667b9811233d 100644
--- a/image/image-restore.c
+++ b/image/image-restore.c
@@ -1790,7 +1790,8 @@ int restore_metadump(const char *input, FILE *out, int old_restore,
 
 		oca.filename = target;
 		oca.flags = OPEN_CTREE_WRITES | OPEN_CTREE_RESTORE |
-			    OPEN_CTREE_PARTIAL | OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS;
+			    OPEN_CTREE_PARTIAL | OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS |
+			    OPEN_CTREE_EXCLUSIVE;
 		info = open_ctree_fs_info(&oca);
 		if (!info) {
 			error("open ctree failed");
@@ -1855,6 +1856,7 @@ int restore_metadump(const char *input, FILE *out, int old_restore,
 		root = open_ctree_fd(fileno(out), target, 0,
 					  OPEN_CTREE_PARTIAL |
 					  OPEN_CTREE_WRITES |
+					  OPEN_CTREE_EXCLUSIVE |
 					  OPEN_CTREE_NO_DEVICES |
 					  OPEN_CTREE_ALLOW_TRANSID_MISMATCH |
 					  OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS);
diff --git a/mkfs/main.c b/mkfs/main.c
index 45c25df339ff..06cc2484e612 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1846,7 +1846,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	}
 
 	oca.filename = file;
-	oca.flags = OPEN_CTREE_WRITES | OPEN_CTREE_TEMPORARY_SUPER;
+	oca.flags = OPEN_CTREE_WRITES | OPEN_CTREE_TEMPORARY_SUPER |
+		    OPEN_CTREE_EXCLUSIVE;
 	fs_info = open_ctree_fs_info(&oca);
 	if (!fs_info) {
 		error("open ctree failed");
diff --git a/tune/main.c b/tune/main.c
index b0509cf131e6..d246b970e82e 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -185,7 +185,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 {
 	struct btrfs_root *root;
 	struct btrfs_fs_info *fs_info;
-	unsigned ctree_flags = OPEN_CTREE_WRITES;
+	unsigned ctree_flags = OPEN_CTREE_WRITES | OPEN_CTREE_EXCLUSIVE;
 	int seeding_flag = 0;
 	u64 seeding_value = 0;
 	int random_fsid = 0;
-- 
2.46.0


