Return-Path: <linux-btrfs+bounces-10552-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 977CF9F653E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 12:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEF3160C87
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 11:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDCF1A2399;
	Wed, 18 Dec 2024 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbiQfetw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAEA1A23A1
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734522353; cv=none; b=kqu+7pPjqFMjQ0xEBGiZgshmUKUc8BQEX/E4Hizpc82wzxpPEobY07gAXtuIVCzjV8NQJCPJ65C3BMa2BCLXilnykS+P9XaBirJc9IEpCYhdihQZuJo0VFUy9EFOlLlMGbhSpGmVeokXDuvASglWRGLxk0WTcFMf/5E5qxQlBd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734522353; c=relaxed/simple;
	bh=bJgqOe09e3xkjkKWnbwZkkRxwbV3Tgrxz2MoPE2AsjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9Dwo3/G+fnv4wnUHRJhJQEnjwUv4Ir0eI7He4MRWaTdp8KEEvCsqpaVehx6sboOiSpLY7fJfkATmuxVr7Bi8nh5TIMC801wvFzzZHB92wppi6blf4fZpNmarxc+BCdg4aUqBLSNn1NTk2R1+Zw8SJlTUSXnIyNLQGggHTzOxz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbiQfetw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2295C4CECE
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 11:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734522352;
	bh=bJgqOe09e3xkjkKWnbwZkkRxwbV3Tgrxz2MoPE2AsjY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NbiQfetwcG53JqA2z3BUMIE62BcTdCiXM7ccI4q2O/9IiVTClM6Zgmafi9jXpgOfh
	 nFlK9feL0+lHPezS+ZOWXJ3FugnHMOLl0i5DN29Q6qE+OtE+qnzSFUl6lCeawLHiiW
	 bzGWsn34ey7jdCbBKdpkpdNUIr+5tggxkFByy3dtrqG3CH23ljuO9ycaZqKCpQh5rb
	 N2tsudUnxYikK4tDpqMEFKEBVMGEOW4Je+Ds268i9IHE14cIR/PVME6xGyzWmBrx/5
	 vabxsOsokuqd10nvJAfyn80rgw8Je82BksAR47BrgoTJNYPkB5OyDEtkO6mKtUJn8e
	 NwQUQ1e462t9Q==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a68480164so1033690166b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 03:45:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXVsLnA9Jfpd49pgsFwjLzmgl56G96H97N0kAkpvUh4Js6xoO4XAxuZJN8DNybYaMJF0SLI4iS+kzXQFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YywWcwX0fGj56+H0P/+6iQ+WQbqVKlcIjWN3NLkPdAKxwjXmQPS
	+X5I+qowG2dv6cWYUoQ5J1Grf6oNUitlV91g9DeiGLZpKmx+bx6iVGpQCOv+hoi42yobYLZ0FRe
	dCMnZBmEXq1i5X7MUSCPfa67yXB8=
X-Google-Smtp-Source: AGHT+IE7tSBbNLzez0a/oTEkdJCCBcusFdbU+XR++IZiY/sdvIkJ9h5y0/x2xXAin+onQnwtkoqstvUgLtbGYj4bpxc=
X-Received: by 2002:a17:907:728c:b0:aa6:a501:7c2f with SMTP id
 a640c23a62f3a-aabf4788676mr233676966b.27.1734522351217; Wed, 18 Dec 2024
 03:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <58dac27acbab72124549718201bec971491b5b1a.1734420572.git.wqu@suse.com>
 <CAL3q7H7xPN+w4xYWaDUceYDZTot5Nab3V19afhnfko3w6A74Fw@mail.gmail.com>
 <0509f570-3ff8-498e-9cc5-9b45d56fff2c@suse.com> <CAL3q7H5c8oYYBuhEQg8xo=MyA9pGhYnq-42FoS1usHgVBbTK-A@mail.gmail.com>
 <b5671e8c-295e-4ca3-b2b3-65495ffa1894@gmx.com>
In-Reply-To: <b5671e8c-295e-4ca3-b2b3-65495ffa1894@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 18 Dec 2024 11:45:14 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4JtteM6WhbrR4=+85EvBxk9Tw2rJzjHy8sjdwmmj2UEA@mail.gmail.com>
Message-ID: <CAL3q7H4JtteM6WhbrR4=+85EvBxk9Tw2rJzjHy8sjdwmmj2UEA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: handle free space tree rebuild in multiple transactions
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 8:38=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/12/17 21:06, Filipe Manana =E5=86=99=E9=81=93:
> > On Tue, Dec 17, 2024 at 9:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/12/17 19:15, Filipe Manana =E5=86=99=E9=81=93:
> >>> On Tue, Dec 17, 2024 at 7:31=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrot=
e:
> >>>>
> >>>> During free space tree rebuild, we're holding on transaction handler=
 for
> >>>> the whole rebuild process.
> >>>>
> >>>> This will cause blocked task warning for btrfs-transaction kernel
> >>>> thread, as during the rebuild, btrfs-transaction kthread has to wait=
 for
> >>>> the running transaction we're holding for free space tree rebuild.
> >>>
> >>> Do you have a stack trace?
> >>> Does that happen where exactly, in the btrfs_attach_transaction() cal=
l
> >>> chain, while waiting on a wait queue?
> >>
> >> Unfortunately no, thus it's only based on code analyze.
> >>
> >> The original reporter's stack are not related to free space cache
> >> rebuild, but on metadata writeback wait:
> >>
> >> [101497.950425] INFO: task btrfs-transacti:29385 blocked for more than
> >> 122 seconds.
> >> [101497.950432]       Tainted: G        W  O       6.12.3-gentoo-x86_6=
4 #1
> >> [101497.950435] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> >> disables this message.
> >> [101497.950437] task:btrfs-transacti state:D stack:0     pid:29385
> >> tgid:29385 ppid:2      flags:0x00004000
> >> [101497.950442] Call Trace:
> >> [101497.950444]  <TASK>
> >> [101497.950449]  __schedule+0x3f0/0xbd0
> >> [101497.950458]  schedule+0x27/0xf0
> >> [101497.950461]  io_schedule+0x46/0x70
> >> [101497.950465]  folio_wait_bit_common+0x123/0x340
> >> [101497.950472]  ? __pfx_wake_page_function+0x10/0x10
> >> [101497.950477]  folio_wait_writeback+0x2b/0x80
> >> [101497.950480]  __filemap_fdatawait_range+0x7d/0xd0
> >> [101497.950489]  filemap_fdatawait_range+0x12/0x20
> >> [101497.950493]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]
> >> [101497.950536]  btrfs_write_and_wait_transaction+0x5e/0xd0 [btrfs]
> >> [101497.950572]  btrfs_commit_transaction+0x8d9/0xe80 [btrfs]
> >> [101497.950606]  ? start_transaction+0xc0/0x820 [btrfs]
> >> [101497.950640]  transaction_kthread+0x159/0x1c0 [btrfs]
> >> [101497.950674]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
> >> [101497.950705]  kthread+0xd2/0x100
> >> [101497.950710]  ? __pfx_kthread+0x10/0x10
> >> [101497.950714]  ret_from_fork+0x34/0x50
> >> [101497.950718]  ? __pfx_kthread+0x10/0x10
> >> [101497.950721]  ret_from_fork_asm+0x1a/0x30
> >> [101497.950727]  </TASK>
> >>
> >> Furthermore, the original reporter doesn't experience real hang.
> >> The operation can finish (very large stream receive), sync and properl=
y
> >> unmount.
> >> I believe the original report is mostly caused by the following reason=
s:
> >>
> >> - Too large physical RAM
> >>     96GiB, causing too huge page cache
> >>
> >> - HDD
> >>     Low IOPS
> >>
> >> - Mostly random metadata writes?
> >
> > Looking at that trace, I don't see how this change relates to it.
> > That is, how this batching helps prevent that.
>
> Exactly, this batching fix is unrelated to the report, just as I said.

So I think this batch thing is not really appropriate:

1) There's the thing about the space reservation mentioned earlier;

2) Picking 32 or any other number may result in unnecessary churn by
calling end_transaction() / star_transaction() too often,
   as we're likely to be able to process much more than 32 block
groups before the transaction kthread attempts to
   commit the transaction.

Instead of that, just periodically call
btrfs_should_end_transaction(), and release the handle and start a new
one if it returns true.

This is all we need since it returns true when the transaction kthread
attempts to start the commit (state set to TRANS_STATE_COMMIT_START).
This way the kthread won't wait for potentially too long in the
transaction's wait queue and trigger any warning about being blocked
for too long.

Thanks.


>
> Thanks,
> Qu
> >
> > That happens when committing a transaction and we're in the unblocked
> > transaction state, starting writeback of the metadata extents and
> > waiting for the writeback to finish.
> >
> > Since the free space tree build code uses the same transaction handle
> > to build the whole free space tree,
> > the transaction kthread would block when calling
> > btrfs_commit_transaction(), waiting for the free space tree build task
> > to release its handle - but that's not what is happening here.
> >
> > The transaction kthread is doing the commit, and already in the
> > unblocked transaction state, writing all dirty metadata extents.
> > So that means it's not getting blocked by free tree build task holding
> > a transaction handle - it may be holding a transaction handle open,
> > but it's a different transaction already, since when the current
> > transaction is in a state >=3D TRANS_STATE_UNBLOCKED, other tasks can
> > start a new transaction.
> >
> > And each transaction has its own io tree to keep track of the metadata
> > extents it created/dirtied (trans->transaction->dirty_pages),
> > so even if the task building the free space tree keeps COWing and
> > creating free space tree nodes/leaves, it doesn't affect the io tree
> > of the
> > committing transaction - these extent buffers will be written by the
> > transaction used by the free space tree build task when it commits,
> > and not by the one being committed by the transaction kthread.
> >
> > We should have the stack trace in the change log, a link to the
> > reporter's thread and an explanation of how this batching helps
> > anything - I don't see how, as explained above.
> >
> > Thanks.
> >
> >
> >>
> >>>
> >>>>
> >>>> On a large enough btrfs, we have thousands of block groups to go
> >>>> through, thus it will definitely take over 120s and trigger the bloc=
ked
> >>>> task warning.
> >>>>
> >>>> Fix the problem by handling 32 block groups in one transaction, and =
end
> >>>> the transaction when we hit the 32 block groups threshold.
> >>>>
> >>>> This will allow the btrfs-transaction kthread to commit the transact=
ion
> >>>> when needed.
> >>>>
> >>>> And even if during the rebuild the system lost its power, we are sti=
ll
> >>>> fine as we didn't set FREE_SPACE_TREE_VALID flag, thus on next RW mo=
unt
> >>>> we will still rebuild the tree, without utilizing the half built one=
.
> >>>
> >>> What about if a crash happens and we already processed some block
> >>> groups and the transaction got committed?
> >>>
> >>> On the next mount, when we call populate_free_space_tree() for the
> >>> same block groups, because we always start from the first one, won't
> >>> we get an -EEXIST and fail the mount?
> >>> For example, add_new_free_space_info() doesn't ignore an -EEXIST when
> >>> it calls btrfs_insert_empty_item(), so we will fail the mount when
> >>> trying to build the tree.
> >>
> >> We are still fine:
> >>
> >> btrfs_start_pre_rw_mount()
> >> |- rebuild_free_space_tree =3D true;
> >> |  This is because our fs only has FREE_SPACE_TREE, but no
> >> |  FREE_SPACE_TREE_VALID compat_ro flag.
> >> |
> >> |- btrfs_rebuild_free_space_tree()
> >>      |- clear_free_space_tree()
> >>         Which deletes all the free space tree items.
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>>>
> >>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>>> ---
> >>>>    fs/btrfs/free-space-tree.c | 12 ++++++++++++
> >>>>    1 file changed, 12 insertions(+)
> >>>>
> >>>> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> >>>> index 7ba50e133921..d8f334724092 100644
> >>>> --- a/fs/btrfs/free-space-tree.c
> >>>> +++ b/fs/btrfs/free-space-tree.c
> >>>> @@ -1312,6 +1312,8 @@ int btrfs_delete_free_space_tree(struct btrfs_=
fs_info *fs_info)
> >>>>           return btrfs_commit_transaction(trans);
> >>>>    }
> >>>>
> >>>> +/* How many block groups can be handled in one transaction. */
> >>>> +#define FREE_SPACE_TREE_REBUILD_BATCH  (32)
> >>>>    int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
> >>>
> >>> Please put a blank line after the macro declaration and place the
> >>> macro at the top of the file before the C code.
> >>>
> >>>>    {
> >>>>           struct btrfs_trans_handle *trans;
> >>>> @@ -1322,6 +1324,7 @@ int btrfs_rebuild_free_space_tree(struct btrfs=
_fs_info *fs_info)
> >>>>           };
> >>>>           struct btrfs_root *free_space_root =3D btrfs_global_root(f=
s_info, &key);
> >>>>           struct rb_node *node;
> >>>> +       unsigned int handled =3D 0;
> >>>>           int ret;
> >>>>
> >>>>           trans =3D btrfs_start_transaction(free_space_root, 1);
> >>>> @@ -1350,6 +1353,15 @@ int btrfs_rebuild_free_space_tree(struct btrf=
s_fs_info *fs_info)
> >>>>                           btrfs_end_transaction(trans);
> >>>>                           return ret;
> >>>>                   }
> >>>> +               handled++;
> >>>> +               handled %=3D FREE_SPACE_TREE_REBUILD_BATCH;
> >>>> +               if (!handled) {
> >>>> +                       btrfs_end_transaction(trans);
> >>>> +                       trans =3D btrfs_start_transaction(free_space=
_root,
> >>>> +                                       FREE_SPACE_TREE_REBUILD_BATC=
H);
> >>>
> >>> This is a fundamental change here, we are no longer reserving 1 unit
> >>> but 32 instead.
> >>> Plus the first call to btrfs_start_transaction(), before entering the
> >>> loop, uses 1.
> >>> For consistency, both places should reserve the same amount.
> >>>
> >>> But I think that changing the amount of reserved space should be a
> >>> separate change with its own changelog,
> >>> providing a rationale for it.
> >>>
> >>> It's odd indeed that only 1 item is being reserved, but on the other
> >>> hand the block reserve associated with the free space tree root is th=
e
> >>> delayed refs reserve (see btrfs_init_root_block_rsv()),
> >>> so changing the number of units passed to btrfs_start_transaction()
> >>> shouldn't make much difference because the space reserved by a
> >>> transaction goes to the transaction block reserve
> >>> (fs_info->trans_block_rsv).
> >>>
> >>> And given that free space tree build/rebuild only touches the free
> >>> space tree root, I don't see how that makes any difference, or at
> >>> least it's not trivial, hence the separate change only for the space
> >>> reservation
> >>> amount and an explanation about why we are doing it.
> >>>
> >>> Thanks.
> >>>
> >>>
> >>>> +                       if (IS_ERR(trans))
> >>>> +                               return PTR_ERR(trans);
> >>>> +               }
> >>>>                   node =3D rb_next(node);
> >>>>           }
> >>>>
> >>>> --
> >>>> 2.47.1
> >>>>
> >>>>
> >>
> >
>

