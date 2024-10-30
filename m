Return-Path: <linux-btrfs+bounces-9223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44549B58DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 01:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E5E1C22C4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 00:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231303D96A;
	Wed, 30 Oct 2024 00:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LkhGmLRe";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LkhGmLRe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C6282F4
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 00:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730249788; cv=none; b=PqmKFQDU7svwWdteUdTPnfAlR72GW5VI4VSnw3aPNsfM9MeKyVWHh4265eSWF3N8dXEM9b8AIPA49KxRt+AIMZ9utaaExMsK3aNLhWXD8wPOpBPnoeskkNhSk8Qy3CyYqPPBfn3JSNS57YJCbYk1uho4643Gb20tj2iABLbKKBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730249788; c=relaxed/simple;
	bh=b+Yei9Mf5OSH86dqlQqhKU/OQ8vcJFVHfDnghhr/qc0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDYiopLbjS8zPb2Ag/qLGWBpkAOikRfV4pvbyyll13jpR7AOTTWsf+mIlZpRe4rWoVhhbJPs8BCrp2zDX12Hy0WiJ85G4hiN97qYCoqgjNe/nAJaHqowuoR+5l95SWwXE6bIutfs9mHVJUrBJlZPmuqVOGb+H+jE5atCxVs5UFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LkhGmLRe; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LkhGmLRe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A728621D55
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 00:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730249783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9mJTfrm8ClPgyghBF9L6l+W6yKAVv4DjHfjGEQpmDM=;
	b=LkhGmLReWH3IJwo2Uu1lDersWJTKRMSIojJjXqRmZCNs1eZUMuBzl+xZs7A7UsRhWXAJSl
	AeIM9kZLVTavuieV+dby34N3IkmoqFfCgBCIHczuvOEem0qDVw/2LEX8drLx74Xst1d5vJ
	GNLIuZShT7+Bk518tNrjqr5dq9j2C7c=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=LkhGmLRe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730249783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9mJTfrm8ClPgyghBF9L6l+W6yKAVv4DjHfjGEQpmDM=;
	b=LkhGmLReWH3IJwo2Uu1lDersWJTKRMSIojJjXqRmZCNs1eZUMuBzl+xZs7A7UsRhWXAJSl
	AeIM9kZLVTavuieV+dby34N3IkmoqFfCgBCIHczuvOEem0qDVw/2LEX8drLx74Xst1d5vJ
	GNLIuZShT7+Bk518tNrjqr5dq9j2C7c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9573136A5
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 00:56:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eCekJTaEIWdJJAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 00:56:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix per-subvolume RO/RW flags with new mount API
Date: Wed, 30 Oct 2024 11:25:47 +1030
Message-ID: <530cb7c961043767d15eac6c86d6cfd9a5d19ac5.1730249396.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: A728621D55
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
With util-linux 2.40.2, the mount is already utilizing the new mount
API. e.g:

 # strace  mount -o subvol=subv1,ro /dev/test/scratch1 /mnt/test/
 ...
 fsconfig(3, FSCONFIG_SET_STRING, "source", "/dev/mapper/test-scratch1", 0) = 0
 fsconfig(3, FSCONFIG_SET_STRING, "subvol", "subv1", 0) = 0
 fsconfig(3, FSCONFIG_SET_FLAG, "ro", NULL, 0) = 0
 fsconfig(3, FSCONFIG_CMD_CREATE, NULL, NULL, 0) = 0
 fsmount(3, FSMOUNT_CLOEXEC, 0)          = 4
 mount_setattr(4, "", AT_EMPTY_PATH, {attr_set=MOUNT_ATTR_RDONLY, attr_clr=0, propagation=0 /* MS_??? */, userns_fd=0}, 32) = 0
 move_mount(4, "", AT_FDCWD, "/mnt/test", MOVE_MOUNT_F_EMPTY_PATH) = 0

But this leads to a new problem, that per-subvolume RO/RW mount no
longer works, if the initial mount is RO:

 # mount -o subvol=subv1,ro /dev/test/scratch1 /mnt/test
 # mount -o rw,subvol=subv2 /dev/test/scratch1  /mnt/scratch
 # mount | grep mnt
 /dev/mapper/test-scratch1 on /mnt/test type btrfs (ro,relatime,discard=async,space_cache=v2,subvolid=256,subvol=/subv1)
 /dev/mapper/test-scratch1 on /mnt/scratch type btrfs (ro,relatime,discard=async,space_cache=v2,subvolid=257,subvol=/subv2)
 # touch /mnt/scratch/foobar
 touch: cannot touch '/mnt/scratch/foobar': Read-only file system

[CAUSE]
We have the remount "hack" to handle the RO->RW change, but if the mount
is using the new mount API, we do not do the hack, and rely on the mount
tool NOT to set the ro flag.

But that's not how the mount tool is doing for the new API:

 fsconfig(3, FSCONFIG_SET_STRING, "source", "/dev/mapper/test-scratch1", 0) = 0
 fsconfig(3, FSCONFIG_SET_STRING, "subvol", "subv1", 0) = 0
 fsconfig(3, FSCONFIG_SET_FLAG, "ro", NULL, 0) = 0 <<<< Setting RO flag for super block
 fsconfig(3, FSCONFIG_CMD_CREATE, NULL, NULL, 0) = 0
 fsmount(3, FSMOUNT_CLOEXEC, 0)          = 4
 mount_setattr(4, "", AT_EMPTY_PATH, {attr_set=MOUNT_ATTR_RDONLY, attr_clr=0, propagation=0 /* MS_??? */, userns_fd=0}, 32) = 0
 move_mount(4, "", AT_FDCWD, "/mnt/test", MOVE_MOUNT_F_EMPTY_PATH) = 0

This means we will set the super block RO at the first mount.

Later RW mount will not try to reconfigure the fs to RW because the
mount tool is already using the new API.

This totally breaks the per-subvolume RO/RW mount behavior.

[FIX]
Do not skip the reconfiguration even using the new API.
The old comments are just expecting the mount tool to properly skip RO
flag set even we specify "ro", which is not the reality.

And remove the comments pushing all the responsibility to mount command,
replace them with ones matching the reality instead.

Fixes: f044b318675f ("btrfs: handle the ro->rw transition for mounting different subvolumes")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6cc9291c4552..d77cce8d633e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1977,25 +1977,11 @@ static int btrfs_get_tree_super(struct fs_context *fc)
  *     fsconfig(FSCONFIG_SET_FLAG, "ro"). This option is seen by the filesystem
  *     in fc->sb_flags.
  *
- * This disambiguation has rather positive consequences.  Mounting a subvolume
- * ro will not also turn the superblock ro. Only the mount for the subvolume
- * will become ro.
+ * But in reality, even the newer util-linux mount command, which is already
+ * utilizing the new mount API, is still setting fsconfig(FSCONFIG_SET_FLAG, "ro")
+ * no matter if it's a btrfs or not, setting the whole super block RO.
  *
- * So, if the superblock creation request comes from the new mount API the
- * caller must have explicitly done:
- *
- *      fsconfig(FSCONFIG_SET_FLAG, "ro")
- *      fsmount/mount_setattr(MOUNT_ATTR_RDONLY)
- *
- * IOW, at some point the caller must have explicitly turned the whole
- * superblock ro and we shouldn't just undo it like we did for the old mount
- * API. In any case, it lets us avoid the hack in the new mount API.
- *
- * Consequently, the remounting hack must only be used for requests originating
- * from the old mount API and should be marked for full deprecation so it can be
- * turned off in a couple of years.
- *
- * The new mount API has no reason to support this hack.
+ * So here we always needs the remount hack to support per-subvolume RO/RW flags.
  */
 static struct vfsmount *btrfs_reconfigure_for_mount(struct fs_context *fc)
 {
@@ -2017,7 +2003,7 @@ static struct vfsmount *btrfs_reconfigure_for_mount(struct fs_context *fc)
 	if (IS_ERR(mnt))
 		return mnt;
 
-	if (!fc->oldapi || !ro2rw)
+	if (!ro2rw)
 		return mnt;
 
 	/* We need to convert to rw, call reconfigure. */
-- 
2.47.0


