Return-Path: <linux-btrfs+bounces-14665-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D069EADA24E
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Jun 2025 17:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D884F1890940
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Jun 2025 15:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FC7279DDE;
	Sun, 15 Jun 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b="dohG8V55"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E57A1E1C3F
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Jun 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750000886; cv=none; b=YcmJ11x2aApRP00iYoIcapuVcpueTNn/RpWPe2p+s9+2vRLiF1ZJ3hJ4YDHcKRwVV72wg+nQ9NI1gJWw496TaPtgSusuNLTtGqeiTWEoFBoc9a4JXI+dBOwfHd3jot6zOWEnzjaxdMbiC/DdmMKao5MpgJ1kR1ZzY29CHspNKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750000886; c=relaxed/simple;
	bh=+RwxJrS+UW6SDy0E9+8EthTonjxmnWL+iRC0IXhewUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZxwyh2HXhpDCi4aIIKzIwU/phsOz2FlVuo+Ab9PlPy6Zwvylydee9fvE9Z3k9hqdhiMyPH5DJ9jknKG+VhOdgIjUUxKkvqW64J8cbCTsdTuK0HM8VPsS/wL1B9wR+Odp+lwm4v97Tg0KLJTapNN4DiYS5W5h9Qpj8siT/i+akk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com; spf=pass smtp.mailfrom=zadarastorage.com; dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b=dohG8V55; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zadarastorage.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-747c2cc3419so2801155b3a.2
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Jun 2025 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara.com; s=google; t=1750000883; x=1750605683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlEPN2zPXA/yA0tuNT4ear8r5sbBUr6y98MNLRALjwk=;
        b=dohG8V55+8JAkSGL4znFLC4Jtm1K3S/u9It69yKQp2UeCB1jbeyuwAY+brHVLkne5H
         1Xl+1x32YY+4Quf/vi0vTjPvWRS7Lxq59o9pwBB5+Jp3P2eoOKQQydNx9AGe0qUPhLWi
         zOnjh8gU+RS82mvzw/cDjGFDEd1S8TaQlJGPR7nLZL39fYyuw42SURrx/DIlUmGT6oEI
         ecx7HphatcAw6fZqZ9P7tMZah98c73yKCo8d7wMGQVmxQtXWErAT8FYJZITa+y+wiMON
         ogMu3DVwmzUPwgm36IkkzPKM7l7wK5RYuo2AI8OVq84VA9mfdpcq4mbgE+M+Jdpi81gl
         6EcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750000883; x=1750605683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlEPN2zPXA/yA0tuNT4ear8r5sbBUr6y98MNLRALjwk=;
        b=Zcu92y2hn64wv9TXg8JYdOXqWuZjGV/RMgRAlhV/wMjkzAkdm+wpbn1Ra5SdVEvdKv
         8V+OMh7/m252zAYGcYXSl5gRUerrlCGtCFpWXVMr4d1mF6mgvY309UxCxfv0L+Ejkzss
         CqBIyUdTMJT2+EBs2m60cI6a96qV3phuHHrSk9m25aIejQ858i3FbaeebfyMS7TxxqYE
         +p15fDN4w+r1fBhttNmdNZQAwiCgEkR1BQrtYKr5ccwncTWQuDKX6550DUG8tHqSH36F
         fXEOqELh9Z6o7OKXE7nsoHE0Oq2hEOx6nimmM48HxmJZrHaXkWVdxsd7/IeMM+P8zQDh
         ZsrQ==
X-Gm-Message-State: AOJu0YzyJiEarPzeMSNPErc46j4Gi1oQEvc7SvaFBOpyXSxiIikpPiCw
	fZz7qV6Y/J0iKa69HkjcODMThTLc92k1pOGEY9pLiWZnSmeQ3Z5BIhVn6eCUxASPFTGRjGwpEu3
	wNB55E/kxpLyw5ZR+dORIcpxL5EUTs8fs26HWf/QZSA==
X-Gm-Gg: ASbGnctXVHYd9q3p7Jc2CxDL8TJGnHGTbWxMBuqYPcYpa8L4JGXLrupYEJA1Bn6x4iB
	33Sj0CBWeIsiXx7PV/taH5x9+OdESc/LnuCsJossFddnODhyKYBzz0Alduw2fb81Gfn3W+XVdmw
	3eWDolvipxF4/b74NJ3pdk7ZHU0GlSFCUBURm1a9jYCMM=
X-Google-Smtp-Source: AGHT+IGcUapSYTM9rKtBvfKMfywAIc66uUncf9wK9h3ltTpToO0YXkCqKA689lwxmo86wE6V/wlp8eCigLXl7WQSMtQ=
X-Received: by 2002:a05:6a00:2185:b0:740:6f69:8d94 with SMTP id
 d2e1a72fcca58-7489cd4987fmr7934851b3a.0.1750000883459; Sun, 15 Jun 2025
 08:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f64b44109b568df8a12daa8ee21fec172ef9cb26.1723040386.git.josef@toxicpanda.com>
 <CAOcd+r2r7NJiG-2VMwr51qGxznv9XrgO6_38Qf+J727X57=vig@mail.gmail.com>
In-Reply-To: <CAOcd+r2r7NJiG-2VMwr51qGxznv9XrgO6_38Qf+J727X57=vig@mail.gmail.com>
From: Alex Lyakas <alex.lyakas@zadara.com>
Date: Sun, 15 Jun 2025 18:21:12 +0300
X-Gm-Features: AX0GCFue2rcaTBgq-BMj6RtZv45UHpevpYifQRzJuLeJCmZugbyAKrgXiaXFl-8
Message-ID: <CAOcd+r2iS2URrHbaHfFjX2HPL0UG7oAoqjskgUTzapQFFUb0vw@mail.gmail.com>
Subject: Re: [PATCH][RESEND] btrfs: check delayed refs when we're checking if
 a ref exists
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josef,

> On Wed, Aug 7, 2024 at 5:21=E2=80=AFPM Josef Bacik <josef@toxicpanda.com>=
 wrote:
> >
> > In the patch 78c52d9eb6b7 ("btrfs: check for refs on snapshot delete
> > resume") I added some code to handle file systems that had been
> > corrupted by a bug that incorrectly skipped updating the drop progress
> > key while dropping a snapshot.  This code would check to see if we had
> > already deleted our reference for a child block, and skip the deletion
> > if we had already.
> >
> > Unfortunately there is a bug, as the check would only check the on-disk
> > references.  I made an incorrect assumption that blocks in an already
> > deleted snapshot that was having the deletion resume on mount wouldn't
> > be modified.
> >
> > If we have 2 pending deleted snapshots that share blocks, we can easily
> > modify the rules for a block.  Take the following example
> >
> > subvolume a exists, and subvolume b is a snapshot of subvolume a.  They
> > share references to block 1.  Block 1 will have 2 full references, one
> > for subvolume a and one for subvolume b, and it belongs to subvolume a
> > (btrfs_header_owner(block 1) =3D=3D subvolume a).
> >
> > When deleting subvolume a, we will drop our full reference for block 1,
> > and because we are the owner we will drop our full reference for all of
> > block 1's children, convert block 1 to FULL BACKREF, and add a shared
> > reference to all of block 1's children.
> >
> > Then we will start the snapshot deletion of subvolume b.  We look up th=
e
> > extent info for block 1, which checks delayed refs and tells us that
> > FULL BACKREF is set, so sets parent to the bytenr of block 1.  However
> > because this is a resumed snapshot deletion, we call into
> > check_ref_exists().  Because check_ref_exists() only looks at the disk,
> > it doesn't find the shared backref for the child of block 1, and thus
> > returns 0 and we skip deleting the reference for the child of block 1
> > and continue.  This orphans the child of block 1.
> >
> > The fix is to lookup the delayed refs, similar to what we do in
> > btrfs_lookup_extent_info().  However we only care about whether the
> > reference exists or not.  If we fail to find our reference on disk, go
> > look up the bytenr in the delayed refs, and if it exists look for an
> > existing ref in the delayed ref head.  If that exists then we know we
> > can delete the reference safely and carry on.  If it doesn't exist we
> > know we have to skip over this block.
> >
> > This bug has existed since I introduced this fix, however requires
> > having multiple deleted snapshots pending when we unmount.  We noticed
> > this in production because our shutdown path stops the container on the
> > system, which deletes a bunch of subvolumes, and then reboots the box.
> > This gives us plenty of opportunities to hit this issue.  Looking at th=
e
> > history we've seen this occasionally in production, but we had a big
> > spike recently thanks to faster machines getting jobs with multiple
> > subvolumes in the job.
> >
> > Chris Mason wrote a reproducer which does the following
> >
> > mount /dev/nvme4n1 /btrfs
> > btrfs subvol create /btrfs/s1
> > simoop -E -f 4k -n 200000 -z /btrfs/s1
> > while(true) ; do
> >         btrfs subvol snap /btrfs/s1 /btrfs/s2
> >         simoop -f 4k -n 200000 -r 10 -z /btrfs/s2
> >         btrfs subvol snap /btrfs/s2 /btrfs/s3
> >         btrfs balance start -dusage=3D80 /btrfs
> >         btrfs subvol del /btrfs/s2 /btrfs/s3
> >         umount /btrfs
> >         btrfsck /dev/nvme4n1 || exit 1
> >         mount /dev/nvme4n1 /btrfs
> > done
> >
> > On the second loop this would fail consistently, with my patch it has
> > been running for hours and hasn't failed.
> >
> > I also used dm-log-writes to capture the state of the failure so I coul=
d
> > debug the problem.  Using the existing failure case to test my patch
> > validated that it fixes the problem.
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > Fixes: 78c52d9eb6b7 ("btrfs: check for refs on snapshot delete resume")
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I see that this patch is marked as:

CC: stable@vger.kernel.org # 5.4+

However, in kernel 6.6 stable, this patch doesn't appear. Can you
please comment?

Thanks,
Alex.


> > ---
> > I dropped the ball on this, I've rebased it and I'm re-sending it just =
to make
> > sure people know I'm going to merge this.  If there are any questions l=
et me
> > know, otherwise I'll push this into our for-next branch tomorrow.
> >
> >  fs/btrfs/delayed-ref.c | 67 ++++++++++++++++++++++++++++++++++++++++++
> >  fs/btrfs/delayed-ref.h |  2 ++
> >  fs/btrfs/extent-tree.c | 51 ++++++++++++++++++++++++++++----
> >  3 files changed, 114 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> > index 2ac9296edccb..06a9e0542d70 100644
> > --- a/fs/btrfs/delayed-ref.c
> > +++ b/fs/btrfs/delayed-ref.c
> > @@ -1134,6 +1134,73 @@ btrfs_find_delayed_ref_head(struct btrfs_delayed=
_ref_root *delayed_refs, u64 byt
> >         return find_ref_head(delayed_refs, bytenr, false);
> >  }
> >
> > +static int find_comp(struct btrfs_delayed_ref_node *entry, u64 root, u=
64 parent)
> > +{
> > +       int type =3D parent ? BTRFS_SHARED_BLOCK_REF_KEY : BTRFS_TREE_B=
LOCK_REF_KEY;
> > +
> > +       if (type < entry->type)
> > +               return -1;
> > +       if (type > entry->type)
> > +               return 1;
> > +
> > +       if (type =3D=3D BTRFS_TREE_BLOCK_REF_KEY) {
> > +               if (root < entry->ref_root)
> > +                       return -1;
> > +               if (root > entry->ref_root)
> > +                       return 1;
> > +       } else {
> > +               if (parent < entry->parent)
> > +                       return -1;
> > +               if (parent > entry->parent)
> > +                       return 1;
> > +       }
> > +       return 0;
> > +}
> > +
> > +/*
> > + * Check to see if a given root/parent reference is attached to the he=
ad.  This
> > + * only checks for BTRFS_ADD_DELAYED_REF references that match, as tha=
t
> > + * indicates the reference exists for the given root or parent.  This =
is for
> > + * tree blocks only.
> > + *
> > + * @head: the head of the bytenr we're searching.
> > + * @root: the root objectid of the reference if it is a normal referen=
ce.
> > + * @parent: the parent if this is a shared backref.
> > + */
> > +bool btrfs_find_delayed_tree_ref(struct btrfs_delayed_ref_head *head,
> > +                                u64 root, u64 parent)
> > +{
> > +       struct rb_node *node;
> > +       bool found =3D false;
> > +
> > +       lockdep_assert_held(&head->mutex);
> > +
> > +       spin_lock(&head->lock);
> > +       node =3D head->ref_tree.rb_root.rb_node;
> > +       while (node) {
> > +               struct btrfs_delayed_ref_node *entry;
> > +               int ret;
> > +
> > +               entry =3D rb_entry(node, struct btrfs_delayed_ref_node,=
 ref_node);
> > +               ret =3D find_comp(entry, root, parent);
> > +               if (ret < 0) {
> > +                       node =3D node->rb_left;
> > +               } else if (ret > 0) {
> > +                       node =3D node->rb_right;
> > +               } else {
> > +                       /*
> > +                        * We only want to count ADD actions, as drops =
mean the
> > +                        * ref doesn't exist.
> > +                        */
> > +                       if (entry->action =3D=3D BTRFS_ADD_DELAYED_REF)
> > +                               found =3D true;
> > +                       break;
> > +               }
> > +       }
> > +       spin_unlock(&head->lock);
> > +       return found;
> > +}
> > +
> >  void __cold btrfs_delayed_ref_exit(void)
> >  {
> >         kmem_cache_destroy(btrfs_delayed_ref_head_cachep);
> > diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> > index ef15e998be03..05f634eb472d 100644
> > --- a/fs/btrfs/delayed-ref.h
> > +++ b/fs/btrfs/delayed-ref.h
> > @@ -389,6 +389,8 @@ void btrfs_dec_delayed_refs_rsv_bg_updates(struct b=
trfs_fs_info *fs_info);
> >  int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
> >                                   enum btrfs_reserve_flush_enum flush);
> >  bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info)=
;
> > +bool btrfs_find_delayed_tree_ref(struct btrfs_delayed_ref_head *head,
> > +                                u64 root, u64 parent);
> >
> >  static inline u64 btrfs_delayed_ref_owner(struct btrfs_delayed_ref_nod=
e *node)
> >  {
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index ff9f0d41987e..feec49e6f9c8 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -5472,23 +5472,62 @@ static int check_ref_exists(struct btrfs_trans_=
handle *trans,
> >                             struct btrfs_root *root, u64 bytenr, u64 pa=
rent,
> >                             int level)
> >  {
> > +       struct btrfs_delayed_ref_root *delayed_refs;
> > +       struct btrfs_delayed_ref_head *head;
> >         struct btrfs_path *path;
> >         struct btrfs_extent_inline_ref *iref;
> >         int ret;
> > +       bool exists =3D false;
> >
> >         path =3D btrfs_alloc_path();
> >         if (!path)
> >                 return -ENOMEM;
> > -
> > +again:
> >         ret =3D lookup_extent_backref(trans, path, &iref, bytenr,
> >                                     root->fs_info->nodesize, parent,
> >                                     btrfs_root_id(root), level, 0);
> > +       if (ret !=3D -ENOENT) {
> > +               /*
> > +                * If we get 0 then we found our reference, return 1, e=
lse
> > +                * return the error if it's not -ENOENT;
> > +                */
> > +               btrfs_free_path(path);
> > +               return (ret < 0 ) ? ret : 1;
> > +       }
> > +
> > +       /*
> > +        * We could have a delayed ref with this reference, so look it =
up while
> > +        * we're holding the path open to make sure we don't race with =
the
> > +        * delayed ref running.
> > +        */
> > +       delayed_refs =3D &trans->transaction->delayed_refs;
> > +       spin_lock(&delayed_refs->lock);
> > +       head =3D btrfs_find_delayed_ref_head(delayed_refs, bytenr);
> > +       if (!head)
> > +               goto out;
> > +       if (!mutex_trylock(&head->mutex)) {
> > +               /*
> > +                * We're contended, means that the delayed ref is runni=
ng, get a
> > +                * reference and wait for the ref head to be complete a=
nd then
> > +                * try again.
> > +                */
> > +               refcount_inc(&head->refs);
> > +               spin_unlock(&delayed_refs->lock);
> > +
> > +               btrfs_release_path(path);
> > +
> > +               mutex_lock(&head->mutex);
> > +               mutex_unlock(&head->mutex);
> > +               btrfs_put_delayed_ref_head(head);
> > +               goto again;
> > +       }
> > +
> > +       exists =3D btrfs_find_delayed_tree_ref(head, root->root_key.obj=
ectid, parent);
> > +       mutex_unlock(&head->mutex);
> > +out:
> > +       spin_unlock(&delayed_refs->lock);
> >         btrfs_free_path(path);
> > -       if (ret =3D=3D -ENOENT)
> > -               return 0;
> > -       if (ret < 0)
> > -               return ret;
> > -       return 1;
> > +       return exists ? 1 : 0;
> >  }
> >
> >  /*
> > --
> > 2.43.0
> >
> >

