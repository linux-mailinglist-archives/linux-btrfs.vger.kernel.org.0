Return-Path: <linux-btrfs+bounces-13454-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF13A9E5A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 03:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371473B76D7
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 01:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF24D3596F;
	Mon, 28 Apr 2025 01:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eCuVIz4s";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eCuVIz4s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7D679CF
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 01:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745802990; cv=none; b=paR49arM5Z/Blze6Dgjl5XgE4J/dzCsH1A90rJ1BAz1Zc4RmeKp2+6sI0BSiJtrH/IJdYOITn0GWxTNzwm+L97IqMIrNJTi+XrvR+cinEUkVcGEQJqTCT7asCjQEA+wgs4Ijrgvj4Ssuei7qTvGAZYapCe8vnrg/mtCLiaNm8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745802990; c=relaxed/simple;
	bh=xeJpWWGP0wIMqaQDz3vSObgqkBug32X71s65MX4WeWc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dB6LScQ022fIjamID6A+qKCDjMV/YYVljsG6bpaS6XwiG6fnhm+zMhL4kn3+SCbt38wIfAllpQGpMl6tkXj2o9T48/nhtez8Ush8IHVS0/Sl4JpBzXMSE0HEUia6UlyAGaQuq7e1W+MNp+mhM5ZQblOenPT5m5YBiPET2APq3+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eCuVIz4s; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eCuVIz4s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 29361211C7
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 01:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745802977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ga0Xwdn+gXoLCRe8fyhXR1N2niCtNhKu7ya+xMlJ/w=;
	b=eCuVIz4sQySa/8I9m8Uwwcz+gCaWTnro8YaMJDQKpiV82zZvFtNI1EgdNhUrD2w/e3Q1lX
	F9D+O2QNgXCPgcW0SFtIEwaWXIoquBL59iQResojoCxzVEtoIKLLSwz0lJVCOmiGH8Tpyq
	Q39VHHuEg7VGUCHL4MXJmndhVyigp+0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=eCuVIz4s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745802977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ga0Xwdn+gXoLCRe8fyhXR1N2niCtNhKu7ya+xMlJ/w=;
	b=eCuVIz4sQySa/8I9m8Uwwcz+gCaWTnro8YaMJDQKpiV82zZvFtNI1EgdNhUrD2w/e3Q1lX
	F9D+O2QNgXCPgcW0SFtIEwaWXIoquBL59iQResojoCxzVEtoIKLLSwz0lJVCOmiGH8Tpyq
	Q39VHHuEg7VGUCHL4MXJmndhVyigp+0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A7DD13A25
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 01:16:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2J7rC+DWDmhADgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 01:16:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: get rid of btrfs_read_dev_super()
Date: Mon, 28 Apr 2025 10:45:52 +0930
Message-ID: <96a246471a1071b6cee00be2bcdbc7bc0e97787b.1745802753.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745802753.git.wqu@suse.com>
References: <cover.1745802753.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 29361211C7
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The function is introduced by commit a512bbf855ff ("Btrfs: superblock
duplication") at the beginning of btrfs.

It leaves a comment saying we need a special mount option to read all
super blocks, but it's never implemented.

This means btrfs_read_dev_super() is always reading the first super
block, making all the code finding the latest super block unnecessary.

Just remove that function and replace all call sites with
btrfs_read_disk_super(bdev, 0, false).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 30 +-----------------------------
 fs/btrfs/disk-io.h |  1 -
 fs/btrfs/volumes.c |  2 +-
 3 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index df68796288a2..a69d33abf44c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3307,7 +3307,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	/*
 	 * Read super block and check the signature bytes only
 	 */
-	disk_super = btrfs_read_dev_super(fs_devices->latest_dev->bdev);
+	disk_super = btrfs_read_disk_super(fs_devices->latest_dev->bdev, 0, false);
 	if (IS_ERR(disk_super)) {
 		ret = PTR_ERR(disk_super);
 		goto fail_alloc;
@@ -3702,34 +3702,6 @@ static void btrfs_end_super_write(struct bio *bio)
 	bio_put(bio);
 }
 
-struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
-{
-	struct btrfs_super_block *super, *latest = NULL;
-	int i;
-	u64 transid = 0;
-
-	/* we would like to check all the supers, but that would make
-	 * a btrfs mount succeed after a mkfs from a different FS.
-	 * So, we need to add a special mount option to scan for
-	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
-	 */
-	for (i = 0; i < 1; i++) {
-		super = btrfs_read_disk_super(bdev, i, false);
-		if (IS_ERR(super))
-			continue;
-
-		if (!latest || btrfs_super_generation(super) > transid) {
-			if (latest)
-				btrfs_release_disk_super(super);
-
-			latest = super;
-			transid = btrfs_super_generation(super);
-		}
-	}
-
-	return super;
-}
-
 /*
  * Write superblock @sb to the @device. Do not wait for completion, all the
  * folios we use for writing are locked.
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 0ac9baf1215f..864a55a96226 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -58,7 +58,6 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 			 const struct btrfs_super_block *sb, int mirror_num);
 int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount);
 int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
-struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 					const struct btrfs_key *key);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e751bc32e867..57617020ee40 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -493,7 +493,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 		}
 	}
 	invalidate_bdev(bdev);
-	*disk_super = btrfs_read_dev_super(bdev);
+	*disk_super = btrfs_read_disk_super(bdev, 0, false);
 	if (IS_ERR(*disk_super)) {
 		ret = PTR_ERR(*disk_super);
 		fput(*bdev_file);
-- 
2.49.0


