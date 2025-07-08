Return-Path: <linux-btrfs+bounces-15322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88297AFCC0C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 15:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E62BB7B4EDF
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 13:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A632E0923;
	Tue,  8 Jul 2025 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hv5c5Hp7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XTKewh3p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF32DEA9A
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981151; cv=none; b=YCEcwmACextQgGmM9QpU1n3XAE8F+PwHqzMk+d02BUGIOzRYQ5kYxWeGnzyFDnE6AOgWA1XtvldS9miHh0LioR3xeO6z2g0qQmb/gayzpdbp8s+9x/5BU7Ar9vYjP2gyz5UsQs0c+TOaB7seL/wCZa1EZ/XNJ5E3yGFc4G3Krvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981151; c=relaxed/simple;
	bh=CPSxH0Fd8jxabt8uZGv5qAEk456hMNRjaFS8sjQYU28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tR7i4JZvzhsC2nKG+Jv0FqT+ueZcENsVDxD3m0/OskeLgQEDdAyStSkOHJgO9jCoNfO6V7qlCcvScbEDAjt1TWecbqWSJXnTej7ojKIUMI7eOz1WnmkkKj0gJwEg+P903QKzn74d1X8ncN8rMM9tF9goVIOLpsi4V22uuSpNPYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hv5c5Hp7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XTKewh3p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D3FC921163;
	Tue,  8 Jul 2025 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751981147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yIIftZXodqLFtd1qMq2PBXFtC/YM76S1GDJGtMTzxI4=;
	b=hv5c5Hp7hbi86FiG4XQQcnGRUpGoNFi/fiot2QH6n4BmX8MwURcIAuJiWX5uegKQrbq5lr
	iGEt6LuF47kDeJrtadO49GozPo75X8AlLEM1n2vq+kse6cq7CwJio0fDogE8eMXkSamL60
	ixnq9g8Q2e24UuMmW4hVCVH5ZMkUXJQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=XTKewh3p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751981146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yIIftZXodqLFtd1qMq2PBXFtC/YM76S1GDJGtMTzxI4=;
	b=XTKewh3ppUy7lJsgzX4vMSx2WPlHc7q7NsrBn9wzB3FbJt6TVbtgRgphzRpYjSz3yKEMM0
	SWZgc2mW6tZlhkoA4qNjdxU928eJVIyI1goeMx+HLGhiaHLmSunrU55gotM2aVkfYHTR2t
	LIB5S5Op7D5Ee7XKvkzWKfWbK/vuwPs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD55513A54;
	Tue,  8 Jul 2025 13:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /gIbMlocbWj+NQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 08 Jul 2025 13:25:46 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: wqu@suse.com,
	David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: scrub: wip, pause on fs freeze
Date: Tue,  8 Jul 2025 15:25:39 +0200
Message-ID: <20250708132540.28285-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,lwn.net:url,suse.com:mid,suse.com:dkim,suse.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D3FC921163
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Implement sb->freeze_super that can instruct our threads to pause
themselves. In case of (read-write) scrub this means to undo
mnt_want_write, implemented as sb_start_write()/sb_end_write().
The freeze_super callback is necessary otherwise the call
sb_want_write() inside the generic implementation hangs.

This works with concurrent scrub running and 'fsfreeze --freeze', not
with process freezing (like with suspend).

References: https://lwn.net/Articles/1018341/

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/fs.h    |  2 ++
 fs/btrfs/scrub.c | 21 +++++++++++++++++++++
 fs/btrfs/super.c | 36 ++++++++++++++++++++++++++++++++----
 3 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 8cc07cc70b12..005828a6ab17 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -137,6 +137,8 @@ enum {
 	BTRFS_FS_QUOTA_OVERRIDE,
 	/* Used to record internally whether fs has been frozen */
 	BTRFS_FS_FROZEN,
+	/* Started freezing, pause your progress. */
+	BTRFS_FS_FREEZING,
 	/*
 	 * Indicate that balance has been set up from the ioctl and is in the
 	 * main phase. The fs_info::balance_ctl is initialized.
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 6776e6ab8d10..9a6bce6ea191 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2250,6 +2250,27 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 			ret = -ECANCELED;
 			break;
 		}
+
+		/* Freezing? */
+		if (test_bit(BTRFS_FS_FREEZING, &fs_info->flags)) {
+			atomic_inc(&fs_info->scrubs_paused);
+			smp_mb();
+			wake_up(&fs_info->scrub_pause_wait);
+
+			if (!sctx->readonly)
+				sb_end_write(fs_info->sb);
+
+			try_to_freeze();
+			wait_on_bit(&fs_info->flags, BTRFS_FS_FREEZING, TASK_UNINTERRUPTIBLE);
+
+			if (!sctx->readonly)
+				sb_start_write(fs_info->sb);
+
+			atomic_dec(&fs_info->scrubs_paused);
+			smp_mb();
+			wake_up(&fs_info->scrub_pause_wait);
+		}
+
 		/* Paused? */
 		if (atomic_read(&fs_info->scrub_pause_req)) {
 			/* Push queued extents */
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index e4ce2754cfde..c049d145db66 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2279,7 +2279,33 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 	return ret;
 }
 
-static int btrfs_freeze(struct super_block *sb)
+static int btrfs_freeze_super(struct super_block *sb, enum freeze_holder who,
+			      const void *freeze_owner)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	int ret;
+
+	set_bit(BTRFS_FS_FREEZING, &fs_info->flags);
+	ret = freeze_super(sb, who, freeze_owner);
+	if (ret < 0)
+		clear_bit(BTRFS_FS_FREEZING, &fs_info->flags);
+	return ret;
+}
+
+static int btrfs_thaw_super(struct super_block *sb, enum freeze_holder who,
+			    const void *freeze_owner)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	int ret;
+
+	ret = thaw_super(sb, who, freeze_owner);
+	clear_bit(BTRFS_FS_FREEZING, &fs_info->flags);
+	smp_mb();
+	wake_up_bit(&fs_info->flags, BTRFS_FS_FREEZING);
+	return ret;
+}
+
+static int btrfs_freeze_fs(struct super_block *sb)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 
@@ -2345,7 +2371,7 @@ static int check_dev_super(struct btrfs_device *dev)
 	return ret;
 }
 
-static int btrfs_unfreeze(struct super_block *sb)
+static int btrfs_unfreeze_fs(struct super_block *sb)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_device *device;
@@ -2426,8 +2452,10 @@ static const struct super_operations btrfs_super_ops = {
 	.destroy_inode	= btrfs_destroy_inode,
 	.free_inode	= btrfs_free_inode,
 	.statfs		= btrfs_statfs,
-	.freeze_fs	= btrfs_freeze,
-	.unfreeze_fs	= btrfs_unfreeze,
+	.freeze_super   = btrfs_freeze_super,
+	.thaw_super     = btrfs_thaw_super,
+	.freeze_fs	= btrfs_freeze_fs,
+	.unfreeze_fs	= btrfs_unfreeze_fs,
 	.nr_cached_objects = btrfs_nr_cached_objects,
 	.free_cached_objects = btrfs_free_cached_objects,
 };
-- 
2.49.0


