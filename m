Return-Path: <linux-btrfs+bounces-20182-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C85F2CFB30A
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 23:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DE60305EE45
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 22:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E0119C54E;
	Tue,  6 Jan 2026 22:02:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C530224FA
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 22:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767736940; cv=none; b=E8eTqLbHHWntx/y8kF23pOFjKd/G9Coaj9TzBJNHUS5pRf23EaWzI4T8PmBdgyETLPABMVR+uek/DRuoLgR8D46VTy8HYjzt6ynKAf7IjFGtugF1ss+4WWg75PnNKcl2bg5BIAcq0re8DOM/tV58hVZplFmpomxY5NoCE93TklQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767736940; c=relaxed/simple;
	bh=upoVqe4Ldq4kImGXCAHpgY/8J7N9JnITFTHwkUO7po4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To; b=XVAH+HO4d2Ms33DF4cl8gluYH7RAn/reuHw++OC+N4nQsLY3xVD1hSA931X27VZ6oYgfGbC5TcpWEZjXkK4EZ1wM7bBXICzkNd0/tzzdbpjIZdZ2dBft4/LJSZsjT+Zo7KSwXaiudv9MCh6VJ5hLEbcoNTmlNi77VnwHSzAcXOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solnickfarrell.co.uk; spf=pass smtp.mailfrom=solnickfarrell.co.uk; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solnickfarrell.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solnickfarrell.co.uk
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <gideon@solnickfarrell.co.uk>)
	id 1vdF7w-002SY2-4d
	for linux-btrfs@vger.kernel.org; Tue, 06 Jan 2026 23:02:08 +0100
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <gideon@solnickfarrell.co.uk>)
	id 1vdF7v-0000bt-RN
	for linux-btrfs@vger.kernel.org; Tue, 06 Jan 2026 23:02:07 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (880355)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vdF7p-005QMR-HP
	for linux-btrfs@vger.kernel.org; Tue, 06 Jan 2026 23:02:02 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=8d5eb6bfd44ca6cca8b04046e6f2b72e280f5c365ca7a3dd6ae394173b9e;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 06 Jan 2026 22:01:58 +0000
Message-Id: <DFHUFTKLUCB5.11QUC5R2L77DO@solnickfarrell.co.uk>
Subject: refcount_warn_saturate in __btrfs_release_delayed_node for
 6.18.2-arch2-1
From: "Gideon Farrell" <gideon@solnickfarrell.co.uk>
To: <linux-btrfs@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2

--8d5eb6bfd44ca6cca8b04046e6f2b72e280f5c365ca7a3dd6ae394173b9e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi there,

I recently experienced a type of crash I haven't seen before on this system=
 which seems to originate in __btrfs_release_delayed_node on Kernel 6.18.2-=
arch2-1.

Here's the stack trace:

```
Jan 06 16:46:07 leviathan kernel: ------------[ cut here ]------------
Jan 06 16:46:07 leviathan kernel: refcount_t: saturated; leaking memory.
Jan 06 16:46:07 leviathan kernel: WARNING: CPU: 5 PID: 299428 at lib/refcou=
nt.c:22 refcount_warn_saturate+0x55/0x110
Jan 06 16:46:07 leviathan kernel: Modules linked in: uinput uas usb_storage=
 rfcomm tun ip6table_nat ip6table_filter ip6_tables iptable_nat iptable_fil=
ter ip_tables x_tables cmac algif_hash algif_skcipher af_alg bnep 8021q gar=
p mrp stp llc vfat fat amd_atl intel_rapl_msr intel_rapl_common mt7921e snd=
_hda_codec_atihdmi mt7921_common snd_hda_codec_hdmi mt792x_lib snd_hda_inte=
l mt76_connac_lib uvcvideo kvm_amd snd_hda_codec mt76 videobuf2_vmalloc snd=
_usb_audio uvc btusb snd_hda_core snd_usbmidi_lib videobuf2_memops kvm btmt=
k asus_nb_wmi snd_ump snd_intel_dspcfg videobuf2_v4l2 btrtl asus_wmi mac802=
11 snd_rawmidi spd5118 asus_ec_sensors snd_intel_sdw_acpi btbcm videobuf2_c=
ommon platform_profile irqbypass snd_hwdep snd_seq_device btintel sp5100_tc=
o rapl pcspkr videodev snd_pcm sparse_keymap wmi_bmof cfg80211 bluetooth sn=
d_timer i2c_piix4 igc snd k10temp i2c_smbus soundcore ptp mousedev mc joyde=
v rfkill libarc4 pps_core wacom gpio_amdpt gpio_generic mac_hid nft_reject_=
inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_chain_nat nf_nat nf_connt=
rack
Jan 06 16:46:07 leviathan kernel:  nf_defrag_ipv6 nf_defrag_ipv4 nf_tables =
crypto_user pkcs8_key_parser ntsync nfnetlink dm_crypt encrypted_keys trust=
ed asn1_encoder tee dm_mod hid_logitech_hidpp amdgpu amdxcp i2c_algo_bit dr=
m_ttm_helper ttm drm_exec drm_panel_backlight_quirks gpu_sched drm_suballoc=
_helper drm_buddy nvme polyval_clmulni hid_logitech_dj drm_display_helper g=
hash_clmulni_intel nvme_core ccp cec aesni_intel video nvme_keyring nvme_au=
th hkdf wmi
Jan 06 16:46:07 leviathan kernel: CPU: 5 UID: 0 PID: 299428 Comm: kworker/u=
97:4 Tainted: G        W           6.18.2-arch2-1 #1 PREEMPT(full)  e9d53cd=
e2ee9d1bdaa4464d2214ad0f22bd43723
Jan 06 16:46:07 leviathan kernel: Tainted: [W]=3DWARN
Jan 06 16:46:07 leviathan kernel: Hardware name: ASUS System Product Name/R=
OG STRIX B650E-I GAMING WIFI, BIOS 3057 10/29/2024
Jan 06 16:46:07 leviathan kernel: Workqueue: btrfs-delalloc btrfs_work_help=
er
Jan 06 16:46:07 leviathan kernel: RIP: 0010:refcount_warn_saturate+0x55/0x1=
10
Jan 06 16:46:07 leviathan kernel: Code: 84 bc 00 00 00 e9 76 ff 56 ff 85 f6=
 74 46 80 3d b4 ce ae 01 00 75 ee 48 c7 c7 60 4a 5d 8f c6 05 a4 ce ae 01 01=
 e8 4b 7d 7b ff <0f> 0b e9 4f ff 56 ff 80 3d 8d ce ae 01 00 75 cb 48 c7 c7 =
10 4b 5d
Jan 06 16:46:07 leviathan kernel: RSP: 0018:ffffcff6e1687b90 EFLAGS: 000102=
46
Jan 06 16:46:07 leviathan kernel: RAX: 0000000000000000 RBX: ffff8e330174b1=
10 RCX: 0000000000000027
Jan 06 16:46:07 leviathan kernel: RDX: ffff8e41de15d008 RSI: 00000000000000=
01 RDI: ffff8e41de15d000
Jan 06 16:46:07 leviathan kernel: RBP: ffff8e32d3349060 R08: 00000000000000=
00 R09: 00000000ffffdfff
Jan 06 16:46:07 leviathan kernel: R10: ffffffff90bbaa40 R11: ffffcff6e1687a=
28 R12: 0000000000020000
Jan 06 16:46:07 leviathan kernel: R13: 0000000000000000 R14: ffff8e330174b2=
28 R15: 0000000000000000
Jan 06 16:46:07 leviathan kernel: FS:  0000000000000000(0000) GS:ffff8e424d=
632000(0000) knlGS:0000000000000000
Jan 06 16:46:07 leviathan kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
Jan 06 16:46:07 leviathan kernel: CR2: 000033b723ba6004 CR3: 0000000024a240=
00 CR4: 0000000000f50ef0
Jan 06 16:46:07 leviathan kernel: PKRU: 55555554
Jan 06 16:46:07 leviathan kernel: Call Trace:
Jan 06 16:46:07 leviathan kernel:  <TASK>
Jan 06 16:46:07 leviathan kernel:  __btrfs_release_delayed_node.part.0+0x2e=
7/0x310
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  btrfs_delayed_update_inode+0xf5/0x1e0
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? btrfs_update_root_times+0x75/0xa0
Jan 06 16:46:07 leviathan kernel:  btrfs_update_inode+0x59/0xc0
Jan 06 16:46:07 leviathan kernel:  __cow_file_range_inline+0x16c/0x3f0
Jan 06 16:46:07 leviathan kernel:  cow_file_range_inline.constprop.0+0xd7/0=
x140
Jan 06 16:46:07 leviathan kernel:  compress_file_range+0x3d6/0x5c0
Jan 06 16:46:07 leviathan kernel:  ? __pfx_submit_compressed_extents+0x10/0=
x10
Jan 06 16:46:07 leviathan kernel:  btrfs_work_helper+0xe1/0x380
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  process_one_work+0x193/0x350
Jan 06 16:46:07 leviathan kernel:  worker_thread+0x2d7/0x410
Jan 06 16:46:07 leviathan kernel:  ? __pfx_worker_thread+0x10/0x10
Jan 06 16:46:07 leviathan kernel:  kthread+0xfc/0x240
Jan 06 16:46:07 leviathan kernel:  ? __pfx_kthread+0x10/0x10
Jan 06 16:46:07 leviathan kernel:  ? __pfx_kthread+0x10/0x10
Jan 06 16:46:07 leviathan kernel:  ret_from_fork+0x1c2/0x1f0
Jan 06 16:46:07 leviathan kernel:  ? __pfx_kthread+0x10/0x10
Jan 06 16:46:07 leviathan kernel:  ret_from_fork_asm+0x1a/0x30
Jan 06 16:46:07 leviathan kernel:  </TASK>
Jan 06 16:46:07 leviathan kernel: ---[ end trace 0000000000000000 ]---
Jan 06 16:46:07 leviathan kernel: ------------[ cut here ]------------
Jan 06 16:46:07 leviathan kernel: refcount_t: decrement hit 0; leaking memo=
ry.
Jan 06 16:46:07 leviathan kernel: WARNING: CPU: 5 PID: 327490 at lib/refcou=
nt.c:31 refcount_warn_saturate+0xff/0x110
Jan 06 16:46:07 leviathan kernel: Modules linked in: uinput uas usb_storage=
 rfcomm tun ip6table_nat ip6table_filter ip6_tables iptable_nat iptable_fil=
ter ip_tables x_tables cmac algif_hash algif_skcipher af_alg bnep 8021q gar=
p mrp stp llc vfat fat amd_atl intel_rapl_msr intel_rapl_common mt7921e snd=
_hda_codec_atihdmi mt7921_common snd_hda_codec_hdmi mt792x_lib snd_hda_inte=
l mt76_connac_lib uvcvideo kvm_amd snd_hda_codec mt76 videobuf2_vmalloc snd=
_usb_audio uvc btusb snd_hda_core snd_usbmidi_lib videobuf2_memops kvm btmt=
k asus_nb_wmi snd_ump snd_intel_dspcfg videobuf2_v4l2 btrtl asus_wmi mac802=
11 snd_rawmidi spd5118 asus_ec_sensors snd_intel_sdw_acpi btbcm videobuf2_c=
ommon platform_profile irqbypass snd_hwdep snd_seq_device btintel sp5100_tc=
o rapl pcspkr videodev snd_pcm sparse_keymap wmi_bmof cfg80211 bluetooth sn=
d_timer i2c_piix4 igc snd k10temp i2c_smbus soundcore ptp mousedev mc joyde=
v rfkill libarc4 pps_core wacom gpio_amdpt gpio_generic mac_hid nft_reject_=
inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_chain_nat nf_nat nf_connt=
rack
Jan 06 16:46:07 leviathan kernel:  nf_defrag_ipv6 nf_defrag_ipv4 nf_tables =
crypto_user pkcs8_key_parser ntsync nfnetlink dm_crypt encrypted_keys trust=
ed asn1_encoder tee dm_mod hid_logitech_hidpp amdgpu amdxcp i2c_algo_bit dr=
m_ttm_helper ttm drm_exec drm_panel_backlight_quirks gpu_sched drm_suballoc=
_helper drm_buddy nvme polyval_clmulni hid_logitech_dj drm_display_helper g=
hash_clmulni_intel nvme_core ccp cec aesni_intel video nvme_keyring nvme_au=
th hkdf wmi
Jan 06 16:46:07 leviathan kernel: CPU: 5 UID: 1000 PID: 327490 Comm: Backgr=
o~ol #189 Tainted: G        W           6.18.2-arch2-1 #1 PREEMPT(full)  e9=
d53cde2ee9d1bdaa4464d2214ad0f22bd43723
Jan 06 16:46:07 leviathan kernel: Tainted: [W]=3DWARN
Jan 06 16:46:07 leviathan kernel: Hardware name: ASUS System Product Name/R=
OG STRIX B650E-I GAMING WIFI, BIOS 3057 10/29/2024
Jan 06 16:46:07 leviathan kernel: RIP: 0010:refcount_warn_saturate+0xff/0x1=
10
Jan 06 16:46:07 leviathan kernel: Code: 88 4a 5d 8f c6 05 13 ce ae 01 01 e8=
 bb 7c 7b ff 0f 0b e9 bf fe 56 ff 48 c7 c7 e0 4a 5d 8f c6 05 f7 cd ae 01 01=
 e8 a1 7c 7b ff <0f> 0b e9 a5 fe 56 ff 66 2e 0f 1f 84 00 00 00 00 00 90 90 =
90 90 90
Jan 06 16:46:07 leviathan kernel: RSP: 0018:ffffcff6eed07868 EFLAGS: 000102=
46
Jan 06 16:46:07 leviathan kernel: RAX: 0000000000000000 RBX: ffff8e330174b1=
10 RCX: 0000000000000027
Jan 06 16:46:07 leviathan kernel: RDX: ffff8e41de15d008 RSI: 00000000000000=
01 RDI: ffff8e41de15d000
Jan 06 16:46:07 leviathan kernel: RBP: ffff8e32d3349060 R08: 00000000000000=
00 R09: 00000000ffffdfff
Jan 06 16:46:07 leviathan kernel: R10: ffffffff90bbaa40 R11: ffffcff6eed077=
00 R12: 0000000000000000
Jan 06 16:46:07 leviathan kernel: R13: ffff8e32d35393f0 R14: ffff8e330174b2=
28 R15: 0000000000000000
Jan 06 16:46:07 leviathan kernel: FS:  00007fb4ae5e56c0(0000) GS:ffff8e424d=
632000(0000) knlGS:00007fa800000000
Jan 06 16:46:07 leviathan kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
Jan 06 16:46:07 leviathan kernel: CR2: 00007f87aaf44000 CR3: 000000012615c0=
00 CR4: 0000000000f50ef0
Jan 06 16:46:07 leviathan kernel: PKRU: 55555554
Jan 06 16:46:07 leviathan kernel: Call Trace:
Jan 06 16:46:07 leviathan kernel:  <TASK>
Jan 06 16:46:07 leviathan kernel:  __btrfs_release_delayed_node.part.0+0x2f=
6/0x310
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? balance_dirty_pages_ratelimited_flags+=
0x190/0x380
Jan 06 16:46:07 leviathan kernel:  btrfs_commit_inode_delayed_inode+0xda/0x=
120
Jan 06 16:46:07 leviathan kernel:  btrfs_evict_inode+0x286/0x3e0
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? xas_load+0xd/0xd0
Jan 06 16:46:07 leviathan kernel:  evict+0x117/0x290
Jan 06 16:46:07 leviathan kernel:  __dentry_kill+0x6b/0x190
Jan 06 16:46:07 leviathan kernel:  dput+0xeb/0x1c0
Jan 06 16:46:07 leviathan kernel:  do_renameat2+0x41e/0x580
Jan 06 16:46:07 leviathan kernel:  __x64_sys_rename+0x7a/0xc0
Jan 06 16:46:07 leviathan kernel:  do_syscall_64+0x81/0x7f0
Jan 06 16:46:07 leviathan kernel:  ? __mark_inode_dirty+0x273/0x350
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? btrfs_block_rsv_release+0x105/0x1f0
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? __btrfs_qgroup_free_meta+0x2b/0x160
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? btrfs_inode_rsv_release+0x60/0xf0
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? btrfs_drop_folio+0x3c/0x60
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? btrfs_buffered_write+0x527/0x8a0
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? vfs_write+0x2e6/0x480
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? xas_load+0xd/0xd0
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? xa_load+0x76/0xb0
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? refill_obj_stock+0x12e/0x240
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? __memcg_slab_free_hook+0xf4/0x140
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? kmem_cache_free+0x549/0x5d0
Jan 06 16:46:07 leviathan kernel:  ? __x64_sys_close+0x3d/0x80
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? __x64_sys_close+0x3d/0x80
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? do_syscall_64+0x81/0x7f0
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  ? switch_fpu_return+0x4e/0xd0
Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Jan 06 16:46:07 leviathan kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jan 06 16:46:07 leviathan kernel: RIP: 0033:0x7fb53e460adb
Jan 06 16:46:07 leviathan kernel: Code: c0 48 8b 5d f8 c9 c3 0f 1f 84 00 00=
 00 00 00 b8 ff ff ff ff eb eb 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 52=
 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 01 72 1a =
00 f7 d8
Jan 06 16:46:07 leviathan kernel: RSP: 002b:00007fb4ae5e3d88 EFLAGS: 000002=
46 ORIG_RAX: 0000000000000052
Jan 06 16:46:07 leviathan kernel: RAX: ffffffffffffffda RBX: 00000000000000=
55 RCX: 00007fb53e460adb
Jan 06 16:46:07 leviathan kernel: RDX: 0000000000000055 RSI: 00007fb4ae5e3d=
90 RDI: 00007fb4ae5e3f10
Jan 06 16:46:07 leviathan kernel: RBP: 00007fb4ae5e4100 R08: 80808080808080=
80 R09: 0101010101010100
Jan 06 16:46:07 leviathan kernel: R10: fffefffffefffcff R11: 00000000000002=
46 R12: 00007fb4ae5e3d90
Jan 06 16:46:07 leviathan kernel: R13: 0000000000000054 R14: 00007fb4717407=
90 R15: 00007fb4ae5e3f10
Jan 06 16:46:07 leviathan kernel:  </TASK>
Jan 06 16:46:07 leviathan kernel: ---[ end trace 0000000000000000 ]---
```

~gtf

--8d5eb6bfd44ca6cca8b04046e6f2b72e280f5c365ca7a3dd6ae394173b9e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEh8X06naLl+68LpNrY7uIhCIXbKQFAmldhlkACgkQY7uIhCIX
bKQJ1Av9G4L5HgYzTEeSyIRwstJRjwPzMdI5THignHlBVjp3d+Z45nAZg15Wkwqu
EAzOHnkDCMwGN8O4XZpKBu3uiyBoy4ZQQEU6xVBERI8UdSP6R+LJt24rTyEDN/y6
LMUBfN40Uza4S2tkqwENwbakQ0Nf2yx68IcwJqJbPtMuEix6dfT5CU5+jc9+xDYO
LeuTBBw3LJXP7nAbKeHqI0MhSH6N+5hMXGJ2CWAu/BHmIkWg45F/asqXpY90EOjz
8JykpmWZcveJdAdFT77xySE9dHcPAwQ4KUxMxogEWIcC4ZxiyEZBBZnMUU4cMHkS
czd2jMEWCIUmDbIM8joC5CNhMsa93kgSYv6AvS0IHuXxIjXAJMYjnQVSw0+G4b3V
JO0QTfYYtu0aUmNKsttO+NZ9T7hyZvXBmZAoaOrbuW4iklz7dQfM0OWOLRKQYJmY
7nXEqT/fxPCwl5teJpEROoXl0nIdmSTyr29OaxEt+aDYB6y3Sxmsq9wCETU0YjxS
em1d3q7e
=ufdu
-----END PGP SIGNATURE-----

--8d5eb6bfd44ca6cca8b04046e6f2b72e280f5c365ca7a3dd6ae394173b9e--

