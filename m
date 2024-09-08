Return-Path: <linux-btrfs+bounces-7886-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 944199706C9
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Sep 2024 13:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA766B216CE
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Sep 2024 11:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690071531CD;
	Sun,  8 Sep 2024 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3dha3pD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E793913BAFA
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Sep 2024 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725794064; cv=none; b=q9J0W8Ql+yCJJlw5MGxm8lAAJpX+fFTHzofqmrjBOmHmO71mC+/QDaNUz50e85h/rpW+sn6lYY4jiTuiG9/nMyEIrtaMcViaSeCy9vd2wCVmnO5xVBZa60T8dSm0IZcSLjAEIZTtJFyzHZAIXJa+rEy0GVnsbLlSLBWuC9Pf64k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725794064; c=relaxed/simple;
	bh=NykOR00Ll3OJnCBqBDfUfWV3Dkqor+A6KGDhlDwZJNg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KZ/vv3iGq5adY6eUoTmu3UNuABhZmMNeUZmcji66kBqUssTpQ8iqQJ+RBR+tP2of6nU0IwHXxR0hOlfGx0bA6yBOlvPrMiIbWCl2gWST87O3zqduS7OkCqBTdFnWXHW3u/4Oe0U5x1MzfoAa25XbrGNfkzAjR5KCErlmty55/Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3dha3pD; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5da686531d3so2347238eaf.3
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Sep 2024 04:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725794062; x=1726398862; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J2hS56VNFXs/0X3NwO9UOQypg/GVldY1IYo+W2uZuCg=;
        b=M3dha3pDzCdy7s9XTkXVwSjHcpHbLfxdiNlR3P+rFjWXTHHf0htmOrMsGtMF0jE6rj
         IgFsWQS2HNtq+vVn21iXpGQDctL95yjla6jJuX9PzPTSEx4L6jn6wiEALjMcrn2diUJM
         xMQZxTyj1ygg8CH8WxeMsAEqVp2JowR7dIRWwrc74YZ3jfNBxBHgcHSzxBt584JaisHp
         C262pgHz2s76KdaNQBKdjFhZQDQ+ud4PF/LMpEpy7w/BjunlhxxqdwPN+ALEFHkxcsow
         ZvD3I50Kok/d6bWphbo8NnJB2reQTdJqQ9nXz09Nf28C5iO4JcTZX9C1KSRSR0qGqTcT
         nnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725794062; x=1726398862;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2hS56VNFXs/0X3NwO9UOQypg/GVldY1IYo+W2uZuCg=;
        b=Q1AU/UT8nPX+0kfSNfxgLxgW/eZfyxJk8CUaHjP0vw2UbOPiODbzDelFLecz4PEodM
         74ACvOrUwA6ljW3wNdgWQtW55Oh1vlCNRPnkpxGbP5zrSy2gjMq1NDKsjINSpqsNcUXs
         MrKmisGgvlByIlqbq933+VxrP9uVI8MHWX1mxEbhiMkdJ2xVbktBe/FTZq9MCXKp1hGj
         oIIefvAZHGdqTJjR2YkpSBFOo5wnpilipQ1VSfDw5QyXkVuq6orfAv2s+otKIM2lI5Rt
         +KnjxJWr2GeefOaCUfMRo6RYMGQNk9r/FMnE0nvbn6q9X/CBXjMNR8SXq1rpdo2u0ASD
         XLDQ==
X-Gm-Message-State: AOJu0Yw1bKGTxLmItbhxTvAzMOs1JF9+phl+AMWcyddk1I87dt1wpGSh
	A3mFaQNYLh9OBRqmELqGTLzAHpvEt0jROPKe2xRmeu2xoc61d8Gn2jvoVtrGN2cyei8nowMNdne
	hnnMLJQPkw6DOLMXLhHuAM6wRsJqDgINP
X-Google-Smtp-Source: AGHT+IG8xX5oP/l0Wgs4Zg4YomqEXGm9hvcwPwn0bCoGmr5zU1yX27do5yA4HyIn1UMFmQlaQ7FgJDlmO4caiyK2yuM=
X-Received: by 2002:a05:6820:1ad5:b0:5dc:95f0:3691 with SMTP id
 006d021491bc7-5e1a9d5bafbmr8601188eaf.8.1725794061638; Sun, 08 Sep 2024
 04:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stefan N <stefannnau@gmail.com>
Date: Sun, 8 Sep 2024 20:44:09 +0930
Message-ID: <CA+W5K0pYAyHS6K5Oy2h03KKgP9+6Q0stOYBrNY7vSmA+J4SdfA@mail.gmail.com>
Subject: Recovering from/avoiding metadata space exhaustion
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I seem to have another issue with btrfs raid6 metadata free space.
I've managed to regain a writeable filesystem by remounting with
skip_balance and quickly adding a 1tb ssd, however, want to know what
I should do next to resolve this safely longer term and avoid it
reoccurring. The raid6 balance has not yet been resumed/canceled.

As the state of the array has been rapidly evolving, these are the
steps over the last month leading up to this issue (after the old
array became inconsistent, due to dev extent overlap)
1) create new 'single' array with 2x disks, fill this new array
2) disconnect another 2x disks from old raid6 array, add these to new
'single' array, and continue to copy data
3) remove remaining 5 disks from old array, add to new 'single' array
4) use balance to convert new 'single' array to raid6 with raid1c3 metadata
5) continue using array, slowly filling it up further

The following error occurred roughly half way through this balance,
(-dconvert=raid6 -mconvert=raid1c3)

** Trigger of previous read-only state

------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 1 PID: 3814 at fs/btrfs/free-space-tree.c:865
remove_from_free_space_tree+0x209/0x210 [btrfs]
Modules linked in: ipt_REJECT nf_reject_ipv4 iptable_filter
xt_connmark xt_mark iptable_mangle xt_comment iptable_raw wireguard
curve25519_x86_64 libchacha20poly1305 chacha_x86_64 poly1305_x86_64
libcurve
25519_generic libchacha ip6_udp_tunnel udp_tunnel xt_nat xt_tcpudp
veth xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat
nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables br_netfilter bri
dge stp llc ipmi_devintf ipmi_msghandler overlay cfg80211 binfmt_misc
nls_iso8859_1 intel_rapl_msr amdgpu intel_rapl_common edac_mce_amd
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi
snd_hda_intel snd_intel_dspcfg kvm_amd snd_intel_sdw_
acpi amdxcp drm_exec snd_hda_codec gpu_sched drm_buddy snd_hda_core
kvm drm_suballoc_helper drm_ttm_helper irqbypass snd_hwdep ttm
drm_display_helper snd_pcm wmi_bmof rapl cec snd_timer rc_core snd
k10temp i2c_piix4 soundcore ccp mac_hid dm_multipath bo
nding tls nfsd efi_pstore auth_rpcgss nfs_acl lockd grace
 sunrpc nfnetlink dmi_sysfs ip_tables x_tables autofs4 btrfs
blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 crct10dif_pclmul
c
rc32_pclmul polyval_clmulni uas polyval_generic usb_storage
ghash_clmulni_intel nvme sha256_ssse3 sha1_ssse3 igb nvme_core ahci
i2c_algo_bit qlcnic xhci_pci libahci dca nvme_auth xhci_pci_renesas
mpt3sas raid_class video scsi_transport_sas wmi aesni_int
el crypto_simd cryptd
CPU: 1 PID: 3814 Comm: btrfs-balance Not tainted 6.8.0-41-generic #41-Ubuntu
Hardware name: To Be Filled By O.E.M. X570M Pro4/X570M Pro4, BIOS
P3.70 02/23/2022
RIP: 0010:remove_from_free_space_tree+0x209/0x210 [btrfs]
Code: c7 c6 c0 5b a4 c0 e8 56 ca 01 00 41 b8 01 00 00 00 eb 81 41 89
c7 e9 48 ff ff ff 44 89 fe 48 c7 c7 e8 5b a4 c0 e8 97 2b 19 e8 <0f> 0b
eb dd 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffb6f700b3ba50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff94421ed373f0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffb6f700b3ba88 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00005fca57b5c000
R13: ffff944204262a10 R14: ffff9442483f6000 R15: 00000000ffffffe4
FS:  0000000000000000(0000) GS:ffff944920280000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007012c82613f4 CR3: 000000018205c000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 ? show_regs+0x6d/0x80
 ? __warn+0x89/0x160
 ? remove_from_free_space_tree+0x209/0x210 [btrfs]
 ? report_bug+0x17e/0x1b0
 ? handle_bug+0x51/0xa0
 ? exc_invalid_op+0x18/0x80
 ? asm_exc_invalid_op+0x1b/0x20
 ? remove_from_free_space_tree+0x209/0x210 [btrfs]
 alloc_reserved_extent+0x24/0x100 [btrfs]
 alloc_reserved_tree_block+0x1af/0x2a0 [btrfs]
 run_delayed_tree_ref+0x17f/0x200 [btrfs]
 btrfs_run_delayed_refs_for_head+0x2d0/0x550 [btrfs]
 __btrfs_run_delayed_refs+0x101/0x1b0 [btrfs]
 btrfs_run_delayed_refs+0x62/0x130 [btrfs]
 btrfs_commit_transaction+0x4ea/0xbe0 [btrfs]
 ? btrfs_release_path+0x2d/0x190 [btrfs]
 insert_balance_item.isra.0+0x104/0x400 [btrfs]
 ? psi_group_change+0x24a/0x550
 btrfs_balance+0x49a/0x990 [btrfs]
 ? __pfx_balance_kthread+0x10/0x10 [btrfs]
 balance_kthread+0x74/0x120 [btrfs]
 kthread+0xf2/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x47/0x70
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>
---[ end trace 0000000000000000 ]---
BTRFS info (device sdd1: state A): dumping space info:
BTRFS info (device sdd1: state A): space_info DATA has 33173680803840
free, is not full
BTRFS info (device sdd1: state A): space_info total=137411433594880,
used=103127752634368, pinned=1073741824, reserved=0, may_use=0,
readonly=1108926414848 zone_unusable=0
BTRFS info (device sdd1: state A): space_info METADATA has 1313734656
free, is full
BTRFS info (device sdd1: state A): space_info total=111669149696,
used=109772881920, pinned=37240832, reserved=2768896,
may_use=542392320, readonly=131072 zone_unusable=0
BTRFS info (device sdd1: state A): space_info SYSTEM has 30539776
free, is not full
BTRFS info (device sdd1: state A): space_info total=41943040,
used=11403264, pinned=0, reserved=0, may_use=0, readonly=0
zone_unusable=0
BTRFS info (device sdd1: state A): global_block_rsv: size 536870912
reserved 536870912
BTRFS info (device sdd1: state A): trans_block_rsv: size 1835008
reserved 1835008
BTRFS info (device sdd1: state A): chunk_block_rsv: size 0 reserved 0
BTRFS info (device sdd1: state A): delayed_block_rsv: size 0 reserved 0
BTRFS info (device sdd1: state A): delayed_refs_rsv: size 142082048
reserved 16384
BTRFS: error (device sdd1: state A) in
remove_from_free_space_tree:865: errno=-28 No space left
BTRFS info (device sdd1: state EA): forced readonly
BTRFS error (device sdd1: state EA): failed to run delayed ref for
logical 105322659561472 num_bytes 16384 type 176 action 1 ref_mod 1:
-28
BTRFS: error (device sdd1: state EA) in btrfs_run_delayed_refs:2249:
errno=-28 No space left
BTRFS warning (device sdd1: state EA): Skipping commit of aborted transaction.
BTRFS: error (device sdd1: state EA) in cleanup_transaction:2020:
errno=-28 No space left
BTRFS info (device sdd1: state EA): balance: resume
-dconvert=raid6,soft -mconvert=raid1c3,soft -sconvert=raid1c3,soft
BTRFS info (device sdd1: state EA): balance: ended with status: -30

$ uname -a
Linux nas 6.8.0-41-generic #41-Ubuntu SMP PREEMPT_DYNAMIC Fri Aug  2
20:41:06 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux

$ btrfs --version
btrfs-progs v6.6.3

$ df -h /mnt/array/
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdd1       162T   95T   31T  76% /mnt/array

$ sudo btrfs fi show /mnt/array/
Label: 'array'  uuid: a-b-c-d-e
        Total devices 9 FS bytes used 93.89TiB
        devid    1 size 20.01TiB used 20.01TiB path /dev/sdd1
        devid    2 size 20.01TiB used 20.01TiB path /dev/sdb1
        devid    3 size 16.37TiB used 16.37TiB path /dev/sdg1
        devid    4 size 20.01TiB used 19.70TiB path /dev/sde1
        devid    5 size 16.37TiB used 16.37TiB path /dev/sdn1
        devid    6 size 20.01TiB used 16.44TiB path /dev/sdh1
        devid    7 size 16.37TiB used 16.37TiB path /dev/sda1
        devid    8 size 16.37TiB used 16.37TiB path /dev/sdf1
        devid    9 size 16.37TiB used 16.37TiB path /dev/sdc1

$ sudo btrfs fi usage /mnt/array/
Overall:
    Device size:                 161.88TiB
    Device allocated:            158.01TiB
    Device unallocated:            3.87TiB
    Device missing:                  0.00B
    Device slack:                    0.00B
    Used:                        114.71TiB
    Free (estimated):             37.37TiB      (min: 35.59TiB)
    Free (statfs, df):            30.17TiB
    Data ratio:                       1.26
    Metadata ratio:                   2.57
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                 yes      (data, metadata, system)

Data,single: Size:43.31TiB, Used:42.31TiB (97.67%)
   /dev/sdd1      19.97TiB
   /dev/sdb1      19.96TiB
   /dev/sdg1      51.00GiB
   /dev/sde1       3.33TiB

Data,RAID6: Size:81.66TiB, Used:51.49TiB (63.05%)
   /dev/sdd1       2.02GiB
   /dev/sdb1       3.00GiB
   /dev/sdg1      16.32TiB
   /dev/sde1      16.36TiB
   /dev/sdn1      16.34TiB
   /dev/sdh1      16.39TiB
   /dev/sda1      16.34TiB
   /dev/sdf1      16.34TiB
   /dev/sdc1      16.34TiB

Metadata,RAID1: Size:45.00GiB, Used:43.27GiB (96.16%)
   /dev/sdd1      42.00GiB
   /dev/sdb1      42.00GiB
   /dev/sdg1       3.00GiB
   /dev/sde1       3.00GiB

Metadata,RAID1C3: Size:59.00GiB, Used:58.96GiB (99.94%)
   /dev/sdn1      30.00GiB
   /dev/sdh1      59.00GiB
   /dev/sda1      30.00GiB
   /dev/sdf1      29.00GiB
   /dev/sdc1      29.00GiB

System,RAID1: Size:8.00MiB, Used:4.47MiB (55.86%)
   /dev/sdd1       8.00MiB
   /dev/sdb1       8.00MiB

System,RAID1C3: Size:32.00MiB, Used:6.41MiB (20.02%)
   /dev/sdh1      32.00MiB
   /dev/sdf1      32.00MiB
   /dev/sdc1      32.00MiB

Unallocated:
   /dev/sdd1       1.00MiB
   /dev/sdb1       1.00MiB
   /dev/sdg1       1.00MiB
   /dev/sde1     317.00GiB
   /dev/sdn1       1.00MiB
   /dev/sdh1       3.56TiB
   /dev/sda1       1.00MiB
   /dev/sdf1       1.00MiB
   /dev/sdc1       1.00MiB
$

** Current state: remediated by adding /dev/sdj (1tb SSD) while
mounted with skip_balance

$ sudo btrfs fi usage /mnt/array/
Overall:
    Device size:                 162.34TiB
    Device allocated:            116.20TiB
    Device unallocated:           46.14TiB
    Device missing:                  0.00B
    Device slack:                    0.00B
    Used:                        114.64TiB
    Free (estimated):             39.15TiB      (min: 16.65TiB)
    Free (statfs, df):            30.65TiB
    Data ratio:                       1.22
    Metadata ratio:                   2.57
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                 yes      (data, metadata, system)

Data,single: Size:43.31TiB, Used:42.31TiB (97.67%)
   /dev/sdd1      19.97TiB
   /dev/sdb1      19.96TiB
   /dev/sdh1      51.00GiB
   /dev/sde1       3.33TiB

Data,RAID6: Size:51.87TiB, Used:51.49TiB (99.26%)
   /dev/sdd1       2.02GiB
   /dev/sdb1       3.00GiB
   /dev/sdh1      10.37TiB
   /dev/sde1      10.37TiB
   /dev/sdm1      10.37TiB
   /dev/sdg1      10.37TiB
   /dev/sda1      10.37TiB
   /dev/sdf1      10.37TiB
   /dev/sdc1      10.37TiB

Metadata,RAID1: Size:45.00GiB, Used:43.27GiB (96.16%)
   /dev/sdd1      42.00GiB
   /dev/sdb1      42.00GiB
   /dev/sdh1       3.00GiB
   /dev/sde1       3.00GiB

Metadata,RAID1C3: Size:60.00GiB, Used:58.95GiB (98.25%)
   /dev/sde1       1.00GiB
   /dev/sdm1      30.00GiB
   /dev/sdg1      60.00GiB
   /dev/sda1      30.00GiB
   /dev/sdf1      29.00GiB
   /dev/sdc1      29.00GiB
   /dev/sdj        1.00GiB

System,RAID1: Size:8.00MiB, Used:4.47MiB (55.86%)
   /dev/sdd1       8.00MiB
   /dev/sdb1       8.00MiB

System,RAID1C3: Size:32.00MiB, Used:3.17MiB (9.91%)
   /dev/sdg1      32.00MiB
   /dev/sdf1      32.00MiB
   /dev/sdc1      32.00MiB

Unallocated:
   /dev/sdd1       1.00MiB
   /dev/sdb1       1.00MiB
   /dev/sdh1       5.94TiB
   /dev/sde1       6.30TiB
   /dev/sdm1       5.97TiB
   /dev/sdg1       9.58TiB
   /dev/sda1       5.97TiB
   /dev/sdf1       5.97TiB
   /dev/sdc1       5.97TiB
   /dev/sdj      464.76GiB
$

