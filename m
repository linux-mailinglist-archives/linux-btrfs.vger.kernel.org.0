Return-Path: <linux-btrfs+bounces-14360-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39070ACAC5E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 12:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B89189E91A
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 10:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9071EB5F8;
	Mon,  2 Jun 2025 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZZmbXq2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E5D7E0FF
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748859711; cv=none; b=KB8arugDPkobmISIijVI+wFEHCjGx9O0TGSXIVcfwmtPLnZXeQO8mjtc9gMQJqsSfVdf7gVH0hcRkbiXlgmsR9scSZcXJvbifPqTdpFU75iZOnpcdN8uBoR1crREouYBo+pWCbmtV96rjv1d+to4e+o+h0w7WV4MF2eOHcorLOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748859711; c=relaxed/simple;
	bh=/nvYJn8NVR+zhpkTYnQcPSi5GrT1ikFAV8/UIoA4qO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0bL6wYNPG5UtSo6DEnXUcAjm0Wb55dsR5ywl7fpNpkcRJGS7gz4yOz+FVsS0Q3hyGqmrOXMV+7T4hRvWjrPTg17tfMdVtVMngU+pFDmZ/B4rtfLWDXV6n8iGOaZ41E6A4rzWr2qeap4pEVy5oKqX9Lj36JL+ZQuTqL9ytZdCWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZZmbXq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87698C4CEED
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748859710;
	bh=/nvYJn8NVR+zhpkTYnQcPSi5GrT1ikFAV8/UIoA4qO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nZZmbXq2S5iQGdKk5y+/xsDnzn93KK3PgKcKdaCpKBLwE2wjrXuxTzvg8pzSae/1I
	 oTaK78qv/HzIFoR7/gNqZIMIV5LrgGSTIouWCm7YLqaqpYV8LmD7Z7rRVFNKdyw/42
	 imZlwviCVlzhtDwGucr3ke0lbiuDacAc2lZiMn1uXf2JksNFJKxS/I2z8LStEfI2x4
	 yl2Y5UMED/JMxTfBYX8E3vX9d1m7C2ly8Ai8Wzxj7zD81Gp1IaflMwP9migINwNVqf
	 HW/igNoe5+4iKB6BRM4IZ4UKdQ7E+VQ6PuCTCaGNsBVuP+HmWPVj6ikDm7hSB9C0M2
	 Ngyk1pVWq8tvw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad574992fcaso687532366b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Jun 2025 03:21:50 -0700 (PDT)
X-Gm-Message-State: AOJu0YwEO4CcM2EnG+MNEfiYh3/5rGRcd6ohuyPHZU/k3zpHGAgbgdBP
	AbMX2A8DVk3RacbOLfRk53I1KVFwMqO9SmzRpn54Oy5Avd2KLGx7wDdf+yVWiJyWj2C91Gu3AZu
	7M/pHKgffkpDfeCX4I3nCiY3nmM/rm6k=
X-Google-Smtp-Source: AGHT+IEhUoSpjyX5OmVFuf8CF0MxMo93iS6q+waSl+01Zg2d1U0PMFGJPRkixR17R7rE5W7suV1RycRjGoZhyAvEFtA=
X-Received: by 2002:a17:907:2da6:b0:ad8:a2a8:23db with SMTP id
 a640c23a62f3a-adb49598eefmr721018966b.56.1748859709024; Mon, 02 Jun 2025
 03:21:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6133ab918b19507738e4fa08be23b73be0d8d84e.1748842937.git.johannes.thumshirn@wdc.com>
In-Reply-To: <6133ab918b19507738e4fa08be23b73be0d8d84e.1748842937.git.johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 2 Jun 2025 11:21:12 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5Nff5KVbqK9X7B2FJY2tuuQHZxaAe3CcyAT9Rwch8URA@mail.gmail.com>
X-Gm-Features: AX0GCFtyPvAzdRcW2OouiGQXYezj8-nl8Z6KxeWfS1UbZBUYqIXzClSx-OE9oNs
Message-ID: <CAL3q7H5Nff5KVbqK9X7B2FJY2tuuQHZxaAe3CcyAT9Rwch8URA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: zoned: reserve data_reloc block group on mount
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Josef Bacik <josef@toxicpanda.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 6:43=E2=80=AFAM Johannes Thumshirn <jth@kernel.org> =
wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Create a blog group dedicated for data relocation on mount of a zoned

blog -> block

> filesystem.
>
> If there is already more than one empty DATA block group on mount, this
> one is picked for the data relocation block group, instead of a newly
> created one.
>
> This is done to ensure, there is always space for performing garbage
> collection and the filesystem is not hitting ENOSPC under heavy overwrite
> workloads.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> Changes to v1:
> - Fix build error with CONFIG_BLK_DEV_ZONED=3Dn
>
>  fs/btrfs/disk-io.c |  1 +
>  fs/btrfs/zoned.c   | 84 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/zoned.h   |  3 ++
>  3 files changed, 88 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 3def93016963..b211dc8cdb86 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3562,6 +3562,7 @@ int __cold open_ctree(struct super_block *sb, struc=
t btrfs_fs_devices *fs_device
>                 goto fail_sysfs;
>         }
>
> +       btrfs_zoned_reserve_data_reloc_bg(fs_info);
>         btrfs_free_zone_cache(fs_info);
>
>         btrfs_check_active_zone_reservation(fs_info);
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 19710634d63f..446f6cee10c2 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -17,6 +17,7 @@
>  #include "fs.h"
>  #include "accessors.h"
>  #include "bio.h"
> +#include "transaction.h"
>
>  /* Maximum number of zones to report per blkdev_report_zones() call */
>  #define BTRFS_REPORT_NR_ZONES   4096
> @@ -2443,6 +2444,89 @@ void btrfs_clear_data_reloc_bg(struct btrfs_block_=
group *bg)
>         spin_unlock(&fs_info->relocation_bg_lock);
>  }
>
> +void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
> +{
> +       struct btrfs_space_info *data_sinfo =3D fs_info->data_sinfo;
> +       struct btrfs_space_info *space_info;
> +       struct btrfs_root *root;
> +       struct btrfs_trans_handle *trans =3D NULL;

There's no need to initialize trans.

> +       struct btrfs_block_group *bg;
> +       u64 alloc_flags;
> +       bool initial =3D false;
> +       int index;
> +       int ret;
> +
> +       if (!btrfs_is_zoned(fs_info))
> +               return;
> +
> +       if (fs_info->data_reloc_bg)
> +               return;
> +
> +       if (sb_rdonly(fs_info->sb))
> +               return;
> +
> +       space_info =3D data_sinfo->sub_group[0];

This could be assigned right when the variable is declared.

> +       ASSERT(space_info->subgroup_id =3D=3D BTRFS_SUB_GROUP_DATA_RELOC)=
;
> +       alloc_flags =3D btrfs_get_alloc_profile(fs_info, space_info->flag=
s);
> +       index =3D btrfs_bg_flags_to_raid_index(alloc_flags);
> +
> +       list_for_each_entry(bg, &data_sinfo->block_groups[index], list) {
> +               btrfs_get_block_group(bg);

Why are we getting and putting a ref on the block group? There's no
need for it, given this is run in the mount path.

> +               if (!bg->used) {

Since ->used is a counter and not a boolean, please use "=3D=3D 0"
instead, it's a lot more clear.

Also to reduce indentation, this could be changed to do instead:

if (bg->used > 0)
    continue;

> +                       if (!initial) {
> +                               initial =3D true;
> +                               btrfs_put_block_group(bg);
> +                               continue;
> +                       }
> +
> +                       fs_info->data_reloc_bg =3D bg->start;
> +                       set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
> +                               &bg->runtime_flags);
> +                       btrfs_zone_activate(bg);
> +
> +                       btrfs_put_block_group(bg);
> +                       return;
> +               }
> +               btrfs_put_block_group(bg);
> +       }
> +
> +       if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))
> +               root =3D fs_info->block_group_root;
> +       else
> +               root =3D btrfs_extent_root(fs_info, 0);
> +
> +       trans =3D btrfs_join_transaction(root);
> +       if (IS_ERR(trans))
> +               return;
> +
> +       mutex_lock(&fs_info->chunk_mutex);
> +       bg =3D btrfs_create_chunk(trans, space_info, alloc_flags);
> +       if (IS_ERR(bg)) {
> +               mutex_unlock(&fs_info->chunk_mutex);
> +               ret =3D PTR_ERR(bg);
> +               btrfs_abort_transaction(trans, ret);

Why the abort? We haven't done any fs change after we joined the transactio=
n.

> +               btrfs_end_transaction(trans);
> +               return;
> +       }
> +
> +       ret =3D btrfs_chunk_alloc_add_chunk_item(trans, bg);

Why are we creating the chunk using the lower level APIs and not
btrfs_chunk_alloc()?

All one needs to do is call btrfs_chunk_alloc() and not
btrfs_create_chunk() followed by btrfs_chunk_alloc_add_chunk_item() -
these two functions are not meant to be used directly.
It's also buggy to not call check_system_chunk() before them, as we
may need to allocate a new system chunk too.

Essentially this is duplicating part of what do_chunk_alloc() does and
missing some critical things it does that are necessary for chunk
allocation.

Calling btrfs_chunk_alloc() takes care of all that and more - it's all
that is needed, and removes the need to lock the chunk mutex too, as
it's done by that function.


> +       if (ret) {
> +               mutex_unlock(&fs_info->chunk_mutex);
> +               btrfs_abort_transaction(trans, ret);
> +               btrfs_end_transaction(trans);
> +               return;
> +       }
> +       mutex_unlock(&fs_info->chunk_mutex);
> +
> +       btrfs_get_block_group(bg);

Same here, why grabbing the reference? We are in the mount path... I
don't get why it's being done only here and not right after we got the
bg...

> +       fs_info->data_reloc_bg =3D bg->start;
> +       set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &bg->runtime_flags);
> +       btrfs_zone_activate(bg);

So using the low level function btrfs_create_chunk() was only because
you wanted to get the block group returned.

So I suggest using btrfs_chunk_alloc() with CHUNK_ALLOC_FORCE argument
and then repeating the list_for_each_entry() above.
Not ideal, but refactoring the normal API to return the bg will
require some thought, and duplicating and all the logic it does here
is not a good idea.

Thanks.

> +       btrfs_put_block_group(bg);
> +
> +       btrfs_end_transaction(trans);
> +}
> +
>  void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info)
>  {
>         struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 9672bf4c3335..6e11533b8e14 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -88,6 +88,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_i=
nfo, u64 logical,
>  void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
>                                    struct extent_buffer *eb);
>  void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
> +void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info);
>  void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
>  bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info);
>  void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u6=
4 logical,
> @@ -241,6 +242,8 @@ static inline void btrfs_schedule_zone_finish_bg(stru=
ct btrfs_block_group *bg,
>
>  static inline void btrfs_clear_data_reloc_bg(struct btrfs_block_group *b=
g) { }
>
> +static inline void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_inf=
o *fs_info) { }
> +
>  static inline void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info) =
{ }
>
>  static inline bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info=
 *fs_info)
> --
> 2.43.0
>
>

