Return-Path: <linux-btrfs+bounces-8760-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518B0997A91
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 04:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01EF1F23EA1
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 02:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D99013D8B2;
	Thu, 10 Oct 2024 02:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gnGWkT+A";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gnGWkT+A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F7B2B9A1
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 02:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728527485; cv=none; b=PrqRcVyZurHk72U5es/NsdRUAV3g4CNst7TKhsZ+dU5Y4NWb7G4YiBbxaMHKbVGzkh+WdMAZvh6pDbzIEyaFKfWTPxuVvDCgPtvX8bu7F1UmmeRwB86IvBeYBhqszQOkiemVBSxHH8b/ZfSaVCDjwChLHfuOYWVFgf2h54QHqis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728527485; c=relaxed/simple;
	bh=R1nnFYNfq0QRn4ygSJRz2l+WpvTlKTHtw51Oki3L/lE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hgEmG/oQPqAH8QAgsBJwQhFgHNozFQI7OjxFR0NstCxhG/kqbErdmyovpAcGj4NerkCm5v1ljNMHbpRfda8Rmhlhlg548yUYCIyNILXJqcYxl7Bugw8fQ72k7kcNMeOyLNsl+FSzUvJtQI8lKAVK8IzCCiV814RS/v9GdGFC9YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gnGWkT+A; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gnGWkT+A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2634B21F73;
	Thu, 10 Oct 2024 02:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728527476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CG5LMOSopxCvw/Fv6pLsABPCnbRNk46vCbvkKxTbqos=;
	b=gnGWkT+AhN13psHb4yh54cpcreX4O/4zP++rIDTmHLm9bN9O5f3urOlKbMPU2cGdQ1KaxS
	BoHyR0l4k/DvNMDShcH1Ndcu39x6ZCfGx9NSh2rWIo6X7mKsmSbVcFNHMwFLyfshtHTU4P
	OjXpGfpoHuo7uW9wn7tWiqWLKLYU5mM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728527476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CG5LMOSopxCvw/Fv6pLsABPCnbRNk46vCbvkKxTbqos=;
	b=gnGWkT+AhN13psHb4yh54cpcreX4O/4zP++rIDTmHLm9bN9O5f3urOlKbMPU2cGdQ1KaxS
	BoHyR0l4k/DvNMDShcH1Ndcu39x6ZCfGx9NSh2rWIo6X7mKsmSbVcFNHMwFLyfshtHTU4P
	OjXpGfpoHuo7uW9wn7tWiqWLKLYU5mM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BEDB137CF;
	Thu, 10 Oct 2024 02:31:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5jnWMnI8B2fGCwAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 10 Oct 2024 02:31:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: handle NULL as device path for btrfs_scan_one_device()
Date: Thu, 10 Oct 2024 13:00:57 +1030
Message-ID: <330f0214f1d8150e25dc609477e89534e3da961a.1728527388.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[cee29f5a48caf10cd475];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
Syzbot reports a crash when mounting a btrfs with NULL as @path for
btrfs_scan_one_device():

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 5235 Comm: syz-executor338 Not tainted 6.12.0-rc2-next-20241008-syzkaller #0
RIP: 0010:strlen+0x2c/0x70 lib/string.c:402
Call Trace:
 <TASK>
 getname_kernel+0x1d/0x2f0 fs/namei.c:232
 kern_path+0x1d/0x50 fs/namei.c:2716
 is_good_dev_path fs/btrfs/volumes.c:760 [inline]
 btrfs_scan_one_device+0x19e/0xd90 fs/btrfs/volumes.c:1484
 btrfs_get_tree_super fs/btrfs/super.c:1841 [inline]
 btrfs_get_tree+0x30e/0x1920 fs/btrfs/super.c:2114
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 fc_mount+0x1b/0xb0 fs/namespace.c:1231
 btrfs_get_tree_subvol fs/btrfs/super.c:2077 [inline]
 btrfs_get_tree+0x652/0x1920 fs/btrfs/super.c:2115
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 vfs_cmd_create+0xa0/0x1f0 fs/fsopen.c:225
 __do_sys_fsconfig fs/fsopen.c:472 [inline]
 __se_sys_fsconfig+0xa1f/0xf70 fs/fsopen.c:344
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe8c78542a9
---[ end trace 0000000000000000 ]---

[CAUSE]
The reproducer passes NULL as the device path for
btrfs_scan_one_device().

Normally such case will be rejected by bdev_file_open_by_path(), which
will return -EINVAL and we reject the mount.

But since commit ("btrfs: avoid unnecessary device path update for the
same device") and commit ("btrfs: canonicalize the device path before
adding") will do extra kern_path() lookup before
bdev_file_open_by_path().

Unlike bdev_file_open_by_path(), kern_path() doesn't do the NULL pointer
check and triggers the above strlen() on NULL pointer.

[FIX]
For function is_good_dev_path() and get_canonical_dev_path(), do the
extra NULL pointer checks.

This will be folded into the two offending patches, and I hope this is
really the last fix I need to fold...

Reported-by: syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/670689a8.050a0220.67064.0046.GAE@google.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5f5748ab6f9d..dc9f54849f39 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -749,6 +749,9 @@ static bool is_good_dev_path(const char *dev_path)
 	bool is_good = false;
 	int ret;
 
+	if (!dev_path)
+		goto out;
+
 	path_buf = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!path_buf)
 		goto out;
@@ -779,6 +782,11 @@ static int get_canonical_dev_path(const char *dev_path, char *canonical)
 	char *resolved_path;
 	int ret;
 
+	if (!dev_path) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	path_buf = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!path_buf) {
 		ret = -ENOMEM;
-- 
2.46.2


