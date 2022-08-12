Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2615913D1
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 18:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbiHLQWI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 12:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238724AbiHLQWH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 12:22:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A373A3469;
        Fri, 12 Aug 2022 09:22:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0678061579;
        Fri, 12 Aug 2022 16:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6116DC433C1;
        Fri, 12 Aug 2022 16:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660321324;
        bh=8UVR1IBW/pdAT0BckkWxu0wjoR6S/l2lDVWCdvZMzJo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sckapiQMke9ksbl7+sO+X2rTro2CBVl5uPJop4puhSdVzonsCYmyjSugsX7ZqtC6C
         /51he3IYkYcT4qeBoJUPuBlJx/p4bNo/dbQZRiz4bdOp79Q5l76VOdQ7uw/LjMGM4x
         sJBuzFAvpoERNrSHvG8haxJIZV0VzG8HbuILXJ7ZlbhTji7wJ7n05pNb3okrg4ZyAx
         8fZMJfic8qOXcd9ThS01Ixdujc/9DQ0Y26c+Y95D+uko68uX+TF6vrKYnLhk4MbTQN
         2JmU5cQ+71tbyGR7DKgWiZKlift8unH0hsdiL+l9qtSqfexdiv/aT8aHCsBHAiOpvu
         o306n0CLt389Q==
Received: by mail-oi1-f174.google.com with SMTP id o184so1640172oif.13;
        Fri, 12 Aug 2022 09:22:04 -0700 (PDT)
X-Gm-Message-State: ACgBeo23IGBtgBI4RDkXErt7DXB9MprB4MJoWe6s4axyNf6jwpcmSo5H
        6qoY67cnIjgOIkJhlFcxnfv1mOAuH+ZoYkDOnMA=
X-Google-Smtp-Source: AA6agR4kU5eGCvbCrr8CjXqR/o+lNbDoN7MnPENHc1jScBgLnJfFs5r1QnYDA980PvQpfxey3ccrDNToL8nopjBMlYE=
X-Received: by 2002:a05:6808:1b85:b0:33a:7a2b:3ff7 with SMTP id
 cj5-20020a0568081b8500b0033a7a2b3ff7mr2098903oib.152.1660321323194; Fri, 12
 Aug 2022 09:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220812144233.132960-1-bingjingc@synology.com> <20220812144233.132960-3-bingjingc@synology.com>
In-Reply-To: <20220812144233.132960-3-bingjingc@synology.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 12 Aug 2022 17:21:26 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4X+XcS_u8g71GpQ6Vnsz5keFiXb1rxstiOwdvJAJzezw@mail.gmail.com>
Message-ID: <CAL3q7H4X+XcS_u8g71GpQ6Vnsz5keFiXb1rxstiOwdvJAJzezw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] brfs: send: fix failures when processing inodes
 with no links
To:     bingjingc <bingjingc@synology.com>
Cc:     josef@toxicpanda.com, dsterba@suse.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        robbieko@synology.com, bxxxjxxg@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 12, 2022 at 3:43 PM bingjingc <bingjingc@synology.com> wrote:
>
> From: BingJing Chang <bingjingc@synology.com>
>
> There is a bug causing send failures when processing an orphan directory
> with no links. In commit 46b2f4590aab ("Btrfs: fix send failure when root
> has deleted files still open")', the orphan inode issue was addressed. The
> send operation fails with a ENOENT error because of any attempts to
> generate a path for the inode with a link count of zero. Therefore, in that
> patch, sctx->ignore_cur_inode was introduced to be set if the current inode
> has a link count of zero for bypassing some unnecessary steps. And a helper
> function btrfs_unlink_all_paths() was introduced and called to clean up old
> paths found in the parent snapshot. However, not only regular files but
> also directories can be orphan inodes. So if the send operation meets an
> orphan directory, it will issue a wrong unlink command for that directory
> now. Soon the receive operation fails with a EISDIR error. Besides, the
> send operation also fails with a ENOENT error later when it tries to
> generate a path of it.
>
> Similar example but making an orphan dir for an incremental send:
>
>   $ btrfs subvolume create vol
>   $ mkdir vol/dir
>   $ touch vol/dir/foo
>
>   $ btrfs subvolume snapshot -r vol snap1
>   $ btrfs subvolume snapshot -r vol snap2
>
>   # Turn the second snapshot to RW mode and delete the whole dir while
>   # holding an open file descriptor on it.
>   $ btrfs property set snap2 ro false
>   $ exec 73<snap2/dir
>   $ rm -rf snap2/dir
>
>   # Set the second snapshot back to RO mode and do an incremental send.
>   $ btrfs property set snap2 ro true
>   $ mkdir receive_dir
>   $ btrfs send snap2 -p snap1 | btrfs receive receive_dir/
>   At subvol snap2
>   At snapshot snap2
>   ERROR: send ioctl failed with -2: No such file or directory
>   ERROR: unlink dir failed. Is a directory
>
> Actually, orphan inodes are more common use cases in cascading backups.
> (Please see the illustration below.) In a cascading backup, a user wants
> to replicate a couple of snapshots from Machine A to Machine B and from
> Machine B to Machine C. Machine B doesn't take any RO snapshots for
> sending. All a receiver does is create an RW snapshot of its parent
> snapshot, apply the send stream and turn it into RO mode at the end. Even
> if all paths of some inodes are deleted in applying the send stream, these
> inodes would not be deleted and become orphans after changing the subvolume
> from RW to RO. Moreover, orphan inodes can occur not only in send snapshots
> but also in parent snapshots because Machine B may do a batch replication
> of a couple of snapshots.
>
> An illustration for cascading backups:
> Machine A (snapshot {1..n}) --> Machine B --> Machine C
>
> The intuition to solve the problem is to delete all the items of orphan
> inodes before using these snapshots for sending. I used to think that the
> reasonable timing for doing that is during the ioctl of changing the
> subvolume from RW to RO because it sounds good that we will not modify the
> fs tree of a RO snapshot anymore. However, attempting to do the orphan
> cleanup in the ioctl would be pointless. Because if someone is holding an
> open file descriptor on the inode, the reference count of the inode will
> never drop to 0. Then iput() cannot trigger eviction, which finally deletes
> all the items of it. So we try to extend the original patch to handle
> orphans in send/parent snapshots. Here are several cases that need to be
> considered:
>
> Case 1: BTRFS_COMPARE_TREE_NEW
>        |  send snapshot  | action
>  --------------------------------
>  nlink |        0        | ignore
>
> In case 1, when we get a BTRFS_COMPARE_TREE_NEW tree comparison result,
> it means that a new inode is found in the send snapshot and it doesn't
> appear in the parent snapshot. Since this inode has a link count of zero
> (It's an orphan and there're no paths for it.), we can leverage
> sctx->ignore_cur_inode in the original patch to prevent it from being
> created.
>
> Case 2: BTRFS_COMPARE_TREE_DELETED
>        | parent snapshot | action
>  ----------------------------------
>  nlink |        0        | as usual
>
> In case 2, when we get a BTRFS_COMPARE_TREE_DELETED tree comparison
> result, it means that the inode only appears in the parent snapshot.
> As usual, the send operation will try to delete all its paths. However,
> this inode has a link count of zero, so no paths of it will be found. No
> deletion operations will be issued. We don't need to change any logic.
>
> Case 3: BTRFS_COMPARE_TREE_CHANGED
>            |       | parent snapshot | send snapshot | action
>  -----------------------------------------------------------------------
>  subcase 1 | nlink |        0        |       0       | ignore
>  subcase 2 | nlink |       >0        |       0       | new_gen(deletion)
>  subcase 3 | nlink |        0        |      >0       | new_gen(creation)
>
> In case 3, when we get a BTRFS_COMPARE_TREE_CHANGED tree comparison result,
> it means that the inode appears in both snapshots. Here're three subcases.
>
> First, if the inode has link counts of zero in both snapshots. Since there
> are no paths for this inode in (source/destination) parent snapshots and we
> don't care about whether there is also an orphan inode in destination or
> not, we can set sctx->ignore_cur_inode on to prevent it from being created.
>
> For the second and the third subcases, if there're paths in one snapshot
> and there're no paths in the other snapshot for this inode. We can treat
> this inode as a new generation. We can also leverage the logic handling a
> new generation of an inode with small adjustments. Then it will delete all
> old paths and create a new inode with new attributes and paths only when
> there's a positive link count in the send snapshot. In subcase 2, the
> send operation only needs to delete all old paths as in the parent
> snapshot. But it may require more operations for a directory to remove its
> old paths. If a not-empty directory is going to be deleted (because it has
> a link count of zero in the send snapshot) but there're files/directories
> with bigger inode numbers under it, the send operation will need to rename
> it to its orphan name first. After processing and deleting the last item
> under this directory, the send operation will check this directory, aka
> the parent directory of the last item, again and issue a rmdir operation
> to remove it finally. Therefore, we also need to treat inodes with a link
> count of zero as if they didn't exist in get_cur_inode_state(), which is
> used in process_recorded_refs(). By doing this, when reviewing a directory
> with orphan names after the last item under it has been deleted, the send
> operation now can properly issue a rmdir operation. Otherwise, without
> doing this, the orphan directory with an orphan name would be kept here
> at the end due to the existing inode with a link count of zero being found.
> In subcase 3, as in case 2, no old paths would be found, so no deletion
> operations will be issued. The send operation will only create a new one
> for that inode.
>
> Note that subcase 3 is not a common case. That's because it's easy to
> reduce the hard links of an inode, but once all valid paths are removed,
> there're no valid paths for creating other hard links. The only way to do
> that is trying to send an older snapshot after a newer snapshot has been
> sent.
>
> Fixes: 31db9f7c23fbf7 ("Btrfs: introduce BTRFS_IOC_SEND for btrfs send/receive")
> Reviewed-by: Robbie Ko <robbieko@synology.com>
> Signed-off-by: BingJing Chang <bingjingc@synology.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks!

> ---
>  fs/btrfs/send.c | 214 +++++++++++++++++++-----------------------------
>  1 file changed, 85 insertions(+), 129 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index f8d77a33b9b7..6ab1ba66ff4b 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -850,6 +850,7 @@ struct btrfs_inode_info {
>         u64 gid;
>         u64 rdev;
>         u64 attr;
> +       u64 nlink;
>  };
>
>  /*
> @@ -888,6 +889,7 @@ static int get_inode_info(struct btrfs_root *root, u64 ino,
>         info->uid = btrfs_inode_uid(path->nodes[0], ii);
>         info->gid = btrfs_inode_gid(path->nodes[0], ii);
>         info->rdev = btrfs_inode_rdev(path->nodes[0], ii);
> +       info->nlink = btrfs_inode_nlink(path->nodes[0], ii);
>         /*
>          * Transfer the unchanged u64 value of btrfs_inode_item::flags, that's
>          * otherwise logically split to 32/32 parts.
> @@ -1652,19 +1654,22 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen)
>         int right_ret;
>         u64 left_gen;
>         u64 right_gen;
> +       struct btrfs_inode_info info;
>
> -       ret = get_inode_gen(sctx->send_root, ino, &left_gen);
> +       ret = get_inode_info(sctx->send_root, ino, &info);
>         if (ret < 0 && ret != -ENOENT)
>                 goto out;
> -       left_ret = ret;
> +       left_ret = (info.nlink == 0) ? -ENOENT : ret;
> +       left_gen = info.gen;
>
>         if (!sctx->parent_root) {
>                 right_ret = -ENOENT;
>         } else {
> -               ret = get_inode_gen(sctx->parent_root, ino, &right_gen);
> +               ret = get_inode_info(sctx->parent_root, ino, &info);
>                 if (ret < 0 && ret != -ENOENT)
>                         goto out;
> -               right_ret = ret;
> +               right_ret = (info.nlink == 0) ? -ENOENT : ret;
> +               right_gen = info.gen;
>         }
>
>         if (!left_ret && !right_ret) {
> @@ -6413,86 +6418,6 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
>         return ret;
>  }
>
> -struct parent_paths_ctx {
> -       struct list_head *refs;
> -       struct send_ctx *sctx;
> -};
> -
> -static int record_parent_ref(int num, u64 dir, int index, struct fs_path *name,
> -                            void *ctx)
> -{
> -       struct parent_paths_ctx *ppctx = ctx;
> -
> -       /*
> -        * Pass 0 as the generation for the directory, we don't care about it
> -        * here as we have no new references to add, we just want to delete all
> -        * references for an inode.
> -        */
> -       return record_ref_in_tree(&ppctx->sctx->rbtree_deleted_refs, ppctx->refs,
> -                                 name, dir, 0, ppctx->sctx);
> -}
> -
> -/*
> - * Issue unlink operations for all paths of the current inode found in the
> - * parent snapshot.
> - */
> -static int btrfs_unlink_all_paths(struct send_ctx *sctx)
> -{
> -       LIST_HEAD(deleted_refs);
> -       struct btrfs_path *path;
> -       struct btrfs_root *root = sctx->parent_root;
> -       struct btrfs_key key;
> -       struct btrfs_key found_key;
> -       struct parent_paths_ctx ctx;
> -       int iter_ret = 0;
> -       int ret;
> -
> -       path = alloc_path_for_send();
> -       if (!path)
> -               return -ENOMEM;
> -
> -       key.objectid = sctx->cur_ino;
> -       key.type = BTRFS_INODE_REF_KEY;
> -       key.offset = 0;
> -
> -       ctx.refs = &deleted_refs;
> -       ctx.sctx = sctx;
> -
> -       btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
> -               if (found_key.objectid != key.objectid)
> -                       break;
> -               if (found_key.type != key.type &&
> -                   found_key.type != BTRFS_INODE_EXTREF_KEY)
> -                       break;
> -
> -               ret = iterate_inode_ref(root, path, &found_key, 1,
> -                                       record_parent_ref, &ctx);
> -               if (ret < 0)
> -                       goto out;
> -       }
> -       /* Catch error found during iteration */
> -       if (iter_ret < 0) {
> -               ret = iter_ret;
> -               goto out;
> -       }
> -
> -       while (!list_empty(&deleted_refs)) {
> -               struct recorded_ref *ref;
> -
> -               ref = list_first_entry(&deleted_refs, struct recorded_ref, list);
> -               ret = send_unlink(sctx, ref->full_path);
> -               if (ret < 0)
> -                       goto out;
> -               recorded_ref_free(ref);
> -       }
> -       ret = 0;
> -out:
> -       btrfs_free_path(path);
> -       if (ret)
> -               __free_recorded_refs(&deleted_refs);
> -       return ret;
> -}
> -
>  static void close_current_inode(struct send_ctx *sctx)
>  {
>         u64 i_size;
> @@ -6583,25 +6508,37 @@ static int changed_inode(struct send_ctx *sctx,
>          * file descriptor against it or turning a RO snapshot into RW mode,
>          * keep an open file descriptor against a file, delete it and then
>          * turn the snapshot back to RO mode before using it for a send
> -        * operation. So if we find such cases, ignore the inode and all its
> -        * items completely if it's a new inode, or if it's a changed inode
> -        * make sure all its previous paths (from the parent snapshot) are all
> -        * unlinked and all other the inode items are ignored.
> +        * operation. The former is what the receiver operation does.
> +        * Therefore, if we want to send these snapshots soon after they're
> +        * received, we need to handle orphan inodes as well. Moreover,
> +        * orphans can appear not only in the send snapshot but also in the
> +        * parent snapshot. Here are several cases:
> +        *
> +        * Case 1: BTRFS_COMPARE_TREE_NEW
> +        *       |  send snapshot  | action
> +        * --------------------------------
> +        * nlink |        0        | ignore
> +        *
> +        * Case 2: BTRFS_COMPARE_TREE_DELETED
> +        *       | parent snapshot | action
> +        * ----------------------------------
> +        * nlink |        0        | as usual
> +        * Note: No unlinks will be sent because there're no paths for it.
> +        *
> +        * Case 3: BTRFS_COMPARE_TREE_CHANGED
> +        *           |       | parent snapshot | send snapshot | action
> +        * -----------------------------------------------------------------------
> +        * subcase 1 | nlink |        0        |       0       | ignore
> +        * subcase 2 | nlink |       >0        |       0       | new_gen(deletion)
> +        * subcase 3 | nlink |        0        |      >0       | new_gen(creation)
> +        *
>          */
> -       if (result == BTRFS_COMPARE_TREE_NEW ||
> -           result == BTRFS_COMPARE_TREE_CHANGED) {
> -               u32 nlinks;
> -
> -               nlinks = btrfs_inode_nlink(sctx->left_path->nodes[0], left_ii);
> -               if (nlinks == 0) {
> +       if (result == BTRFS_COMPARE_TREE_NEW) {
> +               if (btrfs_inode_nlink(sctx->left_path->nodes[0], left_ii) ==
> +                                     0) {
>                         sctx->ignore_cur_inode = true;
> -                       if (result == BTRFS_COMPARE_TREE_CHANGED)
> -                               ret = btrfs_unlink_all_paths(sctx);
>                         goto out;
>                 }
> -       }
> -
> -       if (result == BTRFS_COMPARE_TREE_NEW) {
>                 sctx->cur_inode_gen = left_gen;
>                 sctx->cur_inode_new = true;
>                 sctx->cur_inode_deleted = false;
> @@ -6622,6 +6559,18 @@ static int changed_inode(struct send_ctx *sctx,
>                 sctx->cur_inode_mode = btrfs_inode_mode(
>                                 sctx->right_path->nodes[0], right_ii);
>         } else if (result == BTRFS_COMPARE_TREE_CHANGED) {
> +               u32 new_nlinks, old_nlinks;
> +
> +               new_nlinks = btrfs_inode_nlink(sctx->left_path->nodes[0],
> +                                              left_ii);
> +               old_nlinks = btrfs_inode_nlink(sctx->right_path->nodes[0],
> +                                              right_ii);
> +               if (new_nlinks == 0 && old_nlinks == 0) {
> +                       sctx->ignore_cur_inode = true;
> +                       goto out;
> +               } else if (new_nlinks == 0 || old_nlinks == 0) {
> +                       sctx->cur_inode_new_gen = 1;
> +               }
>                 /*
>                  * We need to do some special handling in case the inode was
>                  * reported as changed with a changed generation number. This
> @@ -6648,38 +6597,45 @@ static int changed_inode(struct send_ctx *sctx,
>                         /*
>                          * Now process the inode as if it was new.
>                          */
> -                       sctx->cur_inode_gen = left_gen;
> -                       sctx->cur_inode_new = true;
> -                       sctx->cur_inode_deleted = false;
> -                       sctx->cur_inode_size = btrfs_inode_size(
> -                                       sctx->left_path->nodes[0], left_ii);
> -                       sctx->cur_inode_mode = btrfs_inode_mode(
> -                                       sctx->left_path->nodes[0], left_ii);
> -                       sctx->cur_inode_rdev = btrfs_inode_rdev(
> -                                       sctx->left_path->nodes[0], left_ii);
> -                       ret = send_create_inode_if_needed(sctx);
> -                       if (ret < 0)
> -                               goto out;
> +                       if (new_nlinks > 0) {
> +                               sctx->cur_inode_gen = left_gen;
> +                               sctx->cur_inode_new = true;
> +                               sctx->cur_inode_deleted = false;
> +                               sctx->cur_inode_size = btrfs_inode_size(
> +                                               sctx->left_path->nodes[0],
> +                                               left_ii);
> +                               sctx->cur_inode_mode = btrfs_inode_mode(
> +                                               sctx->left_path->nodes[0],
> +                                               left_ii);
> +                               sctx->cur_inode_rdev = btrfs_inode_rdev(
> +                                               sctx->left_path->nodes[0],
> +                                               left_ii);
> +                               ret = send_create_inode_if_needed(sctx);
> +                               if (ret < 0)
> +                                       goto out;
>
> -                       ret = process_all_refs(sctx, BTRFS_COMPARE_TREE_NEW);
> -                       if (ret < 0)
> -                               goto out;
> -                       /*
> -                        * Advance send_progress now as we did not get into
> -                        * process_recorded_refs_if_needed in the new_gen case.
> -                        */
> -                       sctx->send_progress = sctx->cur_ino + 1;
> +                               ret = process_all_refs(sctx,
> +                                               BTRFS_COMPARE_TREE_NEW);
> +                               if (ret < 0)
> +                                       goto out;
> +                               /*
> +                                * Advance send_progress now as we did not get
> +                                * into process_recorded_refs_if_needed in the
> +                                * new_gen case.
> +                                */
> +                               sctx->send_progress = sctx->cur_ino + 1;
>
> -                       /*
> -                        * Now process all extents and xattrs of the inode as if
> -                        * they were all new.
> -                        */
> -                       ret = process_all_extents(sctx);
> -                       if (ret < 0)
> -                               goto out;
> -                       ret = process_all_new_xattrs(sctx);
> -                       if (ret < 0)
> -                               goto out;
> +                               /*
> +                                * Now process all extents and xattrs of the
> +                                * inode as if they were all new.
> +                                */
> +                               ret = process_all_extents(sctx);
> +                               if (ret < 0)
> +                                       goto out;
> +                               ret = process_all_new_xattrs(sctx);
> +                               if (ret < 0)
> +                                       goto out;
> +                       }
>                 } else {
>                         sctx->cur_inode_gen = left_gen;
>                         sctx->cur_inode_new = false;
> --
> 2.37.1
>
