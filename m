Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C31A9B0EBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 14:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbfILMSQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 08:18:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34740 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731283AbfILMSP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 08:18:15 -0400
Received: by mail-io1-f65.google.com with SMTP id k13so38745852ioj.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 05:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JEPKv5WL1ocpo04C4+zQ0nWSc8+lWvlUwX4EFHwP928=;
        b=uh+ZDPEBn3QHxZ09IBUR6ioFw2Lw7Vy9W33irWxyDeujVC5mhxztEwE27tZXCFNZBY
         Z5IbLnMjvoJxBTaylvsOmjq0qrjX4qiDlrE9i81reaYZ/ZbIh6WR1FB9HEE7zoovBtCP
         1E/89zoGw8dhLi9q5CmTYciVmsoHbqbR6bpKjGlNzo040u0FeKFwoVNu8Vbn/+tYtBfz
         Xq9gN1bmW3++FhYKkcPUb6UJPMw7XMK7s9QO1bcqA9Y0cfgmBxFibdNBY8wN/gStGqj8
         7Uw4SozlL4wSIk88laxk3ctE3HUxluJNsNrfAx6XpQ2xLH5xonKQkATp19ZeACq+FuRL
         urMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JEPKv5WL1ocpo04C4+zQ0nWSc8+lWvlUwX4EFHwP928=;
        b=Xd35glMxVj42OgvdtCDV4GBFc4qbL0klmI8ZhkTTgRXmuSnnr1hJWr+T5BK93fTJwL
         /s4BjzV8QVUTTH1j7AH717qGTsp0ksdWRi6CNHSMZVvXDcf8wYPFLwbxA/NX+HSWFMAK
         c/4U/ylYuA+g/ygeJLe2+fEaca3f8kpYRL6RWBxU+/c4z8xWOFH4qAGDAMYz/Ty8byG4
         V1ZH0g21NVeFDz4pDmih1BXERhx3RVcKfAkw4tWELanpNjzDUpgzYkhkXlCBobPMZyoX
         /sPpbFOWEJ5PQABfsVY1X+/2yLlmZ4/hYaR0A3x2Wfzc5lG7lCR5hAgCIvPZL/pr6iEB
         0jTQ==
X-Gm-Message-State: APjAAAXssy30BEic0hCLf4NqushGy5nVe80dRzI2MrVEPeGlUukUudiG
        qUXvX65dZMfDWRc9YvbJ/4EXQg==
X-Google-Smtp-Source: APXvYqzF0Bq0Uo9JAIppzvKEpH+XbIGF4N0Jg4fFOwkDAX3k+1CLPF2BscbpADErqm148iA3OTCttw==
X-Received: by 2002:a02:6601:: with SMTP id k1mr44795567jac.47.1568290693811;
        Thu, 12 Sep 2019 05:18:13 -0700 (PDT)
Received: from localhost ([75.104.69.207])
        by smtp.gmail.com with ESMTPSA id a21sm16860600ioe.27.2019.09.12.05.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 05:18:12 -0700 (PDT)
Date:   Thu, 12 Sep 2019 08:18:01 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix assertion failure during fsync and use of
 stale transaction
Message-ID: <20190912121757.hw2osz4sejlzsrrq@MacBook-Pro-91.local>
References: <20190910142649.19808-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910142649.19808-1-fdmanana@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 10, 2019 at 03:26:49PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Sometimes when fsync'ing a file we need to log that other inodes exist and
> when we need to do that we acquire a reference on the inodes and then drop
> that reference using iput() after logging them.
> 
> That generally is not a problem except if we end up doing the final iput()
> (dropping the last reference) on the inode and that inode has a link count
> of 0, which can happen in a very short time window if the logging path
> gets a reference on the inode while it's being unlinked.
> 
> In that case we end up getting the eviction callback, btrfs_evict_inode(),
> invoked through the iput() call chain which needs to drop all of the
> inode's items from its subvolume btree, and in order to do that, it needs
> to join a transaction at the helper function evict_refill_and_join().
> However because the task previously started a transaction at the fsync
> handler, btrfs_sync_file(), it has current->journal_info already pointing
> to a transaction handle and therefore evict_refill_and_join() will get
> that transaction handle from btrfs_join_transaction(). From this point on,
> two different problems can happen:
> 
> 1) evict_refill_and_join() will often change the transaction handle's
>    block reserve (->block_rsv) and set its ->bytes_reserved field to a
>    value greater than 0. If evict_refill_and_join() never commits the
>    transaction, the eviction handler ends up decreasing the reference
>    count (->use_count) of the transaction handle through the call to
>    btrfs_end_transaction(), and after that point we have a transaction
>    handle with a NULL ->block_rsv (which is the value prior to the
>    transaction join from evict_refill_and_join()) and a ->bytes_reserved
>    value greater than 0. If after the eviction/iput completes the inode
>    logging path hits an error or it decides that it must fallback to a
>    transaction commit, the btrfs fsync handle, btrfs_sync_file(), gets a
>    non-zero value from btrfs_log_dentry_safe(), and because of that
>    non-zero value it tries to commit the transaction using a handle with
>    a NULL ->block_rsv and a non-zero ->bytes_reserved value. This makes
>    the transaction commit hit an assertion failure at
>    btrfs_trans_release_metadata() because ->bytes_reserved is not zero but
>    the ->block_rsv is NULL. The produced stack trace for that is like the
>    following:
> 
>    [192922.917158] assertion failed: !trans->bytes_reserved, file: fs/btrfs/transaction.c, line: 816
>    [192922.917553] ------------[ cut here ]------------
>    [192922.917922] kernel BUG at fs/btrfs/ctree.h:3532!
>    [192922.918310] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
>    [192922.918666] CPU: 2 PID: 883 Comm: fsstress Tainted: G        W         5.1.4-btrfs-next-47 #1
>    [192922.919035] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
>    [192922.919801] RIP: 0010:assfail.constprop.25+0x18/0x1a [btrfs]
>    (...)
>    [192922.920925] RSP: 0018:ffffaebdc8a27da8 EFLAGS: 00010286
>    [192922.921315] RAX: 0000000000000051 RBX: ffff95c9c16a41c0 RCX: 0000000000000000
>    [192922.921692] RDX: 0000000000000000 RSI: ffff95cab6b16838 RDI: ffff95cab6b16838
>    [192922.922066] RBP: ffff95c9c16a41c0 R08: 0000000000000000 R09: 0000000000000000
>    [192922.922442] R10: ffffaebdc8a27e70 R11: 0000000000000000 R12: ffff95ca731a0980
>    [192922.922820] R13: 0000000000000000 R14: ffff95ca84c73338 R15: ffff95ca731a0ea8
>    [192922.923200] FS:  00007f337eda4e80(0000) GS:ffff95cab6b00000(0000) knlGS:0000000000000000
>    [192922.923579] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [192922.923948] CR2: 00007f337edad000 CR3: 00000001e00f6002 CR4: 00000000003606e0
>    [192922.924329] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    [192922.924711] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    [192922.925105] Call Trace:
>    [192922.925505]  btrfs_trans_release_metadata+0x10c/0x170 [btrfs]
>    [192922.925911]  btrfs_commit_transaction+0x3e/0xaf0 [btrfs]
>    [192922.926324]  btrfs_sync_file+0x44c/0x490 [btrfs]
>    [192922.926731]  do_fsync+0x38/0x60
>    [192922.927138]  __x64_sys_fdatasync+0x13/0x20
>    [192922.927543]  do_syscall_64+0x60/0x1c0
>    [192922.927939]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>    (...)
>    [192922.934077] ---[ end trace f00808b12068168f ]---
> 
> 2) If evict_refill_and_join() decides to commit the transaction, it will
>    be able to do it, since the nested transaction join only increments the
>    transaction handle's ->use_count reference counter and it does not
>    prevent the transaction from getting committed. This means that after
>    eviction completes, the fsync logging path will be using a transaction
>    handle that refers to an already committed transaction. What happens
>    when using such a stale transaction can be unpredictable, we are at
>    least having a use-after-free on the transaction handle itself, since
>    the transaction commit will call kmem_cache_free() against the handle
>    regardless of its ->use_count value, or we can end up silently losing
>    all the updates to the log tree after that iput() in the logging path,
>    or using a transaction handle that in the meanwhile was allocated to
>    another task for a new transaction, etc, pretty much unpredictable
>    what can happen.
> 

And talking it over with Nikolay I realized that since we're doing the commit
through the flushing this doesn't actually happen anymore.
may_commit_transaction() returns -EGAIN if we already have a trans handle open,
so hooray I made it safer by accident!  But we definitely should follow up and
add an assert in btrfs_commit_transaction() to catch this case, cause holy shit
that's bad.  Thanks,

Josef
