Return-Path: <linux-btrfs+bounces-4183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61E58A2EB6
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 14:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B53B28511E
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 12:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD6D5B1E8;
	Fri, 12 Apr 2024 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4BrX1gI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9809D59154
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712926725; cv=none; b=LqfSrclzF5oLRZC9xYvt40rw96pRI7BD9lKP8Nd8jdaQvi4A3gEVgzjzSrxM1MtM6GImhAqlKxk7hJ2+ENW5PA1n+cZb5Vm5u96D84IPrl4AETqoOSmyE63qGgmYXXgor3U7F6VhxlJrfocFRgqLNoq8prFRXAGeerSwC/3F5S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712926725; c=relaxed/simple;
	bh=fnHVNzjvirdxaG672mOojokBFmmPxAROb3ziyRhN5Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QM0Q+U8SH6EmfL5EoJdvruWoh0ihPbo7B/XWiZzESv0XbQdYqa3Osx4tmm4tJ00qA1W/izMw1JqIRKmD3SAMmaXg2Hnz2faf6iyPagZOX+FpiQ648qF258uwe5q7dJ3RrFveuxRRLxhESXSpOT7UbWtNVj+cgo7rz5G4+IFTFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4BrX1gI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F30C2BD11
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 12:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712926725;
	bh=fnHVNzjvirdxaG672mOojokBFmmPxAROb3ziyRhN5Pg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W4BrX1gIU/7+G08AYlkerQ+yPmfxCmU/HloRiEqyO2i0Q+JkJuJWRnPgwbbJQPUTV
	 yDXMTmoDKX9QdyZJbM+fa9Uh8NJoe4/iypTRXEiQidEQx4iGuaxDFQzl1hj4lFZk3A
	 ALKkkaE2IrFFw5BcB8eph9Bdb2GaPMwCAE2WN/KkG2/0wk+mNSbZhvI7/BDrW/obdd
	 kIMJX23DCyMAZbbcQ/PkExO/3DZu41l8t7JrsDPy6hk46+QUTC8M4mdAsg3e+mbR9Y
	 UrmsUnWuqVHJneKMGzVGIE7eTpSYXCzY0PSXteSJAGPOCYfToNUxejBTcYA+ydnuXt
	 eZ1ScTkXWj3oA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so2990339a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 05:58:45 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz4VQHqp81yZBzrjxe/WP7sqCCEqtcld6gBrpMMF+n/J3+fjht1
	Q63iuyPijOWBJPnBzxy365E04y0rZQo0FBQLJwB6PpjT6a/bl8cew0yc+0Ji9UMAQOARWr7p8oz
	EULoYLqNouu1Nc5HICCOywU8GmAA=
X-Google-Smtp-Source: AGHT+IGrEYaVyg51WEJ+tfPpXHnA7dltsBygQO/cUIsOrybVY8rqGXGb5eAVK04OLBE++IIcOlG7zNyNL8z/Xnuyvqs=
X-Received: by 2002:a17:906:a2d2:b0:a52:3f89:20b8 with SMTP id
 by18-20020a170906a2d200b00a523f8920b8mr298906ejb.28.1712926723645; Fri, 12
 Apr 2024 05:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dc43a26265d37c71a53d6415ae2d352035fa6847.1712869574.git.josef@toxicpanda.com>
In-Reply-To: <dc43a26265d37c71a53d6415ae2d352035fa6847.1712869574.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Apr 2024 13:58:06 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4RFSr3GEohQ=mLA2Tm0Us0spCk6je1o8iJFKEmhr4N5Q@mail.gmail.com>
Message-ID: <CAL3q7H4RFSr3GEohQ=mLA2Tm0Us0spCk6je1o8iJFKEmhr4N5Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: check delayed refs when we're checking if a ref exists
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:12=E2=80=AFPM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> In the patch 78c52d9eb6b7 ("btrfs: check for refs on snapshot delete
> resume") I added some code to handle file systems that had been
> corrupted by a bug that incorrectly skipped updating the drop progress
> key while dropping a snapshot.  This code would check to see if we had
> already deleted our reference for a child block, and skip the deletion
> if we had already.
>
> Unfortunately there is a bug, as the check would only check the on-disk
> references.  I made an incorrect assumption that blocks in an already
> deleted snapshot that was having the deletion resume on mount wouldn't
> be modified.
>
> If we have 2 pending deleted snapshots that share blocks, we can easily
> modify the rules for a block.  Take the following example
>
> subvolume a exists, and subvolume b is a snapshot of subvolume a.  They
> share references to block 1.  Block 1 will have 2 full references, one
> for subvolume a and one for subvolume b, and it blocks to subvolume a.

Something's odd here with "and it blocks to subvolume a", blocks?
Belongs? Since it's owned by subvolume a.

>
> When deleting subvolume a, we will drop our full reference for block 1,
> and because we are the owner we will drop our full reference for all of
> block 1's children, convert block 1 to FULL BACKREF, and add a shared
> reference to all of block 1's children.

Ok, makes sense.

>
> Then we will start the snapshot deletion of subvolume b.  We look up the
> extent info for block 1, which checks delayed refs and tells us that
> FULL BACKREF is set, so sets parent to the bytenr of block 1.  However
> because this is a resumed snapshot deletion, we call into
> check_ref_exists().  Because check_ref_exists() only looks at the disk,
> it doesn't find the shared backref for the child of block 1, and thus
> returns 0 and we skip deleting the reference for the child of block 1
> and continue.  This orphans the child of block 1.
>
> The fix is to lookup the delayed refs, similar to what we do in
> btrfs_lookup_extent_info().  However we only care about whether the
> reference exists or not.  If we fail to find our reference on disk, go
> look up the bytenr in the delayed refs, and if it exists look for an
> existing ref in the delayed ref head.  If that exists then we know we
> can delete the reference safely and carry on.  If it doesn't exist we
> know we have to skip over this block.
>
> This bug has existed since I introduced this fix, however requires
> having multiple deleted snapshots pending when we unmount.  Previously
> this was difficult to do, because we committed the transaction on
> snapshot delete.  However a recent change to that code removed the
> delete, so it was much easier to reproduce this issue.

This last sentence, isn't clear because:

1) Recent change, which one? Can you mention the commit id and subject?

2) "removed the delete"? Shouldn't this be "removed the transaction
commit"? Otherwise it doesn't make sense.

> We noticed this
> in production because our shutdown path stops the container on the
> system, which deletes a bunch of subvolumes, and then reboots the box.
> This gives us plenty of opportunities to hit this issue.  Looking at the
> history we've seen this occasionally in production, but we had a big
> spike recently thanks to faster machines getting put onto kernels with
> the fix to no longer commit the transaction on subvolume delete.
>
> Chris Mason wrote a reproducer which does the following
>
> mount /dev/nvme4n1 /btrfs
> btrfs subvol create /btrfs/s1
> simoop -E -f 4k -n 200000 -z /btrfs/s1
> while(true) ; do
>         btrfs subvol snap /btrfs/s1 /btrfs/s2
>         simoop -f 4k -n 200000 -r 10 -z /btrfs/s2
>         btrfs subvol snap /btrfs/s2 /btrfs/s3
>         btrfs balance start -dusage=3D80 /btrfs
>         btrfs subvol del /btrfs/s2 /btrfs/s3
>         umount /btrfs
>         btrfsck /dev/nvme4n1 || exit 1
>         mount /dev/nvme4n1 /btrfs
> done
>
> On the second loop this would fail consistently, with my patch it has
> been running for hours and hasn't failed.

Is there a way to exercise this with fstests, using fsstress for example?

>
> I also used dm-log-writes to capture the state of the failure so I could
> debug the problem.  Using the existing failure case to test my patch
> validated that it fixes the problem.
>
> Fixes: 78c52d9eb6b7 ("btrfs: check for refs on snapshot delete resume")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/delayed-ref.c | 67 ++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/delayed-ref.h |  2 ++
>  fs/btrfs/extent-tree.c | 51 ++++++++++++++++++++++++++++----
>  3 files changed, 114 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index e44e62cf76bc..2d43cb4b2106 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -1297,6 +1297,73 @@ btrfs_find_delayed_ref_head(struct btrfs_delayed_r=
ef_root *delayed_refs, u64 byt
>         return find_ref_head(delayed_refs, bytenr, false);
>  }
>
> +static int find_comp(struct btrfs_delayed_ref_node *entry, u64 root, u64=
 parent)
> +{
> +       struct btrfs_delayed_tree_ref *ref;
> +       int type =3D parent ? BTRFS_SHARED_BLOCK_REF_KEY : BTRFS_TREE_BLO=
CK_REF_KEY;
> +
> +       if (type < entry->type)
> +               return -1;
> +       if (type > entry->type)
> +               return 1;
> +
> +       ref =3D btrfs_delayed_node_to_tree_ref(entry);
> +       if (type =3D=3D BTRFS_TREE_BLOCK_REF_KEY) {
> +               if (root < ref->root)
> +                       return -1;
> +               if (root > ref->root)
> +                       return 1;
> +       } else {
> +               if (parent < ref->parent)
> +                       return -1;
> +               if (parent > ref->parent)
> +                       return 1;
> +       }
> +       return 0;
> +}
> +
> +/*
> + * Check to see if a given root/parent reference is attached to the head=
.  This
> + * only checks for BTRFS_ADD_DELAYED_REF references that match, as that
> + * indicates the reference exists for the given root or parent.  This is=
 for
> + * tree blocks only.
> + *
> + * @head: the head of the bytenr we're searching.
> + * @root: the root objectid of the reference if it is a normal reference=
.
> + * @parent: the parent if this is a shared backref.
> + */
> +bool btrfs_find_delayed_tree_ref(struct btrfs_delayed_ref_head *head,
> +                                u64 root, u64 parent)
> +{
> +       struct rb_node *node;
> +       bool found =3D false;
> +

Shouldn't assert that head->mutex is held?

> +       spin_lock(&head->lock);
> +       node =3D head->ref_tree.rb_root.rb_node;
> +       while (node) {
> +               struct btrfs_delayed_ref_node *entry;
> +               int ret;
> +
> +               entry =3D rb_entry(node, struct btrfs_delayed_ref_node, r=
ef_node);
> +               ret =3D find_comp(entry, root, parent);
> +               if (ret < 0)
> +                       node =3D node->rb_left;
> +               else if (ret > 0)
> +                       node =3D node->rb_right;
> +               else {
> +                       /*
> +                        * We only want to count ADD actions, as drops me=
an the
> +                        * ref doesn't exist.
> +                        */
> +                       if (entry->action =3D=3D BTRFS_ADD_DELAYED_REF)
> +                               found =3D true;
> +                       break;
> +               }

All branches of the if statement should use { }, since the else is using th=
em.
IIRC even chechpatch.pl used to complain about that.

> +       }
> +       spin_unlock(&head->lock);
> +       return found;
> +}
> +
>  void __cold btrfs_delayed_ref_exit(void)
>  {
>         kmem_cache_destroy(btrfs_delayed_ref_head_cachep);
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index b291147cb8ab..34c34db01cc6 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -397,6 +397,8 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_inf=
o *fs_info,
>  void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
>                                        u64 num_bytes);
>  bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
> +bool btrfs_find_delayed_tree_ref(struct btrfs_delayed_ref_head *head,
> +                                u64 root, u64 parent);
>
>  /*
>   * helper functions to cast a node into its container
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 42314604906a..4d98bd247342 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5428,23 +5428,62 @@ static int check_ref_exists(struct btrfs_trans_ha=
ndle *trans,
>                             struct btrfs_root *root, u64 bytenr, u64 pare=
nt,
>                             int level)
>  {
> +       struct btrfs_delayed_ref_root *delayed_refs;
> +       struct btrfs_delayed_ref_head *head;
>         struct btrfs_path *path;
>         struct btrfs_extent_inline_ref *iref;
>         int ret;
> +       bool exists =3D false;
>
>         path =3D btrfs_alloc_path();
>         if (!path)
>                 return -ENOMEM;
> -
> +again:
>         ret =3D lookup_extent_backref(trans, path, &iref, bytenr,
>                                     root->fs_info->nodesize, parent,
>                                     root->root_key.objectid, level, 0);
> +       if (ret !=3D -ENOENT) {
> +               /* If we get 0 then we found our reference, return 1, els=
e

Another style nit, the comment should have the opening "/*" in a line by it=
self.

> +                * return the error if it's not -ENOENT;
> +                */
> +               btrfs_free_path(path);
> +               return (ret < 0 ) ? ret : 1;
> +       }
> +
> +       /*
> +        * We could have a delayed ref with this reference, so look it up=
 while
> +        * we're holding the path open to make sure we don't race with th=
e
> +        * delayed ref running.
> +        */
> +       delayed_refs =3D &trans->transaction->delayed_refs;
> +       spin_lock(&delayed_refs->lock);
> +       head =3D btrfs_find_delayed_ref_head(delayed_refs, bytenr);
> +       if (!head)
> +               goto out;
> +       if (!mutex_trylock(&head->mutex)) {
> +               /*
> +                * We're contended, means that the delayed ref is running=
, get a
> +                * reference and wait for the ref head to be complete and=
 then
> +                * try again.
> +                */
> +               refcount_inc(&head->refs);
> +               spin_unlock(&delayed_refs->lock);
> +
> +               btrfs_release_path(path);
> +
> +               mutex_lock(&head->mutex);
> +               mutex_unlock(&head->mutex);
> +               btrfs_put_delayed_ref_head(head);
> +               goto again;
> +       }
> +
> +       exists =3D btrfs_find_delayed_tree_ref(head, root->root_key.objec=
tid,
> +                                            parent);

Could all be placed in a single line, 84 characters is acceptable nowadays.

Anyway, apart from those clarifications/corrections in the changelog
and the code style nits, it looks correct to me.
So with those addressed:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +       mutex_unlock(&head->mutex);
> +out:
> +       spin_unlock(&delayed_refs->lock);
>         btrfs_free_path(path);
> -       if (ret =3D=3D -ENOENT)
> -               return 0;
> -       if (ret < 0)
> -               return ret;
> -       return 1;
> +       return exists ? 1 : 0;
>  }
>
>  /*
> --
> 2.43.0
>
>

