Return-Path: <linux-btrfs+bounces-14361-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08955ACAC67
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 12:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CFC189DE70
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 10:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72261EDA3A;
	Mon,  2 Jun 2025 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig2kzufl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068571DED64
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748859941; cv=none; b=kpyPCr7R+bJkNoIsYgRngRtY0zBC1CP6i6N4jdv5/QI1HaOPnF0GNNZlZE3WM99hS7wyH7TbqWJTXoGOVDHv+n11byjun5nWAg18qYatolKrG3CUy/FipYNsr1eBbLsug34OtgyZY2+/KFpAqXJc/XVgpKceEX89l7iVQX+5Mvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748859941; c=relaxed/simple;
	bh=AZ9nCcMjD7BlXQ9Fc32U5AA2vEnu4IcI7wLg4BE2P2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8PutvlcFTQBjxPFW4eTLnp/UiYTBEczTpZbs3qLyqABiLcukk1qnkL5JMCWXBwM0z3bA5aB4IQQQLnIvwrPrFZ3UBU8I0L0kXp8tU+7OKgQxEy5VbmMYw3baQeTwkLYfWmPx09z3Xhf54V+LU2WTE2U5JCPq8b2MXUxbpwixV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig2kzufl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A004C4AF09
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748859940;
	bh=AZ9nCcMjD7BlXQ9Fc32U5AA2vEnu4IcI7wLg4BE2P2k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ig2kzuflsZHBFl3vgSzuxT597aNRRc9j9RdecBzMgSwDEYdgovpYMHiulLkHJ70tW
	 9zRYWmz7GMYdisdnXDgciztNp8aJhOEMJSQfXfLfC+K4OtoNEscjAMzsR6tbuZkZ87
	 3XwGKjkLREL6TplCufw/eb8JUndnivzvzolM4e5EmztPW241Bq1Cz8LxJBeldN/KHV
	 4Jrj92fMO9O/QiLJFsJWsXDaBFveSa+Q58sIUZMae5aMa+cGmQd9hFhHlKZEIScxGI
	 oY5qDgDqMneGA7uerriDsxbe38wz/qxKM9E+0osX+23SlQLprw8PqGGHEHWbp6miCa
	 uXH2rIzea6idg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-adb5cb6d8f1so180956266b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Jun 2025 03:25:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YwjHBcZ82PYJZ7X7KgJKQ60/HNlUFhhA0opVpB+qWAAC9aSlY5p
	SeyKGM+1kvv3XJFUHMi75RvkuYp7jDc6619o9wHBH0K7vogMmLPV8CA7P7nf6QR4ukgJouIqwHu
	QAQrZVWPD6AiroYCMvS8TJh8yQg8QAQo=
X-Google-Smtp-Source: AGHT+IE6se/FSptreIfbvytf+s0C6cI4DWos1ykkCiYSAIV+fY1Rhjgy6Es7Y7g5xiM7URUAX32i9VljEx0nWUz4d1M=
X-Received: by 2002:a17:907:1c1b:b0:ada:abf7:d0e1 with SMTP id
 a640c23a62f3a-adb36bf41b5mr1001700766b.37.1748859938933; Mon, 02 Jun 2025
 03:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6133ab918b19507738e4fa08be23b73be0d8d84e.1748842937.git.johannes.thumshirn@wdc.com>
In-Reply-To: <6133ab918b19507738e4fa08be23b73be0d8d84e.1748842937.git.johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 2 Jun 2025 11:25:02 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4jC9Hpbuzt3h2BzWr-StqO_aVAJDm6xXS2erV5L=5ucg@mail.gmail.com>
X-Gm-Features: AX0GCFuIcVDEuCRn87SIbBt9hwwt_XsRtNZOG5ihcw20NFrUQvT6pgIVM_B_6-E
Message-ID: <CAL3q7H4jC9Hpbuzt3h2BzWr-StqO_aVAJDm6xXS2erV5L=5ucg@mail.gmail.com>
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
> +       ASSERT(space_info->subgroup_id =3D=3D BTRFS_SUB_GROUP_DATA_RELOC)=
;
> +       alloc_flags =3D btrfs_get_alloc_profile(fs_info, space_info->flag=
s);
> +       index =3D btrfs_bg_flags_to_raid_index(alloc_flags);
> +
> +       list_for_each_entry(bg, &data_sinfo->block_groups[index], list) {
> +               btrfs_get_block_group(bg);
> +               if (!bg->used) {
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

Also, if a transaction is used only for chunk allocation, it doesn't
matter which root we pass, just pass fs_info->tree_root to
btrfs_join_transaction().
No need to have this logic here and declare a root variable.

Thanks.

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
> +               btrfs_end_transaction(trans);
> +               return;
> +       }
> +
> +       ret =3D btrfs_chunk_alloc_add_chunk_item(trans, bg);
> +       if (ret) {
> +               mutex_unlock(&fs_info->chunk_mutex);
> +               btrfs_abort_transaction(trans, ret);
> +               btrfs_end_transaction(trans);
> +               return;
> +       }
> +       mutex_unlock(&fs_info->chunk_mutex);
> +
> +       btrfs_get_block_group(bg);
> +       fs_info->data_reloc_bg =3D bg->start;
> +       set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &bg->runtime_flags);
> +       btrfs_zone_activate(bg);
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

