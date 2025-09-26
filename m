Return-Path: <linux-btrfs+bounces-17205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41615BA2680
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 06:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0129A562007
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 04:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006B9272E4E;
	Fri, 26 Sep 2025 04:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fqrBwE2j";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EBjDJuW6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D888834BA20
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 04:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758862240; cv=none; b=m0QZAKQpbep4NtGxLmYE6wsbDuVE50IqaZ+BOpqBuOIyWOLQfq/fgFx9O8ZLTGmHkVVH/E64ArN3XFQ2MDnsuhUS0H26jx1dNRhWdO3C3lnReBfa0VyDZyhc26g939GmgPne/A1CrQ568bliMHSUL2UzEiYtf3WRAEZ+r/LDnmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758862240; c=relaxed/simple;
	bh=LPw78MHZQPU2cVjFo7UzPIUpqserIO2v21AIx3NXiSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6gwH5NmJgspdZE+Qv7G3WLqLqSc4mUoxfGeOuYny1gRG0y7ZGREbQtcLLgwGgVIfDoMlF3ak9knZxjsfFgY/vQ0qxDVofz9+0LIhvwaO2vjYgj4l1qrOzcaLH2R2AWNdjj5hhthKF152XlnWa6622xX1rxLn0opsbHu6SqGIAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fqrBwE2j; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EBjDJuW6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E28D524137;
	Fri, 26 Sep 2025 04:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758862235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nHTMgGlXQYOtWan4j/hqXargX4hqaElTiyoBK9q8Kpc=;
	b=fqrBwE2jJcZvw0L6UEDUr5ELsL+rsvqGbXIF2k2+pxEbBDXKPQPQsdjk4qNXNf+5xSpANz
	VRiVct4CiCJBwK8PYCVUWCHj2jGe42nI9O38kvmd+0Bdq1NprH/hdWAg5YYttiDMy82m3s
	5dZrhH0c+D7PoNOTMgguN4DUFiTvF6M=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758862234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nHTMgGlXQYOtWan4j/hqXargX4hqaElTiyoBK9q8Kpc=;
	b=EBjDJuW6y8BVcjvzSGil+7Rg9/z4gOIDu7OVmaD/liVt8+8LEdHJ2DRiOLo50n+DQ43srz
	iQ1vx3W40Vdv+ND1bD7eZd00h8COuGN/tBa8mreZ0M4EUS72xN4EVy3gqbCfwKNMUOZcKx
	AiMEuWW3SwAqgUr6jnhXu2Eg1aeaT6U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA8B01386E;
	Fri, 26 Sep 2025 04:50:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rPlFJpkb1mglNwAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 26 Sep 2025 04:50:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: HAN Yuwei <hrx@bupt.moe>
Subject: [PATCH] btrfs: only set the device specific options after devices are opened
Date: Fri, 26 Sep 2025 14:20:11 +0930
Message-ID: <95f198ac033610c66c30312743fbec4869200229.1758862208.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,bupt.moe:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

[BUG]
With v6.17-rc kernels, btrfs will always set 'ssd' mount option even if
the block device is not a rotating one:

 # cat /sys/block/sdd/queue/rotational
 1
 # cat /etc/fstab:
 LABEL=DATA2     /data2  btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/,nofail,nosuid,nodev      0 0

 # mount
 [...]
 /dev/sdd on /data2 type btrfs (rw,nosuid,nodev,relatime,ssd,space_cache=v2,subvolid=5,subvol=/)

[CAUSE]
The 'ssd' mount option is set by set_device_specific_options(), and it
expects that if there is any rotating device in the btrfs, it will set
fs_devices::rotating.

However after commit bddf57a70781 ("btrfs: delay btrfs_open_devices()
until super block is created"), the device opening is delayed until the
super block is created.

But the timing of set_device_specific_options() is still left as is,
this makes the function to be called without any device opened.

Since no device is opened, thus fs_devices::rotating will never be set,
making btrfs to incorrectly setting 'ssd' mount option.

[FIX]
Only call set_device_specific_options() after btrfs_open_devices().

Also only call set_device_specific_options() after a new mount, if we're
mounting a mounted btrfs, there is no need to set the device specific
mount options again.

Fixes: bddf57a70781 ("btrfs: delay btrfs_open_devices() until super block is created")
Reported-by: HAN Yuwei <hrx@bupt.moe>
Link: https://lore.kernel.org/linux-btrfs/C8FF75669DFFC3C5+5f93bf8a-80a0-48a6-81bf-4ec890abc99a@bupt.moe/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d6e496436539..aadc02374b2a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1900,8 +1900,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		return PTR_ERR(sb);
 	}
 
-	set_device_specific_options(fs_info);
-
 	if (sb->s_root) {
 		/*
 		 * Not the first mount of the fs thus got an existing super block.
@@ -1946,6 +1944,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 			deactivate_locked_super(sb);
 			return -EACCES;
 		}
+		set_device_specific_options(fs_info);
 		bdev = fs_devices->latest_dev->bdev;
 		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
-- 
2.50.1


