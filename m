Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C78B1145D21
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 21:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgAVU3S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 15:29:18 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46404 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgAVU3S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 15:29:18 -0500
Received: by mail-qk1-f193.google.com with SMTP id r14so1045116qke.13
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2020 12:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FN/gD1EUpKDhiSLF2pagGiaSlxMME5Iy1hVJJjlvCCI=;
        b=YhYnDXfauomceHC/bxKrn5WF/FhkepdTjhy3HK0nYc1UOOlwbs5oPrPiBxBFsqILBy
         LZAKbX6fzyAroM/s3QrC5j6kJwbmFyw3gUc7c/pgE3uJ+ai17GpLv39ZWK+eueZLQ85N
         1F96Hn2BvZtqta85p8Duo1UreXMmxr+18HryiIp2WlUH9a6RoIZXmdOJR3zTARcENULz
         gKDv4QEy1lS1xaDuPyZtD7KzHrBbp+fJXO7LDp//PRu+xa1JHILCTHs4czNACGNfrf2+
         Xya65hZMH4PWFMVMZq7rSzoQ0WYTYgJHnpkd/tyEMYBePWNbW56zMO0H/VW26gMPzSjO
         bc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FN/gD1EUpKDhiSLF2pagGiaSlxMME5Iy1hVJJjlvCCI=;
        b=tiN5xAtYiw0QqisPTlpZt+Z/Aj5duDD9ozQvZXv+N9ClN+ldDHI8gVGZZxVIr4SUQv
         kyv1FC1K4SXNAra70KVYrQ4Ez73SEsCHVkbC1iVPxOgYfF6d7yYBe+14tLnr1DkY/Y2t
         Mrhmj/Fn8RK+bAmBvym935/mETEQVTwgJW9wej2MZZcSJAC39Y7DItjNeJwILSRKp/Mk
         5E+VkgC/AYOrpqQxBXO7OYp6hZIJR0ubn6Ylls6CXWpk2Xf3ytaeIQnbdU23Q3UgULP3
         plUpOdDI57IZmRemNh1gCXyBYnWvm7LULSEfZUh/ofdAeoYXqws9QGMVJ1GxR/dhI8a6
         oqTw==
X-Gm-Message-State: APjAAAXH0UFmFcgYs8tmJbG/VCdd6FfiZ8jzBQl9J4ufQuli1FE7NnlX
        NDxMuzYDaGN8xkgxa5AMmN/UXhnzskuPQA==
X-Google-Smtp-Source: APXvYqzFq/15zFxmG7pP8NBKXLfXF0a7+t9qdP2caSx1un7FA8YWJtQPkx/1RfEtXuCY5ajcIwI4Pg==
X-Received: by 2002:a05:620a:14a4:: with SMTP id x4mr12079980qkj.493.1579724956267;
        Wed, 22 Jan 2020 12:29:16 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id n25sm2442203qkh.88.2020.01.22.12.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 12:29:15 -0800 (PST)
Subject: Re: [PATCH 1/2] Btrfs: fix race between adding and putting tree mod
 seq elements and nodes
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200122122320.30073-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0991d646-30f7-ae4e-3bf3-d262747c1eff@toxicpanda.com>
Date:   Wed, 22 Jan 2020 15:29:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122122320.30073-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/22/20 7:23 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There is a race between adding and removing elements to the tree mod log
> list and rbtree that can lead to use-after-free problems.
> 
> Consider the following example that explains how/why the problems happens:
> 
> 1) Task A has mod log element with sequence number 200. It currently is
>     the only element in the mod log list;
> 
> 2) Task A calls btrfs_put_tree_mod_seq() because it no longer needs to
>     access the tree mod log. When it enters the function, it initializes
>     'min_seq' to (u64)-1. Then it acquires the lock 'tree_mod_seq_lock'
>     before checking if there are other elements in the mod seq list.
>     Since the list it empty, 'min_seq' remains set to (u64)-1. Then it
>     unlocks the lock 'tree_mod_seq_lock';
> 
> 3) Before task A acquires the lock 'tree_mod_log_lock', task B adds
>     itself to the mod seq list through btrfs_get_tree_mod_seq() and gets a
>     sequence number of 201;
> 
> 4) Some other task, name it task C, modifies a btree and because there
>     elements in the mod seq list, it adds a tree mod elem to the tree
>     mod log rbtree. That node added to the mod log rbtree is assigned
>     a sequence number of 202;
> 
> 5) Task B, which is doing fiemap and resolving indirect back references,
>     calls btrfs get_old_root(), with 'time_seq' == 201, which in turn
>     calls tree_mod_log_search() - the search returns the mod log node
>     from the rbtree with sequence number 202, created by task C;
> 
> 6) Task A now acquires the lock 'tree_mod_log_lock', starts iterating
>     the mod log rbtree and finds the node with sequence number 202. Since
>     202 is less than the previously computed 'min_seq', (u64)-1, it
>     removes the node and frees it;
> 
> 7) Task B still has a pointer to the node with sequence number 202, and
>     it dereferences the pointer itself and through the call to
>     __tree_mod_log_rewind(), resulting in a use-after-free problem._
> 
> This issue can be triggered sporadically with the test case generic/561
> from fstests, and it happens more frequently with a higher number of
> duperemove processes. When it happens to me, it either freezes the vm or
> it produces a trace like the following before crashing:
> 
>    [ 1245.321140] general protection fault: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
>    [ 1245.321200] CPU: 1 PID: 26997 Comm: pool Not tainted 5.5.0-rc6-btrfs-next-52 #1
>    [ 1245.321235] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
>    [ 1245.321287] RIP: 0010:rb_next+0x16/0x50
>    [ 1245.321307] Code: ....
>    [ 1245.321372] RSP: 0018:ffffa151c4d039b0 EFLAGS: 00010202
>    [ 1245.321388] RAX: 6b6b6b6b6b6b6b6b RBX: ffff8ae221363c80 RCX: 6b6b6b6b6b6b6b6b
>    [ 1245.321409] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8ae221363c80
>    [ 1245.321439] RBP: ffff8ae20fcc4688 R08: 0000000000000002 R09: 0000000000000000
>    [ 1245.321475] R10: ffff8ae20b120910 R11: 00000000243f8bb1 R12: 0000000000000038
>    [ 1245.321506] R13: ffff8ae221363c80 R14: 000000000000075f R15: ffff8ae223f762b8
>    [ 1245.321539] FS:  00007fdee1ec7700(0000) GS:ffff8ae236c80000(0000) knlGS:0000000000000000
>    [ 1245.321591] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [ 1245.321614] CR2: 00007fded4030c48 CR3: 000000021da16003 CR4: 00000000003606e0
>    [ 1245.321642] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    [ 1245.321668] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    [ 1245.321706] Call Trace:
>    [ 1245.321798]  __tree_mod_log_rewind+0xbf/0x280 [btrfs]
>    [ 1245.321841]  btrfs_search_old_slot+0x105/0xd00 [btrfs]
>    [ 1245.321877]  resolve_indirect_refs+0x1eb/0xc60 [btrfs]
>    [ 1245.321912]  find_parent_nodes+0x3dc/0x11b0 [btrfs]
>    [ 1245.321947]  btrfs_check_shared+0x115/0x1c0 [btrfs]
>    [ 1245.321980]  ? extent_fiemap+0x59d/0x6d0 [btrfs]
>    [ 1245.322029]  extent_fiemap+0x59d/0x6d0 [btrfs]
>    [ 1245.322066]  do_vfs_ioctl+0x45a/0x750
>    [ 1245.322081]  ksys_ioctl+0x70/0x80
>    [ 1245.322092]  ? trace_hardirqs_off_thunk+0x1a/0x1c
>    [ 1245.322113]  __x64_sys_ioctl+0x16/0x20
>    [ 1245.322126]  do_syscall_64+0x5c/0x280
>    [ 1245.322139]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>    [ 1245.322155] RIP: 0033:0x7fdee3942dd7
>    [ 1245.322177] Code: ....
>    [ 1245.322258] RSP: 002b:00007fdee1ec6c88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>    [ 1245.322294] RAX: ffffffffffffffda RBX: 00007fded40210d8 RCX: 00007fdee3942dd7
>    [ 1245.322314] RDX: 00007fded40210d8 RSI: 00000000c020660b RDI: 0000000000000004
>    [ 1245.322337] RBP: 0000562aa89e7510 R08: 0000000000000000 R09: 00007fdee1ec6d44
>    [ 1245.322369] R10: 0000000000000073 R11: 0000000000000246 R12: 00007fdee1ec6d48
>    [ 1245.322390] R13: 00007fdee1ec6d40 R14: 00007fded40210d0 R15: 00007fdee1ec6d50
>    [ 1245.322423] Modules linked in: ....
>    [ 1245.323443] ---[ end trace 01de1e9ec5dff3cd ]---
> 
> Fix this by ensuring that btrfs_put_tree_mod_seq() computes the minimum
> sequence number and iterates the rbtree while holding the lock
> 'tree_mod_log_lock' in write mode. Also get rid of the 'tree_mod_seq_lock'
> lock, since it is now redundant.
> 
> Fixes: bd989ba359f2ac ("Btrfs: add tree modification log functions")
> Fixes: 097b8a7c9e48e2 ("Btrfs: join tree mod log code with the code holding back delayed refs")
> CC: stable@vger.kernel.org
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Ugh what a pain in the ass, thanks

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
