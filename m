Return-Path: <linux-btrfs+bounces-2853-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CF386AF81
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 13:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45F88B227EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD4014DFEC;
	Wed, 28 Feb 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mIYc67L1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F21487DF
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Feb 2024 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124807; cv=none; b=ZVsFGAAzcmQ9LdULWhK4E849susw4aBZSLg5MlgCLY/eufzxO3xKY+p669Hl9SyuOSNi2UQnHwqT59XZqurDj18/x+wds//UEyCJFaPj34FFXAy+wON+kgZ4zLw+V8wIbLcVGGUodJXQ5foMAyKlZnNd/uyokASovabn54QyJyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124807; c=relaxed/simple;
	bh=m4iS0znK0haR4YWhGkyYSM/XF0Su8IWMNyUZmWLX9SY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmI8mhhWoZNHxpRGcJBUfS8Ql5WTEuULoyyO51m35XaKxTLBP3VVKQpCAZTF2x4rPqlgvCfp0dJarSsAr2fKnQp05Aity3k+JGsKJUxtOmnmd4Q1ehu/OnpdG8vUWZJ3LSfyWF+N+Cf52oLmT7u7Qk3ImIzKeMEL1o7Ntzz57v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mIYc67L1; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709124805; x=1740660805;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m4iS0znK0haR4YWhGkyYSM/XF0Su8IWMNyUZmWLX9SY=;
  b=mIYc67L126SDhxhRuq+rT4U0weASw3C2/yx9lrFwQ2FGfRrec8367SPt
   eydS0LQ0MSYL3Wq82hc58cr4iG117hZ00YUW4v8b+6VcNEX5QwT9MYWti
   qGpbgrGxd+zbCu55Ce4NBviCaFj46mVTcn7eYFKsOpS31qVN/WdKHdsrf
   gOkmpQcJJL4IUkuIS1LnUv/iMkWGxM8Uv9+gnUJ/5ZHEX7geOnijqkizx
   d8GOwCE/UxCu/cB4iOnWBVGY/B3XXQaJJa3Q2cx66saMPeXtjVNXZDbVv
   WW5l0aX9maZXhcuDCyQJZo+dY4mgitQaF99ZUzrpFHL+K79GuTymw6dxF
   A==;
X-CSE-ConnectionGUID: i5v2KAyfS2aaLIiAHDNgEA==
X-CSE-MsgGUID: 9fd4WtiKQVWY0QSus0aT6A==
X-IronPort-AV: E=Sophos;i="6.06,190,1705334400"; 
   d="scan'208";a="10253666"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2024 20:53:17 +0800
IronPort-SDR: 2I7qKESG+fXBtsnuMTA7ubEQCB0Tw5I7hVY7mTbRMlrPj+QmRvqoCjBqspkiadXbPbT0nY+URP
 QVwfx6+Eme0Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2024 03:56:55 -0800
IronPort-SDR: 5pPX9esEwY0rfB+fbE+x43ydm0XHc55gQHwE+k/1AWpnP5vlSAfaValzk+wuRZeu7EmtcA6s0X
 H9yPY214AilQ==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.108])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Feb 2024 04:53:16 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: prevent extent buffer header to be cleared
Date: Wed, 28 Feb 2024 21:53:03 +0900
Message-ID: <3f4f2a0ff1a6c818050434288925bdcf3cd719e5.1709124777.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Btrfs clears the content of an extent buffer marked as
EXTENT_BUFFER_ZONED_ZEROOUT before the bio submission. This mechanism is
introduced to prevent a write hole of an extent buffer, which is once
allocated, marked dirty, but turns out unnecessary and cleaned up within
one transaction operation.

However, btrfs_free_tree_block() can be called on an extent buffer after
its content is cleared. Then, it inserts a faulty delayed reference entry,
which makes the FS corrupted.

This bug can be triggered running generic/013 several (~200) times. It
failed as following:

    ------------[ cut here ]------------
    WARNING: CPU: 9 PID: 29834 at fs/btrfs/extent-tree.c:3248 __btrfs_free_extent.isra.0+0x604/0x1330 [btrfs]
    Modules linked in: dm_flakey algif_hash af_alg xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_addrtype iptable_filter ip_tables br_netfilter bridge stp llc overlay sunrpc kvm_amd kvm irqbypass rapl acpi_cpufreq ipmi_ssif i2c_piix4 k10temp btrfs ipmi_si blake2b_generic ipmi_devintf xor ipmi_msghandler raid6_pq bfq loop dm_mod zram bnxt_en ccp pkcs8_key_parser asn1_decoder public_key oid_registry fuse msr ipv6
    CPU: 9 PID: 29834 Comm: fsstress Not tainted 6.8.0-rc4-BTRFS-ZNS+ #403
    Hardware name: Supermicro Super Server/H12SSL-NT, BIOS 2.0 02/22/2021
    RIP: 0010:__btrfs_free_extent.isra.0+0x604/0x1330 [btrfs]
    Code: 8b 3f e8 bf 69 00 00 48 8b 7d 60 45 8b 4f 40 49 89 d8 8b 54 24 40 4c 89 e9 48 c7 c6 30 64 65 a0 e8 61 fb 0d 00 e9 8f fd ff ff <0f> 0b f0 48 0f ba 28 02 41 b8 00 00 00 00 0f 83 86 04 00 00 b9 8b
    RSP: 0018:ffffc900090cfb80 EFLAGS: 00010246
    RAX: ffff888365c719d8 RBX: 0000000f9677c000 RCX: 0000000000000001
    RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
    RBP: ffff8889a044b220 R08: 0000000000000000 R09: 0000000000000004
    R10: 0000000000000000 R11: 00000000ffffffff R12: 0000000000000001
    R13: ffff888ad87a4c98 R14: 0000000000000005 R15: ffff888a0c7d2a80
    FS:  00007f823f5f7740(0000) GS:ffff889fcea40000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000560ce0610b38 CR3: 0000000a907ec000 CR4: 0000000000350ef0
    Call Trace:
     <TASK>
     ? __btrfs_free_extent.isra.0+0x604/0x1330 [btrfs]
     ? __warn+0x81/0x170
     ? __btrfs_free_extent.isra.0+0x604/0x1330 [btrfs]
     ? report_bug+0x18d/0x1c0
     ? handle_bug+0x3c/0x70
     ? exc_invalid_op+0x13/0x60
     ? asm_exc_invalid_op+0x16/0x20
     ? __btrfs_free_extent.isra.0+0x604/0x1330 [btrfs]
     ? srso_return_thunk+0x5/0x5f
     ? rcu_is_watching+0xd/0x40
     ? srso_return_thunk+0x5/0x5f
     ? lock_release+0x1e5/0x280
     __btrfs_run_delayed_refs+0x64c/0x1380 [btrfs]
     ? btrfs_commit_transaction+0x3e/0x12d0 [btrfs]
     btrfs_run_delayed_refs+0x92/0x130 [btrfs]
     btrfs_commit_transaction+0xa2/0x12d0 [btrfs]
     ? srso_return_thunk+0x5/0x5f
     ? srso_return_thunk+0x5/0x5f
     ? rcu_is_watching+0xd/0x40
     ? srso_return_thunk+0x5/0x5f
     ? lock_release+0x1e5/0x280
     btrfs_sync_file+0x532/0x660 [btrfs]
     __x64_sys_fsync+0x37/0x60
     do_syscall_64+0x79/0x1a0
     entry_SYSCALL_64_after_hwframe+0x6e/0x76
    RIP: 0033:0x7f823f6f8400
    Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d e1 d1 0d 00 00 74 17 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
    RSP: 002b:00007ffe3c26e9f8 EFLAGS: 00000202 ORIG_RAX: 000000000000004a
    RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f823f6f8400
    RDX: 0000000000000193 RSI: 0000560cdfcdb048 RDI: 0000000000000003
    RBP: 00000000000002e6 R08: 0000000000000007 R09: 00007ffe3c26ea0c
    R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe3c26ea10
    R13: 028f5c28f5c28f5c R14: 8f5c28f5c28f5c29 R15: 0000560cdfcd7180
     </TASK>
    irq event stamp: 0
    hardirqs last  enabled at (0): [<0000000000000000>] 0x0
    hardirqs last disabled at (0): [<ffffffff810e5e0e>] copy_process+0xb0e/0x1e00
    softirqs last  enabled at (0): [<ffffffff810e5e0e>] copy_process+0xb0e/0x1e00
    softirqs last disabled at (0): [<0000000000000000>] 0x0
    ---[ end trace 0000000000000000 ]---
    ------------[ cut here ]------------
    BTRFS: Transaction aborted (error -117)
    WARNING: CPU: 9 PID: 29834 at fs/btrfs/extent-tree.c:3249 __btrfs_free_extent.isra.0+0xf8e/0x1330 [btrfs]
    Modules linked in: dm_flakey algif_hash af_alg xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_addrtype iptable_filter ip_tables br_netfilter bridge stp llc overlay sunrpc kvm_amd kvm irqbypass rapl acpi_cpufreq ipmi_ssif i2c_piix4 k10temp btrfs ipmi_si blake2b_generic ipmi_devintf xor ipmi_msghandler raid6_pq bfq loop dm_mod zram bnxt_en ccp pkcs8_key_parser asn1_decoder public_key oid_registry fuse msr ipv6
    CPU: 9 PID: 29834 Comm: fsstress Tainted: G        W          6.8.0-rc4-BTRFS-ZNS+ #403
    Hardware name: Supermicro Super Server/H12SSL-NT, BIOS 2.0 02/22/2021
    RIP: 0010:__btrfs_free_extent.isra.0+0xf8e/0x1330 [btrfs]
    Code: 48 c7 c6 40 5d 65 a0 e8 f0 f1 0d 00 c7 44 24 18 01 00 00 00 e9 ed f7 ff ff be 8b ff ff ff 48 c7 c7 68 5d 65 a0 e8 52 69 c1 e0 <0f> 0b e9 30 fb ff ff 48 8b 45 60 48 05 d8 19 00 00 f0 48 0f ba 28
    RSP: 0018:ffffc900090cfb80 EFLAGS: 00010282
    RAX: 0000000000000000 RBX: 0000000f9677c000 RCX: 0000000000000000
    RDX: 0000000000000002 RSI: ffffffff82464302 RDI: 00000000ffffffff
    RBP: ffff8889a044b220 R08: 0000000000009ffb R09: 00000000ffffdfff
    R10: 00000000ffffdfff R11: ffffffff8264dd80 R12: 0000000000000001
    R13: ffff888ad87a4c98 R14: 0000000000000005 R15: ffff888a0c7d2a80
    FS:  00007f823f5f7740(0000) GS:ffff889fcea40000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000560ce0610b38 CR3: 0000000a907ec000 CR4: 0000000000350ef0
    Call Trace:
     <TASK>
     ? __btrfs_free_extent.isra.0+0xf8e/0x1330 [btrfs]
     ? __warn+0x81/0x170
     ? __btrfs_free_extent.isra.0+0xf8e/0x1330 [btrfs]
     ? report_bug+0x18d/0x1c0
     ? tick_nohz_tick_stopped+0x12/0x30
     ? srso_return_thunk+0x5/0x5f
     ? handle_bug+0x3c/0x70
     ? exc_invalid_op+0x13/0x60
     ? asm_exc_invalid_op+0x16/0x20
     ? __btrfs_free_extent.isra.0+0xf8e/0x1330 [btrfs]
     ? srso_return_thunk+0x5/0x5f
     ? rcu_is_watching+0xd/0x40
     ? srso_return_thunk+0x5/0x5f
     ? lock_release+0x1e5/0x280
     __btrfs_run_delayed_refs+0x64c/0x1380 [btrfs]
     ? btrfs_commit_transaction+0x3e/0x12d0 [btrfs]
     btrfs_run_delayed_refs+0x92/0x130 [btrfs]
     btrfs_commit_transaction+0xa2/0x12d0 [btrfs]
     ? srso_return_thunk+0x5/0x5f
     ? srso_return_thunk+0x5/0x5f
     ? rcu_is_watching+0xd/0x40
     ? srso_return_thunk+0x5/0x5f
     ? lock_release+0x1e5/0x280
     btrfs_sync_file+0x532/0x660 [btrfs]
     __x64_sys_fsync+0x37/0x60
     do_syscall_64+0x79/0x1a0
     entry_SYSCALL_64_after_hwframe+0x6e/0x76
    RIP: 0033:0x7f823f6f8400
    Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d e1 d1 0d 00 00 74 17 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
    RSP: 002b:00007ffe3c26e9f8 EFLAGS: 00000202 ORIG_RAX: 000000000000004a
    RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f823f6f8400
    RDX: 0000000000000193 RSI: 0000560cdfcdb048 RDI: 0000000000000003
    RBP: 00000000000002e6 R08: 0000000000000007 R09: 00007ffe3c26ea0c
    R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe3c26ea10
    R13: 028f5c28f5c28f5c R14: 8f5c28f5c28f5c29 R15: 0000560cdfcd7180
     </TASK>
    irq event stamp: 0
    hardirqs last  enabled at (0): [<0000000000000000>] 0x0
    hardirqs last disabled at (0): [<ffffffff810e5e0e>] copy_process+0xb0e/0x1e00
    softirqs last  enabled at (0): [<ffffffff810e5e0e>] copy_process+0xb0e/0x1e00
    softirqs last disabled at (0): [<0000000000000000>] 0x0
    ---[ end trace 0000000000000000 ]---
    BTRFS: error (device nvme1n2: state A) in __btrfs_free_extent:3249: errno=-117 Filesystem corrupted
    BTRFS info (device nvme1n2: state EA): forced readonly
    BTRFS info (device nvme1n2: state EA): leaf 66957836288 gen 3873 total ptrs 203 free space 1102 owner 2
    BTRFS info (device nvme1n2: state EA): refs 2 lock_owner 29834 current 29834
            item 0 key (63394947072 168 40960) itemoff 16230 itemsize 53
                    extent refs 1 gen 3835 flags 1
                    ref#0: extent data backref root 5 objectid 552 offset 1802240 count 1
(snip)...
            item 164 key (66948923392 169 0) itemoff 8229 itemsize 33
                    extent refs 1 gen 3872 flags 2
                    ref#0: tree block backref root 2
            item 165 key (66948939776 169 1) itemoff 8196 itemsize 33
                    extent refs 1 gen 3873 flags 2
                    ref#0: tree block backref root 5
            item 166 key (68719476736 168 110592) itemoff 8143 itemsize 53
                    extent refs 1 gen 3841 flags 1
                    ref#0: extent data backref root 5 objectid 440 offset 3100672 count 1
(snip)...
            item 202 key (68722249728 168 110592) itemoff 6177 itemsize 53
                    extent refs 1 gen 3842 flags 1
                    ref#0: extent data backref root 5 objectid 953 offset 5431296 count 1
    BTRFS critical (device nvme1n2: state EA): unable to find ref byte nr 66948939776 parent 66948939776 root 5 owner 0 offset 0 slot 166
    BTRFS error (device nvme1n2: state EA): failed to run delayed ref for logical 66948939776 num_bytes 16384 type 182 action 2 ref_mod 1: -2
    BTRFS: error (device nvme1n2: state EA) in btrfs_run_delayed_refs:2246: errno=-2 No such entry
    BTRFS warning (device nvme1n2: state EA): Skipping commit of aborted transaction.
    BTRFS: error (device nvme1n2: state EA) in cleanup_transaction:2006: errno=-2 No such entry

This happens maybe because clearing the contents is too early. It should
clear the content after all the reference to the node is dropped.

Addressing that root cause needs more time. Until that, leave the extent
buffer header intact, so that we can add a proper delayed reference entry.

Fixes: aa6313e6ff2b ("btrfs: zoned: don't clear dirty flag of extent buffer")
Link: https://lore.kernel.org/linux-btrfs/oadvdekkturysgfgi4qzuemd57zudeasynswurjxw3ocdfsef6@sjyufeugh63f/
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a2e45ed6ef14..8aaed8719394 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -278,7 +278,9 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 	 * ordering of I/O without unnecessarily writing out data.
 	 */
 	if (test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags)) {
-		memzero_extent_buffer(eb, 0, eb->len);
+		const unsigned long header_size = sizeof(struct btrfs_header);
+
+		memzero_extent_buffer(eb, header_size, eb->len - header_size);
 		return BLK_STS_OK;
 	}
 
-- 
2.44.0


