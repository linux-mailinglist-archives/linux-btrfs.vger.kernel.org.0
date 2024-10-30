Return-Path: <linux-btrfs+bounces-9224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 690AB9B58DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 01:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9B31F23DBA
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 00:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981C847F69;
	Wed, 30 Oct 2024 00:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dJuWNM74";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dJuWNM74"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282F31A60
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 00:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730249789; cv=none; b=sRC3Eq9sEkymn2YIvqwNXAWM8sMCxEh+XomlI+3nV4lroRJWmI2XOz7vR/T6skHgzvKps3xa/YpAKhnI2cjcW9MmWbEspMQlYu7USBYxoiHC/TxQjOZO37+LfD8wjYjXTcRF/AV8PlPrkEPakGhB00m/Kb1deaiCq7jehEa9o2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730249789; c=relaxed/simple;
	bh=eqcU6OGwBvcxAJe2nBm34z55IKBZn83NKIXIPgia6FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvSD1FnmhW2kKxvRmN6LDB+mU9haFL0rvxyEFYOmhxYyH26kqq6YYVj5QLuwVzQ8fhNhT6p2JPEG9dLKLKdzeZA2j9D52UdeZeTqyj03QSBN4Put0kS1xG17F2lfKRpYQKfJ0MLrFBWBDWwJnXE5Jj6w2E2GYs7ibkaa5QRasPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dJuWNM74; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dJuWNM74; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C46A21DD0;
	Wed, 30 Oct 2024 00:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730249785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ou8wb0I++Dlb4mEV2+sf47RPAVY6jwzdTNmVh9V6rLU=;
	b=dJuWNM74F0piQA8RK18pJ8gSWVeomB24EpKA8JveIukD+k0gVKL8Lfp8IG1Xkx7ZOd2J48
	JpoRqQvgkkyGh7ZsD20qUyaMrak49j3sZwsX08Vs4FosBaaG2YsjBXx/Yj03+ru6rgajcs
	sakK9vnquZnV1yfSHMC3jkwbHlOneEY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730249785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ou8wb0I++Dlb4mEV2+sf47RPAVY6jwzdTNmVh9V6rLU=;
	b=dJuWNM74F0piQA8RK18pJ8gSWVeomB24EpKA8JveIukD+k0gVKL8Lfp8IG1Xkx7ZOd2J48
	JpoRqQvgkkyGh7ZsD20qUyaMrak49j3sZwsX08Vs4FosBaaG2YsjBXx/Yj03+ru6rgajcs
	sakK9vnquZnV1yfSHMC3jkwbHlOneEY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E2CC136A5;
	Wed, 30 Oct 2024 00:56:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sJJxNzeEIWdJJAAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 30 Oct 2024 00:56:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Enno Gotthold <egotthold@suse.com>,
	Fabian Vogt <fvogt@suse.com>
Subject: [PATCH 2/2] btrfs: fix mount failure due to remount races
Date: Wed, 30 Oct 2024 11:25:48 +1030
Message-ID: <a682e48c161eece38f8d803103068fed5959537d.1730249396.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730249396.git.wqu@suse.com>
References: <cover.1730249396.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.com:url];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
The following reproducer can cause btrfs mount to fail:

  dev="/dev/test/scratch1"
  mnt1="/mnt/test"
  mnt2="/mnt/scratch"

  mkfs.btrfs -f $dev
  mount $dev $mnt1
  btrfs subvolume create $mnt1/subvol1
  btrfs subvolume create $mnt1/subvol2
  umount $mnt1

  mount $dev $mnt1 -o subvol=subvol1
  while mount -o remount,ro $mnt1; do mount -o remount,rw $mnt1; done &
  bg=$!

  while mount $dev $mnt2 -o subvol=subvol2; do umount $mnt2; done

  kill $bg
  wait
  umount -R $mnt1
  umount -R $mnt2

The script will fail with the following error:

 mount: /mnt/scratch: /dev/mapper/test-scratch1 already mounted on /mnt/test.
       dmesg(1) may have more information after failed mount system call.
 umount: /mnt/test: target is busy.
 umount: /mnt/scratch/: not mounted

And there is no kernel error message.

[CAUSE]
During the btrfs mount, to support mounting different subvolumes with
different RO/RW flags, we have a small hack during the mount:

  Retry with matching RO flags if the initial mount fail with -EBUSY.

The problem is, during that retry we do not hold any super block lock
(s_umount), this meanings there can be a remount process changing the RO
flags of the original fs super block.

If so, we can have an EBUSY error during retry.
And this time we treat any failure as an error, without any retry and
cause the above EBUSY mount failure.

[FIX]
The current retry behavior is racy because we do not have a super block
thus no way to hold s_umount to prevent the race with remount.

Solve the root problem by allowing fc->sb_flags to mismatch from the
sb->s_flags at btrfs_get_tree_super().

Then at the re-entry point btrfs_get_tree_subvol(), manually check the
fc->s_flags against sb->s_flags, if it's a RO->RW mismatch, then
reconfigure with s_umount lock hold.

Fixes: f044b318675f ("btrfs: handle the ro->rw transition for mounting different subvolumes")
Reported-by: Enno Gotthold <egotthold@suse.com>
Reported-by: Fabian Vogt <fvogt@suse.com>
[ Special thanks for the reproducer and early analyze pointing to btrfs ]
Link: https://bugzilla.suse.com/show_bug.cgi?id=1231836
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Instead of brute force retry-until-success-or-failure, allow sb flags
  mismatch during btrfs_get_tree_super()
  So that we can utilize sb->s_umount to prevent race.

- Rebased after patch "btrfs: fix per-subvolume RO/RW flags with new mount API"
  Fortunately or unfortunately my distro is already utilizing the new
  mount API and I found the per-subvolume RO/RW support is broken again.

  Unlike the original expectation, the new API is not the new hope, but
  allows the old bug to strike back.

  So this patch can only be applied after that fix.
---
 fs/btrfs/super.c | 66 ++++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d77cce8d633e..d137ce2b5038 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1885,18 +1885,21 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 
 	if (sb->s_root) {
 		btrfs_close_devices(fs_devices);
-		if ((fc->sb_flags ^ sb->s_flags) & SB_RDONLY)
-			ret = -EBUSY;
+		/*
+		 * At this stage we may have RO flag mismatch between
+		 * fc->sb_flags and sb->s_flags.
+		 * Caller should detect such mismatch and reconfigure
+		 * with sb->s_umount rwsem hold if needed.
+		 */
 	} else {
 		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
 		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
 		ret = btrfs_fill_super(sb, fs_devices);
-	}
-
-	if (ret) {
-		deactivate_locked_super(sb);
-		return ret;
+		if (ret) {
+			deactivate_locked_super(sb);
+			return ret;
+		}
 	}
 
 	btrfs_clear_oneshot_options(fs_info);
@@ -1983,39 +1986,18 @@ static int btrfs_get_tree_super(struct fs_context *fc)
  *
  * So here we always needs the remount hack to support per-subvolume RO/RW flags.
  */
-static struct vfsmount *btrfs_reconfigure_for_mount(struct fs_context *fc)
+static int btrfs_reconfigure_for_mount(struct fs_context *fc, struct vfsmount *mnt)
 {
-	struct vfsmount *mnt;
-	int ret;
-	const bool ro2rw = !(fc->sb_flags & SB_RDONLY);
+	int ret = 0;
 
-	/*
-	 * We got an EBUSY because our SB_RDONLY flag didn't match the existing
-	 * super block, so invert our setting here and retry the mount so we
-	 * can get our vfsmount.
-	 */
-	if (ro2rw)
-		fc->sb_flags |= SB_RDONLY;
-	else
-		fc->sb_flags &= ~SB_RDONLY;
+	if (fc->sb_flags & SB_RDONLY)
+		return ret;
 
-	mnt = fc_mount(fc);
-	if (IS_ERR(mnt))
-		return mnt;
-
-	if (!ro2rw)
-		return mnt;
-
-	/* We need to convert to rw, call reconfigure. */
-	fc->sb_flags &= ~SB_RDONLY;
 	down_write(&mnt->mnt_sb->s_umount);
-	ret = btrfs_reconfigure(fc);
+	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
+		ret = btrfs_reconfigure(fc);
 	up_write(&mnt->mnt_sb->s_umount);
-	if (ret) {
-		mntput(mnt);
-		return ERR_PTR(ret);
-	}
-	return mnt;
+	return ret;
 }
 
 static int btrfs_get_tree_subvol(struct fs_context *fc)
@@ -2025,6 +2007,7 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
 	struct fs_context *dup_fc;
 	struct dentry *dentry;
 	struct vfsmount *mnt;
+	int ret = 0;
 
 	/*
 	 * Setup a dummy root and fs_info for test/set super.  This is because
@@ -2067,11 +2050,16 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
 	fc->security = NULL;
 
 	mnt = fc_mount(dup_fc);
-	if (PTR_ERR_OR_ZERO(mnt) == -EBUSY)
-		mnt = btrfs_reconfigure_for_mount(dup_fc);
-	put_fs_context(dup_fc);
-	if (IS_ERR(mnt))
+	if (IS_ERR(mnt)) {
+		put_fs_context(dup_fc);
 		return PTR_ERR(mnt);
+	}
+	ret = btrfs_reconfigure_for_mount(dup_fc, mnt);
+	put_fs_context(dup_fc);
+	if (ret) {
+		mntput(mnt);
+		return ret;
+	}
 
 	/*
 	 * This free's ->subvol_name, because if it isn't set we have to
-- 
2.47.0


