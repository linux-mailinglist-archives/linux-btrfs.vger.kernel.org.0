Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F10B314D9AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 12:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgA3L0C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 06:26:02 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44333 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgA3L0C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 06:26:02 -0500
Received: by mail-ua1-f67.google.com with SMTP id x16so1006096uao.11
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2020 03:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=QU1zGHPORXb9ZSQ4aqHUBPRzcACoD6449faypNdahzk=;
        b=vXZECMAdoXP9ZZKopnuS0jVbk44g8jaDTKzkT5G3LiyEGDkBUxO/TKhSORhR3R0Pde
         OAeYSY08AVf3IaLwliC32ZcWZo1v0PmiXOiyiEMoHjr+xHclV6GAlL2cmYa7S1xSABmO
         NDU+9xreBAlWd0yksfNcw/RS7jOvkqEpdM+wrf+3ALXQ60/w0MOQjXqDq4yl3Q/n7Xpk
         NuT7KI9va6D5AtmQCpStwl6TnI7s67/sIJq0AFpusT6ZkeC0UxrOVBiWgUQzXF4b8sMQ
         09puB+RALHzoJbNXX1E/4hnX3DjanTAUWLgS9cRe8XVzyaoYsTtPLdk6j9+CZnlzLz/R
         OnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=QU1zGHPORXb9ZSQ4aqHUBPRzcACoD6449faypNdahzk=;
        b=p/PTk7YLXwliV+ZfguNbEOwwC1uphTXXtylCZWQq6fs9dxrhNOZSl25BNaowlll+9b
         OU+U8fHZOLsrZ/thyWgVxwKphxR+pLdwygTS/9RVKiFHIMkX+GgdsGrX4Gg7OzztWTXP
         sKFil9qWJ7+KnCkwsaj8vWZizVZH5h6J17jWfxNXRgzXN4Ou09ZgURhrRIt/fww1wDag
         k6hAd0alqo6ZgD6i1hFmrX/xMya+H6T6bRYIs7SAJBcnD5QqBisRDuzf+W0L21l7AyWH
         sJF3vR1yjB4KJH16E7lHTGkpJm3H3lnRVM/LzE+QRWMpbEnnrSbcMFcgxnOF1tBUEnz/
         p1uA==
X-Gm-Message-State: APjAAAXkLJC/7bHAsHpt0S5zZssL1WQKRyL2gmIFIpm5Zu3RrMqBEIZz
        iX9tJ6qtjI1gdsOHcNDS09DCQedshfxglpgjr3k=
X-Google-Smtp-Source: APXvYqz+FcyUU3W9RhoydDQIdmJkiYzHmjvFkSdlG0QNrz8uVaqpzwH5dcc9aW0JzMmW3QA/k7Kmw1g8TgjOvslD0hU=
X-Received: by 2002:ab0:2a93:: with SMTP id h19mr2208078uar.27.1580383561057;
 Thu, 30 Jan 2020 03:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20200117140224.42495-1-josef@toxicpanda.com> <20200117140224.42495-4-josef@toxicpanda.com>
 <3c35e341-0313-54ce-77c9-0ca2eba4c85b@suse.com>
In-Reply-To: <3c35e341-0313-54ce-77c9-0ca2eba4c85b@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 30 Jan 2020 11:25:49 +0000
Message-ID: <CAL3q7H5f8Vd9dAHf2mSQ2-SSNHWQBtbDb56ivX3ijYR4uxs6Sg@mail.gmail.com>
Subject: Re: [PATCH 3/6] btrfs: introduce the inode->file_extent_tree
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 11:19 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 17.01.20 =D0=B3. 16:02 =D1=87., Josef Bacik wrote:
> > In order to keep track of where we have file extents on disk, and thus
> > where it is safe to adjust the i_size to, we need to have a tree in
> > place to keep track of the contiguous areas we have file extents for.
> > Add helpers to use this tree, as it's not required for NO_HOLES file
> > systems.  We will use this by setting DIRTY for areas we know we have
> > file extent item's set, and clearing it when we remove file extent item=
s
> > for truncation.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/btrfs_inode.h    |  5 +++
> >  fs/btrfs/ctree.h          |  5 +++
> >  fs/btrfs/extent-io-tree.h |  1 +
> >  fs/btrfs/extent_io.c      | 11 +++++
> >  fs/btrfs/file-item.c      | 91 +++++++++++++++++++++++++++++++++++++++
> >  fs/btrfs/inode.c          |  6 +++
> >  6 files changed, 119 insertions(+)
> >
> > diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> > index 4e12a477d32e..d9dcbac513ed 100644
> > --- a/fs/btrfs/btrfs_inode.h
> > +++ b/fs/btrfs/btrfs_inode.h
> > @@ -60,6 +60,11 @@ struct btrfs_inode {
> >        */
> >       struct extent_io_tree io_failure_tree;
> >
> > +     /* keeps track of where we have extent items mapped in order to m=
ake
> > +      * sure our i_size adjustments are accurate.
> > +      */
> > +     struct extent_io_tree file_extent_tree;
> > +
> >       /* held while logging the inode in tree-log.c */
> >       struct mutex log_mutex;
> >
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 00cf1641f1b9..8a2c1665baad 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -2851,6 +2851,11 @@ void btrfs_extent_item_to_extent_map(struct btrf=
s_inode *inode,
> >                                    struct btrfs_file_extent_item *fi,
> >                                    const bool new_inline,
> >                                    struct extent_map *em);
> > +int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64=
 start,
> > +                                     u64 len);
> > +int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 s=
tart,
> > +                                   u64 len);
> > +void btrfs_inode_safe_disk_i_size_write(struct inode *inode, u64 new_i=
size);
> >
> >  /* inode.c */
> >  struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
> > diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> > index a3febe746c79..c8bcd2e3184c 100644
> > --- a/fs/btrfs/extent-io-tree.h
> > +++ b/fs/btrfs/extent-io-tree.h
> > @@ -44,6 +44,7 @@ enum {
> >       IO_TREE_TRANS_DIRTY_PAGES,
> >       IO_TREE_ROOT_DIRTY_LOG_PAGES,
> >       IO_TREE_SELFTEST,
> > +     IO_TREE_INODE_FILE_EXTENT,
> >  };
> >
> >  struct extent_io_tree {
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 0d40cd7427ba..f9b223d827b3 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -265,6 +265,15 @@ void __cold extent_io_exit(void)
> >       bioset_exit(&btrfs_bioset);
> >  }
> >
> > +/*
> > + * For the file_extent_tree, we want to hold the inode lock when we lo=
okup and
> > + * update the disk_i_size, but lockdep will complain because our io_tr=
ee we hold
> > + * the tree lock and get the inode lock when setting delalloc.  These =
two things
> > + * are unrelated, so make a class for the file_extent_tree so we don't=
 get the
> > + * two locking patterns mixed up.
> > + */
> > +static struct lock_class_key file_extent_tree_class;
> > +
> >  void extent_io_tree_init(struct btrfs_fs_info *fs_info,
> >                        struct extent_io_tree *tree, unsigned int owner,
> >                        void *private_data)
> > @@ -276,6 +285,8 @@ void extent_io_tree_init(struct btrfs_fs_info *fs_i=
nfo,
> >       spin_lock_init(&tree->lock);
> >       tree->private_data =3D private_data;
> >       tree->owner =3D owner;
> > +     if (owner =3D=3D IO_TREE_INODE_FILE_EXTENT)
> > +             lockdep_set_class(&tree->lock, &file_extent_tree_class);
> >  }
> >
> >  void extent_io_tree_release(struct extent_io_tree *tree)
> > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > index c2f365662d55..e5dc6c4b2f05 100644
> > --- a/fs/btrfs/file-item.c
> > +++ b/fs/btrfs/file-item.c
> > @@ -23,6 +23,97 @@
> >  #define MAX_CSUM_ITEMS(r, size) (min_t(u32, __MAX_CSUM_ITEMS(r, size),=
 \
> >                                      PAGE_SIZE))
> >
> > +/**
> > + * @inode - the inode we want to update the disk_i_size for
> > + * @new_isize - the isize we want to set to, 0 if we use i_size
> > + *
> > + * With NO_HOLES set this simply sets the disk_is_size to whatever i_s=
ize_read()
> > + * returns as it is perfectly fine with a file that has holes without =
hole file
> > + * extent items.
> > + *
> > + * However for !NO_HOLES we need to only return the area that is conti=
guous from
> > + * the 0 offset of the file.  Otherwise we could end up adjust i_size =
up to an
> > + * extent that has a gap in between.
> > + *
> > + * Finally new_isize should only be set in the case of truncate where =
we're not
> > + * ready to use i_size_read() as the limiter yet.
> > + */
> > +void btrfs_inode_safe_disk_i_size_write(struct inode *inode, u64 new_i=
size)
> > +{
> > +     struct btrfs_fs_info *fs_info =3D BTRFS_I(inode)->root->fs_info;
> > +     u64 start, end, isize;
> > +     int ret;
> > +
> > +     isize =3D new_isize ? new_isize : i_size_read(inode);
> > +     if (btrfs_fs_incompat(fs_info, NO_HOLES)) {
> > +             BTRFS_I(inode)->disk_i_size =3D isize;
> > +             return;
> > +     }
> > +
> > +     spin_lock(&BTRFS_I(inode)->lock);
> > +     ret =3D find_first_extent_bit(&BTRFS_I(inode)->file_extent_tree, =
0,
> > +                                 &start, &end, EXTENT_DIRTY, NULL);
> > +     if (!ret && start =3D=3D 0)
> > +             isize =3D min(isize, end + 1);
> > +     else
> > +             isize =3D 0;
> > +     BTRFS_I(inode)->disk_i_size =3D isize;
> > +     spin_unlock(&BTRFS_I(inode)->lock);
> > +}
> > +
>
>
> What if we have the following layout for an inode:
>
> [----1M-EXT=D0=95NT---][----2M-HOLE--------][------3M-EXTENT-----------]
>
> In this case the idisk size should be 4m whereas with the above code it
> will be 1M. Isn't this wrong?

No. That's precisely the point - to set it to 1Mb because there's an
implicit hole after it. For explicit holes, it will be 4M (that's done
in another patch in the series).



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
