Return-Path: <linux-btrfs+bounces-18591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AA2C2D42D
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 17:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 481984E7C36
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 16:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891CB3195EC;
	Mon,  3 Nov 2025 16:53:00 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from savella.carfax.org.uk (savella.carfax.org.uk [85.119.84.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A29290F
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.119.84.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188780; cv=none; b=TymMJOoSXiaDoTZ1EtCsPy/S2H9yWjViogJu5IWJZrlSznQXL2gskolKxe0yhoGR4ryAFvFcIGEMHJ+iGO0ESQlq1ODCAkGzgw1yE3Qdon4quSBoWrOhGF4nWIDOEcAMTAvy1Bt0HpJAFZCjwjO8D9NrrNJR9BMjcU/e5Q/We6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188780; c=relaxed/simple;
	bh=w6OZu5hrlqMjhg28XjoBsggm1j9Tq6C8iIZa+siJKtg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BJxcSMUuYA89j1JaxHRFPS+8aFKos5ItkZCYjTdvfDgwACtezeGJfZMKVL5xaDyFiMRYcWHh7qx613luQMaJbkiRqd+DvrkOLfOCOMA4c4GX0PLTxq09A3h86XS9oCDkLbgM4B/aJ7yWKagsUKcPbiImIXW5Wy8b/oySL6zQCs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carfax.org.uk; spf=pass smtp.mailfrom=savella.carfax.org.uk; arc=none smtp.client-ip=85.119.84.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carfax.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savella.carfax.org.uk
Received: from hrm by savella.carfax.org.uk with local (Exim 4.98.2)
	(envelope-from <hrm@savella.carfax.org.uk>)
	id 1vFxFN-00000003KPK-1o16
	for linux-btrfs@vger.kernel.org;
	Mon, 03 Nov 2025 16:17:33 +0000
Date: Mon, 3 Nov 2025 16:17:33 +0000
From: Hugo Mills <hugo@carfax.org.uk>
To: linux-btrfs@vger.kernel.org
Subject: Kernel backtrace and hang while replacing dead drive
Message-ID: <aQjVnfVTSjtOtosd@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
	linux-btrfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing

   On Saturday morning, one SSD in a 4-drive RAID-1 array failed (the
failed drive is /dev/sdb, devid 5). The replacement arrived today. I
physically removed the dead drive, and added the new one to the
machine. This was /dev/sdj.

   I ran "btrfs replace start -r 5 /dev/sdj1 /". At 12% done,
everything hung. I was able to get the log info below before the whole
machine locked up (the array in question contains the system
installation, so when the array locked up, the machine became
unresponsive).

   I'm going to reboot and try again. I'm leaving this report here in
case anyone's interested in following up on why it happened, or wants
to suggest an alternative way forward. (I'll be on the freenode IRC
channel, too, as darkling).

   Thanks,
   Hugo.

Nov  3 15:56:14 s_src@amelia kernel: BTRFS error (device sdd1): bdev /dev/s=
db1 errs: wr 50488570, rd 36558204, f
lush 24486, corrupt 0, gen 0
Nov  3 15:56:16 s_src@amelia kernel: scrub_handle_errored_block: 18199 call=
backs suppressed
Nov  3 15:56:16 s_src@amelia kernel: _btrfs_printk: 163 callbacks suppressed
Nov  3 15:56:16 s_src@amelia kernel: BTRFS warning (device sdd1): i/o error=
 at logical 2236658860032 on dev /dev
/sdb1, physical 61027368960: metadata leaf (level 0) in tree 2284479184896
Nov  3 15:56:16 s_src@amelia kernel: BTRFS warning (device sdd1): i/o error=
 at logical 2236658860032 on dev /dev
/sdb1, physical 61027368960: metadata leaf (level 0) in tree 2284479184896
Nov  3 15:56:16 s_src@amelia kernel: BTRFS warning (device sdd1): i/o error=
 at logical 2236658909184 on dev /dev
/sdb1, physical 61027418112: metadata leaf (level 0) in tree 257
Nov  3 15:56:16 s_src@amelia kernel: BTRFS warning (device sdd1): i/o error=
 at logical 2236658909184 on dev /dev
/sdb1, physical 61027418112: metadata leaf (level 0) in tree 257
Nov  3 15:56:16 s_src@amelia kernel: BTRFS warning (device sdd1): i/o error=
 at logical 2236659089408 on dev /dev
/sdb1, physical 61027598336: metadata leaf (level 0) in tree 7
Nov  3 15:56:16 s_src@amelia kernel: BTRFS warning (device sdd1): i/o error=
 at logical 2236659089408 on dev /dev
/sdb1, physical 61027598336: metadata leaf (level 0) in tree 7
Nov  3 15:56:16 s_src@amelia kernel: BTRFS warning (device sdd1): i/o error=
 at logical 2236659204096 on dev /dev
/sdb1, physical 61027713024: metadata leaf (level -1) in tree 1844674407370=
9551615
Nov  3 15:56:16 s_src@amelia kernel: BTRFS warning (device sdd1): bad eb me=
mber end: ptr 0x4000 start 2237987028
992 member offset 16384 size 1
Nov  3 15:56:16 s_src@amelia kernel: general protection fault, probably for=
 non-canonical address 0xda7b8c000000
0: 0000 [#1] PREEMPT SMP NOPTI
Nov  3 15:56:16 s_src@amelia kernel: CPU: 5 PID: 1939101 Comm: kworker/u16:=
8 Not tainted 5.19.0-2-amd64 #1  Debi
an 5.19.11-1
Nov  3 15:56:16 s_src@amelia kernel: Hardware name: Gigabyte Technology Co.=
, Ltd. To be filled by O.E.M./970A-DS
3P, BIOS FD 02/26/2016
Nov  3 15:56:16 s_src@amelia kernel: Workqueue: btrfs-scrub scrub_bio_end_i=
o_worker [btrfs]
Nov  3 15:56:16 s_src@amelia kernel: RIP: 0010:btrfs_get_8+0x57/0x70 [btrfs]
Nov  3 15:56:16 s_src@amelia kernel: Code: e5 ff 0f 00 00 48 c1 fb 06 48 c1=
 e3 0c 48 03 1d 4f 83 12 ec 49 39 d0=20
0f 87 22 2f 09 00 49 8d 48 01 48 39 ca 0f 82 36 2f 09 00 <0f> b6 04 2b 5b 5=
d e9 ce 4e b4 eb 66 66 2e 0f 1f 84 00
 00 00 00 00
Nov  3 15:56:16 s_src@amelia kernel: RSP: 0018:ffffa3cf8d6abc50 EFLAGS: 000=
10296
Nov  3 15:56:16 s_src@amelia kernel: RAX: 0000000000000000 RBX: 000da7b8c00=
00000 RCX: 0000000000000000
Nov  3 15:56:16 s_src@amelia kernel: RDX: 0000000000000000 RSI: ffffffffac7=
6ee29 RDI: 00000000ffffffff
Nov  3 15:56:16 s_src@amelia kernel: RBP: 0000000000000000 R08: 00000000000=
00000 R09: 0000000104903c77
Nov  3 15:56:16 s_src@amelia kernel: R10: ffffa3cf8d6aba60 R11: fffffffface=
cca48 R12: 0000000000003fd6
Nov  3 15:56:16 s_src@amelia kernel: R13: 0000000000004000 R14: 00000000000=
03fee R15: ffff94c9d6cfc400
Nov  3 15:56:16 s_src@amelia kernel: FS:  0000000000000000(0000) GS:ffff94c=
ceed40000(0000) knlGS:000000000000000
0
Nov  3 15:56:16 s_src@amelia kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000=
00080050033
Nov  3 15:56:16 s_src@amelia kernel: CR2: 00007fc2cba0a360 CR3: 000000010b8=
a6000 CR4: 00000000000406e0
Nov  3 15:56:16 s_src@amelia kernel: Call Trace:
Nov  3 15:56:16 s_src@amelia kernel:  <TASK>
Nov  3 15:56:16 s_src@amelia kernel:  btrfs_get_extent_inline_ref_type+0x1a=
/0x110 [btrfs]
Nov  3 15:56:16 s_src@amelia kernel:  tree_backref_for_extent+0x96/0x1a0 [b=
trfs]
Nov  3 15:56:16 s_src@amelia kernel:  scrub_print_warning+0x1b1/0x1d0 [btrf=
s]
Nov  3 15:56:16 s_src@amelia kernel:  scrub_handle_errored_block.isra.0+0x1=
00f/0x1110 [btrfs]
Nov  3 15:56:16 s_src@amelia kernel:  scrub_bio_end_io_worker+0xa6/0x230 [b=
trfs]
Nov  3 15:56:16 s_src@amelia kernel:  process_one_work+0x1e5/0x3b0
Nov  3 15:56:16 s_src@amelia kernel:  worker_thread+0x50/0x3a0
Nov  3 15:56:16 s_src@amelia kernel:  ? rescuer_thread+0x390/0x390
Nov  3 15:56:16 s_src@amelia kernel:  kthread+0xe8/0x110
Nov  3 15:56:16 s_src@amelia kernel:  ? kthread_complete_and_exit+0x20/0x20
Nov  3 15:56:16 s_src@amelia kernel:  ret_from_fork+0x22/0x30
Nov  3 15:56:16 s_src@amelia kernel:  </TASK>
Nov  3 15:56:16 s_src@amelia kernel: Modules linked in: tls unix_diag fuse =
udf crc_itu_t nfsd auth_rpcgss nfs_acl lockd grace sunrpc bridge stp llc it=
87 hwmon_vid parport_pc ppdev lp parport dm_crypt dm_mod ses enclosure scsi=
_transport_sas amdgpu gpu_sched radeon amd64_edac edac_mce_amd drm_display_=
helper kvm_amd cec ccp rc_core snd_hda_codec_realtek drm_ttm_helper ttm rng=
_core r8169 snd_hda_codec_generic drm_kms_helper kvm snd_hda_codec_hdmi led=
trig_audio irqbypass realtek xhci_pci crc32_pclmul snd_hda_intel sr_mod snd=
_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core mdio_devres ohc=
i_pci ghash_clmulni_intel cdrom drm megaraid_sas snd_hwdep pcspkr efi_pstor=
e k10temp fam15h_power libphy xhci_hcd sg ohci_hcd ehci_pci i2c_algo_bit sn=
d_pcm sp5100_tco ehci_hcd watchdog snd_timer usbcore snd i2c_piix4 usb_comm=
on soundcore button acpi_cpufreq btrfs blake2b_generic zstd_compress efivar=
fs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_t=
x libcrc32c crc32c_generic xor raid6_pq raid1 raid0
Nov  3 15:56:16 s_src@amelia kernel:  multipath linear md_mod sd_mod t10_pi=
 crc64_rocksoft crc64 crc_t10dif crct10dif_generic crct10dif_pclmul crct10d=
if_common crc32c_intel ahci libahci sata_sil24 libata aesni_intel scsi_mod =
crypto_simd cryptd evdev serio_raw scsi_common
Nov  3 15:56:16 s_src@amelia kernel: ---[ end trace 0000000000000000 ]---
Nov  3 15:56:17 s_src@amelia kernel: RIP: 0010:btrfs_get_8+0x57/0x70 [btrfs]
Nov  3 15:56:17 s_src@amelia kernel: Code: e5 ff 0f 00 00 48 c1 fb 06 48 c1=
 e3 0c 48 03 1d 4f 83 12 ec 49 39 d0 0f 87 22 2f 09 00 49 8d 48 01 48 39 ca=
 0f 82 36 2f 09 00 <0f> b6 04 2b 5b 5d e9 ce 4e b4 eb 66 66 2e 0f 1f 84 00 =
00 00 00 00
Nov  3 15:56:17 s_src@amelia kernel: RSP: 0018:ffffa3cf8d6abc50 EFLAGS: 000=
10296
Nov  3 15:56:17 s_src@amelia kernel: RAX: 0000000000000000 RBX: 000da7b8c00=
00000 RCX: 0000000000000000
Nov  3 15:56:17 s_src@amelia kernel: RDX: 0000000000000000 RSI: ffffffffac7=
6ee29 RDI: 00000000ffffffff
Nov  3 15:56:17 s_src@amelia kernel: RBP: 0000000000000000 R08: 00000000000=
00000 R09: 0000000104903c77
Nov  3 15:56:17 s_src@amelia kernel: R10: ffffa3cf8d6aba60 R11: fffffffface=
cca48 R12: 0000000000003fd6
Nov  3 15:56:17 s_src@amelia kernel: R13: 0000000000004000 R14: 00000000000=
03fee R15: ffff94c9d6cfc400
Nov  3 15:56:17 s_src@amelia kernel: FS:  0000000000000000(0000) GS:ffff94c=
ceed40000(0000) knlGS:0000000000000000
Nov  3 15:56:17 s_src@amelia kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000=
00080050033
Nov  3 15:56:17 s_src@amelia kernel: CR2: 00007fc2cba0a360 CR3: 000000010b8=
a6000 CR4: 00000000000406e0
Nov  3 15:56:23 s_src@amelia kernel: btrfs_dev_stat_print_on_error: 7137 ca=
llbacks suppressed
Nov  3 15:56:23 s_src@amelia kernel: BTRFS error (device sdd1): bdev /dev/s=
db1 errs: wr 50488571, rd 36565341, flush 24486, corrupt 0, gen 0
Nov  3 15:56:24 s_src@amelia kernel: BTRFS error (device sdd1): bdev /dev/s=
db1 errs: wr 50488571, rd 36565341, flush 24487, corrupt 0, gen 0


--=20
Hugo Mills             | "You know, the British have always been nice to mad
hugo@... carfax.org.uk | people."
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                         Laura Jesson, Brief Encoun=
ter

