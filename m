Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 106F3B0DBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 13:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbfILLYu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 07:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731139AbfILLYu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 07:24:50 -0400
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 569E82081B
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 11:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568287488;
        bh=52ZrdvN9umHv0BYMf+FPkxH8Nzgr4j2n/VhVG0par+g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cYAXvGPBmIIUi9ft/7pQrhry4ee3YNLq2snELCFMVwxrKvbfL/zhmD5iUxh2l2SBP
         APT3hVc/tkWqNj93cTPv9YQV6fs4RzqNU5aLobXnsA0W5Y/7djXNlYNmoFLjjuycrL
         u2d3IPKowDjFofOslKaHEdqH2KZcy4leZ8FY52to=
Received: by mail-vk1-f176.google.com with SMTP id d66so5068530vka.2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 04:24:48 -0700 (PDT)
X-Gm-Message-State: APjAAAWSAG63Hu046hN+lQR7kHtfEbtKybKus4rKp+soTsbugW4lnCWB
        44dbDE3DCFZ+7oFwC742ZeG60nHBtMmKxRDElec=
X-Google-Smtp-Source: APXvYqw7bHWFPVY3wiLAO/T9FaSTZpy7bJ8GfyMq22WK5V2iyqPQoZcBTBds/HPlGt+mYv5+SfTM2P0cmNejaLzNvtk=
X-Received: by 2002:a1f:f2cd:: with SMTP id q196mr19419877vkh.31.1568287487360;
 Thu, 12 Sep 2019 04:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190910142649.19808-1-fdmanana@kernel.org> <b171e10f-6f1f-4711-4fa6-67e2ffbe8378@suse.com>
In-Reply-To: <b171e10f-6f1f-4711-4fa6-67e2ffbe8378@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 12 Sep 2019 12:24:36 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7-ARvEp+gXE6XYK3KRLuwYO8HdSP_0C+fW5ekCE8-goQ@mail.gmail.com>
Message-ID: <CAL3q7H7-ARvEp+gXE6XYK3KRLuwYO8HdSP_0C+fW5ekCE8-goQ@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: fix assertion failure during fsync and use of
 stale transaction
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 12:10 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 10.09.19 =D0=B3. 17:26 =D1=87., fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Sometimes when fsync'ing a file we need to log that other inodes exist =
and
> > when we need to do that we acquire a reference on the inodes and then d=
rop
> > that reference using iput() after logging them.
> >
> > That generally is not a problem except if we end up doing the final ipu=
t()
> > (dropping the last reference) on the inode and that inode has a link co=
unt
> > of 0, which can happen in a very short time window if the logging path
> > gets a reference on the inode while it's being unlinked.
> >
> > In that case we end up getting the eviction callback, btrfs_evict_inode=
(),
> > invoked through the iput() call chain which needs to drop all of the
> > inode's items from its subvolume btree, and in order to do that, it nee=
ds
> > to join a transaction at the helper function evict_refill_and_join().
> > However because the task previously started a transaction at the fsync
> > handler, btrfs_sync_file(), it has current->journal_info already pointi=
ng
> > to a transaction handle and therefore evict_refill_and_join() will get
> > that transaction handle from btrfs_join_transaction(). From this point =
on,
> > two different problems can happen:
> >
> > 1) evict_refill_and_join() will often change the transaction handle's
> >    block reserve (->block_rsv) and set its ->bytes_reserved field to a
> >    value greater than 0. If evict_refill_and_join() never commits the
> >    transaction, the eviction handler ends up decreasing the reference
> >    count (->use_count) of the transaction handle through the call to
> >    btrfs_end_transaction(), and after that point we have a transaction
> >    handle with a NULL ->block_rsv (which is the value prior to the
> >    transaction join from evict_refill_and_join()) and a ->bytes_reserve=
d
> >    value greater than 0. If after the eviction/iput completes the inode
> >    logging path hits an error or it decides that it must fallback to a
> >    transaction commit, the btrfs fsync handle, btrfs_sync_file(), gets =
a
> >    non-zero value from btrfs_log_dentry_safe(), and because of that
> >    non-zero value it tries to commit the transaction using a handle wit=
h
> >    a NULL ->block_rsv and a non-zero ->bytes_reserved value. This makes
> >    the transaction commit hit an assertion failure at
> >    btrfs_trans_release_metadata() because ->bytes_reserved is not zero =
but
> >    the ->block_rsv is NULL. The produced stack trace for that is like t=
he
> >    following:
> >
> >    [192922.917158] assertion failed: !trans->bytes_reserved, file: fs/b=
trfs/transaction.c, line: 816
> >    [192922.917553] ------------[ cut here ]------------
> >    [192922.917922] kernel BUG at fs/btrfs/ctree.h:3532!
> >    [192922.918310] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
> >    [192922.918666] CPU: 2 PID: 883 Comm: fsstress Tainted: G        W  =
       5.1.4-btrfs-next-47 #1
> >    [192922.919035] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
> >    [192922.919801] RIP: 0010:assfail.constprop.25+0x18/0x1a [btrfs]
> >    (...)
> >    [192922.920925] RSP: 0018:ffffaebdc8a27da8 EFLAGS: 00010286
> >    [192922.921315] RAX: 0000000000000051 RBX: ffff95c9c16a41c0 RCX: 000=
0000000000000
> >    [192922.921692] RDX: 0000000000000000 RSI: ffff95cab6b16838 RDI: fff=
f95cab6b16838
> >    [192922.922066] RBP: ffff95c9c16a41c0 R08: 0000000000000000 R09: 000=
0000000000000
> >    [192922.922442] R10: ffffaebdc8a27e70 R11: 0000000000000000 R12: fff=
f95ca731a0980
> >    [192922.922820] R13: 0000000000000000 R14: ffff95ca84c73338 R15: fff=
f95ca731a0ea8
> >    [192922.923200] FS:  00007f337eda4e80(0000) GS:ffff95cab6b00000(0000=
) knlGS:0000000000000000
> >    [192922.923579] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >    [192922.923948] CR2: 00007f337edad000 CR3: 00000001e00f6002 CR4: 000=
00000003606e0
> >    [192922.924329] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
> >    [192922.924711] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
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
> > 2) If evict_refill_and_join() decides to commit the transaction, it wil=
l
> evict_refill_and_join only ever calls btrfs_join_transaction so it
> cannot ever commit the transaction.

It can:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/=
btrfs/inode.c?h=3Dv5.3-rc8#n5399

>  Let's look into its sole caller,
> btrfs_evict_inode, I see 3 cases where transactions handle is involved
> in that function:
>
> 1. btrfs_commit_inode_delayed_inode - iot calls trans_join +
> end_transaction =3D> use_count =3D 2 -> no commit
>
> 2. btrfs_truncate_inode_items -> never calls end/commit transaction
>
> 3. btrfs_evict_inode itself only ever calls btrfs_end_transaction on a
> handle that's obtained via btrfs_join_transaction, meaning that trans
> handle's ->use_count will be 2. This in turn will hit:
>
>  if (refcount_read(&trans->use_count) > 1) {
>                   refcount_dec(&trans->use_count);
>
>                   trans->block_rsv =3D trans->orig_rsv;
>
>                   return 0;
>
> }
>
> in __btrfs_end_transaction. That code is in direct contradiction with
> what you describe next?

No, it isn't.

I explicitly mention it in point 1):

"... the eviction handler ends up decreasing the reference
count (->use_count) of the transaction handle through the call to
btrfs_end_transaction(), and after that point we have a transaction
handle with a NULL ->block_rsv (which is the value prior to the
transaction join from evict_refill_and_join()) and a ->bytes_reserved
value greater than 0."


>  Am I missing something here? If my analysis is
> correct this implies case 1) above also cannot happen because
> trans->block_rsv is set to NULL in __btrfs_end_transaction only if
> use_count =3D=3D 1.

Again, go read the change log and the code more carefully.

Thanks.

>
> >    be able to do it, since the nested transaction join only increments =
the
> >    transaction handle's ->use_count reference counter and it does not
> >    prevent the transaction from getting committed. This means that afte=
r
> >    eviction completes, the fsync logging path will be using a transacti=
on
> >    handle that refers to an already committed transaction. What happens
> >    when using such a stale transaction can be unpredictable, we are at
> >    least having a use-after-free on the transaction handle itself, sinc=
e
> >    the transaction commit will call kmem_cache_free() against the handl=
e
> >    regardless of its ->use_count value, or we can end up silently losin=
g
> >    all the updates to the log tree after that iput() in the logging pat=
h,
> >    or using a transaction handle that in the meanwhile was allocated to
> >    another task for a new transaction, etc, pretty much unpredictable
> >    what can happen.
> >
> > In order to fix both of them, instead of using iput() during logging, u=
se
> > btrfs_add_delayed_iput(), so that the logging path of fsync never drops
> > the last reference on an inode, that step is offloaded to a safe contex=
t
> > (usually the cleaner kthread).
> >
> > The assertion failure issue was sporadically triggered by the test case
> > generic/475 from fstests, which loads the dm error target while fsstres=
s
> > is running, which lead to fsync failing while logging inodes with -EIO
> > errors and then trying later to commit the transaction, triggering the
> > assertion failure.
> >
> > CC: stable@vger.kernel.org # 4.4+
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/tree-log.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 6c8297bcfeb7..1bfd7e34f31e 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -4985,7 +4985,7 @@ static int log_conflicting_inodes(struct btrfs_tr=
ans_handle *trans,
> >                                                     BTRFS_I(inode),
> >                                                     LOG_OTHER_INODE_ALL=
,
> >                                                     0, LLONG_MAX, ctx);
> > -                                     iput(inode);
> > +                                     btrfs_add_delayed_iput(inode);
> >                               }
> >                       }
> >                       continue;
> > @@ -5000,7 +5000,7 @@ static int log_conflicting_inodes(struct btrfs_tr=
ans_handle *trans,
> >               ret =3D btrfs_log_inode(trans, root, BTRFS_I(inode),
> >                                     LOG_OTHER_INODE, 0, LLONG_MAX, ctx)=
;
> >               if (ret) {
> > -                     iput(inode);
> > +                     btrfs_add_delayed_iput(inode);
> >                       continue;
> >               }
> >
> > @@ -5009,7 +5009,7 @@ static int log_conflicting_inodes(struct btrfs_tr=
ans_handle *trans,
> >               key.offset =3D 0;
> >               ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
> >               if (ret < 0) {
> > -                     iput(inode);
> > +                     btrfs_add_delayed_iput(inode);
> >                       continue;
> >               }
> >
> > @@ -5056,7 +5056,7 @@ static int log_conflicting_inodes(struct btrfs_tr=
ans_handle *trans,
> >                       }
> >                       path->slots[0]++;
> >               }
> > -             iput(inode);
> > +             btrfs_add_delayed_iput(inode);
> >       }
> >
> >       return ret;
> > @@ -5689,7 +5689,7 @@ static int log_new_dir_dentries(struct btrfs_tran=
s_handle *trans,
> >                       }
> >
> >                       if (btrfs_inode_in_log(BTRFS_I(di_inode), trans->=
transid)) {
> > -                             iput(di_inode);
> > +                             btrfs_add_delayed_iput(di_inode);
> >                               break;
> >                       }
> >
> > @@ -5701,7 +5701,7 @@ static int log_new_dir_dentries(struct btrfs_tran=
s_handle *trans,
> >                       if (!ret &&
> >                           btrfs_must_commit_transaction(trans, BTRFS_I(=
di_inode)))
> >                               ret =3D 1;
> > -                     iput(di_inode);
> > +                     btrfs_add_delayed_iput(di_inode);
> >                       if (ret)
> >                               goto next_dir_inode;
> >                       if (ctx->log_new_dentries) {
> > @@ -5848,7 +5848,7 @@ static int btrfs_log_all_parents(struct btrfs_tra=
ns_handle *trans,
> >                       if (!ret && ctx && ctx->log_new_dentries)
> >                               ret =3D log_new_dir_dentries(trans, root,
> >                                                  BTRFS_I(dir_inode), ct=
x);
> > -                     iput(dir_inode);
> > +                     btrfs_add_delayed_iput(dir_inode);
> >                       if (ret)
> >                               goto out;
> >               }
> > @@ -5891,7 +5891,7 @@ static int log_new_ancestors(struct btrfs_trans_h=
andle *trans,
> >                       ret =3D btrfs_log_inode(trans, root, BTRFS_I(inod=
e),
> >                                             LOG_INODE_EXISTS,
> >                                             0, LLONG_MAX, ctx);
> > -             iput(inode);
> > +             btrfs_add_delayed_iput(inode);
> >               if (ret)
> >                       return ret;
> >
> >
