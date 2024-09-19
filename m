Return-Path: <linux-btrfs+bounces-8122-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861CC97C834
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 12:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047611F22809
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 10:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D2A199FCD;
	Thu, 19 Sep 2024 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SkIk4+0h";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SkIk4+0h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777F960B8A
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726742923; cv=none; b=hSsNXaNPsukywB8s6VNbulT12YUirw9UKC9fTU3IgUWtetlqV7XM2QKTBejrTtAWKhDxE1g/6/40UOrZRyCaalt/aHUAJW+UsKJSmlwTrNnfX8FUx2W7ZxSj4+1KYPKorUzZuSApNSALpMOM5qwAZiOp9ScNz/PGjgvqam6vxuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726742923; c=relaxed/simple;
	bh=FmzLZiJoT02BfCdO7fLWG417pT6ta6GpfqeGBTrTpGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WWvVPWehtow4Hx83E4KIRDmANq4fV1Bwl8D5QzKwiqIudy6ECJj3oZexlu9kp8wd+tceYSOac5Mb6nC0UJTV3qE1DIsoRkLKv7T8zw4sD0mDqvNJpjJmtSOTNztjUN+txXwmQaqf2gfQNaA+Ap3ATTeXFspDSQojLzHg2BbNlOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SkIk4+0h; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SkIk4+0h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 374603387B;
	Thu, 19 Sep 2024 10:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726742914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NrsvIn2N6e0HEEy9AmSgmKu/Pik39a2CR2Ud3o1pNEw=;
	b=SkIk4+0hOOigpGGlzIbA8bHPO3KpNi1QAAPhTKaFTupF8AUr4zHL3Fyo3vZcu+MFdf31tP
	1fMwBjCxuTOXNdceKGZTrpYJiRD4mMnWha3MzbLBpABTiz5N20e+R6g7XNXsFa4SbOzFnv
	hcPpEUoOJa8p5GnpMuc1aYwzKMltZh0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726742914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NrsvIn2N6e0HEEy9AmSgmKu/Pik39a2CR2Ud3o1pNEw=;
	b=SkIk4+0hOOigpGGlzIbA8bHPO3KpNi1QAAPhTKaFTupF8AUr4zHL3Fyo3vZcu+MFdf31tP
	1fMwBjCxuTOXNdceKGZTrpYJiRD4mMnWha3MzbLBpABTiz5N20e+R6g7XNXsFa4SbOzFnv
	hcPpEUoOJa8p5GnpMuc1aYwzKMltZh0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36D1D13A1E;
	Thu, 19 Sep 2024 10:48:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KotaOoAB7GZdDAAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 19 Sep 2024 10:48:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: syzbot+56360f93efa90ff15870@syzkaller.appspotmail.com
Subject: [PATCH v2] btrfs: reject ro->rw reconfiguration if there are hard ro requirements
Date: Thu, 19 Sep 2024 20:18:11 +0930
Message-ID: <b03b069ea18d29ccad3410c61ed40b979b12f50b.1726742871.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[56360f93efa90ff15870];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

[BUG]
Syzbot reports the following crash:

  BTRFS info (device loop0 state MCS): disabling free space tree
  BTRFS info (device loop0 state MCS): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
  BTRFS info (device loop0 state MCS): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
  RIP: 0010:backup_super_roots fs/btrfs/disk-io.c:1691 [inline]
  RIP: 0010:write_all_supers+0x97a/0x40f0 fs/btrfs/disk-io.c:4041
  Call Trace:
   <TASK>
   btrfs_commit_transaction+0x1eae/0x3740 fs/btrfs/transaction.c:2530
   btrfs_delete_free_space_tree+0x383/0x730 fs/btrfs/free-space-tree.c:1312
   btrfs_start_pre_rw_mount+0xf28/0x1300 fs/btrfs/disk-io.c:3012
   btrfs_remount_rw fs/btrfs/super.c:1309 [inline]
   btrfs_reconfigure+0xae6/0x2d40 fs/btrfs/super.c:1534
   btrfs_reconfigure_for_mount fs/btrfs/super.c:2020 [inline]
   btrfs_get_tree_subvol fs/btrfs/super.c:2079 [inline]
   btrfs_get_tree+0x918/0x1920 fs/btrfs/super.c:2115
   vfs_get_tree+0x90/0x2b0 fs/super.c:1800
   do_new_mount+0x2be/0xb40 fs/namespace.c:3472
   do_mount fs/namespace.c:3812 [inline]
   __do_sys_mount fs/namespace.c:4020 [inline]
   __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

[CAUSE]
To support mounting different subvolume with different RO/RW flags for
the new mount APIs, btrfs introduced two small hack to support this feature:

- Skip mount option/feature checks if we are mounting a different
  subvolume

- Reconfigure the fs to RW if the initial mount is RO

Combining this two, we can have the following sequence:

- Mount the fs ro,rescue=all,clear_cache,space_cache=v1
  rescue=all will mark the fs as hard read-only, so no v2 cache clearing
  will happen.

- Mount a subvolume rw of the same fs.
  We go into btrfs_get_tree_subvol(), but fc_mount() returns EBUSY
  because our new fc is RW, different from the original fs.

  Now we enter btrfs_reconfigure_for_mount(), which switch the RO flag
  first so that we can grab the existing fs_info.
  Then we reconfigure the fs to RW.

- During reconfiguration, option/features check is skipped
  This means we will restart the v2 cache clearing, and convert back to
  v1 cache.
  This will trigger fs writes, and since the original fs has "rescue=all" option,
  it skips the csum tree read.

  And eventually causing NULL pointer dereference in super block
  writeback.

[FIX]
For reconfiguration caused by different subvolume RO/RW flags, ensure we
always run btrfs_check_options() to ensure we have proper hard RO
requirements met.

In fact the function btrfs_check_options() doesn't really do many
complex checks, but hard RO requirement and some feature dependency
checks, thus there is no special reason not to do the check for mount
reconfiguration.

Reported-by: syzbot+56360f93efa90ff15870@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/0000000000008c5d090621cb2770@google.com/
Fixes: f044b318675f ("btrfs: handle the ro->rw transition for mounting different subvolumes")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Always call btrfs_check_options() for reconfiguration
---
 fs/btrfs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 98fa0f382480..804c8fde5e8d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1498,8 +1498,7 @@ static int btrfs_reconfigure(struct fs_context *fc)
 	sync_filesystem(sb);
 	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
 
-	if (!mount_reconfigure &&
-	    !btrfs_check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
+	if (!btrfs_check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
 		return -EINVAL;
 
 	ret = btrfs_check_features(fs_info, !(fc->sb_flags & SB_RDONLY));
-- 
2.46.0


