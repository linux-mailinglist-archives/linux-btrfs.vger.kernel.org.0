Return-Path: <linux-btrfs+bounces-9398-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CF19C2AEC
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Nov 2024 08:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72579282466
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Nov 2024 07:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A9713B2B4;
	Sat,  9 Nov 2024 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8uasjC+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04754A1E
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Nov 2024 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731135689; cv=none; b=Wf/nes19mp1MKjNzvK6FQvuYtsBuKKPHWbSQ3W+gJ2Gg4BdjI7PztJK10r3aT8Fd1PDffRCRIarRW5gnhdv2Y79iS5kPt51KoGulDmxICBPdV+MwIBgDXpt0765y7yAwv5JhdOjYKZ7rJbRJpWniE/Ac43VrQ3R29/kU+bbu/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731135689; c=relaxed/simple;
	bh=Hn0wKoxPP4qECLVXHQrlITTW9k++ea/ckBpy1ggHsU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMAwqYPNbKR2hG8BxdAVNT6B3g4Qm4pEl+eRmD6k0wFzMgR2h0UNNbnLyC21TX2UekCSFmN+RRNhUChB47hm4DwYCqcnuHkFpJEs3s27gFzDV/MBd0+uV8oYFS1KJQn1SGCeTayU0N2IW02Cm/FOj36MfuXw7oKNA9QGYJN4PgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8uasjC+; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ebc349204cso1422659eaf.3
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Nov 2024 23:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731135686; x=1731740486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r31qiIMmA4m/ECZwmkDG2L1UuCWwCOmsNpTrooWxBOQ=;
        b=R8uasjC+iwnYtSYDmShPoEkau9J20r6Allfeh0L/snOujZIESYtjBl1aAP+BXpQ+TF
         9cunYKkWpZkvy577JWPbQyUDmjoJQtwKLfcE2HOAUCEw+XediD4CqTBivNam5egmgEmm
         zR4qLJQb2a6DtIxOHtfI0S15vV9CgS1aqvyZuVyT/csPLYN9SLPROBXcbcdsvI//2l2z
         ej5bvEzoeOcm/BhCiGVWHZ9OdDxFqeUGj1JRFS5XKym/u/a6+msFQSuEonNS0b0u/uEd
         CfG9hSN699zahNnBU4GPcA1+Abykq/MwLK27SkHrD8IkmDvuOQz8PtszNhmLrRwLXhuF
         MyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731135686; x=1731740486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r31qiIMmA4m/ECZwmkDG2L1UuCWwCOmsNpTrooWxBOQ=;
        b=LWMrD/2nqSB2aExB2gnLvvhp7TVSW5QkCAX/rdqpKxfOTrRllSP/RAHK7RRUy8Nfm+
         TRtyuwurFeTNzBlVHDurxdM0UJ6jJfVsT628LHCZPemX2qreCdK7MWNym6JnMTsHRTjL
         QnHwX48HvQrNIda1ULVq/B7puBytwP4xpGhDqHDL7YH3sLb93l+KuJRZpiaeqF2lACcV
         BSSrE3/7OnONKMhQFJHRXAPKtiAHwjtN1lS7eROLcHYrSo8w/OVcl1S4zG45Uvj7+rao
         sbaLSOdShsUCB9W+PezzYPFxjTnNY5idsHjIBvhIqx9tSLCvSaiMpXfsptKXwV8Qn+6J
         4fUg==
X-Forwarded-Encrypted: i=1; AJvYcCUlt6w/yp19qkNyCNpj2WKdSVpWD0YytEVTI0qUIhKjPFJAyEE/9XgAzYkPQ8bVP8LcLzJUWllwWrbjhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVyyROCYld0ZwSlObs2SRskVErqMC4HbEvXPPnvS3NDnPEHo1Z
	zUXVhZlCj4M5k0qstO+fbIycq7JUp18epwLXYWIsnbsKqsdCJV1Gx2wiPQqLzKa1acjVyospxSg
	l1POltKuiy31kJepiWLsQ82bmW38=
X-Google-Smtp-Source: AGHT+IFu52CkFWE5aKBhmx3hHCCjDFwDhJz1l1UJ4G6ULFkiuKohfcZta4RlwVWPXkbpq0PxJ/ZpR7Qvt1vVJZ3qJHQ=
X-Received: by 2002:a05:6820:2184:b0:5eb:6a67:6255 with SMTP id
 006d021491bc7-5ee57ba7b74mr5119412eaf.1.1731135685684; Fri, 08 Nov 2024
 23:01:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+W5K0pYAyHS6K5Oy2h03KKgP9+6Q0stOYBrNY7vSmA+J4SdfA@mail.gmail.com>
 <CA+W5K0pnbNZL+rPu=vF1TTYnrx+=qhUSuNjx-ueDNc=ip+yjpA@mail.gmail.com>
 <fb093ca9-2deb-4eae-93ee-8442e01e7470@app.fastmail.com> <CAK-xaQaCY5uLz0Sg4f4VupFFxf707RS26DBLaVxJ3UJgs5Eoug@mail.gmail.com>
In-Reply-To: <CAK-xaQaCY5uLz0Sg4f4VupFFxf707RS26DBLaVxJ3UJgs5Eoug@mail.gmail.com>
From: Stefan N <stefannnau@gmail.com>
Date: Sat, 9 Nov 2024 17:31:13 +1030
Message-ID: <CA+W5K0ovc1fbgYJMDhXx_kJNUBdV7pZ0DSwqkPzcqodAEn0=Qw@mail.gmail.com>
Subject: Re: Recovering from/avoiding metadata space exhaustion
To: Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: Chris Murphy <lists@colorremedies.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Thanks for the responses Andrea and Chris.

With Ubuntu 24.10 now including 6.11 I've been running this to
determine if this will avoid the issue recurring.

However, I'm still stuck at the same impasse due to inability to mount
rw, as well as no metadata space to add another device, see
output/trace below.

Qu had previously hacked together a patch for 6.2 which I used to
queue `dev add`s when metadata was full, however in this case, I can't
mount as rw to be able to use it :(

$ btrfs --version ; uname -a
btrfs-progs v6.6.3
Linux mynas 6.11.0-9-generic #9-Ubuntu SMP PREEMPT_DYNAMIC Mon Oct 14
13:19:59 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux

$ btrfs fi show /mnt/array/
Label: 'array'  uuid: my-uuid
        Total devices 9 FS bytes used 101.20TiB
        devid    1 size 20.01TiB used 11.23TiB path /dev/sdd1
        devid    2 size 20.01TiB used 11.23TiB path /dev/sdb1
        devid    3 size 16.37TiB used 16.37TiB path /dev/sdg1
        devid    4 size 20.01TiB used 20.01TiB path /dev/sde1
        devid    5 size 16.37TiB used 16.37TiB path /dev/sdm1
        devid    6 size 20.01TiB used 20.01TiB path /dev/sdh1
        devid    7 size 16.37TiB used 16.37TiB path /dev/sda1
        devid    8 size 16.37TiB used 16.37TiB path /dev/sdf1
        devid    9 size 16.37TiB used 16.37TiB path /dev/sdc1

$ btrfs fi usage /mnt/array/
Overall:
    Device size:                 161.88TiB
    Device allocated:            144.31TiB
    Device unallocated:           17.57TiB
    Device missing:                  0.00B
    Device slack:                    0.00B
    Used:                        139.93TiB
    Free (estimated):             15.88TiB      (min: 9.03TiB)
    Free (statfs, df):               0.00B
    Data ratio:                       1.38
    Metadata ratio:                   3.00
    Global reserve:              512.00MiB      (used: 64.00KiB)
    Multiple profiles:                 yes      (data)

Data,single: Size:9.33TiB, Used:9.32TiB (99.87%)
   /dev/sdd1       4.67TiB
   /dev/sdb1       4.67TiB

Data,RAID6: Size:94.85TiB, Used:91.77TiB (96.76%)
   /dev/sdd1       6.55TiB
   /dev/sdb1       6.55TiB
   /dev/sdg1      16.37TiB
   /dev/sde1      19.90TiB
   /dev/sdm1      16.34TiB
   /dev/sdh1      19.90TiB
   /dev/sda1      16.34TiB
   /dev/sdf1      16.34TiB
   /dev/sdc1      16.34TiB

Metadata,RAID1C3: Size:113.00GiB, Used:112.95GiB (99.95%)
   /dev/sdd1       7.00GiB
   /dev/sdb1       5.00GiB
   /dev/sde1     111.00GiB
   /dev/sdm1      27.00GiB
   /dev/sdh1     110.00GiB
   /dev/sda1      26.00GiB
   /dev/sdf1      27.00GiB
   /dev/sdc1      26.00GiB

System,RAID1C3: Size:32.00MiB, Used:6.77MiB (21.14%)
   /dev/sdb1      32.00MiB
   /dev/sde1      32.00MiB
   /dev/sdh1      32.00MiB

Unallocated:
   /dev/sdd1       8.78TiB
   /dev/sdb1       8.78TiB
   /dev/sdg1       1.00MiB
   /dev/sde1       1.00MiB
   /dev/sdm1       1.00MiB
   /dev/sdh1       1.00MiB
   /dev/sda1       1.00MiB
   /dev/sdf1       1.00MiB
   /dev/sdc1       1.00MiB

$ mount -o rw,degraded,clear_cache,skip_balance -U my-uuid /mnt/array

BTRFS info (device sdd1): first mount of my-uuid
BTRFS info (device sdd1): using crc32c (crc32c-intel) checksum algorithm
BTRFS info (device sdd1): using free-space-tree
BTRFS info (device sdd1): rebuilding free space tree
------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 1 PID: 18279 at fs/btrfs/free-space-tree.c:1349
btrfs_rebuild_free_space_tree.cold+0xc6/0xca [btrfs]
Modules linked in: ipt_REJECT nf_reject_ipv4 iptable_filter
xt_connmark xt_mark iptable_mangle xt_comment iptable_raw wireguard
curve25519_x86_64 libchacha20poly1305 chacha_x86_64 poly1305_x86_64
libcurve25519_generic libchacha ip6_udp_tunnel udp_tunnel xt_nat
xt_tcpudp veth xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat
nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables br_netfilter
bridge stp llc ipmi_devintf ipmi_msghandler overlay cfg80211
binfmt_misc nls_iso8859_1 amd_atl intel_rapl_msr amdgpu
intel_rapl_common edac_mce_amd ee1004 snd_hda_codec_realtek
snd_hda_codec_generic snd_hda_scodec_component kvm_amd
snd_hda_codec_hdmi snd_hda_intel amdxcp snd_intel_dspcfg
snd_intel_sdw_acpi drm_exec snd_hda_codec snd_hda_core snd_hwdep
gpu_sched drm_buddy drm_suballoc_helper drm_ttm_helper kvm snd_pcm ttm
drm_display_helper snd_timer i2c_piix4 rapl snd cec wmi_bmof i2c_smbus
rc_core k10temp soundcore ccp mac_hid sch_fq_codel dm_multipath
bonding
 tls efi_pstore nfsd auth_rpcgss nfs_acl lockd grace sunrpc nfnetlink
dmi_sysfs ip_tables x_tables autofs4 btrfs blake2b_generic raid10
raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
raid6_pq libcrc32c raid1 raid0 crct10dif_pclmul uas crc32_pclmul
usb_storage polyval_clmulni polyval_generic nvme ghash_clmulni_intel
sha256_ssse3 sha1_ssse3 igb ahci nvme_core i2c_algo_bit libahci dca
mpt3sas xhci_pci qlcnic video xhci_pci_renesas raid_class nvme_auth
scsi_transport_sas wmi aesni_intel crypto_simd cryptd
CPU: 1 UID: 0 PID: 18279 Comm: mount Tainted: G        W
6.11.0-061100-generic #202409151536
Tainted: [W]=WARN
Hardware name: To Be Filled By O.E.M. X570M Pro4/X570M Pro4, BIOS
P3.70 02/23/2022
RIP: 0010:btrfs_rebuild_free_space_tree.cold+0xc6/0xca [btrfs]
Code: 41 b8 01 00 00 00 eb b1 44 89 e6 48 c7 c7 00 62 77 c0 e8 a5 94
84 c3 0f 0b eb 93 44 89 e6 48 c7 c7 00 62 77 c0 e8 92 94 84 c3 <0f> 0b
eb d2 45 31 ed 45 89 e8 44 89 e1 ba 80 05 00 00 48 89 df 41
RSP: 0018:ffffb4f6d1f8b828 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff95e2553048d8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffb4f6d1f8b868 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00000000ffffffe4
R13: ffff95e1b6fd1888 R14: ffff95e1b826b000 R15: ffff95e1802f2200
FS:  00007d2942217800(0000) GS:ffff95e8a1080000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00012f010 CR3: 000000014aad4000 CR4: 00000000003506f0
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
 ? syscall_exit_to_user_mode+0x4e/0x250
 ? do_syscall_64+0x8a/0x170
 ? _copy_to_user+0x25/0x50
 ? cp_new_stat+0x142/0x190
 ? syscall_exit_to_user_mode+0x4e/0x250
 ? do_syscall_64+0x8a/0x170
 ? __do_sys_newfstatat+0x53/0x90
 ? syscall_exit_to_user_mode+0x4e/0x250
 ? do_syscall_64+0x8a/0x170
 ? syscall_exit_to_user_mode+0x4e/0x250
 ? do_syscall_64+0x8a/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7d294212af0e
Code: 48 8b 0d 0d 7f 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d da 7e 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007fff49995ff8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000063db6b983b00 RCX: 00007d294212af0e
RDX: 000063db6b98a8f0 RSI: 000063db6b984180 RDI: 000063db6b9841e0
RBP: 00007fff49996060 R08: 000063db6b989af0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000063db6b9841e0
R13: 000063db6b984180 R14: 000063db6b98a8f0 R15: 000063db6b983c60
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
On Thu, 26 Sept 2024 at 16:45, Andrea Gelmini <andrea.gelmini@gmail.com> wrote:
>
> Il gio 26 set 2024, 00:25 Chris Murphy <lists@colorremedies.com> ha scritto:
>>
>> My opinions only. And hopefully someone will push back on it.
>>
>> You need to run a more recent kernel that's also closer to kernel.org source. And latest btrfs-progs. That'd be a mostly unmodified 6.10.11 or 6.11.0 kernel.
>
>
> Stefan, you can use the Ubuntu 24.10 iso as live CD. So, you have latest kernel and tools.
>
> Ciao,
> Gelma
>>
>>

