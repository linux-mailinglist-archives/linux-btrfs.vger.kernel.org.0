Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769E43AD0F1
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 19:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbhFRRJT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 13:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbhFRRJM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 13:09:12 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCFDC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 10:07:01 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c9so12671229qkm.0
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=uLWX2m2t/412lyt3H58GBC+Foy4Zk+h3rnS9Z4B+AN8=;
        b=Sb9OrnIcUYbb3xkRMCmcJq1dwTQjfpCMAENqgjlASnqFUqpf1Aar+XW/Vi3uJ8JfBq
         lKAFlJAXvSqP4KtEXHxy0Sz4uAYbcU5q6DXGWDYuEvg+tDf9esKcte/CIA1lZ0T6D2YA
         DrluRetD/wAu4IIeHLocjulBxjPolxzJXTmTsORyQ+JYsrdm51OP2I/GhFkmts41sV5+
         2+tx/QckyD02/XVPL+isBAg7fQ2S7M5uCDQuMGoxuis3MBYbPIEAeGrxgpV6UajoJhsJ
         /G3fHAAJvXWXJC9Chps8ATCtttx3pz7X3rxLW0z8IM4WkVw9YXJvT+8+1Nh450CM5sVS
         ZZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uLWX2m2t/412lyt3H58GBC+Foy4Zk+h3rnS9Z4B+AN8=;
        b=NSODDmzRlivh/oDHu9gyD8X3woUfsW7FeaP6qC/wGmkWh1DXE+Jl2DliMHbq5wGq6Q
         b7XLYoM0TqVIXqq1aVCAXgkyyH/tPcSKdGY1+RfqLiF1lH39ravveEOUSlPJCLpl7hYe
         WAsPiBiadsnZsq/Jcgp+mVUa33Mv6DA0E+H7ICddVy0MYGA7RNHJJFPnA+s9IfqSS3qx
         izAVPYNl2hPhOFLGPaAbeTfLOdTrslBeNuxdU6vcyvLTM2EsUl27f5K+Cf6ul11lD3Vz
         BVqUjPlKN1AaxuNBiN4NXpFxJaHx//RGVvFrn3sMGuOgMpP01H4lTnjDcp9twtGRHXxl
         dwQQ==
X-Gm-Message-State: AOAM5317He4TSlAt6vEdRs2l9b50MifJWMRSy+ByhDr5QZYqrvx+Drpw
        7g4hv0/iHkH94hBuKv7N3h9wV2woMDe9FvdJVNcXGUNCbAQCJUeS
X-Google-Smtp-Source: ABdhPJwSL1JBPqNIo6D4BVyT++f3cCX06ZKmP2mMnZkh87WFMd8B1UCrJn2HE8sgNAHHwFg1rPaa8BWAmeN0RV+8KPA=
X-Received: by 2002:a25:ba08:: with SMTP id t8mr14703270ybg.111.1624036020278;
 Fri, 18 Jun 2021 10:07:00 -0700 (PDT)
MIME-Version: 1.0
From:   Thiago Ramon <thiagoramon@gmail.com>
Date:   Fri, 18 Jun 2021 14:06:49 -0300
Message-ID: <CAO1Y9wrzMEf+H5cg2SaJrcZy8Qb7aeufHDXAt0f71bEA_5HAwg@mail.gmail.com>
Subject: Kernel GPF on RAID6 replace
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A disk decided to just disappear from the array (this is a 12-disk
RAID6-data/RAID1C4-metadata array) a few hours ago, and I've started a
replace with a hot spare. The array had an unusually bad event a few
months back with a disk starting to show some read failures, and dying
in the middle of a scrub. Replacing it revealed a lot of errors all
over the array, though I couldn't identify the reason. Memory
corruption was a suspect, but the memory didn't show any errors upon
extended testing. I had a few uncorrectable errors still lingering
around while this other disk died, in case this could be part of the
problem here.

A few moments after the replace started, the machine went
unresponsive. After rebooting and remounting degraded to continue the
replace, while observing the dmesg output, I started seeing the kernel
errors and the machine can't access disks anymore. I was on an Ubuntu
HWE kernel (currently on 5.8) at the time, but I tested the latest
5.12 and it also throws similar GPFs. Even the main disk won't sync
anymore after the errors, so getting the logs out is a bit
complicated, but if it helps with logs from another kernel I'll get
some.

I did replace the machine memory to be sure that wasn't the problem,
so if something is bad, it would e the processor, which is very
unlikely. Also no other piece of software there has had any trouble so
far.

Here's what I could capture:
Jun 18 12:37:56 balthasar kernel: BTRFS info (device bcache8):
enabling auto defrag
Jun 18 12:37:56 balthasar kernel: BTRFS info (device bcache8): force
zstd compression, level 3
Jun 18 12:37:56 balthasar kernel: BTRFS info (device bcache8):
allowing degraded mounts
Jun 18 12:37:56 balthasar kernel: BTRFS info (device bcache8): disk
space caching is enabled
Jun 18 12:37:56 balthasar kernel: BTRFS info (device bcache8): has
skinny extents
Jun 18 12:37:56 balthasar kernel: BTRFS warning (device bcache8):
devid 6 uuid c9792a3f-e5f4-415a-9c54-81f11db046be is missing
Jun 18 12:37:58 balthasar kernel: BTRFS info (device bcache8): bdev
(efault) errs: wr 6896987, rd 6693338, flush 1145, corrupt 0, gen 0
Jun 18 12:37:58 balthasar kernel: BTRFS info (device bcache8): bdev
/dev/bcache2 errs: wr 0, rd 0, flush 0, corrupt 127, gen 0
Jun 18 12:37:58 balthasar kernel: BTRFS info (device bcache8): bdev
/dev/bcache5 errs: wr 0, rd 0, flush 0, corrupt 596, gen 0
Jun 18 12:37:58 balthasar kernel: BTRFS info (device bcache8): bdev
/dev/bcache4 errs: wr 0, rd 0, flush 0, corrupt 278, gen 0
Jun 18 12:37:58 balthasar kernel: BTRFS info (device bcache8): bdev
/dev/bcache6 errs: wr 0, rd 0, flush 0, corrupt 119, gen 0
Jun 18 12:37:58 balthasar kernel: BTRFS info (device bcache8): bdev
/dev/bcache9 errs: wr 0, rd 0, flush 0, corrupt 82, gen 1
Jun 18 12:37:58 balthasar kernel: BTRFS info (device bcache8): bdev
/dev/bcache10 errs: wr 0, rd 0, flush 0, corrupt 849, gen 0
Jun 18 12:37:58 balthasar kernel: BTRFS info (device bcache8): bdev
/dev/bcache1 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
Jun 18 12:37:58 balthasar kernel: BTRFS info (device bcache8): bdev
/dev/bcache0 errs: wr 0, rd 0, flush 0, corrupt 65, gen 0
Jun 18 12:38:23 balthasar kernel: BTRFS info (device bcache8):
enabling ssd optimizations
Jun 18 12:38:23 balthasar kernel: BTRFS info (device bcache8):
continuing dev_replace from <missing disk> (devid 6) to target
/dev/bcache8 @0%
Jun 18 12:38:24 balthasar kernel: BTRFS warning (device bcache8): csum
failed root 5 ino 19656523 off 153594132299776 csum 0x8941f998
expected csum 0xe402f64f mirror 2
Jun 18 12:38:24 balthasar kernel: BTRFS warning (device bcache8): csum
failed root 5 ino 19656523 off 153594132299776 csum 0x8941f998
expected csum 0xe402f64f mirror 2
Jun 18 12:38:24 balthasar kernel: BTRFS warning (device bcache8): csum
failed root 5 ino 19656523 off 153594132299776 csum 0x8941f998
expected csum 0xe402f64f mirror 2
Jun 18 12:38:24 balthasar kernel: BTRFS warning (device bcache8): csum
failed root 5 ino 19656523 off 153594132299776 csum 0x8941f998
expected csum 0xe402f64f mirror 2
Jun 18 12:38:24 balthasar kernel: BTRFS warning (device bcache8): csum
failed root 5 ino 19656523 off 153594132299776 csum 0x8941f998
expected csum 0xe402f64f mirror 2
Jun 18 12:38:24 balthasar kernel: BTRFS warning (device bcache8): csum
failed root 5 ino 19656523 off 153594132299776 csum 0x8941f998
expected csum 0xe402f64f mirror 2
Jun 18 12:38:24 balthasar kernel: BTRFS warning (device bcache8): csum
failed root 5 ino 19656523 off 153594132299776 csum 0x8941f998
expected csum 0xe402f64f mirror 2
Jun 18 12:38:24 balthasar kernel: BTRFS warning (device bcache8): csum
failed root 5 ino 19656523 off 153594132299776 csum 0x8941f998
expected csum 0xe402f64f mirror 2
Jun 18 12:38:24 balthasar kernel: BTRFS warning (device bcache8): csum
failed root 5 ino 19656523 off 153594132299776 csum 0x8941f998
expected csum 0xe402f64f mirror 2
Jun 18 12:38:24 balthasar kernel: BTRFS warning (device bcache8): csum
failed root 5 ino 19656523 off 153594132299776 csum 0x8941f998
expected csum 0xe402f64f mirror 2
Jun 18 12:38:25 balthasar kernel: BTRFS info (device bcache8): read
error corrected: ino 19656523 off 2158592 (dev /dev/bcache4 sector
2707449080)
Jun 18 12:38:25 balthasar kernel: BTRFS info (device bcache8): read
error corrected: ino 19656523 off 2097152 (dev /dev/bcache4 sector
2707449080)
Jun 18 12:38:25 balthasar kernel: BTRFS info (device bcache8): read
error corrected: ino 19656523 off 2101248 (dev /dev/bcache4 sector
2707449080)
Jun 18 12:38:25 balthasar kernel: BTRFS info (device bcache8): read
error corrected: ino 19656523 off 2105344 (dev /dev/bcache4 sector
2707449080)
Jun 18 12:38:26 balthasar kernel: BTRFS info (device bcache8): read
error corrected: ino 19656523 off 2109440 (dev /dev/bcache4 sector
2707449080)
Jun 18 12:38:26 balthasar kernel: BTRFS info (device bcache8): read
error corrected: ino 19656523 off 2113536 (dev /dev/bcache4 sector
2707449080)
Jun 18 12:38:26 balthasar kernel: BTRFS info (device bcache8): read
error corrected: ino 19656523 off 2117632 (dev /dev/bcache4 sector
2707449080)
Jun 18 12:38:26 balthasar kernel: BTRFS info (device bcache8): read
error corrected: ino 19656523 off 2121728 (dev /dev/bcache4 sector
2707449080)
Jun 18 12:38:26 balthasar kernel: BTRFS info (device bcache8): read
error corrected: ino 19656523 off 2125824 (dev /dev/bcache4 sector
2707449080)
Jun 18 12:38:26 balthasar kernel: BTRFS info (device bcache8): read
error corrected: ino 19656523 off 2129920 (dev /dev/bcache4 sector
2707449080)
Jun 18 12:38:27 balthasar kernel: BTRFS warning (device bcache8): csum
failed root 5 ino 19656539 off 65536 csum 0x29f46903 expected csum
0x8675682d mirror 1
Jun 18 12:38:27 balthasar kernel: BTRFS warning (device bcache8): csum
failed root 5 ino 19656539 off 65536 csum 0x29f46903 expected csum
0x8675682d mirror 2
Jun 18 12:38:27 balthasar kernel: BTRFS warning (device bcache8): csum
failed root 5 ino 19656539 off 65536 csum 0x29f46903 expected csum
0x8675682d mirror 11
Jun 18 12:38:27 balthasar kernel: BTRFS warning (device bcache8): csum
failed root 5 ino 19656539 off 65536 csum 0x29f46903 expected csum
0x8675682d mirror 1
Jun 18 12:38:27 balthasar kernel: BTRFS warning (device bcache8): csum
failed root 5 ino 19656539 off 65536 csum 0x29f46903 expected csum
0x8675682d mirror 1
Jun 18 12:38:27 balthasar kernel: general protection fault, probably
for non-canonical address 0x17d5269120963487: 0000 [#1] SMP NOPTI
Jun 18 12:38:27 balthasar kernel: CPU: 1 PID: 221 Comm: kworker/u32:4
Not tainted 5.8.0-55-generic #62~20.04.1-Ubuntu
Jun 18 12:38:27 balthasar kernel: Hardware name: Gigabyte Technology
Co., Ltd. B450M DS3H/B450M DS3H-CF, BIOS F4 01/25/2019
Jun 18 12:38:27 balthasar kernel: Workqueue: btrfs-rmw btrfs_work_helper [btrfs]
Jun 18 12:38:27 balthasar kernel: RIP: 0010:kmem_cache_alloc+0x89/0x230
Jun 18 12:38:27 balthasar kernel: Code: 08 65 4c 03 05 30 8b d5 44 49
83 78 10 00 4d 8b 20 0f 84 8e 01 00 00 4d 85 e4 0f 84 85 01 00 00 41
8b 47 20 49 8b 3f 4c 01 e0 <48> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c
89 e0 48 0f c9 48 31 cb
Jun 18 12:38:27 balthasar kernel: RSP: 0018:ffffa6eac051bc30 EFLAGS: 00010206
Jun 18 12:38:27 balthasar kernel: RAX: 17d5269120963487 RBX:
0000000000000000 RCX: ffff8b7ebd794e00
Jun 18 12:38:27 balthasar kernel: RDX: 0000000000006ca8 RSI:
0000000000092800 RDI: 00000000000324f0
Jun 18 12:38:27 balthasar kernel: RBP: ffffa6eac051bc60 R08:
ffff8b7ed0c724f0 R09: 0000000000000010
Jun 18 12:38:27 balthasar kernel: R10: ffff8b7e23313c00 R11:
ffff8b7e14615830 R12: 17d52691209633e7
Jun 18 12:38:27 balthasar kernel: R13: 0000000000092800 R14:
ffff8b7ecf023b80 R15: ffff8b7ecf023b80
Jun 18 12:38:27 balthasar kernel: FS:  0000000000000000(0000)
GS:ffff8b7ed0c40000(0000) knlGS:0000000000000000
Jun 18 12:38:27 balthasar kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jun 18 12:38:27 balthasar kernel: CR2: 00007fa7b99b5000 CR3:
00000003995b8000 CR4: 00000000003406e0
Jun 18 12:38:27 balthasar kernel: Call Trace:
Jun 18 12:38:27 balthasar kernel:  ? mempool_alloc_slab+0x17/0x20
Jun 18 12:38:27 balthasar kernel:  mempool_alloc_slab+0x17/0x20
Jun 18 12:38:27 balthasar kernel:  mempool_alloc+0x64/0x180
Jun 18 12:38:27 balthasar kernel:  ? kmem_cache_alloc+0x178/0x230
Jun 18 12:38:27 balthasar kernel:  ? bvec_alloc+0x57/0xf0
Jun 18 12:38:27 balthasar kernel:  bio_alloc_bioset+0xb0/0x200
Jun 18 12:38:27 balthasar kernel:  btrfs_io_bio_alloc+0x1c/0x50 [btrfs]
Jun 18 12:38:27 balthasar kernel: BTRFS warning (device bcache8): csum
failed root 5 ino 19656539 off 65536 csum 0x29f46903 expected csum
0x8675682d mirror 2
Jun 18 12:38:27 balthasar kernel:  rbio_add_io_page+0x82/0x1a0 [btrfs]
Jun 18 12:38:27 balthasar kernel:  __raid56_parity_recover+0x104/0x250 [btrfs]
Jun 18 12:38:27 balthasar kernel:  read_rebuild_work+0x12/0x20 [btrfs]
Jun 18 12:38:27 balthasar kernel:  btrfs_work_helper+0xc5/0x390 [btrfs]
Jun 18 12:38:27 balthasar kernel:  process_one_work+0x1e8/0x3b0
Jun 18 12:38:27 balthasar kernel:  worker_thread+0x4d/0x3f0
Jun 18 12:38:27 balthasar kernel:  kthread+0x114/0x150
Jun 18 12:38:27 balthasar kernel:  ? process_one_work+0x3b0/0x3b0
Jun 18 12:38:27 balthasar kernel:  ? kthread_park+0x90/0x90
Jun 18 12:38:27 balthasar kernel:  ret_from_fork+0x22/0x30
Jun 18 12:38:27 balthasar kernel: Modules linked in: xt_nat
xt_MASQUERADE xt_recent xt_comment nf_tables ipt_REJECT nf_reject_ipv4
xt_addrtype iptable_nat xt_mark iptable_mangle xt_TCPMSS xt_tcpudp
xt_CT iptable_raw xt_multiport xt_conntrack nfnetlink_log xt_NFLOG
nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp nf_nat_snmp_basic
nf_conntrack_snmp nf_nat_sip nf_nat_pptp nf_nat_irc nf_nat_h323
nf_nat_ftp nf_nat_amanda ts_kmp nf_conntrack_amanda nf_nat
nf_conntrack_sane nf_conntrack_tftp nf_conntrack_sip nf_conntrack_pptp
nf_conntrack_netlink nfnetlink nf_conntrack_netbios_ns
nf_conntrack_broadcast nf_conntrack_irc nf_conntrack_h323
nf_conntrack_ftp nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
iptable_filter bpfilter cfg80211 8021q garp mrp stp llc binfmt_misc
dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua snd_hda_codec_hdmi
snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep
snd_pcm snd_seq_midi edac_mce_amd snd_seq_midi_event snd_rawmidi kvm
rapl snd_seq wmi_bmof k10temp snd_seq_device snd_timer
Jun 18 12:38:27 balthasar kernel:  cdc_ether usbnet r8152 mii snd
soundcore ccp cdc_acm mac_hid sch_fq_codel parport_pc ppdev lp parport
ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid0
multipath linear raid1 dm_raid raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c bcache crc64 ses
enclosure amdgpu iommu_v2 gpu_sched crct10dif_pclmul i2c_algo_bit
crc32_pclmul ghash_clmulni_intel ttm drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops aesni_intel crypto_simd cryptd cec
rc_core glue_helper mpt3sas raid_class drm ahci i2c_piix4 r8169
xhci_pci realtek libahci xhci_pci_renesas scsi_transport_sas wmi video
gpio_amdpt gpio_generic
Jun 18 12:38:27 balthasar kernel: ---[ end trace 40846da2a524d9a5 ]---
Jun 18 12:38:27 balthasar kernel: RIP: 0010:kmem_cache_alloc+0x89/0x230
Jun 18 12:38:27 balthasar kernel: Code: 08 65 4c 03 05 30 8b d5 44 49
83 78 10 00 4d 8b 20 0f 84 8e 01 00 00 4d 85 e4 0f 84 85 01 00 00 41
8b 47 20 49 8b 3f 4c 01 e0 <48> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c
89 e0 48 0f c9 48 31 cb
Jun 18 12:38:27 balthasar kernel: RSP: 0018:ffffa6eac051bc30 EFLAGS: 00010206
Jun 18 12:38:27 balthasar kernel: RAX: 17d5269120963487 RBX:
0000000000000000 RCX: ffff8b7ebd794e00
Jun 18 12:38:27 balthasar kernel: RDX: 0000000000006ca8 RSI:
0000000000092800 RDI: 00000000000324f0
Jun 18 12:38:27 balthasar kernel: RBP: ffffa6eac051bc60 R08:
ffff8b7ed0c724f0 R09: 0000000000000010
Jun 18 12:38:27 balthasar kernel: R10: ffff8b7e23313c00 R11:
ffff8b7e14615830 R12: 17d52691209633e7
Jun 18 12:38:27 balthasar kernel: R13: 0000000000092800 R14:
ffff8b7ecf023b80 R15: ffff8b7ecf023b80
Jun 18 12:38:27 balthasar kernel: FS:  0000000000000000(0000)
GS:ffff8b7ed0c40000(0000) knlGS:0000000000000000
Jun 18 12:38:27 balthasar kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jun 18 12:38:27 balthasar kernel: CR2: 00007fa7b99b5000 CR3:
00000003995b8000 CR4: 00000000003406e0
Jun 18 12:38:27 balthasar kernel: general protection fault, probably
for non-canonical address 0x17d5269120963487: 0000 [#2] SMP NOPTI
Jun 18 12:38:27 balthasar kernel: CPU: 1 PID: 218 Comm: kworker/u32:2
Tainted: G      D           5.8.0-55-generic #62~20.04.1-Ubuntu
Jun 18 12:38:27 balthasar kernel: Hardware name: Gigabyte Technology
Co., Ltd. B450M DS3H/B450M DS3H-CF, BIOS F4 01/25/2019
Jun 18 12:38:27 balthasar kernel: Workqueue: btrfs-rmw btrfs_work_helper [btrfs]
Jun 18 12:38:27 balthasar kernel: RIP: 0010:kmem_cache_alloc+0x89/0x230
Jun 18 12:38:27 balthasar kernel: Code: 08 65 4c 03 05 30 8b d5 44 49
83 78 10 00 4d 8b 20 0f 84 8e 01 00 00 4d 85 e4 0f 84 85 01 00 00 41
8b 47 20 49 8b 3f 4c 01 e0 <48> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c
89 e0 48 0f c9 48 31 cb
Jun 18 12:38:27 balthasar kernel: RSP: 0018:ffffa6eac04dfc30 EFLAGS: 00010206
Jun 18 12:38:27 balthasar kernel: RAX: 17d5269120963487 RBX:
0000000000000000 RCX: ffff8b7ebd7a30c0
Jun 18 12:38:27 balthasar kernel: RDX: 0000000000006ca8 RSI:
0000000000092800 RDI: 00000000000324f0
Jun 18 12:38:27 balthasar kernel: RBP: ffffa6eac04dfc60 R08:
ffff8b7ed0c724f0 R09: 0000000000000010
Jun 18 12:38:27 balthasar kernel: R10: ffff8b7e3967c400 R11:
0000000000000000 R12: 17d52691209633e7
Jun 18 12:38:27 balthasar kernel: R13: 0000000000092800 R14:
ffff8b7ecf023b80 R15: ffff8b7ecf023b80
Jun 18 12:38:27 balthasar kernel: FS:  0000000000000000(0000)
GS:ffff8b7ed0c40000(0000) knlGS:0000000000000000
Jun 18 12:38:27 balthasar kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jun 18 12:38:27 balthasar kernel: CR2: 00007fa7b99b5000 CR3:
00000003995b8000 CR4: 00000000003406e0
Jun 18 12:38:27 balthasar kernel: Call Trace:
Jun 18 12:38:27 balthasar kernel:  ? mempool_alloc_slab+0x17/0x20
Jun 18 12:38:27 balthasar kernel:  mempool_alloc_slab+0x17/0x20
Jun 18 12:38:27 balthasar kernel:  mempool_alloc+0x64/0x180
Jun 18 12:38:27 balthasar kernel:  ? get_page_from_freelist+0x1b5/0x370
Jun 18 12:38:27 balthasar kernel:  bio_alloc_bioset+0xb0/0x200
Jun 18 12:38:27 balthasar kernel:  btrfs_io_bio_alloc+0x1c/0x50 [btrfs]
Jun 18 12:38:27 balthasar kernel:  rbio_add_io_page+0x82/0x1a0 [btrfs]
Jun 18 12:38:27 balthasar kernel:  __raid56_parity_recover+0x104/0x250 [btrfs]
Jun 18 12:38:27 balthasar kernel:  read_rebuild_work+0x12/0x20 [btrfs]
Jun 18 12:38:27 balthasar kernel:  btrfs_work_helper+0xc5/0x390 [btrfs]
Jun 18 12:38:27 balthasar kernel:  process_one_work+0x1e8/0x3b0
Jun 18 12:38:27 balthasar kernel:  worker_thread+0x4d/0x3f0
Jun 18 12:38:27 balthasar kernel:  kthread+0x114/0x150
Jun 18 12:38:27 balthasar kernel:  ? process_one_work+0x3b0/0x3b0
Jun 18 12:38:27 balthasar kernel:  ? kthread_park+0x90/0x90
Jun 18 12:38:27 balthasar kernel:  ret_from_fork+0x22/0x30
Jun 18 12:38:27 balthasar kernel: Modules linked in: xt_nat
xt_MASQUERADE xt_recent xt_comment nf_tables ipt_REJECT nf_reject_ipv4
xt_addrtype iptable_nat xt_mark iptable_mangle xt_TCPMSS xt_tcpudp
xt_CT iptable_raw xt_multiport xt_conntrack nfnetlink_log xt_NFLOG
nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp nf_nat_snmp_basic
nf_conntrack_snmp nf_nat_sip nf_nat_pptp nf_nat_irc nf_nat_h323
nf_nat_ftp nf_nat_amanda ts_kmp nf_conntrack_amanda nf_nat
nf_conntrack_sane nf_conntrack_tftp nf_conntrack_sip nf_conntrack_pptp
nf_conntrack_netlink nfnetlink nf_conntrack_netbios_ns
nf_conntrack_broadcast nf_conntrack_irc nf_conntrack_h323
nf_conntrack_ftp nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
iptable_filter bpfilter cfg80211 8021q garp mrp stp llc binfmt_misc
dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua snd_hda_codec_hdmi
snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep
snd_pcm snd_seq_midi edac_mce_amd snd_seq_midi_event snd_rawmidi kvm
rapl snd_seq wmi_bmof k10temp snd_seq_device snd_timer
Jun 18 12:38:27 balthasar kernel:  cdc_ether usbnet r8152 mii snd
soundcore ccp cdc_acm mac_hid sch_fq_codel parport_pc ppdev lp parport
ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid0
multipath linear raid1 dm_raid raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c bcache crc64 ses
enclosure amdgpu iommu_v2 gpu_sched crct10dif_pclmul i2c_algo_bit
crc32_pclmul ghash_clmulni_intel ttm drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops aesni_intel crypto_simd cryptd cec
rc_core glue_helper mpt3sas raid_class drm ahci i2c_piix4 r8169
xhci_pci realtek libahci xhci_pci_renesas scsi_transport_sas wmi video
gpio_amdpt gpio_generic
Jun 18 12:38:27 balthasar kernel: ---[ end trace 40846da2a524d9a6 ]---
Jun 18 12:38:27 balthasar kernel: RIP: 0010:kmem_cache_alloc+0x89/0x230
Jun 18 12:38:27 balthasar kernel: Code: 08 65 4c 03 05 30 8b d5 44 49
83 78 10 00 4d 8b 20 0f 84 8e 01 00 00 4d 85 e4 0f 84 85 01 00 00 41
8b 47 20 49 8b 3f 4c 01 e0 <48> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c
89 e0 48 0f c9 48 31 cb
Jun 18 12:38:27 balthasar kernel: RSP: 0018:ffffa6eac051bc30 EFLAGS: 00010206
Jun 18 12:38:27 balthasar kernel: RAX: 17d5269120963487 RBX:
0000000000000000 RCX: ffff8b7ebd794e00
Jun 18 12:38:27 balthasar kernel: RDX: 0000000000006ca8 RSI:
0000000000092800 RDI: 00000000000324f0
Jun 18 12:38:27 balthasar kernel: RBP: ffffa6eac051bc60 R08:
ffff8b7ed0c724f0 R09: 0000000000000010
Jun 18 12:38:27 balthasar kernel: R10: ffff8b7e23313c00 R11:
ffff8b7e14615830 R12: 17d52691209633e7
Jun 18 12:38:27 balthasar kernel: R13: 0000000000092800 R14:
ffff8b7ecf023b80 R15: ffff8b7ecf023b80
Jun 18 12:38:27 balthasar kernel: FS:  0000000000000000(0000)
GS:ffff8b7ed0c40000(0000) knlGS:0000000000000000
Jun 18 12:38:27 balthasar kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jun 18 12:38:27 balthasar kernel: CR2: 00007fa7b99b5000 CR3:
00000003995b8000 CR4: 00000000003406e0
Jun 18 12:38:27 balthasar kernel: general protection fault, probably
for non-canonical address 0x17d5269120963487: 0000 [#3] SMP NOPTI
Jun 18 12:38:27 balthasar kernel: CPU: 1 PID: 223 Comm: kworker/u32:6
Tainted: G      D           5.8.0-55-generic #62~20.04.1-Ubuntu
Jun 18 12:38:27 balthasar kernel: Hardware name: Gigabyte Technology
Co., Ltd. B450M DS3H/B450M DS3H-CF, BIOS F4 01/25/2019
Jun 18 12:38:27 balthasar kernel: Workqueue: btrfs-rmw btrfs_work_helper [btrfs]
Jun 18 12:38:27 balthasar kernel: RIP: 0010:kmem_cache_alloc+0x89/0x230
Jun 18 12:38:27 balthasar kernel: Code: 08 65 4c 03 05 30 8b d5 44 49
83 78 10 00 4d 8b 20 0f 84 8e 01 00 00 4d 85 e4 0f 84 85 01 00 00 41
8b 47 20 49 8b 3f 4c 01 e0 <48> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c
89 e0 48 0f c9 48 31 cb
Jun 18 12:38:27 balthasar kernel: RSP: 0018:ffffa6eac0753c30 EFLAGS: 00010206
Jun 18 12:38:27 balthasar kernel: RAX: 17d5269120963487 RBX:
0000000000000000 RCX: ffff8b7ebd7a30c0
Jun 18 12:38:27 balthasar kernel: RDX: 0000000000006ca8 RSI:
0000000000092800 RDI: 00000000000324f0
Jun 18 12:38:27 balthasar kernel: RBP: ffffa6eac0753c60 R08:
ffff8b7ed0c724f0 R09: 0000000000000010
Jun 18 12:38:27 balthasar kernel: R10: ffff8b7e377c5400 R11:
0000000000000000 R12: 17d52691209633e7
Jun 18 12:38:27 balthasar kernel: R13: 0000000000092800 R14:
ffff8b7ecf023b80 R15: ffff8b7ecf023b80
Jun 18 12:38:27 balthasar kernel: FS:  0000000000000000(0000)
GS:ffff8b7ed0c40000(0000) knlGS:0000000000000000
Jun 18 12:38:27 balthasar kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jun 18 12:38:27 balthasar kernel: CR2: 00007fa7b99b5000 CR3:
00000003995b8000 CR4: 00000000003406e0
Jun 18 12:38:27 balthasar kernel: Call Trace:
Jun 18 12:38:27 balthasar kernel:  ? mempool_alloc_slab+0x17/0x20
Jun 18 12:38:27 balthasar kernel:  mempool_alloc_slab+0x17/0x20
Jun 18 12:38:27 balthasar kernel:  mempool_alloc+0x64/0x180
Jun 18 12:38:27 balthasar kernel:  ? get_page_from_freelist+0x1b5/0x370
Jun 18 12:38:27 balthasar kernel:  bio_alloc_bioset+0xb0/0x200
Jun 18 12:38:27 balthasar kernel:  btrfs_io_bio_alloc+0x1c/0x50 [btrfs]
Jun 18 12:38:27 balthasar kernel:  rbio_add_io_page+0x82/0x1a0 [btrfs]
Jun 18 12:38:27 balthasar kernel:  __raid56_parity_recover+0x104/0x250 [btrfs]
Jun 18 12:38:27 balthasar kernel:  read_rebuild_work+0x12/0x20 [btrfs]
Jun 18 12:38:27 balthasar kernel:  btrfs_work_helper+0xc5/0x390 [btrfs]
Jun 18 12:38:27 balthasar kernel:  ? __schedule+0x39c/0xa60
Jun 18 12:38:27 balthasar kernel:  ? flush_to_ldisc+0x53/0xf0
Jun 18 12:38:27 balthasar kernel:  process_one_work+0x1e8/0x3b0
Jun 18 12:38:27 balthasar kernel:  worker_thread+0x4d/0x3f0
Jun 18 12:38:27 balthasar kernel:  kthread+0x114/0x150
Jun 18 12:38:27 balthasar kernel:  ? process_one_work+0x3b0/0x3b0
Jun 18 12:38:27 balthasar kernel:  ? kthread_park+0x90/0x90
Jun 18 12:38:27 balthasar kernel:  ret_from_fork+0x22/0x30
Jun 18 12:38:27 balthasar kernel: Modules linked in: xt_nat
xt_MASQUERADE xt_recent xt_comment nf_tables ipt_REJECT nf_reject_ipv4
xt_addrtype iptable_nat xt_mark iptable_mangle xt_TCPMSS xt_tcpudp
xt_CT iptable_raw xt_multiport xt_conntrack nfnetlink_log xt_NFLOG
nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp nf_nat_snmp_basic
nf_conntrack_snmp nf_nat_sip nf_nat_pptp nf_nat_irc nf_nat_h323
nf_nat_ftp nf_nat_amanda ts_kmp nf_conntrack_amanda nf_nat
nf_conntrack_sane nf_conntrack_tftp nf_conntrack_sip nf_conntrack_pptp
nf_conntrack_netlink nfnetlink nf_conntrack_netbios_ns
nf_conntrack_broadcast nf_conntrack_irc nf_conntrack_h323
nf_conntrack_ftp nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
iptable_filter bpfilter cfg80211 8021q garp mrp stp llc binfmt_misc
dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua snd_hda_codec_hdmi
snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep
snd_pcm snd_seq_midi edac_mce_amd snd_seq_midi_event snd_rawmidi kvm
rapl snd_seq wmi_bmof k10temp snd_seq_device snd_timer
Jun 18 12:38:27 balthasar kernel:  cdc_ether usbnet r8152 mii snd
soundcore ccp cdc_acm mac_hid sch_fq_codel parport_pc ppdev lp parport
ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid0
multipath linear raid1 dm_raid raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c bcache crc64 ses
enclosure amdgpu iommu_v2 gpu_sched crct10dif_pclmul i2c_algo_bit
crc32_pclmul ghash_clmulni_intel ttm drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops aesni_intel crypto_simd cryptd cec
rc_core glue_helper mpt3sas raid_class drm ahci i2c_piix4 r8169
xhci_pci realtek libahci xhci_pci_renesas scsi_transport_sas wmi video
gpio_amdpt gpio_generic
Jun 18 12:38:27 balthasar kernel: ---[ end trace 40846da2a524d9a7 ]---
Jun 18 12:38:27 balthasar kernel: RIP: 0010:kmem_cache_alloc+0x89/0x230
Jun 18 12:38:27 balthasar kernel: Code: 08 65 4c 03 05 30 8b d5 44 49
83 78 10 00 4d 8b 20 0f 84 8e 01 00 00 4d 85 e4 0f 84 85 01 00 00 41
8b 47 20 49 8b 3f 4c 01 e0 <48> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c
89 e0 48 0f c9 48 31 cb
Jun 18 12:38:27 balthasar kernel: RSP: 0018:ffffa6eac051bc30 EFLAGS: 00010206
Jun 18 12:38:27 balthasar kernel: RAX: 17d5269120963487 RBX:
0000000000000000 RCX: ffff8b7ebd794e00
Jun 18 12:38:27 balthasar kernel: RDX: 0000000000006ca8 RSI:
0000000000092800 RDI: 00000000000324f0
Jun 18 12:38:27 balthasar kernel: RBP: ffffa6eac051bc60 R08:
ffff8b7ed0c724f0 R09: 0000000000000010
Jun 18 12:38:27 balthasar kernel: R10: ffff8b7e23313c00 R11:
ffff8b7e14615830 R12: 17d52691209633e7
Jun 18 12:38:27 balthasar kernel: R13: 0000000000092800 R14:
ffff8b7ecf023b80 R15: ffff8b7ecf023b80
Jun 18 12:38:27 balthasar kernel: FS:  0000000000000000(0000)
GS:ffff8b7ed0c40000(0000) knlGS:0000000000000000
Jun 18 12:38:27 balthasar kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jun 18 12:38:27 balthasar kernel: CR2: 00007fa7b99b5000 CR3:
00000003995b8000 CR4: 00000000003406e0
Jun 18 12:38:27 balthasar kernel: general protection fault, probably
for non-canonical address 0x17d5269120963487: 0000 [#4] SMP NOPTI
Jun 18 12:38:27 balthasar kernel: CPU: 1 PID: 225 Comm: kworker/u32:8
Tainted: G      D           5.8.0-55-generic #62~20.04.1-Ubuntu
Jun 18 12:38:27 balthasar kernel: Hardware name: Gigabyte Technology
Co., Ltd. B450M DS3H/B450M DS3H-CF, BIOS F4 01/25/2019
Jun 18 12:38:27 balthasar kernel: Workqueue: btrfs-rmw btrfs_work_helper [btrfs]
Jun 18 12:38:27 balthasar kernel: RIP: 0010:kmem_cache_alloc+0x89/0x230
Jun 18 12:38:27 balthasar kernel: Code: 08 65 4c 03 05 30 8b d5 44 49
83 78 10 00 4d 8b 20 0f 84 8e 01 00 00 4d 85 e4 0f 84 85 01 00 00 41
8b 47 20 49 8b 3f 4c 01 e0 <48> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c
89 e0 48 0f c9 48 31 cb
Jun 18 12:38:27 balthasar kernel: RSP: 0018:ffffa6eac0763c30 EFLAGS: 00010206
Jun 18 12:38:27 balthasar kernel: RAX: 17d5269120963487 RBX:
0000000000000000 RCX: ffff8b7ebd791a00
Jun 18 12:38:27 balthasar kernel: RDX: 0000000000006caa RSI:
0000000000092800 RDI: 00000000000324f0
Jun 18 12:38:27 balthasar kernel: RBP: ffffa6eac0763c60 R08:
ffff8b7ed0c724f0 R09: 0000000000000010
Jun 18 12:38:27 balthasar kernel: R10: ffff8b7e3eee3800 R11:
ffff8b7e14615ab0 R12: 17d52691209633e7
Jun 18 12:38:27 balthasar kernel: R13: 0000000000092800 R14:
ffff8b7ecf023b80 R15: ffff8b7ecf023b80
Jun 18 12:38:27 balthasar kernel: FS:  0000000000000000(0000)
GS:ffff8b7ed0c40000(0000) knlGS:0000000000000000
Jun 18 12:38:27 balthasar kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jun 18 12:38:27 balthasar kernel: CR2: 00007fa7b99b5000 CR3:
00000003f7cf4000 CR4: 00000000003406e0
Jun 18 12:38:27 balthasar kernel: Call Trace:
Jun 18 12:38:27 balthasar kernel:  ? mempool_alloc_slab+0x17/0x20
Jun 18 12:38:27 balthasar kernel:  mempool_alloc_slab+0x17/0x20
Jun 18 12:38:27 balthasar kernel:  mempool_alloc+0x64/0x180
Jun 18 12:38:27 balthasar kernel:  ? kmem_cache_alloc+0x178/0x230
Jun 18 12:38:27 balthasar kernel:  ? bvec_alloc+0x57/0xf0
Jun 18 12:38:27 balthasar kernel:  bio_alloc_bioset+0xb0/0x200
Jun 18 12:38:27 balthasar kernel:  btrfs_io_bio_alloc+0x1c/0x50 [btrfs]
Jun 18 12:38:27 balthasar kernel:  rbio_add_io_page+0x82/0x1a0 [btrfs]
Jun 18 12:38:27 balthasar kernel:  __raid56_parity_recover+0x104/0x250 [btrfs]
Jun 18 12:38:27 balthasar kernel:  read_rebuild_work+0x12/0x20 [btrfs]
Jun 18 12:38:27 balthasar kernel:  btrfs_work_helper+0xc5/0x390 [btrfs]
Jun 18 12:38:27 balthasar kernel:  process_one_work+0x1e8/0x3b0
Jun 18 12:38:27 balthasar kernel:  worker_thread+0x4d/0x3f0
Jun 18 12:38:27 balthasar kernel:  kthread+0x114/0x150
Jun 18 12:38:27 balthasar kernel:  ? process_one_work+0x3b0/0x3b0
Jun 18 12:38:27 balthasar kernel:  ? kthread_park+0x90/0x90
Jun 18 12:38:27 balthasar kernel:  ret_from_fork+0x22/0x30
Jun 18 12:38:27 balthasar kernel: Modules linked in: xt_nat
xt_MASQUERADE xt_recent xt_comment nf_tables ipt_REJECT nf_reject_ipv4
xt_addrtype iptable_nat xt_mark iptable_mangle xt_TCPMSS xt_tcpudp
xt_CT iptable_raw xt_multiport xt_conntrack nfnetlink_log xt_NFLOG
nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp nf_nat_snmp_basic
nf_conntrack_snmp nf_nat_sip nf_nat_pptp nf_nat_irc nf_nat_h323
nf_nat_ftp nf_nat_amanda ts_kmp nf_conntrack_amanda nf_nat
nf_conntrack_sane nf_conntrack_tftp nf_conntrack_sip nf_conntrack_pptp
nf_conntrack_netlink nfnetlink nf_conntrack_netbios_ns
nf_conntrack_broadcast nf_conntrack_irc nf_conntrack_h323
nf_conntrack_ftp nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
iptable_filter bpfilter cfg80211 8021q garp mrp stp llc binfmt_misc
dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua snd_hda_codec_hdmi
snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep
snd_pcm snd_seq_midi edac_mce_amd snd_seq_midi_event snd_rawmidi kvm
rapl snd_seq wmi_bmof k10temp snd_seq_device snd_timer
Jun 18 12:38:27 balthasar kernel:  cdc_ether usbnet r8152 mii snd
soundcore ccp cdc_acm mac_hid sch_fq_codel parport_pc ppdev lp parport
ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid0
multipath linear raid1 dm_raid raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c bcache crc64 ses
enclosure amdgpu iommu_v2 gpu_sched crct10dif_pclmul i2c_algo_bit
crc32_pclmul ghash_clmulni_intel ttm drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops aesni_intel crypto_simd cryptd cec
rc_core glue_helper mpt3sas raid_class drm ahci i2c_piix4 r8169
xhci_pci realtek libahci xhci_pci_renesas scsi_transport_sas wmi video
gpio_amdpt gpio_generic
Jun 18 12:38:27 balthasar kernel: ---[ end trace 40846da2a524d9a8 ]---
Jun 18 12:38:27 balthasar kernel: RIP: 0010:kmem_cache_alloc+0x89/0x230
Jun 18 12:38:27 balthasar kernel: Code: 08 65 4c 03 05 30 8b d5 44 49
83 78 10 00 4d 8b 20 0f 84 8e 01 00 00 4d 85 e4 0f 84 85 01 00 00 41
8b 47 20 49 8b 3f 4c 01 e0 <48> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c
89 e0 48 0f c9 48 31 cb
Jun 18 12:38:27 balthasar kernel: RSP: 0018:ffffa6eac051bc30 EFLAGS: 00010206
Jun 18 12:38:27 balthasar kernel: RAX: 17d5269120963487 RBX:
0000000000000000 RCX: ffff8b7ebd794e00
Jun 18 12:38:27 balthasar kernel: RDX: 0000000000006ca8 RSI:
0000000000092800 RDI: 00000000000324f0
Jun 18 12:38:27 balthasar kernel: RBP: ffffa6eac051bc60 R08:
ffff8b7ed0c724f0 R09: 0000000000000010
Jun 18 12:38:27 balthasar kernel: R10: ffff8b7e23313c00 R11:
ffff8b7e14615830 R12: 17d52691209633e7
Jun 18 12:38:27 balthasar kernel: R13: 0000000000092800 R14:
ffff8b7ecf023b80 R15: ffff8b7ecf023b80
Jun 18 12:38:27 balthasar kernel: FS:  0000000000000000(0000)
GS:ffff8b7ed0c40000(0000) knlGS:0000000000000000
Jun 18 12:38:27 balthasar kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jun 18 12:38:27 balthasar kernel: CR2: 00007fa7b99b5000 CR3:
00000003f7cf4000 CR4: 00000000003406e0
Jun 18 12:38:27 balthasar kernel: general protection fault, probably
for non-canonical address 0x17d5269120963487: 0000 [#5] SMP NOPTI
Jun 18 12:38:27 balthasar kernel: CPU: 1 PID: 272 Comm: kworker/u32:15
Tainted: G      D           5.8.0-55-generic #62~20.04.1-Ubuntu
Jun 18 12:38:27 balthasar kernel: Hardware name: Gigabyte Technology
Co., Ltd. B450M DS3H/B450M DS3H-CF, BIOS F4 01/25/2019
Jun 18 12:38:27 balthasar kernel: Workqueue: btrfs-rmw btrfs_work_helper [btrfs]
Jun 18 12:38:27 balthasar kernel: RIP: 0010:kmem_cache_alloc+0x89/0x230
Jun 18 12:38:27 balthasar kernel: Code: 08 65 4c 03 05 30 8b d5 44 49
83 78 10 00 4d 8b 20 0f 84 8e 01 00 00 4d 85 e4 0f 84 85 01 00 00 41
8b 47 20 49 8b 3f 4c 01 e0 <48> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c
89 e0 48 0f c9 48 31 cb
Jun 18 12:38:27 balthasar kernel: RSP: 0018:ffffa6eac04c3c30 EFLAGS: 00010206
Jun 18 12:38:27 balthasar kernel: RAX: 17d5269120963487 RBX:
0000000000000000 RCX: ffff8b7ecec15e40
Jun 18 12:38:27 balthasar kernel: RDX: 0000000000006caa RSI:
0000000000092800 RDI: 00000000000324f0
Jun 18 12:38:27 balthasar kernel: RBP: ffffa6eac04c3c60 R08:
ffff8b7ed0c724f0 R09: 0000000000000010
Jun 18 12:38:27 balthasar kernel: R10: ffff8b7e377c5800 R11:
0000000000000000 R12: 17d52691209633e7
Jun 18 12:38:27 balthasar kernel: R13: 0000000000092800 R14:
ffff8b7ecf023b80 R15: ffff8b7ecf023b80
Jun 18 12:38:27 balthasar kernel: FS:  0000000000000000(0000)
GS:ffff8b7ed0c40000(0000) knlGS:0000000000000000
Jun 18 12:38:27 balthasar kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jun 18 12:38:27 balthasar kernel: CR2: 00007fa7b99b5000 CR3:
00000003f7cf4000 CR4: 00000000003406e0
Jun 18 12:38:27 balthasar kernel: Call Trace:
Jun 18 12:38:27 balthasar kernel:  ? mempool_alloc_slab+0x17/0x20
Jun 18 12:38:27 balthasar kernel:  mempool_alloc_slab+0x17/0x20
Jun 18 12:38:27 balthasar kernel:  mempool_alloc+0x64/0x180
Jun 18 12:38:27 balthasar kernel:  ? get_page_from_freelist+0x1b5/0x370
Jun 18 12:38:27 balthasar kernel:  bio_alloc_bioset+0xb0/0x200
Jun 18 12:38:27 balthasar kernel:  btrfs_io_bio_alloc+0x1c/0x50 [btrfs]
Jun 18 12:38:27 balthasar kernel:  rbio_add_io_page+0x82/0x1a0 [btrfs]
Jun 18 12:38:27 balthasar kernel:  __raid56_parity_recover+0x104/0x250 [btrfs]
Jun 18 12:38:27 balthasar kernel:  read_rebuild_work+0x12/0x20 [btrfs]
Jun 18 12:38:27 balthasar kernel:  btrfs_work_helper+0xc5/0x390 [btrfs]
Jun 18 12:38:27 balthasar kernel:  ? __schedule+0x39c/0xa60
Jun 18 12:38:27 balthasar kernel:  process_one_work+0x1e8/0x3b0
Jun 18 12:38:27 balthasar kernel:  worker_thread+0x4d/0x3f0
Jun 18 12:38:27 balthasar kernel:  kthread+0x114/0x150
Jun 18 12:38:27 balthasar kernel:  ? process_one_work+0x3b0/0x3b0
Jun 18 12:38:27 balthasar kernel:  ? kthread_park+0x90/0x90
Jun 18 12:38:27 balthasar kernel:  ret_from_fork+0x22/0x30
Jun 18 12:38:27 balthasar kernel: Modules linked in: xt_nat
xt_MASQUERADE xt_recent xt_comment nf_tables ipt_REJECT nf_reject_ipv4
xt_addrtype iptable_nat xt_mark iptable_mangle xt_TCPMSS xt_tcpudp
xt_CT iptable_raw xt_multiport xt_conntrack nfnetlink_log xt_NFLOG
nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp nf_nat_snmp_basic
nf_conntrack_snmp nf_nat_sip nf_nat_pptp nf_nat_irc nf_nat_h323
nf_nat_ftp nf_nat_amanda ts_kmp nf_conntrack_amanda nf_nat
nf_conntrack_sane nf_conntrack_tftp nf_conntrack_sip nf_conntrack_pptp
nf_conntrack_netlink nfnetlink nf_conntrack_netbios_ns
nf_conntrack_broadcast nf_conntrack_irc nf_conntrack_h323
nf_conntrack_ftp nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
iptable_filter bpfilter cfg80211 8021q garp mrp stp llc binfmt_misc
dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua snd_hda_codec_hdmi
snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep
snd_pcm snd_seq_midi edac_mce_amd snd_seq_midi_event snd_rawmidi kvm
rapl snd_seq wmi_bmof k10temp snd_seq_device snd_timer
Jun 18 12:38:27 balthasar kernel:  cdc_ether usbnet r8152 mii snd
soundcore ccp cdc_acm mac_hid sch_fq_codel parport_pc ppdev lp parport
ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid0
multipath linear raid1 dm_raid raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c bcache crc64 ses
enclosure amdgpu iommu_v2 gpu_sched crct10dif_pclmul i2c_algo_bit
crc32_pclmul ghash_clmulni_intel ttm drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops aesni_intel crypto_simd cryptd cec
rc_core glue_helper mpt3sas raid_class drm ahci i2c_piix4 r8169
xhci_pci realtek libahci xhci_pci_renesas scsi_transport_sas wmi video
gpio_amdpt gpio_generic
Jun 18 12:38:27 balthasar kernel: ---[ end trace 40846da2a524d9a9 ]---
Jun 18 12:38:27 balthasar kernel: RIP: 0010:kmem_cache_alloc+0x89/0x230
Jun 18 12:38:27 balthasar kernel: Code: 08 65 4c 03 05 30 8b d5 44 49
83 78 10 00 4d 8b 20 0f 84 8e 01 00 00 4d 85 e4 0f 84 85 01 00 00 41
8b 47 20 49 8b 3f 4c 01 e0 <48> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c
89 e0 48 0f c9 48 31 cb
Jun 18 12:38:27 balthasar kernel: RSP: 0018:ffffa6eac051bc30 EFLAGS: 00010206
Jun 18 12:38:27 balthasar kernel: RAX: 17d5269120963487 RBX:
0000000000000000 RCX: ffff8b7ebd794e00
Jun 18 12:38:27 balthasar kernel: RDX: 0000000000006ca8 RSI:
0000000000092800 RDI: 00000000000324f0
Jun 18 12:38:27 balthasar kernel: RBP: ffffa6eac051bc60 R08:
ffff8b7ed0c724f0 R09: 0000000000000010
Jun 18 12:38:27 balthasar kernel: R10: ffff8b7e23313c00 R11:
ffff8b7e14615830 R12: 17d52691209633e7
Jun 18 12:38:27 balthasar kernel: R13: 0000000000092800 R14:
ffff8b7ecf023b80 R15: ffff8b7ecf023b80
Jun 18 12:38:27 balthasar kernel: FS:  0000000000000000(0000)
GS:ffff8b7ed0c40000(0000) knlGS:0000000000000000
Jun 18 12:38:27 balthasar kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jun 18 12:38:27 balthasar kernel: CR2: 00007fa7b99b5000 CR3:
00000003f7cf4000 CR4: 00000000003406e0
Jun 18 12:38:27 balthasar kernel: general protection fault, probably
for non-canonical address 0x17d5269120963487: 0000 [#6] SMP NOPTI
Jun 18 12:38:27 balthasar kernel: CPU: 1 PID: 222 Comm: kworker/u32:5
Tainted: G      D           5.8.0-55-generic #62~20.04.1-Ubuntu
Jun 18 12:38:27 balthasar kernel: Hardware name: Gigabyte Technology
Co., Ltd. B450M DS3H/B450M DS3H-CF, BIOS F4 01/25/2019
Jun 18 12:38:27 balthasar kernel: Workqueue: btrfs-scrub
btrfs_work_helper [btrfs]
Jun 18 12:38:27 balthasar kernel: RIP: 0010:kmem_cache_alloc+0x89/0x230
Jun 18 12:38:27 balthasar kernel: Code: 08 65 4c 03 05 30 8b d5 44 49
83 78 10 00 4d 8b 20 0f 84 8e 01 00 00 4d 85 e4 0f 84 85 01 00 00 41
8b 47 20 49 8b 3f 4c 01 e0 <48> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c
89 e0 48 0f c9 48 31 cb
Jun 18 12:38:27 balthasar kernel: RSP: 0018:ffffa6eac05f7c28 EFLAGS: 00010206
Jun 18 12:38:27 balthasar kernel: RAX: 17d5269120963487 RBX:
0000000000000000 RCX: 0000000000000000
Jun 18 12:38:27 balthasar kernel: RDX: 0000000000006caa RSI:
0000000000092800 RDI: 00000000000324f0
Jun 18 12:38:27 balthasar kernel: RBP: ffffa6eac05f7c58 R08:
ffff8b7ed0c724f0 R09: ffff8b7ecf006d80
Jun 18 12:38:27 balthasar kernel: R10: ffffffffbc669a00 R11:
0000000000000000 R12: 17d52691209633e7
Jun 18 12:38:27 balthasar kernel: R13: 0000000000092800 R14:
ffff8b7ecf023b80 R15: ffff8b7ecf023b80
Jun 18 12:38:27 balthasar kernel: FS:  0000000000000000(0000)
GS:ffff8b7ed0c40000(0000) knlGS:0000000000000000
Jun 18 12:38:27 balthasar kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jun 18 12:38:27 balthasar kernel: CR2: 00007fa7b99b5000 CR3:
00000003f7cf4000 CR4: 00000000003406e0
Jun 18 12:38:27 balthasar kernel: Call Trace:
Jun 18 12:38:27 balthasar kernel:  ? mempool_alloc_slab+0x17/0x20
Jun 18 12:38:27 balthasar kernel:  mempool_alloc_slab+0x17/0x20
Jun 18 12:38:27 balthasar kernel:  mempool_alloc+0x64/0x180
Jun 18 12:38:27 balthasar kernel:  ? __schedule+0x39c/0xa60
Jun 18 12:38:27 balthasar kernel:  bio_alloc_bioset+0xb0/0x200
Jun 18 12:38:27 balthasar kernel:  ? preempt_schedule_common+0x18/0x30
Jun 18 12:38:27 balthasar kernel:  ? _cond_resched+0x22/0x30
Jun 18 12:38:27 balthasar kernel:  btrfs_io_bio_alloc+0x1c/0x50 [btrfs]
Jun 18 12:38:27 balthasar kernel:
scrub_write_page_to_dev_replace+0x162/0x280 [btrfs]
Jun 18 12:38:27 balthasar kernel:
scrub_write_block_to_dev_replace+0x40/0x60 [btrfs]
Jun 18 12:38:27 balthasar kernel:
scrub_missing_raid56_worker+0x122/0x160 [btrfs]
Jun 18 12:38:27 balthasar kernel:  btrfs_work_helper+0xc5/0x390 [btrfs]
Jun 18 12:38:27 balthasar kernel:  process_one_work+0x1e8/0x3b0
Jun 18 12:38:27 balthasar kernel:  worker_thread+0x4d/0x3f0
Jun 18 12:38:27 balthasar kernel:  kthread+0x114/0x150
Jun 18 12:38:27 balthasar kernel:  ? process_one_work+0x3b0/0x3b0
Jun 18 12:38:27 balthasar kernel:  ? kthread_park+0x90/0x90
Jun 18 12:38:27 balthasar kernel:  ret_from_fork+0x22/0x30
Jun 18 12:38:27 balthasar kernel: Modules linked in: xt_nat
xt_MASQUERADE xt_recent xt_comment nf_tables ipt_REJECT nf_reject_ipv4
xt_addrtype iptable_nat xt_mark iptable_mangle xt_TCPMSS xt_tcpudp
xt_CT iptable_raw xt_multiport xt_conntrack nfnetlink_log xt_NFLOG
nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp nf_nat_snmp_basic
nf_conntrack_snmp nf_nat_sip nf_nat_pptp nf_nat_irc nf_nat_h323
nf_nat_ftp nf_nat_amanda ts_kmp nf_conntrack_amanda nf_nat
nf_conntrack_sane nf_conntrack_tftp nf_conntrack_sip nf_conntrack_pptp
nf_conntrack_netlink nfnetlink nf_conntrack_netbios_ns
nf_conntrack_broadcast nf_conntrack_irc nf_conntrack_h323
nf_conntrack_ftp nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
iptable_filter bpfilter cfg80211 8021q garp mrp stp llc binfmt_misc
dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua snd_hda_codec_hdmi
snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep
snd_pcm snd_seq_midi edac_mce_amd snd_seq_midi_event snd_rawmidi kvm
rapl snd_seq wmi_bmof k10temp snd_seq_device snd_timer
Jun 18 12:38:27 balthasar kernel:  cdc_ether usbnet r8152 mii snd
soundcore ccp cdc_acm mac_hid sch_fq_codel parport_pc ppdev lp parport
ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid0
multipath linear raid1 dm_raid raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c bcache crc64 ses
enclosure amdgpu iommu_v2 gpu_sched crct10dif_pclmul i2c_algo_bit
crc32_pclmul ghash_clmulni_intel ttm drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops aesni_intel crypto_simd cryptd cec
rc_core glue_helper mpt3sas raid_class drm ahci i2c_piix4 r8169
xhci_pci realtek libahci xhci_pci_renesas scsi_transport_sas wmi video
gpio_amdpt gpio_generic
Jun 18 12:38:27 balthasar kernel: ---[ end trace 40846da2a524d9aa ]---
Jun 18 12:38:27 balthasar kernel: RIP: 0010:kmem_cache_alloc+0x89/0x230
Jun 18 12:38:27 balthasar kernel: Code: 08 65 4c 03 05 30 8b d5 44 49
83 78 10 00 4d 8b 20 0f 84 8e 01 00 00 4d 85 e4 0f 84 85 01 00 00 41
8b 47 20 49 8b 3f 4c 01 e0 <48> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c
89 e0 48 0f c9 48 31 cb
Jun 18 12:38:27 balthasar kernel: RSP: 0018:ffffa6eac051bc30 EFLAGS: 00010206
Jun 18 12:38:27 balthasar kernel: RAX: 17d5269120963487 RBX:
0000000000000000 RCX: ffff8b7ebd794e00
Jun 18 12:38:27 balthasar kernel: RDX: 0000000000006ca8 RSI:
0000000000092800 RDI: 00000000000324f0
Jun 18 12:38:27 balthasar kernel: RBP: ffffa6eac051bc60 R08:
ffff8b7ed0c724f0 R09: 0000000000000010
Jun 18 12:38:27 balthasar kernel: R10: ffff8b7e23313c00 R11:
ffff8b7e14615830 R12: 17d52691209633e7
Jun 18 12:38:27 balthasar kernel: R13: 0000000000092800 R14:
ffff8b7ecf023b80 R15: ffff8b7ecf023b80
Jun 18 12:38:27 balthasar kernel: FS:  0000000000000000(0000)
GS:ffff8b7ed0c40000(0000) knlGS:0000000000000000
Jun 18 12:38:27 balthasar kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jun 18 12:38:27 balthasar kernel: CR2: 00007fa7b99b5000 CR3:
00000003f7cf4000 CR4: 00000000003406e0
Jun 18 12:38:27 balthasar kernel: general protection fault, probably
for non-canonical address 0x17d5269120963487: 0000 [#7] SMP NOPTI
Jun 18 12:38:27 balthasar kernel: CPU: 1 PID: 274 Comm: kworker/u32:17
Tainted: G      D           5.8.0-55-generic #62~20.04.1-Ubuntu
Jun 18 12:38:27 balthasar kernel: Hardware name: Gigabyte Technology
Co., Ltd. B450M DS3H/B450M DS3H-CF, BIOS F4 01/25/2019
Jun 18 12:38:27 balthasar kernel: Workqueue: btrfs-endio-raid56
btrfs_work_helper [btrfs]
Jun 18 12:38:27 balthasar kernel: RIP: 0010:kmem_cache_alloc+0x89/0x230
Jun 18 12:38:27 balthasar kernel: Code: 08 65 4c 03 05 30 8b d5 44 49
83 78 10 00 4d 8b 20 0f 84 8e 01 00 00 4d 85 e4 0f 84 85 01 00 00 41
8b 47 20 49 8b 3f 4c 01 e0 <48> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c
89 e0 48 0f c9 48 31 cb
Jun 18 12:38:27 balthasar kernel: RSP: 0018:ffffa6eac071fb80 EFLAGS: 00010206
Jun 18 12:38:27 balthasar kernel: RAX: 17d5269120963487 RBX:
0000000000000000 RCX: ffff8b7ebd7a2a40
Jun 18 12:38:27 balthasar kernel: RDX: 0000000000006caa RSI:
0000000000092800 RDI: 00000000000324f0
Jun 18 12:38:27 balthasar kernel: RBP: ffffa6eac071fbb0 R08:
ffff8b7ed0c724f0 R09: 0000000000000010
Jun 18 12:38:27 balthasar kernel: R10: ffff8b7e3d4d7000 R11:
0000000000000000 R12: 17d52691209633e7
Jun 18 12:38:27 balthasar kernel: R13: 0000000000092800 R14:
ffff8b7ecf023b80 R15: ffff8b7ecf023b80
Jun 18 12:38:27 balthasar kernel: FS:  0000000000000000(0000)
GS:ffff8b7ed0c40000(0000) knlGS:0000000000000000
Jun 18 12:38:27 balthasar kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jun 18 12:38:27 balthasar kernel: CR2: 00007fa7b99b5000 CR3:
00000003f7cf4000 CR4: 00000000003406e0
Jun 18 12:38:27 balthasar kernel: Call Trace:
Jun 18 12:38:27 balthasar kernel:  ? mempool_alloc_slab+0x17/0x20
Jun 18 12:38:27 balthasar kernel:  mempool_alloc_slab+0x17/0x20
Jun 18 12:38:27 balthasar kernel:  mempool_alloc+0x64/0x180
Jun 18 12:38:27 balthasar kernel:  bio_alloc_bioset+0xb0/0x200
Jun 18 12:38:27 balthasar kernel:  btrfs_io_bio_alloc+0x1c/0x50 [btrfs]
Jun 18 12:38:27 balthasar kernel:  rbio_add_io_page+0x82/0x1a0 [btrfs]
Jun 18 12:38:27 balthasar kernel:  finish_parity_scrub+0x2e6/0x5a0 [btrfs]
Jun 18 12:38:27 balthasar kernel:  ? kmem_cache_free+0x288/0x2b0
Jun 18 12:38:27 balthasar kernel:  ? mempool_free_slab+0x17/0x20
Jun 18 12:38:27 balthasar kernel:
validate_rbio_for_parity_scrub+0xa9/0xc0 [btrfs]
Jun 18 12:38:27 balthasar kernel:  raid56_parity_scrub_end_io+0x3f/0x50 [btrfs]
Jun 18 12:38:27 balthasar kernel:  bio_endio+0xef/0x150
Jun 18 12:38:27 balthasar kernel:  end_workqueue_fn+0x2d/0x40 [btrfs]
Jun 18 12:38:27 balthasar kernel:  btrfs_work_helper+0xc5/0x390 [btrfs]
Jun 18 12:38:27 balthasar kernel:  ? __schedule+0x39c/0xa60
Jun 18 12:38:27 balthasar kernel:  ? flush_to_ldisc+0x53/0xf0
Jun 18 12:38:27 balthasar kernel:  process_one_work+0x1e8/0x3b0
Jun 18 12:38:27 balthasar kernel:  worker_thread+0x4d/0x3f0
Jun 18 12:38:27 balthasar kernel:  kthread+0x114/0x150
Jun 18 12:38:27 balthasar kernel:  ? process_one_work+0x3b0/0x3b0
Jun 18 12:38:27 balthasar kernel:  ? kthread_park+0x90/0x90
Jun 18 12:38:27 balthasar kernel:  ret_from_fork+0x22/0x30
Jun 18 12:38:27 balthasar kernel: Modules linked in: xt_nat
xt_MASQUERADE xt_recent xt_comment nf_tables ipt_REJECT nf_reject_ipv4
xt_addrtype iptable_nat xt_mark iptable_mangle xt_TCPMSS xt_tcpudp
xt_CT iptable_raw xt_multiport xt_conntrack nfnetlink_log xt_NFLOG
nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp nf_nat_snmp_basic
nf_conntrack_snmp nf_nat_sip nf_nat_pptp nf_nat_irc nf_nat_h323
nf_nat_ftp nf_nat_amanda ts_kmp nf_conntrack_amanda nf_nat
nf_conntrack_sane nf_conntrack_tftp nf_conntrack_sip nf_conntrack_pptp
nf_conntrack_netlink nfnetlink nf_conntrack_netbios_ns
nf_conntrack_broadcast nf_conntrack_irc nf_conntrack_h323
nf_conntrack_ftp nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
iptable_filter bpfilter cfg80211 8021q garp mrp stp llc binfmt_misc
dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua snd_hda_codec_hdmi
snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep
snd_pcm snd_seq_midi edac_mce_amd snd_seq_midi_event snd_rawmidi kvm
rapl snd_seq wmi_bmof k10temp snd_seq_device snd_timer
Jun 18 12:38:27 balthasar kernel:  cdc_ether usbnet r8152 mii snd
soundcore ccp cdc_acm mac_hid sch_fq_codel parport_pc ppdev lp parport
ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid0
multipath linear raid1 dm_raid raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c bcache crc64 ses
enclosure amdgpu iommu_v2 gpu_sched crct10dif_pclmul i2c_algo_bit
crc32_pclmul ghash_clmulni_intel ttm drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops aesni_intel crypto_simd cryptd cec
rc_core glue_helper mpt3sas raid_class drm ahci i2c_piix4 r8169
xhci_pci realtek libahci xhci_pci_renesas scsi_transport_sas wmi video
gpio_amdpt gpio_generic
Jun 18 12:38:27 balthasar kernel: ---[ end trace 40846da2a524d9ab ]---
Jun 18 12:38:27 balthasar kernel: RIP: 0010:kmem_cache_alloc+0x89/0x230
Jun 18 12:38:27 balthasar kernel: Code: 08 65 4c 03 05 30 8b d5 44 49
83 78 10 00 4d 8b 20 0f 84 8e 01 00 00 4d 85 e4 0f 84 85 01 00 00 41
8b 47 20 49 8b 3f 4c 01 e0 <48> 8b 18 48 89 c1 49 33 9f 70 01 00 00 4c
89 e0 48 0f c9 48 31 cb
Jun 18 12:38:27 balthasar kernel: RSP: 0018:ffffa6eac051bc30 EFLAGS: 00010206
Jun 18 12:38:27 balthasar kernel: RAX: 17d5269120963487 RBX:
0000000000000000 RCX: ffff8b7ebd794e00
Jun 18 12:38:27 balthasar kernel: RDX: 0000000000006ca8 RSI:
0000000000092800 RDI: 00000000000324f0
Jun 18 12:38:27 balthasar kernel: RBP: ffffa6eac051bc60 R08:
ffff8b7ed0c724f0 R09: 0000000000000010
Jun 18 12:38:27 balthasar kernel: R10: ffff8b7e23313c00 R11:
ffff8b7e14615830 R12: 17d52691209633e7
Jun 18 12:38:27 balthasar kernel: R13: 0000000000092800 R14:
ffff8b7ecf023b80 R15: ffff8b7ecf023b80
Jun 18 12:38:27 balthasar kernel: FS:  0000000000000000(0000)
GS:ffff8b7ed0c40000(0000) knlGS:0000000000000000
Jun 18 12:38:27 balthasar kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jun 18 12:38:27 balthasar kernel: CR2: 00007fa7b99b5000 CR3:
00000003f7cf4000 CR4: 00000000003406e0
