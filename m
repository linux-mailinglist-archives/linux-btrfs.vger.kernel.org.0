Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F3F30BC02
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Feb 2021 11:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhBBKZa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Feb 2021 05:25:30 -0500
Received: from mout.gmx.net ([212.227.15.19]:37943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhBBKZ2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Feb 2021 05:25:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612261429;
        bh=yZBlXKLGoC73YCsGuTnWTbdDsS6PQtJ0ZlW229tVstc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ihA/tA3izH5wWpW49Lop+nsuA1B5f62UigyqIK4BH8WZqjfBmaSMWX8/UoP78KMDf
         QpO5y0pUcKuv/jxadtm9CeCZ2Ejv8UPytAYJVgYOBtQFFzjygOkNLpX7hgOBoivOvP
         rnkDrusrFjiVnhqZm+RCit8ydL7KIb3T+ol0SoN0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvK0R-1lxc5l1rKT-00rEfu; Tue, 02
 Feb 2021 11:23:49 +0100
Subject: Re: [bug report] Unable to handle kernel paging request
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210126083402.142577-1-wqu@suse.com>
 <5afbf08b-a93d-5633-8212-0e540625594a@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d55afd47-189f-e0a6-5577-0e89dab9e37d@gmx.com>
Date:   Tue, 2 Feb 2021 18:23:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <5afbf08b-a93d-5633-8212-0e540625594a@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TLXop6XeSXGvuFCTy0paqyiqW5H99qST3jHvp4ghqwGfmVZFUaL
 7SmfJw8ufh1+2arf/s1uTE0Hw3Mrt2mMq3UDm3iS36BGjz2UfLA3iFiRtw0JvY+vbiqSWIm
 5J8ocLRxE8mifU1X5UlbjiH224Cwaxex8X/w6Tywbcr+AHE9ZcbYfAfcmur91b+kWc8vQbF
 tEm3kOSWhnEWGZ9s4u0PQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hwq3kDnyNjo=:abO+tQM7GAA8MgPMaspFIy
 z46Yb8/OZ03Ixf5r8j5c3cyGByRAq+iOINfrRyZAI/0PJnNTkwURaCv8cA3iRqkIHPG8NouSj
 P6i+3JNzUC7glSWuBIFyxkAZJpkVzj2SVLxQ7eIVTQCAUPQwmz8K0GnT/ApqL8pP2+To12ugE
 2v8sXmXyoXqDhQPiDq5Fn3FJ56yiWuqggK/SjNRmeq2TTtln2zLhn3vyFGLaNw2r0enNRZI3r
 +B8Sm8/rmEQNsI/uFJ+DZPRkXKO0yb1D22cgayNNzrJKg+WpBIUf3ba/xtO9X6RZSnox4tx3j
 brmD6Y2KqPRKZu8Duf9kARHb9onfxPScFFlByw5WkizFEFkqCJ0uCk9/yvI0LlKCDlvP6ChjE
 6xqfp/ExvH1vcukcQFpd+RpIpLAQxd1gC7hNsxdwXhqRJFQi3cS7xtikd3HvJJizLRLTGrv32
 7BgJu5lEJAIcPOJoEulcDcgC9brMkETfBYXjdJ6/jVu/5P2sVUnbaadLk5f+TqP/hG+QaRdfD
 GxLoiTpy9RwSyq/8wsYT570MxuGST2IGlBMxvoSR4h9kmiRA4Vw/Licv1anHXgS3LbQg3lmW/
 5In4FvZz0QDdg7pBDSFB2sgKnFROb6BdvwpM1y8lW5+h8ebnOkFuMQpbH6VY8igA8tI2m8Uiy
 pTB19mMQFg6M2N0F3H+Iy7Tnsi7u3CgGZtKjJ3fy6pIbsJ17lyQTKaYcU+hnauh754VNtyoTd
 jvI76IA1bJiwZuf/7uHimHV6H54/B8dG8HYo6clxMLUbnqLD1fq5cIpBZi+WQL2B4r5HuXhLq
 FlR3vqVDh0o7pym3S3FLWlaLf45WrCcAz0811Qj8amT12+YZjMxCSThaK744KMFZlM/9UewZE
 Y2FR9be3O+Z2HvsrBDsQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/2 =E4=B8=8B=E5=8D=885:21, Anand Jain wrote:
>
> Qu,
>
>  =C2=A0fstests ran fine on an aarch64 kvm with this patch set.

Do you mean subpage patchset?

With 4K sector size?

No way it can run fine...
Long enough fsstress can crash the kernel with btrfs_csum_one_bio()
unable to locate the corresponding ordered extent.


>
>  =C2=A0Further, I was running few hand tests as below, and it fails
>  =C2=A0with - Unable to handle kernel paging.
>
>  =C2=A0Test case looks something like..
>
>  =C2=A0On x86_64 create btrfs on a file 11g
>  =C2=A0copy /usr into /test-mnt stops at enospc
>  =C2=A0set compression property on the root sunvol
>  =C2=A0run defrag with -czstd

I don't even consider compression a supported feature for subpage.

Are you really talking about the subpage patchset with 4K sector size,
on 64K page size AArch64?

If really so, I appreciate your effort on testing very much, it means
the patchset is doing way better than it is.
But I don't really believe it's even true to pass fstests....

Thanks,
Qu

>  =C2=A0truncate a large file 4gb
>  =C2=A0punch holes on it
>  =C2=A0truncate couple of smaller files
>  =C2=A0unmount
>  =C2=A0send file to an aarch64 (64k pagesize) kvm
>  =C2=A0mount -o ro
>  =C2=A0run sha256sum on all the files
>
> ---------------------
> [37012.027764] BTRFS warning (device loop0): csum failed root 5 ino 611
> off 228659200 csum 0x1dcefc2d expected csum 0x69412d2a mirror 1
> [37012.030971] BTRFS error (device loop0): bdev /dev/loop0 errs: wr 0,
> rd 0, flush 0, corrupt 9, gen 0
> [37012.036223] BTRFS warning (device loop0): csum failed root 5 ino 616
> off 228724736 csum 0x73f63661 expected csum 0xaf922a6f mirror 1
> [37012.036250] BTRFS error (device loop0): bdev /dev/loop0 errs: wr 0,
> rd 0, flush 0, corrupt 10, gen 0
> [37012.123917] Unable to handle kernel paging request at virtual address
> 0061d1f66c080000
> [37012.126104] Mem abort info:
> [37012.126951]=C2=A0=C2=A0 ESR =3D 0x96000004
> [37012.127791]=C2=A0=C2=A0 EC =3D 0x25: DABT (current EL), IL =3D 32 bit=
s
> [37012.129207]=C2=A0=C2=A0 SET =3D 0, FnV =3D 0
> [37012.130043]=C2=A0=C2=A0 EA =3D 0, S1PTW =3D 0
> [37012.131269] Data abort info:
> [37012.132165]=C2=A0=C2=A0 ISV =3D 0, ISS =3D 0x00000004
> [37012.133211]=C2=A0=C2=A0 CM =3D 0, WnR =3D 0
> [37012.134014] [0061d1f66c080000] address between user and kernel
> address ranges
> [37012.136050] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [37012.137567] Modules linked in: btrfs blake2b_generic xor xor_neon
> zstd_compress raid6_pq crct10dif_ce ip_tables x_tables ipv6
> [37012.140742] CPU: 0 PID: 289001 Comm: kworker/u64:3 Not tainted
> 5.11.0-rc5+ #10
> [37012.142839] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
> 02/06/2015
> [37012.144787] Workqueue: btrfs-endio btrfs_work_helper [btrfs]
> [37012.146474] pstate: 20000005 (nzCv daif -PAN -UAO -TCO BTYPE=3D--)
> [37012.148175] pc : __crc32c_le+0x84/0xe8
> [37012.149266] lr : chksum_digest+0x24/0x40
> [37012.150420] sp : ffff80001638f8f0
> [37012.151491] x29: ffff80001638f8f0 x28: ffff0000c7bb0000
> [37012.152982] x27: ffff0000d1a27000 x26: ffff0002f21b56e0
> [37012.154565] x25: ffff800011df3948 x24: 0000004000000000
> [37012.156063] x23: ffff000000000000 x22: ffff80001638fa00
> [37012.157570] x21: 0000000000000004 x20: ffff0000c7bb0050
> [37012.159145] x19: ffff80001638fc88 x18: 0000000000000000
> [37012.160684] x17: 0000000000000000 x16: 0000000000000000
> [37012.162190] x15: 0000051d5454c764 x14: 000000000000017a
> [37012.163774] x13: 0000000000000145 x12: 0000000000000001
> [37012.165282] x11: 0000000000000000 x10: 00000000000009d0
> [37012.166849] x9 : ffff0000ca305564 x8 : 0000000000000000
> [37012.168395] x7 : 0000000000000000 x6 : ffff800011f23980
> [37012.169883] x5 : 00000000006f6964 x4 : ffff8000105dd7a8
> [37012.171476] x3 : ffff80001638fc88 x2 : 0000000000010000
> [37012.172997] x1 : bc61d1f66c080000 x0 : 00000000ffffffff
> [37012.174642] Call trace:
> [37012.175427]=C2=A0 __crc32c_le+0x84/0xe8
> [37012.176419]=C2=A0 crypto_shash_digest+0x34/0x58
> [37012.177616]=C2=A0 check_compressed_csum+0xd0/0x2b0 [btrfs]
> [37012.179160]=C2=A0 end_compressed_bio_read+0xb8/0x308 [btrfs]
> [37012.180731]=C2=A0 bio_endio+0x12c/0x1d8
> [37012.181712]=C2=A0 end_workqueue_fn+0x3c/0x60 [btrfs]
> [37012.183161]=C2=A0 btrfs_work_helper+0xf4/0x5a8 [btrfs]
> [37012.184570]=C2=A0 process_one_work+0x1ec/0x4c0
> [37012.185727]=C2=A0 worker_thread+0x48/0x478
> [37012.186823]=C2=A0 kthread+0x158/0x160
> [37012.187768]=C2=A0 ret_from_fork+0x10/0x34
> [37012.188791] Code: 9ac55c08 9ac65d08 1a880000 b4000122 (a8c21023)
> [37012.190486] ---[ end trace 4f73e813d058b84c ]---
> [37019.180684] note: kworker/u64:3[289001] exited with preempt_count 1
> ---------------
>
>  =C2=A0Could you please take a look?
>
> Thanks, Anand
