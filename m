Return-Path: <linux-btrfs+bounces-19632-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C46CCB4700
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 02:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67F013029C44
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 01:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93572C0F92;
	Thu, 11 Dec 2025 01:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="0Gg8ld9c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hRU5eIMN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDEC2C0F7F
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765416541; cv=none; b=cZeZJRohcv9td6XyubZdBQqfiYnLmCUsF18VFioZWP1zo2+5yIg30usBdq1rHwdpKyPnXX91DaVkA+9DzB4tAGeWtnvaHVfwQSuNtMsfrd8RMl/kb60hmkiRf0Wcew7yFyVuIKj6Je1z5/39almSvYX3wEOibsHxHhOGNPjHvMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765416541; c=relaxed/simple;
	bh=7ElfktT9sDNZv6EYfZ9Tmk+YNSv9YOo5kKRg/1eEusU=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=EKpTIVgwHMfB0YO4NeF2+44od5+kHN5IHoE/8BYm/3VWvMvI7V3edcgfXT3mCNBAjXbOvqZU5XdKpqLtfoJo7cvKqL+2o00dk6GzPwNlS34TrmDWnapfM6Y3a8BjFJcy+kds+X1uMnL9MUuLRqp9cMft6r9FF+21SjdHkqYBRnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=0Gg8ld9c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hRU5eIMN; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F6EF14000FA
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 20:28:57 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Wed, 10 Dec 2025 20:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm2; t=
	1765416537; x=1765502937; bh=MuAiHAma0UG4ksmdpLZq4cstWJ2DWUvzvHp
	4AaeHzaw=; b=0Gg8ld9c4zzaZjaEZ/DLzRqrmv0WeimZhhWUcgQYS7upw5Af2t9
	ni3p4ZIxv1DoiVrKQvKosv8g/F8VvkU9f9sjsvbvEk0f7mUuEnkbcrKanSVrmPys
	swjwBIUpmO87M76OQUwKP2p5L2+rwePtOhhBLkGl7OVwMCnRQdWwFXkYbIvFcvIw
	CDhzYZOe8X9g5UP3vFy67PoMXB2ZgbkCaNr6997IlL8CiBx4l3Ux1Ie5Jj8Ylvla
	Ev9s0YwhoSlWl2k2qvyasuv8GZnFiMbFTyHC9aBSS8AvFrJ6JlPjbdO2YL8imYCW
	8rOtqKwHMX8JpUnT+XlcTkP5wVOQ4HiHP5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765416537; x=1765502937; bh=MuAiHAma0UG4ksmdpLZq4cstWJ2DWUvzvHp
	4AaeHzaw=; b=hRU5eIMN/2l831HBYRUPaZc8d1OMIv1RPf7iwH5pT47GX2Y+RVn
	aJbznPOdvhYnXcxHPXe3lyiX2HYc3hK/EZtO/bnVug/l3pYS+gwI54ozvOB6wvZQ
	7RmvGd41FuIA6HLk/pA3k+5bCm2T75spikuGtB8+YI8BKP4MVNHa9TBMXS7zYWN0
	5ZEDW5zfpDaMAVlsdIsQq/33u3etH590K+XHpsYn2dAQ5fWoz/OAFLEtAiSNmrdN
	gC6psB9KTJfrd7tynnlNb7SLkU+kO8L3WJ/HUpPUsXv0TM8N1IbB8xXzh7PKPBEd
	iBwf7g1byfOb0Y5ZsF2w12uxSsi84DhS0vQ==
X-ME-Sender: <xms:WB46aZmiBAU8JkoKFZyLO24kUkecTgYWXQhSengp-LYdhgqMzWxEPg>
    <xme:WB46afqEqbsZ6BuzubFngTlyhFzvulDFgSIlPeITJwLlPEykOf0NBslNqLAvP-Oqv
    4gqPTWnlZGZ2chp1UF94H3LzVBswfsHvIqzxkvrKqT2RAWBDSDjt_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkffutgfgsehtqhertdertddtnecuhfhrohhmpedfvehhrhhishcuofhu
    rhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenucggtf
    frrghtthgvrhhnpeegheejtedvvdduhfetkeefvdeigedvveffvdejvdehiefggedvtdek
    vdfggffgkeenucffohhmrghinheprhgvughhrghtrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghm
    vgguihgvshdrtghomhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WB46abUCb_0OxfyhSbCMYspv5Y0tcscWBO15X6CGeCW8vHq0al0Xfg>
    <xmx:WR46aThGBIKc74CHWvUQJlVcQc-oNhwtrhnV_0fXeAM98qPVJn7mVw>
    <xmx:WR46aUQrrR_4hF_bj7eAx6Lmo-rpoQXP9yoXjXHSGpRR-UzzbrLPQA>
    <xmx:WR46aeFw9a3aiorMUf7ttFYWBBaEiF26-2hiIV5Tqf0FlVsQpPadzw>
    <xmx:WR46aRqcxk9Dd4TM32QqEXI1Ub_63SZiObtiYuGZ6QzUF9dB7jaitvb->
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E065918C004E; Wed, 10 Dec 2025 20:28:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Dec 2025 18:28:36 -0700
From: "Chris Murphy" <lists@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <e2095d93-fa47-46b2-b894-0918b6ce348c@app.fastmail.com>
Subject: kernel 6.17 and 6.18, WARNING: CPU: 5 PID: 7181 at fs/btrfs/inode.c:4297
 __btrfs_unlink_inode, forced readonly
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

User reports root file system going read-only at some point after startu=
p. Seems to be when a Firefox cache file is accessed.

Initial report is kernel 6.17.8-300.fc43.x86_64, but the problem also ha=
ppens with 6.18.0-65.fc44.x86_64.

User previously discovered bad RAM and has replaced it, so I guess it's =
possible we have a bad write that made it to disk despite write time tre=
e checker (?) and now can't handle the issue when reading the file. But =
I haven't seen this kind of error or call trace before, so I'm not sure =
what to recommend next. If --repair can fix it.

Downstream bug is here, which has the complete dmesg attached:
https://bugzilla.redhat.com/show_bug.cgi?id=3D2421293

$ sudo btrfs check -p --readonly /dev/sda3
Opening filesystem to check...
Checking filesystem on /dev/sda3
UUID: afdbb979-0b91-499b-976c-0244ba2ed38f
[1/8] checking log skipped (none written)
[1/7] checking root items                      (0:00:00 elapsed, 659535 =
items checked)
[2/7] checking extents                         (0:00:03 elapsed, 59194 i=
tems checked)
We have a space info key for a block group that doesn't existed)
[3/7] checking free space tree                 (0:00:00 elapsed, 172 ite=
ms checked)
[4/7] chunresolved ref dir 1924 index 134016 namelen 40 name AC1E6A9C763=
DC6BC77494D6E8DE724C240D36C9E filetype 1 errors 4, no inode ref
[4/7] checking fs roots                        (0:00:02 elapsed, 45654 i=
tems checked)
ERROR: errors found in fs roots
found 140957597696 bytes used, error(s) found
total csum bytes: 136358540
total tree bytes: 969637888
total fs tree bytes: 750862336
total extent tree bytes: 62783488
btree space waste bytes: 178909301
file data blocks allocated: 488208621568
 referenced 162958045184


dmesg excerpt

[  126.803576] BTRFS critical (device sda3): failed to delete reference =
to AC1E6A9C763DC6BC77494D6E8DE724C240D36C9E, root 256 inode 730455 paren=
t 1924
[  126.803583] ------------[ cut here ]------------
[  126.803584] BTRFS: Transaction aborted (error -2)
[  126.803590] WARNING: CPU: 5 PID: 7181 at fs/btrfs/inode.c:4297 __btrf=
s_unlink_inode+0x416/0x440
[  126.803596] Modules linked in: vfat fat exfat uinput rfcomm snd_seq_d=
ummy snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_=
inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf=
_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defr=
ag_ipv6 nf_defrag_ipv4 nf_tables qrtr bnep iwlmvm mac80211 libarc4 snd_h=
da_codec_alc882 snd_hda_codec_realtek_lib snd_usb_audio snd_hda_codec_ge=
neric snd_hda_codec_atihdmi btusb iwlwifi snd_hda_codec_hdmi btmtk snd_h=
da_intel btrtl amd_atl snd_hda_codec btbcm intel_rapl_msr intel_rapl_com=
mon btintel snd_usbmidi_lib snd_hda_core mc cfg80211 snd_intel_dspcfg sn=
d_ump snd_intel_sdw_acpi bluetooth snd_rawmidi snd_hwdep edac_mce_amd sn=
d_seq snd_seq_device kvm_amd eeepc_wmi snd_pcm asus_wmi snd_timer snd ee=
1004 sparse_keymap kvm platform_profile wmi_bmof joydev soundcore rfkill=
 i2c_piix4 gpio_amdpt irqbypass k10temp i2c_smbus pcspkr gpio_generic ra=
pl tun zram lz4hc_compress lz4_compress overlay erofs netfs isofs amdgpu=
 hid_logitech_hidpp amdxcp
[  126.803693]  drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_h=
elper ttm video drm_exec i2c_algo_bit drm_suballoc_helper drm_display_he=
lper r8169 uas polyval_clmulni cec ghash_clmulni_intel usb_storage realt=
ek sp5100_tco nvme nvme_tcp nvme_fabrics wmi hid_logitech_dj nvme_core n=
vme_keyring nvme_auth hkdf sunrpc be2iscsi bnx2i cnic uio cxgb4i cxgb4 t=
ls cxgb3i cxgb3 mdio libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp=
 libiscsi_tcp libiscsi scsi_transport_iscsi loop fuse i2c_dev nfnetlink
[  126.803747] CPU: 5 UID: 1000 PID: 7181 Comm: rm Not tainted 6.18.0-65=
.fc44.x86_64 #1 PREEMPT(lazy)=20
[  126.803750] Hardware name: MM-Vision Computer/TUF B450M-PLUS GAMING, =
BIOS 4604 03/22/2024
[  126.803752] RIP: 0010:__btrfs_unlink_inode+0x416/0x440
[  126.803755] Code: bc 89 04 24 e8 5b 61 9e ff 0f 0b 8b 04 24 41 b8 01 =
00 00 00 e9 b7 d8 86 ff 89 c6 48 c7 c7 28 49 a4 bc 89 04 24 e8 3a 61 9e =
ff <0f> 0b 8b 04 24 41 b8 01 00 00 00 e9 6e d8 86 ff b8 f4 ff ff ff e9
[  126.803757] RSP: 0018:ffffd1e8926c7b48 EFLAGS: 00010246
[  126.803760] RAX: 0000000000000000 RBX: ffff8f351fbdfc00 RCX: 00000000=
00000027
[  126.803762] RDX: ffff8f36dec9cfc8 RSI: 0000000000000001 RDI: ffff8f36=
dec9cfc0
[  126.803764] RBP: ffff8f34c79b4400 R08: 0000000000000000 R09: ffffd1e8=
926c79f0
[  126.803765] R10: ffffffffbd53c268 R11: 00000000ffffdfff R12: ffff8f34=
fbb818c0
[  126.803767] R13: ffff8f34c7aaa1f8 R14: ffff8f33c564f800 R15: ffffd1e8=
926c7bc0
[  126.803769] FS:  00007ff6c7bc7740(0000) GS:ffff8f37208aa000(0000) knl=
GS:0000000000000000
[  126.803771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  126.803773] CR2: 000055cce3131618 CR3: 00000001ef110000 CR4: 00000000=
00f50ef0
[  126.803775] PKRU: 55555554
[  126.803777] Call Trace:
[  126.803779]  <TASK>
[  126.803785]  btrfs_unlink+0xd9/0x150
[  126.803790]  vfs_unlink+0x117/0x2a0
[  126.803795]  do_unlinkat+0x268/0x2f0
[  126.803801]  __x64_sys_unlinkat+0x61/0xd0
[  126.803803]  do_syscall_64+0x7e/0x7f0
[  126.803807]  ? charge_memcg+0x48/0x80
[  126.803811]  ? srso_alias_return_thunk+0x5/0xfbef5
[  126.803814]  ? blk_cgroup_congested+0x65/0x70
[  126.803818]  ? srso_alias_return_thunk+0x5/0xfbef5
[  126.803821]  ? srso_alias_return_thunk+0x5/0xfbef5
[  126.803823]  ? __lruvec_stat_mod_folio+0x85/0xd0
[  126.803827]  ? srso_alias_return_thunk+0x5/0xfbef5
[  126.803829]  ? srso_alias_return_thunk+0x5/0xfbef5
[  126.803832]  ? set_ptes.isra.0+0x36/0x80
[  126.803835]  ? srso_alias_return_thunk+0x5/0xfbef5
[  126.803838]  ? do_anonymous_page+0x100/0x490
[  126.803842]  ? srso_alias_return_thunk+0x5/0xfbef5
[  126.803844]  ? __handle_mm_fault+0x551/0x6a0
[  126.803849]  ? srso_alias_return_thunk+0x5/0xfbef5
[  126.803852]  ? count_memcg_events+0xd6/0x220
[  126.803856]  ? srso_alias_return_thunk+0x5/0xfbef5
[  126.803858]  ? handle_mm_fault+0x248/0x360
[  126.803861]  ? srso_alias_return_thunk+0x5/0xfbef5
[  126.803864]  ? srso_alias_return_thunk+0x5/0xfbef5
[  126.803866]  ? srso_alias_return_thunk+0x5/0xfbef5
[  126.803869]  ? do_syscall_64+0xb6/0x7f0
[  126.803871]  ? srso_alias_return_thunk+0x5/0xfbef5
[  126.803874]  ? do_user_addr_fault+0x21a/0x690
[  126.803878]  ? srso_alias_return_thunk+0x5/0xfbef5
[  126.803881]  ? srso_alias_return_thunk+0x5/0xfbef5
[  126.803883]  ? irqentry_exit_to_user_mode+0x2c/0x1c0
[  126.803886]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  126.803889] RIP: 0033:0x7ff6c7cb314b
[  126.803908] Code: 77 05 c3 0f 1f 40 00 48 8b 15 a9 fc 0f 00 f7 d8 64 =
89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 07 01 00 00 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 7d fc 0f 00 f7 d8 64 89 01 48
[  126.803910] RSP: 002b:00007ffdb498d188 EFLAGS: 00000206 ORIG_RAX: 000=
0000000000107
[  126.803913] RAX: ffffffffffffffda RBX: 000055cce3131730 RCX: 00007ff6=
c7cb314b
[  126.803914] RDX: 0000000000000000 RSI: 000055cce3130510 RDI: 00000000=
ffffff9c
[  126.803916] RBP: 00007ffdb498d260 R08: 0000000000000002 R09: 00007ffd=
b498d2bc
[  126.803918] R10: 0000000000000000 R11: 0000000000000206 R12: 000055cc=
e3130480
[  126.803919] R13: 0000000000000000 R14: 00007ffdb498d2c0 R15: 00000000=
00000000
[  126.803925]  </TASK>
[  126.803926] ---[ end trace 0000000000000000 ]---
[  126.803956] BTRFS: error (device sda3 state A) in __btrfs_unlink_inod=
e:4297: errno=3D-2 No such entry
[  126.803963] BTRFS info (device sda3 state EA): forced readonly



--
Chris Murphy

