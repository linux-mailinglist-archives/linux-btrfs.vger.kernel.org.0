Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305CC6507E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Dec 2022 07:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiLSGyM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 01:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiLSGyL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 01:54:11 -0500
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1845FE0
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Dec 2022 22:54:09 -0800 (PST)
Subject: Re: [PATCH v2 0/3] btrfs: fix unexpected -ENOMEM with
 percpu_counter_init when create snapshot
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1671432847; bh=UEGEgSOWdJreKcypPHVSCVRWc5C3FNv0wPe6KlwTDLo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=If8mfvygQoJd4bmrgiMVRgUOJP0W0wk8b+8XPgBYGr5bxAijIhBE3oXLtOHwqeN12
         wAFihN4LlDTjwUbYpXFWeKRTy0lZfq7lqAm2gBxtGz5KF6ODuPSmI8BmKDmokregsa
         A37SfMfSc8Z/0v6+w5sJaYhZS3epod+1Jsvd7ZQg=
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20221214021125.28289-1-robbieko@synology.com>
 <Y5oA3qBk+qMSyAR/@localhost.localdomain>
 <20221214180718.GF10499@twin.jikos.cz>
From:   robbieko <robbieko@synology.com>
Message-ID: <f1971de4-5355-6f57-46df-0a6cefb9ee95@synology.com>
Date:   Mon, 19 Dec 2022 14:54:06 +0800
MIME-Version: 1.0
In-Reply-To: <20221214180718.GF10499@twin.jikos.cz>
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


David Sterba 於 2022/12/15 上午2:07 寫道:
> On Wed, Dec 14, 2022 at 11:59:10AM -0500, Josef Bacik wrote:
>> On Wed, Dec 14, 2022 at 10:11:22AM +0800, robbieko wrote:
>>> From: Robbie Ko <robbieko@synology.com>
>>>
>>> [Issue]
>>> When creating subvolume/snapshot, the transaction may be abort due to -ENOMEM
>>>
>>>    WARNING: CPU: 1 PID: 411 at fs/btrfs/transaction.c:1937 create_pending_snapshot+0xe30/0xe70 [btrfs]()
>>>    CPU: 1 PID: 411 Comm: btrfs Tainted: P O 4.4.180+ #42661
>>>    Call Trace:
>>>      create_pending_snapshot+0xe30/0xe70 [btrfs]
>>>      create_pending_snapshots+0x89/0xb0 [btrfs]
>>>      btrfs_commit_transaction+0x469/0xc60 [btrfs]
>>>      btrfs_mksubvol+0x5bd/0x690 [btrfs]
>>>      btrfs_mksnapshot+0x102/0x170 [btrfs]
>>>      btrfs_ioctl_snap_create_transid+0x1ad/0x1c0 [btrfs]
>>>      btrfs_ioctl_snap_create_v2+0x102/0x160 [btrfs]
>>>      btrfs_ioctl+0x2111/0x3130 [btrfs]
>>>      do_vfs_ioctl+0x7ea/0xa80
>>>      SyS_ioctl+0xa1/0xb0
>>>      entry_SYSCALL_64_fastpath+0x1e/0x8e
>>>    ---[ end trace 910c8f86780ca385 ]---
>>>    BTRFS: error (device dm-2) in create_pending_snapshot:1937: errno=-12 Out of memory
>>>
>>> [Cause]
>>> During creating a subvolume/snapshot, it is necessary to allocate memory for Initializing fs root.
>>> Therefore, it can only use GFP_NOFS to allocate memory to avoid deadlock issues.
>>> However, atomic allocation is required when processing percpu_counter_init
>>> without GFP_KERNEL due to the unique structure of percpu_counter.
>>> In this situation, allocating memory for initializing fs root may cause
>>> unexpected -ENOMEM when free memory is low and causes btrfs transaction to abort.
>>>
>>> [Fix]
>>> We allocate memory at the beginning of creating a subvolume/snapshot.
>>> This way, we can ensure the memory is enough when initializing fs root.
>>> Even -ENOMEM happens at the beginning of creating a subvolume/snapshot,
>>> the transaction won’t abort since it hasn’t started yet.
>> Honestly I'd rather just make the btrfs_drew_lock use an atomic_t for the
>> writers counter as well.  This is only taken in truncate an nocow writes, and in
>> nocow writes there are a looooot of slower things that have to be done that
>> we're not winning a lot with the percpu counter.  Is there any reason not to
>> just do that and leave all this code alone?  Thanks,
> The percpu counter for writers is there since the original commit
> 8257b2dc3c1a1057 "Btrfs: introduce btrfs_{start, end}_nocow_write() for
> each subvolume". The reason could be to avoid hammering the same
> cacheline from all the readers but then the writers do that anyway.
> This happens in context related to IO or there's some waiting anyway, so
> yeah using atomic for writers should be ok as well.

Sorry for the late reply, I've been busy recently.
This modification will not affect the original btrfs_drew_lock behavior,
and the framework can also provide future scenarios where memory
needs to be allocated in init_fs_root.

Thanks.

Robbie Ko

