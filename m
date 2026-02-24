Return-Path: <linux-btrfs+bounces-21870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBYbCNKenWnwQgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21870-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 13:51:30 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4195E1873BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 13:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CED68300E19E
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 12:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0311939A7FF;
	Tue, 24 Feb 2026 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JbkKXt2F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8CAE555
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937482; cv=none; b=eE2GqoSCPDDhQXR92lIgkUAZMAE5lUiFNVBxCnhbX6G3UhoGF5yxD8iN9hmTWZ19E/6qK4PiGx7oTgBASR2PBJ53PDMruo42xl2r6g5cv/GVtfJ1xaiPaH+ZrQ0plenUPA0zPtJvwMVCzBEoxk5FwwYRBS5T75pp1GXQ1trs6Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937482; c=relaxed/simple;
	bh=gi3jJC6yjVQqNxSW4LBtXBmJes0lvGVMYbqKK9FbNxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QGQsreGmhtPduGGcfv3RBi+PDG6RwlLYTo48lgAMi9/d6rU/Rkpiz9slJIXp97lhSAcjhyI80Op2/tQBmukVTch1YrK50s10yLt7lT5GFRRR5fxkXNsaMNERyYi21UQihuaMVANk6Vq813AmLGEgu4LKHa9vy2uZ21Ush0UoR5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JbkKXt2F; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771937481; x=1803473481;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gi3jJC6yjVQqNxSW4LBtXBmJes0lvGVMYbqKK9FbNxI=;
  b=JbkKXt2FxOl2YzIo4zxjHtmphcMk2h7fRxRDxKImoISDAcmWXpTh0BAe
   hs8ZdlnfWi8oMK0fI1BLePgotRv5ZGEn2CyZHbLwHgkdrg154M4x2l8XE
   JnhKVpJDlLDkNKqhX5gXCsPhK1eZlkKwm6ECes0tC0XCbYuaJctuQ5RRk
   8e02bCfOisnEoNOtNuo0FgXJcKsyrfOXF6L0/V5pzQqSHJimvqGuJoFct
   XoLCNL03CP/719/EhfRbhQDtK4O934SU95/2b3EGlG2Y3WMO+1iXfaY/q
   UMQgR0ruflsh3H3b7ffk1GZvLWR3CH1mr3BrxMFakYegxF05ayFK++TaM
   A==;
X-CSE-ConnectionGUID: sKg3F/S/TQmhGaN3euqH4g==
X-CSE-MsgGUID: ZdQ7FXa5TuOMr8NDKajqfA==
X-IronPort-AV: E=Sophos;i="6.21,308,1763395200"; 
   d="scan'208";a="141881877"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2026 20:51:21 +0800
IronPort-SDR: 699d9ec8_OLkOw+A7bjtTDp0qUb0PzHZ3zrxhAWgyWU4/vspdpjC0Vih
 7BH07s2SR30pQleo7WcMDEiicn3uxbDgj6KKLFQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Feb 2026 04:51:20 -0800
WDCIronportException: Internal
Received: from wdap-1nkveyfids.ad.shared (HELO neo.wdc.com) ([10.224.28.151])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2026 04:51:19 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: zoned: move btrfs_zoned_reserve_data_reloc_bg after kthread start
Date: Tue, 24 Feb 2026 13:51:13 +0100
Message-ID: <20260224125113.14831-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21870-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4195E1873BD
X-Rspamd-Action: no action

btrfs_zoned_reserve_data_reloc_bg() is called on each mount of a file
system and allocates a new block-group, to assign it to be the dedicated
relocation target, if no pre-existing usable block-group for this task is
found.

If for some reason the transaction is aborted, btrfs_end_transaction()
will wake up the transaction kthread. But the transaction kthread is not
yet initialized at the time btrfs_zoned_reserve_data_reloc_bg() is
called, leading to the follwing NULL-pointer dereference:

 RSP: 0018:ffffc9000c617c98 EFLAGS: 00010046
 RAX: 0000000000000000 RBX: 000000000000073c RCX: 0000000000000002
 RDX: 0000000000000001 RSI: 0000000000000003 RDI: 0000000000000001
 RBP: 0000000000000207 R08: ffffffff8223c71d R09: 0000000000000635
 R10: ffff888108588000 R11: 0000000000000003 R12: 0000000000000003
 R13: 000000000000073c R14: 0000000000000000 R15: ffff888114dd6000
 FS:  00007f2993745840(0000) GS:ffff8882b508d000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000000000073c CR3: 0000000121a82006 CR4: 0000000000770eb0
 PKRU: 55555554
 Call Trace:
  <TASK>
  try_to_wake_up (./include/linux/spinlock.h:557 kernel/sched/core.c:4106)
  __btrfs_end_transaction (fs/btrfs/transaction.c:1115 (discriminator 2))
  btrfs_zoned_reserve_data_reloc_bg (fs/btrfs/zoned.c:2840)
  open_ctree (fs/btrfs/disk-io.c:3588)
  btrfs_get_tree.cold (fs/btrfs/super.c:982 fs/btrfs/super.c:1944 fs/btrfs/super.c:2087 fs/btrfs/super.c:2121)
  vfs_get_tree (fs/super.c:1752)
  __do_sys_fsconfig (fs/fsopen.c:231 fs/fsopen.c:295 fs/fsopen.c:473)
  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:131)
 RIP: 0033:0x7f299392740e

Move the call to btrfs_zoned_reserve_data_reloc_bg() after the
transaction_kthread has been initialized to fix this problem.

Fixes: 694ce5e143d6 ("btrfs: zoned: reserve data_reloc block group on mount")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
This supersedes https://lore.kernel.org/r/20260223143820.89931-1-johannes.thumshirn@wdc.com

 fs/btrfs/disk-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 73ddde973532..428b135a890d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3583,7 +3583,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		}
 	}
 
-	btrfs_zoned_reserve_data_reloc_bg(fs_info);
 	btrfs_free_zone_cache(fs_info);
 
 	btrfs_check_active_zone_reservation(fs_info);
@@ -3611,6 +3610,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_cleaner;
 	}
 
+	btrfs_zoned_reserve_data_reloc_bg(fs_info);
+
 	ret = btrfs_read_qgroup_config(fs_info);
 	if (ret)
 		goto fail_trans_kthread;
-- 
2.53.0


