Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4133540C0
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Apr 2021 12:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbhDEJV5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Apr 2021 05:21:57 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:35578 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241447AbhDEJUZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Apr 2021 05:20:25 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id EA59146D388;
        Mon,  5 Apr 2021 12:20:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1617614418; bh=ycE/cdogn8UjKAK8zPvsI1wmTOdyfN0MuCRk/fdeWew=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=JVvnT4sFIBxLRcCiSwh3rEmqvaezvmUi6DNPEcjRzNRqMeTK7bNfRp+QGWoI+pPqX
         +CEBlh3DxQzLnRRYQ1hKb+yes7aTQUCvEunZ46ePjqbGrGVhEx7ZwTR4MnAUnD93FY
         xHWoE2gzrOnY2MQlcpsc3wWNWeRqplo4UW9qaUyc=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id DB0B746D384;
        Mon,  5 Apr 2021 12:20:17 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id jp5hbDRM7aZq; Mon,  5 Apr 2021 12:20:17 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 388F846D385;
        Mon,  5 Apr 2021 12:20:17 +0300 (EEST)
Received: from nas (unknown [45.87.95.48])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 75FA11BE187A;
        Mon,  5 Apr 2021 12:20:13 +0300 (EEST)
References: <23a8830f3be500995e74b45f18862e67c0634c3d.1614793362.git.anand.jain@oracle.com>
 <b0caf058-3bb5-2ceb-d1d4-d352deee636e@oracle.com>
 <83ecd955-560f-14e5-ab97-33e0c0a3d3d0@oracle.com>
User-agent: mu4e 1.5.8; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     "dsterba@suse.com" <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
Date:   Mon, 05 Apr 2021 17:18:32 +0800
In-reply-to: <83ecd955-560f-14e5-ab97-33e0c0a3d3d0@oracle.com>
Message-ID: <a6qdw0jr.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBkfEh1qkXXPZGw8ysS5BQI+W9uSmo25U5hvmU1qJf04NURK/nm1yS2A=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Mon 05 Apr 2021 at 16:38, Anand Jain <anand.jain@oracle.com> 
wrote:

> Ping again.
>
It's already queued in misc-next.

commit 441737bb30f83914bb8517f52088c0130138d74b (misc-next)
Author: Anand Jain <anand.jain@oracle.com>
Date:   Fri Jul 17 18:05:25 2020 +0800

    btrfs: fix lockdep warning while mounting sprout fs

    Martin reported the following test case which reproduces 
    lockdep

--
Su
> Thanks, Anand
>
> On 06/03/2021 16:37, Anand Jain wrote:
>>
>> David,
>>
>> Ping?
>>
>> Thanks, Anand
>>
>>
>> On 04/03/2021 02:10, Anand Jain wrote:
>>> Following test case reproduces lockdep warning.
>>>
>>> Test case:
>>> DEV1=/dev/vdb
>>> DEV2=/dev/vdc
>>> umount /btrfs
>>> run mkfs.btrfs -f $DEV1
>>> run btrfstune -S 1 $DEV1
>>> run mount $DEV1 /btrfs
>>> run btrfs device add $DEV2 /btrfs -f
>>> run umount /btrfs
>>> run mount $DEV2 /btrfs
>>> run umount /btrfs
>>>
>>> The warning claims a possible ABBA deadlock between the 
>>> threads
>>> initiated by
>>> [#1] btrfs device add and [#0] the mount.
>>>
>>> ======================================================
>>> [ 540.743122] WARNING: possible circular locking dependency 
>>> detected
>>> [ 540.743129] 5.11.0-rc7+ #5 Not tainted
>>> [ 540.743135] 
>>> ------------------------------------------------------
>>> [ 540.743142] mount/2515 is trying to acquire lock:
>>> [ 540.743149] ffffa0c5544c2ce0
>>> (&fs_devs->device_list_mutex){+.+.}-{4:4}, at:
>>> clone_fs_devices+0x6d/0x210 [btrfs]
>>> [ 540.743458] but task is already holding lock:
>>> [ 540.743461] ffffa0c54a7932b8 (btrfs-chunk-00){++++}-{4:4}, 
>>> at:
>>> __btrfs_tree_read_lock+0x32/0x200 [btrfs]
>>> [ 540.743541] which lock already depends on the new lock.
>>> [ 540.743543] the existing dependency chain (in reverse order) 
>>> is:
>>>
>>> [ 540.743546] -> #1 (btrfs-chunk-00){++++}-{4:4}:
>>> [ 540.743566] down_read_nested+0x48/0x2b0
>>> [ 540.743585] __btrfs_tree_read_lock+0x32/0x200 [btrfs]
>>> [ 540.743650] btrfs_read_lock_root_node+0x70/0x200 [btrfs]
>>> [ 540.743733] btrfs_search_slot+0x6c6/0xe00 [btrfs]
>>> [ 540.743785] btrfs_update_device+0x83/0x260 [btrfs]
>>> [ 540.743849] btrfs_finish_chunk_alloc+0x13f/0x660 [btrfs] 
>>> <---
>>> device_list_mutex
>>> [ 540.743911] btrfs_create_pending_block_groups+0x18d/0x3f0 
>>> [btrfs]
>>> [ 540.743982] btrfs_commit_transaction+0x86/0x1260 [btrfs]
>>> [ 540.744037] btrfs_init_new_device+0x1600/0x1dd0 [btrfs]
>>> [ 540.744101] btrfs_ioctl+0x1c77/0x24c0 [btrfs]
>>> [ 540.744166] __x64_sys_ioctl+0xe4/0x140
>>> [ 540.744170] do_syscall_64+0x4b/0x80
>>> [ 540.744174] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>
>>> [ 540.744180] -> #0 (&fs_devs->device_list_mutex){+.+.}-{4:4}:
>>> [ 540.744184] __lock_acquire+0x155f/0x2360
>>> [ 540.744188] lock_acquire+0x10b/0x5c0
>>> [ 540.744190] __mutex_lock+0xb1/0xf80
>>> [ 540.744193] mutex_lock_nested+0x27/0x30
>>> [ 540.744196] clone_fs_devices+0x6d/0x210 [btrfs]
>>> [ 540.744270] btrfs_read_chunk_tree+0x3c7/0xbb0 [btrfs]
>>> [ 540.744336] open_ctree+0xf6e/0x2074 [btrfs]
>>> [ 540.744406] btrfs_mount_root.cold.72+0x16/0x127 [btrfs]
>>> [ 540.744472] legacy_get_tree+0x38/0x90
>>> [ 540.744475] vfs_get_tree+0x30/0x140
>>> [ 540.744478] fc_mount+0x16/0x60
>>> [ 540.744482] vfs_kern_mount+0x91/0x100
>>> [ 540.744484] btrfs_mount+0x1e6/0x670 [btrfs]
>>> [ 540.744536] legacy_get_tree+0x38/0x90
>>> [ 540.744537] vfs_get_tree+0x30/0x140
>>> [ 540.744539] path_mount+0x8d8/0x1070
>>> [ 540.744541] do_mount+0x8d/0xc0
>>> [ 540.744543] __x64_sys_mount+0x125/0x160
>>> [ 540.744545] do_syscall_64+0x4b/0x80
>>> [ 540.744547] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>
>>> [ 540.744551] other info that might help us debug this:
>>> [ 540.744552] Possible unsafe locking scenario:
>>>
>>> [ 540.744553] CPU0                 CPU1
>>> [ 540.744554] ----                 ----
>>> [ 540.744555] lock(btrfs-chunk-00);
>>> [ 540.744557] 
>>> lock(&fs_devs->device_list_mutex);
>>> [ 540.744560]                     lock(btrfs-chunk-00);
>>> [ 540.744562] lock(&fs_devs->device_list_mutex);
>>> [ 540.744564]
>>>   *** DEADLOCK ***
>>>
>>> [ 540.744565] 3 locks held by mount/2515:
>>> [ 540.744567] #0: ffffa0c56bf7a0e0
>>> (&type->s_umount_key#42/1){+.+.}-{4:4}, at:
>>> alloc_super.isra.16+0xdf/0x450
>>> [ 540.744574] #1: ffffffffc05a9628 (uuid_mutex){+.+.}-{4:4}, 
>>> at:
>>> btrfs_read_chunk_tree+0x63/0xbb0 [btrfs]
>>> [ 540.744640] #2: ffffa0c54a7932b8 
>>> (btrfs-chunk-00){++++}-{4:4}, at:
>>> __btrfs_tree_read_lock+0x32/0x200 [btrfs]
>>> [ 540.744708]
>>>   stack backtrace:
>>> [ 540.744712] CPU: 2 PID: 2515 Comm: mount Not tainted 
>>> 5.11.0-rc7+ #5
>>>
>>>
>>> But the device_list_mutex in clone_fs_devices() is redundant, 
>>> as
>>> explained
>>> below.
>>> Two threads [1]  and [2] (below) could lead to 
>>> clone_fs_device().
>>>
>>> [1]
>>> open_ctree <== mount sprout fs
>>>   btrfs_read_chunk_tree()
>>>    mutex_lock(&uuid_mutex) <== global lock
>>>    read_one_dev()
>>>     open_seed_devices()
>>>      clone_fs_devices() <== seed fs_devices
>>>       mutex_lock(&orig->device_list_mutex) <== seed fs_devices
>>>
>>> [2]
>>> btrfs_init_new_device() <== sprouting
>>>   mutex_lock(&uuid_mutex); <== global lock
>>>   btrfs_prepare_sprout()
>>>     lockdep_assert_held(&uuid_mutex)
>>>     clone_fs_devices(seed_fs_device) <== seed fs_devices
>>>
>>> Both of these threads hold uuid_mutex which is sufficient to 
>>> protect
>>> getting the seed device(s) freed while we are trying to clone 
>>> it for
>>> sprouting [2] or mounting a sprout [1] (as above). A mounted 
>>> seed
>>> device can not free/write/replace because it is read-only. An 
>>> unmounted
>>> seed device can free by btrfs_free_stale_devices(), but it 
>>> needs
>>> uuid_mutex.
>>> So this patch removes the unnecessary device_list_mutex in
>>> clone_fs_devices().
>>> And adds a lockdep_assert_held(&uuid_mutex) in 
>>> clone_fs_devices().
>>>
>>> Reported-by: Su Yue <l@damenly.su>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> v2: Remove Martin's Reported-by and Tested-by.
>>>      Add Su's Reported-by.
>>>      Add lockdep_assert_held check.
>>>      Update the changelog, make it relevant to the current 
>>>      misc-next
>>>
>>>   fs/btrfs/volumes.c | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index bc3b33efddc5..4188edbad2ef 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -570,6 +570,8 @@ static int btrfs_free_stale_devices(const 
>>> char *path,
>>>       struct btrfs_device *device, *tmp_device;
>>>       int ret = 0;
>>> +    lockdep_assert_held(&uuid_mutex);
>>> +
>>>       if (path)
>>>           ret = -ENOENT;
>>> @@ -1000,11 +1002,12 @@ static struct btrfs_fs_devices
>>> *clone_fs_devices(struct btrfs_fs_devices *orig)
>>>       struct btrfs_device *orig_dev;
>>>       int ret = 0;
>>> +    lockdep_assert_held(&uuid_mutex);
>>> +
>>>       fs_devices = alloc_fs_devices(orig->fsid, NULL);
>>>       if (IS_ERR(fs_devices))
>>>           return fs_devices;
>>> -    mutex_lock(&orig->device_list_mutex);
>>>       fs_devices->total_devices = orig->total_devices;
>>>       list_for_each_entry(orig_dev, &orig->devices, dev_list) 
>>>       {
>>> @@ -1036,10 +1039,8 @@ static struct btrfs_fs_devices
>>> *clone_fs_devices(struct btrfs_fs_devices *orig)
>>>           device->fs_devices = fs_devices;
>>>           fs_devices->num_devices++;
>>>       }
>>> -    mutex_unlock(&orig->device_list_mutex);
>>>       return fs_devices;
>>>   error:
>>> -    mutex_unlock(&orig->device_list_mutex);
>>>       free_fs_devices(fs_devices);
>>>       return ERR_PTR(ret);
>>>   }
>>>
>>

