Return-Path: <linux-btrfs+bounces-16475-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FDFB39280
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 06:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBC546360D
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 04:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25351218858;
	Thu, 28 Aug 2025 04:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rokXmnbo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rokXmnbo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98513209F5A
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756354623; cv=none; b=AH56maPXNbzEcsr9qZ4wjIx59IBQogwoEo8Fj6pDY7jHoUDzjH4alBTlJ3ZtttUw3CojWK/7K69cvJILVj8t85Kd7AFc9xno+PV8er+7WNTyKDcstewF+Kx6s5LI/jnTk64+J3iFV84kjHU+kBqutyNK7hWhoaGr8iITzX+lHAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756354623; c=relaxed/simple;
	bh=rPKiw9pv+ggTO34iwhf/5+fxCSibFyMyAbxGHJO4IXk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFcu/rpevLxCi3Ez29QjPU2vuEw6xEJuOG9iXiDQsku5GUR3b3UvZ4KK/ueoHqn4L/FUAXOVwg7P/frxOEZLGqXo5203QsgbdTnM73St+g+oAHFxR+qHH/EhoPX6DRMV1uMZVb5IP8cl1otmyGh1uqRwQtcZRWUAhscse5ZQSMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rokXmnbo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rokXmnbo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D8627336E7
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756354612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xRxMk28xVrg9hSwbD6ZEi4jPliIOkyXhJqPMhvBXrHA=;
	b=rokXmnboBmdPSU/LvKhlsGFovyVS2kE90aNDlkUoB8mJNPMnv+HCaFNQDFixg64EBkXRie
	LO03YOhHxMFckXJyPUpfO/h2SsI4Wio5ypJ/Z6ZoW7oMQLX95DzqMdmZis5hUhshIHyRrQ
	7Zr0Dq60ajNkYlcbvV7Nr8oczHDDppA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756354612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xRxMk28xVrg9hSwbD6ZEi4jPliIOkyXhJqPMhvBXrHA=;
	b=rokXmnboBmdPSU/LvKhlsGFovyVS2kE90aNDlkUoB8mJNPMnv+HCaFNQDFixg64EBkXRie
	LO03YOhHxMFckXJyPUpfO/h2SsI4Wio5ypJ/Z6ZoW7oMQLX95DzqMdmZis5hUhshIHyRrQ
	7Zr0Dq60ajNkYlcbvV7Nr8oczHDDppA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20F8213680
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QA4nNTPYr2hhYQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 04:16:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: add extra error handling for btrfs_init_new_device()
Date: Thu, 28 Aug 2025 13:46:25 +0930
Message-ID: <2298cb0507e8a30f4bc31c79e54f7af900315702.1756353444.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756353444.git.wqu@suse.com>
References: <cover.1756353444.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

With all the new error handling for super block writebacks, now a tiny
device add will fail as expected:

 # lsblk  /dev/loop0
 NAME  MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
 loop0   7:0    0  64K  0 loop
 # mount /dev/test/scratch1  /mnt/btrfs/
 # btrfs device add -f /dev/loop0 /mnt/btrfs/
 Performing full device TRIM /dev/loop0 (64.00KiB) ...
 ERROR: error adding device '/dev/loop0': Input/output error

And the on-disk super block is still pointing to the older chunk tree:

 # btrfs ins dump-tree -t chunk /dev/test/scratch1
 ...
         item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
                devid 1 total_bytes 10737418240 bytes_used 562036736
                io_align 4096 io_width 4096 sector_size 4096 type 0
                generation 0 start_offset 0 dev_group 0
                seek_speed 0 bandwidth 0
                uuid 87358ef3-2cd2-4a4c-b607-4cba0cc80a3b
                fsid 26f7058c-2604-4293-a580-6efc653b849d
        item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 13631488) itemoff 16105 itemsize 80

But after the above error, we still can not properly mount the original
fs again:

 # umount /mnt/btrfs
 # mount /dev/test/scratch1 /mnt/btrfs
 mount: /mnt/btrfs: can't read superblock on /dev/mapper/test-scratch1.
       dmesg(1) may have more information after failed mount system call.
 # dmesg -t | tail -n 3
 BTRFS info (device dm-2): using crc32c (crc32c-lib) checksum algorithm
 BTRFS error (device dm-2): failed to read devices
 BTRFS error (device dm-2): open_ctree failed: -5

The mount failure is caused by the missing error handling of the
btrfs_commit_transaction() inside btrfs_init_new_device().

If that call failed, we should remove the new device, or it will pollute
the fs_devices, causing newer mounts to fail until the device is
forgotten manually.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2106190e972b..0f2a93824db1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2867,14 +2867,16 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	ret = btrfs_commit_transaction(trans);
 	clear_bit(BTRFS_DEV_STATE_NEW, &device->dev_state);
+	if (ret < 0) {
+		trans = NULL;
+		goto error_sysfs;
+	}
+
 	if (seeding_dev) {
 		mutex_unlock(&uuid_mutex);
 		up_write(&sb->s_umount);
 		locked = false;
 
-		if (ret) /* transaction commit */
-			return ret;
-
 		ret = btrfs_relocate_sys_chunks(fs_info);
 		if (ret < 0)
 			btrfs_handle_fs_error(fs_info, ret,
-- 
2.50.1


