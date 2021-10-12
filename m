Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451E1429D1A
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 07:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhJLF1u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 01:27:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47892 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhJLF1q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 01:27:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4107E2217E;
        Tue, 12 Oct 2021 05:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634016344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hGSblMaWAnklsPbwxFJaPouA46zpRMNbQoLlke41fpM=;
        b=tzB1wqgfxxFRQYR8oS4FYLoinzhoIAh/m2D+FzK1EoFVaVsiIyLUuGWqmEzBHqEeBabjdQ
        RrGKC0NZyfcCPPTYGOeWuL+VVvaSBGVacZhjogg1LfhDGksjuawrnRdqB/ICv1v/dWOaqu
        slmwKFWMqLhQgigIaO/RU1E5zpZbaKw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 047E813A8D;
        Tue, 12 Oct 2021 05:25:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F4aEOVccZWGGeAAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 12 Oct 2021 05:25:43 +0000
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com>
Date:   Tue, 12 Oct 2021 08:25:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.10.21 г. 3:59, Chris Murphy wrote:
> Linux version 5.14.9-300.fc35.aarch64 Fedora-Cloud-Base-35-20211004.n.0.aarch64
> [ 2164.477113] Unable to handle kernel paging request at virtual
> address fffffffffffffdd0
> [ 2164.483166] Mem abort info:
> [ 2164.485300]   ESR = 0x96000004
> [ 2164.487824]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 2164.493361]   SET = 0, FnV = 0
> [ 2164.496336]   EA = 0, S1PTW = 0
> [ 2164.498762]   FSC = 0x04: level 0 translation fault
> [ 2164.503031] Data abort info:
> [ 2164.509584]   ISV = 0, ISS = 0x00000004
> [ 2164.516918]   CM = 0, WnR = 0
> [ 2164.523438] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000158751000
> [ 2164.533628] [fffffffffffffdd0] pgd=0000000000000000, p4d=0000000000000000
> [ 2164.543741] Internal error: Oops: 96000004 [#1] SMP
> [ 2164.551652] Modules linked in: virtio_gpu virtio_dma_buf
> drm_kms_helper cec fb_sys_fops syscopyarea sysfillrect sysimgblt
> joydev virtio_net virtio_balloon net_failover failover vfat fat drm
> fuse zram ip_tables crct10dif_ce ghash_ce virtio_blk qemu_fw_cfg
> virtio_mmio aes_neon_bs
> [ 2164.583368] CPU: 2 PID: 8910 Comm: kworker/u8:3 Not tainted
> 5.14.9-300.fc35.aarch64 #1
> [ 2164.593732] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> [ 2164.603204] Workqueue: btrfs-delalloc btrfs_work_helper
> [ 2164.611402] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
> [ 2164.620165] pc : submit_compressed_extents+0x38/0x3d0

Qu isn't this the subpage bug you narrowed down a couple of days ago ?

> [ 2164.628056] lr : async_cow_submit+0x50/0xd0
> [ 2164.635258] sp : ffff800010bfbc20
> [ 2164.642585] x29: ffff800010bfbc30 x28: 0000000000000000 x27: ffffdf2b47b11000
> [ 2164.652135] x26: fffffffffffffdd0 x25: dead000000000100 x24: ffff00014152d608
> [ 2164.661614] x23: 0000000000000000 x22: 0000000000000000 x21: ffff0000c6106980
> [ 2164.670886] x20: ffff0000c55e2000 x19: 0000000000000001 x18: ffff0000d3f00bd4
> [ 2164.680050] x17: ffff00016f467ff8 x16: 0000000000000006 x15: 72a308ccefd184e0
> [ 2164.689179] x14: 5378ed9c2ad24340 x13: 0000000000000020 x12: ffff0001fefa68c0
> [ 2164.698178] x11: ffffdf2b47b2b500 x10: 0000000000000000 x9 : ffffdf2b462f2b70
> [ 2164.707265] x8 : ffff20d6b742d000 x7 : ffff800010bfbbe0 x6 : ffffdf2b4805ad40
> [ 2164.716368] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff0000c61069a0
> [ 2164.725454] x2 : 0000000000000000 x1 : ffff00014152d630 x0 : ffff00014152d630
> [ 2164.734445] Call trace:
> [ 2164.739675]  submit_compressed_extents+0x38/0x3d0
> [ 2164.746728]  async_cow_submit+0x50/0xd0
> [ 2164.752980]  run_ordered_work+0xc8/0x280
> [ 2164.759248]  btrfs_work_helper+0x98/0x250
> [ 2164.765449]  process_one_work+0x1f0/0x4ac
> [ 2164.771558]  worker_thread+0x188/0x504
> [ 2164.777395]  kthread+0x110/0x114
> [ 2164.782791]  ret_from_fork+0x10/0x18
> [ 2164.788343] Code: a9056bf9 f8428437 f9401400 d108c2fa (f9400356)
> [ 2164.795833] ---[ end trace e44350b86ce16830 ]---
> 
> 
> Downstream bug report has been proposed as a btrfs release blocking bug.
> https://bugzilla.redhat.com/show_bug.cgi?id=2011928
> 
