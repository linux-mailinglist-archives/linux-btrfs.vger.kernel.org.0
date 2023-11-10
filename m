Return-Path: <linux-btrfs+bounces-72-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA0E7E849C
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Nov 2023 21:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669DD1C20B4C
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Nov 2023 20:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D553C08B;
	Fri, 10 Nov 2023 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T7yezgZ3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC33B780
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Nov 2023 20:45:18 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8445279
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Nov 2023 12:45:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 100191F8BD;
	Fri, 10 Nov 2023 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1699649116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xoT4pUKg1s0hiaFkzWUp1fPgYX4s4zFhfKWt4WpSplk=;
	b=T7yezgZ3KIukHWRz7PFt+c4bBFVXgkpsZsXEkPNOAZ2up31ipOEn/65JW1uSWXN5hVZKK1
	vgeDO687SVvqXaMIv3GgJsGH8T6NbxJg6dje1JthKhE9BRa04QHreuQfQRaEF6w1oTuA2G
	Mfl1Ip+XZtd6dx9NGY+48XI6J4QUmaA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3D4E13398;
	Fri, 10 Nov 2023 20:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mWvkK1qWTmVKeQAAMHmgww
	(envelope-from <wqu@suse.com>); Fri, 10 Nov 2023 20:45:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: do not abort transaction if there is already an existing qgroup
Date: Sat, 11 Nov 2023 07:14:57 +1030
Message-ID: <b305a5b0228b40fc62923b0133957c72468600de.1699649085.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[BUG]
Syzbot reported a regression that after commit 6ed05643ddb1 ("btrfs:
create qgroup earlier in snapshot creation") we can trigger transaction
abort during subvolume creation:

  ------------[ cut here ]------------
  BTRFS: Transaction aborted (error -17)
  WARNING: CPU: 0 PID: 5057 at fs/btrfs/transaction.c:1778 create_pending_snapshot+0x25f4/0x2b70 fs/btrfs/transaction.c:1778
  Modules linked in:
  CPU: 0 PID: 5057 Comm: syz-executor225 Not tainted 6.6.0-syzkaller-15365-g305230142ae0 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
  RIP: 0010:create_pending_snapshot+0x25f4/0x2b70 fs/btrfs/transaction.c:1778
  Call Trace:
   <TASK>
   create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1967
   btrfs_commit_transaction+0xf1c/0x3730 fs/btrfs/transaction.c:2440
   create_snapshot+0x4a5/0x7e0 fs/btrfs/ioctl.c:845
   btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:995
   btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1041
   __btrfs_ioctl_snap_create+0x344/0x460 fs/btrfs/ioctl.c:1294
   btrfs_ioctl_snap_create+0x13c/0x190 fs/btrfs/ioctl.c:1321
   btrfs_ioctl+0xbbf/0xd40
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:871 [inline]
   __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
   do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
   entry_SYSCALL_64_after_hwframe+0x63/0x6b
  RIP: 0033:0x7f2f791127b9
   </TASK>

[CAUSE]
The error number is -EEXIST, which can happen for qgroup if there is
already an existing qgroup and then we're trying to create a subvolume
for it.

[FIX]
In that case, we can continue creating the subvolume, although it may
lead to qgroup inconsistency, it's not so critical to abort the current
transaction.

So in this case, we can just ignore the non-critical errors, mostly -EEXIST
(there is already a qgroup).

Reported-by: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
Fixes: 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot creation")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 9694a3ca1739..7af9665bebae 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1774,7 +1774,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 
 	ret = btrfs_create_qgroup(trans, objectid);
-	if (ret) {
+	if (ret && ret != -EEXIST) {
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
 	}
-- 
2.42.1


