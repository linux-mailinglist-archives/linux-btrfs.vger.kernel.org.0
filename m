Return-Path: <linux-btrfs+bounces-5912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EB0914240
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 07:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6DDB23F19
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 05:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B0318AF9;
	Mon, 24 Jun 2024 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mGgElqDY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mGgElqDY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0621754B
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719207683; cv=none; b=XYfX4U/yIRk3sVMlQ+sBv2wmUsPK1n/MW4C02Rq5CPm7V42pOLn/2rSk4vFJsVg/0dLDUutmwLq7e1QRHv7HblR/sXp4ziyS8f+SKMqX2lUVyADSTupVTgy0bfZQcPZSmVy6FgQwXA/zz3suI6qvHfvir958InsRaxHk3gwn79c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719207683; c=relaxed/simple;
	bh=YiDlZ/dplKUJEEUPfotL3mz4g0MwrOG32HtD3aDWQL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e73DZf4Kj2SuPp6766ROVf+qDEJi0/ocLYH27rxx6+rQXYmy25d+6+8Ke1+fddDtLeuXaz+nqkWpNyUI/GFhuDjfsOwMmurf+zhv3D3IE303DPQpDzfrNTkJU/2LjRgtFIlsWKegY0hY0zbxZ5ybU0z+ZUonc9fAL6I+HBwGNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mGgElqDY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mGgElqDY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5AF43219FE;
	Mon, 24 Jun 2024 05:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719207677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WkkyLinMwOZ4xWAXZJWjqlknop+uxIahexDebrHNg8U=;
	b=mGgElqDYYCcEfgKhow14H+rE9INzlJ3F4/SLB6ouLUggDIG+AewUWdRkgJKX9I1gu/tlqo
	8Z4HtVrbWdoyluBvgg17gXtB9IIarehe31nWv4fibSBlR+c2RMuEqANLq44xAzJsiHW1xh
	WI6H4I3LWKktqM70AnOOJDSaFVbOa84=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mGgElqDY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719207677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WkkyLinMwOZ4xWAXZJWjqlknop+uxIahexDebrHNg8U=;
	b=mGgElqDYYCcEfgKhow14H+rE9INzlJ3F4/SLB6ouLUggDIG+AewUWdRkgJKX9I1gu/tlqo
	8Z4HtVrbWdoyluBvgg17gXtB9IIarehe31nWv4fibSBlR+c2RMuEqANLq44xAzJsiHW1xh
	WI6H4I3LWKktqM70AnOOJDSaFVbOa84=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2965313ACD;
	Mon, 24 Jun 2024 05:41:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id //8dNPsGeWacVQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 24 Jun 2024 05:41:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: always do the basic checks for btrfs_qgroup_inherit structure
Date: Mon, 24 Jun 2024 15:10:53 +0930
Message-ID: <47d3dd33f637b70f230fa31f98dbf9ff066b58bb.1719207446.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[a0d1f7e26910be4dc171];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.com:email,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5AF43219FE
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

[BUG]
Syzbot reports the following regression detected by KASAN:

==================================================================
BUG: KASAN: slab-out-of-bounds in btrfs_qgroup_inherit+0x42e/0x2e20 fs/btrfs/qgroup.c:3277
Read of size 8 at addr ffff88814628ca50 by task syz-executor318/5171

CPU: 0 PID: 5171 Comm: syz-executor318 Not tainted 6.10.0-rc2-syzkaller-00010-g2ab795141095 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 btrfs_qgroup_inherit+0x42e/0x2e20 fs/btrfs/qgroup.c:3277
 create_pending_snapshot+0x1359/0x29b0 fs/btrfs/transaction.c:1854
 create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1922
 btrfs_commit_transaction+0xf20/0x3740 fs/btrfs/transaction.c:2382
 create_snapshot+0x6a1/0x9e0 fs/btrfs/ioctl.c:875
 btrfs_mksubvol+0x58f/0x710 fs/btrfs/ioctl.c:1029
 btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1075
 __btrfs_ioctl_snap_create+0x387/0x4b0 fs/btrfs/ioctl.c:1340
 btrfs_ioctl_snap_create_v2+0x1f2/0x3a0 fs/btrfs/ioctl.c:1422
 btrfs_ioctl+0x99e/0xc60
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcbf1992509
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcbf1928218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fcbf1a1f618 RCX: 00007fcbf1992509
RDX: 0000000020000280 RSI: 0000000050009417 RDI: 0000000000000003
RBP: 00007fcbf1a1f610 R08: 00007ffea1298e97 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fcbf19eb660
R13: 00000000200002b8 R14: 00007fcbf19e60c0 R15: 0030656c69662f2e
 </TASK>

And it also pinned it down to this commit:

commit b5357cb268c41b4e2b7383d2759fc562f5b58c33
Author: Qu Wenruo <wqu@suse.com>
Date:   Sat Apr 20 07:50:27 2024 +0000

    btrfs: qgroup: do not check qgroup inherit if qgroup is disabled

[CAUSE]
That offending commit skips the whole qgroup inherit check if qgroup is
not enabled.

But that also skips the very basic checks like
num_ref_copies/num_excl_copies and the structure size checks.

Meaning if a qgroup enable/disable race is happening at the background,
and we pass a btrfs_qgroup_inherit structure when the qgroup is
disabled, the check would be completely skipped.

Then at the time of transaction commitment, qgroup is re-enabled and
btrfs_qgroup_inherit() is going to use the incorrect structure and
causing the above KASAN error.

[FIX]
Make btrfs_qgroup_check_inherit() only skip the source qgroup checks.
So that even if invalid btrfs_qgroup_inherit structure is passed in, we
can still reject invalid ones no matter if qgroup is enabled or not.

Furthermore we do already have an extra safenet inside
btrfs_qgroup_inherit(), which would just ignore invalid qgroup sources,
so even if we only skip the qgroup source check we're still safe.

Reported-by: syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com
Fixes: b5357cb268c4 ("btrfs: qgroup: do not check qgroup inherit if qgroup is disabled")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 3edbe5bb19c6..45f4facc6f96 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3166,8 +3166,6 @@ int btrfs_qgroup_check_inherit(struct btrfs_fs_info *fs_info,
 			       struct btrfs_qgroup_inherit *inherit,
 			       size_t size)
 {
-	if (!btrfs_qgroup_enabled(fs_info))
-		return 0;
 	if (inherit->flags & ~BTRFS_QGROUP_INHERIT_FLAGS_SUPP)
 		return -EOPNOTSUPP;
 	if (size < sizeof(*inherit) || size > PAGE_SIZE)
@@ -3188,6 +3186,14 @@ int btrfs_qgroup_check_inherit(struct btrfs_fs_info *fs_info,
 	if (size != struct_size(inherit, qgroups, inherit->num_qgroups))
 		return -EINVAL;
 
+	/*
+	 * Skip the inherit source qgroups check if qgroup is not enabled.
+	 * Qgroup can still be later enabled causing problems, but in that case
+	 * btrfs_qgroup_inherit() would just ignore those invalid ones.
+	 */
+	if (!btrfs_qgroup_enabled(fs_info))
+		return 0;
+
 	/*
 	 * Now check all the remaining qgroups, they should all:
 	 *
-- 
2.45.2


