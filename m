Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0A251DEC
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 00:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfFXWHe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 18:07:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51880 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfFXWHd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 18:07:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so804020wma.1
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2019 15:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=higSg0+BY2PbsS9eUpv23K3jEfIsvkSC4wMSPvFBpqY=;
        b=DqX02lx0nIhk46R6/QXZw8hYrLSu6wY/+EzVwicWv80HOW43a2A/jyLC/U9Fgy4xp+
         GtFaQCbnBGIwLhuJYVz/liwdw+M26mABGZT5AoB1Y/PiGFtSe6q9YRNa+Rxtkqw2H4o3
         RPASD8kpQUTywyJNs6fkuNLW9AW+S+EmluUhejJu9k7G3UaB6OYY/Q3tQ4hna5S1SPNr
         /wzxej/4PIanm2L80RNkmWEoL3aEckw4htRU6d4wdHN/o8gzzmHPAuRVW0gc/NegtBKK
         UzjkSDZ3UWSpiph4aNpEBq8mkdwNeIOPDfkE6ba3vHjaS3itebUao2/jGEaGTBlPhj/2
         Kiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=higSg0+BY2PbsS9eUpv23K3jEfIsvkSC4wMSPvFBpqY=;
        b=t0xWAlyBYFDuEXdVckAO6X2OQn8j+OAU6BvnKGA9XIExgtDIeNtFN///kYGvsm+GBa
         7PZvFApLnhGIBHUN6TU6GzkHqnlwYczIMqlPayyw6Sz8vfzvpxC1uwLjUhNcxqRi2gH5
         I5xZoh2BZMqEtf+IBJNY+TG5UdgA0MDSj/50U5P9g/sk3u+n9ng4bqKuaD0GR4Zde8dK
         9xJOKZYO2nnxdY24h3iQce1kXNZ4N1hWYfqY0Gg3JBxxOSTS+wbspYlqznHco5wC4V/X
         i9sShGEwHwoTuHNwtneDUYCGB+mJSYCHVZMx/OvwMDkoW5gGIwFwv0B+qgVqgVzPLXxU
         JIGw==
X-Gm-Message-State: APjAAAXArBHqpHEVN8haoT0DiMOpDe4ChR35h2hvyFkEc9jgwqmGGTOc
        Ldc/uQEQm68Ei6CgsWs0WHW+PChzTfGJ4gi1V2wOxLYCg6ZAig==
X-Google-Smtp-Source: APXvYqwnkvIs0ZVNI4H25eq4YBD2io50jSN5LTxQoKws2hxezshx9cNPHJXE7uAOhXtXiCNQ5cCUOkIgjCY/eG5o4Z4=
X-Received: by 2002:a1c:2c41:: with SMTP id s62mr17349295wms.8.1561414050669;
 Mon, 24 Jun 2019 15:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRNn9WFQc2VHc8uHg-Uoe7iKq0zOu6qA1OjBBP_O4385A@mail.gmail.com>
In-Reply-To: <CAJCQCtRNn9WFQc2VHc8uHg-Uoe7iKq0zOu6qA1OjBBP_O4385A@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 24 Jun 2019 16:07:19 -0600
Message-ID: <CAJCQCtR3azJyM40P0AyHSAp=uWxchN+R=LR5BxCuzdxQ5_JcbA@mail.gmail.com>
Subject: Re: 5.2rc5 corruption, many "is compressed but inode flag doesn't allow"
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is with kernel 5.0.7, still ro mounted with blockdev --setro as well

[root@localhost-live ~]# btrfs scrub start -BrR /mnt
scrub done for 72df6d5b-26d1-47ff-a9ab-33f6a0b2c4cf
    scrub started at Mon Jun 24 17:59:57 2019 and finished after 00:00:15
    data_extents_scrubbed: 231002
    tree_extents_scrubbed: 3657
    data_bytes_scrubbed: 7518072832
    tree_bytes_scrubbed: 239665152
    read_errors: 0
    csum_errors: 0
    verify_errors: 0
    no_csum: 25134
    csum_discards: 0
    super_errors: 0
    malloc_errors: 0
    uncorrectable_errors: 0
    unverified_errors: 0
    corrected_errors: 0
    last_physical: 93437558784
[root@localhost-live ~]#

I'm not sure what's no_csum on this file system, are those in bytes?
The only file I can think of that's nocow is a qcow2 I made with
nocow=true (chattr +C) option.
-rw-r--r--. 1 root root 194K Jun 16 20:48 untitled.qcow2

At the same time as this scrub, the kernel complained:

[ 5255.219838] BTRFS info (device sda6): using free space tree
[ 5255.219903] BTRFS info (device sda6): has skinny extents
[ 5255.236065] BTRFS info (device sda6): enabling ssd optimizations
[ 5396.839752] BTRFS warning (device sda6): Skipping commit of aborted
transaction.
[ 5396.839853] ------------[ cut here ]------------
[ 5396.839910] BTRFS: Transaction aborted (error -28)
[ 5396.840081] WARNING: CPU: 0 PID: 4583 at
fs/btrfs/transaction.c:1831 cleanup_transaction+0x5d/0xa0 [btrfs]
[ 5396.840190] Modules linked in: devlink rfcomm fuse
nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT ip6t_rpfilter
ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_nat ip6table_nat
nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat
nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink
ebtable_filter ebtables ip6table_filter ip6_tables bnep rpcrdma
ib_isert iscsi_target_mod ib_iser ib_srpt target_core_mod ib_srp
scsi_transport_srp ib_ipoib rdma_ucm ib_uverbs ib_umad iw_cxgb4
rdma_cm iw_cm ib_cm iw_cxgb3 ib_core snd_hda_codec_cirrus
snd_hda_codec_generic ledtrig_audio b43 cordic uvcvideo mac80211
videobuf2_vmalloc i915 btusb videobuf2_memops videobuf2_v4l2 btrtl
videobuf2_common btbcm btintel intel_rapl videodev bluetooth
snd_hda_codec_hdmi kvmgt cfg80211 x86_pkg_temp_thermal snd_hda_intel
intel_powerclamp media vfio_mdev snd_hda_codec mdev coretemp
vfio_iommu_type1 kvm_intel snd_hda_core ecdh_generic
[ 5396.840256]  ssb vfio bcm5974 snd_hwdep kvm rfkill snd_seq joydev
snd_seq_device ttm snd_pcm i2c_algo_bit irqbypass drm_kms_helper
intel_cstate snd_timer drm bcma snd intel_uncore iTCO_wdt mei_me
acpi_als iTCO_vendor_support soundcore mei intel_rapl_perf kfifo_buf
applesmc apple_gmux lpc_ich industrialio i2c_i801 input_polldev
pcc_cpufreq sbs sbshc apple_bl nls_utf8 isofs squashfs dm_multipath
btrfs xor zstd_compress raid6_pq crct10dif_pclmul 8021q libcrc32c
crc32_pclmul garp crc32c_intel zstd_decompress sdhci_pci mrp stp llc
cqhci sdhci ghash_clmulni_intel firewire_ohci tg3 mmc_core thunderbolt
firewire_core crc_itu_t video uas usb_storage hid_apple hid_appleir
sunrpc be2iscsi bnx2i cnic uio cxgb4i cxgb4 cxgb3i cxgb3 mdio libcxgbi
libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp libiscsi
scsi_transport_iscsi loop
[ 5396.841981] CPU: 0 PID: 4583 Comm: btrfs-transacti Not tainted
5.0.7-300.fc30.x86_64 #1
[ 5396.842069] Hardware name: Apple Inc.
MacBookPro8,2/Mac-94245A3940C91C80, BIOS
MBP81.88Z.0050.B00.1804101331 04/10/18
[ 5396.842241] RIP: 0010:cleanup_transaction+0x5d/0xa0 [btrfs]
[ 5396.842308] Code: 83 f8 01 77 63 f0 49 0f ba ad 38 23 00 00 02 72
1b 41 83 fc fb 0f 84 97 8d 08 00 44 89 e6 48 c7 c7 58 72 5c c0 e8 d2
37 bb f7 <0f> 0b 44 89 e1 ba 27 07 00 00 4d 8d 66 28 48 89 ef 48 c7 c6
90 ae
[ 5396.842507] RSP: 0018:ffffb81a81c8fde8 EFLAGS: 00010282
[ 5396.842569] RAX: 0000000000000000 RBX: ffff8d2be70ecc20 RCX: ffff8d2c678168c0
[ 5396.842649] RDX: 0000000000000007 RSI: 0000000000000006 RDI: ffff8d2c678168c0
[ 5396.842729] RBP: ffff8d2be70ecbc8 R08: 0000000000000001 R09: 00000000000004a6
[ 5396.842812] R10: 000000000001a804 R11: 0000000000000007 R12: 00000000ffffffe4
[ 5396.842891] R13: ffff8d2b97488000 R14: ffff8d2c56db7200 R15: ffff8d2be70ecb00
[ 5396.842972] FS:  0000000000000000(0000) GS:ffff8d2c67800000(0000)
knlGS:0000000000000000
[ 5396.848211] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5396.853447] CR2: 00007fea0109510c CR3: 00000001bb20e001 CR4: 00000000000606f0
[ 5396.858717] Call Trace:
[ 5396.864015]  btrfs_commit_transaction+0x83f/0x930 [btrfs]
[ 5396.869353]  ? start_transaction+0x9b/0x470 [btrfs]
[ 5396.874657]  ? __next_timer_interrupt+0x70/0xd0
[ 5396.879998]  transaction_kthread+0x144/0x180 [btrfs]
[ 5396.885310]  kthread+0xfb/0x130
[ 5396.890599]  ? btrfs_cleanup_transaction+0x540/0x540 [btrfs]
[ 5396.895841]  ? kthread_park+0x90/0x90
[ 5396.901059]  ret_from_fork+0x35/0x40
[ 5396.906268] ---[ end trace c42b154d80664636 ]---
[ 5396.911560] BTRFS warning (device sda6): cleanup_transaction:1831:
Aborting unused transaction(No space left).
[ 5396.913679] BTRFS info (device sda6): delayed_refs has NO entry
[root@localhost-live ~]#


I don't know. There's no log tree and no transactions have happened,
so I don't know what transaction it wants to clean up.


Chris Murphy
