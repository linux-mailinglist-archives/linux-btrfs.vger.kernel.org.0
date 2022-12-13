Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3BE64AE04
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 03:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiLMC7u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 21:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiLMC7t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 21:59:49 -0500
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C3819000
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 18:59:47 -0800 (PST)
Subject: Re: [PATCH 0/3] btrfs: fix unexpected -ENOMEM with
 percpu_counter_init when create snapshot
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1670900386; bh=iG7zbhW+uHHKyGOb/p2l3puUOwwFkCuLv+gU79JdDnE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lEI6yxYk2i2Uek1s9tw2TlNDWSvEUZRVDfLeIpSS9jzAgrii+614ZmODU4yZyb787
         rIU5ovjti0mL2PZ7LJ6eo5+tHmwyB/9gfnLx24471bdSQ7HSUxdoSMiNP2+Z2/d4gZ
         VmHp6Zk77lF885qa2pkLcMo/tXMAwz1c0kUIpM5E=
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20221205095122.17011-1-robbieko@synology.com>
 <CAL3q7H5V9zC_a7cUGuUuWyAh8POqbBMtmTP608mrE8vy_jqvqw@mail.gmail.com>
 <eb6563b8-10b3-9418-4777-812ddda45b23@synology.com>
 <bb8c0658-a1b1-b8fd-cdd2-f797692832ec@synology.com>
 <CAL3q7H6Vf9FX-ZiUh+NPpO1XK1718OHf-q9AeFXAmr38OZXkxg@mail.gmail.com>
From:   robbieko <robbieko@synology.com>
Message-ID: <162bffea-19c9-6b81-695d-62181c66e319@synology.com>
Date:   Tue, 13 Dec 2022 10:59:44 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6Vf9FX-ZiUh+NPpO1XK1718OHf-q9AeFXAmr38OZXkxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Filipe Manana 於 2022/12/13 上午1:04 寫道:
> On Thu, Dec 8, 2022 at 6:24 AM robbieko <robbieko@synology.com> wrote:
>>
>> robbieko 於 2022/12/6 下午4:58 寫道:
>>> Filipe Manana 於 2022/12/5 下午7:15 寫道:
>>>> On Mon, Dec 5, 2022 at 10:55 AM robbieko <robbieko@synology.com> wrote:
>>>>> From: Robbie Ko <robbieko@synology.com>
>>>>>
>>>>> [Issue]
>>>>> When creating subvolume/snapshot, the transaction may be abort due
>>>>> to -ENOMEM
>>>>>
>>>>>     WARNING: CPU: 1 PID: 411 at fs/btrfs/transaction.c:1937
>>>>> create_pending_snapshot+0xe30/0xe70 [btrfs]()
>>>>>     CPU: 1 PID: 411 Comm: btrfs Tainted: P O 4.4.180+ #42661
>>>> 4.4.180...
>>>>
>>>> How often does that happen on a supported kernel? The oldest supported
>>>> kernel is 4.9 at the moment.
>>> The occurrence of this issue is extremely low, and it cannot be
>>> reproduced stably.
>>> We have millions of machines out there, and this issue happened 3
>>> times in the last two years.
>>>
>>>
>>>>>     Call Trace:
>>>>>       create_pending_snapshot+0xe30/0xe70 [btrfs]
>>>>>       create_pending_snapshots+0x89/0xb0 [btrfs]
>>>>>       btrfs_commit_transaction+0x469/0xc60 [btrfs]
>>>>>       btrfs_mksubvol+0x5bd/0x690 [btrfs]
>>>>>       btrfs_mksnapshot+0x102/0x170 [btrfs]
>>>>>       btrfs_ioctl_snap_create_transid+0x1ad/0x1c0 [btrfs]
>>>>>       btrfs_ioctl_snap_create_v2+0x102/0x160 [btrfs]
>>>>>       btrfs_ioctl+0x2111/0x3130 [btrfs]
>>>>>       do_vfs_ioctl+0x7ea/0xa80
>>>>>       SyS_ioctl+0xa1/0xb0
>>>>>       entry_SYSCALL_64_fastpath+0x1e/0x8e
>>>>>     ---[ end trace 910c8f86780ca385 ]---
>>>>>     BTRFS: error (device dm-2) in create_pending_snapshot:1937:
>>>>> errno=-12 Out of memory
>>>>>
>>>>> [Cause]
>>>>> During creating a subvolume/snapshot, it is necessary to allocate
>>>>> memory for Initializing fs root.
>>>>> Therefore, it can only use GFP_NOFS to allocate memory to avoid
>>>>> deadlock issues.
>>>>> However, atomic allocation is required when processing
>>>>> percpu_counter_init
>>>>> without GFP_KERNEL due to the unique structure of percpu_counter.
>>>>> In this situation, allocating memory for initializing fs root may cause
>>>>> unexpected -ENOMEM when free memory is low and causes btrfs
>>>>> transaction to abort.
>>>> This sounds familiar, and we had a regression in mm that made
>>>> percepu_counter_init fail very often with -ENOMEM.
>>>> See:
>>>>
>>>> https://lore.kernel.org/linux-mm/CAL3q7H5RNBjCi708GH7jnczAOe0BLnacT9C+OBgA-Dx9jhB6SQ@mail.gmail.com/
>>>>
>>>>
>>>> The kernel fix was this:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0760fa3d8f7fceeea508b98899f1c826e10ffe78
>>>>
>>>>
>>>> I'm assuming that you are probably running a Synology kernel based on
>>>> 4.4 with a lot of backported patches, is that correct?
>>>> Maybe you have the patchset that introduced the regression in that
>>>> kernel, but that later fix is not in there.
>>>>
>>>> Thanks.
>>> Yes, We do backport many patches, but we don't backport "mm:
>>> memcg/percpu: account percpu memory to memory cgroups",
>>> So we think the issue has nothing to do with "percpu: make
>>> pcpu_nr_empty_pop_pages per chunk type".
>>>
>>> This issue is just a corner case, when percpu_counter_init is executed
>>> with GFP_NOFS, there is a chance to fail.
>>> So we feel that the snapshot_lock should be preallocated.
>>>
>>> Thanks.
>>>
>>>
>> Anyone have any suggestions ?
> Sorry, some holidays and other priorities came in.
>
> The idea seems fine to me. I was just wondering if you weren't hitting
> that regression in mm.
> Patches 1 and 2 don't apply with current misc-next, btw, they require
> manual conflict resolution.

Ok. I will switch to using misc-next for development and send patch v2

Thanks.

> I'll leave review comments on each patch, small things, nothing major.
>
> Thanks.
>
>>
>>>>> [Fix]
>>>>> We allocate memory at the beginning of creating a subvolume/snapshot.
>>>>> This way, we can ensure the memory is enough when initializing fs root.
>>>>> Even -ENOMEM happens at the beginning of creating a subvolume/snapshot,
>>>>> the transaction won’t abort since it hasn’t started yet.
>>>>>
>>>>> Robbie Ko (3):
>>>>>     btrfs: refactor anon_dev with new_fs_root_args for create
>>>>>       subvolume/snapshot
>>>>>     btrfs: change snapshot_lock to dynamic pointer
>>>>>     btrfs: add snapshot_lock to new_fs_root_args
>>>>>
>>>>>    fs/btrfs/ctree.h       |   2 +-
>>>>>    fs/btrfs/disk-io.c     | 107
>>>>> ++++++++++++++++++++++++++++++-----------
>>>>>    fs/btrfs/disk-io.h     |  12 ++++-
>>>>>    fs/btrfs/file.c        |   8 +--
>>>>>    fs/btrfs/inode.c       |  12 ++---
>>>>>    fs/btrfs/ioctl.c       |  38 +++++++--------
>>>>>    fs/btrfs/transaction.c |   2 +-
>>>>>    fs/btrfs/transaction.h |   5 +-
>>>>>    8 files changed, 123 insertions(+), 63 deletions(-)
>>>>>
>>>>> --
>>>>> 2.17.1
>>>>>
