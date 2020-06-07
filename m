Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9441F0A20
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jun 2020 07:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgFGFXH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jun 2020 01:23:07 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:49219 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgFGFXH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jun 2020 01:23:07 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49flCD2Nn0z2d
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Jun 2020 07:23:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591507384; bh=A0frEzvrBcXUpI9PXCY1rXV04DsQqw13dWkBZ1U/IPA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=aWWj4BLrlrYfnC8bBkl3UTRKpFMnd0te15kisv0J1x9X/ZaVg82BawL3c6zLKQQ/k
         acNcGze7Jlhy3kCr67JsHE+H7vJ/PI1z2edZhDiHKoKIITLV2/1WGmUXwUpLEl1Kkl
         VtROtYPcoo2ab6DIjVfQy3shVFfPQe88KZRrPa4jPkjT6zBVJkNmeAkcT2HqGq/PrB
         fP+zzd3dbyNDFPlZqrWY2KmO513qwploHQyGc1xp95hVxEvHd/xuemnMrPvbqe3WR8
         w7jrR9BUrPbrOpoAi9tr4PjouBithwdJFYGnamTxf7BNFUGsO2qoyIM3HYK+BBAQw6
         SQHulvILOifvQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 7 Jun 2020 07:23:03 +0200
From:   =?iso-8859-2?B?TWljaGGzoE1pcm9zs2F3?= <mirq-linux@rere.qmqm.pl>
To:     linux-btrfs@vger.kernel.org
Subject: Re: balance + ENOFS -> readonly filesystem
Message-ID: <20200607052303.GF12913@qmqm.qmqm.pl>
References: <20200607051217.GE12913@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200607051217.GE12913@qmqm.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 07, 2020 at 07:12:17AM +0200, Micha=B3=A0Miros=B3aw wrote:
> Dear btrfs developers,
>=20
> I just added a new disk to already almost full filesystem and tried to
> enable raid1 for metadata (transcript below). The operation failed and
> left the filesystem in readonly state. Is this expected?

This doesn't look good:

# btrfs balance start -musage=3D90 .
Segmentation fault

# dmesg | tail ...
[11215.910301] BTRFS info (device dm-5): balance: start -musage=3D90 -susag=
e=3D90
[11215.910966] ------------[ cut here ]------------
[11215.910967] kernel BUG at fs/btrfs/relocation.c:4291!
[11215.910972] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[11215.910974] CPU: 4 PID: 19615 Comm: btrfs Tainted: G        W  O      5.=
6.15mq+ #376
[11215.910975] Hardware name: System manufacturer System Product Name/P8Z68=
-V PRO, BIOS 3603 11/09/2012
[11215.910999] RIP: 0010:create_reloc_inode.isra.40+0xf2/0x220 [btrfs]
[11215.911001] Code: 48 85 c0 74 25 4c 89 f1 48 89 c2 48 89 de 48 89 04 24 =
4c 89 e7 e8 0e c7 f9 ff 4c 8b 04 24 85 c0 74 0a 4c 89 c7 e8 4e 56 f8 ff <0f=
> 0b 49 63 40 40 ba 11 00 00 00 4d 8b 38 48 8d 04 80 48 8d 74 80
[11215.911002] RSP: 0018:ffffc9000ab2fb88 EFLAGS: 00010286
[11215.911003] RAX: 0000000000000000 RBX: ffff8883f502c000 RCX: 00000000001=
23c6c
[11215.911005] RDX: 0000000000000002 RSI: 0000000000123c64 RDI: 00000000000=
37140
[11215.911006] RBP: ffff888405e80000 R08: ffff88829f76ae00 R09: 00000000000=
00000
[11215.911007] R10: 00000000ffffffff R11: 0000000000000000 R12: ffff88831b3=
a8340
[11215.911008] R13: ffff8882f6614448 R14: 0000000000000107 R15: 00000000fff=
ffffe
[11215.911009] FS:  00007f0ecb8978c0(0000) GS:ffff88840ed00000(0000) knlGS:=
0000000000000000
[11215.911010] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11215.911012] CR2: 0000558614da72d8 CR3: 00000002be854001 CR4: 00000000000=
606e0
[11215.911013] Call Trace:
[11215.911033]  btrfs_relocate_block_group+0xe4/0x310 [btrfs]
[11215.911049]  btrfs_relocate_chunk+0x31/0xe0 [btrfs]
[11215.911065]  btrfs_balance+0x899/0xf70 [btrfs]
[11215.911085]  btrfs_ioctl_balance+0x2d4/0x390 [btrfs]
[11215.911102]  btrfs_ioctl+0x1652/0x31d0 [btrfs]
[11215.911106]  ? _raw_spin_unlock+0x24/0x40
[11215.911108]  ? __handle_mm_fault+0xb8d/0x1210
[11215.911115]  ? ksys_ioctl+0x81/0xc0
[11215.911130]  ? btrfs_ioctl_get_supported_features+0x20/0x20 [btrfs]
[11215.911132]  ksys_ioctl+0x81/0xc0
[11215.911134]  __x64_sys_ioctl+0x11/0x20
[11215.911136]  do_syscall_64+0x4f/0x210
[11215.911139]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[11215.911140] RIP: 0033:0x7f0ecb98e427
[11215.911142] Code: 00 00 90 48 8b 05 69 7a 0c 00 64 c7 00 26 00 00 00 48 =
c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 7a 0c 00 f7 d8 64 89 01 48
[11215.911143] RSP: 002b:00007ffd51b7fdc8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000010
[11215.911144] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f0ecb9=
8e427
[11215.911145] RDX: 00007ffd51b7fe58 RSI: 00000000c4009420 RDI: 00000000000=
00003
[11215.911147] RBP: 00007ffd51b7fe58 R08: 0000558614d9f2a0 R09: 00000000000=
00231
[11215.911148] R10: fffffffffffffa4c R11: 0000000000000202 R12: 00000000000=
00003
[11215.911149] R13: 00007ffd51b82750 R14: 0000000000000001 R15: 00000000000=
00000
[11215.911153] Modules linked in: uas usb_storage rfcomm fuse cpufreq_power=
save cpufreq_userspace cpufreq_conservative nfc nf_conntrack_netlink overla=
y xfrm_user xfrm4_tunnel tunnel4 ipcomp xfrm_ipcomp esp4 ah4 af_key xfrm_al=
go cmac vboxnetadp(O) vboxnetflt(O) bridge stp llc bnep vboxdrv(O) binfmt_m=
isc dm_cache_smq dm_cache dm_persistent_data dm_bio_prison dm_bufio usblp x=
fs btrfs blake2b_generic zstd_compress ftdi_sio usbserial joydev squashfs z=
std_decompress btusb btrtl btbcm btintel bluetooth ecdh_generic ecc wmi_bmo=
f mxm_wmi kvm_intel kvm irqbypass ghash_clmulni_intel pcspkr i2c_i801 snd_h=
da_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi iTCO_wdt sg snd_e=
mu10k1 snd_util_mem snd_ac97_codec ac97_bus emu10k1_gp snd_rawmidi gameport=
 snd_hda_intel snd_seq_device snd_intel_dspcfg snd_hda_codec snd_hda_core x=
hci_pci snd_hwdep xhci_hcd snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd =
soundcore nvidia_drm(O) nft_masq wmi drm_kms_helper cfbfillrect syscopyarea=
 cfbimgblt sysfillrect sysimgblt
[11215.911176]  fb_sys_fops cfbcopyarea fb font fbdev drm drm_panel_orienta=
tion_quirks nvidia_modeset(O) nft_redir nvidia(O) i2c_core nf_tables_set nf=
t_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_counter n=
f_tables nfnetlink nfsd auth_rpcgss nfs_acl lockd grace sunrpc loop firewir=
e_sbp2 firewire_core crc_itu_t ecryptfs autofs4 input_leds raid10 raid456 l=
ibcrc32c async_raid6_recov async_memcpy async_pq raid6_pq async_xor xor asy=
nc_tx raid0 multipath linear e1000e video backlight
[11215.911193] ---[ end trace 0d99142474b285fb ]---
[11215.911208] RIP: 0010:create_reloc_inode.isra.40+0xf2/0x220 [btrfs]
[11215.911209] Code: 48 85 c0 74 25 4c 89 f1 48 89 c2 48 89 de 48 89 04 24 =
4c 89 e7 e8 0e c7 f9 ff 4c 8b 04 24 85 c0 74 0a 4c 89 c7 e8 4e 56 f8 ff <0f=
> 0b 49 63 40 40 ba 11 00 00 00 4d 8b 38 48 8d 04 80 48 8d 74 80
[11215.911210] RSP: 0018:ffffc9000ab2fb88 EFLAGS: 00010286
[11215.911212] RAX: 0000000000000000 RBX: ffff8883f502c000 RCX: 00000000001=
23c6c
[11215.911213] RDX: 0000000000000002 RSI: 0000000000123c64 RDI: 00000000000=
37140
[11215.911214] RBP: ffff888405e80000 R08: ffff88829f76ae00 R09: 00000000000=
00000
[11215.911215] R10: 00000000ffffffff R11: 0000000000000000 R12: ffff88831b3=
a8340
[11215.911216] R13: ffff8882f6614448 R14: 0000000000000107 R15: 00000000fff=
ffffe
[11215.911217] FS:  00007f0ecb8978c0(0000) GS:ffff88840ed00000(0000) knlGS:=
0000000000000000
[11215.911219] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11215.911220] CR2: 0000558614da72d8 CR3: 00000002be854001 CR4: 00000000000=
606e0

Best Regards,
Micha=B3 Miros=B3aw
