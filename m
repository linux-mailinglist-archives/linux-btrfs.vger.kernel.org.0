Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5181F7AB97D
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 20:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjIVSoJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 14:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjIVSoI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 14:44:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41CAC2
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 11:44:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93407C433C7
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 18:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695408241;
        bh=v3O8q3hevQYYF2GFKMcsiHsWfLf0d9/7YMlG3x1BiX8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qYNQiyOP3TUqctsSd0bb4kXWiCWVgZnllQrfKNr+moPmx7E7Nx1pk+9od31j5Dffw
         FiJwMCs2uBPBaOrx4d8funxKnx2rBvNqlMCRG64HRdtaX9SxWGrwk/+Xlb5R5lhDkt
         DcUnkvgaL5k8fS+y/qKzJv8vSqBRWoPVJDmyt3+tv9qbtf91X3Ez6vx8jZJysZmv4c
         tVd+lyP+CR4Okqg55b5eu53+rkOiyHHfi12IL3Rx9r60e6lSMHIyJiZekjsdCxkG2Z
         nW1XLUHkHSfzI2VbLhTrJ1qujSecc7sr3K4/b0ClkUhBT7Ps3BGfSqhYGZVCZ5uD04
         f7rdUOHbQB8JA==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-57b9193b1aeso347706eaf.0
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 11:44:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YylzQJ5U1NJsO4IBM9Dbrfj7wsGUOt7cWCZNZdJgfb9qh02rkIT
        ZDKN79LH2hMAKBngxy3b5aYdMbaXoIb99t+/vOs=
X-Google-Smtp-Source: AGHT+IHd8amT7kiFlioI9/X98KDHDqq4TbTOJGqqyVsBizsqfSJlzfFrHC0n/paBhE0D3RWaP1SlnHoK0lSHMtoaG+w=
X-Received: by 2002:a05:6870:2328:b0:1d5:cdf7:bdbc with SMTP id
 w40-20020a056870232800b001d5cdf7bdbcmr341800oao.2.1695408240831; Fri, 22 Sep
 2023 11:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695333278.git.fdmanana@suse.com> <20230922181807.GG13697@twin.jikos.cz>
In-Reply-To: <20230922181807.GG13697@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 22 Sep 2023 19:43:24 +0100
X-Gmail-Original-Message-ID: <CAL3q7H62P3h3ABOXn2HjqQ3ZwBp1XBhHqbXsQnktrfHZCyGMMQ@mail.gmail.com>
Message-ID: <CAL3q7H62P3h3ABOXn2HjqQ3ZwBp1XBhHqbXsQnktrfHZCyGMMQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] btrfs: some speedups for io tree operations and cleanups
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 22, 2023 at 7:24=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Fri, Sep 22, 2023 at 11:39:01AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > These are some changes to make some io tree operations more efficient a=
nd
> > some cleanups. More details on the changelogs.
> >
> > Filipe Manana (8):
> >   btrfs: make extent state merges more efficient during insertions
> >   btrfs: update stale comment at extent_io_tree_release()
> >   btrfs: make wait_extent_bit() static
> >   btrfs: remove pointless memory barrier from extent_io_tree_release()
> >   btrfs: collapse wait_on_state() to its caller wait_extent_bit()
> >   btrfs: make extent_io_tree_release() more efficient
> >   btrfs: use extent_io_tree_release() to empty dirty log pages
> >   btrfs: make sure we cache next state in find_first_extent_bit()
>
> I see a lot of reports like:
>
> btrfs/004        [16:14:23][  468.732077] run fstests btrfs/004 at 2023-0=
9-22 16:14:24
> [  470.921989] BTRFS: device fsid f7d57de2-899a-4b33-b77a-084058ac36e9 de=
vid 1 transid 11 /dev/vda scanned by mount (31993)
> [  470.926438] BTRFS info (device vda): using crc32c (crc32c-generic) che=
cksum algorithm
> [  470.928013] BTRFS info (device vda): using free space tree
> [  470.952723] BTRFS info (device vda): auto enabling async discard
> [  472.385556] BTRFS: device fsid 097a012d-8e9b-4bd8-960d-87577821cbbe de=
vid 1 transid 6 /dev/vdb scanned by mount (32061)
> [  472.395192] BTRFS info (device vdb): using crc32c (crc32c-generic) che=
cksum algorithm
> [  472.398895] BTRFS info (device vdb): using free space tree
> [  472.438755] BTRFS info (device vdb): auto enabling async discard
> [  472.440900] BTRFS info (device vdb): checking UUID tree
> [  472.534254] BUG: sleeping function called from invalid context at fs/b=
trfs/extent-io-tree.c:132
> [  472.539305] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 320=
79, name: fsstress
> [  472.542685] preempt_count: 1, expected: 0
> [  472.543641] RCU nest depth: 0, expected: 0
> [  472.544778] 6 locks held by fsstress/32079:
> [  472.546916]  #0: ffff888017ad4648 (sb_internal#2){.+.+}-{0:0}, at: btr=
fs_sync_file+0x594/0xa20 [btrfs]
> [  472.551474]  #1: ffff888014c72790 (btrfs_trans_completed){.+.+}-{0:0},=
 at: btrfs_commit_transaction+0x840/0x1580 [btrfs]
> [  472.556334]  #2: ffff888014c72760 (btrfs_trans_super_committed){.+.+}-=
{0:0}, at: btrfs_commit_transaction+0x840/0x1580 [btrfs]
> [  472.561372]  #3: ffff888014c72730 (btrfs_trans_unblocked){++++}-{0:0},=
 at: btrfs_commit_transaction+0x840/0x1580 [btrfs]
> [  472.565793]  #4: ffff888014c70de0 (&fs_info->reloc_mutex){+.+.}-{3:3},=
 at: btrfs_commit_transaction+0x8ed/0x1580 [btrfs]
> [  472.569931]  #5: ffff88802ec1c248 (&tree->lock#2){+.+.}-{2:2}, at: ext=
ent_io_tree_release+0x1c/0x120 [btrfs]
> [  472.573099] Preemption disabled at:
> [  472.573110] [<0000000000000000>] 0x0
> [  472.575200] CPU: 0 PID: 32079 Comm: fsstress Not tainted 6.6.0-rc2-def=
ault+ #2197
> [  472.577440] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
> [  472.580902] Call Trace:
> [  472.581738]  <TASK>
> [  472.582480]  dump_stack_lvl+0x60/0x70
> [  472.583621]  __might_resched+0x224/0x360
> [  472.584591]  extent_io_tree_release+0xa5/0x120 [btrfs]
> [  472.585864]  free_log_tree+0xec/0x250 [btrfs]
> [  472.587007]  ? walk_log_tree+0x4a0/0x4a0 [btrfs]
> [  472.588116]  ? reacquire_held_locks+0x280/0x280
> [  472.589104]  ? btrfs_log_holes+0x430/0x430 [btrfs]
> [  472.590296]  ? node_tag_clear+0xf4/0x160
> [  472.591292]  btrfs_free_log+0x2c/0x60 [btrfs]
> [  472.592468]  commit_fs_roots+0x1e0/0x440 [btrfs]
> [  472.593569]  ? __lock_release.isra.0+0x14e/0x510
> [  472.594470]  ? percpu_up_read+0xe0/0xe0 [btrfs]
> [  472.595496]  ? btrfs_run_delayed_refs+0xf6/0x180 [btrfs]
> [  472.596758]  ? btrfs_assert_delayed_root_empty+0x2d/0xd0 [btrfs]
> [  472.598077]  ? btrfs_commit_transaction+0x932/0x1580 [btrfs]
> [  472.599437]  btrfs_commit_transaction+0x94e/0x1580 [btrfs]
> [  472.600845]  ? cleanup_transaction+0x650/0x650 [btrfs]
> [  472.602164]  ? preempt_count_sub+0x18/0xc0
> [  472.603111]  ? __rcu_read_unlock+0x67/0x90
> [  472.604011]  ? preempt_count_add+0x71/0xd0
> [  472.604840]  ? preempt_count_sub+0x18/0xc0
> [  472.605664]  ? preempt_count_add+0x71/0xd0
> [  472.606454]  ? preempt_count_sub+0x18/0xc0
> [  472.607251]  ? __up_write+0x125/0x300
> [  472.608059]  btrfs_sync_file+0x794/0xa20 [btrfs]
> [  472.609105]  ? start_ordered_ops.constprop.0+0xd0/0xd0 [btrfs]
> [  472.610392]  ? mark_held_locks+0x1a/0x80
> [  472.611179]  __x64_sys_fdatasync+0x70/0xb0
> [  472.614054]  do_syscall_64+0x3d/0x90
> [  472.614584]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [  472.615522] RIP: 0033:0x7f9bbbe983d4
>
>  115 void extent_io_tree_release(struct extent_io_tree *tree)
>  116 {
>  117         struct extent_state *state;
>  118         struct extent_state *tmp;
>  119
>  120         spin_lock(&tree->lock);
>  121         rbtree_postorder_for_each_entry_safe(state, tmp, &tree->stat=
e, rb_node) {
>  122                 /* Clear node to keep free_extent_state() happy. */
>  123                 RB_CLEAR_NODE(&state->rb_node);
>  124                 ASSERT(!(state->state & EXTENT_LOCKED));
>  125                 /*
>  126                  * No need for a memory barrier here, as we are hold=
ing the tree
>  127                  * lock and we only change the waitqueue while holdi=
ng that lock
>  128                  * (see wait_extent_bit()).
>  129                  */
>  130                 ASSERT(!waitqueue_active(&state->wq));
>  131                 free_extent_state(state);
>  132                 cond_resched();
>  ^^^
>
> should be cond_resched_lock() as it's under spinlock but then I'm not
> sure if relocking is still safe in the middle of the tree traversal.

cond_resched_lock() works here under the assumption that at this point no o=
ther
tasks access the tree (as documented in an earlier patch) - if the
assumption is broken in
the future, then another task can access a node that was freed before
the cond_resched_lock()
call and result in a use-after-free or other weird issues.

But I think it's best to remove the cond_resched() call. I removed it
and then added it again
but didn't think properly and ran on a vm without several debugging
configs turned on, likely
why I didn't get that splat.

Do you want me to send a v2 with the cond_resched() line deleted?

Thanks.

>
>  133         }
>  134         tree->state =3D RB_ROOT;
>  135         spin_unlock(&tree->lock);
>  136 }
