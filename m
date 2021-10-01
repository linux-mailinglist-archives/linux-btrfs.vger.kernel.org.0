Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C704141EF15
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Oct 2021 16:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhJAOG7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Oct 2021 10:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231438AbhJAOG7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Oct 2021 10:06:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3418061278
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Oct 2021 14:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633097115;
        bh=6Le+35HvWIg8HT5ufDXl9HdAQ3W52/6konFQNwjW4HI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X8kbLMt0iHpjW1yZuhGS3pFDdBVCPfnAB3qWgVADMucQ0YLzmY+fsZsHphByNmtgu
         cASwyjDvhIUhH/nNRCNcAhzf+UmPCOxa7gMyDud2rGAI7aUHlY5hPQ3GctlHBGtYZh
         N9eKJqXrNUd6sKhAqb30QcZF2jKhF9h7/eHtDRa1gDIYeqjZQ7w7zjX9pKT6RDk5n7
         x/KQnSNS3NEtIHMoC+mqjECcEgHqESy6KD4PvKfiL+sZyEQ3mDxq0zMNrHTIQzg1F3
         iK0lLoC6LNNvPx46FbAq9RsT9gxAD0UJ5+laPbvQTAF/A03T5bGapSTP6cnrLZ1MXh
         MuOslRSbjfHNw==
Received: by mail-qk1-f181.google.com with SMTP id 194so9173812qkj.11
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Oct 2021 07:05:15 -0700 (PDT)
X-Gm-Message-State: AOAM531I/tXfB7bNYF1jEh6BZysDMCQRdbhYo339glkdcVr0Fd77dbHA
        EnNZbq894IrPIKBgeyPD+1uv+qju3u44l3dOxIk=
X-Google-Smtp-Source: ABdhPJw7Uoxt28+i1WMBjotkTD6R756dUtI2MqXE3zHg6pDYA6PNpdhrxaIOZZAwm/8p1vmEhtvjVPoJd0DD6YuUsDA=
X-Received: by 2002:a37:b647:: with SMTP id g68mr9598023qkf.39.1633097114376;
 Fri, 01 Oct 2021 07:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633082623.git.fdmanana@suse.com> <2c11d304684692a7f41d34c149099580f1bce9e8.1633082623.git.fdmanana@suse.com>
 <f3d480f1-36ef-229e-d3f2-469305250144@gmx.com>
In-Reply-To: <f3d480f1-36ef-229e-d3f2-469305250144@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 1 Oct 2021 15:04:37 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7MM6GdW2J14+rMh-RX7yR4hPhUQF=NhHQcUyVPyTiBOA@mail.gmail.com>
Message-ID: <CAL3q7H7MM6GdW2J14+rMh-RX7yR4hPhUQF=NhHQcUyVPyTiBOA@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: deal with errors when checking if a dir entry
 exists during log replay
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 1, 2021 at 2:14 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/10/1 20:52, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Currently inode_in_dir() ignores errors returned from
> > btrfs_lookup_dir_index_item() and from btrfs_lookup_dir_item(), treating
> > any errors as if the directory entry does not exists in the fs/subvolume
> > tree, which is obviously not correct, as we can get errors such as -EIO
> > when reading extent buffers while searching the fs/subvolume's tree.
> >
> > Fix that by making inode_in_dir() return the errors and making its only
> > caller, add_inode_ref(), deal with returned errors as well.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/tree-log.c | 47 ++++++++++++++++++++++++++++-----------------
> >   1 file changed, 29 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index b765ca7536fe..79d7cca704fb 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -967,9 +967,11 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
> >   }
> >
> >   /*
> > - * helper function to see if a given name and sequence number found
> > - * in an inode back reference are already in a directory and correctly
> > - * point to this inode
> > + * Helper function to see if a given name and sequence number found in an inode
> > + * back reference are already in a directory and correctly point to this inode.
> > + *
> > + * Returns: < 0 on error, 0 if the directory entry does not exists and 1 if it
> > + * exists.
> >    */
> >   static noinline int inode_in_dir(struct btrfs_root *root,
> >                                struct btrfs_path *path,
> > @@ -978,29 +980,35 @@ static noinline int inode_in_dir(struct btrfs_root *root,
> >   {
> >       struct btrfs_dir_item *di;
> >       struct btrfs_key location;
> > -     int match = 0;
> > +     int ret = 0;
> >
> >       di = btrfs_lookup_dir_index_item(NULL, root, path, dirid,
> >                                        index, name, name_len, 0);
>
> I did a quick search for "btrfs_lookup_dir_", and find most if not all
> callers are handling the NULL case just like ENOENT.
>
> Can we make btrfs_lookup_match_dir() to return -ENOENT when the target
> is not found?
>
> Return NULL while we still have another PTR_ERR(-ENOENT) to indicate not
> found is really asking for problems.

Yes it is. And that's what the last patch does, it makes the two
functions consistent regarding the return value.

Thanks.

>
> Thanks,
> Qu
> > -     if (di && !IS_ERR(di)) {
> > +     if (IS_ERR(di)) {
> > +             if (PTR_ERR(di) != -ENOENT)
> > +                     ret = PTR_ERR(di);
> > +             goto out;
> > +     } else if (di) {
> >               btrfs_dir_item_key_to_cpu(path->nodes[0], di, &location);
> >               if (location.objectid != objectid)
> >                       goto out;
> > -     } else
> > +     } else {
> >               goto out;
> > -     btrfs_release_path(path);
> > +     }
> >
> > +     btrfs_release_path(path);
> >       di = btrfs_lookup_dir_item(NULL, root, path, dirid, name, name_len, 0);
> > -     if (di && !IS_ERR(di)) {
> > -             btrfs_dir_item_key_to_cpu(path->nodes[0], di, &location);
> > -             if (location.objectid != objectid)
> > -                     goto out;
> > -     } else
> > +     if (IS_ERR(di)) {
> > +             ret = PTR_ERR(di);
> >               goto out;
> > -     match = 1;
> > +     } else if (di) {
> > +             btrfs_dir_item_key_to_cpu(path->nodes[0], di, &location);
> > +             if (location.objectid == objectid)
> > +                     ret = 1;
> > +     }
> >   out:
> >       btrfs_release_path(path);
> > -     return match;
> > +     return ret;
> >   }
> >
> >   /*
> > @@ -1545,10 +1553,12 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
> >               if (ret)
> >                       goto out;
> >
> > -             /* if we already have a perfect match, we're done */
> > -             if (!inode_in_dir(root, path, btrfs_ino(BTRFS_I(dir)),
> > -                                     btrfs_ino(BTRFS_I(inode)), ref_index,
> > -                                     name, namelen)) {
> > +             ret = inode_in_dir(root, path, btrfs_ino(BTRFS_I(dir)),
> > +                                btrfs_ino(BTRFS_I(inode)), ref_index,
> > +                                name, namelen);
> > +             if (ret < 0) {
> > +                     goto out;
> > +             } else if (ret == 0) {
> >                       /*
> >                        * look for a conflicting back reference in the
> >                        * metadata. if we find one we have to unlink that name
> > @@ -1608,6 +1618,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
> >                       if (ret)
> >                               goto out;
> >               }
> > +             /* Else, ret == 1, we already have a perfect match, we're done. */
> >
> >               ref_ptr = (unsigned long)(ref_ptr + ref_struct_size) + namelen;
> >               kfree(name);
> >
