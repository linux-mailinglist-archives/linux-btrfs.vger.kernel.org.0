Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45948B11E6
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732728AbfILPOh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 11:14:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40268 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732698AbfILPOg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 11:14:36 -0400
Received: by mail-io1-f66.google.com with SMTP id h144so55467748iof.7
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PBVrP14tfyeXfVNTEun1T+jA88MWleP2vjV37IANvM8=;
        b=0xkg9J8fXaiuNxGRRdWyV7X+lgQit6Ags+kAj0H/6o8QRysT985BRed4o712vG0ui/
         DcVhY5OGIsktT2WYRi5TL0Zrq/ZceIwLXnQvf2UD77o8W5hx/cnxPOxIYB1RgjWzBrjS
         mX/Mh6+msA75+eFPiNzqafdsGgMMPtjHy9XA7sfTB4hTqlLf37+NscolW/1+x3bqH25V
         t/OfmXIK0Rahfew1g/bXMYKJXCSKi6KN27AF81wvxjQPW7cNcAU9E3S8sn7sVDvd0ILv
         tcO2NNRMMQ2YJfh0YF4hFKdOj1PFQ6dNx8PMJDLcTR7c/JuVwrOHm98fkGEY7xQfLR+I
         Ol+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PBVrP14tfyeXfVNTEun1T+jA88MWleP2vjV37IANvM8=;
        b=TdMvyjwKcjRacn705wBGK5ftOuYi3d3EcDrtyMaaGDuLEsxqMraFJRYKHaamkSC8/g
         I1HmfVMk0u26aGidxNLcaiBHRuKUJ/L9yuaLdWo7MqogBJux1nSWLLsZEitn/ivmvB5Q
         MUwzwedeUtJRhBZkRscq89AI7UnhXEQtDCbTCCowv9H6v2iZkXPqlanpYrAMNkRgNAZ7
         wwLx4XpGa4aSe/mMiLn/Usp1lNi6CINm+iFxJ6HRwysumcRE5aJ3i6HdK95p2DA4Tmc7
         1I8ll/yy/y5hx+5ylZeMvQAgoHqHcp2FP85uUN36ZEcENlHmcSztt6y4M/BCIzrhFnv3
         Qigw==
X-Gm-Message-State: APjAAAXHyEMPcOPn2sh+9MkrJgfdBLNzJchZK4gZJsvfxYkXrLDfnuta
        vt4gJoXDE2BfgAySxqUcV2nBdA==
X-Google-Smtp-Source: APXvYqzTqe1HtsN6nwT9kp72wFFVxFdvEb7lm9mIWL4v/uWtfiIHoPWYRoq5liqeO4Rv0Zm/eqbvWw==
X-Received: by 2002:a02:3f12:: with SMTP id d18mr2197451jaa.39.1568301273854;
        Thu, 12 Sep 2019 08:14:33 -0700 (PDT)
Received: from localhost ([75.104.69.207])
        by smtp.gmail.com with ESMTPSA id e139sm35611843iof.60.2019.09.12.08.14.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 08:14:32 -0700 (PDT)
Date:   Thu, 12 Sep 2019 11:14:20 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] Btrfs: fix assertion failure during fsync and use of
 stale transaction
Message-ID: <20190912151416.svmkxurjrtyc5jkf@MacBook-Pro-91.local>
References: <20190910142649.19808-1-fdmanana@kernel.org>
 <20190912121757.hw2osz4sejlzsrrq@MacBook-Pro-91.local>
 <CAL3q7H4tTsZaz0Nr+yWBkDfHmj=M0JszZtaTaaM9LP2oeWLu3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4tTsZaz0Nr+yWBkDfHmj=M0JszZtaTaaM9LP2oeWLu3w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 02:19:55PM +0100, Filipe Manana wrote:
> On Thu, Sep 12, 2019 at 1:18 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Tue, Sep 10, 2019 at 03:26:49PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Sometimes when fsync'ing a file we need to log that other inodes exist and
> > > when we need to do that we acquire a reference on the inodes and then drop
> > > that reference using iput() after logging them.
> > >
> > > That generally is not a problem except if we end up doing the final iput()
> > > (dropping the last reference) on the inode and that inode has a link count
> > > of 0, which can happen in a very short time window if the logging path
> > > gets a reference on the inode while it's being unlinked.
> > >
> > > In that case we end up getting the eviction callback, btrfs_evict_inode(),
> > > invoked through the iput() call chain which needs to drop all of the
> > > inode's items from its subvolume btree, and in order to do that, it needs
> > > to join a transaction at the helper function evict_refill_and_join().
> > > However because the task previously started a transaction at the fsync
> > > handler, btrfs_sync_file(), it has current->journal_info already pointing
> > > to a transaction handle and therefore evict_refill_and_join() will get
> > > that transaction handle from btrfs_join_transaction(). From this point on,
> > > two different problems can happen:
> > >
> > > 1) evict_refill_and_join() will often change the transaction handle's
> > >    block reserve (->block_rsv) and set its ->bytes_reserved field to a
> > >    value greater than 0. If evict_refill_and_join() never commits the
> > >    transaction, the eviction handler ends up decreasing the reference
> > >    count (->use_count) of the transaction handle through the call to
> > >    btrfs_end_transaction(), and after that point we have a transaction
> > >    handle with a NULL ->block_rsv (which is the value prior to the
> > >    transaction join from evict_refill_and_join()) and a ->bytes_reserved
> > >    value greater than 0. If after the eviction/iput completes the inode
> > >    logging path hits an error or it decides that it must fallback to a
> > >    transaction commit, the btrfs fsync handle, btrfs_sync_file(), gets a
> > >    non-zero value from btrfs_log_dentry_safe(), and because of that
> > >    non-zero value it tries to commit the transaction using a handle with
> > >    a NULL ->block_rsv and a non-zero ->bytes_reserved value. This makes
> > >    the transaction commit hit an assertion failure at
> > >    btrfs_trans_release_metadata() because ->bytes_reserved is not zero but
> > >    the ->block_rsv is NULL. The produced stack trace for that is like the
> > >    following:
> > >
> > >    [192922.917158] assertion failed: !trans->bytes_reserved, file: fs/btrfs/transaction.c, line: 816
> > >    [192922.917553] ------------[ cut here ]------------
> > >    [192922.917922] kernel BUG at fs/btrfs/ctree.h:3532!
> > >    [192922.918310] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
> > >    [192922.918666] CPU: 2 PID: 883 Comm: fsstress Tainted: G        W         5.1.4-btrfs-next-47 #1
> > >    [192922.919035] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
> > >    [192922.919801] RIP: 0010:assfail.constprop.25+0x18/0x1a [btrfs]
> > >    (...)
> > >    [192922.920925] RSP: 0018:ffffaebdc8a27da8 EFLAGS: 00010286
> > >    [192922.921315] RAX: 0000000000000051 RBX: ffff95c9c16a41c0 RCX: 0000000000000000
> > >    [192922.921692] RDX: 0000000000000000 RSI: ffff95cab6b16838 RDI: ffff95cab6b16838
> > >    [192922.922066] RBP: ffff95c9c16a41c0 R08: 0000000000000000 R09: 0000000000000000
> > >    [192922.922442] R10: ffffaebdc8a27e70 R11: 0000000000000000 R12: ffff95ca731a0980
> > >    [192922.922820] R13: 0000000000000000 R14: ffff95ca84c73338 R15: ffff95ca731a0ea8
> > >    [192922.923200] FS:  00007f337eda4e80(0000) GS:ffff95cab6b00000(0000) knlGS:0000000000000000
> > >    [192922.923579] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >    [192922.923948] CR2: 00007f337edad000 CR3: 00000001e00f6002 CR4: 00000000003606e0
> > >    [192922.924329] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > >    [192922.924711] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > >    [192922.925105] Call Trace:
> > >    [192922.925505]  btrfs_trans_release_metadata+0x10c/0x170 [btrfs]
> > >    [192922.925911]  btrfs_commit_transaction+0x3e/0xaf0 [btrfs]
> > >    [192922.926324]  btrfs_sync_file+0x44c/0x490 [btrfs]
> > >    [192922.926731]  do_fsync+0x38/0x60
> > >    [192922.927138]  __x64_sys_fdatasync+0x13/0x20
> > >    [192922.927543]  do_syscall_64+0x60/0x1c0
> > >    [192922.927939]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > >    (...)
> > >    [192922.934077] ---[ end trace f00808b12068168f ]---
> > >
> > > 2) If evict_refill_and_join() decides to commit the transaction, it will
> > >    be able to do it, since the nested transaction join only increments the
> > >    transaction handle's ->use_count reference counter and it does not
> > >    prevent the transaction from getting committed. This means that after
> > >    eviction completes, the fsync logging path will be using a transaction
> > >    handle that refers to an already committed transaction. What happens
> > >    when using such a stale transaction can be unpredictable, we are at
> > >    least having a use-after-free on the transaction handle itself, since
> > >    the transaction commit will call kmem_cache_free() against the handle
> > >    regardless of its ->use_count value, or we can end up silently losing
> > >    all the updates to the log tree after that iput() in the logging path,
> > >    or using a transaction handle that in the meanwhile was allocated to
> > >    another task for a new transaction, etc, pretty much unpredictable
> > >    what can happen.
> > >
> >
> > And talking it over with Nikolay I realized that since we're doing the commit
> > through the flushing this doesn't actually happen anymore.
> > may_commit_transaction() returns -EGAIN if we already have a trans handle open,
> > so hooray I made it safer by accident!  But we definitely should follow up and
> > add an assert in btrfs_commit_transaction() to catch this case, cause holy shit
> > that's bad.  Thanks,
> 
> Yep, but problem 1) (assertion failure) is still valid after your
> recent changes in misc-next.
> Either way, this fix has to be added to stable releases to fix both
> problems there.
> 

Agreed, just adding context for the current changes.  This patch is fine as it
is, just some follow up stuff to catch transaction commits under nested trans
handles.  Thanks,

Josef
