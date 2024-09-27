Return-Path: <linux-btrfs+bounces-8310-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6AB988C82
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Sep 2024 00:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D0BEB2154D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 22:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED90D1B3742;
	Fri, 27 Sep 2024 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GeGHa7XA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GeGHa7XA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C791B3737
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727476584; cv=none; b=mvdBLJUPT7jJw7T7ljpu7BKg95FPPz8P1oxPoDjfZheEE7Y63oeGjlpa2pE/DiDUGQpgRH6Bi3YLzJEaW+p/MbOBxVesGoYth6WXyYoct7yoIipVEtq80lF38hnHr1hflAFS5xxN8LguqR1NtG83kHR2pqYfvrbL5zgsIDWMfSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727476584; c=relaxed/simple;
	bh=btHVR/PqrMDS77a9iwa+uCrFlUxJ41+oVa7h1IhHqvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ToMqA2xj8zZclIAd+8fEIMzo6jXvlCUI00q+RTWSSWkad/dLEglA3x8v+5L/VENFq5G6ycoHcMbPrhTwWVsZvir4381yxJr9GugahauMDClUwibVX+/VL8uejrglXDJyQ/lebZFHkulGRJDrFsgeKcWRAOO6/ms0kRcMLtyD9ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GeGHa7XA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GeGHa7XA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B70D1F396;
	Fri, 27 Sep 2024 22:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727476577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KU3F8NaOw9uOHjCYuaYBkvPv+QNhBmCf7OSZarrkyIY=;
	b=GeGHa7XAg0HhFf4SFDduz6TUTrhQGC9mtQSqXz8uO0h2QEXuzidQP748urud5in0pEQFIU
	7l7ym2YWNRXs2YNBrsQAMtIZn+oXC1r8qiJxtL9GA+dNut5BHW90hNaxNPgTZXH0THNjen
	Lg47cqs17IW7GeD+oB/Ag6iw1e1MY34=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727476577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KU3F8NaOw9uOHjCYuaYBkvPv+QNhBmCf7OSZarrkyIY=;
	b=GeGHa7XAg0HhFf4SFDduz6TUTrhQGC9mtQSqXz8uO0h2QEXuzidQP748urud5in0pEQFIU
	7l7ym2YWNRXs2YNBrsQAMtIZn+oXC1r8qiJxtL9GA+dNut5BHW90hNaxNPgTZXH0THNjen
	Lg47cqs17IW7GeD+oB/Ag6iw1e1MY34=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F48B1386E;
	Fri, 27 Sep 2024 22:36:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z/BqBGAz92a6KQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 27 Sep 2024 22:36:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: syzbot+283673dbc38527ef9f3d@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: fix a NULL pointer dereference when failed to start a new trasacntion
Date: Sat, 28 Sep 2024 08:05:58 +0930
Message-ID: <c3663ebd875fb3576710f61aefedc25bf452d141.1727476551.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.1
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
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[283673dbc38527ef9f3d];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
Syzbot reported a NULL pointer dereference with the following crash:

FAULT_INJECTION: forcing a failure.
 start_transaction+0x830/0x1670 fs/btrfs/transaction.c:676
 prepare_to_relocate+0x31f/0x4c0 fs/btrfs/relocation.c:3642
 relocate_block_group+0x169/0xd20 fs/btrfs/relocation.c:3678
...
BTRFS info (device loop0): balance: ended with status: -12
Oops: general protection fault, probably for non-canonical address 0xdffffc00000000cc: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000660-0x0000000000000667]
RIP: 0010:btrfs_update_reloc_root+0x362/0xa80 fs/btrfs/relocation.c:926
Call Trace:
 <TASK>
 commit_fs_roots+0x2ee/0x720 fs/btrfs/transaction.c:1496
 btrfs_commit_transaction+0xfaf/0x3740 fs/btrfs/transaction.c:2430
 del_balance_item fs/btrfs/volumes.c:3678 [inline]
 reset_balance_state+0x25e/0x3c0 fs/btrfs/volumes.c:3742
 btrfs_balance+0xead/0x10c0 fs/btrfs/volumes.c:4574
 btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3673
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
---[ end trace 0000000000000000 ]---

[CAUSE]
The allocation failure happens at the start_transaction() inside
prepare_to_relocate(), and during the error handling we call
unset_reloc_control(), which makes fs_info->balance_ctl to be NULL.

Then we continue the error path cleanup in btrfs_balance() by calling
reset_balance_state() which will call del_balance_item() to fully delete
the balance item in the root tree.

However during the small window between set_reloc_contrl() and
unset_reloc_control(), we can have a subvolume tree update and created a
reloc_root for that subvolume.

Then we go into the final btrfs_commit_transaction() of
del_balance_item(), and into btrfs_update_reloc_root() inside
commit_fs_roots().

That function checks if fs_info->reloc_ctl is in the merge_reloc_tree
stage, but since fs_info->reloc_ctl is NULL, it results a NULL pointer
dereference.

[FIX]
Just add extra check on fs_info->reloc_ctl inside
btrfs_update_reloc_root(), before checking
fs_info->reloc_ctl->merge_reloc_tree.

That DEAD_RELOC_TREE handling is to prevent further modification to the
reloc tree during merge stage, but since there is no reloc_ctl at all,
we do not need to bother that.

Reported-by: syzbot+283673dbc38527ef9f3d@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/66f6bfa7.050a0220.38ace9.0019.GAE@google.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index cf1dfeaaf2d8..f3834f8d26b4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -856,7 +856,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	btrfs_grab_root(reloc_root);
 
 	/* root->reloc_root will stay until current relocation finished */
-	if (fs_info->reloc_ctl->merge_reloc_tree &&
+	if (fs_info->reloc_ctl && fs_info->reloc_ctl->merge_reloc_tree &&
 	    btrfs_root_refs(root_item) == 0) {
 		set_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
 		/*
-- 
2.46.1


