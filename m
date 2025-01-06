Return-Path: <linux-btrfs+bounces-10756-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A82A0338F
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 00:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F5D3A420E
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 23:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2E31E2849;
	Mon,  6 Jan 2025 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KsyAbFAZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Xkrq1qWe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CE61DA634
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736207445; cv=none; b=CkXsG2KGB9OgMhvxKxHS+gTZPYFjKOPGVg+Verjo6B8jZEj1dogMG6D3aJ2DLQnBR2jbqFWmqhn3+1gz27JKC4w65/5nlCLTVfk4HF55JMn2kTrie69agV7vOgVMiMLA7V5XqmNmpdFFkvJWTAd8q5tQ1xwOJqpv9tjjmafPmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736207445; c=relaxed/simple;
	bh=5M+xwPo/nGv4waE855UxmVqhtQICvgcG/Bn+mVAlG5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSysNHJ8Mv+oom1rD6srNbGAjLFDr+HR+2UQjI3FP5nexd9knfKDNUUJnZTNyUO9HCwEqaQCY1bnPHS4IRDl0reT/KONSs5AQRbRWGFLfApmdhygpFMSJOU1/b3uzGqbhzhHEvGQViqTHS2ScPg8hrwnKZf0btPvbZg9bm4O2lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KsyAbFAZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Xkrq1qWe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E74991F450;
	Mon,  6 Jan 2025 23:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736207441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/+X9HuBDNujuENsEOxHhoFyavzZnKBT2AURgpdJrgEI=;
	b=KsyAbFAZjaJiSxUOSS5Qlphbt2CrT4T/NN0fjEEiEsd8auoslxqJt5HiItYsKRyA+QqCME
	D/siw5EXxbb90A0/UvUGCR211vVnKFjO8ephjKFOuR0Egh9dP5zl9a1lp1SmiT8tK7VrlM
	gFRn7i0Iy14y8EJBQZuuF2pH5r+92W8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Xkrq1qWe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736207440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/+X9HuBDNujuENsEOxHhoFyavzZnKBT2AURgpdJrgEI=;
	b=Xkrq1qWeUrFQJ4g5GIrEEC5GwFScAj5U1FxN5UmQQa3Z3VUKS3kIlt5QqvuIUxzasdAKiL
	462vMEXTofcZjDODuYKg1aVevHdgm5zdyOf4zoT8aXGxXQPObr5TvqZlyKez+us7wDz5j1
	nBkgorjJQIkG078e6riFRZNiory43Uo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E85D1139AB;
	Mon,  6 Jan 2025 23:50:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DhguKk9sfGcuQgAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 06 Jan 2025 23:50:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Duchesne <aether@disroot.org>
Subject: [PATCH v3] btrfs: prefer to use "/dev/mapper/name" symlink instead of "/dev/dm-*"
Date: Tue,  7 Jan 2025 10:20:18 +1030
Message-ID: <cb400b48ce549a16705adfe454fd39fbdb89f85c.1736207407.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E74991F450
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[BUG]
There is a gentoo bug report that upstream commit 2e8b6bc0ab41
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
"/dev/dm-1", mount will resolve the path to "/dev/mapper/hdd2" link
anyway.

So for newer kernels it won't be a big deal but one extra safety net.

[FIX]
Add an extra exception for is_same_device(), that if both paths are
pointing to the same device, but the newer path begins with "/dev/mapper"
and the older path is not, then still treat them as different devices,
so that we can rename to use the more human readable device path.

Reported-by: David Duchesne <aether@disroot.org>
Link: https://bugs.gentoo.org/947126
Fixes: 2e8b6bc0ab41 ("btrfs: avoid unnecessary device path update for the same device")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v3:
- Fix the term "soft link" to "symlink"
- Use the proper upstream commit hash
- Use "DEV_MAPPER_PATH" macro for both the path and strlen() parameter

v2:
- Fix unnecessary rename where the filename is the same
  The problem is in the exception handling that if both old and new path
  matches, we will still do the rename.
  Fix it by revert the exception check condition and setting is_same to true when
  path_equal() is true.

- Fix special chars in the commit message
---
 fs/btrfs/volumes.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c8b079ad1dfa..80687fcf25fb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -805,6 +805,8 @@ static int get_canonical_dev_path(const char *dev_path, char *canonical)
 	return ret;
 }
 
+#define	DEV_MAPPER_PATH		("/dev/mapper/")
+
 static bool is_same_device(struct btrfs_device *device, const char *new_path)
 {
 	struct path old = { .mnt = NULL, .dentry = NULL };
@@ -832,8 +834,21 @@ static bool is_same_device(struct btrfs_device *device, const char *new_path)
 	ret = kern_path(new_path, LOOKUP_FOLLOW, &new);
 	if (ret)
 		goto out;
-	if (path_equal(&old, &new))
+	if (path_equal(&old, &new)) {
 		is_same = true;
+		/*
+		 * Special case for device mapper with its symlinks.
+		 *
+		 * We can have the old path as "/dev/dm-3", but udev triggered
+		 * rescan on the symlink "/dev/mapper/test".
+		 * In that case we want to rename to that mapper link, to avoid
+		 * a bug in libblkid where it cannot handle multiple mount
+		 * points if the device is "/dev/dm-3".
+		 */
+		if (strncmp(old_path, DEV_MAPPER_PATH, strlen(DEV_MAPPER_PATH)) &&
+		    strncmp(new_path, DEV_MAPPER_PATH, strlen(DEV_MAPPER_PATH)) == 0)
+			is_same = false;
+	}
 out:
 	kfree(old_path);
 	path_put(&old);
-- 
2.47.1


