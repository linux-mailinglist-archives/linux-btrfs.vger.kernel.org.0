Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B22D77AA8A
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Aug 2023 20:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjHMSYb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Aug 2023 14:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHMSYa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Aug 2023 14:24:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AD910CE
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 11:24:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CB726249A
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 18:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7271AC433C8
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 18:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691951070;
        bh=2f8u9j8bM7iC1iAlixnGSjzdSFXKiGTEOupUmLuGfTo=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=gLW1ZjJMbwwPmxIvJQLEZnsfckFff48XtrqkGKjQBRNIJYMriJdLNT6fNnNRfDlz+
         4T36rqcP9MxvhE7hxaTi9MWY81CelD7xAtcfVXsWuaItmiFd3FPf3viqq8QrFZW/Fp
         Nm0lExvvNqTD/e5IzIOc0Z/U8lETgsBCQ2g2whHy2OM9HunklcYpv4HnG95WEtrIGa
         K18YKtUqp6OVs13GzmCRRHML14gLXXXFDJqvgpz4BZjPWMqlzvxIAJmoaULwhCShfS
         V2hly1koiveQBLXiIVUe4TCKZTMH5cR9OuHrthf+iFThsnlhWEYxIu8WqRWMbRoFc2
         R8ujxQsu175PQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1bbb4bde76dso2823038fac.2
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 11:24:30 -0700 (PDT)
X-Gm-Message-State: AOJu0YyscZvFByT6vwldGL3fJclMJnETWRENbQPXNsld+mgHKtvVNCT5
        6o2UTt1MI0sjqpUrnz0CGUgaFn6KSXmkEeLwNGU=
X-Google-Smtp-Source: AGHT+IHZ9SKaIUHQvGbTR4cyDlzwDZaGI2X5UesyCBi6o2Hg6U1NNiKhdyXGYbl41MyxCAjwtmez/6/hrwScWcOB5Lk=
X-Received: by 2002:a05:6870:96aa:b0:1bf:87af:e6df with SMTP id
 o42-20020a05687096aa00b001bf87afe6dfmr6758925oaq.55.1691951069473; Sun, 13
 Aug 2023 11:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <c9ceb0e15d92d0634600603b38965d9b6d986b6d.1691923900.git.fdmanana@suse.com>
In-Reply-To: <c9ceb0e15d92d0634600603b38965d9b6d986b6d.1691923900.git.fdmanana@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Sun, 13 Aug 2023 19:23:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6ottXN_pvQoZNkiTcjv3R83zwgoSEqby53vuw=aKm-yA@mail.gmail.com>
Message-ID: <CAL3q7H6ottXN_pvQoZNkiTcjv3R83zwgoSEqby53vuw=aKm-yA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix infinite directory reads
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 13, 2023 at 3:35=E2=80=AFPM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> The readdir implementation currently processes always up to the last inde=
x
> it finds. This however can result in an infinite loop if the directory ha=
s
> a large number of entries such that they won't all fit in the given buffe=
r
> passed to the readdir callback, that is, dir_emit() returns a non-zero
> value. Because in that case readdir() will be called again and if in the
> meanwhile new directory entries were added and we still can't put all the
> remaining entries in the buffer, we keep repeating this over and over.
>
> The following C program and test script reproduce the problem:
>
>   $ cat /mnt/readdir_prog.c
>   #include <sys/types.h>
>   #include <dirent.h>
>   #include <stdio.h>
>
>   int main(int argc, char *argv[])
>   {
>     DIR *dir =3D opendir(".");
>     struct dirent *dd;
>
>     while ((dd =3D readdir(dir))) {
>       printf("%s\n", dd->d_name);
>       rename(dd->d_name, "TEMPFILE");
>       rename("TEMPFILE", dd->d_name);
>     }
>     closedir(dir);
>   }
>
>   $ gcc -o /mnt/readdir_prog /mnt/readdir_prog.c
>
>   $ cat test.sh
>   #!/bin/bash
>
>   DEV=3D/dev/sdi
>   MNT=3D/mnt/sdi
>
>   mkfs.btrfs -f $DEV &> /dev/null
>   #mkfs.xfs -f $DEV &> /dev/null
>   #mkfs.ext4 -F $DEV &> /dev/null
>
>   mount $DEV $MNT
>
>   mkdir $MNT/testdir
>   for ((i =3D 1; i <=3D 2000; i++)); do
>       echo -n > $MNT/testdir/file_$i
>   done
>
>   cd $MNT/testdir
>   /mnt/readdir_prog
>
>   cd /mnt
>
>   umount $MNT
>
> This behaviour is surprising to applications and it's unlike ext4, xfs,
> tmpfs, vfat and other filesystems, which always finish. In this case wher=
e
> new entries were added due to renames, some file names may be reported
> more than once, but this varies according to each filesystem - for exampl=
e
> ext4 never reported the same file more than once while xfs reports the
> first 13 file names twice.
>
> So change our readdir implementation to track the last index number when
> opendir() is called and then make readdir() never process beyond that
> index number. This gives the same behaviour as ext4.
>
> Reported-by: Rob Landley <rob@landley.net>
> Link: https://lore.kernel.org/linux-btrfs/2c8c55ec-04c6-e0dc-9c5c-8c79247=
78c35@landley.net/
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217681
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Tested-by: Rob Landley <rob@landley.net>

Given in this other thread:
https://lore.kernel.org/linux-btrfs/d5a42b8f-fd8d-7974-fd78-f76399e78541@la=
ndley.net/

> ---
>  fs/btrfs/ctree.h         |   1 +
>  fs/btrfs/delayed-inode.c |   5 +-
>  fs/btrfs/delayed-inode.h |   1 +
>  fs/btrfs/inode.c         | 131 +++++++++++++++++++++++----------------
>  4 files changed, 84 insertions(+), 54 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index f2d2b313bde5..9419f4e37a58 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -443,6 +443,7 @@ struct btrfs_drop_extents_args {
>
>  struct btrfs_file_private {
>         void *filldir_buf;
> +       u64 last_index;
>         struct extent_state *llseek_cached_state;
>  };
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 6b457b010cbc..6d51db066503 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1632,6 +1632,7 @@ int btrfs_inode_delayed_dir_index_count(struct btrf=
s_inode *inode)
>  }
>
>  bool btrfs_readdir_get_delayed_items(struct inode *inode,
> +                                    u64 last_index,
>                                      struct list_head *ins_list,
>                                      struct list_head *del_list)
>  {
> @@ -1651,14 +1652,14 @@ bool btrfs_readdir_get_delayed_items(struct inode=
 *inode,
>
>         mutex_lock(&delayed_node->mutex);
>         item =3D __btrfs_first_delayed_insertion_item(delayed_node);
> -       while (item) {
> +       while (item && item->index <=3D last_index) {
>                 refcount_inc(&item->refs);
>                 list_add_tail(&item->readdir_list, ins_list);
>                 item =3D __btrfs_next_delayed_item(item);
>         }
>
>         item =3D __btrfs_first_delayed_deletion_item(delayed_node);
> -       while (item) {
> +       while (item && item->index <=3D last_index) {
>                 refcount_inc(&item->refs);
>                 list_add_tail(&item->readdir_list, del_list);
>                 item =3D __btrfs_next_delayed_item(item);
> diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
> index 4f21daa3dbc7..dc1085b2a397 100644
> --- a/fs/btrfs/delayed-inode.h
> +++ b/fs/btrfs/delayed-inode.h
> @@ -148,6 +148,7 @@ void btrfs_destroy_delayed_inodes(struct btrfs_fs_inf=
o *fs_info);
>
>  /* Used for readdir() */
>  bool btrfs_readdir_get_delayed_items(struct inode *inode,
> +                                    u64 last_index,
>                                      struct list_head *ins_list,
>                                      struct list_head *del_list);
>  void btrfs_readdir_put_delayed_items(struct inode *inode,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c268c5861a24..3b7e8a1b9b8e 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5885,6 +5885,74 @@ static struct dentry *btrfs_lookup(struct inode *d=
ir, struct dentry *dentry,
>         return d_splice_alias(inode, dentry);
>  }
>
> +/*
> + * Find the highest existing sequence number in a directory and then set=
 the
> + * in-memory index_cnt variable to the first free sequence number.
> + */
> +static int btrfs_set_inode_index_count(struct btrfs_inode *inode)
> +{
> +       struct btrfs_root *root =3D inode->root;
> +       struct btrfs_key key, found_key;
> +       struct btrfs_path *path;
> +       struct extent_buffer *leaf;
> +       int ret;
> +
> +       key.objectid =3D btrfs_ino(inode);
> +       key.type =3D BTRFS_DIR_INDEX_KEY;
> +       key.offset =3D (u64)-1;
> +
> +       path =3D btrfs_alloc_path();
> +       if (!path)
> +               return -ENOMEM;
> +
> +       ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +       if (ret < 0)
> +               goto out;
> +       /* FIXME: we should be able to handle this */
> +       if (ret =3D=3D 0)
> +               goto out;
> +       ret =3D 0;
> +
> +       if (path->slots[0] =3D=3D 0) {
> +               inode->index_cnt =3D BTRFS_DIR_START_INDEX;
> +               goto out;
> +       }
> +
> +       path->slots[0]--;
> +
> +       leaf =3D path->nodes[0];
> +       btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +
> +       if (found_key.objectid !=3D btrfs_ino(inode) ||
> +           found_key.type !=3D BTRFS_DIR_INDEX_KEY) {
> +               inode->index_cnt =3D BTRFS_DIR_START_INDEX;
> +               goto out;
> +       }
> +
> +       inode->index_cnt =3D found_key.offset + 1;
> +out:
> +       btrfs_free_path(path);
> +       return ret;
> +}
> +
> +static int btrfs_get_dir_last_index(struct btrfs_inode *dir, u64 *index)
> +{
> +       if (dir->index_cnt =3D=3D (u64)-1) {
> +               int ret;
> +
> +               ret =3D btrfs_inode_delayed_dir_index_count(dir);
> +               if (ret) {
> +                       ret =3D btrfs_set_inode_index_count(dir);
> +                       if (ret)
> +                               return ret;
> +               }
> +       }
> +
> +       *index =3D dir->index_cnt;
> +
> +       return 0;
> +}
> +
>  /*
>   * All this infrastructure exists because dir_emit can fault, and we are=
 holding
>   * the tree lock when doing readdir.  For now just allocate a buffer and=
 copy
> @@ -5897,10 +5965,17 @@ static struct dentry *btrfs_lookup(struct inode *=
dir, struct dentry *dentry,
>  static int btrfs_opendir(struct inode *inode, struct file *file)
>  {
>         struct btrfs_file_private *private;
> +       u64 last_index;
> +       int ret;
> +
> +       ret =3D btrfs_get_dir_last_index(BTRFS_I(inode), &last_index);
> +       if (ret)
> +               return ret;
>
>         private =3D kzalloc(sizeof(struct btrfs_file_private), GFP_KERNEL=
);
>         if (!private)
>                 return -ENOMEM;
> +       private->last_index =3D last_index;
>         private->filldir_buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
>         if (!private->filldir_buf) {
>                 kfree(private);
> @@ -5967,7 +6042,8 @@ static int btrfs_real_readdir(struct file *file, st=
ruct dir_context *ctx)
>
>         INIT_LIST_HEAD(&ins_list);
>         INIT_LIST_HEAD(&del_list);
> -       put =3D btrfs_readdir_get_delayed_items(inode, &ins_list, &del_li=
st);
> +       put =3D btrfs_readdir_get_delayed_items(inode, private->last_inde=
x,
> +                                             &ins_list, &del_list);
>
>  again:
>         key.type =3D BTRFS_DIR_INDEX_KEY;
> @@ -5985,6 +6061,8 @@ static int btrfs_real_readdir(struct file *file, st=
ruct dir_context *ctx)
>                         break;
>                 if (found_key.offset < ctx->pos)
>                         continue;
> +               if (found_key.offset > private->last_index)
> +                       break;
>                 if (btrfs_should_delete_dir_index(&del_list, found_key.of=
fset))
>                         continue;
>                 di =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_=
dir_item);
> @@ -6120,57 +6198,6 @@ static int btrfs_update_time(struct inode *inode, =
struct timespec64 *now,
>         return dirty ? btrfs_dirty_inode(BTRFS_I(inode)) : 0;
>  }
>
> -/*
> - * find the highest existing sequence number in a directory
> - * and then set the in-memory index_cnt variable to reflect
> - * free sequence numbers
> - */
> -static int btrfs_set_inode_index_count(struct btrfs_inode *inode)
> -{
> -       struct btrfs_root *root =3D inode->root;
> -       struct btrfs_key key, found_key;
> -       struct btrfs_path *path;
> -       struct extent_buffer *leaf;
> -       int ret;
> -
> -       key.objectid =3D btrfs_ino(inode);
> -       key.type =3D BTRFS_DIR_INDEX_KEY;
> -       key.offset =3D (u64)-1;
> -
> -       path =3D btrfs_alloc_path();
> -       if (!path)
> -               return -ENOMEM;
> -
> -       ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
> -       if (ret < 0)
> -               goto out;
> -       /* FIXME: we should be able to handle this */
> -       if (ret =3D=3D 0)
> -               goto out;
> -       ret =3D 0;
> -
> -       if (path->slots[0] =3D=3D 0) {
> -               inode->index_cnt =3D BTRFS_DIR_START_INDEX;
> -               goto out;
> -       }
> -
> -       path->slots[0]--;
> -
> -       leaf =3D path->nodes[0];
> -       btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> -
> -       if (found_key.objectid !=3D btrfs_ino(inode) ||
> -           found_key.type !=3D BTRFS_DIR_INDEX_KEY) {
> -               inode->index_cnt =3D BTRFS_DIR_START_INDEX;
> -               goto out;
> -       }
> -
> -       inode->index_cnt =3D found_key.offset + 1;
> -out:
> -       btrfs_free_path(path);
> -       return ret;
> -}
> -
>  /*
>   * helper to find a free sequence number in a given directory.  This cur=
rent
>   * code is very simple, later versions will do smarter things in the btr=
ee
> --
> 2.34.1
>
