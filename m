Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC6243569F
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 01:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhJTX6X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 19:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJTX6X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 19:58:23 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A84C06161C
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 16:56:08 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id i84so14897435ybc.12
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 16:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jRkgK5tsxCETEOWzrxh597amCxrqtM3ug5N7M4M3mqo=;
        b=r6ZkIUcGVr0q+iI3KQger1nmyTzBkdJ2vaQ2QOkWaAwS+/pJ2VhlzOPjcatyDSOt3C
         4/5CdxWbpEC4pAqCSg6WcTZuke/HpVhcrFIr0Fw7Y/s7tUzmA+KxawfHk47nHj68Cjz0
         4mIYO61FrsMvpE04jVFS/LBD6HEzFLq6i3c7k506h/681e6BwmXvWJGGIgaFHVccTMfP
         tZGyPHxdhHKq84dwuEdnYHn7XK3LD+HUzBF6hvDrtKXJi/iaFaGZRjzqOghwqxgr6Svx
         2/IfftMdJSKIGb/nxe/vKHTsFTre4HxHFUWrBPYAHMQ1MTsF50RtQ6AKBDWnv6FshNSX
         6J9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRkgK5tsxCETEOWzrxh597amCxrqtM3ug5N7M4M3mqo=;
        b=3KKp14Pyuw/lyZG/JAgaZD6PxYbp8+uUBKzu/2BgLy/pANBSHv7IQkxcLqiSFkuEPL
         R02A+QZKss+rWvJTe3QwwYbMLIUMydtMhbLNxDKxjRShEvrj56PVx3NE59PQ3oiOdaLS
         dwMIa8zxMtXjg5m1HHr1h7M62j2zVTtd8cUgoEclaqmFnJ0r09NfTVwAVA2uAP03Nvq/
         3cCi2qSqnEkwBST4faGisd962B2X2Z7OrtHynM2JUx2sIeyhcGZYn/7duUMuCBNwydL0
         jalj5EGcfx/Cxc8USHHmzxCz9ltQOCDItYM/7rPMN9slHu+Lh4XTRtww/SvDFfcS3yp4
         PGoA==
X-Gm-Message-State: AOAM532VGVbjBbl1UFMorsJLxus64BYwJzkqG+XSu0b9aOVjSAbpzm2O
        AktpH/tB3DLjF37DnKfmiTF21J7lkpYGpbSzfei+zQ==
X-Google-Smtp-Source: ABdhPJypbHB7MsYPsB6M/+Q+Gm1dFdXRH3MND/Ysgpj0uzx9t6YHZs/3R0NuzP3pwVfXPJzjszTPAAOrfghhOEMK1Ck=
X-Received: by 2002:a25:780e:: with SMTP id t14mr2335324ybc.470.1634774167377;
 Wed, 20 Oct 2021 16:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com> <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
 <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com> <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com> <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
 <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com> <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com> <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su> <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su>
In-Reply-To: <35owijrm.fsf@damenly.su>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 20 Oct 2021 19:55:51 -0400
Message-ID: <CAJCQCtR3upV0tEgdNOThMdQRE+fGH60vcbTeKagzXsw1wx9wMQ@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Su Yue <l@damenly.su>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 9:10 PM Su Yue <l@damenly.su> wrote:
>
> Dump file and vmlinu[zx] kernel file are needed.

So we get a splat but kdump doesn't create a vmcore. Do we need to
issue sysrq+c at the time of the hang and splat to create it?

Fedora Linux 35 (Cloud Edition)
Kernel 5.14.10-300.fc35.aarch64 on an aarch64 (ttyAMA0)

eth0: 199.204.45.141 2604:e100:1:0:f816:3eff:fe72:c876
dusty-35 login: [  286.982605] Unable to handle kernel paging request
at virtual address fffffffffffffdd0
[  286.988338] Mem abort info:
[  286.990307]   ESR = 0x96000004
[  286.992596]   EC = 0x25: DABT (current EL), IL = 32 bits
[  286.996316]   SET = 0, FnV = 0
[  286.998454]   EA = 0, S1PTW = 0
[  287.000791]   FSC = 0x04: level 0 translation fault
[  287.004472] Data abort info:
[  287.006540]   ISV = 0, ISS = 0x00000004
[  287.009239]   CM = 0, WnR = 0
[  287.011344] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000054181000
[  287.018245] [fffffffffffffdd0] pgd=0000000000000000, p4d=0000000000000000
[  287.024209] Internal error: Oops: 96000004 [#1] SMP
[  287.027615] Modules linked in: virtio_gpu virtio_dma_buf
drm_kms_helper cec joydev fb_sys_fops syscopyarea virtio_net
sysfillrect sysimgblt net_failover virtio_balloon failover vfat fat
drm fuse zram ip_tables crct10dif_ce ghash_ce virtio_blk qemu_fw_cfg
virtio_mmio aes_neon_bs
[  287.047659] CPU: 0 PID: 3558 Comm: kworker/u8:7 Kdump: loaded Not
tainted 5.14.10-300.fc35.aarch64 #1
[  287.055269] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[  287.060932] Workqueue: btrfs-delalloc btrfs_work_helper
[  287.065353] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
[  287.070568] pc : submit_compressed_extents+0x38/0x3d0
[  287.074825] lr : async_cow_submit+0x50/0xd0
[  287.078217] sp : ffff800015d4bc20
[  287.081008] x29: ffff800015d4bc30 x28: 0000000000000000 x27: ffffb8a2fa941000
[  287.087022] x26: fffffffffffffdd0 x25: dead000000000100 x24: ffff000115873608
[  287.092822] x23: 0000000000000000 x22: 0000000000000001 x21: ffff0000c6f25800
[  287.098591] x20: ffff0000c0596000 x19: 0000000000000001 x18: ffff0000c2100bd4
[  287.104387] x17: ffff000115875ff8 x16: 0000000000000006 x15: 50006a3d10a961cd
[  287.110159] x14: f0668b836620caa1 x13: 0000000000000020 x12: ffff0001fefa68c0
[  287.116170] x11: ffffb8a2fa95b500 x10: 0000000000000000 x9 : ffffb8a2f9131c40
[  287.122120] x8 : ffff475f045bb000 x7 : ffff800015d4bbe0 x6 : ffffb8a2fae8ad40
[  287.128086] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff0000c6f25820
[  287.133953] x2 : 0000000000000000 x1 : ffff000115873630 x0 : ffff000115873630
[  287.139760] Call trace:
[  287.141784]  submit_compressed_extents+0x38/0x3d0
[  287.145620]  async_cow_submit+0x50/0xd0
[  287.148801]  run_ordered_work+0xc8/0x280
[  287.152005]  btrfs_work_helper+0x98/0x250
[  287.155450]  process_one_work+0x1f0/0x4ac
[  287.161577]  worker_thread+0x188/0x504
[  287.167461]  kthread+0x110/0x114
[  287.172872]  ret_from_fork+0x10/0x18
[  287.178558] Code: a9056bf9 f8428437 f9401400 d108c2fa (f9400356)
[  287.186268] ---[ end trace 41ec405ced3786b6 ]---



-- 
Chris Murphy
