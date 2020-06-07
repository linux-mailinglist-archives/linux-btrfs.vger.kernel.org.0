Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978141F0A19
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jun 2020 07:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgFGFMX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jun 2020 01:12:23 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:40917 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgFGFMW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jun 2020 01:12:22 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49fkyq0Gsxz2d
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Jun 2020 07:12:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591506739; bh=dioqTY5QQnzRsclkVQjivMKlEa57VjWkyuEL5yxl3vg=;
        h=Date:From:To:Subject:From;
        b=bxLiFbQRzzF9ptorVW+FujrDJC/0ApHQuJ4J3LzVVLt5YL3MK8AgDvOaP+8GRelm0
         jtkx3HuN3qFe2HQwQRvuPYKENnCGSzGxMWjjfC1tIaAIN7FRuidj0sl5up9HADA+Oq
         2aBZYS/ALkZ1204V9SuD3W2oMLcMFajkO8S24UUQCcMSD6tIuAAHwJkKFP+MwNqZne
         yhgyeSbNNfy+mnqlAuqoxOWJ43h8R1nZlzOC30ztWMFUGlOcKoS/Ru1nbx3a3N0lP3
         JzesnNM9aYuepxlXfSixw1cp+95ufwNLUk8OK+w8NVkfVLiEGltst2Rlud007P5xUk
         F2M+BVBjdLYhA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 7 Jun 2020 07:12:17 +0200
From:   =?iso-8859-2?B?TWljaGGzoE1pcm9zs2F3?= <mirq-linux@rere.qmqm.pl>
To:     linux-btrfs@vger.kernel.org
Subject: balance + ENOFS -> readonly filesystem
Message-ID: <20200607051217.GE12913@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear btrfs developers,

I just added a new disk to already almost full filesystem and tried to
enable raid1 for metadata (transcript below). The operation failed and
left the filesystem in readonly state. Is this expected?

Best Regards,
Micha=B3 Miros=B3aw

[on linux v5.6.15]

# btrfs balance start -mconvert=3Draid1 -v .
Dumping filters: flags 0x6, state 0x0, force is off
  METADATA (flags 0x100): converting, target=3D16, soft is off
  SYSTEM (flags 0x100): converting, target=3D16, soft is off
ERROR: error during balancing '.': Read-only file system
There may be more info in syslog - try dmesg | tail

[dmesg: see below, first WARN]

# umount ...
# btrfs check /dev/mapper/btrfs1
Opening filesystem to check...
Checking filesystem on /dev/mapper/jb1_crypt
UUID: 01234567-abcd-0123-abcd-012345678901
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 994491097088 bytes used, no error found
total csum bytes: 969796120
total tree bytes: 1176272896
total fs tree bytes: 134135808
total extent tree bytes: 19972096
btree space waste bytes: 59492903
file data blocks allocated: 993314824192
 referenced 993314824192

# mount ...
# btrfs balance start -mconvert=3Draid1 -v .
Dumping filters: flags 0x6, state 0x0, force is off
  METADATA (flags 0x100): converting, target=3D16, soft is off
  SYSTEM (flags 0x100): converting, target=3D16, soft is off
ERROR: error during balancing '.': Read-only file system
There may be more info in syslog - try dmesg | tail

[dmesg: second WARN, same as before]


-----> first <-----

[ 8532.719868] BTRFS info (device dm-5): disk added /dev/mapper/btrfs2
[ 8532.726483] BTRFS info (device dm-5): device fsid 01234567-abcd-0123-abc=
d-012345678901 devid 2 moved old:/dev/mapper/btrfs2 new:/dev/dm-9
[ 8532.726952] BTRFS info (device dm-5): device fsid 01234567-abcd-0123-abc=
d-012345678901 devid 2 moved old:/dev/dm-9 new:/dev/mapper/btrfs2
[ 8909.439222] BTRFS info (device dm-5): balance: start -mconvert=3Draid1 -=
sconvert=3Draid1
[ 8909.589730] BTRFS info (device dm-5): relocating block group 93418579558=
4 flags metadata|dup
[ 8910.080664] ------------[ cut here ]------------
[ 8910.080669] BTRFS: Transaction aborted (error -28)
[ 8910.080707] WARNING: CPU: 1 PID: 3067 at fs/btrfs/extent-tree.c:2210 btr=
fs_run_delayed_refs+0x18b/0x1e0 [btrfs]
[ 8910.080708] Modules linked in: uas usb_storage rfcomm fuse cpufreq_power=
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
[ 8910.080731]  fb_sys_fops cfbcopyarea fb font fbdev drm drm_panel_orienta=
tion_quirks nvidia_modeset(O) nft_redir nvidia(O) i2c_core nf_tables_set nf=
t_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_counter n=
f_tables nfnetlink nfsd auth_rpcgss nfs_acl lockd grace sunrpc loop firewir=
e_sbp2 firewire_core crc_itu_t ecryptfs autofs4 input_leds raid10 raid456 l=
ibcrc32c async_raid6_recov async_memcpy async_pq raid6_pq async_xor xor asy=
nc_tx raid0 multipath linear e1000e video backlight
[ 8910.080747] CPU: 1 PID: 3067 Comm: btrfs Tainted: G           O      5.6=
=2E15mq+ #376
[ 8910.080748] Hardware name: System manufacturer System Product Name/P8Z68=
-V PRO, BIOS 3603 11/09/2012
[ 8910.080759] RIP: 0010:btrfs_run_delayed_refs+0x18b/0x1e0 [btrfs]
[ 8910.080761] Code: 41 5f c3 49 8b 54 24 50 f0 48 0f ba aa 90 1b 00 00 02 =
72 1b 83 f8 fb 74 34 89 c6 48 c7 c7 50 26 f0 a1 89 04 24 e8 90 0a 27 df <0f=
> 0b 8b 04 24 89 c1 ba a2 08 00 00 4c 89 e7 89 04 24 48 c7 c6 a0
[ 8910.080763] RSP: 0018:ffffc90008e27ab8 EFLAGS: 00010286
[ 8910.080764] RAX: 0000000000000000 RBX: ffff8882325361a0 RCX: 00000000000=
00001
[ 8910.080765] RDX: 0000000080000001 RSI: ffffffff8112da21 RDI: 00000000fff=
fffff
[ 8910.080766] RBP: ffff8883f531c000 R08: 0000000000000000 R09: 00000000000=
00001
[ 8910.080767] R10: 0000000000000000 R11: ffffc90008e27965 R12: ffff8882325=
361a0
[ 8910.080768] R13: ffff888364331800 R14: ffff8882325361a0 R15: 00000000000=
01dc4
[ 8910.080770] FS:  00007f93605b18c0(0000) GS:ffff88840ec40000(0000) knlGS:=
0000000000000000
[ 8910.080771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8910.080772] CR2: 00000000014ba2c8 CR3: 0000000260d86001 CR4: 00000000000=
606e0
[ 8910.080773] Call Trace:
[ 8910.080790]  btrfs_commit_transaction+0x52/0xa40 [btrfs]
[ 8910.080803]  ? start_transaction+0xcb/0x550 [btrfs]
[ 8910.080819]  relocate_block_group+0x4d1/0x5c0 [btrfs]
[ 8910.080838]  btrfs_relocate_block_group+0x194/0x310 [btrfs]
[ 8910.080854]  btrfs_relocate_chunk+0x31/0xe0 [btrfs]
[ 8910.080869]  btrfs_balance+0x899/0xf70 [btrfs]
[ 8910.080889]  btrfs_ioctl_balance+0x2d4/0x390 [btrfs]
[ 8910.080905]  btrfs_ioctl+0x1652/0x31d0 [btrfs]
[ 8910.080909]  ? _raw_spin_unlock+0x24/0x40
[ 8910.080911]  ? __handle_mm_fault+0xb8d/0x1210
[ 8910.080918]  ? ksys_ioctl+0x81/0xc0
[ 8910.080933]  ? btrfs_ioctl_get_supported_features+0x20/0x20 [btrfs]
[ 8910.080935]  ksys_ioctl+0x81/0xc0
[ 8910.080937]  __x64_sys_ioctl+0x11/0x20
[ 8910.080939]  do_syscall_64+0x4f/0x210
[ 8910.080941]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 8910.080943] RIP: 0033:0x7f93606a8427
[ 8910.080945] Code: 00 00 90 48 8b 05 69 7a 0c 00 64 c7 00 26 00 00 00 48 =
c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 7a 0c 00 f7 d8 64 89 01 48
[ 8910.080946] RSP: 002b:00007ffe33acfc58 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000010
[ 8910.080947] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f93606=
a8427
[ 8910.080949] RDX: 00007ffe33acfce8 RSI: 00000000c4009420 RDI: 00000000000=
00003
[ 8910.080950] RBP: 00007ffe33acfce8 R08: 0000564d2be846b0 R09: 00000000000=
00231
[ 8910.080951] R10: fffffffffffffa4c R11: 0000000000000202 R12: 00000000000=
00003
[ 8910.080952] R13: 00007ffe33ad2746 R14: 0000000000000001 R15: 00000000000=
00001
[ 8910.080957] irq event stamp: 0
[ 8910.080958] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 8910.080961] hardirqs last disabled at (0): [<ffffffff810aff62>] copy_pro=
cess+0xa22/0x1da0
[ 8910.080963] softirqs last  enabled at (0): [<ffffffff810aff62>] copy_pro=
cess+0xa22/0x1da0
[ 8910.080964] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 8910.080965] ---[ end trace 0d99142474b285f7 ]---
[ 8910.080968] BTRFS: error (device dm-5) in btrfs_run_delayed_refs:2210: e=
rrno=3D-28 No space left
[ 8910.080969] BTRFS info (device dm-5): forced readonly
[ 8910.081553] BTRFS info (device dm-5): 1 enospc errors during balance
[ 8910.081554] BTRFS info (device dm-5): balance: ended with status: -30

-----> second <-----

[ 9144.739758] BTRFS info (device dm-5): disk space caching is enabled
[ 9144.739761] BTRFS info (device dm-5): has skinny extents
[ 9146.898605] BTRFS info (device dm-5): checking UUID tree
[ 9147.072175] BTRFS info (device dm-5): balance: resume -mconvert=3Draid1,=
soft -sconvert=3Draid1,soft
[ 9147.092146] BTRFS info (device dm-5): relocating block group 93418579558=
4 flags metadata|dup
[ 9147.993117] ------------[ cut here ]------------
[ 9147.993121] BTRFS: Transaction aborted (error -28)
[ 9147.993158] WARNING: CPU: 1 PID: 8924 at fs/btrfs/extent-tree.c:3106 __b=
trfs_free_extent.isra.47+0x5a9/0x940 [btrfs]
[ 9147.993159] Modules linked in: uas usb_storage rfcomm fuse cpufreq_power=
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
[ 9147.993183]  fb_sys_fops cfbcopyarea fb font fbdev drm drm_panel_orienta=
tion_quirks nvidia_modeset(O) nft_redir nvidia(O) i2c_core nf_tables_set nf=
t_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_counter n=
f_tables nfnetlink nfsd auth_rpcgss nfs_acl lockd grace sunrpc loop firewir=
e_sbp2 firewire_core crc_itu_t ecryptfs autofs4 input_leds raid10 raid456 l=
ibcrc32c async_raid6_recov async_memcpy async_pq raid6_pq async_xor xor asy=
nc_tx raid0 multipath linear e1000e video backlight
[ 9147.993199] CPU: 1 PID: 8924 Comm: btrfs-balance Tainted: G        W  O =
     5.6.15mq+ #376
[ 9147.993200] Hardware name: System manufacturer System Product Name/P8Z68=
-V PRO, BIOS 3603 11/09/2012
[ 9147.993211] RIP: 0010:__btrfs_free_extent.isra.47+0x5a9/0x940 [btrfs]
[ 9147.993213] Code: 3c 24 44 89 e9 ba 55 0c 00 00 48 c7 c6 20 a1 ef a1 e8 =
09 c3 0a 00 e9 23 ff ff ff 44 89 ee 48 c7 c7 50 26 f0 a1 e8 b2 29 27 df <0f=
> 0b 48 8b 3c 24 44 89 e9 ba 22 0c 00 00 48 c7 c6 20 a1 ef a1 e8
[ 9147.993214] RSP: 0018:ffffc9000a2cfa80 EFLAGS: 00010282
[ 9147.993216] RAX: 0000000000000000 RBX: ffff8882ec2bc540 RCX: 00000000000=
00001
[ 9147.993217] RDX: 0000000080000001 RSI: ffffffff8112da21 RDI: 00000000fff=
fffff
[ 9147.993218] RBP: 0000000000000001 R08: 0000000000000000 R09: 00000000000=
00001
[ 9147.993219] R10: 0000000000000000 R11: ffffc9000a2cf92d R12: 000000000e5=
b8000
[ 9147.993220] R13: 00000000ffffffe4 R14: 0000000000000000 R15: 00000000000=
00007
[ 9147.993222] FS:  0000000000000000(0000) GS:ffff88840ec40000(0000) knlGS:=
0000000000000000
[ 9147.993223] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9147.993224] CR2: 000056196ee73230 CR3: 00000003a5056005 CR4: 00000000000=
606e0
[ 9147.993225] Call Trace:
[ 9147.993233]  ? _raw_read_unlock+0x24/0x40
[ 9147.993248]  ? btrfs_merge_delayed_refs+0x3b3/0x460 [btrfs]
[ 9147.993260]  __btrfs_run_delayed_refs+0x7a0/0x1310 [btrfs]
[ 9147.993277]  btrfs_run_delayed_refs+0x5b/0x1e0 [btrfs]
[ 9147.993290]  btrfs_commit_transaction+0x52/0xa40 [btrfs]
[ 9147.993303]  ? start_transaction+0xcb/0x550 [btrfs]
[ 9147.993319]  relocate_block_group+0x4d1/0x5c0 [btrfs]
[ 9147.993337]  btrfs_relocate_block_group+0x194/0x310 [btrfs]
[ 9147.993353]  btrfs_relocate_chunk+0x31/0xe0 [btrfs]
[ 9147.993368]  btrfs_balance+0x899/0xf70 [btrfs]
[ 9147.993388]  ? btrfs_balance+0xf70/0xf70 [btrfs]
[ 9147.993402]  balance_kthread+0x31/0x50 [btrfs]
[ 9147.993405]  kthread+0x10e/0x130
[ 9147.993406]  ? kthread_park+0x80/0x80
[ 9147.993409]  ret_from_fork+0x3a/0x50
[ 9147.993414] irq event stamp: 0
[ 9147.993415] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 9147.993418] hardirqs last disabled at (0): [<ffffffff810aff62>] copy_pro=
cess+0xa22/0x1da0
[ 9147.993420] softirqs last  enabled at (0): [<ffffffff810aff62>] copy_pro=
cess+0xa22/0x1da0
[ 9147.993421] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 9147.993422] ---[ end trace 0d99142474b285f8 ]---
[ 9147.993424] BTRFS: error (device dm-5) in __btrfs_free_extent:3106: errn=
o=3D-28 No space left
[ 9147.993426] BTRFS info (device dm-5): forced readonly
[ 9147.993429] BTRFS: error (device dm-5) in btrfs_run_delayed_refs:2210: e=
rrno=3D-28 No space left
[ 9147.994013] BTRFS info (device dm-5): 1 enospc errors during balance
[ 9147.994015] BTRFS info (device dm-5): balance: ended with status: -30

