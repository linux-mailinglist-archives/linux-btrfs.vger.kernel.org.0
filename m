Return-Path: <linux-btrfs+bounces-10655-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A9F9FE3DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2024 09:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A36E3A1FA4
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2024 08:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0311A0BCF;
	Mon, 30 Dec 2024 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dXUBTO93";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gonS63fO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C4E25948E
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Dec 2024 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735548376; cv=none; b=uF9JP4hwpg+gArE2fbh9fcvYpAgWWnaEw1xBJLIrZEB4L+mD2F5TJ4mtsvV9/hh5FZJOGbwTmwgsc5UX0zfulySZiNm4yxQW9lAgluqFTzEG3oyFej4obYWj7+GABENyMgpWlXEUwSAD/7s0I+zolm6/cwAz4vdY0KXTK6oDVg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735548376; c=relaxed/simple;
	bh=9RAV769x2Re/Djx1i1Xi/tP8RUYJbwf3yeKA3sGDY6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LBrSnQJZUzF9rADzHGc6meQhz5bE9pVf2NlfNbMMljb8se4Ja/F4gwg5MbgW9nTm3qSbAduH8bvInJ05a+W190EJT0r11ekY/2dZoMaSQrOiypyFTWF6VDEGA6og4JpX/Eod1FO2OcIeh9pkYOdF2GrS7zks/mnWMUPGAGep6qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dXUBTO93; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gonS63fO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D9DF621111;
	Mon, 30 Dec 2024 08:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1735548372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zTDIwKp1KLoUGjtSibF+V1QJLjgVkKcD9qtiwj+rM2c=;
	b=dXUBTO93CCd5D2nw7O9226/N0aQIieIT66fwrFlF7s0v8nL2fuDQUiPDKUZagUWejQMbzF
	3/hjLZ7E3jN9xYKFH0Bxu2Ozbu1M1aYLECvBPMFtQYMsM+Vxe00OLI9idqztBu4G9mS20u
	8NpcmSLFovroptMHf4Ct/9pZO0zahNY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1735548371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zTDIwKp1KLoUGjtSibF+V1QJLjgVkKcD9qtiwj+rM2c=;
	b=gonS63fO4v6DacNHxhq1hEWr5oMDNeODOBGvfAETqxCRm74jQipvjoIDEHdNikw9BmsvdE
	st8EMAYCBs+sEC+62ivoJHlGTRK0sfJMkvwpGEN9TWUW34ACBhpbpY6ncPNtWimoB2eBEw
	gnO8SQVAYBy2/U9yINak2ZdEbm5MSsw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6B3C13A30;
	Mon, 30 Dec 2024 08:46:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gWw/JdJdcme2TgAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 30 Dec 2024 08:46:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Duchesne <aether@disroot.org>
Subject: [PATCH] btrfs: prefer to use "/dev/mapper/name" soft link instead of "/dev/dm-*"
Date: Mon, 30 Dec 2024 19:15:53 +1030
Message-ID: <30aefd8b4e8c1f0c5051630b106a1ff3570d28ed.1735537399.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

[BUG]
There is a gentoo bug report that upstream commit a5d74fa24752
("btrfs: avoid unnecessary device path update for the same device") breaks
6.6 LTS kernel behavior where previously lsblk can properly show multiple
mount points of the same btrfs:

 With kernel 6.6.62:
 NAME         MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
 sdb            8:16   0   9,1T  0 disk
 └─sdb1         8:17   0   9,1T  0 part
   └─hdd2     254:6    0   9,1T  0 crypt /mnt/hdd2
                                         /var/cache/distfiles
                                         /var/cache/binpkgs

But not with that upstream commit backported:

 With kernel 6.6.67:
 sdb            8:16   0   9,1T  0 disk
 └─sdb1         8:17   0   9,1T  0 part
   └─hdd2     254:6    0   9,1T  0 crypt /mnt/hdd2

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
Unfortunately I'm not yet 100% clear on why lsblk and libblkid failed to
handle multiple mount points with "/dev/dm-*" path names (it can only
show the first one).

But since it's a behavior change caused by the backport, at least we
should allow the rename to align the older behavior.
---
 fs/btrfs/volumes.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c8b079ad1dfa..1d208968daf3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -832,8 +832,20 @@ static bool is_same_device(struct btrfs_device *device, const char *new_path)
 	ret = kern_path(new_path, LOOKUP_FOLLOW, &new);
 	if (ret)
 		goto out;
-	if (path_equal(&old, &new))
-		is_same = true;
+	if (path_equal(&old, &new)) {
+		/*
+		 * Special case for device mapper with its soft links.
+		 *
+		 * We can have the old path as "/dev/dm-3", but udev triggered
+		 * rescan on the soft link "/dev/mapper/test".
+		 * In that case we want to rename to that mapper link, to avoid
+		 * a bug in libblkid where it can not handle multiple mount
+		 * points if the device is "/dev/dm-3".
+		 */
+		if (!strncmp(old_path, "/dev/mapper/", strlen("/dev/mapper")) &&
+		    strncmp(new_path, "/dev/mapper/", strlen("/dev/mapper")))
+			is_same = true;
+	}
 out:
 	kfree(old_path);
 	path_put(&old);
-- 
2.47.1


