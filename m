Return-Path: <linux-btrfs+bounces-4860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC17B8C0CC2
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 10:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6264D285CA4
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 08:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5AD149C4F;
	Thu,  9 May 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZL8Bcxj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE0E13C915
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715244149; cv=none; b=tGVP1tH/3fq8N6CXrRQVEzlFewkE8xj3lAf/jp+Omh+PJsKvR+RqRgLr9MmFdaVOU8tftmCE6MRxhVInse04C5/MU3C8OOJnAUmDtxiSlu7moDXloh6fsxgKkwqNOai4Zg95TW7dtgpqFDFRXb9nQvfnSV1wS+zHfA7jln+oUDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715244149; c=relaxed/simple;
	bh=eSiEyi8WDy3Zu4ikI59of01PGfw/qHTyVixwbTL3Al8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CU0/J1MfYVR5EPN4Peq136V4R42S2DDLFeyymbEFIOlDAhuP7Vj1BAzJdkUacRaYeyPKp1YDZho/i2uWMJ1XawCV4LrgySUKzb/1tNTLYh5nl+/4e/7FBjJbVRcQj0pElm+YoktnXqs4rp//nEiQtWk9OAPvcixEa4gAx6n3Iy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZL8Bcxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35FFC116B1
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 08:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715244148;
	bh=eSiEyi8WDy3Zu4ikI59of01PGfw/qHTyVixwbTL3Al8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OZL8BcxjYgQpE4gxTPmARBxHuz/dKhDK88fTHWYBb44XZtU6KEGOMnuFlnoQgsHXl
	 mElJG+g4+s2mJnOsg0re+NWoqkrMpAi0ByawFZ2S40g3pgf34E3MGEncCt/Wi4exVD
	 Bt/pb1tYT+0sKaq7K1PWspfDX1XH8Rg5AIcgco0Lbt/TxJ9JXFbawcVOrCtlnhqLuF
	 a2TEw+RyZnHUJpjv5lO+JXhtQPHkXv/dleg2ZqpTloMGO1R9Kee2JxHaec6PLU7bwf
	 9jS+lK0FxUqi+Q7KYIP5S9IhJoY+rhowJYgmKB83Uyr2KY5Pgy5LrSmAZDl+e1uDb2
	 HM2BsqUuB3pgg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a599a298990so139635066b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 09 May 2024 01:42:28 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx4NVE2L9v+VJoxTG0vtWDyuIEO8JvFKW2rA24SHXpABIhtS3RZ
	3wDPe9SOadGXK1lQ4RCwoZR2yNZNO1KD6CN/z9IjRZaJGdVJ/TxD0vmn5FtxgAKdCzjD5p63hH9
	l+SuYIXeHI7DyfyKPjNlSiOScnVQ=
X-Google-Smtp-Source: AGHT+IHCBlOUCDoXv4NkyupHwgBEWBgnSBBHF2/NBLpLqt+7CcjR8okhXXrvyBo41mx8ihI3R0/of1cDOSoQkEwPVZI=
X-Received: by 2002:a17:906:5395:b0:a59:af54:1651 with SMTP id
 a640c23a62f3a-a59fb9c6ce3mr336644066b.57.1715244147312; Thu, 09 May 2024
 01:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715169723.git.fdmanana@suse.com> <13d914be0518dc3f4a8086f96275c3b8bf113d63.1715169723.git.fdmanana@suse.com>
 <39f3094b-4e6a-4f72-8ba7-c013a33a05ad@gmx.com>
In-Reply-To: <39f3094b-4e6a-4f72-8ba7-c013a33a05ad@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 9 May 2024 09:41:50 +0100
X-Gmail-Original-Message-ID: <CAL3q7H655KkXXTYutyReiJf41F61-qzveCJh9nmKfOH8f47Row@mail.gmail.com>
Message-ID: <CAL3q7H655KkXXTYutyReiJf41F61-qzveCJh9nmKfOH8f47Row@mail.gmail.com>
Subject: Re: [PATCH 6/8] btrfs: don't allocate file extent tree for non
 regular files
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 1:39=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
>
>
> =E5=9C=A8 2024/5/8 21:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When not using the NO_HOLES feature we always allocate an io tree for a=
n
> > inode's file_extent_tree.
>
> I'm wondering can we discard non-NO_HOLES support directly so that we
> can get rid of the file_extent_tree completely?
>
> Initially I'm wondering why NO_HOLES makes a difference, especially as
> NO_HOLES can be set halfway, thus we can still have explicit hole extents=
.
>
> But it turns out that the whole file_extent_tree() is only to handle
> non-NO_HOLES case so that we always have a hole for the whole file range
> until i_size.
>
> Considering NO_HOLES is considered safe at 4.0 kernel, can we start
> deprecating non-NO_HOLES?

NO_HOLES is a mkfs default for only 2 or 3 years IIRC. It's not that long.

And how do you know everyone is already using NO_HOLES?
Last week I saw a user filesystem that doesn't use it.

And probably there are many more.

>
> > This is wasteful because that io tree is only
> > used for regular files, so we allocate more memory than needed for inod=
es
> > that represent directories or symlinks for example, or for inodes that
> > correspond to free space inodes.
> >
> > So improve on this by allocating the io tree only for inodes of regular
> > files that are not free space inodes.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Otherwise looks good to me.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Thanks,
> Qu
>
> > ---
> >   fs/btrfs/file-item.c | 13 ++++++-----
> >   fs/btrfs/inode.c     | 53 +++++++++++++++++++++++++++++--------------=
-
> >   2 files changed, 42 insertions(+), 24 deletions(-)
> >
> > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > index bce95f871750..f3ed78e21fa4 100644
> > --- a/fs/btrfs/file-item.c
> > +++ b/fs/btrfs/file-item.c
> > @@ -45,13 +45,12 @@
> >    */
> >   void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u6=
4 new_i_size)
> >   {
> > -     struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> >       u64 start, end, i_size;
> >       int ret;
> >
> >       spin_lock(&inode->lock);
> >       i_size =3D new_i_size ?: i_size_read(&inode->vfs_inode);
> > -     if (btrfs_fs_incompat(fs_info, NO_HOLES)) {
> > +     if (!inode->file_extent_tree) {
> >               inode->disk_i_size =3D i_size;
> >               goto out_unlock;
> >       }
> > @@ -84,13 +83,14 @@ void btrfs_inode_safe_disk_i_size_write(struct btrf=
s_inode *inode, u64 new_i_siz
> >   int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 =
start,
> >                                     u64 len)
> >   {
> > +     if (!inode->file_extent_tree)
> > +             return 0;
> > +
> >       if (len =3D=3D 0)
> >               return 0;
> >
> >       ASSERT(IS_ALIGNED(start + len, inode->root->fs_info->sectorsize))=
;
> >
> > -     if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
> > -             return 0;
> >       return set_extent_bit(inode->file_extent_tree, start, start + len=
 - 1,
> >                             EXTENT_DIRTY, NULL);
> >   }
> > @@ -112,14 +112,15 @@ int btrfs_inode_set_file_extent_range(struct btrf=
s_inode *inode, u64 start,
> >   int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u6=
4 start,
> >                                       u64 len)
> >   {
> > +     if (!inode->file_extent_tree)
> > +             return 0;
> > +
> >       if (len =3D=3D 0)
> >               return 0;
> >
> >       ASSERT(IS_ALIGNED(start + len, inode->root->fs_info->sectorsize) =
||
> >              len =3D=3D (u64)-1);
> >
> > -     if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
> > -             return 0;
> >       return clear_extent_bit(inode->file_extent_tree, start,
> >                               start + len - 1, EXTENT_DIRTY, NULL);
> >   }
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 9b98aa65cc63..175fd007f0ef 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -3781,6 +3781,30 @@ static noinline int acls_after_inode_item(struct=
 extent_buffer *leaf,
> >       return 1;
> >   }
> >
> > +static int btrfs_init_file_extent_tree(struct btrfs_inode *inode)
> > +{
> > +     struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> > +
> > +     if (WARN_ON_ONCE(inode->file_extent_tree))
> > +             return 0;
> > +     if (btrfs_fs_incompat(fs_info, NO_HOLES))
> > +             return 0;
> > +     if (!S_ISREG(inode->vfs_inode.i_mode))
> > +             return 0;
> > +     if (btrfs_is_free_space_inode(inode))
> > +             return 0;
> > +
> > +     inode->file_extent_tree =3D kmalloc(sizeof(struct extent_io_tree)=
, GFP_KERNEL);
> > +     if (!inode->file_extent_tree)
> > +             return -ENOMEM;
> > +
> > +     extent_io_tree_init(fs_info, inode->file_extent_tree, IO_TREE_INO=
DE_FILE_EXTENT);
> > +     /* Lockdep class is set only for the file extent tree. */
> > +     lockdep_set_class(&inode->file_extent_tree->lock, &file_extent_tr=
ee_class);
> > +
> > +     return 0;
> > +}
> > +
> >   /*
> >    * read an inode from the btree into the in-memory inode
> >    */
> > @@ -3800,6 +3824,10 @@ static int btrfs_read_locked_inode(struct inode =
*inode,
> >       bool filled =3D false;
> >       int first_xattr_slot;
> >
> > +     ret =3D btrfs_init_file_extent_tree(BTRFS_I(inode));
> > +     if (ret)
> > +             return ret;
> > +
> >       ret =3D btrfs_fill_inode(inode, &rdev);
> >       if (!ret)
> >               filled =3D true;
> > @@ -6247,6 +6275,10 @@ int btrfs_create_new_inode(struct btrfs_trans_ha=
ndle *trans,
> >               BTRFS_I(inode)->root =3D btrfs_grab_root(BTRFS_I(dir)->ro=
ot);
> >       root =3D BTRFS_I(inode)->root;
> >
> > +     ret =3D btrfs_init_file_extent_tree(BTRFS_I(inode));
> > +     if (ret)
> > +             goto out;
> > +
> >       ret =3D btrfs_get_free_objectid(root, &objectid);
> >       if (ret)
> >               goto out;
> > @@ -8413,20 +8445,10 @@ struct inode *btrfs_alloc_inode(struct super_bl=
ock *sb)
> >       struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
> >       struct btrfs_inode *ei;
> >       struct inode *inode;
> > -     struct extent_io_tree *file_extent_tree =3D NULL;
> > -
> > -     /* Self tests may pass a NULL fs_info. */
> > -     if (fs_info && !btrfs_fs_incompat(fs_info, NO_HOLES)) {
> > -             file_extent_tree =3D kmalloc(sizeof(struct extent_io_tree=
), GFP_KERNEL);
> > -             if (!file_extent_tree)
> > -                     return NULL;
> > -     }
> >
> >       ei =3D alloc_inode_sb(sb, btrfs_inode_cachep, GFP_KERNEL);
> > -     if (!ei) {
> > -             kfree(file_extent_tree);
> > +     if (!ei)
> >               return NULL;
> > -     }
> >
> >       ei->root =3D NULL;
> >       ei->generation =3D 0;
> > @@ -8471,13 +8493,8 @@ struct inode *btrfs_alloc_inode(struct super_blo=
ck *sb)
> >       extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO);
> >       ei->io_tree.inode =3D ei;
> >
> > -     ei->file_extent_tree =3D file_extent_tree;
> > -     if (file_extent_tree) {
> > -             extent_io_tree_init(fs_info, ei->file_extent_tree,
> > -                                 IO_TREE_INODE_FILE_EXTENT);
> > -             /* Lockdep class is set only for the file extent tree. */
> > -             lockdep_set_class(&ei->file_extent_tree->lock, &file_exte=
nt_tree_class);
> > -     }
> > +     ei->file_extent_tree =3D NULL;
> > +
> >       mutex_init(&ei->log_mutex);
> >       spin_lock_init(&ei->ordered_tree_lock);
> >       ei->ordered_tree =3D RB_ROOT;

