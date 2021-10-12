Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8901C429DF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 08:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhJLGtc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 02:49:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:52011 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233174AbhJLGta (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 02:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634021247;
        bh=KzzFPNV/eNfgC0Uu+cypHotXTFCG0Pg+reTLGzzovsc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=T7snZMc+tIsm4krNRlRifU4fX8cdp7P6cfnGSMt3wSO3CG/+tri+mxDcO8bVsNfJb
         zdSBekRGLP9qsJTn1XVCxdDdSRW++gbaqdNZ7yD2y4dhSoQExUiSzM4AhEuTCTKOOl
         KIMwGWifb2E416+a5i7vbreHLyiOoVy7vrJWSi7s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFsUp-1mX7x31On9-00HP0d; Tue, 12
 Oct 2021 08:47:26 +0200
Message-ID: <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
Date:   Tue, 12 Oct 2021 14:47:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z/qrIGxZ8dsC72oO4sWCFuO2snf33YXPcnJUi2JjFIMAmCYtEzN
 ddBbtQXIaKQ65pf4g2BtXjy8RKWeAZNSFhwwUH4nIBs9o2bTh479IIn7FqNxXjWoBHXI06d
 P1JKuZVZ5gIQDDmqnww35gMiuZlyBBQ4Zja8qnvv1XBHPyGJRri7hIZ5dFEh/NG6w/0hzI7
 SFHGf0r0bbAEJpeZXuvGQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vnWTLa3Rf8k=:2tr3Y9TCQ9oTSWRHR8UGC3
 v/2/rnEIMl3tNJJc+i/pMOQYPsDTz12DR3M9iGK0JgXbEI56fJbGDGl61gw+KqqhdErZ14zTX
 GDTpe1NOqCv2JgpvY84w6aXPt5a4Y4Mj2279VeK9Riv/mfzV/HRfBF2jUFAjqBqQ83o/BmjdK
 0vJ1m63eDMCvCte3wnoRRfbys5kDffa511hsEozD4bE4DhJ0ILPmZwNFC7yMAlk7G4aGOANbp
 yVZh+UXU6sMBjR9d0wTFJaTYRInA6NagDDN7aMCX717lm9Bo7tJfSu7A2kD5mhHG5J5OnN+J3
 I58gQg5XcIlBlL6CaV+VP+8FSmFshPZ/IeVwR4hP/ogjLNsR67EKFzH3UH0z6iyHPROpXqW9s
 hOHSoK0efrjXBvlZLm8GiHXbVHkEaPEhBsF6wwYMIw7/sVbf9PL4ZXnJgYbJy6fqOKfdRQfL7
 6R51qlvUthtXxqkufOzOUvA5863WKIWYc3rRqNOz/BNke4LpAkO+dY98CboP5QR+8x4dL6gVv
 jP/4xJ+kFAwFsvP2F0KVUEaLycUndU6FK9q0zPD6z3jkKHxEnTPYKlkfiv513HM4W+YNoc+D+
 pFPR1qB8utkgsk2xsBJJ+p35Aki4NEfLYY7ecRP/DmF/9e9XPCOHbroZL+rIgXToi+ZxXyYtZ
 TBT9AtYCg35pQYx2OhJb/JKxRJ6P3b+mHD+uJWOXfZz3iAItg4AdIvb2WZpf3Zk7lo7nf6ajj
 Yi3TrUqZut9gU40+BX6I5wkE2eQwucs60hVelgV8muGyhB2ZIXU9qojWndv4yPEXMsMKib+VA
 NJeuzpL4lTvOmsdSkyx+CkwGwvdOqyL1oFys4rWprXokSI9Q6N3rWrYmFx3FOvALVnyN/VbGA
 lvh39R2qw6D0PUXHQZb4XPAhzGuqIeWRkWOG2ZzWyp1sbjaG+p1EA1TBpjXoPJe5kCw7LXCws
 1d6aO4AV00+1kvfVvjHk71s8HB1h7NX33nZtrOwyJJqltS91Vc5teb46qO3ljDZWU1eV7wqS/
 2wdxeM8VpXgWvXccAHjWf8oo10nlXnYDWUR5te65GUG/VMG1pV+gQ2s5SgIk2lgTnik03ga3/
 EHWINctLUmKO5c=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/12 13:25, Nikolay Borisov wrote:
>
>
> On 12.10.21 =D0=B3. 3:59, Chris Murphy wrote:
>> Linux version 5.14.9-300.fc35.aarch64 Fedora-Cloud-Base-35-20211004.n.0=
.aarch64
>> [ 2164.477113] Unable to handle kernel paging request at virtual
>> address fffffffffffffdd0
>> [ 2164.483166] Mem abort info:
>> [ 2164.485300]   ESR =3D 0x96000004
>> [ 2164.487824]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>> [ 2164.493361]   SET =3D 0, FnV =3D 0
>> [ 2164.496336]   EA =3D 0, S1PTW =3D 0
>> [ 2164.498762]   FSC =3D 0x04: level 0 translation fault
>> [ 2164.503031] Data abort info:
>> [ 2164.509584]   ISV =3D 0, ISS =3D 0x00000004
>> [ 2164.516918]   CM =3D 0, WnR =3D 0
>> [ 2164.523438] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000158=
751000
>> [ 2164.533628] [fffffffffffffdd0] pgd=3D0000000000000000, p4d=3D0000000=
000000000
>> [ 2164.543741] Internal error: Oops: 96000004 [#1] SMP
>> [ 2164.551652] Modules linked in: virtio_gpu virtio_dma_buf
>> drm_kms_helper cec fb_sys_fops syscopyarea sysfillrect sysimgblt
>> joydev virtio_net virtio_balloon net_failover failover vfat fat drm
>> fuse zram ip_tables crct10dif_ce ghash_ce virtio_blk qemu_fw_cfg
>> virtio_mmio aes_neon_bs
>> [ 2164.583368] CPU: 2 PID: 8910 Comm: kworker/u8:3 Not tainted
>> 5.14.9-300.fc35.aarch64 #1
>> [ 2164.593732] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/0=
6/2015
>> [ 2164.603204] Workqueue: btrfs-delalloc btrfs_work_helper
>> [ 2164.611402] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO BTYPE=3D--)
>> [ 2164.620165] pc : submit_compressed_extents+0x38/0x3d0
>
> Qu isn't this the subpage bug you narrowed down a couple of days ago ?

Not exactly.

The bug I pinned down is inside my refactored code of LZO code, not the
generic part, and my refactored code is not yet merged.

Chris, mind to share the code context of the stack?

A quick glance into the code shows it could be some use-after-free bug,
that btrfs_debug() is referring some member of a freed async_extent
structure.

Thanks,
Qu

>
>> [ 2164.628056] lr : async_cow_submit+0x50/0xd0
>> [ 2164.635258] sp : ffff800010bfbc20
>> [ 2164.642585] x29: ffff800010bfbc30 x28: 0000000000000000 x27: ffffdf2=
b47b11000
>> [ 2164.652135] x26: fffffffffffffdd0 x25: dead000000000100 x24: ffff000=
14152d608
>> [ 2164.661614] x23: 0000000000000000 x22: 0000000000000000 x21: ffff000=
0c6106980
>> [ 2164.670886] x20: ffff0000c55e2000 x19: 0000000000000001 x18: ffff000=
0d3f00bd4
>> [ 2164.680050] x17: ffff00016f467ff8 x16: 0000000000000006 x15: 72a308c=
cefd184e0
>> [ 2164.689179] x14: 5378ed9c2ad24340 x13: 0000000000000020 x12: ffff000=
1fefa68c0
>> [ 2164.698178] x11: ffffdf2b47b2b500 x10: 0000000000000000 x9 : ffffdf2=
b462f2b70
>> [ 2164.707265] x8 : ffff20d6b742d000 x7 : ffff800010bfbbe0 x6 : ffffdf2=
b4805ad40
>> [ 2164.716368] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff000=
0c61069a0
>> [ 2164.725454] x2 : 0000000000000000 x1 : ffff00014152d630 x0 : ffff000=
14152d630
>> [ 2164.734445] Call trace:
>> [ 2164.739675]  submit_compressed_extents+0x38/0x3d0
>> [ 2164.746728]  async_cow_submit+0x50/0xd0
>> [ 2164.752980]  run_ordered_work+0xc8/0x280
>> [ 2164.759248]  btrfs_work_helper+0x98/0x250
>> [ 2164.765449]  process_one_work+0x1f0/0x4ac
>> [ 2164.771558]  worker_thread+0x188/0x504
>> [ 2164.777395]  kthread+0x110/0x114
>> [ 2164.782791]  ret_from_fork+0x10/0x18
>> [ 2164.788343] Code: a9056bf9 f8428437 f9401400 d108c2fa (f9400356)
>> [ 2164.795833] ---[ end trace e44350b86ce16830 ]---
>>
>>
>> Downstream bug report has been proposed as a btrfs release blocking bug=
.
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D2011928
>>
