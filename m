Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477AF439938
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 16:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhJYOwa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 10:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbhJYOwK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 10:52:10 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D75BC061225
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 07:49:15 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id m63so26600003ybf.7
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ryveRrKG3gwhcz8mUEUXJ5db2eGGhWkfhtbmXfaNKE8=;
        b=WMMNxZCSMACr6kDYz4hxY813mMjMFpCSPXj21mZf+BGmkQWAWGHTFgAgv9xHdeQssi
         RbKEP/n8Ufvgt5g33NraHScMG7OExczp1YGpOf3G4faVjxIwzqa3jH1qm44NBIwSuEUK
         eFbYHL7Rr0mfWBhDePlv+yhqlkUweryKuvD03NJC9Y1zbEsF1+PQUJt5tH0IF9GneSQX
         /GCuX9uC7Ge1lXuxsIojqgfActd2azuOiAv/AGNibzb2+owKUikqyMtLYpGU4BEIeY1U
         XBhNYSWm7omV04lQGulP/GiRUCDeNFbs0+9sdPX0+kTUJZe5mMNCXqzpdMopXpj0Asup
         oC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryveRrKG3gwhcz8mUEUXJ5db2eGGhWkfhtbmXfaNKE8=;
        b=BFHAExHF07j3GL5iASMYlaG40bmg0OjlQitUgwsNNjrk80mo4+bf80fB+h78yDw3y7
         9venYQ0t3xcMvcIh3+qrBmwrU+fOJCXAZGRk4OigG09JGiT6igVMZRi8BXvkYBx0uFGt
         Kpq5ZiLN+tdYbIFF5kD9/ya447yPnt6r+B+pGn8fUYHkENN6mq/mBNWd9iWlu7RPIfef
         qOzx4RWc+aSQZiEmEA/ETLluNeUbtWjxuuR4y5NA8bq8qBmVHnRiEF4ji7fuvAfxPgcx
         oS5eTeH1eDctTmL83gxx8jE/BTBgZWSEzqUD1ccSa32arIbytHcXgSVjlP6YyYoCXeb8
         f5lQ==
X-Gm-Message-State: AOAM533AZgMcxgrZobGFQmTZ8sR2naKfPtcoQQ2JKNO9fS3XzEQnm2eH
        KrhPG99JLLS52F3Qv7jpsvF90lYJgsUj1oQUPfkNjmdXzoA0fUuLIpk=
X-Google-Smtp-Source: ABdhPJzgmC6Uebl0DAWRM9XKEYXO3nyY7TJWWJdh6D+EsfvLyS42SWdRFVX3rroNAazn8qPyoIC5gIFVB47PZBIiqc8=
X-Received: by 2002:a25:2e52:: with SMTP id b18mr9640805ybn.391.1635173354606;
 Mon, 25 Oct 2021 07:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com> <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su> <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su> <CAJCQCtS-QhnZm2X_k77BZPDP_gybn-Ao_qPOJhXLabgPHUvKng@mail.gmail.com>
 <ff911f0c-9ea5-43b1-4b8d-e8c392f0718e@suse.com> <9e746c1c-85e5-c766-26fa-a4d83f1bfd34@suse.com>
 <CAJCQCtTHPAHMAaBg54Cs9CRKBLD9hRdA2HwOCBjsqZCwWBkyvg@mail.gmail.com> <91185758-fdaf-f8da-01eb-a9932734fc09@suse.com>
In-Reply-To: <91185758-fdaf-f8da-01eb-a9932734fc09@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 25 Oct 2021 10:48:58 -0400
Message-ID: <CAJCQCtTEm5UKR+pr3q-5xw34Tmy2suuU4p9f5H43eQkkw5AiKw@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>, Su Yue <l@damenly.su>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

https://bugzilla.redhat.com/show_bug.cgi?id=2011928

Comment 45 (attachment) is a dmesg sysrq+t during the hang with a
5.14.14 kernel with the WARN_ON added but no OOPS or call trace
occurred

Comment 46 (attachment) is a dmesg with a 5.14.10 kernel with the
WARN_ON added, with OOPS and call trace; excerpt of this pasted below


[  992.788137] ------------[ cut here ]------------
[  992.793018] WARNING: CPU: 0 PID: 1509 at fs/btrfs/inode.c:844
submit_compressed_extents+0x3d4/0x3e0
[  992.802276] Modules linked in: rfkill virtio_gpu virtio_dma_buf
drm_kms_helper joydev cec fb_sys_fops virtio_net syscopyarea
net_failover sysfillrect sysimgblt virtio_balloon failover vfat fat
drm fuse zram ip_tables crct10dif_ce ghash_ce virtio_blk qemu_fw_cfg
virtio_mmio aes_neon_bs
[  992.828320] CPU: 0 PID: 1509 Comm: kworker/u8:12 Not tainted
5.14.10-300.fc35.dusty.aarch64 #1
[  992.837159] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[  992.844076] Workqueue: btrfs-delalloc btrfs_work_helper
[  992.849339] pstate: 20400005 (nzCv daif +PAN -UAO -TCO BTYPE=--)
[  992.855262] pc : submit_compressed_extents+0x3d4/0x3e0
[  992.860357] lr : async_cow_submit+0x50/0xd0
[  992.864444] sp : ffff800012023c20
[  992.867667] x29: ffff800012023c30 x28: 0000000000000000 x27: ffffdd47ca411000
[  992.874799] x26: ffff000128f2c548 x25: dead000000000100 x24: ffff000128f2c508
[  992.881862] x23: 0000000000000000 x22: 0000000000000001 x21: ffff00018f9d5e80
[  992.888931] x20: ffff0000c0672000 x19: 0000000000000001 x18: ffff0000c4c00bd4
[  992.896105] x17: ffff00012d53aff8 x16: 0000000000000006 x15: 7a1cde357ab19b01
[  992.903348] x14: 5eac0029a606c741 x13: 0000000000000020 x12: ffff0001fefa78c0
[  992.910639] x11: ffffdd47ca42b500 x10: 0000000000000000 x9 : ffffdd47c8c01c50
[  992.917872] x8 : ffff22ba34aec000 x7 : ffff800012023be0 x6 : ffffdd47ca95ad40
[  992.925086] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff00018f9d5ea0
[  992.932221] x2 : 0000000000000000 x1 : ffff000128f2c508 x0 : ffff000128f2c508
[  992.939392] Call trace:
[  992.941854]  submit_compressed_extents+0x3d4/0x3e0
[  992.946737]  async_cow_submit+0x50/0xd0
[  992.950574]  run_ordered_work+0xc8/0x280
[  992.954560]  btrfs_work_helper+0x98/0x250
[  992.958594]  process_one_work+0x1f0/0x4ac
[  992.962619]  worker_thread+0x188/0x504
[  992.966390]  kthread+0x110/0x114
[  992.969681]  ret_from_fork+0x10/0x18
[  992.973313] ---[ end trace 11b751608cbdcfac ]---
[  992.978203] Unable to handle kernel paging request at virtual
address fffffffffffffdd0
[  992.986011] Mem abort info:
[  992.993975]   ESR = 0x96000004
[  992.996786]   EC = 0x25: DABT (current EL), IL = 32 bits
[  993.001795]   SET = 0, FnV = 0
[  993.004646]   EA = 0, S1PTW = 0
[  993.007455]   FSC = 0x04: level 0 translation fault
[  993.012081] Data abort info:
[  993.014712]   ISV = 0, ISS = 0x00000004
[  993.021058]   CM = 0, WnR = 0
[  993.026357] swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000009c051000
[  993.035411] [fffffffffffffdd0] pgd=0000000000000000, p4d=0000000000000000
[  993.044400] Internal error: Oops: 96000004 [#1] SMP
[  993.051651] Modules linked in: rfkill virtio_gpu virtio_dma_buf
drm_kms_helper joydev cec fb_sys_fops virtio_net syscopyarea
net_failover sysfillrect sysimgblt virtio_balloon failover vfat fat
drm fuse zram ip_tables crct10dif_ce ghash_ce virtio_blk qemu_fw_cfg
virtio_mmio aes_neon_bs
[  993.083344] CPU: 0 PID: 1509 Comm: kworker/u8:12 Tainted: G
W         5.14.10-300.fc35.dusty.aarch64 #1
[  993.095545] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[  993.104796] Workqueue: btrfs-delalloc btrfs_work_helper
[  993.112752] pstate: 20400005 (nzCv daif +PAN -UAO -TCO BTYPE=--)
[  993.121096] pc : submit_compressed_extents+0x44/0x3e0
[  993.128333] lr : async_cow_submit+0x50/0xd0
[  993.134773] sp : ffff800012023c20
[  993.140397] x29: ffff800012023c30 x28: 0000000000000000 x27: ffffdd47ca411000
[  993.149489] x26: fffffffffffffdd0 x25: dead000000000100 x24: ffff000128f2c508
[  993.158723] x23: 0000000000000000 x22: 0000000000000001 x21: ffff00018f9d5e80
[  993.167904] x20: fffffffffffffe18 x19: 0000000000000001 x18: ffff0000c4c00bd4
[  993.177039] x17: ffff00012d53aff8 x16: 0000000000000006 x15: 7a1cde357ab19b01
[  993.186386] x14: 5eac0029a606c741 x13: 0000000000000020 x12: ffff0001fefa78c0
[  993.195490] x11: ffffdd47ca42b500 x10: 0000000000000000 x9 : ffffdd47c8c01c50
[  993.204603] x8 : ffff22ba34aec000 x7 : ffff800012023be0 x6 : ffffdd47ca95ad40
[  993.213749] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff00018f9d5ea0
[  993.222960] x2 : 0000000000000000 x1 : ffff000128f2c530 x0 : ffff000128f2c530
[  993.232079] Call trace:
[  993.236821]  submit_compressed_extents+0x44/0x3e0
[  993.243682]  async_cow_submit+0x50/0xd0
[  993.249829]  run_ordered_work+0xc8/0x280
[  993.255974]  btrfs_work_helper+0x98/0x250
[  993.262187]  process_one_work+0x1f0/0x4ac
[  993.268381]  worker_thread+0x188/0x504
[  993.274252]  kthread+0x110/0x114
[  993.279894]  ret_from_fork+0x10/0x18
[  993.285819] Code: d108c2fa 9100a301 f9401700 d107a2f4 (f9400356)
[  993.294256] ---[ end trace 11b751608cbdcfad ]---


I don't see any new information here though.


--
Chris Murphy
