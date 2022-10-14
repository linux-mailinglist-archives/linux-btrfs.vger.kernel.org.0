Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8DE5FEC74
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 12:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJNKU6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 06:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiJNKU5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 06:20:57 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECC56DFA5
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 03:20:55 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id j188so4561118oih.4
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 03:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HiWuYcyZVfHIRtIfeycbJrzvDe+EaOFjz79bj1aMe3E=;
        b=osTPparz+1O41YJTyPgi8IX5/TImmDREqKg5JgAyWgPDN1LveVr1op1GexOg8qaHNF
         xQ3SQkiWlgr/icsOnSF5ceyi/7WJngLfTpk0VagoBX8qTnZM98or6MtWq3fQj628h+m4
         cHE+FkciHm/RaV04989DXBga+/qNaCLpTWDUCcGr6zcfW6t6zuQfZ2PrT9BzK9uYMoZ0
         HnMNPFuET2056Q/Mk3Ekj7A8rhkgovgHbL4hOkHUCH1c+pzFlBeS8b+CUpb4X6cmO/u2
         R+IJKlMeiKjCPmvP1veoKDxHzoJRBa/MqyErPj4LhYnI2MZsh1AaCKwVvBFII4AsLJ9Y
         OTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiWuYcyZVfHIRtIfeycbJrzvDe+EaOFjz79bj1aMe3E=;
        b=HiaR24ZQAmW10v7iMvs4hBJGwcLME1epnHWnA7qfOJzQU7FvDHHXok5q+RVf9t23q6
         4vq7DUqq7xphhBoYV7JF5pw76m7oa+xNR6R7Gz9kKnZOUYsRu5hha76c0+XaWVul2tNC
         CBdjrG9B074d+54JGEx8OgU4e3OOv82GZHtXqaL7UDxs4DGRJ17d1a9+p9rLl7bQQ4eP
         aJoQzXWSM9/ycdTvE/3bZnAQdwBbkwve9MnYyRwkXDUncYBnZN2W1gtAwd3Y8rnW5PgX
         L5KT3nKsSmi29ntXHQ1r6jGGfvlrhH43E4rSd6t6AxoOO1iuxdKZGRvOifau/ZJhQbuj
         VaDw==
X-Gm-Message-State: ACrzQf1zYSZmuQvPr5aunkB6qiGAEyxfR8SPbE3AP9yB/m8KpE3ZTT2A
        sVCYc/AdvINGSZ8itMgZYt7sBdtmODjDt/hLe/8Fr1u05tc=
X-Google-Smtp-Source: AMsMyM7DPhvL+v/4JS1O6zLrYCHVzBx2Dc2217aWXhkj2zyPJfvVkxAcMGASWmcYKNh3YndC7zZ3q2vKB9mOJFqo2Qs=
X-Received: by 2002:a05:6808:1691:b0:351:48da:62e0 with SMTP id
 bb17-20020a056808169100b0035148da62e0mr2096178oib.98.1665742854862; Fri, 14
 Oct 2022 03:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <d1a5c1798d025cd81c4530b3640c8cf9861fd0dd.1665678770.git.josef@toxicpanda.com>
In-Reply-To: <d1a5c1798d025cd81c4530b3640c8cf9861fd0dd.1665678770.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 14 Oct 2022 11:20:18 +0100
Message-ID: <CAL3q7H7Bvvwwk_y_mc0zEM_jdtMkdzsp+FY35An8y9TVhnXcgg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix tree mod log mishandling of reallocated nodes
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 13, 2022 at 5:54 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> We have been seeing the following panic in production
>
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/tree-mod-log.c:677!
> invalid opcode: 0000 [#1] SMP
> RIP: 0010:tree_mod_log_rewind+0x1b4/0x200
> RSP: 0000:ffffc9002c02f890 EFLAGS: 00010293
> RAX: 0000000000000003 RBX: ffff8882b448c700 RCX: 0000000000000000
> RDX: 0000000000008000 RSI: 00000000000000a7 RDI: ffff88877d831c00
> RBP: 0000000000000002 R08: 000000000000009f R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000100c40 R12: 0000000000000001
> R13: ffff8886c26d6a00 R14: ffff88829f5424f8 R15: ffff88877d831a00
> FS:  00007fee1d80c780(0000) GS:ffff8890400c0000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fee1963a020 CR3: 0000000434f33002 CR4: 00000000007706e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  btrfs_get_old_root+0x12b/0x420
>  btrfs_search_old_slot+0x64/0x2f0
>  ? tree_mod_log_oldest_root+0x3d/0xf0
>  resolve_indirect_ref+0xfd/0x660
>  ? ulist_alloc+0x31/0x60
>  ? kmem_cache_alloc_trace+0x114/0x2c0
>  find_parent_nodes+0x97a/0x17e0
>  ? ulist_alloc+0x30/0x60
>  btrfs_find_all_roots_safe+0x97/0x150
>  iterate_extent_inodes+0x154/0x370
>  ? btrfs_search_path_in_tree+0x240/0x240
>  iterate_inodes_from_logical+0x98/0xd0
>  ? btrfs_search_path_in_tree+0x240/0x240
>  btrfs_ioctl_logical_to_ino+0xd9/0x180
>  btrfs_ioctl+0xe2/0x2ec0
>  ? __mod_memcg_lruvec_state+0x3d/0x280
>  ? do_sys_openat2+0x6d/0x140
>  ? kretprobe_dispatcher+0x47/0x70
>  ? kretprobe_rethook_handler+0x38/0x50
>  ? rethook_trampoline_handler+0x82/0x140
>  ? arch_rethook_trampoline_callback+0x3b/0x50
>  ? kmem_cache_free+0xfb/0x270
>  ? do_sys_openat2+0xd5/0x140
>  __x64_sys_ioctl+0x71/0xb0
>  do_syscall_64+0x2d/0x40
>
> Which is this code in tree_mod_log_rewind()
>
>         switch (tm->op) {
>         case BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING:
>                 BUG_ON(tm->slot < n);
>
> This occurs because we replay the nodes in order that they happened, and
> when we do a REPLACE we will log a REMOVE_WHILE_FREEING for every slot,
> starting at 0.  'n' here is the number of items in this block, which in
> this case was 1, but we had 2 REMOVE_WHILE_FREEING operations.
>
> The actual root cause of this was that we were replaying operations for
> a block that shouldn't have been replayed.  Consider the following
> sequence of events
>
> 1. We have an already modified root, and we do a btrfs_get_tree_mod_seq()=
.
> 2. We begin removing items from this root, triggering KEY_REPLACE for
>    it's child slots.
> 3. We remove one of the 2 children this root node points to, thus trigger=
ing
>    the root node promotion of the remaining child, and freeing this node.
> 4. We modify a new root, and re-allocate the above node to the root node =
of
>    this other root.
>
> The tree mod log looks something like this
>
>         logical 0       op KEY_REPLACE (slot 1)                 seq 2
>         logical 0       op KEY_REMOVE (slot 1)                  seq 3
>         logical 0       op KEY_REMOVE_WHILE_FREEING (slot 0)    seq 4
>         logical 4096    op LOG_ROOT_REPLACE (old logical 0)     seq 5
>         logical 8192    op KEY_REMOVE_WHILE_FREEING (slot 0)    seq 6
>         logical 8192    op KEY_REMOVE_WHILE_FREEING (slot 1)    seq 7
>         logical 0       op LOG_ROOT_REPLACE (old logical 8192)  seq 8
>
> From here the bug is triggered by the following steps
>
> 1. Call btrfs_get_old_root() on the new_root.
> 2. We call tree_mod_log_oldest_root(btrfs_root_node(new_root)), which is
>    currently logical 0.
> 3. tree_mod_log_oldest_root() calls tree_mod_log_search_oldest(), which
>    gives us the KEY_REPLACE seq 2, and since that's not a
>    LOG_ROOT_REPLACE we incorrectly believe that we don't have an old
>    root, because we expect that the most recent change should be a
>    LOG_ROOT_REPLACE.
> 4. Back in tree_mod_log_oldest_root() we don't have a LOG_ROOT_REPLACE,
>    so we don't set old_root, we simply use our existing extent buffer by
>    cloning it.
> 5. We call tree_mod_log_rewind() with the cloned extent buffer.

It wouldn't hurt here to say that before calling tree_mod_log_rewind() we c=
all
tree_mod_log_search() to get the most recent operation record for
logical 0 (with seq 8).

> 6. Set n =3D btrfs_header_nritems(logical 0), which would be whatever the
>    original nritems was when we cow'ed the original root, say for this
>    example it's 2.
> 7. We start from the newest operation and work our way forward, so we

We start from the newest operation due to that tree_mod_log_search() call d=
one
at btrfs_get_old_root(), after calling tree_mod_log_oldest_root().

>    see LOG_ROOT_REPLACE which we ignore.
> 8. Next we see KEY_REMOVE_WHILE_FREEING for slot 1, which triggers the

slot 0, not 1

At the very least with that slot correction:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>    BUG_ON(tm->slot < n), because it expects if we've done this we have a
>    completely empty extent buffer to replay completely.
>
> The correct thing would be to find the first LOG_ROOT_REPLACE, and then
> get the old_root set to logical 8192.  In fact making that change fixes
> this particular problem.
>
> However consider the much more complicated case.  We have a child node
> in this tree and the above situation.  In the above case we free'd one
> of the child blocks at the seq 3 operation.  If this block was also
> re-allocated and got new tree mod log operations we would have a
> different problem.  btrfs_search_old_slot(orig root) would get down to
> the logical 0 root that still pointed at that node.  However in
> btrfs_search_old_slot() we call tree_mod_log_rewind(buf) directly.  This
> is not context aware enough to know which operations we should be
> replaying.  If the block was re-allocated multiple times we may only
> want to replay a range of operations, and determining what that range is
> isn't possible to determine.
>
> We could maybe solve this by keeping track of which root the node
> belonged to at every tree mod log operation, and then passing this
> around to make sure we're only replaying operations that relate to the
> root we're trying to rewind.
>
> However there's a simpler way to solve this problem, simply disallow
> reallocations if we have currently running tree mod log users.  We
> already do this for leaf's, so we're simply expanding this to nodes as
> well.  This is a relatively uncommon occurrence, and the problem is
> complicated enough I'm worried that we will still have corner cases in
> the reallocation case.  So fix this in the most straightforward way
> possible.
>
> Fixes: bd989ba359f2 ("Btrfs: add tree modification log functions")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent-tree.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index cd2d36580f1a..2801c991814f 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3295,21 +3295,22 @@ void btrfs_free_tree_block(struct btrfs_trans_han=
dle *trans,
>                 }
>
>                 /*
> -                * If this is a leaf and there are tree mod log users, we=
 may
> -                * have recorded mod log operations that point to this le=
af.
> -                * So we must make sure no one reuses this leaf's extent =
before
> -                * mod log operations are applied to a node, otherwise af=
ter
> -                * rewinding a node using the mod log operations we get a=
n
> -                * inconsistent btree, as the leaf's extent may now be us=
ed as
> -                * a node or leaf for another different btree.
> +                * If there are tree mod log users we may have recorded m=
od log
> +                * operations for this node.  If we re-allocate this node=
 we
> +                * could replay operations on this node that happened whe=
n it
> +                * existed in a completely different root.  For example i=
f it
> +                * was part of root A, then was reallocated to root B, an=
d we
> +                * are doing a btrfs_old_search_slot(root b), we could re=
play
> +                * operations that happened when the block was part of ro=
ot A,
> +                * giving us an inconsistent view of the btree.
> +                *
>                  * We are safe from races here because at this point no o=
ther
>                  * node or root points to this extent buffer, so if after=
 this
> -                * check a new tree mod log user joins, it will not be ab=
le to
> -                * find a node pointing to this leaf and record operation=
s that
> -                * point to this leaf.
> +                * check a new tree mod log user joins we will not have a=
n
> +                * existing log of operations on this node that we have t=
o
> +                * contend with.
>                  */
> -               if (btrfs_header_level(buf) =3D=3D 0 &&
> -                   test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags=
))
> +               if (test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags=
))
>                         must_pin =3D true;
>
>                 if (must_pin || btrfs_is_zoned(fs_info)) {
> --
> 2.26.3
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
