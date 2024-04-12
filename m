Return-Path: <linux-btrfs+bounces-4189-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E068A304F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 16:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEB21F21BAE
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 14:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E08D86120;
	Fri, 12 Apr 2024 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po1O5KRC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB77219FF
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931444; cv=none; b=GH4iOzRRR8IaC54v24tyggBN6N4nCelcvKL2BNKxjmuIJRSeoIq1ahuS7S0KlPhJJ+nbu+4sKaKw+n2rhrvJ7weUF8yQ3NedsoD+4WuFJ0rzsv2ylbcmPcz9aECFQ9nGSU/pU9LVa7JeWg1UU8ow2lTc1RAvpxBt/jOgy22c7uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931444; c=relaxed/simple;
	bh=oPvZKR/trDGTonYqZ8fbBSF1iwDYF7rrKdlBMJ3ZK08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UuWTnvU/ddjnUaHOkwSTRNL4xdC2e5NmaNuGJJ5TIEF/cxGTKW1vyckoCnwBWManNszT+KAyvV8qnIboJnNU10ybNINGdLLmjtKg8UP3ZBBIepB9oT3KloJCYIh1T8uX8KFkvYIU4ynKhMaVc3wJTW1XaUn4Y0CsZ2Fk5qBPpwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po1O5KRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470B4C2BD10
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 14:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712931444;
	bh=oPvZKR/trDGTonYqZ8fbBSF1iwDYF7rrKdlBMJ3ZK08=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Po1O5KRCZ5wtYYnH/GHlasAPIReZn7ESQsAeKerm2Az248OLG+dpxpGrxTQkC276L
	 vJwlM1bsNWy4V2+Ycy9SeyPCq9wuCfa+WTgYEorMoC4fk6FCfSuePH9oIqrKSqOd0b
	 26ljZLAjw3bPj90ZyhdhlO36RQrbfuFQWzuBgCWA2/m32yyY4yyAcbG1pe/CvQE/Ex
	 0CmjJWfJMEW8xSHOprgdVmYns3RsA9Q1zYSVJ0drVJAl+NL8rJGwPaivezHoeKUSZp
	 CzLDepuxEc5ITqyMF79fbCc6es9SZ+bvJvgB9I21KtnbQKAON1Xt3L0FH5ZN+8Y1LA
	 tPjEBNVMx8qBw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso123005966b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 07:17:24 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyw47B7hXvgIAJSnKVkdxyd+LsU5Odr5NV8g7ieXIKSHwEcS7w6
	ZXC5yKaD0rvk0NI96BY2N8lzrCyfKBvVRhsO2YOJETj+hue/tkIb488m8WL0xP8zmy4Goitqemh
	wpo6oi0fgEtsHWql0DyYrijmchcI=
X-Google-Smtp-Source: AGHT+IFdXaANtD6gp9u+atulDsfWzhUJjBXyW0Q+JC08EtWqkDDVvvdro8Cox8u/JP34Lcyf3EamVLj3rD//6NoWE9I=
X-Received: by 2002:a17:907:2cc4:b0:a52:2e97:190d with SMTP id
 hg4-20020a1709072cc400b00a522e97190dmr2316459ejc.69.1712931442635; Fri, 12
 Apr 2024 07:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3937cbcdf53440dcda98b64ce5e0e1cf8b15803d.1712929998.git.josef@toxicpanda.com>
In-Reply-To: <3937cbcdf53440dcda98b64ce5e0e1cf8b15803d.1712929998.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Apr 2024 15:16:45 +0100
X-Gmail-Original-Message-ID: <CAL3q7H48n9exXQ2vMLm5Do92N-BQAhaXT0JE+XcSNtKYqTnv1g@mail.gmail.com>
Message-ID: <CAL3q7H48n9exXQ2vMLm5Do92N-BQAhaXT0JE+XcSNtKYqTnv1g@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: check delayed refs when we're checking if a ref exists
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 2:55=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
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
> for subvolume a and one for subvolume b, and it belongs to subvolume a
> (btrfs_header_owner(block 1) =3D=3D subvolume a).
>
> When deleting subvolume a, we will drop our full reference for block 1,
> and because we are the owner we will drop our full reference for all of
> block 1's children, convert block 1 to FULL BACKREF, and add a shared
> reference to all of block 1's children.
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
> having multiple deleted snapshots pending when we unmount.  We noticed
> this in production because our shutdown path stops the container on the
> system, which deletes a bunch of subvolumes, and then reboots the box.
> This gives us plenty of opportunities to hit this issue.  Looking at the
> history we've seen this occasionally in production, but we had a big
> spike recently thanks to faster machines getting jobs with multiple
> subvolumes in the job.
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
>
> I also used dm-log-writes to capture the state of the failure so I could
> debug the problem.  Using the existing failure case to test my patch
> validated that it fixes the problem.
>
> Fixes: 78c52d9eb6b7 ("btrfs: check for refs on snapshot delete resume")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> v1->v2:
> - Fixed up style nits pointed out by Filipe.
> - Fixed up the changelog to fix some wrong words and make things more cle=
ar.
>
>  fs/btrfs/delayed-ref.c | 69 ++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/delayed-ref.h |  2 ++
>  fs/btrfs/extent-tree.c | 51 +++++++++++++++++++++++++++----
>  3 files changed, 116 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index e44e62cf76bc..8c0970980acb 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -1297,6 +1297,75 @@ btrfs_find_delayed_ref_head(struct btrfs_delayed_r=
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
> +       lockdep_assert_held(&head->mutex);
> +
> +       spin_lock(&head->lock);
> +       node =3D head->ref_tree.rb_root.rb_node;
> +       while (node) {
> +               struct btrfs_delayed_ref_node *entry;
> +               int ret;
> +
> +               entry =3D rb_entry(node, struct btrfs_delayed_ref_node, r=
ef_node);
> +               ret =3D find_comp(entry, root, parent);
> +               if (ret < 0) {
> +                       node =3D node->rb_left;
> +               } else if (ret > 0) {
> +                       node =3D node->rb_right;
> +               } else {
> +                       /*
> +                        * We only want to count ADD actions, as drops me=
an the
> +                        * ref doesn't exist.
> +                        */
> +                       if (entry->action =3D=3D BTRFS_ADD_DELAYED_REF)
> +                               found =3D true;
> +                       break;
> +               }
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
> index 42314604906a..b21998c1e33f 100644
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
> +               /*
> +                * If we get 0 then we found our reference, return 1, els=
e
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
tid, parent);
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

