Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C62F1E4E87
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 21:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgE0Tso (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 15:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgE0Tso (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 15:48:44 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64C5C05BD1E
        for <linux-btrfs@vger.kernel.org>; Wed, 27 May 2020 12:48:42 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id v26so14484270vsa.1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 May 2020 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=JwwOc+0zly87QaWbprg4WYTQMZEauRC9ihULxRO7+ok=;
        b=RWc125zmElPoI7IX/eiPcBPO6Sh5+LviDqW73pZpQHYELCn6SqbqZYVbQky0BPA7DU
         oPVBz7dXI49HZG1TchjP24lJKbWry1VaJlPoJsoCSotdU3D+plylzOJjYXGGQtM1d2hg
         qwKHXXlTwAp6DaPKX32zH2t0PI/74CXyWLZkvsOLPOJ6gwil4nZ0tPwVEWfruZeNoR2U
         cfrJGxSuFtIGsA3gq9SZn6BIsr3r1i8sskpuAdyUtEFo5KU41xIeoWJtq5SYTSjOCokJ
         KeOk+Rs58XwxNfWCFKKEQu1J3ACAPvr/6Bo2C/9h+2QnvPimF9rkqZOrFH+Ni/OhHpbF
         GDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=JwwOc+0zly87QaWbprg4WYTQMZEauRC9ihULxRO7+ok=;
        b=VpuJzfJck7hLZo4YAWGAG8YCwFst2pdd6XbZ1vlnGEMu2u5OcMann9Quf6/crgB/fV
         Eumpbo89IYPxzruxdThe8qkzA3Id6nRR9/BKRbJY1QMvXhZb8ZqTLQgOPeHfK/Ap8ZWZ
         nd61WhdTvyj2rb0rXPbjJSSRXuqXVeffW3N/1XbRZ9jVH32JnFwl6o2JyzGiSjJY18y9
         sHMNjp+MCCM7HY4pdtPZjZwn1uVcRw8KSK7lVWJgkIQgKQaBvisTfnR7ffOuNlUFKu3R
         rHBr1qcbJZjx/jQPH48L4I0+ktzEqx/m61VtrW3HtcQQLc6Ok2ob3oFJbQReSjQSRc4/
         RRFg==
X-Gm-Message-State: AOAM530jainQ2fG7suwKP5ouGbjLhFulaf37ya4A1R/OxydUWSAQy2Z+
        wBLm5n6h70SBfJhnn51SlKFnGIKxd/adZN7wy/E=
X-Google-Smtp-Source: ABdhPJwnOGJektcwV8U6gHe7NHqt1fa+eniNGUorFzMNbOorxUzMBZUmHUTprH+T1TuWUqZFzUuhUHqabmiXvjw787I=
X-Received: by 2002:a67:dc89:: with SMTP id g9mr626571vsk.206.1590608922021;
 Wed, 27 May 2020 12:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200527101104.7441-1-nborisov@suse.com>
In-Reply-To: <20200527101104.7441-1-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 27 May 2020 20:48:31 +0100
Message-ID: <CAL3q7H5vZdvgs7Jsu3jp-9BFyv=XyBEJQOE-xytgzmud2we5Gw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Remove BTRFS_INODE_IN_DELALLOC_LIST flag
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 27, 2020 at 12:42 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
> The flag simply replicates whether btrfs_inode::delallocs_inodes list
> is empty or not. Just defer this check to the list management functions
> (btrfs_add_delalloc_inodes/__btrfs_del_delalloc_inode) which are
> always called under btrfs_root::delalloc_lock.

The flag is there to avoid taking the root's delalloc_lock spinlock
everytime a range is marked for delalloc for any inode of the
subvolume.
Have you measured performance with very high concurrency of buffered
writes against files in the same subvolume?

Thanks.

>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/btrfs_inode.h |  1 -
>  fs/btrfs/inode.c       | 11 ++---------
>  2 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index aeff56a0e105..da6743c70412 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -27,7 +27,6 @@ enum {
>         BTRFS_INODE_HAS_ASYNC_EXTENT,
>         BTRFS_INODE_NEEDS_FULL_SYNC,
>         BTRFS_INODE_COPY_EVERYTHING,
> -       BTRFS_INODE_IN_DELALLOC_LIST,
>         BTRFS_INODE_HAS_PROPS,
>         BTRFS_INODE_SNAPSHOT_FLUSH,
>  };
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 7d2f6e55a234..3e87a6644e09 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1865,8 +1865,6 @@ static void btrfs_add_delalloc_inodes(struct btrfs_=
root *root,
>         if (list_empty(&BTRFS_I(inode)->delalloc_inodes)) {
>                 list_add_tail(&BTRFS_I(inode)->delalloc_inodes,
>                               &root->delalloc_inodes);
> -               set_bit(BTRFS_INODE_IN_DELALLOC_LIST,
> -                       &BTRFS_I(inode)->runtime_flags);
>                 root->nr_delalloc_inodes++;
>                 if (root->nr_delalloc_inodes =3D=3D 1) {
>                         spin_lock(&fs_info->delalloc_root_lock);
> @@ -1887,8 +1885,6 @@ void __btrfs_del_delalloc_inode(struct btrfs_root *=
root,
>
>         if (!list_empty(&inode->delalloc_inodes)) {
>                 list_del_init(&inode->delalloc_inodes);
> -               clear_bit(BTRFS_INODE_IN_DELALLOC_LIST,
> -                         &inode->runtime_flags);
>                 root->nr_delalloc_inodes--;
>                 if (!root->nr_delalloc_inodes) {
>                         ASSERT(list_empty(&root->delalloc_inodes));
> @@ -1944,8 +1940,7 @@ void btrfs_set_delalloc_extent(struct inode *inode,=
 struct extent_state *state,
>                 BTRFS_I(inode)->delalloc_bytes +=3D len;
>                 if (*bits & EXTENT_DEFRAG)
>                         BTRFS_I(inode)->defrag_bytes +=3D len;
> -               if (do_list && !test_bit(BTRFS_INODE_IN_DELALLOC_LIST,
> -                                        &BTRFS_I(inode)->runtime_flags))
> +               if (do_list)
>                         btrfs_add_delalloc_inodes(root, inode);
>                 spin_unlock(&BTRFS_I(inode)->lock);
>         }
> @@ -2014,9 +2009,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_=
inode,
>                                          fs_info->delalloc_batch);
>                 spin_lock(&inode->lock);
>                 inode->delalloc_bytes -=3D len;
> -               if (do_list && inode->delalloc_bytes =3D=3D 0 &&
> -                   test_bit(BTRFS_INODE_IN_DELALLOC_LIST,
> -                                       &inode->runtime_flags))
> +               if (do_list && inode->delalloc_bytes =3D=3D 0)
>                         btrfs_del_delalloc_inode(root, inode);
>                 spin_unlock(&inode->lock);
>         }
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
