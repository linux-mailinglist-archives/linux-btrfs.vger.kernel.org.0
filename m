Return-Path: <linux-btrfs+bounces-9053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4479A9772
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 06:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAEB61C21405
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 04:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F9B823C3;
	Tue, 22 Oct 2024 04:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K/VNbTgy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K/VNbTgy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241DA7406D
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 04:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729570118; cv=none; b=jk+rMh8cxXLuFgwKWmOqsDoR07a/eh68wByoMFH9xbAmvKJiKdRrRuj2dE4RNRpkUPvp+qGZNQ9ZeHME0UEP9FvnK21dmcUzIm6T776R8u2ZKr9NeDJr6N0EUChmhRFIdoIIs4vc2x2KTcG6EYqBkK7XWk6SYZg3DgTkLbLO97A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729570118; c=relaxed/simple;
	bh=L30QhgyZxMw1v3JnkSQiyWGJLMv8l8fDqhWnuk9H+JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n7+2j6GPpkwpW43NjmYUc8KhZ9Dfn7qbR6cwwu4IfHSHbB9dE8fjD5oK1nxoyGLqsRN1wh8X+7yYZg/4IIxNA6GLBZgybRAB/NTYpTf6DvRn7pYTBlJIomwOmekKyEcPSnN4qrjTZyScFcXa8+A6NjW0CUT5oQa6VgYcaqXXxqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K/VNbTgy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K/VNbTgy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 55B0C1F8D5;
	Tue, 22 Oct 2024 04:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729570114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=x4BT7g71ZvtD5x+6d1Pu0nUS0nCkUCg56Em43ISWL38=;
	b=K/VNbTgydcz+igNP7n3g9VLtrp+9EpWanHJahc9gBrAv7rirKglx55lA5L0a8HXmBSW2xz
	Rf4MRjZlFRIM9H3PXxgoEPWFs9gQVd71CxKi35LcJK3Mlod30oFk6CI4M6PMkvDAaSzq1l
	4peOGv4VEjYGoLrOS8mnI9eaTzV67ic=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729570114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=x4BT7g71ZvtD5x+6d1Pu0nUS0nCkUCg56Em43ISWL38=;
	b=K/VNbTgydcz+igNP7n3g9VLtrp+9EpWanHJahc9gBrAv7rirKglx55lA5L0a8HXmBSW2xz
	Rf4MRjZlFRIM9H3PXxgoEPWFs9gQVd71CxKi35LcJK3Mlod30oFk6CI4M6PMkvDAaSzq1l
	4peOGv4VEjYGoLrOS8mnI9eaTzV67ic=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A6B513894;
	Tue, 22 Oct 2024 04:08:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4QxEM0AlF2esNgAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 22 Oct 2024 04:08:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Enno Gotthold <egotthold@suse.com>,
	Fabian Vogt <fvogt@suse.com>
Subject: [PATCH] btrfs: fix mount failure due to remount races
Date: Tue, 22 Oct 2024 14:38:11 +1030
Message-ID: <a68b1c835a227c844a5e106c9240f0c0215906c8.1729569894.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

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
Since we are not holding any super block at all, there is no good way to
properly prevent the race of changing the RO flag of the super block.

Thus here fix the bug by retry with an inverted read-only flag from the
previous attempt, and retry until fc_mount() succeed inside
btrfs_reconfigure_for_mount, or got an non-EBUSY error.

Furthermore, each retry will use an inverted RO flag from the previous
attempt, we will eventually win the race just by chance and can
continue.

This will also slightly change the condition on if we need to
reconfigure the fs, since it's possible that the succeeded run is
already using the correct RO flag.

Finally enhance the error message for btrfs_reconfigure_for_mount(), so
that btrfs will no longer silently error out during mount.

Fixes: f044b318675f ("btrfs: handle the ro->rw transition for mounting different subvolumes")
Reported-by: Enno Gotthold <egotthold@suse.com>
Reported-by: Fabian Vogt <fvogt@suse.com>
[ Special thanks for the reproducer and early analyze pointing to btrfs ]
Link: https://bugzilla.suse.com/show_bug.cgi?id=1231836
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index fa25db4aacf9..fe88cebb9dd1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2002,28 +2002,47 @@ static struct vfsmount *btrfs_reconfigure_for_mount(struct fs_context *fc)
 {
 	struct vfsmount *mnt;
 	int ret;
-	const bool ro2rw = !(fc->sb_flags & SB_RDONLY);
+	const unsigned int old_sb_flags = fc->sb_flags_mask;
 
+retry:
 	/*
 	 * We got an EBUSY because our SB_RDONLY flag didn't match the existing
 	 * super block, so invert our setting here and retry the mount so we
 	 * can get our vfsmount.
 	 */
-	if (ro2rw)
-		fc->sb_flags |= SB_RDONLY;
-	else
+	if (fc->sb_flags & SB_RDONLY)
 		fc->sb_flags &= ~SB_RDONLY;
-
+	else
+		fc->sb_flags |= SB_RDONLY;
 	mnt = fc_mount(fc);
-	if (IS_ERR(mnt))
+	/*
+	 * There is no super block lock to hold, thus we can have
+	 * another remount changing the RO/RW status.
+	 * So here we need to check if we got -EBUSY.
+	 * If we got one, retry with inverted RO flags again.
+	 */
+	if (IS_ERR(mnt) && PTR_ERR(mnt) == -EBUSY)
+		goto retry;
+	if (IS_ERR(mnt)) {
+		ret = PTR_ERR(mnt);
+		btrfs_err(NULL, "failed to mount during reconfigure: %d\n", ret);
+		return mnt;
+	}
+	if (!fc->oldapi)
 		return mnt;
 
-	if (!fc->oldapi || !ro2rw)
+	down_write(&mnt->mnt_sb->s_umount);
+	/*
+	 * The new mount is already matching our RO flags, or no need to
+	 * reconfigure to RW.
+	 */
+	if ((old_sb_flags & SB_RDONLY) == (mnt->mnt_sb->s_flags & SB_RDONLY) ||
+	    !(old_sb_flags & SB_RDONLY)) {
+		up_write(&mnt->mnt_sb->s_umount);
 		return mnt;
-
+	}
 	/* We need to convert to rw, call reconfigure. */
 	fc->sb_flags &= ~SB_RDONLY;
-	down_write(&mnt->mnt_sb->s_umount);
 	ret = btrfs_reconfigure(fc);
 	up_write(&mnt->mnt_sb->s_umount);
 	if (ret) {
-- 
2.47.0


