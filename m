Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6DB58CC0B
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 18:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243701AbiHHQXS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 12:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243887AbiHHQXO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 12:23:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0131B15FEA;
        Mon,  8 Aug 2022 09:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E940B80EEA;
        Mon,  8 Aug 2022 16:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D81C4347C;
        Mon,  8 Aug 2022 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659975787;
        bh=Y27blRbFV3bUQqrsko/Bob+YdhO9yRbvNpf0yCZZxiY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dT1fSLw1pgzneIWUBBM3O9Ud3baq1lVdOdyunyWXdmNyTUu/w+tsNqVznvKtyB7eV
         CzHLb1L/avHkUCvDkN6ANmH4j961dsLHSXoUvsgNidMJ6o0YclF3qlNBbMuH/cY+RK
         pGMt/vhCDkV6+IROp+/lVi3daLRtAG/VGXFtZIgxCoNLwLZwmXnun1SmMwJV3rZ4Ob
         FeqqP9fBdL+yqzpd2JjOv8+nIIkFxDac79Bsjbol+2NCniu9tSefPagQr9beHr18nx
         +ZMNe//umD39TanXXbjO6zBSxL76DgqyGdKI09casvwXix4eSkp0mbwcvl5dhIVWNM
         5UkEssjX9HmUQ==
Received: by mail-oi1-f172.google.com with SMTP id u14so2776376oie.2;
        Mon, 08 Aug 2022 09:23:07 -0700 (PDT)
X-Gm-Message-State: ACgBeo2gA3hGDcBEAcq9MtUepGljbY2AO376s8FZjjijo/tF+Ag/5avx
        OiZ/CIof3SO0b7uxtRNcS1Ly7N4b4ubu6zSvnvs=
X-Google-Smtp-Source: AA6agR4Eex+tltZ9bqkchIp/ppRUoanKfW0GyuEpm5nPQq9PJLJZykbmdwYMQdbEtqkfTBh82Jr9XYuDhgyj5QsscMo=
X-Received: by 2002:a05:6808:d4e:b0:33a:b40a:54dd with SMTP id
 w14-20020a0568080d4e00b0033ab40a54ddmr8627927oik.294.1659975785979; Mon, 08
 Aug 2022 09:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220808102735.4556-1-bingjingc@synology.com> <20220808102735.4556-3-bingjingc@synology.com>
In-Reply-To: <20220808102735.4556-3-bingjingc@synology.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 8 Aug 2022 17:22:29 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5Rr6DAQ+rFJUu8aWnGTVkd1GiP2o4_6k93hc1DXcCi1A@mail.gmail.com>
Message-ID: <CAL3q7H5Rr6DAQ+rFJUu8aWnGTVkd1GiP2o4_6k93hc1DXcCi1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: send: fix a bug that sending unlink commands
 for directories
To:     bingjingc <bingjingc@synology.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robbie Ko <robbieko@synology.com>, bxxxjxxg@gmail.com
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

On Mon, Aug 8, 2022 at 11:27 AM bingjingc <bingjingc@synology.com> wrote:
>
> From: BingJing Chang <bingjingc@synology.com>
>

Reading the subject is confusing, something sounds off:

"btrfs: send: fix a bug that sending unlink commands for directories"

May I suggest something more clear like:

"btrfs: send: fix failures when processing inodes with no links"

Since it does not only address the case of directories but also for
regular files on the parent snapshot,
as you mention further below in the changelog.

> There is a bug sending unlink commands for directories. In
> commit 46b2f4590aab ("Btrfs: fix send failure when root has deleted files
> still open")', orphan inode issue was addressed. There're no reference
> paths for these orphan inodes, so the send operation fails with an ENOENT
> error. Therefore, in that patch, sctx->ignore_cur_inode was introduced to
> be set if the current inode has a link count of zero for bypassing some
> unnecessary steps. And a helper function btrfs_unlink_all_paths() was
> introduced and called to clean up old reference paths found in the parent
> snapshot. However, not only regular files but also directories can be
> orphan inodes. So if it meets an orphan directory, a wrong unlink command
> for this directory will be issued. Soon the unlink command fails with an
> EISDIR error.

So, there are two things happening:

1) Send fails with -ENOENT, because it tries to generate a path for a directory
that has no links. This is just like the case of a regular file before
commit 46b2f4590aab.

2) Before the send ioctl failed with -ENOENT, it generated an unlink
command for the
directory. This is the only part you mention.

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
>   ERROR: unlink dir failed. Is a directory

So running your reproducer, I get send failing with -ENOENT, but oddly in your
output that doesn't happen. Perhaps that's when running with some
custom and specific
synology codebase? Or you unintentionally omitted a part of the output?

This is what I get:

$ cat test.sh
#!/bin/bash

DEV=/dev/sdj
MNT=/mnt/sdj

umount $DEV &>/dev/null
mkfs.btrfs -f $DEV 2>/dev/null
mount $DEV $MNT

btrfs subvolume create $MNT/vol
mkdir $MNT/vol/dir
touch $MNT/vol/dir/foo

btrfs subvolume snapshot -r $MNT/vol $MNT/snap1
btrfs subvolume snapshot -r $MNT/vol $MNT/snap2

# Turn the second snapshot to RW mode and delete the whole dir while
# holding an open file descriptor on it.
btrfs property set $MNT/snap2 ro false
exec 73<$MNT/snap2/dir
rm -rf $MNT/snap2/dir

# Set the second snapshot back to RO mode and do an incremental send.
btrfs property set $MNT/snap2 ro true
mkdir $MNT/receive_dir
btrfs send $MNT/snap2 -p $MNT/snap1 | btrfs receive $MNT/receive_dir/

$ ./test.sh
(...)
Create subvolume '/mnt/sdj/vol'
Create a readonly snapshot of '/mnt/sdj/vol' in '/mnt/sdj/snap1'
Create a readonly snapshot of '/mnt/sdj/vol' in '/mnt/sdj/snap2'
At subvol /mnt/sdj/snap2
At snapshot snap2
ERROR: send ioctl failed with -2: No such file or directory
ERROR: unlink dir failed: Is a directory

>
> Actually, orphan inodes are more common use cases in cascading backups.
> (Please see the illustration below.) In a cascading backup, a user wants
> to replicate a couple of snapshots from Machine A to Machine B and from
> Machine B to Machine C. Machine B doesn't take any RO snapshots for
> sending. All a receiver does is clone an RW subvolume from its parent

What do you mean by cloning a RW subvolume?
Create a (RW) snapshot of it? Please make it more clear in the next
patch version.

> snapshot, replay the changes and turn it into RO mode at the end. After
> all reference paths of some inodes are deleted in applying changes,

"reference paths" is confusing, just say paths only.

"in applying changes" -> "when applying the send stream"

> there's no guarantee that orphan inodes will be cleaned up after subvolumes
> are turned into RO mode.

Orphan cleanup is not supposed to happen when changing the subvolume
state from RW to RO (and vice versa).
Once an inode's link count drops to 0, it's marked as an orphan for
cleanup, but the cleanup only happens later,
more on this below.

> Moreover, orphan inodes can occur not only in send
> snapshots but also in parent snapshots because Machine B may do a batch
> replication of a couple of snapshots.
>
> An illustration for cascading backups:
> Machine A (snapshot {1..n}) --> Machine B --> Machine C
>
> The intuition to solve the problem is to do orphan cleanups before using
> these snapshots for sending. The more reasonable timing is doing orphan
> cleanups during the ioctl of turning an RW subvolume into an RO snapshot.

No, attempting to do orphan cleanup in the ioctl would be pointless.
More details below.

The cleanup, deleting the inode's items etc, can not happen while
someone is using a file descriptor for the inode,
which is precisely the case in the reproducer above.

It will happen only once the reference count on the inode drops to 0
(after the last file descriptor is closed).
The final iput() triggers the eviction, which will delete all the
inode items, etc, if the inode still has a link count of 0.

> And it's also because an RO snapshot is regarded that the fs tree has
> already frozen and will never be adjusted anymore.

We can do orphan cleanup on a RO subvolume/snapshot - that's not a
problem. We only skip orphan cleanup
when the fs is mounted in RO mode. It's just pointless for the type of
reproducer you provided, see below.

> However, that would make
> the work of property changes more complicated than expected. And the
> btrfs_orphan_cleanup() is also not promised to remove all orphans
> successfully.

In this case btrfs_orphan_cleanup() would never trigger the cleanup of
the inode because there's still
a process holding a file descriptor open, so the iput() done by
btrfs_orphan_cleanup() is not the final
iput - therefore it doesn't not trigger eviction, which is what
deletes all the items of the inode.

For that test, what will trigger the cleanup is the closing of the
file descriptor - that triggers the final iput,
which triggers eviction and that finally triggers the deletions of all
the items that belong to the inode, etc.

> So we try to extend the original patch to handle orphans in
> send/parent snapshots. Here are several cases that need to be considered:
>
> Case 1: BTRFS_COMPARE_TREE_NEW
>        |  send snapshot  | action
>  --------------------------------
>  nlink |        0        | ignore
>
> In case 1, when we get a BTRFS_COMPARE_TREE_NEW tree comparison result,
> it means that a new inode is found in the send snapshot and it doesn't
> appear in the parent snapshot. Since this inode has a link count of zero
> (It's an orphan and there're no reference paths.), we can leverage

Please don't use the term "reference paths", it's confusing. Just say
it has no links,
or that it doesn't have any inode reference items.

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
> As usual, the send operation will try to delete all its reference paths.

"all its reference paths" -> "all its paths"

> However, this inode has a link count of zero, so no reference paths will

Same as before and same note for everywhere else in the changelog and code
comments.

> be found. No deletion operations will be issued. We don't need to change
> any logics.
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
> are no reference paths for this inode in (source/destination) parent
> snapshots and we don't care about whether there is also an orphan inode in
> destination or not, we can set sctx->ignore_cur_inode on to prevent it
> from being created.
>
> For the second and the third subcases, if there're reference paths in one
> snapshot and there're no reference paths in the other snapshot. We can
> treat this inode as a new generation. We can also leverage the logic
> handling a new generation of an inode with small adjustments. Then it will
> delete all old reference paths and create a new inode with new attributes
> and paths only when there's a positive link count in the send snapshot.
> Unlike regular files, which just require unlink operations for deleting
> their old reference paths, a directory may require more operations to
> remove its old reference paths. For a non-empty directory, the send
> operation will rename it first and finally issue a rmdir operation to
> remove it after the last item under this directory has been deleted.

How can we have a non-empty directory with a link count of 0?
To be able to rmdir a directory (even if some process is holding an
open file descriptor on it), one
has to delete all its dentries first - there's no way around this,
it's enforced in generic code, outside btrfs.

So I don't understand your suggestion that we can have a snapshot with
a non-empty directory
that has a link count of 0.

> Therefore, we also need to modify the existence definition of inodes to

"existence definition of inodes" - this is super confusing. I can
understand it only
by looking at the code changes. You mean, to treat inodes with a link count of 0
as if they didn't exist.

Maybe just say "... we also need to consider inodes without links as deleted".

> exclude orphan inodes in get_cur_inode_state(), which is used in
> process_recorded_refs(). Then it can properly issue the rmdir operation
> after the last item in the directory has been removed.
>
> Note that subcase 3 is not a common case. That's because it's easy to
> reduce the hard links of an inode, but once all valid paths are removed,
> there're no valid paths for creating other hard links. The only way to do
> that is trying to send a older snapshot after a newer snapshot has been
> sent.

>
> Fixes: 46b2f4590aab ("Btrfs: fix send failure when root has deleted files still open")

So the Fixes tag is meant to identify a commit that introduced a bug.

That commit only addressed one case of inodes with no links - when
they are regular files and in the send snapshot only.
The other cases you identified didn't work before that commit - they
have never worked since send was introduced in 2012 (commit
31db9f7c23fbf7e95026143f79645de6507b583b).

If your intention is to have this backported, and simply mark that
commit as a dependency, then use a proper CC tag as mentioned at:

https://www.kernel.org/doc/html/v4.10/process/stable-kernel-rules.html#option-3

Like this I suppose:

Cc: <stable@vger.kernel.org> # 4.9: 46b2f4590aab: Btrfs: fix send
failure when root has deleted files still open
Cc: <stable@vger.kernel.org> # 4.9: 71ecfc133b03: btrfs: send:
introduce recorded_ref_alloc and recorded_ref_free
Cc: <stable@vger.kernel.org> # 4.9: 3aa5bd367fa5: btrfs: send: fix
sending link commands for existing file paths
Cc: <stable@vger.kernel.org> # 4.9: 0d8869fb6b6f8: btrfs: send: always
use the rbtree based inode ref management infrastructure

Maybe there are other patches that are needed for a clean backport,
but those are the only ones I have in mind because they are recent.
Otherwise we would have to change the version of the patch submitted
for stable releases.

> Reviewed-by: Robbie Ko <robbieko@synology.com>
> Signed-off-by: BingJing Chang <bingjingc@synology.com>
> ---
>  fs/btrfs/send.c | 218 ++++++++++++++++++++----------------------------
>  1 file changed, 89 insertions(+), 129 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 84b09d428ca3..351fb7cdec4c 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -850,6 +850,7 @@ enum inode_field {
>         INODE_GID = 0x1 << 4,
>         INODE_RDEV = 0x1 << 5,
>         INODE_ATTR = 0x1 << 6,
> +       INODE_NLINK = 0x1 << 7,
>  };
>
>  struct inode_info {
> @@ -860,6 +861,7 @@ struct inode_info {
>         u64 gid;
>         u64 rdev;
>         u64 attr;
> +       u64 nlink;
>  };
>
>  /*
> @@ -904,6 +906,8 @@ static int get_inode_info(struct btrfs_root *root, u64 ino, unsigned int flags,
>                 info->gid = btrfs_inode_gid(path->nodes[0], ii);
>         if (flags & INODE_RDEV)
>                 info->rdev = btrfs_inode_rdev(path->nodes[0], ii);
> +       if (flags & INODE_NLINK)
> +               info->nlink = btrfs_inode_nlink(path->nodes[0], ii);
>         /*
>          * Transfer the unchanged u64 value of btrfs_inode_item::flags, that's
>          * otherwise logically split to 32/32 parts.
> @@ -1669,19 +1673,24 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen)
>         int right_ret;
>         u64 left_gen;
>         u64 right_gen;
> +       struct inode_info info;
>
> -       ret = get_inode_gen(sctx->send_root, ino, &left_gen);
> +       ret = get_inode_info(sctx->send_root, ino, INODE_GEN|INODE_NLINK,
> +                            &info);
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
> +               ret = get_inode_info(sctx->parent_root, ino,
> +                                    INODE_GEN|INODE_NLINK, &info);
>                 if (ret < 0 && ret != -ENOENT)
>                         goto out;
> -               right_ret = ret;
> +               right_ret = (info.nlink == 0) ? -ENOENT : ret;
> +               right_gen = info.gen;
>         }
>
>         if (!left_ret && !right_ret) {
> @@ -6437,86 +6446,6 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
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
> @@ -6607,25 +6536,37 @@ static int changed_inode(struct send_ctx *sctx,
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
> +        * Note: No unlinks will be sent bacause there're no reference paths.

bacause -> because

The code looks good to me, it's a good solution.

Can you please send a test case for fstests covering all these scenarios?
I.e. directory with a link count of 0, like the reproducer in the
changelog, parent snapshot with an inode have 0 links as well, etc.

Thanks.

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
> @@ -6646,6 +6587,18 @@ static int changed_inode(struct send_ctx *sctx,
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
> @@ -6672,38 +6625,45 @@ static int changed_inode(struct send_ctx *sctx,
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
