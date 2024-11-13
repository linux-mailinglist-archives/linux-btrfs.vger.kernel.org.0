Return-Path: <linux-btrfs+bounces-9590-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D22829C6D4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 12:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E0F1F21507
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 11:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1871FEFA9;
	Wed, 13 Nov 2024 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Duhjko48"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B99426AEC
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495758; cv=none; b=IUmHj/wQNj4M7U0CTpmoD9bgWTeOqga32QMC+vHyEU1R3r3xX8ckqhA0a23YW4zpij+BXRtUq6FplZehqhWrwvWFZERtEsSpyOIvfwh7wbgrlIV4BeK2lUDR+IUjEjZqhJVApOrqGWfRa3fuk/ZZprv/93KZMqu7d1WkzueBU2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495758; c=relaxed/simple;
	bh=uSdauhhjneu7qmBum5aKrB9qaV63k5j/1a5ojuhbkoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHAzYMdfhiCZbKngeToHsbSeawtgt2p+ES/4S8L4lvL/1b27MyvSEdvFXadUimMUCcYr8Spcn2fNxjZ+UdCz7Wq3QRbMkTPV81YNDiGi/S10SD8sYnksA6m0r0KxYFxiuH7aNdtqFcBFjnDLDI65diXoeF8vSTx6ofM0q9q5j7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Duhjko48; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ee58c5c2e3so2448794eaf.2
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 03:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731495755; x=1732100555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/t08cBQXC2aQLjqfXanFeMtiAV0urxynGtS1ysEwCCs=;
        b=Duhjko480g5JnbIrEIaGWnYpc7amkPJl4S4Vn4oCWSI+bq/qQmb19QZ+RI02l8Tt6w
         KU8TFkAz/68qe47FHEu/lPKF/wG79IT9Z0I6+aAIualpYBgvJ95QqStHJQt2+Huy7IXV
         9QhyaE86vEJpnTw4ub+400XE2E8LaguvkwAOyfcKo2suUdPTNY/WxTZ6IENtdxHsn1+1
         L18bNzYk+msM0ARW0C0oPMcC6wkBCwXjUrvV9FGoXi8iJEcSDHXbOXSDMFmCCNvI4Xzl
         0V6GIX9RwRmuvhcWsGES3MdSR3uBd29XneHzVIZ2vxws4gQaSsDaGT8h8BNT73K+D2gg
         FXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731495755; x=1732100555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/t08cBQXC2aQLjqfXanFeMtiAV0urxynGtS1ysEwCCs=;
        b=nMPHXBKULCh9gVT6T98ZSVhFxmh4NaH3gvp/cPvwvVp0ewktxxXYsq/XZb7YW00kCt
         9GXpkeme7dXyJch/UUQrElXfOYTFXCDN4rTA+n/EtjPN7Kz0HCjQFG3/J+LK9QiSbJAR
         GJDntyr85k5qHnltzmyieH5OpVkYf1LL6JHnwMFFS/Nv791NGcawW/IwsZ6usOYr9hXL
         K1AJpWJ3tN9TizFyWSR5pSRf+5JufRrSl2ALLrc9BnAG4HuZ6w/C5DthWwFj5Dgb8BD+
         lO287vt2oJ9YqRXzE3oHohYKLhvYkX/g5TpKdfR13WvkarIUGNRiKxmTBS730Y6kMIoP
         v7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVA/r7iyd8eJvD5JeXu89hrpau1npeiAonaOKqkLASGyEKlvG1alyGYW++GkL1eSt/8YhcdPcOECrChSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi3TjcKnWlhcY6n0A50CFb0x2mCw2XpLf51EHmdHcIJTSdwvae
	00mt7oJ0UWQmETKTk2fHw1TJvYQQo4CcNpCXVBvfLzps8XkNgsNnZC0Xlj7wBLnYJIOmgobG4OT
	lcHBG6hDrvVnDsLOBDlDfMLwJqIc=
X-Google-Smtp-Source: AGHT+IGTcQFIzhXvTmw+LEX6OoTjPLowW74zMsvbE3ZW+r1WnyUwO56gL6x9+40yJlmku3MmcgPGJO/g48WLDEjGHbw=
X-Received: by 2002:a05:6820:2088:b0:5e1:c19d:3f4e with SMTP id
 006d021491bc7-5ee92280549mr2014990eaf.8.1731495755233; Wed, 13 Nov 2024
 03:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+W5K0pYAyHS6K5Oy2h03KKgP9+6Q0stOYBrNY7vSmA+J4SdfA@mail.gmail.com>
 <CA+W5K0pnbNZL+rPu=vF1TTYnrx+=qhUSuNjx-ueDNc=ip+yjpA@mail.gmail.com>
 <fb093ca9-2deb-4eae-93ee-8442e01e7470@app.fastmail.com> <CAK-xaQaCY5uLz0Sg4f4VupFFxf707RS26DBLaVxJ3UJgs5Eoug@mail.gmail.com>
 <CA+W5K0ovc1fbgYJMDhXx_kJNUBdV7pZ0DSwqkPzcqodAEn0=Qw@mail.gmail.com> <1cf9958b-bc89-4000-9c14-ef800e5f58bd@gmail.com>
In-Reply-To: <1cf9958b-bc89-4000-9c14-ef800e5f58bd@gmail.com>
From: Stefan N <stefannnau@gmail.com>
Date: Wed, 13 Nov 2024 21:32:23 +1030
Message-ID: <CA+W5K0oDM7grL0KgbWEtHa4V+WMMvp5d+o54jrSdBjfv_zrAPQ@mail.gmail.com>
Subject: Re: Recovering from/avoiding metadata space exhaustion
To: Andrei Borzenkov <arvidjaar@gmail.com>
Cc: Andrea Gelmini <andrea.gelmini@gmail.com>, Chris Murphy <lists@colorremedies.com>, 
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrei,

Thanks for the suggestion, I did try those mount flags back on the old
kernel version, and just reran on the newer 6.11 to confirm the
behaviour hasn't changed, it still triggers what appears to be the
same errors before 'no space left' on both versions.

When using -o rw,degraded,nospace_cache,clear_cache,skip_balance
triggered at fs/btrfs/free-space-tree.c:1349
btrfs_rebuild_free_space_tree.cold+0xc6/0xca (on older 6.8 it was
fs/btrfs/free-space-tree.c:1348
btrfs_rebuild_free_space_tree+0x1a5/0x1b0)

When using -o rw,degraded,clear_cache,skip_balance
fs/btrfs/extent-tree.c:2199 btrfs_run_delayed_refs.cold+0x54/0x58

Cheers,

Stefan

-o rw,degraded,nospace_cache,clear_cache,skip_balance

BTRFS info (device sdd1): first mount of filesystem my-btrfs-guid
BTRFS info (device sdd1): using crc32c (crc32c-intel) checksum algorithm
BTRFS info (device sdd1): using free-space-tree
BTRFS error (device sdd1 state M): failed to run delayed ref for
logical 189538519531520 num_bytes 16384 type 176 action 1 ref _mod 1:
-28
------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 0 PID: 9441 at fs/btrfs/extent-tree.c:2199
btrfs_run_delayed_refs.cold+0x54/0x58 [btrfs]
Modules linked in: ipt_REJECT nf_reject_ipv4 iptable_filter
xt_connmark xt_mark iptable_mangle xt_comment iptable_raw wireguar d
curve25519_x86_64 libchacha20poly1305 chacha_x86_64 poly1305_x86_64
libcurve25519_generic libchacha ip6_udp_tunnel udp_tunnel xt_nat
xt_tcpudp veth xt_conntrack nft_chain_na t xt_MASQUERADE nf_nat
nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables br_netfilter
bridge stp llc nfsv3 n fs netfs ipmi_devintf ipmi_msghandler overlay
cfg80211 binfmt_misc nls_iso8859_1 amdgpu intel_rapl_msr amd_atl
snd_hda_codec_realtek snd_hda_codec_generic intel_rapl_common ee 1004
snd_hda_scodec_component snd_hda_codec_hdmi edac_mce_amd snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi amdxcp drm_exec snd_hda_codec
kvm_amd snd_hda_core gpu_sched dr m_buddy snd_hwdep kvm snd_pcm
drm_suballoc_helper drm_ttm_helper ttm wmi_bmof drm_display_helper
snd_timer i2c_piix4 rapl snd k10temp i2c_smbus cec soundcore rc_core
ccp input _leds joydev mac_hid
  sch_fq_codel bonding tls efi_pstore nfsd auth_rpcgss nfs_acl lockd
grace dm_multipath sunrpc nfnetlink dmi_sysfs ip_tables x_ tables
autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1
raid0 hid_generic uas crct10dif_pcl mul crc32_pclmul polyval_clmulni
usbhid polyval_generic hid usb_storage ghash_clmulni_intel
sha256_ssse3 sha1_ssse3 nvme mpt3sas igb i2c_algo_bit ahci dca qlcnic
raid_class sc si_transport_sas nvme_core xhci_pci libahci nvme_auth
xhci_pci_renesas video wmi aesni_intel crypto_simd cryptd
CPU: 0 UID: 0 PID: 9441 Comm: mount Tainted: G        W
6.11.0-9-generic #9-Ubuntu
Tainted: [W]=WARN
Hardware name: To Be Filled By O.E.M. X570M Pro4/X570M Pro4, BIOS
P3.70 02/23/2022
RIP: 0010:btrfs_run_delayed_refs.cold+0x54/0x58 [btrfs]
Code: 97 08 00 00 4c 89 e7 41 83 e0 01 48 c7 c6 a0 22 93 c0 e8 3f 42
00 00 e9 f4 b0 f1 ff 89 de 48 c7 c7 d0 ef 93 c0 e8 1c 74  e8 d7 <0f>
0b eb c6 49 8b 13 48 8b 7d d0 48 c7 c6 48 f8 93 c0 e8 15 40 01
RSP: 0018:ffffc06d44c9b7c0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000ffffffe4 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc06d44c9b7e8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff9da9085f5d20
R13: ffff9da8a23c9158 R14: ffff9da8a23c9000 R15: 0000000000000000
FS:  000071dcaeaff800(0000) GS:ffff9dafa1000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007cf02e4ac980 CR3: 0000000192124000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 ? show_trace_log_lvl+0x1be/0x310
 ? show_trace_log_lvl+0x1be/0x310
 ? btrfs_write_dirty_block_groups+0x159/0x380 [btrfs]
 ? show_regs.part.0+0x22/0x30
 ? show_regs.cold+0x8/0x10
 ? btrfs_run_delayed_refs.cold+0x54/0x58 [btrfs]
 ? __warn.cold+0xa7/0x101
 ? btrfs_run_delayed_refs.cold+0x54/0x58 [btrfs]
 ? report_bug+0x114/0x160
 ? handle_bug+0x51/0xa0
 ? exc_invalid_op+0x18/0x80
 ? asm_exc_invalid_op+0x1b/0x20
 ? btrfs_run_delayed_refs.cold+0x54/0x58 [btrfs]
 btrfs_write_dirty_block_groups+0x159/0x380 [btrfs]
 commit_cowonly_roots+0x1cb/0x240 [btrfs]
 btrfs_commit_transaction+0x3ca/0xc70 [btrfs]
 btrfs_recover_relocation+0x2f3/0x5e0 [btrfs]
 ? btrfs_orphan_cleanup.cold+0x2c/0x5f [btrfs]
 btrfs_start_pre_rw_mount+0x2ba/0x450 [btrfs]
 btrfs_reconfigure+0x1e5/0x540 [btrfs]
 btrfs_get_tree_subvol+0x3fb/0x450 [btrfs]
 ? vfs_parse_fs_string+0x7b/0xb0
 btrfs_get_tree+0x25/0x30 [btrfs]
 vfs_get_tree+0x2a/0xe0
 do_new_mount+0x1a1/0x340
 path_mount+0x1d8/0x840
 __x64_sys_mount+0x129/0x160
 x64_sys_call+0x208a/0x22b0
 do_syscall_64+0x7e/0x170
 ? putname+0x5b/0x80
 ? __x64_sys_statx+0xa4/0x100
 ? syscall_exit_to_user_mode+0x4e/0x250
 ? do_syscall_64+0x8a/0x170
 ? __do_sys_newfstatat+0x53/0x90
 ? syscall_exit_to_user_mode+0x4e/0x250
 ? do_syscall_64+0x8a/0x170
 ? do_syscall_64+0x8a/0x170
 ? exc_page_fault+0x96/0x1c0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x71dcae934cfe
Code: 48 8b 0d 25 c1 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00  0f 05 <48>
3d 01 f0 ff ff 73 01 c3 48 8b 0d f2 c0 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd8b659638 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00005bdce8976b00 RCX: 000071dcae934cfe
RDX: 00005bdce8987450 RSI: 00005bdce8987380 RDI: 00005bdce8988ec0
RBP: 00007ffd8b6596a0 R08: 00005bdce89870f0 R09: 00007ffd8b659710
R10: 0000000000000000 R11: 0000000000000246 R12: 00005bdce8988ec0
R13: 00005bdce8987380 R14: 00005bdce8987450 R15: 00005bdce8987c90
 </TASK>
---[ end trace 0000000000000000 ]---
BTRFS info (device sdd1 state MA): dumping space info:
BTRFS info (device sdd1 state MA): space_info DATA has 3383098413056
free, is not full
BTRFS info (device sdd1 state MA): space_info total=114548488011776,
used=111151575642112, pinned=0, reserved=0, may_use=0, re
adonly=13813956608 zone_unusable=0
BTRFS info (device sdd1 state MA): space_info METADATA has -536821760
free, is full
BTRFS info (device sdd1 state MA): space_info total=121332826112,
used=121276514304, pinned=56229888, reserved=81920, may_use=
536821760, readonly=0 zone_unusable=0
BTRFS info (device sdd1 state MA): space_info SYSTEM has 26460160
free, is not full
BTRFS info (device sdd1 state MA): space_info total=33554432,
used=7094272, pinned=0, reserved=0, may_use=0, readonly=0 zone_u
nusable=0
BTRFS info (device sdd1 state MA): global_block_rsv: size 536870912
reserved 536805376
BTRFS info (device sdd1 state MA): trans_block_rsv: size 0 reserved 0
BTRFS info (device sdd1 state MA): chunk_block_rsv: size 0 reserved 0
BTRFS info (device sdd1 state MA): delayed_block_rsv: size 0 reserved 0
BTRFS info (device sdd1 state MA): delayed_refs_rsv: size 23068672
reserved 16384
BTRFS: error (device sdd1 state MA) in btrfs_run_delayed_refs:2199:
errno=-28 No space left
BTRFS warning (device sdd1 state EMA): Skipping commit of aborted transaction.
BTRFS: error (device sdd1 state EMA) in cleanup_transaction:2018:
errno=-28 No space left
BTRFS warning (device sdd1 state EMA): failed to recover relocation: -28


-o rw,degraded,clear_cache,skip_balance

BTRFS info (device sdd1): rebuilding free space tree
------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 2 PID: 8832 at fs/btrfs/free-space-tree.c:1349
btrfs_rebuild_free_space_tree.cold+0xc6/0xca [btrfs]
Modules linked in: ipt_REJECT nf_reject_ipv4 iptable_filter
xt_connmark xt_mark iptable_mangle xt_comment iptable_raw wireguard
curve25519_x86_64 libchacha20poly1305 chacha_x86_64 poly1305_x86_64
libcurve25519_generic libchacha ip6_udp_tunnel udp_tunnel xt_nat
xt_tcpudp veth xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat
nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables br_netfilter
bridge stp llc nfsv3 nfs netfs ipmi_devintf ipmi_msghandler overlay
cfg80211 binfmt_misc nls_iso8859_1 amdgpu intel_rapl_msr ee1004
amd_atl snd_hda_codec_realtek intel_rapl_common snd_hda_codec_generic
edac_mce_amd snd_hda_scodec_component amdxcp drm_exec kvm_amd
snd_hda_codec_hdmi gpu_sched drm_buddy snd_hda_intel
drm_suballoc_helper drm_ttm_helper snd_intel_dspcfg snd_intel_sdw_acpi
ttm snd_hda_codec drm_display_helper kvm snd_hda_core snd_hwdep rapl
wmi_bmof snd_pcm cec snd_timer i2c_piix4 rc_core k10temp snd i2c_smbus
soundcore ccp joydev input_leds mac_hid
 sch_fq_codel bonding tls efi_pstore nfsd auth_rpcgss nfs_acl lockd
grace dm_multipath sunrpc nfnetlink dmi_sysfs ip_tables x_tables
autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1
raid0 hid_generic usbhid uas hid usb_storage crct10dif_pclmul
crc32_pclmul polyval_clmulni polyval_generic nvme ghash_clmulni_intel
sha256_ssse3 sha1_ssse3 igb i2c_algo_bit ahci nvme_core mpt3sas
libahci qlcnic xhci_pci raid_class dca video scsi_transport_sas
xhci_pci_renesas nvme_auth wmi aesni_intel crypto_simd cryptd
CPU: 2 UID: 0 PID: 8832 Comm: mount Not tainted 6.11.0-9-generic #9-Ubuntu
Hardware name: To Be Filled By O.E.M. X570M Pro4/X570M Pro4, BIOS
P3.70 02/23/2022
RIP: 0010:btrfs_rebuild_free_space_tree.cold+0xc6/0xca [btrfs]
Code: 41 b8 01 00 00 00 eb b1 44 89 e6 48 c7 c7 b0 a4 b0 c0 e8 b5 44
8b cb 0f 0b eb 93 44 89 e6 48 c7 c7 b0 a4 b0 c0 e8 a2 44 8b cb <0f> 0b
eb d2 45 31 ed 45 89 e8 44 89 e1 ba 80 05 00 00 48 89 df 41
RSP: 0018:ffff9e1f850bf798 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff919f075b70d8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff9e1f850bf7d8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00000000ffffffe4
R13: ffff919e2bcbae70 R14: ffff919e7b2cf000 R15: ffff919dc9cb5600
FS:  00007d2edd267800(0000) GS:ffff91a4e1100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c000229000 CR3: 00000001bb2fa000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 ? show_trace_log_lvl+0x1be/0x310
 ? show_trace_log_lvl+0x1be/0x310
 ? btrfs_start_pre_rw_mount.cold+0x31/0x18c [btrfs]
 ? show_regs.part.0+0x22/0x30
 ? show_regs.cold+0x8/0x10
 ? btrfs_rebuild_free_space_tree.cold+0xc6/0xca [btrfs]
 ? __warn.cold+0xa7/0x101
 ? btrfs_rebuild_free_space_tree.cold+0xc6/0xca [btrfs]
 ? report_bug+0x114/0x160
 ? handle_bug+0x51/0xa0
 ? exc_invalid_op+0x18/0x80
 ? asm_exc_invalid_op+0x1b/0x20
 ? btrfs_rebuild_free_space_tree.cold+0xc6/0xca [btrfs]
 ? btrfs_rebuild_free_space_tree.cold+0xc6/0xca [btrfs]
 btrfs_start_pre_rw_mount.cold+0x31/0x18c [btrfs]
 ? btrfs_get_root_ref+0x288/0x3a0 [btrfs]
 open_ctree+0xa1b/0xc10 [btrfs]
 ? snprintf+0x4f/0x80
 btrfs_get_tree_super.cold+0xd/0xfe [btrfs]
 btrfs_get_tree+0x18/0x30 [btrfs]
 vfs_get_tree+0x2a/0xe0
 fc_mount+0x12/0x60
 btrfs_get_tree_subvol+0x13c/0x450 [btrfs]
 ? vfs_parse_fs_string+0x7b/0xb0
 btrfs_get_tree+0x25/0x30 [btrfs]
 vfs_get_tree+0x2a/0xe0
 do_new_mount+0x1a1/0x340
 path_mount+0x1d8/0x840
 __x64_sys_mount+0x129/0x160
 x64_sys_call+0x208a/0x22b0
 do_syscall_64+0x7e/0x170
 ? filename_lookup+0xda/0x1f0
 ? mntput_no_expire+0x4f/0x260
 ? generic_permission+0x39/0x230
 ? mntput+0x24/0x50
 ? path_put+0x1e/0x30
 ? do_faccessat+0x1e3/0x2e0
 ? syscall_exit_to_user_mode+0x4e/0x250
 ? do_syscall_64+0x8a/0x170
 ? do_syscall_64+0x8a/0x170
 ? syscall_exit_to_user_mode+0x4e/0x250
 ? do_syscall_64+0x8a/0x170
 ? __do_sys_prctl+0x41/0xa90
 ? syscall_exit_to_user_mode+0x4e/0x250
 ? do_syscall_64+0x8a/0x170
 ? irqentry_exit+0x43/0x50
 ? exc_page_fault+0x96/0x1c0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7d2edd134cfe
Code: 48 8b 0d 25 c1 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d f2 c0 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007fffa50a2478 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00005d86aed26b00 RCX: 00007d2edd134cfe
RDX: 00005d86aed28960 RSI: 00005d86aed287e0 RDI: 00005d86aed271e0
RBP: 00007fffa50a24e0 R08: 00005d86aed28170 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00005d86aed271e0
R13: 00005d86aed287e0 R14: 00005d86aed28960 R15: 00005d86aed26c60
 </TASK>
---[ end trace 0000000000000000 ]---
BTRFS info (device sdd1 state A): dumping space info:
BTRFS info (device sdd1 state A): space_info DATA has 3383098413056
free, is not full
BTRFS info (device sdd1 state A): space_info total=114548488011776,
used=111151575642112, pinned=0, reserved=0, may_use=0,
readonly=13813956608 zone_unusable=0
BTRFS info (device sdd1 state A): space_info METADATA has -537149440
free, is full
BTRFS info (device sdd1 state A): space_info total=121332826112,
used=121276203008, pinned=0, reserved=56623104, may_use=537149440,
readonly=0 zone_unusable=0
BTRFS info (device sdd1 state A): space_info SYSTEM has 26460160 free,
is not full
BTRFS info (device sdd1 state A): space_info total=33554432,
used=7094272, pinned=0, reserved=0, may_use=0, readonly=0
zone_unusable=0
BTRFS info (device sdd1 state A): global_block_rsv: size 536870912
reserved 536870912
BTRFS info (device sdd1 state A): trans_block_rsv: size 262144 reserved 262144
BTRFS info (device sdd1 state A): chunk_block_rsv: size 0 reserved 0
BTRFS info (device sdd1 state A): delayed_block_rsv: size 0 reserved 0
BTRFS info (device sdd1 state A): delayed_refs_rsv: size 5122818048
reserved 16384
BTRFS: error (device sdd1 state A) in
btrfs_rebuild_free_space_tree:1349: errno=-28 No space left
BTRFS warning (device sdd1 state EA): failed to rebuild free space tree: -28
BTRFS warning (device sdd1 state EA): Skipping commit of aborted transaction.
BTRFS: error (device sdd1 state EA) in cleanup_transaction:2018:
errno=-28 No space left
BTRFS error (device sdd1 state EA): commit super ret -30
BTRFS error (device sdd1 state EA): open_ctree failed

On Sat, 9 Nov 2024 at 23:51, Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>
> 09.11.2024 10:01, Stefan N wrote:
> >
> > $ mount -o rw,degraded,clear_cache,skip_balance -U my-uuid /mnt/array
> >
> > BTRFS info (device sdd1): first mount of my-uuid
> > BTRFS info (device sdd1): using crc32c (crc32c-intel) checksum algorithm
> > BTRFS info (device sdd1): using free-space-tree
> > BTRFS info (device sdd1): rebuilding free space tree
>
> You could try mounting with clear-cache,nospace_cache or btrfs-check
> --clear-space-cache.
>
>

