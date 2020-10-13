Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759DD28C718
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 04:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgJMCTU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 22:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbgJMCTQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 22:19:16 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E9CC0613D0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Oct 2020 19:19:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id e2so20030341wme.1
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Oct 2020 19:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=Z1dxMO/wMVBzVXJBOglgdF3AIBtT2OtUla0FRksDtRo=;
        b=QljiWVLsrOzRYNouZ/bJdFPUdTc3T/TXI8yzM7048TwLf2+EnV5y+yfkTsA9JFJnXH
         IH3kFOU8EpIu2nCYThYUmBQKAhsP+EEEKTl/gwvOwR20/1vXIrLL3GU5rC2wVQ1djB8G
         8FXG2kaezM2Vj5jkQxgCbjfTgWvSNr+9SCA4pRwtwC9KJ4Un2Xml24J1xXRxfrVS1/Xo
         4wgn/81P0gUzwxtP00UH5hQZNHpvItnJ8aBQmkuGZqtuZ5ClrqQbSbbSHgJbqyF7pxpH
         FZ+r2s5mezix2jnpAwvWY2bvOIX4b+aKZbDmrlt3YHO0HSItzKKGzHXppizmoFo29rRR
         /BoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Z1dxMO/wMVBzVXJBOglgdF3AIBtT2OtUla0FRksDtRo=;
        b=q+yxnYmTixkKPS4AOAhJ3OkC85QkAGVImcJgefIi7Vw0PNBLM9LLx4kfeBTx2NOPPK
         9V5jig0xGQBUIKSlpeQ1xqCwJIBZfg7Kj+4Wq3ltrRY3rEXRrUbuxX2IZMngER+ZT71F
         f1pDFsRsrxJvShlzCXCeD43ZdJwHd3tquuuzdp2omp+vpsXtGSI3xZOcZPM3rWcrzmk9
         9Hbjw2x9FSUdHE8gMZNQLSYkIlOKtN9I37wLyJuqaTNgBLlZI5Z84CCPOzfkG/qTkScq
         TvP96/kOdf+3YUpO/BXcYS1voYtpA3mWQQoOvQrYzOERo5l5rl6WXikehdUqLcIuDsDx
         u60w==
X-Gm-Message-State: AOAM530grEje8LOr5s+QqOCY95WOzlwJQTmpQRD/PKJc8QIxsbyOuiny
        VyGZWZQS5qz4ZkniFO62XoBK03QuH0IPxuzHL0E2pTdx+CTt4kME
X-Google-Smtp-Source: ABdhPJxXszGcexSY14glk2BfMlqQDi5f5hrBhD4QlSJ05F2qYBFX41KHywKFbstPxbFGIqLXx8jOOJIzaqai6joZr4w=
X-Received: by 2002:a1c:960a:: with SMTP id y10mr12960534wmd.128.1602555551837;
 Mon, 12 Oct 2020 19:19:11 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 12 Oct 2020 20:18:55 -0600
Message-ID: <CAJCQCtQyekZPFFzgBPXkq_SbtizpCZZJJHqZovTS55RdMRBEYw@mail.gmail.com>
Subject: Bug - WARNING: at kernel/locking/lockdep.c:853 register_lock_class+0xa2/0x680
 (edit)
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

kernel 5.9.0-0.rc8.20201009git7575fdda569b.32.fc34.x86_64

https://bugzilla.kernel.org/show_bug.cgi?id=209637

Complete dmesg is in the bug report. There seems to be no other
consequence to this warning.


[ 1419.074113] kernel: ------------[ cut here ]------------
[ 1419.074121] kernel: WARNING: CPU: 0 PID: 8685 at
kernel/locking/lockdep.c:853 register_lock_class+0xa2/0x680
[ 1419.074122] kernel: Modules linked in: libfc scsi_transport_fc
iscsi_ibft sha256_ssse3 dm_crypt vfat fat dm_round_robin dm_multipath
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx raid1 raid0 uinput nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat ip6table_nat ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set
nf_tables nfnetlink rfkill ip6table_filter ip6_tables iptable_filter
rpcrdma ib_isert iscsi_target_mod ib_iser ib_srpt target_core_mod
ib_srp scsi_transport_srp ib_ipoib rdma_ucm ib_umad iw_cxgb4 ib_uverbs
rdma_cm iw_cm ib_cm ib_core snd_hda_codec_generic ledtrig_audio
snd_hda_intel snd_intel_dspcfg intel_rapl_msr snd_hda_codec iTCO_wdt
intel_pmc_bxt iTCO_vendor_support intel_rapl_common snd_hda_core
snd_hwdep kvm_intel
[ 1419.074159] kernel:  snd_seq snd_seq_device kvm joydev snd_pcm
irqbypass qxl drm_ttm_helper rapl ttm drm_kms_helper snd_timer snd
virtio_balloon i2c_i801 soundcore lpc_ich cec i2c_smbus pcspkr drm
zram ip_tables nls_utf8 isofs squashfs crct10dif_pclmul crc32_pclmul
crc32c_intel ghash_clmulni_intel serio_raw virtio_net virtio_console
virtio_blk net_failover virtio_scsi failover qemu_fw_cfg sunrpc
be2iscsi bnx2i cnic uio cxgb4i cxgb4 cxgb3i cxgb3 mdio libcxgbi
libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp libiscsi loop
fuse scsi_transport_iscsi
[ 1419.074180] kernel: CPU: 0 PID: 8685 Comm: btrfs-cleaner Not
tainted 5.9.0-0.rc8.20201009git7575fdda569b.32.fc34.x86_64 #1
[ 1419.074181] kernel: Hardware name: QEMU Standard PC (Q35 + ICH9,
2009), BIOS 0.0.0 02/06/2015
[ 1419.074183] kernel: RIP: 0010:register_lock_class+0xa2/0x680
[ 1419.074185] kernel: Code: 8b 24 24 4d 85 e4 0f 84 07 01 00 00 49 3b
54 24 40 75 ec 49 8b 47 18 49 39 84 24 a8 00 00 00 74 0b 49 81 3f a0
f9 92 a9 74 02 <0f> 0b 45 85 f6 74 36 83 e5 01 75 31 41 83 fe 01 75 04
4d 89 67 10
[ 1419.074186] kernel: RSP: 0018:ffffc2b2821cbaf8 EFLAGS: 00010083
[ 1419.074187] kernel: RAX: ffffffffa8e15b50 RBX: 0000000000000000
RCX: 0000000000000000
[ 1419.074188] kernel: RDX: ffffffffaa907170 RSI: 0000000000000236
RDI: ffffa09781a4fd90
[ 1419.074189] kernel: RBP: 0000000000000000 R08: 0000000000000001
R09: 0000000000000000
[ 1419.074189] kernel: R10: 0000000000000001 R11: ffffa098b57d8000
R12: ffffffffaa0c62b0
[ 1419.074190] kernel: R13: 0000000000000000 R14: 0000000000000000
R15: ffffa09781a4fd90
[ 1419.074192] kernel: FS:  0000000000000000(0000)
GS:ffffa098bc800000(0000) knlGS:0000000000000000
[ 1419.074193] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1419.074193] kernel: CR2: 00007f81eb4ba100 CR3: 000000007330a005
CR4: 0000000000060ef0
[ 1419.074197] kernel: Call Trace:
[ 1419.074203] kernel:  __lock_acquire+0x56/0x2080
[ 1419.074205] kernel:  ? __lock_acquire+0x3a5/0x2080
[ 1419.074207] kernel:  lock_acquire+0xb4/0x420
[ 1419.074210] kernel:  ? btrfs_tree_lock+0x6c/0x260
[ 1419.074214] kernel:  _raw_write_lock+0x31/0x80
[ 1419.074216] kernel:  ? btrfs_tree_lock+0x6c/0x260
[ 1419.074217] kernel:  btrfs_tree_lock+0x6c/0x260
[ 1419.074219] kernel:  ? mark_extent_buffer_accessed+0x5c/0x70
[ 1419.074222] kernel:  do_walk_down+0x105/0x640
[ 1419.074225] kernel:  ? sched_clock+0x5/0x10
[ 1419.074228] kernel:  walk_down_tree+0xb6/0xe0
[ 1419.074230] kernel:  btrfs_drop_snapshot+0x1a8/0x780
[ 1419.074234] kernel:  btrfs_clean_one_deleted_snapshot+0xfb/0x110
[ 1419.074236] kernel:  cleaner_kthread+0xd4/0x140
[ 1419.074237] kernel:  ? btrfs_alloc_root+0x4f0/0x4f0
[ 1419.074240] kernel:  kthread+0x13a/0x150
[ 1419.074241] kernel:  ? kthread_create_worker_on_cpu+0x40/0x40
[ 1419.074244] kernel:  ret_from_fork+0x1f/0x30
[ 1419.074247] kernel: irq event stamp: 13220831
[ 1419.074251] kernel: hardirqs last  enabled at (13220831):
[<ffffffffa75ceaa7>] btrfs_get_alloc_profile+0x207/0x260
[ 1419.074252] kernel: hardirqs last disabled at (13220830):
[<ffffffffa75cea77>] btrfs_get_alloc_profile+0x1d7/0x260
[ 1419.074254] kernel: softirqs last  enabled at (13220486):
[<ffffffffa7e010ef>] asm_call_irq_on_stack+0xf/0x20
[ 1419.074255] kernel: softirqs last disabled at (13220477):
[<ffffffffa7e010ef>] asm_call_irq_on_stack+0xf/0x20
[ 1419.074256] kernel: ---[ end trace 6e64b3056a0e9ca4 ]---



-- 
Chris Murphy
