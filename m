Return-Path: <linux-btrfs+bounces-1778-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6121F83BE3C
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 11:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859721C20979
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 10:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EE11C6BC;
	Thu, 25 Jan 2024 10:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArNWN7R1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C439D1CD0B;
	Thu, 25 Jan 2024 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176960; cv=none; b=Q8ZWcPBY/8nkx1YjRBKO9LZfe8/Q7IACzqgvBjbouc2Za6pHoGeLVYDCMJkWwBVjnhZRoqoGh+8YMkFNp41OFDI5HrMhImo1/TYZbc7xvEZsJsHzd8QzMpKPx4ng7yXnl+mJYXjZ4g1UF64JE1U6vlBUmmSVFuh3oJWzqgrq1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176960; c=relaxed/simple;
	bh=yDt/yhmdo4RZqcXfSV603PxvTj/7g8EXBYjJTITgA34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0FL8Mu/kIWFlIcJS55IJnrme2SWpmRI6H4ifMW6cInN0UdRyDmanON5Dna6rOuX7kydxx0tX7eZfSxotOnz2Z4MRBc1to9/tLqbJMtu/rCBoSNCbI72yW86x+7OvWZ6VUlr2QSd1xeRihIDFotu1SbSA6rXVfS8hVHibrjf0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArNWN7R1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57355C43394;
	Thu, 25 Jan 2024 10:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706176960;
	bh=yDt/yhmdo4RZqcXfSV603PxvTj/7g8EXBYjJTITgA34=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ArNWN7R16y1MsuBiT7RXiav5AV1BWCaKRmZ2Juq4b5muWM6mHirfuY2r/BTNdiDjU
	 kXT9JBLkVZZ/tblUf5pefg9+fUQ6+cinGx6/GYsqeSSMFYV3L9DnIiVc6l0u7sCPIN
	 ANwYVOfdntxq0vdbEoZkd+nyMqBVL/XydltVkDLC2HLPacwjhzO8ZGJoBVrciykdTr
	 tLcCCkp3a9YUaTD962LTMznSqowp925LolMOQuA2X2UIeDMuF+HmgTwdMAXWUznlAv
	 JitDuXPtCU3IGhkAFF9Qox7j5fl2Fg8GHZhbWYE2HKJ9Th2JBzNvhqRo4vrS+i9fGe
	 jV9oY0+wzE6Tg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a31914e7493so31272366b.3;
        Thu, 25 Jan 2024 02:02:40 -0800 (PST)
X-Gm-Message-State: AOJu0YwIYaJXAKl3wAGe6ymLiyKVpD9YIGN/SgxwWSM9hehFGRSYJ5nT
	fRioFuoyS4VCHIeuZIMYykWieUip8mJ51+xQEflGoEADzprXQr6wrlK9li/tY5Mgq45bBMSEXTO
	EBkKHx+PpoNu9ohYrAFdXJnqFZ5A=
X-Google-Smtp-Source: AGHT+IEmBvklLZ+/DGPM2pJFRCdX3g//jNZtBAp6Vhbkzatew/ODQY+UcCjWByuGtlAUo80Tkpek1iufnqd4KXkL+C8=
X-Received: by 2002:a17:907:a644:b0:a31:7c6a:cda3 with SMTP id
 vu4-20020a170907a64400b00a317c6acda3mr325635ejc.23.1706176958471; Thu, 25 Jan
 2024 02:02:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ae6e30a71112e07c727f9e93ff32032051bbce7.1706176168.git.wqu@suse.com>
In-Reply-To: <1ae6e30a71112e07c727f9e93ff32032051bbce7.1706176168.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 25 Jan 2024 10:02:01 +0000
X-Gmail-Original-Message-ID: <CAL3q7H77i3kv7C352k2R6nr-m-cgh_cdCCeTkXna+v1yjpMuoA@mail.gmail.com>
Message-ID: <CAL3q7H77i3kv7C352k2R6nr-m-cgh_cdCCeTkXna+v1yjpMuoA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix infinite directory reads
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, erosca@de.adit-jv.com, 
	Filipe Manana <fdmanana@suse.com>, Rob Landley <rob@landley.net>, stable@vger.kernel.org, 
	David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 9:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> [ Upstream commit 9b378f6ad48cfa195ed868db9123c09ee7ec5ea2 ]
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
> CC: stable@vger.kernel.org # 5.15
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> [ Resolve a conflict due to member changes in 96d89923fa94 ]
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

Thanks for the backport, and running the corresponding test case from
fstests to verify it's working.

However when backporting a commit, one should also check if there are
fixes for that commit, as they
often introduce regressions or have some other bug - and that's the
case here. We also need to backport
the following 3 commits:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D357950361cbc6d54fb68ed878265c647384684ae
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3De60aa5da14d01fed8411202dbe4adf6c44bd2a57
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D8e7f82deb0c0386a03b62e30082574347f8b57d5

One regression, the one regarding rewinddir(3), even has a test case
in fstests too (generic/471) and would have been caught
when running the "dir" group tests in fstests:

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3Dfor-next=
&id=3D68b958f5dc4ab13cfd86f7fb82621f9f022b7626

I'll work on making backports of those 3 other patches on top of your
backport, and then send all of them in a series,
including your patch, to make it easier to follow and apply all at once.

Thanks.


>  fs/btrfs/ctree.h         |   1 +
>  fs/btrfs/delayed-inode.c |   5 +-
>  fs/btrfs/delayed-inode.h |   1 +
>  fs/btrfs/inode.c         | 131 +++++++++++++++++++++++----------------
>  4 files changed, 84 insertions(+), 54 deletions(-)
> ---
> Changelog:
> v2:
> - Fix the upstream commit hash
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 1467bf439cb4..7905f178efa3 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1361,6 +1361,7 @@ struct btrfs_drop_extents_args {
>
>  struct btrfs_file_private {
>         void *filldir_buf;
> +       u64 last_index;
>  };
>
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index fd951aeaeac5..5a98c5da1225 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1513,6 +1513,7 @@ int btrfs_inode_delayed_dir_index_count(struct btrf=
s_inode *inode)
>  }
>
>  bool btrfs_readdir_get_delayed_items(struct inode *inode,
> +                                    u64 last_index,
>                                      struct list_head *ins_list,
>                                      struct list_head *del_list)
>  {
> @@ -1532,14 +1533,14 @@ bool btrfs_readdir_get_delayed_items(struct inode=
 *inode,
>
>         mutex_lock(&delayed_node->mutex);
>         item =3D __btrfs_first_delayed_insertion_item(delayed_node);
> -       while (item) {
> +       while (item && item->key.offset <=3D last_index) {
>                 refcount_inc(&item->refs);
>                 list_add_tail(&item->readdir_list, ins_list);
>                 item =3D __btrfs_next_delayed_item(item);
>         }
>
>         item =3D __btrfs_first_delayed_deletion_item(delayed_node);
> -       while (item) {
> +       while (item && item->key.offset <=3D last_index) {
>                 refcount_inc(&item->refs);
>                 list_add_tail(&item->readdir_list, del_list);
>                 item =3D __btrfs_next_delayed_item(item);
> diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
> index b2412160c5bc..a9cfce856d2e 100644
> --- a/fs/btrfs/delayed-inode.h
> +++ b/fs/btrfs/delayed-inode.h
> @@ -123,6 +123,7 @@ void btrfs_destroy_delayed_inodes(struct btrfs_fs_inf=
o *fs_info);
>
>  /* Used for readdir() */
>  bool btrfs_readdir_get_delayed_items(struct inode *inode,
> +                                    u64 last_index,
>                                      struct list_head *ins_list,
>                                      struct list_head *del_list);
>  void btrfs_readdir_put_delayed_items(struct inode *inode,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 95af29634e55..1df374ce829b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6121,6 +6121,74 @@ static struct dentry *btrfs_lookup(struct inode *d=
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
> @@ -6133,10 +6201,17 @@ static struct dentry *btrfs_lookup(struct inode *=
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
> @@ -6205,7 +6280,8 @@ static int btrfs_real_readdir(struct file *file, st=
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
> @@ -6238,6 +6314,8 @@ static int btrfs_real_readdir(struct file *file, st=
ruct dir_context *ctx)
>                         break;
>                 if (found_key.offset < ctx->pos)
>                         goto next;
> +               if (found_key.offset > private->last_index)
> +                       break;
>                 if (btrfs_should_delete_dir_index(&del_list, found_key.of=
fset))
>                         goto next;
>                 di =3D btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
> @@ -6371,57 +6449,6 @@ static int btrfs_update_time(struct inode *inode, =
struct timespec64 *now,
>         return dirty ? btrfs_dirty_inode(inode) : 0;
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
> 2.43.0
>
>

