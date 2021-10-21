Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12184435A85
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 07:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhJUF7I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 01:59:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36690 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUF7H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 01:59:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2DF97219C1;
        Thu, 21 Oct 2021 05:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634795811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4uqL//Hko6LdVQ6HQVISd4o8mx58UZdFeFQjWJxgucY=;
        b=e9rdBirj8HJo+JYiSiaGcfcsCe6/IK+Zmu4hZJn1MfdLNseHbnQqqXx7jqgKpjGnEWpHWQ
        6u4cXb/5APu5uMY6oxwxi3Bkz69U8hwdu5gPNyBS1LxW3FLkCS3pki63eQJ+zGIZkKkqyl
        y8/5GYdrdd3XOksO1bp6ltFa9ZuGQK0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9BE113C59;
        Thu, 21 Oct 2021 05:56:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rVaLMiIBcWEwawAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 21 Oct 2021 05:56:50 +0000
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>, Su Yue <l@damenly.su>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
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
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <8063a24b-e4ed-e619-da38-3a94570eb09d@suse.com>
Date:   Thu, 21 Oct 2021 08:56:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtR3upV0tEgdNOThMdQRE+fGH60vcbTeKagzXsw1wx9wMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21.10.21 г. 2:55, Chris Murphy wrote:
> On Tue, Oct 19, 2021 at 9:10 PM Su Yue <l@damenly.su> wrote:
>>
>> Dump file and vmlinu[zx] kernel file are needed.
> 
> So we get a splat but kdump doesn't create a vmcore. Do we need to
> issue sysrq+c at the time of the hang and splat to create it?

Alternatively you can set the following sysctl to 1;

kernel.panic_on_warn = 1


> 
> Fedora Linux 35 (Cloud Edition)
> Kernel 5.14.10-300.fc35.aarch64 on an aarch64 (ttyAMA0)
> 
> eth0: 199.204.45.141 2604:e100:1:0:f816:3eff:fe72:c876
> dusty-35 login: [  286.982605] Unable to handle kernel paging request
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
> [  287.011344] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000054181000
> [  287.018245] [fffffffffffffdd0] pgd=0000000000000000, p4d=0000000000000000
> [  287.024209] Internal error: Oops: 96000004 [#1] SMP
> [  287.027615] Modules linked in: virtio_gpu virtio_dma_buf
> drm_kms_helper cec joydev fb_sys_fops syscopyarea virtio_net
> sysfillrect sysimgblt net_failover virtio_balloon failover vfat fat
> drm fuse zram ip_tables crct10dif_ce ghash_ce virtio_blk qemu_fw_cfg
> virtio_mmio aes_neon_bs
> [  287.047659] CPU: 0 PID: 3558 Comm: kworker/u8:7 Kdump: loaded Not
> tainted 5.14.10-300.fc35.aarch64 #1
> [  287.055269] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> [  287.060932] Workqueue: btrfs-delalloc btrfs_work_helper
> [  287.065353] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
> [  287.070568] pc : submit_compressed_extents+0x38/0x3d0
> [  287.074825] lr : async_cow_submit+0x50/0xd0
> [  287.078217] sp : ffff800015d4bc20
> [  287.081008] x29: ffff800015d4bc30 x28: 0000000000000000 x27: ffffb8a2fa941000
> [  287.087022] x26: fffffffffffffdd0 x25: dead000000000100 x24: ffff000115873608
> [  287.092822] x23: 0000000000000000 x22: 0000000000000001 x21: ffff0000c6f25800
> [  287.098591] x20: ffff0000c0596000 x19: 0000000000000001 x18: ffff0000c2100bd4
> [  287.104387] x17: ffff000115875ff8 x16: 0000000000000006 x15: 50006a3d10a961cd
> [  287.110159] x14: f0668b836620caa1 x13: 0000000000000020 x12: ffff0001fefa68c0
> [  287.116170] x11: ffffb8a2fa95b500 x10: 0000000000000000 x9 : ffffb8a2f9131c40
> [  287.122120] x8 : ffff475f045bb000 x7 : ffff800015d4bbe0 x6 : ffffb8a2fae8ad40
> [  287.128086] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff0000c6f25820
> [  287.133953] x2 : 0000000000000000 x1 : ffff000115873630 x0 : ffff000115873630
> [  287.139760] Call trace:
> [  287.141784]  submit_compressed_extents+0x38/0x3d0
> [  287.145620]  async_cow_submit+0x50/0xd0
> [  287.148801]  run_ordered_work+0xc8/0x280
> [  287.152005]  btrfs_work_helper+0x98/0x250
> [  287.155450]  process_one_work+0x1f0/0x4ac
> [  287.161577]  worker_thread+0x188/0x504
> [  287.167461]  kthread+0x110/0x114
> [  287.172872]  ret_from_fork+0x10/0x18
> [  287.178558] Code: a9056bf9 f8428437 f9401400 d108c2fa (f9400356)
> [  287.186268] ---[ end trace 41ec405ced3786b6 ]---
> 
> 
> 
