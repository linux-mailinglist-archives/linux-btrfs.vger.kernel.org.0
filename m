Return-Path: <linux-btrfs+bounces-7335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB20C95881F
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 15:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9A71C2164E
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 13:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C311F190660;
	Tue, 20 Aug 2024 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wpkg.org header.i=@wpkg.org header.b="OK0qGsCP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.virtall.com (mail.virtall.com [46.4.129.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7800418FC80
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.129.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161420; cv=none; b=Y3iHhv5Lt3CzPNbtMSKSYHy3Mfvkz86fMZ4IUHVuaxyuSsoUORCL5/zwJWRfiIjGKoBFgPIjhg6UU7Bwwl89y5VKQbHEX6dAY5BH4BaFhZPswchqvU4MfM+4xstLiQ/Lhkn69XCkgL2qeL8VR9h9m8SBrY4rv7pRjRuPHA7Mu4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161420; c=relaxed/simple;
	bh=zMi9H4JRvcIWPSe6qFrLXscBy1/4hzYdpvt8inqjGnk=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=IZVRr85ykPDvmlcHywotPkEuFUfrEkUWo8yqoy/zQ5HuW3y8+flb0M2dcNjVD/FjIESljA6uPdno2mAJO8x8tBVAYkdVWJJErH6Pxg7j5I2V+/KfCymcV8jbG3qR04zoiCFWVR5QHhTAPkaFOiFqyInxHor4rOwJbGjlJi3u7co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wpkg.org; spf=pass smtp.mailfrom=wpkg.org; dkim=pass (2048-bit key) header.d=wpkg.org header.i=@wpkg.org header.b=OK0qGsCP; arc=none smtp.client-ip=46.4.129.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wpkg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wpkg.org
Received: from mail.virtall.com (localhost [127.0.0.1])
	by mail.virtall.com (Postfix) with ESMTP id 5EAD513EFD5EB
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 13:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
	t=1724161064; bh=Ld9lpdDf7Fu0qmqUJKUF9W0PAztsOoaIH9YiW6Zzf04=;
	h=Date:From:To:Subject;
	b=OK0qGsCP5LJmMQ501l6h2NhXH7eMVev5Rztro0aT2bUUbntfF87d9X0dQRt3c2Z1M
	 CJetAlBJRxziHyzTiIhE71YwfHgJ8MT9xiwpsU2M0zL6GUJesWyYjmCNpSYhgq/3it
	 OAMXCROTZvlnAYvqgeLjOZ8cRCUBAlreiGmANZvfVTtzsDQrsf0ckXeupJ4yqVAFX3
	 xuN2dm4CEOzHqgM49nn7CfGJ0rFHwno6K6xVy8jxFqhrtfOojmsVRXF/6KJdWNlwoL
	 KYgPopnBYVb86FlNf0Iyvck6T4yyJ11PsXC/LFg5TyS2O2WloPCt35FsXlYm78Vc7N
	 JUMO39akYY0Tw==
X-Fuglu-Suspect: 67c63026324a496daba2bd68aa4e4f37
X-Fuglu-Spamstatus: NO
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
	by mail.virtall.com (Postfix) with ESMTPSA
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 13:37:42 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 20 Aug 2024 15:37:42 +0200
From: Tomasz Chmielewski <mangoo@wpkg.org>
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: out of space (>865 GB free), filesystem remounts read-only - how to
 recover?
Message-ID: <f11daee5026d303e673d480f3f812b15@wpkg.org>
X-Sender: mangoo@wpkg.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

My 44 TB filesystem was getting full (~865 GB free out of 44 TB in 
total), so I thought removing some old data would be a good thing to do.

Unfortunately now I'm not able to recover - the filesystem remounts 
read-only (no free space in metadata) a few minutes after mounting.

- kernel is 6.10.6

- the filesystem was writable and did not have any problems

- I've decided to delete some subvolumes with "btrfs sub del ..."

- a couple of minutes later after deleting the subvolumes, the 
filesystem went read only

- when I unmount and mount again - it resumes deleting the subvolumes in 
the background, free space goes up from 865G to 870G and filesystem 
remounts read-only

- after unmounting/mounting again, it again has 865GB free

- even if I remove some files right after mounting, as soon as the 
filesystem goes read-only - I unmount/mount again - removed files 
magically appear again

- I've added a 100 GB device to the filesystem - but it doesn't help, 
the filesystem still goes read only shortly after mounting

- tried running data and metadata balance - but the filesystem still 
goes read only shortly after mounting

How can I recover from that?

1) dmesg after mounting with "skip_balance" option:

[26883.769459] BTRFS info (device sdc1 state EA): last unmount of 
filesystem a80ce575-8c39-4065-80ce-2ca015fa1d51
[26890.241370] BTRFS info (device sdc1): first mount of filesystem 
a80ce575-8c39-4065-80ce-2ca015fa1d51
[26890.241402] BTRFS info (device sdc1): using crc32c (crc32c-intel) 
checksum algorithm
[26890.241414] BTRFS info (device sdc1): using free-space-tree
[27025.188366] BTRFS info (device sdc1): balance: resume skipped


2) dmesg after it goes read-only:

[27493.879003] ------------[ cut here ]------------
[27493.879014] BTRFS: Transaction aborted (error -28)
[27493.887226] BTRFS: error (device sdc1 state A) in 
do_free_extent_accounting:2968: errno=-28 No space left
[27493.936410] WARNING: CPU: 7 PID: 2990 at fs/btrfs/extent-tree.c:2968 
do_free_extent_accounting.cold+0xec/0x1f0 [btrfs]
[27494.050834] BTRFS info (device sdc1 state EA): forced readonly
[27494.050841] BTRFS error (device sdc1 state EA): failed to run delayed 
ref for logical 7329684533248 num_bytes 53248 type 184 action 2 ref_mod 
1: -28
[27494.051372] Modules linked in: tls
[27494.052220] BTRFS: error (device sdc1 state EA) in 
btrfs_run_delayed_refs:2207: errno=-28 No space left
[27494.211400]  isofs binfmt_misc ip6t_REJECT nf_reject_ipv6 
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat nf_tables nfnetlink 
nls_iso8859_1 intel_rapl_msr intel_rapl_common intel_uncore_frequency 
intel_uncore_frequency_common sb_edac x86_pkg_temp_thermal 
intel_powerclamp coretemp kvm_intel ipmi_ssif kvm rapl intel_cstate 
cmdlinepart spi_nor input_leds mei_me joydev intel_pch_thermal mtd mei 
ioatdma acpi_ipmi mac_hid ipmi_si ipmi_devintf ipmi_msghandler acpi_pad 
sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr 
efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic raid10 
raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor 
raid6_pq libcrc32c raid0 raid1 hid_generic usbhid hid crct10dif_pclmul 
crc32_pclmul polyval_clmulni spi_intel_platform polyval_generic ixgbe 
ghash_clmulni_intel spi_intel ahci gpio_ich igb i2c_i801 xfrm_algo 
sha256_ssse3 mxm_wmi i2c_mux libahci lpc_ich sha1_ssse3 i2c_smbus 
i2c_algo_bit xhci_pci
[27494.325621]  dca xhci_pci_renesas mdio wmi aesni_intel crypto_simd 
cryptd
[27494.325631] CPU: 7 PID: 2990 Comm: btrfs-transacti Tainted: G        
W          6.10.6-061006-generic #202408190440
[27494.325635] Hardware name: Supermicro Super Server/X10SDV-TLN4F, BIOS 
2.1.v1 06/05/2020
[27494.325637] RIP: 0010:do_free_extent_accounting.cold+0xec/0x1f0 
[btrfs]
[27494.325721] Code: 83 e0 01 e8 ec 52 00 00 e9 d0 5f f1 ff 89 df e8 e0 
ee ff ff 84 c0 0f 84 e8 00 00 00 89 de 48 c7 c7 d0 4f a4 c0 e8 4a c4 b7 
fb <0f> 0b eb bc 45 31 c0 41 83 e0 01 89 d9 ba b1 0b 00 00 4c 89 e7 48
[27494.325724] RSP: 0018:ffff956e01fbbb50 EFLAGS: 00010246
[27494.325727] RAX: 0000000000000000 RBX: 00000000ffffffe4 RCX: 
0000000000000000
[27494.325729] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000000
[27494.325731] RBP: ffff956e01fbbb80 R08: 0000000000000000 R09: 
0000000000000000
[27494.325733] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff8a4135049f18
[27494.325735] R13: 000006aa92150000 R14: 0000000000010000 R15: 
ffff956e01fbbc08
[27494.325738] FS:  0000000000000000(0000) GS:ffff8a479f980000(0000) 
knlGS:0000000000000000
[27494.325740] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[27494.325742] CR2: 0000713914aeef04 CR3: 000000016223c002 CR4: 
00000000003706f0
[27494.325745] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[27494.325747] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[27494.325749] Call Trace:
[27494.325751]  <TASK>
[27494.325754]  ? show_trace_log_lvl+0x1be/0x310
[27494.325761]  ? show_trace_log_lvl+0x1be/0x310
[27494.325766]  ? __btrfs_free_extent.isra.0+0x62a/0x900 [btrfs]
[27494.325838]  ? show_regs.part.0+0x22/0x30
[27494.325842]  ? show_regs.cold+0x8/0x10
[27494.325845]  ? do_free_extent_accounting.cold+0xec/0x1f0 [btrfs]
[27494.325928]  ? __warn.cold+0xa7/0x101
[27494.325934]  ? do_free_extent_accounting.cold+0xec/0x1f0 [btrfs]
[27494.326010]  ? report_bug+0x114/0x160
[27494.326015]  ? irq_work_queue+0x2d/0x70
[27494.326021]  ? handle_bug+0x51/0xa0
[27494.326025]  ? exc_invalid_op+0x18/0x80
[27494.326028]  ? asm_exc_invalid_op+0x1b/0x20
[27494.326034]  ? do_free_extent_accounting.cold+0xec/0x1f0 [btrfs]
[27494.326109]  __btrfs_free_extent.isra.0+0x62a/0x900 [btrfs]
[27494.326181]  run_delayed_data_ref+0x6c/0x1d0 [btrfs]
[27494.326247]  btrfs_run_delayed_refs_for_head+0x30a/0x420 [btrfs]
[27494.326312]  __btrfs_run_delayed_refs+0x106/0x1b0 [btrfs]
[27494.326375]  btrfs_run_delayed_refs+0x3c/0xd0 [btrfs]
[27494.326437]  btrfs_commit_transaction+0x6a/0xc70 [btrfs]
[27494.326513]  transaction_kthread+0x167/0x1d0 [btrfs]
[27494.326584]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[27494.326653]  kthread+0xe4/0x110
[27494.326657]  ? __pfx_kthread+0x10/0x10
[27494.326660]  ret_from_fork+0x47/0x70
[27494.326665]  ? __pfx_kthread+0x10/0x10
[27494.326667]  ret_from_fork_asm+0x1a/0x30
[27494.326673]  </TASK>
[27494.326674] ---[ end trace 0000000000000000 ]---
[27494.326678] BTRFS info (device sdc1 state EA): dumping space info:
[27494.326681] BTRFS info (device sdc1 state EA): space_info DATA has 
928231587840 free, is not full
[27494.326684] BTRFS info (device sdc1 state EA): space_info 
total=35882286448640, used=34948418105344, pinned=5635772416, 
reserved=0, may_use=0, readonly=983040 zone_unusable=0
[27494.326688] BTRFS info (device sdc1 state EA): space_info METADATA 
has -6576521216 free, is full
[27494.326691] BTRFS info (device sdc1 state EA): space_info 
total=78383153152, used=77616775168, pinned=71188480, 
reserved=695123968, may_use=6576521216, readonly=65536 zone_unusable=0
[27494.326695] BTRFS info (device sdc1 state EA): space_info SYSTEM has 
5980160 free, is not full
[27494.326698] BTRFS info (device sdc1 state EA): space_info 
total=8388608, used=2408448, pinned=0, reserved=0, may_use=0, readonly=0 
zone_unusable=0
[27494.326701] BTRFS info (device sdc1 state EA): global_block_rsv: size 
536870912 reserved 536805376
[27494.326703] BTRFS info (device sdc1 state EA): trans_block_rsv: size 
0 reserved 0
[27494.326706] BTRFS info (device sdc1 state EA): chunk_block_rsv: size 
0 reserved 0
[27494.326708] BTRFS info (device sdc1 state EA): delayed_block_rsv: 
size 0 reserved 0
[27494.326710] BTRFS info (device sdc1 state EA): delayed_refs_rsv: size 
1727549669376 reserved 6039715840
[27494.326713] BTRFS: error (device sdc1 state EA) in 
do_free_extent_accounting:2968: errno=-28 No space left
[27494.443071] BTRFS error (device sdc1 state EA): failed to run delayed 
ref for logical 7329665056768 num_bytes 65536 type 184 action 2 ref_mod 
1: -28
[27494.603135] BTRFS: error (device sdc1 state EA) in 
btrfs_run_delayed_refs:2207: errno=-28 No space left




Tomasz Chmielewski

