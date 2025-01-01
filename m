Return-Path: <linux-btrfs+bounces-10674-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE9F9FF508
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 22:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16473A1FDB
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 21:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D101E2606;
	Wed,  1 Jan 2025 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q4rZ2yNV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q4rZ2yNV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0AB38382
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Jan 2025 21:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735768020; cv=none; b=lxYleXwwZln6wcnVG7TTKSF10nZrcTFVz/GLsqsM+0rh6ipD1mrTYC23F8v1EgxHS21pa0Ky6/6vqg+/Ci0zj9HQgyGHVUdpuDJEydYpm/dhTut7zBaGAu/OXdwOsOxUgZKwZqqtXOBiv6k+Zxvn2U32xx6Mr20oPGfMGNtWxb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735768020; c=relaxed/simple;
	bh=N3bnG38tKp2A5B2+1dCNI5kMfj3Lj5pLTXq9I//wVZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nFUsWpERpwcohDyLCaB1WPY6V3ifS/JUb2D2GC/P1kgR11dVKuya2zcIerIijeYHov79/gar0eKIigqs7NovqE1bWKQD6oGdni4mLbJ/pIRUSjdiZ8ALgg202LbpCTIoHdmBAqwxGm/ypHNX2dm8yWSyUuzwXbO57wzrwtPM7m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q4rZ2yNV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q4rZ2yNV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F6251F37C;
	Wed,  1 Jan 2025 21:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1735768016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=U113Rik2TeVtRDk+485rjaRI22MugInp4FaFf3rqdUE=;
	b=Q4rZ2yNVxfN0zSfhch8zx8hQWBCM5bMOLHCZmzn2B+lOCiSIC6NGXGeTalOByHaXYRFX3y
	pUcVOqOIk1/DDDRtGY84Ptf5Q/2jHXuplsJbmFwe9n+SZmCeAHyf5i25/91hiqZDQ5Ww24
	SEzPtuGUz29230Rj5SuNrENQQ5nEEwk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1735768016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=U113Rik2TeVtRDk+485rjaRI22MugInp4FaFf3rqdUE=;
	b=Q4rZ2yNVxfN0zSfhch8zx8hQWBCM5bMOLHCZmzn2B+lOCiSIC6NGXGeTalOByHaXYRFX3y
	pUcVOqOIk1/DDDRtGY84Ptf5Q/2jHXuplsJbmFwe9n+SZmCeAHyf5i25/91hiqZDQ5Ww24
	SEzPtuGUz29230Rj5SuNrENQQ5nEEwk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B44CE13A30;
	Wed,  1 Jan 2025 21:46:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KqeZF863dWd5NwAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 01 Jan 2025 21:46:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Duchesne <aether@disroot.org>
Subject: [PATCH v2] btrfs: prefer to use "/dev/mapper/name" soft link instead of "/dev/dm-*"
Date: Thu,  2 Jan 2025 08:16:32 +1030
Message-ID: <fb12d07525d725188649f8dae90c0cfc8d31a0db.1735767974.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
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
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
There is a gentoo bug report that upstream commit a5d74fa24752
("btrfs: avoid unnecessary device path update for the same device") breaks
6.6 LTS kernel behavior where previously lsblk can properly show multiple
mount points of the same btrfs:

 With kernel 6.6.62:
 NAME         MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
 sdb            8:16   0   9,1T  0 disk
 `-sdb1         8:17   0   9,1T  0 part
   `-hdd2     254:6    0   9,1T  0 crypt /mnt/hdd2
                                         /var/cache/distfiles
                                         /var/cache/binpkgs

But not with that upstream commit backported:

 With kernel 6.6.67:
 sdb            8:16   0   9,1T  0 disk
 `-sdb1         8:17   0   9,1T  0 part
   `-hdd2     254:6    0   9,1T  0 crypt /mnt/hdd2

[CAUSE]
With that upstream patch backported to 6.6 LTS, the main change is in
the mount info result:

Before:
 /dev/mapper/hdd2 /mnt/hdd2 btrfs rw,relatime,space_cache=v2,subvolid=382,subvol=/hdd2 0 0
 /dev/mapper/hdd2 /mnt/dump btrfs rw,relatime,space_cache=v2,subvolid=393,subvol=/dump 0 0

After:
 /dev/dm-1 /mnt/hdd2 btrfs rw,relatime,space_cache=v2,subvolid=382,subvol=/hdd2 0 0
 /dev/dm-1 /mnt/dump btrfs rw,relatime,space_cache=v2,subvolid=393,subvol=/dump 0 0

I believe that change of mount device is causing problems for lsblk.

And before that patch, even if udev registered "/dev/dm-1" to btrfs,
later mount triggered a rescan and change the name back to
"/dev/mapper/hdd2" thus older kernels will work as expected.

But after that patch, if udev registered "/dev/dm-1", then mount
triggered a rescan, but since btrfs detects both "/dev/dm-1" and
"/dev/mapper/hdd2" are pointing to the same block device, btrfs refuses
to do the rename, causing the less human readable "/dev/dm-1" to be
there forever, and trigger the bug for lsblk.

Fortunately for newer kernels, I guess due to the migration to fsconfig
mount API, even if the end user explicitly mount the fs using
"/dev/dm-1", the mount will resolve the path to "/dev/mapper/hdd2" link
anyway.

So for newer kernels it won't be a big deal but one extra safety net.

[FIX]
Add an extra exception for is_same_device(), that if both paths are
pointing to the same device, but the newer path begins with "/dev/mapper"
and the older path is not, then still treat them as different devices,
so that we can rename to use the more human readable device path.

Reported-by: David Duchesne <aether@disroot.org>
Link: https://bugs.gentoo.org/947126
Fixes: a5d74fa24752 ("btrfs: avoid unnecessary device path update for the same device")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix unnecessary rename where the filename is the same
  The problem is in the exception handling that if both old and new path
  matches, we will still do the rename.
  Fix it by revert the exception check condition and setting is_same to true when
  path_equal() is true.

- Fix special chars in the commit message
---
 fs/btrfs/volumes.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c8b079ad1dfa..5a0327e11807 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -832,8 +832,21 @@ static bool is_same_device(struct btrfs_device *device, const char *new_path)
 	ret = kern_path(new_path, LOOKUP_FOLLOW, &new);
 	if (ret)
 		goto out;
-	if (path_equal(&old, &new))
+	if (path_equal(&old, &new)) {
 		is_same = true;
+		/*
+		 * Special case for device mapper with its soft links.
+		 *
+		 * We can have the old path as "/dev/dm-3", but udev triggered
+		 * rescan on the soft link "/dev/mapper/test".
+		 * In that case we want to rename to that mapper link, to avoid
+		 * a bug in libblkid where it can not handle multiple mount
+		 * points if the device is "/dev/dm-3".
+		 */
+		if (strncmp(old_path, "/dev/mapper/", strlen("/dev/mapper")) &&
+		    !strncmp(new_path, "/dev/mapper/", strlen("/dev/mapper")))
+			is_same = false;
+	}
 out:
 	kfree(old_path);
 	path_put(&old);
-- 
2.47.1


