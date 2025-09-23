Return-Path: <linux-btrfs+bounces-17128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72365B96D8F
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 18:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68C2F7ADCE6
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 16:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844EE32857A;
	Tue, 23 Sep 2025 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/cvnaBn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C542E7F39
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645392; cv=none; b=DIx6fTejQcTW2WVHOWSyKFPdomW8iMZEPIvjznQR1IKFftoeWfNw6+5NGuI4PTwC6sXX0xdpZ6Y7V/p6Y1g3cbHXRKyOlGWsdIbvHVs1HguFOtYa2RNpxZ4RPM2F7jI++6h36GHZGyK4XcWSRz8rGvWoOcZqZNdo5D0xekacpto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645392; c=relaxed/simple;
	bh=5145aHlkDlsui3ozzBSxnSp3cqV3kHFoHD7jXa18Lds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J02YQE8WrNJ8ucZKLSwsai7DqyJtVr9l6sbw/ByJ8bOVZc3ZUFhJnincn76l17gLqXCVxh9fNvQeupDILapNUPI7c5Hq73bwn5a1e1PeQroEXpoxnrXEJ7EGvrJgQpaZRbjb+ZltLvo3KDgWWseDVJGu0OiTkt9Rn7wirBu93vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/cvnaBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EC5C4CEF5
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 16:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758645391;
	bh=5145aHlkDlsui3ozzBSxnSp3cqV3kHFoHD7jXa18Lds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d/cvnaBn1jiu5Ag021Ay1kNEbsy2kB3mRx4V4B8v6MP+rM3zq4Ja/Hey26hEKf+5a
	 cJvMdUHhZuC5i6AQWIDDvCxMA5L++vPJBysXBuvHUk/8Ssmnq2W9c+qWYkpdxMeieI
	 djeR8Fz2jJYTauoJKQL/4+31X21LSkEX4ySdqGpVwb6/EbaVb/9SXUjwvzJdprGPGP
	 Y8Qaeo1rTeqqDzYgZwj3miCsWY5EGaOLhmaM+c0FuVZP3wXrS+HOtxnAn59qeAu9Ul
	 zHdKNhczZLnoJC9qId7tjNhvpDGWH4FwXpItLmQxgBzDQmHJblj6AMCbtwyWZ5x6YF
	 Y/dBzI2VRzwyw==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so6034363a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 09:36:31 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw+DnKrriqyYzflRoToCdKtM3XzNpF8/LjJOTaYkSJ4zAKyS5pf
	ijLBRPwh1Jn1vrEkh0NySaURTquvfLUVEmnMP10xD8uXi0VxGKUJdeWYHmFB9rP8z5fjaDzQ7XW
	kok+IcCF1xRSNY0F8F2eYXdT5rL156Fk=
X-Google-Smtp-Source: AGHT+IGbSOMjgfimgxVjYR/rMHYo7IdsClj6vTihdwv1/DxnFMIBJ7qrGaj80b1BaJN1hm2D7uNrXNJeUsXWWnIgIto=
X-Received: by 2002:a17:907:8691:b0:b2d:b5d3:9630 with SMTP id
 a640c23a62f3a-b302a84d4b6mr321556166b.48.1758645389959; Tue, 23 Sep 2025
 09:36:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923155523.31617-1-mark@harmstone.com> <20250923155523.31617-2-mark@harmstone.com>
In-Reply-To: <20250923155523.31617-2-mark@harmstone.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 23 Sep 2025 17:35:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4Y0A9MgnhtH=0_6372k9NmCU-X9rw_Ng4=1ydjTa477g@mail.gmail.com>
X-Gm-Features: AS18NWBm-2IX0RGfIg5cM0AIC27UkL7DQxIgzlsSoOge7X-lUepss0HUAtoGR10
Message-ID: <CAL3q7H4Y0A9MgnhtH=0_6372k9NmCU-X9rw_Ng4=1ydjTa477g@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: clear spurious free-space entries
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 4:55=E2=80=AFPM Mark Harmstone <mark@harmstone.com>=
 wrote:
>
> Version 6.16.1 of btrfs-progs fixes a broken btrfs check test for
> spurious entries in the free-space tree, those that don't belong to any
> block group. Unfortunately mkfs.btrfs had been generating these, meaning
> that these filesystems will now fail btrfs check.
>
> Add a compat flag BTRFS_FEATURE_COMPAT_NO_SPURIOUS_FREE_SPACE, and if on
> mount we find this isn't set, clean any spurious entries from the
> beginning of the free-space tree.
>
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/disk-io.c         |  10 ++++
>  fs/btrfs/free-space-tree.c | 115 +++++++++++++++++++++++++++++++++++++
>  fs/btrfs/free-space-tree.h |   1 +
>  include/uapi/linux/btrfs.h |   2 +
>  4 files changed, 128 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 21c2a19d690f..224369c450e4 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3077,6 +3077,16 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info =
*fs_info)
>                 }
>         }
>
> +       if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
> +           !btrfs_fs_compat(fs_info, NO_SPURIOUS_FREE_SPACE)) {
> +               ret =3D btrfs_remove_spurious_free_space(fs_info);
> +               if (ret) {
> +                       btrfs_warn(fs_info,
> +                                  "failed to remove spurious free space:=
 %d",
> +                                  ret);

There's no need to split the line, we tolerate more than 80 characters
nowadays up to a reasonable limit, say close to 90.

> +               }
> +       }
> +
>         /*
>          * btrfs_find_orphan_roots() is responsible for finding all the d=
ead
>          * roots (with 0 refs), flag them with BTRFS_ROOT_DEAD_TREE and l=
oad
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index dad0b492a663..5980710cf6b5 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1722,3 +1722,118 @@ int btrfs_load_free_space_tree(struct btrfs_cachi=
ng_control *caching_ctl)
>         else
>                 return load_free_space_extents(caching_ctl, path, extent_=
count);
>  }
> +
> +/*
> + * Earlier versions of mkfs.btrfs created spurious entries at the beginn=
ing of
> + * the free-space tree, before the start of any block group.
> + * If the compat flag NO_SPURIOUS_FREE_SPACE is not set, clean these up =
and
> + * set the flag so we know we don't have to check again.
> + */
> +int btrfs_remove_spurious_free_space(struct btrfs_fs_info *fs_info)
> +{
> +       struct btrfs_root *fst;
> +       struct btrfs_trans_handle *trans;
> +       struct btrfs_key key;
> +       struct extent_buffer *leaf;
> +       struct btrfs_block_group *bg;
> +       u64 bg_start;
> +       BTRFS_PATH_AUTO_FREE(path);
> +       int ret, ret2;
> +       unsigned int entries_to_remove =3D 0;
> +
> +       struct btrfs_key root_key =3D {

Please don't leave a new line between variable declarations.
Also some of these variables are only used inside the loop, like
'leaf' and 'bg_start', so they should be declared inside that block.

> +               .objectid =3D BTRFS_FREE_SPACE_TREE_OBJECTID,
> +               .type =3D BTRFS_ROOT_ITEM_KEY,
> +               .offset =3D 0,
> +       };
> +
> +       path =3D btrfs_alloc_path();
> +       if (!path)
> +               return -ENOMEM;
> +
> +       fst =3D btrfs_grab_root(btrfs_global_root(fs_info, &root_key));
> +       if (!fst)
> +               return -EINVAL;

Not sure if -EINVAL is the best error here, or even if we should error out.

> +
> +       trans =3D btrfs_start_transaction(fst, 0);
> +       if (IS_ERR(trans)) {
> +               ret =3D PTR_ERR(trans);
> +               goto end;
> +       }
> +
> +       key.objectid =3D 0;
> +       key.type =3D 0;
> +       key.offset =3D 0;
> +
> +       ret =3D btrfs_search_slot(trans, fst, &key, path, 0, 0);
> +       if (ret < 0)
> +               goto end_trans;
> +
> +       while (true) {
> +               leaf =3D path->nodes[0];
> +               if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
> +                       ret =3D btrfs_next_leaf(fst, path);
> +                       if (ret < 0)
> +                               goto end_trans;
> +                       if (ret > 0)
> +                               break;
> +                       leaf =3D path->nodes[0];
> +               }
> +
> +               btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> +
> +               bg =3D btrfs_lookup_first_block_group(fs_info, key.object=
id);
> +               if (!bg)
> +                       break;
> +
> +               bg_start =3D bg->start;
> +
> +               btrfs_put_block_group(bg);
> +
> +               if (key.objectid >=3D bg_start)
> +                       break;
> +
> +               entries_to_remove++;
> +
> +               path->slots[0]++;
> +       }
> +
> +       if (entries_to_remove =3D=3D 0) {
> +               ret =3D 0;
> +               goto end_trans;
> +       }
> +
> +       btrfs_release_path(path);
> +
> +       key.objectid =3D 0;
> +       key.type =3D 0;
> +       key.offset =3D 0;
> +
> +       ret =3D btrfs_search_slot(trans, fst, &key, path, -1, 1);
> +       if (ret < 0)
> +               goto end_trans;
> +
> +       ret =3D btrfs_del_items(trans, fst, path, 0, entries_to_remove);

So this all works fine if all items to delete are in a single leaf.
If they aren't, what happens?

btrfs_del_items() is prepared to process a single leaf, and if the
number of items to delete is greater than the number of items in the
leaf, we get some underflows in some operations there, like when we do
"nritems - nr", etc.

> +       if (ret)
> +               btrfs_abort_transaction(trans, ret);
> +
> +end_trans:
> +       btrfs_release_path(path);
> +
> +       if (!ret)
> +               btrfs_set_fs_compat(fs_info, NO_SPURIOUS_FREE_SPACE);
> +
> +       ret2 =3D btrfs_commit_transaction(trans);
> +       if (!ret)
> +               ret =3D ret2;
> +
> +       if (!ret && entries_to_remove > 0) {
> +               btrfs_info(fs_info, "removed %u spurious free-space entri=
es",
> +                          entries_to_remove);

This can also stay in a single line.

> +       }
> +
> +end:
> +       btrfs_put_root(fst);
> +
> +       return ret;
> +}
> diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
> index 3d9a5d4477fc..b501c41acf3b 100644
> --- a/fs/btrfs/free-space-tree.h
> +++ b/fs/btrfs/free-space-tree.h
> @@ -35,6 +35,7 @@ int btrfs_add_to_free_space_tree(struct btrfs_trans_han=
dle *trans,
>                                  u64 start, u64 size);
>  int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
>                                       u64 start, u64 size);
> +int btrfs_remove_spurious_free_space(struct btrfs_fs_info *fs_info);
>
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>  struct btrfs_free_space_info *
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index 8e710bbb688e..6219e2b8e334 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -337,6 +337,8 @@ struct btrfs_ioctl_fs_info_args {
>  #define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE        (1ULL << 14)
>  #define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA    (1ULL << 16)
>
> +#define BTRFS_FEATURE_COMPAT_NO_SPURIOUS_FREE_SPACE    (1ULL << 0)
> +
>  struct btrfs_ioctl_feature_flags {
>         __u64 compat_flags;
>         __u64 compat_ro_flags;
> --
> 2.49.1
>

