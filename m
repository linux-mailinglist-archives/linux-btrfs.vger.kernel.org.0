Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E39FBB0FB1
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 15:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbfILNSC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 09:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731788AbfILNSB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 09:18:01 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00B7B20856
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 13:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568294280;
        bh=An5syCvJ7CCEKCH1uuq7/Gv+AlRKQJicBnTMb1qeGHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oI1kYjDtCYPkxB1Fc11Oj8K38pdg8XNRFtT0wkoyX3O4ukJIPoBNJeC0+bOqCMtsi
         pXTzE5YcSSrEMlgeTwGfDzrvmfiwJniD0j/ZHhED7Jglbw58aL21+f869rVle996qU
         UUnGMeEU4eQQSnPtOSkOgCtaQM6YsQTpOIxpMQYQ=
Received: by mail-vs1-f50.google.com with SMTP id w195so16129268vsw.11
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 06:17:59 -0700 (PDT)
X-Gm-Message-State: APjAAAUjkv3c5UKA/9KqJzBmvEuDE3sUu5WYyIiAinSNN+Pw9Hb/NaKb
        low5KiVzmhA54YhZJP4uOKMSakztwjgHsYZtwPI=
X-Google-Smtp-Source: APXvYqyUZFHITENAsj/181Tk4V4S4J6gUWn5ewZdYNidssOSQjwOb/yLG2JXXuC9okknlyOTqbVh80h18zsE6IRdC2U=
X-Received: by 2002:a67:2d13:: with SMTP id t19mr19730929vst.99.1568294278962;
 Thu, 12 Sep 2019 06:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190910142649.19808-1-fdmanana@kernel.org> <20190912115843.5a2wqft7a47pbrhr@MacBook-Pro-91.local>
In-Reply-To: <20190912115843.5a2wqft7a47pbrhr@MacBook-Pro-91.local>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 12 Sep 2019 14:17:48 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5XcYzbYDNAsi-OY3sMAdcyjH7W70tSq10H=db2h3yaLQ@mail.gmail.com>
Message-ID: <CAL3q7H5XcYzbYDNAsi-OY3sMAdcyjH7W70tSq10H=db2h3yaLQ@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: fix assertion failure during fsync and use of
 stale transaction
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 12:59 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Tue, Sep 10, 2019 at 03:26:49PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Sometimes when fsync'ing a file we need to log that other inodes exist and
> > when we need to do that we acquire a reference on the inodes and then drop
> > that reference using iput() after logging them.
> >
> > That generally is not a problem except if we end up doing the final iput()
> > (dropping the last reference) on the inode and that inode has a link count
> > of 0, which can happen in a very short time window if the logging path
> > gets a reference on the inode while it's being unlinked.
> >
> > In that case we end up getting the eviction callback, btrfs_evict_inode(),
> > invoked through the iput() call chain which needs to drop all of the
> > inode's items from its subvolume btree, and in order to do that, it needs
> > to join a transaction at the helper function evict_refill_and_join().
> > However because the task previously started a transaction at the fsync
> > handler, btrfs_sync_file(), it has current->journal_info already pointing
> > to a transaction handle and therefore evict_refill_and_join() will get
> > that transaction handle from btrfs_join_transaction(). From this point on,
> > two different problems can happen:
> >
> > 1) evict_refill_and_join() will often change the transaction handle's
> >    block reserve (->block_rsv) and set its ->bytes_reserved field to a
> >    value greater than 0. If evict_refill_and_join() never commits the
> >    transaction, the eviction handler ends up decreasing the reference
> >    count (->use_count) of the transaction handle through the call to
> >    btrfs_end_transaction(), and after that point we have a transaction
> >    handle with a NULL ->block_rsv (which is the value prior to the
> >    transaction join from evict_refill_and_join()) and a ->bytes_reserved
> >    value greater than 0. If after the eviction/iput completes the inode
> >    logging path hits an error or it decides that it must fallback to a
> >    transaction commit, the btrfs fsync handle, btrfs_sync_file(), gets a
> >    non-zero value from btrfs_log_dentry_safe(), and because of that
> >    non-zero value it tries to commit the transaction using a handle with
> >    a NULL ->block_rsv and a non-zero ->bytes_reserved value. This makes
> >    the transaction commit hit an assertion failure at
> >    btrfs_trans_release_metadata() because ->bytes_reserved is not zero but
> >    the ->block_rsv is NULL. The produced stack trace for that is like the
> >    following:
> >
> >    [192922.917158] assertion failed: !trans->bytes_reserved, file: fs/btrfs/transaction.c, line: 816
> >    [192922.917553] ------------[ cut here ]------------
> >    [192922.917922] kernel BUG at fs/btrfs/ctree.h:3532!
> >    [192922.918310] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
> >    [192922.918666] CPU: 2 PID: 883 Comm: fsstress Tainted: G        W         5.1.4-btrfs-next-47 #1
> >    [192922.919035] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
> >    [192922.919801] RIP: 0010:assfail.constprop.25+0x18/0x1a [btrfs]
> >    (...)
> >    [192922.920925] RSP: 0018:ffffaebdc8a27da8 EFLAGS: 00010286
> >    [192922.921315] RAX: 0000000000000051 RBX: ffff95c9c16a41c0 RCX: 0000000000000000
> >    [192922.921692] RDX: 0000000000000000 RSI: ffff95cab6b16838 RDI: ffff95cab6b16838
> >    [192922.922066] RBP: ffff95c9c16a41c0 R08: 0000000000000000 R09: 0000000000000000
> >    [192922.922442] R10: ffffaebdc8a27e70 R11: 0000000000000000 R12: ffff95ca731a0980
> >    [192922.922820] R13: 0000000000000000 R14: ffff95ca84c73338 R15: ffff95ca731a0ea8
> >    [192922.923200] FS:  00007f337eda4e80(0000) GS:ffff95cab6b00000(0000) knlGS:0000000000000000
> >    [192922.923579] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >    [192922.923948] CR2: 00007f337edad000 CR3: 00000001e00f6002 CR4: 00000000003606e0
> >    [192922.924329] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >    [192922.924711] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >    [192922.925105] Call Trace:
> >    [192922.925505]  btrfs_trans_release_metadata+0x10c/0x170 [btrfs]
> >    [192922.925911]  btrfs_commit_transaction+0x3e/0xaf0 [btrfs]
> >    [192922.926324]  btrfs_sync_file+0x44c/0x490 [btrfs]
> >    [192922.926731]  do_fsync+0x38/0x60
> >    [192922.927138]  __x64_sys_fdatasync+0x13/0x20
> >    [192922.927543]  do_syscall_64+0x60/0x1c0
> >    [192922.927939]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >    (...)
> >    [192922.934077] ---[ end trace f00808b12068168f ]---
> >
> > 2) If evict_refill_and_join() decides to commit the transaction, it will
> >    be able to do it, since the nested transaction join only increments the
> >    transaction handle's ->use_count reference counter and it does not
> >    prevent the transaction from getting committed. This means that after
>
> This brings up a good point, we should probably not allow the commit in this
> case, or add an ASSERT(use_count == 1) or something, cause this would be bad.
> Thanks,

Yes, that should be separate change however.
I had warn_on(trans->use_count > 1) in the commit locally during
testing (didn't trigger in 4 days of fstests).

Thanks.
>
> Josef
