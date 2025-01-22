Return-Path: <linux-btrfs+bounces-11037-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17574A19177
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 13:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D483AC867
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 12:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272B2212D62;
	Wed, 22 Jan 2025 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ddd4/+Lu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8EC212B0F
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737549600; cv=none; b=U5ktrNuzIQXOKW7eK+yRChQzK55BB2C2lkrqw2Ril+wJJl2IduOtJnm/9JGkQMFQFZMqIi/cY2aUQbOzpnDZMEL7vT4jtV5Qv1CkUpji9Ol+jzXbXG1D9bROU3gLOO6xhiVTxOJIV9IoknRXqRakzCUsKwlBp+E4ofpLSq7/agM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737549600; c=relaxed/simple;
	bh=j8S/cl9AmEvXoMUa0RCue95yorfBtbivQT23OZW0D4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+hCctu444cMRxNLEYZcArXlZHK2yhH7VBJIILhzy5/86XTY+WH/57KlJVWXTCA1V3IybrraL1Yr4qMbABXkcfQtOwKGwJHiHohXpRnhnFjYGDk1RlNNh1E5OIelusMfxibskr5Q62dZsgtOv3L5tbfO0VA1VvcWHTyP6Bvimfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ddd4/+Lu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AABC4CEE2
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 12:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737549600;
	bh=j8S/cl9AmEvXoMUa0RCue95yorfBtbivQT23OZW0D4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ddd4/+LuoGx78kMFSKWDy6ItOK2OeYiSLaGBzJdhWKOzrzq8bGQK9BfWUTY73sJsF
	 yUB27DB7mNcUtGvva5S27yI5zcxoPoV8zSCF3qVTcT9tL43LN3ppTLpem32cRil02m
	 j5vldihKHG+CZYVrLyFPOAVN4ffFvlgbQHxpDRCxhSmq/cF5FwVYqcX8viIYsnRhh+
	 Usg5NMiu40/+Nn/uiWPUmDUQwPh2LJJdwol+hPKDfjw53rhCJMUfb/SyVWyQJ3epii
	 Shqf3bZxNBwpFlo3WoAnI0a+oZZiPqfTf9y99m8uUNm8aMik9kVDJ9hx94bJ3Frmau
	 Rlp8xsm5nU0Ng==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so9960100a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 04:39:59 -0800 (PST)
X-Gm-Message-State: AOJu0YyfDtoZ2JoZ7RAAdSKesQ9NANLtiEAlYuwIxGaX+LHsS1d5rRZV
	7Ip0yohkAtLXj39/GawXoypKuDAOlIzjgtNNoucCAenVI/HTpsUZh/z1RnV/8V6H/Z5RRbSx5+S
	3ExTORT5eRevR6oWVt4wq0/HGtRM=
X-Google-Smtp-Source: AGHT+IFFPUXVVRILGWDiCSe8I92K36X51+i4CfXO1xp4mvGH+PozAoMxgydt0jP17NuuA/keyK3jCfti4WcbB3Aku5I=
X-Received: by 2002:a05:6402:5106:b0:5d0:ced8:d22d with SMTP id
 4fb4d7f45d1cf-5db7db07334mr49269993a12.22.1737549598499; Wed, 22 Jan 2025
 04:39:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122122459.1148668-1-maharmstone@fb.com>
In-Reply-To: <20250122122459.1148668-1-maharmstone@fb.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 22 Jan 2025 12:39:21 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
X-Gm-Features: AbW1kvY6zPas-Bc7F-FzrYWXIoC3ANloJii2fFitdh6bQ1G1r2LOMxZFnVFsIps
Message-ID: <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 12:25=E2=80=AFPM Mark Harmstone <maharmstone@fb.com=
> wrote:
>
> Currently btrfs_get_free_objectid() uses a mutex to protect
> free_objectid; I'm guessing this was because of the inode cache that we
> used to have. The inode cache is no more, so simplify things by
> replacing it with an atomic.
>
> There's no issues with ordering: free_objectid gets set to an initial
> value, then calls to btrfs_get_free_objectid() return a monotonically
> increasing value.
>
> This change means that btrfs_get_free_objectid() will no longer
> potentially sleep, which was a blocker for adding a non-blocking mode
> for inode and subvol creation.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  fs/btrfs/ctree.h    |  4 +---
>  fs/btrfs/disk-io.c  | 43 ++++++++++++++++++-------------------------
>  fs/btrfs/qgroup.c   | 11 ++++++-----
>  fs/btrfs/tree-log.c |  3 ---
>  4 files changed, 25 insertions(+), 36 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 1096a80a64e7..04175698525b 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -179,8 +179,6 @@ struct btrfs_root {
>         struct btrfs_fs_info *fs_info;
>         struct extent_io_tree dirty_log_pages;
>
> -       struct mutex objectid_mutex;
> -
>         spinlock_t accounting_lock;
>         struct btrfs_block_rsv *block_rsv;
>
> @@ -214,7 +212,7 @@ struct btrfs_root {
>
>         u64 last_trans;
>
> -       u64 free_objectid;
> +       atomic64_t free_objectid;
>
>         struct btrfs_key defrag_progress;
>         struct btrfs_key defrag_max;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f09db62e61a1..0543d9c3f8c0 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -659,7 +659,7 @@ static void __setup_root(struct btrfs_root *root, str=
uct btrfs_fs_info *fs_info,
>         RB_CLEAR_NODE(&root->rb_node);
>
>         btrfs_set_root_last_trans(root, 0);
> -       root->free_objectid =3D 0;
> +       atomic64_set(&root->free_objectid, 0);
>         root->nr_delalloc_inodes =3D 0;
>         root->nr_ordered_extents =3D 0;
>         xa_init(&root->inodes);
> @@ -678,7 +678,6 @@ static void __setup_root(struct btrfs_root *root, str=
uct btrfs_fs_info *fs_info,
>         spin_lock_init(&root->ordered_extent_lock);
>         spin_lock_init(&root->accounting_lock);
>         spin_lock_init(&root->qgroup_meta_rsv_lock);
> -       mutex_init(&root->objectid_mutex);
>         mutex_init(&root->log_mutex);
>         mutex_init(&root->ordered_extent_mutex);
>         mutex_init(&root->delalloc_mutex);
> @@ -1133,16 +1132,12 @@ static int btrfs_init_fs_root(struct btrfs_root *=
root, dev_t anon_dev)
>                 }
>         }
>
> -       mutex_lock(&root->objectid_mutex);
>         ret =3D btrfs_init_root_free_objectid(root);
> -       if (ret) {
> -               mutex_unlock(&root->objectid_mutex);
> +       if (ret)
>                 goto fail;
> -       }
>
> -       ASSERT(root->free_objectid <=3D BTRFS_LAST_FREE_OBJECTID);
> -
> -       mutex_unlock(&root->objectid_mutex);
> +       ASSERT((u64)atomic64_read(&root->free_objectid) <=3D
> +               BTRFS_LAST_FREE_OBJECTID);
>
>         return 0;
>  fail:
> @@ -2730,8 +2725,9 @@ static int __cold init_tree_roots(struct btrfs_fs_i=
nfo *fs_info)
>                 }
>
>                 /*
> -                * No need to hold btrfs_root::objectid_mutex since the f=
s
> -                * hasn't been fully initialised and we are the only user
> +                * No need to worry about atomic ordering of btrfs_root::=
free_objectid
> +                * since the fs hasn't been fully initialised and we are =
the
> +                * only user
>                  */
>                 ret =3D btrfs_init_root_free_objectid(tree_root);
>                 if (ret < 0) {
> @@ -2739,7 +2735,8 @@ static int __cold init_tree_roots(struct btrfs_fs_i=
nfo *fs_info)
>                         continue;
>                 }
>
> -               ASSERT(tree_root->free_objectid <=3D BTRFS_LAST_FREE_OBJE=
CTID);
> +               ASSERT((u64)atomic64_read(&tree_root->free_objectid) <=3D
> +                       BTRFS_LAST_FREE_OBJECTID);
>
>                 ret =3D btrfs_read_roots(fs_info);
>                 if (ret < 0) {
> @@ -4931,10 +4928,11 @@ int btrfs_init_root_free_objectid(struct btrfs_ro=
ot *root)
>                 slot =3D path->slots[0] - 1;
>                 l =3D path->nodes[0];
>                 btrfs_item_key_to_cpu(l, &found_key, slot);
> -               root->free_objectid =3D max_t(u64, found_key.objectid + 1=
,
> -                                           BTRFS_FIRST_FREE_OBJECTID);
> +               atomic64_set(&root->free_objectid,
> +                            max_t(u64, found_key.objectid + 1,
> +                                  BTRFS_FIRST_FREE_OBJECTID));
>         } else {
> -               root->free_objectid =3D BTRFS_FIRST_FREE_OBJECTID;
> +               atomic64_set(&root->free_objectid, BTRFS_FIRST_FREE_OBJEC=
TID);
>         }
>         ret =3D 0;
>  error:
> @@ -4944,20 +4942,15 @@ int btrfs_init_root_free_objectid(struct btrfs_ro=
ot *root)
>
>  int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
>  {
> -       int ret;
> -       mutex_lock(&root->objectid_mutex);
> +       u64 val =3D atomic64_inc_return(&root->free_objectid) - 1;
>
> -       if (unlikely(root->free_objectid >=3D BTRFS_LAST_FREE_OBJECTID)) =
{
> +       if (unlikely(val >=3D BTRFS_LAST_FREE_OBJECTID)) {
>                 btrfs_warn(root->fs_info,
>                            "the objectid of root %llu reaches its highest=
 value",
>                            btrfs_root_id(root));
> -               ret =3D -ENOSPC;
> -               goto out;
> +               return -ENOSPC;
>         }
>
> -       *objectid =3D root->free_objectid++;
> -       ret =3D 0;

So this gives different semantics now.

Before we increment free_objectid only if it's less than
BTRFS_LAST_FREE_OBJECTID, so once we reach that value we can't assign
more object IDs and must return -ENOSPC.

But now we always increment and then do the check, so after some calls
to btrfs_get_free_objectid() we wrap around the counter due to
overflow and eventually allow reusing already assigned object IDs.

I'm afraid the lock is still needed because of that. To make it more
lightweight maybe switch the mutex to a spinlock.

Thanks.

> -out:
> -       mutex_unlock(&root->objectid_mutex);
> -       return ret;
> +       *objectid =3D val;
> +       return 0;
>  }
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index aaf16019d829..b41e06d5d2fb 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -472,18 +472,19 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *=
fs_info)
>                          *
>                          * Ensure that we skip any such subvol ids.
>                          *
> -                        * We don't need to lock because this is only cal=
led
> -                        * during mount before we start doing things like=
 creating
> -                        * subvolumes.
> +                        * We don't need to worry about atomic ordering b=
ecause
> +                        * this is only called during mount before we sta=
rt
> +                        * doing things like creating subvolumes.
>                          */
>                         if (is_fstree(qgroup->qgroupid) &&
> -                           qgroup->qgroupid > tree_root->free_objectid)
> +                           qgroup->qgroupid > (u64)atomic64_read(&tree_r=
oot->free_objectid))
>                                 /*
>                                  * Don't need to check against BTRFS_LAST=
_FREE_OBJECTID,
>                                  * as it will get checked on the next cal=
l to
>                                  * btrfs_get_free_objectid.
>                                  */
> -                               tree_root->free_objectid =3D qgroup->qgro=
upid + 1;
> +                               atomic64_set(&tree_root->free_objectid,
> +                                            qgroup->qgroupid + 1);
>                 }
>                 ret =3D btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
>                 if (ret < 0)
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 955d1677e865..9d19528fee17 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -7325,9 +7325,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_=
root_tree)
>                          * We have just replayed everything, and the high=
est
>                          * objectid of fs roots probably has changed in c=
ase
>                          * some inode_item's got replayed.
> -                        *
> -                        * root->objectid_mutex is not acquired as log re=
play
> -                        * could only happen during mount.
>                          */
>                         ret =3D btrfs_init_root_free_objectid(root);
>                         if (ret)
> --
> 2.45.2
>
>

