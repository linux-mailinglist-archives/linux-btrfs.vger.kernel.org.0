Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339644EFD43
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Apr 2022 01:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbiDAXwM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 19:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiDAXwL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 19:52:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8622233A1B
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 16:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EEA461BB5
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 23:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D27FC2BBE4
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 23:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648857018;
        bh=xEbPz0nri1Drxoqe/OKsfJuworyNlLC+EcmByf/oUzA=;
        h=From:Date:Subject:To:Cc:From;
        b=IFoDACijx2OktryRV+TBd9a5u1gw2GBRIELrlabyW8jR+renwfNd3MS7JWqyDFd2p
         nJ1sMAC5eIm8/ZNwsvQj/5kTS3r9CQ2EeHiYzd4wCkOh2TAyAEz0Ms4IMX5zIxD5lh
         SJSGJ0ZmkoDBG3NKcc6Wfe0rXF9FbTT2TTh6xsXt8Rs8w5Qm3EErtsGrC59dkESpt5
         WvRHfMbDTBhtV28UcBofhRHQuoHTcRLRtnFS4rYwEotvJBENzq0Xh18KYIlAs0oKKH
         +te4qB5b6to0EKCG56s+KxEQa3XYc1veBPvSv+GRxWrA8A9+/TUZWG++WyM95GmTO8
         bzOpwW6QK8Enw==
Received: by mail-qt1-f178.google.com with SMTP id a11so3430273qtb.12
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 16:50:18 -0700 (PDT)
X-Gm-Message-State: AOAM530ZoPGNDscTKh3263o8q5RtbSvj1iJ+JvZ1ShbtOM1OUi9lx7m7
        QAB20+CpC7R/ckqjx/iQqkZcSkXs1DbI9IkXNR4=
X-Google-Smtp-Source: ABdhPJz7sJ3a9bvKVoYCkdiSFSA6WlaK1SOPuJZ+Etov0+kctnHQzQrjnqz2ODW5lzs/5xF7vrlsHUCbRpsZMA/jVJM=
X-Received: by 2002:a05:622a:60a:b0:2e2:7b2:ba74 with SMTP id
 z10-20020a05622a060a00b002e207b2ba74mr10554043qta.293.1648857016486; Fri, 01
 Apr 2022 16:50:16 -0700 (PDT)
MIME-Version: 1.0
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri, 1 Apr 2022 16:50:05 -0700
X-Gmail-Original-Message-ID: <CAB=NE6VyZYEmQbTcP=hsBdwM7ptMj0XUjQTfoO03Ghp0tnF6eg@mail.gmail.com>
Message-ID: <CAB=NE6VyZYEmQbTcP=hsBdwM7ptMj0XUjQTfoO03Ghp0tnF6eg@mail.gmail.com>
Subject: btrfs/011 crashing on v5.17-rc7 with null pointer dereference on raid6_avx5121_gen_syndrome+0x99
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     Pankaj Raghav <pankydev8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm sure you all know, but figured I'd check just in case it is not
the case. I don't see this mentioned in the mailing lists. btfs/011
crashes with an fstests configuration on kdevops btrfs_raid56:

[default]
TEST_DIR=/media/test
SCRATCH_MNT=/media/scratch
RESULT_BASE=$PWD/results/$HOST/$(uname -r)
FSTYP=btrfs

[btrfs_raid56]
TEST_DEV=/dev/loop16
SCRATCH_DEV_POOL="/dev/loop5 /dev/loop6 /dev/loop7 /dev/loop8
/dev/loop9 /dev/loop10 /dev/loop11 /dev/loop12"
MKFS_OPTIONS='-f'

The crash is:

[16570.301631] BTRFS info (device loop5): checking UUID tree
[16575.562319] BUG: kernel NULL pointer dereference, address: 0000000000000000
[16575.565764] #PF: supervisor read access in kernel mode
[16575.568645] #PF: error_code(0x0000) - not-present page
[16575.571473] PGD 0 P4D 0
[16575.573387] Oops: 0000 [#1] PREEMPT SMP NOPTI
[16575.575930] CPU: 7 PID: 52803 Comm: kworker/u16:17 Kdump: loaded
Tainted: G            E     5.17.0-rc7 #1
[16575.580412] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.15.0-1 04/01/2014
[16575.584607] Workqueue: btrfs-endio-raid56 btrfs_work_helper [btrfs]
[16575.588237] RIP: 0010:raid6_avx5121_gen_syndrome+0x99/0x150 [raid6_pq]
[16575.591603] Code: 48 8d 74 03 f8 4c 8d 0c 03 44 89 c0 48 c1 e0 03
48 29 c6 41 0f 18 04 0b 62 d1 fd 48 6f 14 0b 41 0f 18 04 0a 62 f1 fd
48 6f e2 <62> d1 fd 48 6f 34 0a 45 85 c0 78 44 4c 89 c8 48 8b 10 0f 18
04 0a
[16575.599228] RSP: 0018:ffffa33bc4ddfd50 EFLAGS: 00010282
[16575.601501] RAX: 00000007fffffff0 RBX: ffff9295d04bd410 RCX: 0000000000000000
[16575.604259] RDX: 0000000000000000 RSI: ffff928dd04bd408 RDI: 0000000000000000
[16575.606796] RBP: 0000000000000003 R08: 00000000fffffffe R09: ffff9295d04bd400
[16575.609268] R10: 0000000000000000 R11: ffff92964e220000 R12: 0000000000001000
[16575.611660] R13: ffff9295e4213000 R14: ffff9295c8c2e000 R15: 0000000000000000
[16575.613919] FS:  0000000000000000(0000) GS:ffff9296f7dc0000(0000)
knlGS:0000000000000000
[16575.616336] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16575.618048] CR2: 0000000000000000 CR3: 0000000203e0a006 CR4: 0000000000770ee0
[16575.620085] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[16575.621993] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[16575.623915] PKRU: 55555554
[16575.624925] Call Trace:
[16575.625899]  <TASK>
[16575.626790]  finish_rmw+0x27d/0x5d0 [btrfs]
[16575.628158]  end_workqueue_fn+0x29/0x40 [btrfs]
[16575.629470]  btrfs_work_helper+0xe1/0x360 [btrfs]
[16575.630832]  process_one_work+0x1e2/0x3b0
[16575.632063]  worker_thread+0x50/0x3a0
[16575.633097]  ? rescuer_thread+0x390/0x390
[16575.634183]  kthread+0xe5/0x110
[16575.635139]  ? kthread_complete_and_exit+0x20/0x20
[16575.636366]  ret_from_fork+0x1f/0x30
[16575.637362]  </TASK>
[16575.638128] Modules linked in: loop(E) nvme_fabrics(E) kvm_intel(E)
kvm(E) irqbypass(E) crct10dif_pclmul(E) ghash_clmulni_intel(E)
aesni_intel(E) crypto_simd(E) cryptd(E) cirrus(E) joydev(E)
drm_shmem_helper(E) drm_kms_helper(E) evdev(E) serio_raw(E)
virtio_balloon(E) cec(E) i6300esb(E) button(E) drm(E) configfs(E)
ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc16(E) mbcache(E)
jbd2(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E)
zstd_compress(E) libcrc32c(E) crc32c_generic(E) virtio_net(E)
net_failover(E) virtio_blk(E) failover(E) ata_generic(E) ata_piix(E)
uhci_hcd(E) libata(E) ehci_hcd(E) crc32_pclmul(E) crc32c_intel(E)
psmouse(E) usbcore(E) scsi_mod(E) nvme(E) nvme_core(E) virtio_pci(E)
virtio_pci_legacy_dev(E) virtio_pci_modern_dev(E) virtio(E)
virtio_ring(E) usb_common(E) t10_pi(E) i2c_piix4(E) scsi_common(E)
[16575.651503] CR2: 0000000000000000

For more details:

https://github.com/mcgrof/kdevops/commit/e95050955cd6d4c13b0accd19f1825dad9539394

  Luis
