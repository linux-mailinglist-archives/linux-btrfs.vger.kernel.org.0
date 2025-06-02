Return-Path: <linux-btrfs+bounces-14386-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6112ACB9B3
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 18:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B970C3BD235
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 16:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217662248B0;
	Mon,  2 Jun 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJpNm5TM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0722C3258
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748882232; cv=none; b=t8YbX58dcLygx3pqCjrq/1cnLJ8CTj6Dl5jioqVxu8pz6rFTFej1sg/Ezg1sD3TzbjWoDB5sVEjl3IONH+DcoGLMQxIX7hJ3ZGZW6QJJBlLO3Z5/ny9itu3dZ7JMWfmWAf5ijGqXfow10TceINtjCLMAaio8PVEgJxrS5pXRhEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748882232; c=relaxed/simple;
	bh=8bXwCF07yfY7LvmuhOUArV98TP80no0Arqvmxnybg4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0u6CfY9wp5GqvK72hwcBL3v0c/mo6ssWwtSbo8CT3Rsuf8v9rFDZqRvlXyT4Pn03uK0PlshI8Xk6bMPRyF6nyIeGgJD16wEi925sB2Wc3OezwuJblEUKV8eN43HGpeL5k1354O+tpoLXFJS082FEdN/zDl9cll0HSFhgkSvh24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJpNm5TM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF341C4CEF2
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 16:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748882231;
	bh=8bXwCF07yfY7LvmuhOUArV98TP80no0Arqvmxnybg4w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LJpNm5TMutWerpRv/PP9RQDIf0v2M4iaR94jFCk8wrR0JTmU+Ew7/r35AVVyX77pS
	 Xy2qxI7wavMpSHcIczmspbLGFjFX8zJ+QpcQBKjAS92iJbba7L77IN5spbarvxA0KC
	 IWCpRL3mY0OblBHNjW3jEY8fYY+rlx8gBgiZpwgxkMGyI6MZKG6j7j/3PqW/eDm+Zd
	 IiijBrmd/LTmLvocqbjKPT/P5xOAo77i6n/MTAedy3RD33KQh9mhZn7Z5Ulwo9TZmb
	 0+2BfnLBJ2cTsP0aHxKqeL90j+vjmHHIueGDdvoIPOuGqYmn+236Ujs7YABJxDNrSK
	 TLlY7uU188q+A==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad51ba0af48so997951266b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Jun 2025 09:37:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YyQ8CboiXC5s19N+kf82o3B/z4/eRAlppsi1ezeTRLs77CggCab
	qCGKE3b+chuDRB+XqZ4ZUHfpEoNtRQkWtllTHDsrcl0wOTsLz6mm40z6olYznP6RULHG5cpn5kJ
	+MvrTseUjwxvpW4tv2sNaHBhOMcqG+KI=
X-Google-Smtp-Source: AGHT+IEGK2CTzxDbiFIT1EjZOXEzeNV7YqOmGz5LXFL6gwRiYyLuAa1n8zpGXfXya8xeMt0DDg2MceCCVFo30CyzIxk=
X-Received: by 2002:a17:907:9307:b0:ad8:ace9:e280 with SMTP id
 a640c23a62f3a-adde0c71af7mr11796266b.5.1748882230383; Mon, 02 Jun 2025
 09:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602162038.3840-1-jth@kernel.org>
In-Reply-To: <20250602162038.3840-1-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 2 Jun 2025 17:36:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4p4RQ46vCUJYREn3BgYa9SBY1eMeaGpyM=0Jz15WH35A@mail.gmail.com>
X-Gm-Features: AX0GCFtKR5CHle5qd87ZTL8Ye-Q5P_FNxM-tm8sAYdZU86LVyBMC-hJV2VP3KAA
Message-ID: <CAL3q7H4p4RQ46vCUJYREn3BgYa9SBY1eMeaGpyM=0Jz15WH35A@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: zoned: reserve data_reloc block group on mount
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Josef Bacik <josef@toxicpanda.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Filipe Manana <fdmanana@suse.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 5:22=E2=80=AFPM Johannes Thumshirn <jth@kernel.org> =
wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Create a block group dedicated for data relocation on mount of a zoned
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
> Changes to v2:
> - Don't take references
> - Use btrfs_chunk_alloc()
> - Don't abort the transaction
> - Decrease indendation
>
>
>  fs/btrfs/disk-io.c |  1 +
>  fs/btrfs/zoned.c   | 71 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/zoned.h   |  3 ++
>  3 files changed, 75 insertions(+)
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
> index 19710634d63f..663cd194522b 100644
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
> @@ -2443,6 +2444,76 @@ void btrfs_clear_data_reloc_bg(struct btrfs_block_=
group *bg)
>         spin_unlock(&fs_info->relocation_bg_lock);
>  }
>
> +void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
> +{
> +       struct btrfs_space_info *data_sinfo =3D fs_info->data_sinfo;
> +       struct btrfs_space_info *space_info =3D data_sinfo->sub_group[0];
> +       struct btrfs_trans_handle *trans;
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
> +       ASSERT(space_info->subgroup_id =3D=3D BTRFS_SUB_GROUP_DATA_RELOC)=
;
> +       alloc_flags =3D btrfs_get_alloc_profile(fs_info, space_info->flag=
s);
> +       index =3D btrfs_bg_flags_to_raid_index(alloc_flags);
> +
> +       list_for_each_entry(bg, &data_sinfo->block_groups[index], list) {
> +               if (bg->used > 0)
> +                       continue;
> +
> +               if (!initial) {
> +                       initial =3D true;
> +                       continue;
> +               }
> +
> +               fs_info->data_reloc_bg =3D bg->start;
> +               set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
> +                       &bg->runtime_flags);
> +               btrfs_zone_activate(bg);
> +
> +               return;
> +       }
> +
> +       trans =3D btrfs_join_transaction(fs_info->tree_root);
> +       if (IS_ERR(trans))
> +               return;
> +
> +       ret =3D btrfs_chunk_alloc(trans, space_info, alloc_flags, CHUNK_A=
LLOC_FORCE);
> +       if (ret !=3D 1)
> +               goto out;
> +
> +       list_for_each_entry(bg, &space_info->block_groups[index], list) {
> +               if (bg->used > 0)
> +                       continue;
> +
> +               if (!initial) {
> +                       initial =3D true;
> +                       continue;
> +               }
> +
> +               fs_info->data_reloc_bg =3D bg->start;
> +               set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
> +                       &bg->runtime_flags);
> +               btrfs_zone_activate(bg);
> +
> +               break;
> +       }

Instead of duplicating the iteration code, we could use a label and a
boolean to track if we already allocated a chunk, something like this:

https://pastebin.com/raw/jrFtUVFj

Otherwise it looks good to me.
Thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +
> +out:
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
> 2.49.0
>
>

