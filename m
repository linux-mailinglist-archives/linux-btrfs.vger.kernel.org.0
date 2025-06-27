Return-Path: <linux-btrfs+bounces-15017-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37132AEACF5
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 04:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7EE74A6DDD
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 02:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AC2199252;
	Fri, 27 Jun 2025 02:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LTJPo4la";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LTJPo4la"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2047A2F1FC0
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750992395; cv=none; b=t0SQj3iWXZ9CYghJPIRGA9BJfCeR44awRDnOuGxLAJBMt6M1ZRQjaSxhqhL0kezKWSZ13jkSwzQv/7Sken/NNKlDCzqHdoHz/6eB3WHTiaKAYDD/s5ZtjJ6aJjjAeGUUQ/UPs+dlCfyJCFe5ataruQpOzaEwYpXmXzaJEYYV8oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750992395; c=relaxed/simple;
	bh=4H9VTHdd7pD4lfX15KxLgY9uPpOYaB+DlcTb3cHSLzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRK7JlYnZXgKQADYqPV4Fq0Ein3e7nom9v85pzhN/hRf5eJw54KY7peTXbMT9qDEJQnPNqfOcknS2lky8mvT/fF8QA09hfH2hPmvmNpIeu5DOTdy4EwQwCrVwZiQlPdz9Hho9eagkT+PfUM7JVRUeVGVjWkd3K+eA1PjccHn9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LTJPo4la; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LTJPo4la; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 24A7821172;
	Fri, 27 Jun 2025 02:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750992391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QZVIvgMaoHIVkfeLRnN9vv0t854C0Jh1vd5YvJ+OBkA=;
	b=LTJPo4laHfH/s4ke6yWpm+pmI5du/L4rzXuviSK8W6U5LAFdhaFJYG5ekriSWlgwUxQwII
	z37xa5Otd6p4tNbnbi60WEj8ywhLFkv/QCh3r5IZ53TdYz2BBigM5VNeS3S+YZhQvJkH40
	fo18Bu39srVFFWFRLKqxAGlsJ6mYN4w=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=LTJPo4la
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750992391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QZVIvgMaoHIVkfeLRnN9vv0t854C0Jh1vd5YvJ+OBkA=;
	b=LTJPo4laHfH/s4ke6yWpm+pmI5du/L4rzXuviSK8W6U5LAFdhaFJYG5ekriSWlgwUxQwII
	z37xa5Otd6p4tNbnbi60WEj8ywhLFkv/QCh3r5IZ53TdYz2BBigM5VNeS3S+YZhQvJkH40
	fo18Bu39srVFFWFRLKqxAGlsJ6mYN4w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21CD1138A7;
	Fri, 27 Jun 2025 02:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h1XnNAUGXmiLfgAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 27 Jun 2025 02:46:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: syzbot+772bdfe41846e057fa83@syzkaller.appspotmail.com
Subject: [PATCH v2] btrfs: fix a use-after-free race if btrfs_open_devices() failed
Date: Fri, 27 Jun 2025 12:16:12 +0930
Message-ID: <8f0b5071b96e7451a3b493c7c11f448b21688c26.1750992149.git.wqu@suse.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[772bdfe41846e057fa83];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 24A7821172
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

[BUG]
With the latest v5 version patchset "btrfs: use fs_holder_ops for btrfs"
merged into linux-next, syzbot reported an use-after-free:

==================================================================
BUG: KASAN: slab-use-after-free in close_fs_devices+0x81f/0x870 fs/btrfs/volumes.c:1182
Read of size 4 at addr ffff88802fe14930 by task syz.4.616/8589

CPU: 0 UID: 0 PID: 8589 Comm: syz.4.616 Not tainted 6.16.0-rc3-next-20250626-syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 close_fs_devices+0x81f/0x870 fs/btrfs/volumes.c:1182
 btrfs_close_devices+0xc5/0x560 fs/btrfs/volumes.c:1201
 btrfs_free_fs_info+0x4f/0x3c0 fs/btrfs/disk-io.c:1250
 deactivate_locked_super+0xbc/0x130 fs/super.c:474
 btrfs_get_tree_super fs/btrfs/super.c:-1 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2073 [inline]
 btrfs_get_tree+0xd1e/0x17f0 fs/btrfs/super.c:2107
 vfs_get_tree+0x92/0x2b0 fs/super.c:1804
 do_new_mount+0x24a/0xa40 fs/namespace.c:3902
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fedccd900ca
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fedcdc28e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fedcdc28ef0 RCX: 00007fedccd900ca
RDX: 00002000000055c0 RSI: 0000200000005600 RDI: 00007fedcdc28eb0
RBP: 00002000000055c0 R08: 00007fedcdc28ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000200000005600
R13: 00007fedcdc28eb0 R14: 000000000000559d R15: 0000200000000440
 </TASK>

Allocated by task 8589:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4396
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 alloc_fs_devices+0x4f/0x1d0 fs/btrfs/volumes.c:384
 device_list_add+0x6b7/0x20b0 fs/btrfs/volumes.c:813
 btrfs_scan_one_device+0x3fd/0x5b0 fs/btrfs/volumes.c:1487
 btrfs_get_tree_super fs/btrfs/super.c:1856 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2073 [inline]
 btrfs_get_tree+0x433/0x17f0 fs/btrfs/super.c:2107
 vfs_get_tree+0x92/0x2b0 fs/super.c:1804
 do_new_mount+0x24a/0xa40 fs/namespace.c:3902
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 7454:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kfree+0x18e/0x440 mm/slub.c:4879
 btrfs_free_stale_devices+0x61c/0x6b0 fs/btrfs/volumes.c:564
 btrfs_scan_one_device+0x3d5/0x5b0 fs/btrfs/volumes.c:1481
 btrfs_control_ioctl+0x11f/0x360 fs/btrfs/super.c:2256
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

[CAUSE]
The patch "btrfs: delay btrfs_open_devices() until super block is created"
changed the timing when btrfs_open_devices() is called.

Now it's called after sget_fc(), the changed timing is required for
using super blocks as bdev holder.

The problem is the changed error handling.

Before the change if btrfs_open_devices() failed we error out directly,
but now we need to call deactivate_locked_super().

However since btrfs_open_devices() failed, fs_devices->opened is still
0, meaning any reclaim request can free the fs_devices.

But at the same time, deactivate_locked_super() will also cleanup the
fs_info with btrfs_free_fs_info(), which calls btrfs_close_devices().

This leads to the following race:

       Mount process              |         Scan process
----------------------------------+--------------------------------
btrfs_get_tree_super()            |
|- mutex_lock(&uuid_mutex)        |
|- btrfs_open_devices()           |
|  Which failed.                  |
|  fs_devices->opened is still 0. |
|- mutex_unlock(&uuid_mutex)      |
|                                 | btrfs_control_ioctl()
|                                 | |- btrfs_scan_one_device()
|                                 |    |- btrfs_free_stale_devices()
|                                 |       That fs_devices is freed
|- deactivate_locked_super()      |
   |- btrfs_free_fs_info()        |
      |- btrfs_close_devices()
         Now try to free the same
	 fs_devices that is freed
	 by the scan process.

[FIX]
If btrfs_open_devices() failed, we should not keep a pointer to it, as
it can be freed at any time after uuid_mutex unlocked.

So add an extra handling for btrfs_open_devices() to reset
fs_info->fs_devices to NULL.

This also applies to all the remaining handling of fs_devices, including:

- Only modify fs_info->fs_devices under uuid_mutex
  This is to be extra safe.
  It is safe as long as fs_info->fs_devices is NULL before we enter
  deactivate_locked_super().

- Error handling if sget_fc() failed
  The handling is the same.

This will be folded into the patch "btrfs: delay btrfs_open_devices()
until super block is created".

Reported-by: syzbot+772bdfe41846e057fa83@syzkaller.appspotmail.com
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2: 
- Add the missing error handling for sget_fc() error
- Only modify fs_info->fs_devices with uuid_mutex hold
  This is just for extra safety and consistency.
  As long as fs_info->fs_devices is NULL before entering
  deactivate_locked_super(), we should be safe.
---
 fs/btrfs/super.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3fba3d6309a2..80486ce3422d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1868,14 +1868,15 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	 * the fs_devices itself won't be freed.
 	 */
 	btrfs_fs_devices_inc_holding(fs_devices);
+	fs_info->fs_devices = fs_devices;
 	mutex_unlock(&uuid_mutex);
 
-	fs_info->fs_devices = fs_devices;
 
 	sb = sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
 	if (IS_ERR(sb)) {
 		mutex_lock(&uuid_mutex);
 		btrfs_fs_devices_dec_holding(fs_devices);
+		fs_info->fs_devices = NULL;
 		mutex_unlock(&uuid_mutex);
 		return PTR_ERR(sb);
 	}
@@ -1895,13 +1896,12 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 
 		mutex_lock(&uuid_mutex);
 		btrfs_fs_devices_dec_holding(fs_devices);
-		mutex_unlock(&uuid_mutex);
 		/*
 		 * But the fs_info->fs_devices is not opened, we should not let
 		 * btrfs_free_fs_context() to close them.
 		 */
 		fs_info->fs_devices = NULL;
-
+		mutex_unlock(&uuid_mutex);
 		/*
 		 * At this stage we may have RO flag mismatch between
 		 * fc->sb_flags and sb->s_flags.  Caller should detect such
@@ -1921,6 +1921,17 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		mutex_lock(&uuid_mutex);
 		btrfs_fs_devices_dec_holding(fs_devices);
 		ret = btrfs_open_devices(fs_devices, mode, sb);
+		/*
+		 * If btrfs_open_devices() failed, fs_devices is not opened and
+		 * can be freed by any reclaim request after uuid_mutex unlocked.
+		 *
+		 * But our fs_info is still using that fs_devices, thus it will
+		 * lead to use-after-free later.
+		 *
+		 * So here we must not use that fs_devices after open failure.
+		 */
+		if (ret < 0)
+			fs_info->fs_devices = NULL;
 		mutex_unlock(&uuid_mutex);
 		if (ret < 0) {
 			deactivate_locked_super(sb);
-- 
2.49.0


