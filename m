Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58BF22EAE4
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 13:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgG0LJw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 07:09:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:33645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgG0LJw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 07:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595848188;
        bh=gTLvS1yoXoxreYhZ1VVEMpvxtJirRRKc8K6zo/XsNnY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IGdhb0pZrJlUBaxJjOowo3ixFeZUXO0b4fgjfjbU7JJH8yMtYxlyenUvlJdADYjeL
         AVoixPJACKoUHXYCIJtLu5e8csCYcLi96De6Ah9TJFy74ojpIy4EjJW9PBF/dPMQcT
         KYH5GwtNOY5q1xZNCP8dcHk6sB1Pt2gRGG0utzsY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MirjS-1kTYP12RXw-00euJ8; Mon, 27
 Jul 2020 13:09:48 +0200
Subject: Re: Debugging abysmal write performance with 100% cpu
 kworker/u16:X+flush-btrfs-2
To:     Hans van Kranenburg <hans@knorrie.org>, linux-btrfs@vger.kernel.org
References: <2523ce77-31a3-ecec-f36d-8d74132eae02@knorrie.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <f3cba5f0-8cc4-a521-3bba-2c02ff6c93a2@gmx.com>
Date:   Mon, 27 Jul 2020 19:09:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2523ce77-31a3-ecec-f36d-8d74132eae02@knorrie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RsNXU1ax0LMBbi4AnYki50Bjndjwh+p6WGuG2sizAzgG2RW6PQU
 +hRmqsJbS1wi4LlBpjXyQ3/UsGtCcu/bdxfbC6Wef/AkPuCauHFpXd19DWddVgeFCRujlfO
 pbtYCfmvfAZ3HFB6uvcxX5dA6Fx4ti9YBKpl46t1FF2dAjNonFZLgSv86v3rmOmMXb922k5
 xg9Ecp+JQxjnopsFEvJIg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nOfoHepskrA=:0oNhWdIsIhRJhYEdaQr9gF
 YKo/pNxZ8Sn4MMiB4M/DFDXXYllPuWkOQqLBYaAQr2vsbOD96/fX8j7x8nNegt8Z6X274C4Jv
 /k32qYLKrQoBeoZKs0dv1CLZUjB4mJy7O1oyQAjkVVkRutjvPoDWO3Vv4oN36PuDwrUU96Fw7
 ns6PCRbwDDarDVeuQz2qfd2TMQSESMq29H5hLy7mEIGC3IztaHOmkz5oK/LEu7sgvgz5t+crx
 ZUahU9ak32o2X4TIifQIeZrYEl/M4gu800v1ftTtCXr0QXwQ/9L61FqVzOuSD+hjm5p94ptEK
 NSr2yb1T2GIK9+gG1Pn6qUgJakVr8o+bUe4vfsTDSp9b5G3Ix7VF9LNFZ+gZqsNR+VbkUWZyR
 AEOjVCu2KmOBlrzIuUROYtzk5rjAfX+jkzAADxH83NdsHNnyLbYpB2bIPACacB7xe82bFTDqU
 gSKPPRjTSu36Ksy2+awFZgEJxsSTSouXp1SxfOaANKfo6cMciK7HM2rupQhi8HUq3Y0+sqcN2
 xrqPH7YOayHT28w7GWskIGdKVgKIe34CwA+d0272513qgn6CW5Tu/l94axm4nyL6gBOpocAYc
 41Cdu3TBvzxAOF+ZHJYRd0zg3qFNd7+wpK+68I825+Jye+7ZVoNqwxo/PTJ0af+Ga1vVVgv0X
 MeC0GE3LuJDz4WqmPbMIXnKt5gme7Ij55/yDjIqV2y7+6JKfmKV60QMiuoS8urb6TRmbZXFA+
 rcCun0ljhLOfoF5fZsrYt5eD33j+nPI7rfpk+Hz59dudLjXyb5GdVa8PTgBWyis37MaFE82TS
 QmCIbytm9smg6epYtGQlhzL1c7qO1UXbeFcYmd/kiYBzMZ0cSM802NLzDwAsAPBp2yptb9oDI
 XERR9WNbFwhK2D9pOuf+wQN+teYUL6cgX9Kc89awKgDgCWNbe455gWe6FMlTQdB3DOsiLBtIh
 XPm/M1yTdIG8YV8oa5Jc+/Qe7IK8upwcJl4mDLDAVdjln/MQvxnVFYmnUdsUKIgwflz2kUdxr
 ZeM0vTKn7Wx1deO96Agvew9spmF6aPpXasxG2ZeGbz5xbXVa2o+jLVHpSBTnHD7557VDd/cq9
 c8Ov2iPew+mb8PkaevPL40hxAIK4OUkt3+paK7WaLHzOWeIMoGHFVA5jWP7GU/GCVTVgCoct4
 KH+pDFZFw8uNoYMYGuJ0o8QBuCxUzsHSWsyiJ21e1mUzjksmylT2rTnGR+JzJwUulbHvX97o5
 mS3O1uzxrtU3MAclCd7UwDhWv1K3BjGMgoa0fBw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/7/25 =E4=B8=8B=E5=8D=8810:24, Hans van Kranenburg wrote:
> Hi,
>
> I have a filesystem here that I'm filling up with data from elsewhere.
> Most of it is done by rsync, and part by send/receive. So, receiving
> data over the network, and then writing the files to disk. There can be
> a dozen of these processes running in parallel.
>
> Now, when doing so, the kworker/u16:X+flush-btrfs-2 process (with
> varying X) often is using nearly 100% cpu, while enormously slowing down
> disk writes. This shows as disk IO wait for the rsync and btrfs receive
> processes.

The name is in fact pretty strange.
It doesn't follow the btrfs workqueue names.

There are two type of kernel threads used by btrfs:
- kthread
  This includes:
  * btrfs-uuid
  * btrfs-cleaner
  * btrfs-transaction
  * btrfs-devrepl
  * btrfs-ino-cache-*llu (deprecated)
  * btrfs-balance

- btrfs_workqueue (a wrapper around kernel workqueue)
  This mostly includes the following one, some of them may have another
workqueue with
  "-high" suffix:
  * btrfs-worker
  * btrfs-delalloc
  * btrfs-flush_delalloc
  * btrfs-cache
  * btrfs-fixup
  * btrfs-endio
  * btrfs-endio-meta
  * btrfs-endio-meta-write
  * btrfs-endio-raid56
  * btrfs-rmw
  * btrfs-endio-write
  * btrfs-freespace-write
  * btrfs-delayed-meta
  * btrfs-readahead
  * btrfs-qgroup-rescan
  * btrfs-scrub
  * btrfs-scrubwrc
  * btrfs-scrubparity

  (No wonder Linus is not happy with so many work queues)

As you can see, there is no one named like "flush-btrfs".

Thus I guess it's from other part of the stack.

Also, the calltrace also shows that, that kernel thread is only doing
page writeback, which calls back to the page write hooks of btrfs.

So I guess it may not be btrfs, but something else trying to do all the
writeback.

But still, the CPU usage is still a problem, it shouldn't cost so much
CPU time just writing back pages from btrfs.


>
> The underlying storage (iSCSI connected over 10Gb/s network) can easily
> eat a few hundred MiB/s. When looking at actual disk business on the
> storage device, percentages <5% utilization are reported for the actual
> disks.
>
> It's clearly kworker/u16:X+flush-btrfs-2 which is the bottleneck here.
>
> I just did a 'perf record -g -a sleep 60' while disk writes were down to
> under 1MiB (!) per second and then 'perf report'. Attached some 'screen
> shot' of it. Also attached an example of what nmon shows to give an idea
> about the situation.
>
> If the kworker/u16:X+flush-btrfs-2 cpu usage decreases, I immediately
> see network and disk write speed ramping up, easily over 200 MiB/s,
> until it soon plummets again.
>
> I see the same behavior with a recent 4.19 kernel and with 5.7.6 (which
> is booted now).
>
> So, what I'm looking for is:
> * Does anyone else see this happen when doing a lot of concurrent writes=
?
> * What does this flush thing do?
> * Why is it using 100% cpu all the time?
> * How can I debug this more?

bcc based runtime probes I guess?

Since it's almost a dead CPU burner loop, regular sleep based lockup
detector won't help much.

You can try trace events first to see which trace event get executed the
most frequently, then try to add probe points to pin down the real cause.

But personally speaking, it's better to shrink the workload, to find a
minimal workload to reproduce the 100% CPU burn, so that you need less
probes/time to pindown the problem.

> * Ultimately, of course... how can we improve this?
>
> I can recompile the kernel image to e.g. put more trace points in, in
> different places.>
> I just have no idea where to start.
>
> Thanks,
> Hans
>
> P.S. /proc/<pid>/stack for the kworker/u16:X+flush-btrfs-2 mostly shows
> nothing at all, and sometimes when it does show some output, it mostly
> looks like this:
>
> ----
> [<0>] rq_qos_wait+0xfa/0x170
> [<0>] wbt_wait+0x98/0xe0
> [<0>] __rq_qos_throttle+0x23/0x30
> [<0>] blk_mq_make_request+0x12a/0x5d0
> [<0>] generic_make_request+0xcf/0x310
> [<0>] submit_bio+0x42/0x1c0
> [<0>] btrfs_map_bio+0x1c0/0x380 [btrfs]
> [<0>] btrfs_submit_bio_hook+0x8c/0x180 [btrfs]
> [<0>] submit_one_bio+0x31/0x50 [btrfs]
> [<0>] submit_extent_page+0x102/0x210 [btrfs]
> [<0>] __extent_writepage_io+0x1cf/0x380 [btrfs]
> [<0>] __extent_writepage+0x101/0x300 [btrfs]
> [<0>] extent_write_cache_pages+0x2bb/0x440 [btrfs]
> [<0>] extent_writepages+0x44/0x90 [btrfs]
> [<0>] do_writepages+0x41/0xd0

Yeah, it's just trying to write dirty pages for btrfs.

I don't really believe it's btrfs causing the 100% CPU burn.

Maybe you could just try run btrfs on bare storage, without iSCSI, just
to verify it's btrfs to blame?

Thanks,
Qu

> [<0>] __writeback_single_inode+0x3d/0x340
> [<0>] writeback_sb_inodes+0x1e5/0x480
> [<0>] __writeback_inodes_wb+0x5d/0xb0
> [<0>] wb_writeback+0x25f/0x2f0
> [<0>] wb_workfn+0x2fe/0x3f0
> [<0>] process_one_work+0x1ad/0x370
> [<0>] worker_thread+0x30/0x390
> [<0>] kthread+0x112/0x130
> [<0>] ret_from_fork+0x1f/0x40
>
> ----
> [<0>] rq_qos_wait+0xfa/0x170
> [<0>] wbt_wait+0x98/0xe0
> [<0>] __rq_qos_throttle+0x23/0x30
> [<0>] blk_mq_make_request+0x12a/0x5d0
> [<0>] generic_make_request+0xcf/0x310
> [<0>] submit_bio+0x42/0x1c0
> [<0>] btrfs_map_bio+0x1c0/0x380 [btrfs]
> [<0>] btrfs_submit_bio_hook+0x8c/0x180 [btrfs]
> [<0>] submit_one_bio+0x31/0x50 [btrfs]
> [<0>] extent_writepages+0x5d/0x90 [btrfs]
> [<0>] do_writepages+0x41/0xd0
> [<0>] __writeback_single_inode+0x3d/0x340
> [<0>] writeback_sb_inodes+0x1e5/0x480
> [<0>] __writeback_inodes_wb+0x5d/0xb0
> [<0>] wb_writeback+0x25f/0x2f0
> [<0>] wb_workfn+0x2fe/0x3f0
> [<0>] process_one_work+0x1ad/0x370
> [<0>] worker_thread+0x30/0x390
> [<0>] kthread+0x112/0x130
> [<0>] ret_from_fork+0x1f/0x40
>
> ----
> [<0>] rq_qos_wait+0xfa/0x170
> [<0>] wbt_wait+0x98/0xe0
> [<0>] __rq_qos_throttle+0x23/0x30
> [<0>] blk_mq_make_request+0x12a/0x5d0
> [<0>] generic_make_request+0xcf/0x310
> [<0>] submit_bio+0x42/0x1c0
> [<0>] btrfs_map_bio+0x1c0/0x380 [btrfs]
> [<0>] btrfs_submit_bio_hook+0x8c/0x180 [btrfs]
> [<0>] submit_one_bio+0x31/0x50 [btrfs]
> [<0>] submit_extent_page+0x102/0x210 [btrfs]
> [<0>] __extent_writepage_io+0x1cf/0x380 [btrfs]
> [<0>] __extent_writepage+0x101/0x300 [btrfs]
> [<0>] extent_write_cache_pages+0x2bb/0x440 [btrfs]
> [<0>] extent_writepages+0x44/0x90 [btrfs]
> [<0>] do_writepages+0x41/0xd0
> [<0>] __writeback_single_inode+0x3d/0x340
> [<0>] writeback_sb_inodes+0x1e5/0x480
> [<0>] __writeback_inodes_wb+0x5d/0xb0
> [<0>] wb_writeback+0x25f/0x2f0
> [<0>] wb_workfn+0x2fe/0x3f0
> [<0>] process_one_work+0x1ad/0x370
> [<0>] worker_thread+0x30/0x390
> [<0>] kthread+0x112/0x130
> [<0>] ret_from_fork+0x1f/0x40
>
