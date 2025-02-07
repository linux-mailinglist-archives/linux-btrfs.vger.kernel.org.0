Return-Path: <linux-btrfs+bounces-11343-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6B4A2CA26
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 18:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558633A6DB9
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 17:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390B1197A92;
	Fri,  7 Feb 2025 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluematt.me header.i=@bluematt.me header.b="h5hX3BnQ";
	dkim=pass (2048-bit key) header.d=clients.mail.as397444.net header.i=@clients.mail.as397444.net header.b="aegDzdO6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.as397444.net (mail.as397444.net [69.59.18.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312CE194A53
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.59.18.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949344; cv=none; b=K6thmbS2+N1SqZ1pHE/4UhOuD1Us1MVnnTPUvJ+TuIKmMh1hEkCJrX0stAc/8fmE1Z2+YtPVxn4I0y+xJCr3mZQbsCd0TO7452MsovWQAkfoKKT8CY1giCELXKUB8C85vw/vA7WdwOr+R8yhhrxvl+8bgRbfbWOLpnjzAmhI6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949344; c=relaxed/simple;
	bh=zvGiI+rb7m5iiAJcSml8qSj9rN56ryAaaagYzdL7lsw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=crsCqZAir7TkjEP0m2scPzHGrAGXCIF3V/fHA/qIjGoUO49nsqnaK5+aSa6v8nMhqX+mD/mYFXCV9WMnQ9zbNzivsrfCwSLP2ZY/+u0MdMoNk7iL2Zv4joGLqLZAn5w8wzSNKvogTxqT33xdoSToLx/cTKC3LrtJYrUThA5IUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluematt.me; spf=pass smtp.mailfrom=bluematt.me; dkim=pass (2048-bit key) header.d=bluematt.me header.i=@bluematt.me header.b=h5hX3BnQ; dkim=pass (2048-bit key) header.d=clients.mail.as397444.net header.i=@clients.mail.as397444.net header.b=aegDzdO6; arc=none smtp.client-ip=69.59.18.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluematt.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bluematt.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
	; s=1738947662; h=Subject:From:To:From:Subject:To:Cc:Cc:Reply-To:In-Reply-To:
	References; bh=y5/8L2l/sfDTQcW1yS/zR3whQrfWgz7glt6tV+fzjNM=; b=h5hX3BnQz4TYLf
	wq40PWpnd1xj2aOYv5zjqMT/RMJsauZztefTYNmWj+gMt9zqZTnBv0TXRUmkAGNirDwePX0xsGNhg
	SM/AUBpmCA/LCo4viHGcmInRBI4NoLikC7LKbH4EQkFSXlWvQoEMdEdiCxYfE8ztwjzmkcsJce5DG
	itVOuuW0knHqxGBYVGM9ewmdxQRhqWXrSsDLmK3nT0J1/52zwQSN1tZDJNgXle8muffES/fsLyrm/
	uhmPIKMf7kQ0dkmMRW56JLZaFcr/Vw94Zv9ylw3YPLZYGUUXN+WVQjPKbJereYxCHhs8cr4muRzv1
	ZtX6i+ikiVA/xw79CRVA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=clients.mail.as397444.net; s=1738947665; h=Subject:From:To:From:Subject:To:
	Cc:Cc:Reply-To:In-Reply-To:References;
	bh=y5/8L2l/sfDTQcW1yS/zR3whQrfWgz7glt6tV+fzjNM=; b=aegDzdO6OjcRINfbOhvmns7z3L
	tzOePzoUUpMZHr4XtSnS6qd0dQ99TlQaCQxIAY7uGA/WPH/O4PKHzr2ijQvxvj/Rppd3XD791tW6X
	+VO9RZbo7T67LRwGOMrzfK2mXQQ5X7YqF0k+uVG8DKScBu4JTOcWQ7bY2XuvpccmGIL6ziz8L8fFn
	6z6PpW4IsuWyg7i0S5JJVCcPG96xnPpkFehl9ckoce9384TQw5X6dZDt1SAb7wSi+HbTvSCMze7j7
	S0lyJrJKnxzo8jOSeunUbav+qKnhiOnEi6E5p45/bs6ZQb/+kF+p3ra5dydoWfnpLc96L8cpfLMdK
	OPUsVYKQ==;
X-DKIM-Note: Keys used to sign are likely public at
X-DKIM-Note: https://as397444.net/dkim/bluematt.me and
X-DKIM-Note: https://as397444.net/dkim/clients.mail.as397444.net
X-DKIM-Note: For more info, see https://as397444.net/dkim/
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
	(envelope-from <blnxfsl@bluematt.me>)
	id 1tgS3l-00FQJR-0e for linux-btrfs@vger.kernel.org;
	Fri, 07 Feb 2025 17:22:33 +0000
Message-ID: <a4789c59-a5f6-41ac-9be8-8ac047f23edf@bluematt.me>
Date: Fri, 7 Feb 2025 12:22:32 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From: Matt Corallo <blnxfsl@bluematt.me>
Subject: [6.1] NULL PTR Deref when missing degraded mount option on encrypted
 fs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Woke up this morning to two failed disks (one not connecting at all, one with lots of dead sectors), 
on a raid1c3 FS (here's hoping the replace finishes before another one dies...). I tried to reboot 
to see if the disconencted disk would come up just a bit for replace in case it had a few good 
sectors (but no dice), and on reboot I tried to mount like I normally do (mount -o noatime 
/dev/mapper/dm_crypt_device /filesystem) only to find it spit out a stream of null and low pointer 
deref OOP's like the following.

Kernel is 6.1.0-29-powerpc64le #1 SMP Debian 6.1.123-1 (2025-01-02) ppc64le GNU/Linux

[  123.802279] BTRFS error (device dm-5): devid 8 uuid a6d73663-a98e-454e-ae15-33506043ce8f is missing
[  123.802320] BTRFS error (device dm-5): failed to read chunk tree: -2
[  123.806902] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
[  123.806937] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  123.806952] Faulting instruction address: 0xc000000000165a60
[  123.806980] Oops: Kernel access of bad area, sig: 11 [#1]
[  123.806992] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[  123.807022] Modules linked in: nvme_fabrics nft_chain_nat xt_nat nf_nat xt_tcpudp xt_set 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables ip_set_hash_net 
ip_set_hash_ip ip_set nfnetlink essiv authenc bridge stp llc ast drm_vram_helper drm_ttm_helper ttm 
ipmi_powernv ofpart drm_kms_helper ipmi_devintf powernv_flash syscopyarea sysfillrect sysimgblt at24 
ipmi_msghandler regmap_i2c fb_sys_fops opal_prd mtd i2c_algo_bit sg binfmt_misc loop drm
[  123.807097] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
[  123.807098]  fuse
[  123.807102] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  123.807316]  drm_panel_orientation_quirks
[  123.807412] Faulting instruction address: 0xc000000000165a60
[  123.807443]  configfs
[  123.807473] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  123.807477] Faulting instruction address: 0xc000000000165a60
[  123.807650]  ip_tables x_tables autofs4 xxhash_generic btrfs zstd_compress raid10 raid456 
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic 
raid1 raid0 multipath linear md_mod usb_storage dm_crypt dm_mod algif_skcipher af_alg sd_mod 
xhci_pci xts ecb ctr xhci_hcd nvme vmx_crypto gf128mul crc32c_vpmsum nvme_core tg3
[  123.807727] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
[  123.807732] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  123.807826]  t10_pi
[  123.807892] Faulting instruction address: 0xc000000000165a60
[  123.807899] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  123.807903] Faulting instruction address: 0xc000000000165a60
[  123.807957]  mpt3sas crc64_rocksoft_generic usbcore crc64_rocksoft crc_t10dif crct10dif_generic 
crc64 crct10dif_common raid_class libphy usb_common scsi_transport_sas
[  123.808243] CPU: 32 PID: 636 Comm: kworker/u130:3 Not tainted 6.1.0-29-powerpc64le #1  Debian 
6.1.123-1
[  123.808318] Hardware name: T2P9D01 REV 1.00 POWER9 0x4e1202 opal:skiboot-bc106a0 PowerNV
[  123.808374] Workqueue: kcryptd/254:3 kcryptd_crypt [dm_crypt]
[  123.808418] NIP:  c000000000165a60 LR: c000000000165ed4 CTR: c000000000165e50
[  123.808451] REGS: c0002000119ab740 TRAP: 0300   Not tainted  (6.1.0-29-powerpc64le Debian 6.1.123-1)
[  123.808525] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
[  123.808534] MSR:  900000000280b033 <SF
[  123.808601] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  123.808604] Faulting instruction address: 0xc000000000165a60
[  123.808650] ,HV
[  123.808739] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
[  123.808759] ,VEC
[  123.808780] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  123.808834] ,VSX
[  123.808854] Faulting instruction address: 0xc000000000165a60
[  123.808904] ,EE,FP,ME,IR,DR,RI,LE>  CR: 24002488  XER: 20040000
[  123.809052] CFAR: c000000000165890 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 1
[  123.809052] GPR00: c000000000165ed4 c0002000119ab9e0 c00000000113cd00 0000000000000800
[  123.809052] GPR04: 000000007fffffff c000200032f62f00 00000000c0002000 0000000000000000
[  123.809052] GPR08: 0000000fffffffe1 000000007fffffff 0000200ff97e0000 0000000000004000
[  123.809052] GPR12: c000000000165e50 c000200fff7ff300 c000000000173dd8 c0002000061e0500
[  123.809052] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[  123.809052] GPR20: 0000000000000000 0000000000000000 c000000002530088 0000000000000000
[  123.809052] GPR24: c00020000933d1b4 c0000000026e3058 0000000000000020 c000000002793480
[  123.809052] GPR28: 0000000000000800 c00020001fd26a00 0000000000000000 c000200032f62f00
[  123.809562] NIP [c000000000165a60] __queue_work+0x2d0/0x6c0
[  123.809597] LR [c000000000165ed4] queue_work_on+0x84/0xb0
[  123.809635] Call Trace:
[  123.809669] [c0002000119ab9e0] [c0000000004db958] __slab_free+0x1f8/0x540 (unreliable)
[  123.809749] [c0002000119aba90] [c000000000165ed4] queue_work_on+0x84/0xb0
[  123.809808] [c0002000119abac0] [c0080000103de304] btrfs_simple_end_io+0x9c/0x110 [btrfs]
[  123.809917] [c0002000119abaf0] [c00000000074262c] bio_endio+0x19c/0x230
[  123.809992] [c0002000119abb20] [c00800000f695058] __dm_io_complete+0x1b0/0x3f0 [dm_mod]
[  123.810065] [c0002000119abb80] [c00800000f697c60] clone_endio+0x1d8/0x2c0 [dm_mod]
[  123.810140] [c0002000119abc20] [c00000000074262c] bio_endio+0x19c/0x230
[  123.810187] [c0002000119abc50] [c00800000f2d2304] crypt_dec_pending+0xac/0x180 [dm_crypt]
[  123.810251] [c0002000119abc90] [c000000000166430] process_one_work+0x2b0/0x560
[  123.810312] [c0002000119abd30] [c000000000166788] worker_thread+0xa8/0x600
[  123.810371] [c0002000119abdc0] [c000000000173ef4] kthread+0x124/0x130
[  123.810412] [c0002000119abe10] [c00000000000cedc] ret_from_kernel_thread+0x5c/0x64
[  123.810486] Instruction dump:
[  123.810539] 81610008 eb21ffc8 eb41ffd0 eb61ffd8 eb81ffe0 eba1ffe8 ebc1fff0 ebe1fff8
[  123.810610] 7c0803a6 7d708120 4e800020 60420000 <e87e0000> 48c55725 60000000 813e0018
[  123.810682] ---[ end trace 0000000000000000 ]---
[  125.415433]
[  125.415449] Oops: Kernel access of bad area, sig: 7 [#2]
[  125.415449] note: kworker/u130:3[636] exited with irqs disabled
[  125.415490] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[  125.415517] Modules linked in: nvme_fabrics nft_chain_nat xt_nat nf_nat xt_tcpudp xt_set 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables ip_set_hash_net 
ip_set_hash_ip ip_set nfnetlink essiv authenc bridge stp llc ast drm_vram_helper drm_ttm_helper ttm 
ipmi_powernv ofpart drm_kms_helper ipmi_devintf powernv_flash syscopyarea sysfillrect sysimgblt at24 
ipmi_msghandler regmap_i2c fb_sys_fops opal_prd mtd i2c_algo_bit sg binfmt_misc loop drm fuse 
drm_panel_orientation_quirks configfs ip_tables x_tables autofs4 xxhash_generic btrfs zstd_compress 
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c 
crc32c_generic raid1 raid0 multipath linear md_mod usb_storage dm_crypt dm_mod algif_skcipher af_alg 
sd_mod xhci_pci xts ecb ctr xhci_hcd nvme vmx_crypto gf128mul crc32c_vpmsum nvme_core tg3 t10_pi 
mpt3sas crc64_rocksoft_generic usbcore crc64_rocksoft crc_t10dif crct10dif_generic crc64 
crct10dif_common raid_class libphy
[  125.415635]  usb_common scsi_transport_sas
[  125.416063] CPU: 37 PID: 629 Comm: kworker/u130:1 Tainted: G      D 
6.1.0-29-powerpc64le #1  Debian 6.1.123-1
[  125.416115] Hardware name: T2P9D01 REV 1.00 POWER9 0x4e1202 opal:skiboot-bc106a0 PowerNV
[  125.416122] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
[  125.416150] Workqueue: kcryptd/254:3 kcryptd_crypt [dm_crypt]
[  125.416199] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  125.416231] NIP:  c000000000165a60 LR: c000000000165ed4 CTR: c000000000165e50
[  125.416264] Faulting instruction address: 0xc000000000165a60
[  125.416296] REGS: c0002000115ff740 TRAP: 0300   Tainted: G      D 
(6.1.0-29-powerpc64le Debian 6.1.123-1)
[  125.416397] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24002488  XER: 20040000
[  125.416424] CFAR: c000000000165890 DAR: 0000000000000000 DSISR: 00080000 IRQMASK: 1
[  125.416424] GPR00: c000000000165ed4 c0002000115ff9e0 c00000000113cd00 0000000000000800
[  125.416424] GPR04: 000000007fffffff c000200032f6cb00 00000000c0002000 0000000000000000
[  125.416424] GPR08: 0000000fffffffe1 000000007fffffff 0000200ff9b00000 0000000000004000
[  125.416424] GPR12: c000000000165e50 c000200fff7f8600 c000000000173dd8 c00020000602c940
[  125.416424] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[  125.416424] GPR20: 0000000000000000 0000000000000000 c000000002530088 0000000000000000
[  125.416424] GPR24: c000200007f7c434 c0000000026e3058 0000000000000025 c000000002793480
[  125.416424] GPR28: 0000000000000800 c00020001fd26a00 0000000000000000 c000200032f6cb00
[  125.416491] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  125.416747] NIP [c000000000165a60] __queue_work+0x2d0/0x6c0
[  125.416813] Faulting instruction address: 0xc000000000165a60
[  125.416832] LR [c000000000165ed4] queue_work_on+0x84/0xb0
[  125.416910] Call Trace:
[  125.416926] [c0002000115ff9e0] [c0000000004db958] __slab_free+0x1f8/0x540 (unreliable)
[  125.416984] [c0002000115ffa90] [c000000000165ed4] queue_work_on+0x84/0xb0
[  125.417030] [c0002000115ffac0] [c0080000103de304] btrfs_simple_end_io+0x9c/0x110 [btrfs]
[  125.417100] [c0002000115ffaf0] [c00000000074262c] bio_endio+0x19c/0x230
[  125.417135] [c0002000115ffb20] [c00800000f695058] __dm_io_complete+0x1b0/0x3f0 [dm_mod]
[  125.417162] [c0002000115ffb80] [c00800000f697c60] clone_endio+0x1d8/0x2c0 [dm_mod]
[  125.417200] [c0002000115ffc20] [c00000000074262c] bio_endio+0x19c/0x230
[  125.417234] [c0002000115ffc50] [c00800000f2d2304] crypt_dec_pending+0xac/0x180 [dm_crypt]
[  125.417282] [c0002000115ffc90] [c000000000166430] process_one_work+0x2b0/0x560
[  125.417317] [c0002000115ffd30] [c000000000166788] worker_thread+0xa8/0x600
[  125.417352] [c0002000115ffdc0] [c000000000173ef4] kthread+0x124/0x130
[  125.417397] [c0002000115ffe10] [c00000000000cedc] ret_from_kernel_thread+0x5c/0x64
[  125.417455] Instruction dump:
[  125.417484] 81610008 eb21ffc8 eb41ffd0 eb61ffd8 eb81ffe0 eba1ffe8 ebc1fff0 ebe1fff8
[  125.417532] 7c0803a6 7d708120 4e800020 60420000 <e87e0000> 48c55725 60000000 813e0018
[  125.417568] ---[ end trace 0000000000000000 ]---
[  127.020036]
[  127.020047] note: kworker/u130:1[629] exited with irqs disabled
[  127.020047] Oops: Kernel access of bad area, sig: 11 [#3]
[  127.020067] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[  127.020092] Modules linked in: nvme_fabrics nft_chain_nat xt_nat nf_nat xt_tcpudp xt_set 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables ip_set_hash_net 
ip_set_hash_ip ip_set nfnetlink essiv authenc bridge stp llc ast drm_vram_helper drm_ttm_helper ttm 
ipmi_powernv ofpart drm_kms_helper ipmi_devintf powernv_flash syscopyarea sysfillrect sysimgblt at24 
ipmi_msghandler regmap_i2c fb_sys_fops opal_prd mtd i2c_algo_bit sg binfmt_misc loop drm fuse 
drm_panel_orientation_quirks configfs ip_tables x_tables autofs4 xxhash_generic btrfs zstd_compress 
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c 
crc32c_generic raid1 raid0 multipath linear md_mod usb_storage dm_crypt dm_mod algif_skcipher af_alg 
sd_mod xhci_pci xts ecb ctr xhci_hcd nvme vmx_crypto gf128mul crc32c_vpmsum nvme_core tg3 t10_pi 
mpt3sas crc64_rocksoft_generic usbcore crc64_rocksoft crc_t10dif crct10dif_generic crc64 
crct10dif_common raid_class libphy
[  127.020218]  usb_common scsi_transport_sas
[  127.020542] CPU: 33 PID: 633 Comm: kworker/u130:2 Tainted: G      D 
6.1.0-29-powerpc64le #1  Debian 6.1.123-1
[  127.020583] Hardware name: T2P9D01 REV 1.00 POWER9 0x4e1202 opal:skiboot-bc106a0 PowerNV
[  127.020609] Workqueue: kcryptd/254:3 kcryptd_crypt [dm_crypt]
[  127.020648] NIP:  c000000000165a60 LR: c000000000165ed4 CTR: c000000000165e50
[  127.020705] REGS: c0002000119e3740 TRAP: 0300   Tainted: G      D 
(6.1.0-29-powerpc64le Debian 6.1.123-1)
[  127.020766] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24002488  XER: 20040000
[  127.020820] CFAR: c000000000165890 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 1
[  127.020820] GPR00: c000000000165ed4 c0002000119e39e0 c00000000113cd00 0000000000000800
[  127.020820] GPR04: 000000007fffffff c000200032f61b80 00000000c0002000 0000000000000000
[  127.020820] GPR08: 0000000fffffffe1 000000007fffffff 0000200ff9880000 0000000000004000
[  127.020820] GPR12: c000000000165e50 c000200fff7fe600 c000000000173dd8 c000200005d50440
[  127.020820] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[  127.020820] GPR20: 0000000000000000 0000000000000000 c000000002530088 0000000000000000
[  127.020820] GPR24: c000200005d44b74 c0000000026e3058 0000000000000021 c000000002793480
[  127.020820] GPR28: 0000000000000800 c00020001fd26a00 0000000000000000 c000200032f61b80
[  127.021128] NIP [c000000000165a60] __queue_work+0x2d0/0x6c0
[  127.021153] LR [c000000000165ed4] queue_work_on+0x84/0xb0
[  127.021176] Call Trace:
[  127.021195] [c0002000119e39e0] [c0000000004db958] __slab_free+0x1f8/0x540 (unreliable)
[  127.021235] [c0002000119e3a90] [c000000000165ed4] queue_work_on+0x84/0xb0
[  127.021272] [c0002000119e3ac0] [c0080000103de304] btrfs_simple_end_io+0x9c/0x110 [btrfs]
[  127.021340] [c0002000119e3af0] [c00000000074262c] bio_endio+0x19c/0x230
[  127.021366] [c0002000119e3b20] [c00800000f695058] __dm_io_complete+0x1b0/0x3f0 [dm_mod]
[  127.021423] [c0002000119e3b80] [c00800000f697c60] clone_endio+0x1d8/0x2c0 [dm_mod]
[  127.021478] [c0002000119e3c20] [c00000000074262c] bio_endio+0x19c/0x230
[  127.021526] [c0002000119e3c50] [c00800000f2d2304] crypt_dec_pending+0xac/0x180 [dm_crypt]
[  127.021568] [c0002000119e3c90] [c000000000166430] process_one_work+0x2b0/0x560
[  127.021617] [c0002000119e3d30] [c000000000166788] worker_thread+0xa8/0x600
[  127.021669] [c0002000119e3dc0] [c000000000173ef4] kthread+0x124/0x130
[  127.021706] [c0002000119e3e10] [c00000000000cedc] ret_from_kernel_thread+0x5c/0x64
[  127.021744] Instruction dump:
[  127.021775] 81610008 eb21ffc8 eb41ffd0 eb61ffd8 eb81ffe0 eba1ffe8 ebc1fff0 ebe1fff8
[  127.021820] 7c0803a6 7d708120 4e800020 60420000 <e87e0000> 48c55725 60000000 813e0018
[  127.021855] ---[ end trace 0000000000000000 ]---
[  128.625385]
[  128.625395] note: kworker/u130:2[633] exited with irqs disabled
[  128.625396] Oops: Kernel access of bad area, sig: 7 [#4]
[  128.625398] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[  128.625441] Modules linked in: nvme_fabrics nft_chain_nat xt_nat nf_nat xt_tcpudp xt_set 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables ip_set_hash_net 
ip_set_hash_ip ip_set nfnetlink essiv authenc bridge stp llc ast drm_vram_helper drm_ttm_helper ttm 
ipmi_powernv ofpart drm_kms_helper ipmi_devintf powernv_flash syscopyarea sysfillrect sysimgblt at24 
ipmi_msghandler regmap_i2c fb_sys_fops opal_prd mtd i2c_algo_bit sg binfmt_misc loop drm fuse 
drm_panel_orientation_quirks configfs ip_tables x_tables autofs4 xxhash_generic btrfs zstd_compress 
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c 
crc32c_generic raid1 raid0 multipath linear md_mod usb_storage dm_crypt dm_mod algif_skcipher af_alg 
sd_mod xhci_pci xts ecb ctr xhci_hcd nvme vmx_crypto gf128mul crc32c_vpmsum nvme_core tg3 t10_pi 
mpt3sas crc64_rocksoft_generic usbcore crc64_rocksoft crc_t10dif crct10dif_generic crc64 
crct10dif_common raid_class libphy
[  128.625566]  usb_common scsi_transport_sas
[  128.625888] CPU: 35 PID: 639 Comm: kworker/u130:4 Tainted: G      D 
6.1.0-29-powerpc64le #1  Debian 6.1.123-1
[  128.625929] Hardware name: T2P9D01 REV 1.00 POWER9 0x4e1202 opal:skiboot-bc106a0 PowerNV
[  128.625975] Workqueue: kcryptd/254:3 kcryptd_crypt [dm_crypt]
[  128.626014] NIP:  c000000000165a60 LR: c000000000165ed4 CTR: c000000000165e50
[  128.626051] REGS: c0002000119ef740 TRAP: 0300   Tainted: G      D 
(6.1.0-29-powerpc64le Debian 6.1.123-1)
[  128.626112] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24002488  XER: 20040000
[  128.626177] CFAR: c000000000165890 DAR: 0000000000000000 DSISR: 00080000 IRQMASK: 1
[  128.626177] GPR00: c000000000165ed4 c0002000119ef9e0 c00000000113cd00 0000000000000800
[  128.626177] GPR04: 000000007fffffff c000200032f60f80 00000000c0002000 0000000000000000
[  128.626177] GPR08: 0000000fffffffe1 000000007fffffff 0000200ff99c0000 0000000000004000
[  128.626177] GPR12: c000000000165e50 c000200fff7fcc00 c000000000173dd8 c0002000061e1440
[  128.626177] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[  128.626177] GPR20: 0000000000000000 0000000000000000 c000000002530088 0000000000000000
[  128.626177] GPR24: c000200009335774 c0000000026e3058 0000000000000023 c000000002793480
[  128.626177] GPR28: 0000000000000800 c00020001fd26a00 0000000000000000 c000200032f60f80
[  128.626481] NIP [c000000000165a60] __queue_work+0x2d0/0x6c0
[  128.626506] LR [c000000000165ed4] queue_work_on+0x84/0xb0
[  128.626540] Call Trace:
[  128.626558] [c0002000119ef9e0] [c0000000004db958] __slab_free+0x1f8/0x540 (unreliable)
[  128.626605] [c0002000119efa90] [c000000000165ed4] queue_work_on+0x84/0xb0
[  128.626645] [c0002000119efac0] [c0080000103de304] btrfs_simple_end_io+0x9c/0x110 [btrfs]
[  128.626734] [c0002000119efaf0] [c00000000074262c] bio_endio+0x19c/0x230
[  128.626772] [c0002000119efb20] [c00800000f695058] __dm_io_complete+0x1b0/0x3f0 [dm_mod]
[  128.626829] [c0002000119efb80] [c00800000f697c60] clone_endio+0x1d8/0x2c0 [dm_mod]
[  128.626863] [c0002000119efc20] [c00000000074262c] bio_endio+0x19c/0x230
[  128.626900] [c0002000119efc50] [c00800000f2d2304] crypt_dec_pending+0xac/0x180 [dm_crypt]
[  128.626941] [c0002000119efc90] [c000000000166430] process_one_work+0x2b0/0x560
[  128.626980] [c0002000119efd30] [c000000000166788] worker_thread+0xa8/0x600
[  128.627019] [c0002000119efdc0] [c000000000173ef4] kthread+0x124/0x130
[  128.627055] [c0002000119efe10] [c00000000000cedc] ret_from_kernel_thread+0x5c/0x64
[  128.627084] Instruction dump:
[  128.627104] 81610008 eb21ffc8 eb41ffd0 eb61ffd8 eb81ffe0 eba1ffe8 ebc1fff0 ebe1fff8
[  128.627151] 7c0803a6 7d708120 4e800020 60420000 <e87e0000> 48c55725 60000000 813e0018
[  128.627197] ---[ end trace 0000000000000000 ]---
[  131.430742]
[  131.430760] note: kworker/u130:4[639] exited with irqs disabled
[  131.430761] Oops: Kernel access of bad area, sig: 11 [#5]
[  131.430763] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[  131.430805] Modules linked in: nvme_fabrics nft_chain_nat xt_nat nf_nat xt_tcpudp xt_set 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables ip_set_hash_net 
ip_set_hash_ip ip_set nfnetlink essiv authenc bridge stp llc ast drm_vram_helper drm_ttm_helper ttm 
ipmi_powernv ofpart drm_kms_helper ipmi_devintf powernv_flash syscopyarea sysfillrect sysimgblt at24 
ipmi_msghandler regmap_i2c fb_sys_fops opal_prd mtd i2c_algo_bit sg binfmt_misc loop drm fuse 
drm_panel_orientation_quirks configfs ip_tables x_tables autofs4 xxhash_generic btrfs zstd_compress 
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c 
crc32c_generic raid1 raid0 multipath linear md_mod usb_storage dm_crypt dm_mod algif_skcipher af_alg 
sd_mod xhci_pci xts ecb ctr xhci_hcd nvme vmx_crypto gf128mul crc32c_vpmsum nvme_core tg3 t10_pi 
mpt3sas crc64_rocksoft_generic usbcore crc64_rocksoft crc_t10dif crct10dif_generic crc64 
crct10dif_common raid_class libphy
[  131.430906]  usb_common scsi_transport_sas
[  131.431191] CPU: 34 PID: 179 Comm: kworker/u130:0 Tainted: G      D 
6.1.0-29-powerpc64le #1  Debian 6.1.123-1
[  131.431241] Hardware name: T2P9D01 REV 1.00 POWER9 0x4e1202 opal:skiboot-bc106a0 PowerNV
[  131.431285] Workqueue: kcryptd/254:3 kcryptd_crypt [dm_crypt]
[  131.431320] NIP:  c000000000165a60 LR: c000000000165ed4 CTR: c000000000165e50
[  131.431366] REGS: c000200005ca3740 TRAP: 0300   Tainted: G      D 
(6.1.0-29-powerpc64le Debian 6.1.123-1)
[  131.431437] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24002488  XER: 20040000
[  131.431495] CFAR: c000000000165890 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 1
[  131.431495] GPR00: c000000000165ed4 c000200005ca39e0 c00000000113cd00 0000000000000800
[  131.431495] GPR04: 000000007fffffff c0002000443a5c00 00000000c0002000 0000000000000000
[  131.431495] GPR08: 0000000fffffffe1 000000007fffffff 0000200ff9920000 0000000000004000
[  131.431495] GPR12: c000000000165e50 c000200fff7fd900 c000000000173dd8 c000200005d52b80
[  131.431495] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[  131.431495] GPR20: 0000000000000000 0000000000000000 c000000002530088 0000000000000000
[  131.431495] GPR24: c000200005d450b4 c0000000026e3058 0000000000000022 c000000002793480
[  131.431495] GPR28: 0000000000000800 c00020001fd26a00 0000000000000000 c0002000443a5c00
[  131.431798] NIP [c000000000165a60] __queue_work+0x2d0/0x6c0
[  131.431821] LR [c000000000165ed4] queue_work_on+0x84/0xb0
[  131.431853] Call Trace:
[  131.431881] [c000200005ca39e0] [c0000000004db958] __slab_free+0x1f8/0x540 (unreliable)
[  131.431942] [c000200005ca3a90] [c000000000165ed4] queue_work_on+0x84/0xb0
[  131.432016] [c000200005ca3ac0] [c0080000103de304] btrfs_simple_end_io+0x9c/0x110 [btrfs]
[  131.432068] [c000200005ca3af0] [c00000000074262c] bio_endio+0x19c/0x230
[  131.432092] [c000200005ca3b20] [c00800000f695058] __dm_io_complete+0x1b0/0x3f0 [dm_mod]
[  131.432131] [c000200005ca3b80] [c00800000f697c60] clone_endio+0x1d8/0x2c0 [dm_mod]
[  131.432172] [c000200005ca3c20] [c00000000074262c] bio_endio+0x19c/0x230
[  131.432207] [c000200005ca3c50] [c00800000f2d2304] crypt_dec_pending+0xac/0x180 [dm_crypt]
[  131.432246] [c000200005ca3c90] [c000000000166430] process_one_work+0x2b0/0x560
[  131.432272] [c000200005ca3d30] [c000000000166788] worker_thread+0xa8/0x600
[  131.432307] [c000200005ca3dc0] [c000000000173ef4] kthread+0x124/0x130
[  131.432341] [c000200005ca3e10] [c00000000000cedc] ret_from_kernel_thread+0x5c/0x64
[  131.432378] Instruction dump:
[  131.432408] 81610008 eb21ffc8 eb41ffd0 eb61ffd8 eb81ffe0 eba1ffe8 ebc1fff0 ebe1fff8
[  131.432450] 7c0803a6 7d708120 4e800020 60420000 <e87e0000> 48c55725 60000000 813e0018
[  131.432491] ---[ end trace 0000000000000000 ]---
[  133.435409]
[  133.435424] note: kworker/u130:0[179] exited with irqs disabled
[  133.435424] Oops: Kernel access of bad area, sig: 11 [#6]
[  133.435444] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[  133.435467] Modules linked in: nvme_fabrics nft_chain_nat xt_nat nf_nat xt_tcpudp xt_set 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables ip_set_hash_net 
ip_set_hash_ip ip_set nfnetlink essiv authenc bridge stp llc ast drm_vram_helper drm_ttm_helper ttm 
ipmi_powernv ofpart drm_kms_helper ipmi_devintf powernv_flash syscopyarea sysfillrect sysimgblt at24 
ipmi_msghandler regmap_i2c fb_sys_fops opal_prd mtd i2c_algo_bit sg binfmt_misc loop drm fuse 
drm_panel_orientation_quirks configfs ip_tables x_tables autofs4 xxhash_generic btrfs zstd_compress 
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c 
crc32c_generic raid1 raid0 multipath linear md_mod usb_storage dm_crypt dm_mod algif_skcipher af_alg 
sd_mod xhci_pci xts ecb ctr xhci_hcd nvme vmx_crypto gf128mul crc32c_vpmsum nvme_core tg3 t10_pi 
mpt3sas crc64_rocksoft_generic usbcore crc64_rocksoft crc_t10dif crct10dif_generic crc64 
crct10dif_common raid_class libphy
[  133.435559]  usb_common scsi_transport_sas
[  133.435864] CPU: 57 PID: 643 Comm: kworker/u130:5 Tainted: G      D 
6.1.0-29-powerpc64le #1  Debian 6.1.123-1
[  133.435925] Hardware name: T2P9D01 REV 1.00 POWER9 0x4e1202 opal:skiboot-bc106a0 PowerNV
[  133.435960] Workqueue: kcryptd/254:3 kcryptd_crypt [dm_crypt]
[  133.436008] NIP:  c000000000165a60 LR: c000000000165ed4 CTR: c000000000165e50
[  133.436076] REGS: c00020001158f740 TRAP: 0300   Tainted: G      D 
(6.1.0-29-powerpc64le Debian 6.1.123-1)
[  133.436137] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24002484  XER: 20040000
[  133.436173] CFAR: c000000000165890 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 1
[  133.436173] GPR00: c000000000165ed4 c00020001158f9e0 c00000000113cd00 0000000000000800
[  133.436173] GPR04: 000000007fffffff c000200032f69680 00000000c0002000 0000000000000000
[  133.436173] GPR08: 0000000fffffffe1 000000007fffffff 0000200ffa780000 0000000000004000
[  133.436173] GPR12: c000000000165e50 c000200fff6e2100 c000000000173dd8 c0002000061e1440
[  133.436173] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[  133.436173] GPR20: 0000000000000000 0000000000000000 c000000002530088 0000000000000000
[  133.436173] GPR24: c000200009338cb4 c0000000026e3058 0000000000000039 c000000002793480
[  133.436173] GPR28: 0000000000000800 c00020001fd26a00 0000000000000000 c000200032f69680
[  133.436402] NIP [c000000000165a60] __queue_work+0x2d0/0x6c0
[  133.436425] LR [c000000000165ed4] queue_work_on+0x84/0xb0
[  133.436459] Call Trace:
[  133.436476] [c00020001158f9e0] [c0000000004db958] __slab_free+0x1f8/0x540 (unreliable)
[  133.436525] [c00020001158fa90] [c000000000165ed4] queue_work_on+0x84/0xb0
[  133.436572] [c00020001158fac0] [c0080000103de304] btrfs_simple_end_io+0x9c/0x110 [btrfs]
[  133.436658] [c00020001158faf0] [c00000000074262c] bio_endio+0x19c/0x230
[  133.436705] [c00020001158fb20] [c00800000f695058] __dm_io_complete+0x1b0/0x3f0 [dm_mod]
[  133.436747] [c00020001158fb80] [c00800000f697c60] clone_endio+0x1d8/0x2c0 [dm_mod]
[  133.436788] [c00020001158fc20] [c00000000074262c] bio_endio+0x19c/0x230
[  133.436813] [c00020001158fc50] [c00800000f2d2304] crypt_dec_pending+0xac/0x180 [dm_crypt]
[  133.436829] [c00020001158fc90] [c000000000166430] process_one_work+0x2b0/0x560
[  133.436867] [c00020001158fd30] [c000000000166788] worker_thread+0xa8/0x600
[  133.436903] [c00020001158fdc0] [c000000000173ef4] kthread+0x124/0x130
[  133.436938] [c00020001158fe10] [c00000000000cedc] ret_from_kernel_thread+0x5c/0x64
[  133.436975] Instruction dump:
[  133.436995] 81610008 eb21ffc8 eb41ffd0 eb61ffd8 eb81ffe0 eba1ffe8 ebc1fff0 ebe1fff8
[  133.437048] 7c0803a6 7d708120 4e800020 60420000 <e87e0000> 48c55725 60000000 813e0018
[  133.437091] ---[ end trace 0000000000000000 ]---
[  134.840027]
[  134.840039] note: kworker/u130:5[643] exited with irqs disabled
[  134.840039] Oops: Kernel access of bad area, sig: 11 [#7]
[  134.840041] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[  134.840081] Modules linked in: nvme_fabrics nft_chain_nat xt_nat nf_nat xt_tcpudp xt_set 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables ip_set_hash_net 
ip_set_hash_ip ip_set nfnetlink essiv authenc bridge stp llc ast drm_vram_helper drm_ttm_helper ttm 
ipmi_powernv ofpart drm_kms_helper ipmi_devintf powernv_flash syscopyarea sysfillrect sysimgblt at24 
ipmi_msghandler regmap_i2c fb_sys_fops opal_prd mtd i2c_algo_bit sg binfmt_misc loop drm fuse 
drm_panel_orientation_quirks configfs ip_tables x_tables autofs4 xxhash_generic btrfs zstd_compress 
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c 
crc32c_generic raid1 raid0 multipath linear md_mod usb_storage dm_crypt dm_mod algif_skcipher af_alg 
sd_mod xhci_pci xts ecb ctr xhci_hcd nvme vmx_crypto gf128mul crc32c_vpmsum nvme_core tg3 t10_pi 
mpt3sas crc64_rocksoft_generic usbcore crc64_rocksoft crc_t10dif crct10dif_generic crc64 
crct10dif_common raid_class libphy
[  134.840163]  usb_common scsi_transport_sas
[  134.840471] CPU: 56 PID: 645 Comm: kworker/u130:6 Tainted: G      D 
6.1.0-29-powerpc64le #1  Debian 6.1.123-1
[  134.840497] Hardware name: T2P9D01 REV 1.00 POWER9 0x4e1202 opal:skiboot-bc106a0 PowerNV
[  134.840531] Workqueue: kcryptd/254:3 kcryptd_crypt [dm_crypt]
[  134.840543] NIP:  c000000000165a60 LR: c000000000165ed4 CTR: c000000000165e50
[  134.840600] REGS: c0002000115d3740 TRAP: 0300   Tainted: G      D 
(6.1.0-29-powerpc64le Debian 6.1.123-1)
[  134.840670] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24002488  XER: 20040000
[  134.840707] CFAR: c000000000165890 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 1
[  134.840707] GPR00: c000000000165ed4 c0002000115d39e0 c00000000113cd00 0000000000000800
[  134.840707] GPR04: 000000007fffffff c000200032f6ec00 00000000c0002000 0000000000000000
[  134.840707] GPR08: 0000000fffffffe1 000000007fffffff 0000200ffa6e0000 0000000000004000
[  134.840707] GPR12: c000000000165e50 c000200fff6e2e00 c000000000173dd8 c000200005d5ad80
[  134.840707] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[  134.840707] GPR20: 0000000000000000 0000000000000000 c000000002530088 0000000000000000
[  134.840707] GPR24: c000200005d4e6b4 c0000000026e3058 0000000000000038 c000000002793480
[  134.840707] GPR28: 0000000000000800 c00020001fd26a00 0000000000000000 c000200032f6ec00
[  134.840875] NIP [c000000000165a60] __queue_work+0x2d0/0x6c0
[  134.840897] LR [c000000000165ed4] queue_work_on+0x84/0xb0
[  134.840919] Call Trace:
[  134.840936] [c0002000115d39e0] [c0000000004db958] __slab_free+0x1f8/0x540 (unreliable)
[  134.840972] [c0002000115d3a90] [c000000000165ed4] queue_work_on+0x84/0xb0
[  134.840995] [c0002000115d3ac0] [c0080000103de304] btrfs_simple_end_io+0x9c/0x110 [btrfs]
[  134.841032] [c0002000115d3af0] [c00000000074262c] bio_endio+0x19c/0x230
[  134.841044] [c0002000115d3b20] [c00800000f695058] __dm_io_complete+0x1b0/0x3f0 [dm_mod]
[  134.841071] [c0002000115d3b80] [c00800000f697c60] clone_endio+0x1d8/0x2c0 [dm_mod]
[  134.841098] [c0002000115d3c20] [c00000000074262c] bio_endio+0x19c/0x230
[  134.841133] [c0002000115d3c50] [c00800000f2d2304] crypt_dec_pending+0xac/0x180 [dm_crypt]
[  134.841170] [c0002000115d3c90] [c000000000166430] process_one_work+0x2b0/0x560
[  134.841205] [c0002000115d3d30] [c000000000166788] worker_thread+0xa8/0x600
[  134.841251] [c0002000115d3dc0] [c000000000173ef4] kthread+0x124/0x130
[  134.841296] [c0002000115d3e10] [c00000000000cedc] ret_from_kernel_thread+0x5c/0x64
[  134.841365] Instruction dump:
[  134.841394] 81610008 eb21ffc8 eb41ffd0 eb61ffd8 eb81ffe0 eba1ffe8 ebc1fff0 ebe1fff8
[  134.841434] 7c0803a6 7d708120 4e800020 60420000 <e87e0000> 48c55725 60000000 813e0018
[  134.841474] ---[ end trace 0000000000000000 ]---
[  136.444058]
[  136.444067] note: kworker/u130:6[645] exited with irqs disabled
[  136.444068] Oops: Kernel access of bad area, sig: 11 [#8]
[  136.444086] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[  136.444108] Modules linked in: nvme_fabrics nft_chain_nat xt_nat nf_nat xt_tcpudp xt_set 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables ip_set_hash_net 
ip_set_hash_ip ip_set nfnetlink essiv authenc bridge stp llc ast drm_vram_helper drm_ttm_helper ttm 
ipmi_powernv ofpart drm_kms_helper ipmi_devintf powernv_flash syscopyarea sysfillrect sysimgblt at24 
ipmi_msghandler regmap_i2c fb_sys_fops opal_prd mtd i2c_algo_bit sg binfmt_misc loop drm fuse 
drm_panel_orientation_quirks configfs ip_tables x_tables autofs4 xxhash_generic btrfs zstd_compress 
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c 
crc32c_generic raid1 raid0 multipath linear md_mod usb_storage dm_crypt dm_mod algif_skcipher af_alg 
sd_mod xhci_pci xts ecb ctr xhci_hcd nvme vmx_crypto gf128mul crc32c_vpmsum nvme_core tg3 t10_pi 
mpt3sas crc64_rocksoft_generic usbcore crc64_rocksoft crc_t10dif crct10dif_generic crc64 
crct10dif_common raid_class libphy
[  136.444181]  usb_common scsi_transport_sas
[  136.444424] CPU: 32 PID: 646 Comm: kworker/u130:7 Tainted: G      D 
6.1.0-29-powerpc64le #1  Debian 6.1.123-1
[  136.444462] Hardware name: T2P9D01 REV 1.00 POWER9 0x4e1202 opal:skiboot-bc106a0 PowerNV
[  136.444507] Workqueue: kcryptd/254:3 kcryptd_crypt [dm_crypt]
[  136.444543] NIP:  c000000000165a60 LR: c000000000165ed4 CTR: c000000000165e50
[  136.444555] REGS: c0002000115fb740 TRAP: 0300   Tainted: G      D 
(6.1.0-29-powerpc64le Debian 6.1.123-1)
[  136.444603] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24002224  XER: 20040000
[  136.444661] CFAR: c000000000165890 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 1
[  136.444661] GPR00: c000000000165ed4 c0002000115fb9e0 c00000000113cd00 0000000000000800
[  136.444661] GPR04: 000000007fffffff c0002000443a5780 00000000c0002000 0000000000000000
[  136.444661] GPR08: 0000000fffffffe1 000000007fffffff 0000200ff97e0000 0000000000004000
[  136.444661] GPR12: c000000000165e50 c000200fff7ff300 c000000000173dd8 c000200006124400
[  136.444661] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[  136.444661] GPR20: 0000000000000000 0000000000000000 c000000002530088 0000000000000000
[  136.444661] GPR24: c000200005d485f4 c0000000026e3058 0000000000000020 c000000002793480
[  136.444661] GPR28: 0000000000000800 c00020001fd26a00 0000000000000000 c0002000443a5780
[  136.445003] NIP [c000000000165a60] __queue_work+0x2d0/0x6c0
[  136.445038] LR [c000000000165ed4] queue_work_on+0x84/0xb0
[  136.445070] Call Trace:
[  136.445098] [c0002000115fb9e0] [c0000000004db958] __slab_free+0x1f8/0x540 (unreliable)
[  136.445147] [c0002000115fba90] [c000000000165ed4] queue_work_on+0x84/0xb0
[  136.445182] [c0002000115fbac0] [c0080000103de304] btrfs_simple_end_io+0x9c/0x110 [btrfs]
[  136.445227] [c0002000115fbaf0] [c00000000074262c] bio_endio+0x19c/0x230
[  136.445251] [c0002000115fbb20] [c00800000f695058] __dm_io_complete+0x1b0/0x3f0 [dm_mod]
[  136.445278] [c0002000115fbb80] [c00800000f697c60] clone_endio+0x1d8/0x2c0 [dm_mod]
[  136.445328] [c0002000115fbc20] [c00000000074262c] bio_endio+0x19c/0x230
[  136.445363] [c0002000115fbc50] [c00800000f2d2304] crypt_dec_pending+0xac/0x180 [dm_crypt]
[  136.445412] [c0002000115fbc90] [c000000000166430] process_one_work+0x2b0/0x560
[  136.445460] [c0002000115fbd30] [c000000000166788] worker_thread+0xa8/0x600
[  136.445495] [c0002000115fbdc0] [c000000000173ef4] kthread+0x124/0x130
[  136.445540] [c0002000115fbe10] [c00000000000cedc] ret_from_kernel_thread+0x5c/0x64
[  136.445576] Instruction dump:
[  136.445596] 81610008 eb21ffc8 eb41ffd0 eb61ffd8 eb81ffe0 eba1ffe8 ebc1fff0 ebe1fff8
[  136.445624] 7c0803a6 7d708120 4e800020 60420000 <e87e0000> 48c55725 60000000 813e0018
[  136.445653] ---[ end trace 0000000000000000 ]---

