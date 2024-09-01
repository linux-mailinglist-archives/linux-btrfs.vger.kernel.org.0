Return-Path: <linux-btrfs+bounces-7710-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545C09675B8
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2024 11:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E4AB2196C
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2024 09:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E219B1448CD;
	Sun,  1 Sep 2024 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=beware.dropbear.id.au header.i=@beware.dropbear.id.au header.b="vXlPa2jg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp70.iad3a.emailsrvr.com (smtp70.iad3a.emailsrvr.com [173.203.187.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2147C219F6
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Sep 2024 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725182215; cv=none; b=Xs0ijfavdii5GSWgqkiP6uT3zX5M7x7jVrDNdm7pe+4JPrRyY11xhaE7gGrk5QD9RyvTNtfBp7U1qgZwxOYAffTJP34kWOWxDWZJtH0DkrB9h5fBKG+OGpyIFSz/1o66EtoX3BWHB9q5+n8/KTKfLPAzdGYniG1RIzLM7zgTQCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725182215; c=relaxed/simple;
	bh=pPNgaO+NNVBWBJrUC1MZB5WPnl0cEvEjgKgXXxMlsac=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=ExnItrA40zUYFe5tIjnisZVXbaUl8y+rgx5721LcNg39kf+WwN00moRp2GW+cLSCZOikVwK3Qhh6FH5HC3l8OO8woG5u5CKCBLsXU0MvNNdnHUTy2uUTCoSF7pOg/R/Z8ZkIIf027CPfJneGfTk2ikeoZQZS/5LxfpchkkphaQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beware.dropbear.id.au; spf=pass smtp.mailfrom=beware.dropbear.id.au; dkim=pass (1024-bit key) header.d=beware.dropbear.id.au header.i=@beware.dropbear.id.au header.b=vXlPa2jg; arc=none smtp.client-ip=173.203.187.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beware.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beware.dropbear.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=beware.dropbear.id.au; s=20201218-7owj1hyf; t=1725181663;
	bh=pPNgaO+NNVBWBJrUC1MZB5WPnl0cEvEjgKgXXxMlsac=;
	h=Subject:From:To:Date:From;
	b=vXlPa2jgwyCgVHAO4D+/3p8HNMUNejhYC7x0zJppcc+c0agHj//BF9MXMkIezz8Yl
	 yqjVvrBXqVSKKWqMTL00V3un6DvcbWCAa7Bf5xVq9LCJgyadlW56bcLp/aWFyLW5Ye
	 bIRdUj4Bm0utTly2D3jjMUgYjpDWNAlfWQ89MWZw=
X-Auth-ID: fergus@beware.dropbear.id.au
Received: by smtp1.relay.iad3a.emailsrvr.com (Authenticated sender: fergus-AT-beware.dropbear.id.au) with ESMTPSA id 233D53F2B
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Sep 2024 05:07:42 -0400 (EDT)
Message-ID: <b9b86b32095ba924fb8c7eec4d8ec024113d9ff4.camel@beware.dropbear.id.au>
Subject: Btrfs balance broke filesystem
From: Fergus Dall <fergus@beware.dropbear.id.au>
To: linux-btrfs@vger.kernel.org
Date: Sun, 01 Sep 2024 18:37:40 +0930
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Classification-ID: 43c285fb-939b-463d-898e-e438dc4e334e-1-1

I recently tried to add a new disk to my existing, nearly full, btrfs
filesystem. I then tried running "btrfs balance -mconvert=3Draid1,soft"
to duplicate the metadata to the new disk and, like seemingly many
people trying similar things, got an ENOSPC error followed by the
filesystem becoming read-only.

The standard advice for this situation seems to be to add a new device
to the filesystem, then mount with "-o skip_balance", then cancel the
existing balance operation, and finally run "btrfs balance -musage=3D0"
to clear the allocated but unused metadata. However, in my case the
filesystem encounters an error and becomes read-only during mount, and
all these operations seem to require a read-write filesystem. There
don't appear to be any mount options to skip the failing operation, or
offline tools that can perform the necessary operations on an unmounted
filesystem.

Additionally, the stack trace from the aborted transaction in the
kernel logs appears different that has been previously reported, so
this may be a new, or previously unreported, bug.

Is there any way to recover this filesystem, short of copying all the
files somewhere else?

Kernel version is 6.10.7-arch1-1, dmesg and btrfs allocation
information below:

[   42.886920] BTRFS warning (device dm-1 state M): Skipping commit of
aborted transaction.
[   42.886924] ------------[ cut here ]------------
[   42.886925] BTRFS: Transaction aborted (error -28)
[   42.886933] WARNING: CPU: 0 PID: 595 at fs/btrfs/transaction.c:1999
btrfs_commit_transaction.cold+0x103/0x356 [btrfs]
[   42.886975] Modules linked in: ip6t_REJECT nf_reject_ipv6 xt_hl
ip6t_rt ipt_REJECT nf_reject_ipv4 xt_LOG nf_log_syslog xt_comment
xt_limit xt_addrtype xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter i2c_dev
crypto_user loop nfnetlink ip_tables x_tables btrfs blake2b_generic
libcrc32c crc32c_generic xor raid6_pq dm_crypt cbc encrypted_keys
trusted asn1_encoder tee hid_generic usbhid dm_mod crct10dif_pclmul
crc32_pclmul crc32c_intel polyval_clmulni polyval_generic gf128mul
ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 nvme
aesni_intel nvme_core crypto_simd ccp cryptd xhci_pci nvme_auth
xhci_pci_renesas
[   42.887019] CPU: 0 PID: 595 Comm: btrfs-transacti Not tainted
6.10.7-arch1-1 #1 2b2df360fbb0436393dc89f6589e9eeea2964ecb
[   42.887022] Hardware name: To Be Filled By O.E.M. X570 Phantom
Gaming 4/X570 Phantom Gaming 4, BIOS P5.60 01/18/2024
[   42.887024] RIP: 0010:btrfs_commit_transaction.cold+0x103/0x356
[btrfs]
[   42.887055] Code: f3 ff 4c 89 ef e8 c3 15 09 ce e9 a5 f3 f3 ff 0f 0b
e9 6e ff ff ff 45 31 c0 eb 9f 44 89 f6 48 c7 c7 10 c0 81 c0 e8 83 7b 34
cd <0f> 0b eb 86 49 3b 9c 24 40 02 00 00 75 2a c7 43 20 03 00 00 00 48
[   42.887057] RSP: 0018:ffffbfa78430fe30 EFLAGS: 00010282
[   42.887059] RAX: 0000000000000000 RBX: ffff9d080c959e00 RCX:
0000000000000027
[   42.887061] RDX: ffff9d16fea219c8 RSI: 0000000000000001 RDI:
ffff9d16fea219c0
[   42.887062] RBP: ffff9d080d0c9150 R08: 0000000000000000 R09:
ffffbfa78430fcb0
[   42.887064] R10: ffffffff8fab21e8 R11: 0000000000000003 R12:
ffff9d080eb3e000
[   42.887065] R13: ffff9d080d0c90a0 R14: 00000000ffffffe4 R15:
ffff9d080d0c90a0
[   42.887066] FS:  0000000000000000(0000) GS:ffff9d16fea00000(0000)
knlGS:0000000000000000
[   42.887068] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.887070] CR2: 00007f01caa5a168 CR3: 0000000106234000 CR4:
0000000000f50ef0
[   42.887071] PKRU: 55555554
[   42.887073] Call Trace:
[   42.887075]  <TASK>
[   42.887076]  ? btrfs_commit_transaction.cold+0x103/0x356 [btrfs
f3cde2e054b00a9dbda089e3ed25c43789a01aae]
[   42.887103]  ? __warn.cold+0x8e/0xe8
[   42.887107]  ? btrfs_commit_transaction.cold+0x103/0x356 [btrfs
f3cde2e054b00a9dbda089e3ed25c43789a01aae]
[   42.887134]  ? report_bug+0xff/0x140
[   42.887138]  ? handle_bug+0x3c/0x80
[   42.887141]  ? exc_invalid_op+0x17/0x70
[   42.887143]  ? asm_exc_invalid_op+0x1a/0x20
[   42.887149]  ? btrfs_commit_transaction.cold+0x103/0x356 [btrfs
f3cde2e054b00a9dbda089e3ed25c43789a01aae]
[   42.887176]  ? __pfx_autoremove_wake_function+0x10/0x10
[   42.887181]  transaction_kthread+0x159/0x1c0 [btrfs
f3cde2e054b00a9dbda089e3ed25c43789a01aae]
[   42.887216]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs
f3cde2e054b00a9dbda089e3ed25c43789a01aae]
[   42.887244]  kthread+0xd2/0x100
[   42.887247]  ? __pfx_kthread+0x10/0x10
[   42.887250]  ret_from_fork+0x34/0x50
[   42.887253]  ? __pfx_kthread+0x10/0x10
[   42.887256]  ret_from_fork_asm+0x1a/0x30
[   42.887261]  </TASK>
[   42.887262] ---[ end trace 0000000000000000 ]---
[   42.887264] BTRFS info (device dm-1 state MA): dumping space info:
[   42.887267] BTRFS info (device dm-1 state MA): space_info DATA has
50215018496 free, is not full
[   42.887269] BTRFS info (device dm-1 state MA): space_info
total=3D907277959168, used=3D857062809600, pinned=3D0, reserved=3D0, may_us=
e=3D0,
readonly=3D131072 zone_unusable=3D0
[   42.887272] BTRFS info (device dm-1 state MA): space_info METADATA
has -537264128 free, is full
[   42.887274] BTRFS info (device dm-1 state MA): space_info
total=3D77317799936, used=3D3742138368, pinned=3D0, reserved=3D0,
may_use=3D537264128, readonly=3D73575661568 zone_unusable=3D0
[   42.887276] BTRFS info (device dm-1 state MA): space_info SYSTEM has
0 free, is not full
[   42.887278] BTRFS info (device dm-1 state MA): space_info
total=3D33554432, used=3D114688, pinned=3D0, reserved=3D0, may_use=3D0,
readonly=3D33439744 zone_unusable=3D0
[   42.887280] BTRFS info (device dm-1 state MA): global_block_rsv:
size 536870912 reserved 536870912
[   42.887282] BTRFS info (device dm-1 state MA): trans_block_rsv: size
0 reserved 0
[   42.887284] BTRFS info (device dm-1 state MA): chunk_block_rsv: size
0 reserved 0
[   42.887285] BTRFS info (device dm-1 state MA): delayed_block_rsv:
size 0 reserved 0
[   42.887287] BTRFS info (device dm-1 state MA): delayed_refs_rsv:
size 0 reserved 0
[   42.887290] BTRFS: error (device dm-1 state MA) in
cleanup_transaction:1999: errno=3D-28 No space left
[   42.887298] BTRFS error (device dm-1 state MA): Error removing
orphan entry, stopping orphan cleanup
[   42.887712] BTRFS error (device dm-1 state EMA): could not do orphan
cleanup -28

$ btrfs filesystem df
Data, single: total=3D844.97GiB, used=3D798.20GiB
System, single: total=3D32.00MiB, used=3D112.00KiB
Metadata, single: total=3D72.01GiB, used=3D3.48GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

$ btrfs filesystem show
Label: none  uuid: 031d5f75-700a-4e42-b4e5-51a2f841d68c
	Total devices 2 FS bytes used 801.69GiB
	devid    1 size 915.01GiB used 915.01GiB path
/dev/mapper/cryptroot-1
	devid    2 size 1.82TiB used 2.00GiB path
/dev/mapper/cryptroot-2

$ btrfs device usage
/dev/mapper/cryptroot-1, ID: 1
   Device size:           915.01GiB
   Device slack:            3.50KiB
   Data,single:           842.97GiB
   Metadata,single:        72.01GiB
   System,single:          32.00MiB
   Unallocated:             1.00MiB

/dev/mapper/cryptroot-2, ID: 2
   Device size:             1.82TiB
   Device slack:              0.00B
   Data,single:             2.00GiB
   Unallocated:             1.82TiB



