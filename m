Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6B1B0DF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 13:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfILLfn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 07:35:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:49828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730923AbfILLfn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 07:35:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A4EFAF61;
        Thu, 12 Sep 2019 11:35:40 +0000 (UTC)
Subject: Re: [PATCH] Btrfs: fix assertion failure during fsync and use of
 stale transaction
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190910142649.19808-1-fdmanana@kernel.org>
 <b171e10f-6f1f-4711-4fa6-67e2ffbe8378@suse.com>
 <CAL3q7H7-ARvEp+gXE6XYK3KRLuwYO8HdSP_0C+fW5ekCE8-goQ@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <438d699e-21bf-5bb2-7c02-0efa87e92086@suse.com>
Date:   Thu, 12 Sep 2019 14:35:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7-ARvEp+gXE6XYK3KRLuwYO8HdSP_0C+fW5ekCE8-goQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.09.19 г. 14:24 ч., Filipe Manana wrote:
> On Thu, Sep 12, 2019 at 12:10 PM Nikolay Borisov <nborisov@suse.com> wrote:
>>
>>
>>
>> On 10.09.19 г. 17:26 ч., fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> Sometimes when fsync'ing a file we need to log that other inodes exist and
>>> when we need to do that we acquire a reference on the inodes and then drop
>>> that reference using iput() after logging them.
>>>
>>> That generally is not a problem except if we end up doing the final iput()
>>> (dropping the last reference) on the inode and that inode has a link count
>>> of 0, which can happen in a very short time window if the logging path
>>> gets a reference on the inode while it's being unlinked.
>>>
>>> In that case we end up getting the eviction callback, btrfs_evict_inode(),
>>> invoked through the iput() call chain which needs to drop all of the
>>> inode's items from its subvolume btree, and in order to do that, it needs
>>> to join a transaction at the helper function evict_refill_and_join().
>>> However because the task previously started a transaction at the fsync
>>> handler, btrfs_sync_file(), it has current->journal_info already pointing
>>> to a transaction handle and therefore evict_refill_and_join() will get
>>> that transaction handle from btrfs_join_transaction(). From this point on,
>>> two different problems can happen:
>>>
>>> 1) evict_refill_and_join() will often change the transaction handle's
>>>    block reserve (->block_rsv) and set its ->bytes_reserved field to a
>>>    value greater than 0. If evict_refill_and_join() never commits the
>>>    transaction, the eviction handler ends up decreasing the reference
>>>    count (->use_count) of the transaction handle through the call to
>>>    btrfs_end_transaction(), and after that point we have a transaction
>>>    handle with a NULL ->block_rsv (which is the value prior to the
>>>    transaction join from evict_refill_and_join()) and a ->bytes_reserved
>>>    value greater than 0. If after the eviction/iput completes the inode
>>>    logging path hits an error or it decides that it must fallback to a
>>>    transaction commit, the btrfs fsync handle, btrfs_sync_file(), gets a
>>>    non-zero value from btrfs_log_dentry_safe(), and because of that
>>>    non-zero value it tries to commit the transaction using a handle with
>>>    a NULL ->block_rsv and a non-zero ->bytes_reserved value. This makes
>>>    the transaction commit hit an assertion failure at
>>>    btrfs_trans_release_metadata() because ->bytes_reserved is not zero but
>>>    the ->block_rsv is NULL. The produced stack trace for that is like the
>>>    following:
>>>
>>>    [192922.917158] assertion failed: !trans->bytes_reserved, file: fs/btrfs/transaction.c, line: 816
>>>    [192922.917553] ------------[ cut here ]------------
>>>    [192922.917922] kernel BUG at fs/btrfs/ctree.h:3532!
>>>    [192922.918310] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
>>>    [192922.918666] CPU: 2 PID: 883 Comm: fsstress Tainted: G        W         5.1.4-btrfs-next-47 #1
>>>    [192922.919035] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
>>>    [192922.919801] RIP: 0010:assfail.constprop.25+0x18/0x1a [btrfs]
>>>    (...)
>>>    [192922.920925] RSP: 0018:ffffaebdc8a27da8 EFLAGS: 00010286
>>>    [192922.921315] RAX: 0000000000000051 RBX: ffff95c9c16a41c0 RCX: 0000000000000000
>>>    [192922.921692] RDX: 0000000000000000 RSI: ffff95cab6b16838 RDI: ffff95cab6b16838
>>>    [192922.922066] RBP: ffff95c9c16a41c0 R08: 0000000000000000 R09: 0000000000000000
>>>    [192922.922442] R10: ffffaebdc8a27e70 R11: 0000000000000000 R12: ffff95ca731a0980
>>>    [192922.922820] R13: 0000000000000000 R14: ffff95ca84c73338 R15: ffff95ca731a0ea8
>>>    [192922.923200] FS:  00007f337eda4e80(0000) GS:ffff95cab6b00000(0000) knlGS:0000000000000000
>>>    [192922.923579] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>    [192922.923948] CR2: 00007f337edad000 CR3: 00000001e00f6002 CR4: 00000000003606e0
>>>    [192922.924329] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>    [192922.924711] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>    [192922.925105] Call Trace:
>>>    [192922.925505]  btrfs_trans_release_metadata+0x10c/0x170 [btrfs]
>>>    [192922.925911]  btrfs_commit_transaction+0x3e/0xaf0 [btrfs]
>>>    [192922.926324]  btrfs_sync_file+0x44c/0x490 [btrfs]
>>>    [192922.926731]  do_fsync+0x38/0x60
>>>    [192922.927138]  __x64_sys_fdatasync+0x13/0x20
>>>    [192922.927543]  do_syscall_64+0x60/0x1c0
>>>    [192922.927939]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>    (...)
>>>    [192922.934077] ---[ end trace f00808b12068168f ]---
>>>
>>> 2) If evict_refill_and_join() decides to commit the transaction, it will
>> evict_refill_and_join only ever calls btrfs_join_transaction so it
>> cannot ever commit the transaction.
> 
> It can:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/btrfs/inode.c?h=v5.3-rc8#n5399

Right, in 5.3 branch yes but in misc-next evict_and_join looks
completely different, that's where the confusion stems from. Thanks

<snip>
