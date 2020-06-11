Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD761F65B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 12:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgFKK3t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 06:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgFKK3s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 06:29:48 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AAAC08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 03:29:46 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id q2so3111090vsr.1
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 03:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=lpD5pphKTVc6wFPnRnuP087Hifkto9ESrX+GD44+2gM=;
        b=rWs8aNMo8X6pfOPS9u5jb8ycW1QNYL2UAKrLHqNfM0LcEilv3mGUZM4DnfMwOaz2hY
         YsQAWh44c956j6zto+veNil240Ybm/fZEbV8pun30GBcFy7fN9fhbceyzlc0yK1GTmH3
         vjgaYbjow8Em4UNH5XlGcSQZR46lU8YXBU5EKbHQ9M28uZSv5RGxMeQAyU+iPd5q/053
         BBqkwjGI6/7cMibdt6YpzoA1GzXvwg67zSSSCPBZf4r5xpRzRkxF5r4exOFcAmUzVO2H
         UnlF7VXocmpAg2Hk00MIocF+bHCKHZKRKui/VQwfihVRt4jZ7SnaEJkYMwd9agpAvzlW
         kDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lpD5pphKTVc6wFPnRnuP087Hifkto9ESrX+GD44+2gM=;
        b=rv3IlYaokVgH0Uf20dH2lQQdOEWKqWTLLg6H3UNUxKsv5BSJ6QMSZ9ucz0QryEF1nt
         nLE7ryaRg6P4+PFkasND6qGFc5WIrSdy3vueETK4QFu3qC5LUPEIv0Rc9MB2fAxvtiKS
         6Bi1Bbfypi1RzHjVirlseoNb3ejqTp42/PIWT4X3Ij/2wMmR+9I7pj53AOe+0sSoUM2T
         cipnxpp7FQVE2OJlEk9X8oiKw0qZvDWGKqmh0OjmYf9w+4tvseValn2e9ZjIZwIIamXe
         tPORknMcneQK2z/TUMqCBC8blXFLvW02ApuxXWAW8/pPAG16EH6GGYJtZyQXxOYl03Gr
         tk6w==
X-Gm-Message-State: AOAM530w+bbY52GnyNJc2uA5h2MwfM90FjBlNKifwyFEjgCwf5ByXLH3
        MRGbHn6Kehadmc3E/p28zsXUbWplGb4Wo4cZSjyGwX6D
X-Google-Smtp-Source: ABdhPJxvyNcn3YnX6Ry6yeQCOnYQyu7hXIwQXxomgRO6TLiUjrduuayDXgRwm+o2JPuP0B9fUjMM+KOifUTy15Qg/UQ=
X-Received: by 2002:a67:4383:: with SMTP id q125mr5773515vsa.167.1591871385706;
 Thu, 11 Jun 2020 03:29:45 -0700 (PDT)
MIME-Version: 1.0
From:   Greed Rong <greedrong@gmail.com>
Date:   Thu, 11 Jun 2020 18:29:34 +0800
Message-ID: <CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com>
Subject: BTRFS: Transaction aborted (error -24)
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,
I have got this error several times. Are there any suggestions to avoid this?

# dmesg
[7142286.563596] ------------[ cut here ]------------
[7142286.564499] BTRFS: Transaction aborted (error -24)
[7142286.565053] WARNING: CPU: 17 PID: 17041 at
fs/btrfs/transaction.c:1576 create_pending_snapshot+0xbc4/0xd10
[btrfs]
[7142286.565482] Modules linked in: vhost_net vhost tap xt_CHECKSUM
iptable_mangle ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
nf_reject_ipv4 xt_tcpudp ebtable_filter ebtables ip6table_filter
ip6_tables iptable_filter bpfilter iscsi_target_mod target_core_mod
overlay 8021q garp mrp bonding bridge stp llc ipmi_ssif nls_iso8859_1
intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp
dcdbas kvm_intel kvm joydev input_leds irqbypass intel_cstate
intel_rapl_perf lpc_ich mei_me mei ipmi_si ipmi_devintf
ipmi_msghandler acpi_power_meter mac_hid sch_fq_codel ib_iser rdma_cm
iw_cm ib_cm iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi
ip_tables x_tables autofs4 btrfs zstd_compress raid10 raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx xor
raid6_pq libcrc32c raid1 raid0 multipath linear mlx4_ib ib_uverbs
mlx4_en ib_core hid_generic usbhid hid crct10dif_pclmul crc32_pclmul
mgag200 i2c_algo_bit
[7142286.565508]  ghash_clmulni_intel ttm drm_kms_helper aesni_intel
syscopyarea sysfillrect mxm_wmi aes_x86_64 sysimgblt crypto_simd
fb_sys_fops cryptd glue_helper ahci drm mlx4_core tg3 libahci
megaraid_sas devlink wmi
[7142286.570322] CPU: 17 PID: 17041 Comm: btrfs Tainted: G      D
     5.0.10-050010-generic #201904270832
[7142286.570893] Hardware name: Dell Inc. PowerEdge R730xd/0H21J3,
BIOS 2.10.5 07/25/2019
[7142286.571479] RIP: 0010:create_pending_snapshot+0xbc4/0xd10 [btrfs]
[7142286.572063] Code: f0 48 0f ba aa 40 ce 00 00 02 72 27 83 f8 fb 0f
84 54 8d 08 00 89 c6 48 c7 c7 10 41 95 c0 48 89 85 60 ff ff ff e8 6e
17 3e f3 <0f> 0b 48 8b 85 60 ff ff ff 89 c1 ba 28 06 00 00 48 c7 c6 b0
7e 94
[7142286.573357] RSP: 0018:ffffac950ff0fa10 EFLAGS: 00010282
[7142286.573981] RAX: 0000000000000000 RBX: ffff9ec1602e2e38 RCX:
0000000000000006
[7142286.574615] RDX: 0000000000000007 RSI: 0000000000000082 RDI:
ffff9eefbf816440
[7142286.575247] RBP: ffffac950ff0fb00 R08: 0000000000000000 R09:
0000000000002595
[7142286.575888] R10: 0000000000010101 R11: ffff9ebfab630c90 R12:
ffff9ebf8998c3c0
[7142286.576561] R13: 00000000ffffffe8 R14: ffff9e92f1bde000 R15:
ffff9e9701297e00
[7142286.577251] FS:  00007fbcad9e18c0(0000) GS:ffff9eefbf800000(0000)
knlGS:0000000000000000
[7142286.577910] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[7142286.578569] CR2: 00007fbcac82e100 CR3: 00000030ad800004 CR4:
00000000001626e0
[7142286.579240] Call Trace:
[7142286.579915]  create_pending_snapshots+0x82/0xa0 [btrfs]
[7142286.580627]  ? create_pending_snapshots+0x82/0xa0 [btrfs]
[7142286.581350]  btrfs_commit_transaction+0x275/0x8c0 [btrfs]
[7142286.582049]  ? btrfs_subvolume_reserve_metadata+0x41/0x180 [btrfs]
[7142286.582750]  btrfs_mksubvol+0x4b9/0x500 [btrfs]
[7142286.583447]  ? security_capable+0x3c/0x60
[7142286.584144]  btrfs_ioctl_snap_create_transid+0x174/0x180 [btrfs]
[7142286.584928]  btrfs_ioctl_snap_create_v2+0x11c/0x180 [btrfs]
[7142286.585646]  btrfs_ioctl+0x11a4/0x2da0 [btrfs]
[7142286.586346]  ? filemap_map_pages+0x1ae/0x380
[7142286.587047]  do_vfs_ioctl+0xa9/0x640
[7142286.587739]  ? do_vfs_ioctl+0xa9/0x640
[7142286.588441]  ksys_ioctl+0x67/0x90
[7142286.589202]  __x64_sys_ioctl+0x1a/0x20
[7142286.589899]  do_syscall_64+0x5a/0x110
[7142286.590604]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[7142286.591308] RIP: 0033:0x7fbcac7c75d7
[7142286.592011] Code: b3 66 90 48 8b 05 b1 48 2d 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 81 48 2d 00 f7 d8 64 89
01 48
[7142286.593558] RSP: 002b:00007fff93db05c8 EFLAGS: 00000206 ORIG_RAX:
0000000000000010
[7142286.594296] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007fbcac7c75d7
[7142286.595034] RDX: 00007fff93db0610 RSI: 0000000050009417 RDI:
0000000000000003
[7142286.595765] RBP: 0000000000000003 R08: 0000000000000000 R09:
000000000000000d
[7142286.596492] R10: 00000000fffffff3 R11: 0000000000000206 R12:
000056203917f260
[7142286.597241] R13: 00007fff93db1e46 R14: 00007fff93db0610 R15:
0000000000000004
[7142286.597926] ---[ end trace 33f2f83f3d5250e9 ]---
[7142286.598635] BTRFS: error (device sda1) in
create_pending_snapshot:1576: errno=-24 unknown
[7142286.599388] BTRFS info (device sda1): forced readonly
[7142286.600037] BTRFS warning (device sda1): Skipping commit of
aborted transaction.
[7142286.600731] BTRFS: error (device sda1) in
cleanup_transaction:1831: errno=-24 unknown

# lsb_release -a
No LSB modules are available.
Distributor ID:    Ubuntu
Description:    Ubuntu 18.04.2 LTS
Release:    18.04
Codename:    bionic

# uname -a
Linux gz-cached-10 5.0.10-050010-generic #201904270832 SMP Sat Apr 27
08:34:43 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

# btrfs --version
btrfs-progs v4.20.2

# btrfs fi show
Label: none  uuid: 209cc44a-3e68-46bd-ad69-184228c73ece
    Total devices 1 FS bytes used 4.31TiB
    devid    1 size 8.73TiB used 5.00TiB path /dev/sda1

# btrfs fi df /snapshot/
Data, single: total=4.92TiB, used=4.28TiB
System, DUP: total=8.00MiB, used=544.00KiB
Metadata, DUP: total=45.00GiB, used=24.60GiB
GlobalReserve, single: total=512.00MiB, used=0.00B
