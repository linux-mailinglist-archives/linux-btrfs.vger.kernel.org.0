Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA37429AAD
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 02:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhJLBBm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 21:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhJLBBl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 21:01:41 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F1FC061570
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 17:59:40 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id a7so42956206yba.6
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Oct 2021 17:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=x0YvqkG/y6+Aw31j15GkD7TDz+vfNWblRR6Cq+Hu6Go=;
        b=OOYJvruqGmqMLdJ7gnbiIXHAwOXFc0azAI8WPnvsDYWE3n054d+kjsqGPcwxxmsBzc
         BidLRuR67FlirdoE7RMcQijRVZKp4felYszA9ki+TZB9T2eyGHxt/sjdNXOh1brQ0hpe
         Z+7wz1F6kMFp22cEalc36Ld4D4BiAmK7Fay6bgPdo6IBbKb3WTvI0b4E/8nUY0x8y6av
         tSXpQahOyTEv+00pMXLpT90sHmuK5ffi5kHCBjgdgrFhCme2F/f6KJ/kRK+71mY1kwT1
         PMm2T6p7803UekJM05/3ZI61lnLHKd8dZzUcfLrMO5cvqhOSS772kFPg0YnAEKLZebXj
         ag8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=x0YvqkG/y6+Aw31j15GkD7TDz+vfNWblRR6Cq+Hu6Go=;
        b=vSYtqV5qBMFRgzppZF5pVnqS9vez9wBdNebc7HCaioiXl2AIFakutd9Sr1XZQDzSrm
         vXtP31UWaQK0AC+mU9NRK2Acag3+IAJDjuC3FL3sp88QuSkCoUHkS62MxGMBRJEP1aCU
         du07/XLCoJ6gVhY8/zUr2jzS7xtzSYneaZM4jfvw5q1SDy7pj2teFv6dJzXrQVKY7f5x
         QR9F6KVR5rpfux8Pf3CsvR5qx6+wXCJ1V8Q5u25eXzGpAUxjTWjDBXj+VuFdHmXNScWz
         n7/e0jICfSFPypG/gsVoV1Zdoy6Dvgqwk8Bx9Zsbk3aRxaPhhEEHTA3tZjusHeuYVxTP
         xNJw==
X-Gm-Message-State: AOAM531vR+E6io/DdhXjdZ+CiAC6XKefQQA/jlHnYu+WjAZSe1DxY87D
        Vq4TjwlDc4hB8ZLpuK0eO5SSe5ejM8EweV6gRB0R0pQAH7UUZjIIklk=
X-Google-Smtp-Source: ABdhPJyayy2+UGLm2wiVrGsRNxbLGVriFWR7VZoJdaMkwMY8FeF0xZ5F4F0jwgQLPe1zWkP4siLXHDQAbobUIbg/cWg=
X-Received: by 2002:a25:d3c8:: with SMTP id e191mr25106522ybf.455.1634000379712;
 Mon, 11 Oct 2021 17:59:39 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 11 Oct 2021 20:59:24 -0400
Message-ID: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
Subject: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Linux version 5.14.9-300.fc35.aarch64 Fedora-Cloud-Base-35-20211004.n.0.aarch64
[ 2164.477113] Unable to handle kernel paging request at virtual
address fffffffffffffdd0
[ 2164.483166] Mem abort info:
[ 2164.485300]   ESR = 0x96000004
[ 2164.487824]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 2164.493361]   SET = 0, FnV = 0
[ 2164.496336]   EA = 0, S1PTW = 0
[ 2164.498762]   FSC = 0x04: level 0 translation fault
[ 2164.503031] Data abort info:
[ 2164.509584]   ISV = 0, ISS = 0x00000004
[ 2164.516918]   CM = 0, WnR = 0
[ 2164.523438] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000158751000
[ 2164.533628] [fffffffffffffdd0] pgd=0000000000000000, p4d=0000000000000000
[ 2164.543741] Internal error: Oops: 96000004 [#1] SMP
[ 2164.551652] Modules linked in: virtio_gpu virtio_dma_buf
drm_kms_helper cec fb_sys_fops syscopyarea sysfillrect sysimgblt
joydev virtio_net virtio_balloon net_failover failover vfat fat drm
fuse zram ip_tables crct10dif_ce ghash_ce virtio_blk qemu_fw_cfg
virtio_mmio aes_neon_bs
[ 2164.583368] CPU: 2 PID: 8910 Comm: kworker/u8:3 Not tainted
5.14.9-300.fc35.aarch64 #1
[ 2164.593732] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[ 2164.603204] Workqueue: btrfs-delalloc btrfs_work_helper
[ 2164.611402] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
[ 2164.620165] pc : submit_compressed_extents+0x38/0x3d0
[ 2164.628056] lr : async_cow_submit+0x50/0xd0
[ 2164.635258] sp : ffff800010bfbc20
[ 2164.642585] x29: ffff800010bfbc30 x28: 0000000000000000 x27: ffffdf2b47b11000
[ 2164.652135] x26: fffffffffffffdd0 x25: dead000000000100 x24: ffff00014152d608
[ 2164.661614] x23: 0000000000000000 x22: 0000000000000000 x21: ffff0000c6106980
[ 2164.670886] x20: ffff0000c55e2000 x19: 0000000000000001 x18: ffff0000d3f00bd4
[ 2164.680050] x17: ffff00016f467ff8 x16: 0000000000000006 x15: 72a308ccefd184e0
[ 2164.689179] x14: 5378ed9c2ad24340 x13: 0000000000000020 x12: ffff0001fefa68c0
[ 2164.698178] x11: ffffdf2b47b2b500 x10: 0000000000000000 x9 : ffffdf2b462f2b70
[ 2164.707265] x8 : ffff20d6b742d000 x7 : ffff800010bfbbe0 x6 : ffffdf2b4805ad40
[ 2164.716368] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff0000c61069a0
[ 2164.725454] x2 : 0000000000000000 x1 : ffff00014152d630 x0 : ffff00014152d630
[ 2164.734445] Call trace:
[ 2164.739675]  submit_compressed_extents+0x38/0x3d0
[ 2164.746728]  async_cow_submit+0x50/0xd0
[ 2164.752980]  run_ordered_work+0xc8/0x280
[ 2164.759248]  btrfs_work_helper+0x98/0x250
[ 2164.765449]  process_one_work+0x1f0/0x4ac
[ 2164.771558]  worker_thread+0x188/0x504
[ 2164.777395]  kthread+0x110/0x114
[ 2164.782791]  ret_from_fork+0x10/0x18
[ 2164.788343] Code: a9056bf9 f8428437 f9401400 d108c2fa (f9400356)
[ 2164.795833] ---[ end trace e44350b86ce16830 ]---


Downstream bug report has been proposed as a btrfs release blocking bug.
https://bugzilla.redhat.com/show_bug.cgi?id=2011928

-- 
Chris Murphy
