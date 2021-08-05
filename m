Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F563E10B3
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 11:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbhHEJAf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Aug 2021 05:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbhHEJAf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Aug 2021 05:00:35 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8F0C061765
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Aug 2021 02:00:21 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c9so5483384qkc.13
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Aug 2021 02:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=UbBOs2iMgoTVdoUNbw+4bfAkGBefITNxta2gPDm3xic=;
        b=dLDkFiuXYa9ve0GShHQTtwe6kP91YC93Sz49aq16wN56B+J0GG6ZuQkezsg/DmKOCz
         DI/++QmmJ4I5MnD7z7UPdv+pSA2JCHBzrJhk+21YEczwUaSkqIhrrd6wOCrWyp/kMsUo
         oByE241KiuXZ8478p1vUsPssxkvDZVyiMOA2lggnwOQAvTZnI7L4RzuVQbsWegZeUgQ2
         3P2U3oTHM55S0SWCpFf/47MoNYKi9QqGsGktESnNQtcZdTLnzP1vqw/T1wN598DxHmue
         7u6C09ckSYGMkxCBTaZE7I2kvWkNnRrNQ1UFJaDs97CxrrAD/YFL6jrSHS/iXRMpN+tY
         zPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=UbBOs2iMgoTVdoUNbw+4bfAkGBefITNxta2gPDm3xic=;
        b=miP4iCacQhwDEovBh0KGvJRwuCljdTXvhem5Erp2gKHUGF50C17ZLs7F2OXJKa3dnK
         RZ/JdfOFgHeYUCm7I4t+yYH8gxm0azrA//9LG9juXWcP0TiURqa1/eVSqtUm+IkDpyo1
         IvqbB6WOzEegzwJOkZMz6YGBR/uYoAMwbha6V+UJ231PRS4qa74JSWpNLrhBgG/G6FCL
         5VUks/edKe4C92erHMEw6IRO+Cb9oiHy5uFtshAfebgz8emgFzxI9AYYA+RDGhZRwOI4
         sOS8pe0RwWVxI283qcrHVUmF2KVXkTbNwG2OSanriOzwwMJB9MeXGvM4rg7nKQGqv3al
         UFiQ==
X-Gm-Message-State: AOAM532/xARATgO5PQwb5ww52QFaXbRRi8GLjPDOsIgcPyPx85JE/gQ1
        GK+uRq3JXZD+nhMc6cQknO+6F706X8+6zrxe0Bg=
X-Google-Smtp-Source: ABdhPJxGzcHk2TXuLiVHJy9XmYVMRlkc5XnNRQHIBpkzQvMCUGMAaT8qb11Sf2NoAGztHUGrZnezGJDiVGd//6yM9BA=
X-Received: by 2002:a05:620a:190c:: with SMTP id bj12mr3663006qkb.479.1628154020426;
 Thu, 05 Aug 2021 02:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210804184854.10696-1-mpdesouza@suse.com> <20210804184854.10696-7-mpdesouza@suse.com>
In-Reply-To: <20210804184854.10696-7-mpdesouza@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 5 Aug 2021 10:00:09 +0100
Message-ID: <CAL3q7H7Ch+yQ6MzhHEHjpAOTKtYUsRByi-jgyQrp-dXEF6Ucgw@mail.gmail.com>
Subject: Re: [PATCH 6/7] btrfs: tree-log: Simplify log_new_ancestors
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 4, 2021 at 10:07 PM Marcos Paulo de Souza
<mpdesouza@suse.com> wrote:
>
> The search_key variable was being used only as argument of
> btrfs_search_slot. This can be simplified by calling btrfs_find_item,
> which also handles the next leaf condition as well.
>
> No functional changes.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  fs/btrfs/tree-log.c | 40 ++++++++++++----------------------------
>  1 file changed, 12 insertions(+), 28 deletions(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 567adc3de11a..22417cd32347 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -5929,31 +5929,30 @@ static int btrfs_log_all_parents(struct btrfs_tra=
ns_handle *trans,
>         return ret;
>  }
>
> +/*
> + * Iterate over the given and all it's parent directories, logging them =
if
> + * needed.
> + *
> + * Return 0 if we reach the toplevel directory, or < 0 if error.
> + */
>  static int log_new_ancestors(struct btrfs_trans_handle *trans,
>                              struct btrfs_root *root,
>                              struct btrfs_path *path,
>                              struct btrfs_log_ctx *ctx)
>  {
> +       struct btrfs_fs_info *fs_info =3D root->fs_info;
>         struct btrfs_key found_key;
> +       u64 ino;
>
>         btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0])=
;
>
>         while (true) {
> -               struct btrfs_fs_info *fs_info =3D root->fs_info;
> -               struct extent_buffer *leaf =3D path->nodes[0];
> -               int slot =3D path->slots[0];
> -               struct btrfs_key search_key;
>                 struct inode *inode;
> -               u64 ino;

Why are the 'ino' and 'fs_info' declarations moved to the outer scope?
They are only used inside the while loop's scope, so I don't see a
reason to move them.

Thanks.

>                 int ret =3D 0;
>
>                 btrfs_release_path(path);
>
>                 ino =3D found_key.offset;
> -
> -               search_key.objectid =3D found_key.offset;
> -               search_key.type =3D BTRFS_INODE_ITEM_KEY;
> -               search_key.offset =3D 0;
>                 inode =3D btrfs_iget(fs_info->sb, ino, root);
>                 if (IS_ERR(inode))
>                         return PTR_ERR(inode);
> @@ -5966,29 +5965,14 @@ static int log_new_ancestors(struct btrfs_trans_h=
andle *trans,
>                 if (ret)
>                         return ret;
>
> -               if (search_key.objectid =3D=3D BTRFS_FIRST_FREE_OBJECTID)
> +               if (ino =3D=3D BTRFS_FIRST_FREE_OBJECTID)
>                         break;
>
> -               search_key.type =3D BTRFS_INODE_REF_KEY;
> -               ret =3D btrfs_search_slot(NULL, root, &search_key, path, =
0, 0);
> +               ret =3D btrfs_find_item(root, path, ino, BTRFS_INODE_REF_=
KEY, 0,
> +                                       &found_key);
>                 if (ret < 0)
>                         return ret;
> -
> -               leaf =3D path->nodes[0];
> -               slot =3D path->slots[0];
> -               if (slot >=3D btrfs_header_nritems(leaf)) {
> -                       ret =3D btrfs_next_leaf(root, path);
> -                       if (ret < 0)
> -                               return ret;
> -                       else if (ret > 0)
> -                               return -ENOENT;
> -                       leaf =3D path->nodes[0];
> -                       slot =3D path->slots[0];
> -               }
> -
> -               btrfs_item_key_to_cpu(leaf, &found_key, slot);
> -               if (found_key.objectid !=3D search_key.objectid ||
> -                   found_key.type !=3D BTRFS_INODE_REF_KEY)
> +               else if (ret > 0)
>                         return -ENOENT;
>         }
>         return 0;
> --
> 2.31.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
