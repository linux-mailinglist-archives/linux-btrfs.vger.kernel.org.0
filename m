Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCF44357D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 02:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhJUAhL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 20:37:11 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:34644 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJUAhL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 20:37:11 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id B9BCD1E00A65;
        Thu, 21 Oct 2021 03:34:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1634776494; bh=Sz0t73SaNR/i8fQRfG4ZwwpEXSbprRjutHni93BU83c=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=H1oaC83Jsn7gqti8jCAVlnBsVNTUBMq+UFAePNG0UV41aZ8h0rllrmVNWgSUbWPJQ
         owuhq1Sb9kdTutCTaakbbVmtOQ94ga103eKVoTLAcfvr/gF3eEWQg29RtwcTPfbeCS
         DELjQV32R0LUvPZH2gbJWcu0hOFOtn9DTGlWNxds=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id AEFCA1E00A0A;
        Thu, 21 Oct 2021 03:34:54 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id jGRw5R54epfK; Thu, 21 Oct 2021 03:34:54 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 4F3FB1E00A63;
        Thu, 21 Oct 2021 03:34:54 +0300 (EEST)
Received: from nas (unknown [117.62.172.224])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 5CA761BE0146;
        Thu, 21 Oct 2021 03:34:52 +0300 (EEST)
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
 <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com>
 <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com>
 <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
 <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com>
 <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com>
 <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su>
 <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su>
 <CAJCQCtR3upV0tEgdNOThMdQRE+fGH60vcbTeKagzXsw1wx9wMQ@mail.gmail.com>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
Date:   Thu, 21 Oct 2021 08:29:23 +0800
In-reply-to: <CAJCQCtR3upV0tEgdNOThMdQRE+fGH60vcbTeKagzXsw1wx9wMQ@mail.gmail.com>
Message-ID: <y26ngqqg.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 885mlYtJBDimlF+mQWXcBwIrzV5EXevl+uWy0xxdmmeJTyPEIQgRMmO6mHAFPnHLwCM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Wed 20 Oct 2021 at 19:55, Chris Murphy 
<lists@colorremedies.com> wrote:

> On Tue, Oct 19, 2021 at 9:10 PM Su Yue <l@damenly.su> wrote:
>>
>> Dump file and vmlinu[zx] kernel file are needed.
>
> So we get a splat but kdump doesn't create a vmcore. Do we need 
> to
> issue sysrq+c at the time of the hang and splat to create it?
>
Yes, please.

BTW, I ran xfstests with 5.14.10-300.fc35.aarch64 and
5.14.12-200.fc34.aarch64 in several rounds. No panic/hang found,
so I think we can exclude the possibility of the toolchain.

--
Su

> Fedora Linux 35 (Cloud Edition)
> Kernel 5.14.10-300.fc35.aarch64 on an aarch64 (ttyAMA0)
>
> eth0: 199.204.45.141 2604:e100:1:0:f816:3eff:fe72:c876
> dusty-35 login: [  286.982605] Unable to handle kernel paging 
> request
> at virtual address fffffffffffffdd0
> [  286.988338] Mem abort info:
> [  286.990307]   ESR = 0x96000004
> [  286.992596]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  286.996316]   SET = 0, FnV = 0
> [  286.998454]   EA = 0, S1PTW = 0
> [  287.000791]   FSC = 0x04: level 0 translation fault
> [  287.004472] Data abort info:
> [  287.006540]   ISV = 0, ISS = 0x00000004
> [  287.009239]   CM = 0, WnR = 0
> [  287.011344] swapper pgtable: 4k pages, 48-bit VAs, 
> pgdp=0000000054181000
> [  287.018245] [fffffffffffffdd0] pgd=0000000000000000, 
> p4d=0000000000000000
> [  287.024209] Internal error: Oops: 96000004 [#1] SMP
> [  287.027615] Modules linked in: virtio_gpu virtio_dma_buf
> drm_kms_helper cec joydev fb_sys_fops syscopyarea virtio_net
> sysfillrect sysimgblt net_failover virtio_balloon failover vfat 
> fat
> drm fuse zram ip_tables crct10dif_ce ghash_ce virtio_blk 
> qemu_fw_cfg
> virtio_mmio aes_neon_bs
> [  287.047659] CPU: 0 PID: 3558 Comm: kworker/u8:7 Kdump: loaded 
> Not
> tainted 5.14.10-300.fc35.aarch64 #1
> [  287.055269] Hardware name: QEMU KVM Virtual Machine, BIOS 
> 0.0.0 02/06/2015
> [  287.060932] Workqueue: btrfs-delalloc btrfs_work_helper
> [  287.065353] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO 
> BTYPE=--)
> [  287.070568] pc : submit_compressed_extents+0x38/0x3d0
> [  287.074825] lr : async_cow_submit+0x50/0xd0
> [  287.078217] sp : ffff800015d4bc20
> [  287.081008] x29: ffff800015d4bc30 x28: 0000000000000000 x27: 
> ffffb8a2fa941000
> [  287.087022] x26: fffffffffffffdd0 x25: dead000000000100 x24: 
> ffff000115873608
> [  287.092822] x23: 0000000000000000 x22: 0000000000000001 x21: 
> ffff0000c6f25800
> [  287.098591] x20: ffff0000c0596000 x19: 0000000000000001 x18: 
> ffff0000c2100bd4
> [  287.104387] x17: ffff000115875ff8 x16: 0000000000000006 x15: 
> 50006a3d10a961cd
> [  287.110159] x14: f0668b836620caa1 x13: 0000000000000020 x12: 
> ffff0001fefa68c0
> [  287.116170] x11: ffffb8a2fa95b500 x10: 0000000000000000 x9 : 
> ffffb8a2f9131c40
> [  287.122120] x8 : ffff475f045bb000 x7 : ffff800015d4bbe0 x6 : 
> ffffb8a2fae8ad40
> [  287.128086] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 
> ffff0000c6f25820
> [  287.133953] x2 : 0000000000000000 x1 : ffff000115873630 x0 : 
> ffff000115873630
> [  287.139760] Call trace:
> [  287.141784]  submit_compressed_extents+0x38/0x3d0
> [  287.145620]  async_cow_submit+0x50/0xd0
> [  287.148801]  run_ordered_work+0xc8/0x280
> [  287.152005]  btrfs_work_helper+0x98/0x250
> [  287.155450]  process_one_work+0x1f0/0x4ac
> [  287.161577]  worker_thread+0x188/0x504
> [  287.167461]  kthread+0x110/0x114
> [  287.172872]  ret_from_fork+0x10/0x18
> [  287.178558] Code: a9056bf9 f8428437 f9401400 d108c2fa 
> (f9400356)
> [  287.186268] ---[ end trace 41ec405ced3786b6 ]---
