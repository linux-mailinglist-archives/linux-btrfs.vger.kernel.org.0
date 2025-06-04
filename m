Return-Path: <linux-btrfs+bounces-14460-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB00ACE20F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 18:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42333A5AD3
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 16:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A3B1E1E1E;
	Wed,  4 Jun 2025 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGzh2CKJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15221DFD96
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053854; cv=none; b=bGQW0ywvEAEk+yuvjCVRc2Z98VZGTG1YdKrdPSyxyy86H35NwkP6XwOySswzVX/WE9SUx8oF4Uw/BiyhHedARXDTuqigheHHXivZZebvN5Pwrjibcq7X3/3F69iPw15W2dBZG7oNWn+VhMTBrqFcL0k3xf4FgiWrSKEP02F7hqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053854; c=relaxed/simple;
	bh=52XJNZMjwvpL/wE9fSkhHReRrEmHQ1CHIb/7h2+P2Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0t22TjXpvIzJZTUilAqGXof7ZYNapMfzc+YyGnotLtz2hCs7mNotRClXJYXo5yxtnjigSUFjp+fx8w6DfA1GOhOcZ7fAGnBfZNM69FI5ZJAIRDctpY6xOa0InTXAo+SwonY+pC9wrrgGD1GYiQio55GUGRWfhKCr/kRU2klByk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGzh2CKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102B0C4CEED
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 16:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749053854;
	bh=52XJNZMjwvpL/wE9fSkhHReRrEmHQ1CHIb/7h2+P2Zs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kGzh2CKJSVmn/LlEmspAfvqr4li336YLi09p8q/ljPyOJDOJJkGS+XCR+YQch13HU
	 IWN80MWRwbOctsR3VGZZoJx4nS7dSfxWZmTbvrYsdJPbojaUw3dnKb/YixC0CRSYzW
	 aq7pCU+nTT8tBAJFIyzEtWx0ei3Vl2EewVxEf5t3kCQvpkIGuIz++Cw+Azh2A/ktBI
	 8pI6SxVVcBY6YbG3Q2wvZPf1pjFGn8aUhWpCFHg45p+sJXsKeW4J4wJeJhbuHOwa5r
	 BeSrkRAGv7CnGsjE4DRg/hiJME7xWgnSJv36uq2rqlo9D49EGEaKclEogK7RXshbWi
	 S5e5G1fbMFyLg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6049431b409so12342334a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Jun 2025 09:17:33 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywgvw7BKIpIxnxu77kSCXWt3C2cpkBEEY939JWTZmiCrKcEeU9a
	jw/zZLfS56lPAVHJVP0G4w9iGjsEEsa45tZSD8ZG4siS+p3PrYjJEvMVPdYGbEMmLJi7oynEO/l
	0Whche+EXkN4sDqWPkreRDMATnEA64cc=
X-Google-Smtp-Source: AGHT+IH4h66x6TfrJHka1QJCT52LdNBD9eYc+oA+6in/PHlOpl0wvEXdzTJyHLptB0HSggpHeqxuLHsqOAp2j87bvhw=
X-Received: by 2002:a17:907:6d28:b0:adb:449c:7621 with SMTP id
 a640c23a62f3a-addf8e7ea4cmr368347066b.29.1749053852614; Wed, 04 Jun 2025
 09:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604084630.346863-1-jth@kernel.org>
In-Reply-To: <20250604084630.346863-1-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 4 Jun 2025 17:16:55 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5eBQijxZXt8NN8xX=g114ZOv++-CLO5XkrbVOqzB0Y2g@mail.gmail.com>
X-Gm-Features: AX0GCFsf_FYSwd0t6phSJ-F_BZZfE0tGaabOH4mPauXtr9HzuHgI1D_jHibIxKY
Message-ID: <CAL3q7H5eBQijxZXt8NN8xX=g114ZOv++-CLO5XkrbVOqzB0Y2g@mail.gmail.com>
Subject: Re: [PATCH v5] btrfs: zoned: reserve data_reloc block group on mount
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>, 
	Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>, 
	Josef Bacik <josef@toxicpanda.com>, Filipe Manana <fdmanana@suse.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 9:46=E2=80=AFAM Johannes Thumshirn <jth@kernel.org> =
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
> Changes to v4:
> - Use btrfs_commit_transaction() instead of btrfs_end_transaction
>
>  fs/btrfs/disk-io.c |  1 +
>  fs/btrfs/zoned.c   | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/zoned.h   |  3 +++
>  3 files changed, 65 insertions(+)
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
> index 19710634d63f..4e122d6c19c0 100644
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
> @@ -2443,6 +2444,66 @@ void btrfs_clear_data_reloc_bg(struct btrfs_block_=
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
> +       struct list_head *bg_list;
> +       u64 alloc_flags;
> +       bool initial =3D false;
> +       bool did_chunk_alloc =3D false;
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
> +       bg_list =3D &data_sinfo->block_groups[index];
> +again:
> +       list_for_each_entry(bg, bg_list, list) {
> +               if (bg->used > 0)
> +                       continue;
> +
> +               if (!initial) {
> +                       initial =3D true;
> +                       continue;
> +               }
> +
> +               fs_info->data_reloc_bg =3D bg->start;
> +               set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &bg->runtime_f=
lags);
> +               btrfs_zone_activate(bg);
> +
> +               return;
> +       }
> +
> +       if (did_chunk_alloc)
> +               return;
> +
> +       trans =3D btrfs_join_transaction(fs_info->tree_root);
> +       if (IS_ERR(trans))
> +               return;
> +
> +       ret =3D btrfs_chunk_alloc(trans, space_info, alloc_flags, CHUNK_A=
LLOC_FORCE);
> +       btrfs_commit_transaction(trans);

Ok so the commit makes a difference and I suppose it fixes the zoned
specific corruption you mentioned before.

Can we please get a comment here that explains why it's needed?
Because normally we don't need to do it, it's enough to call
btrfs_end_transaction() and anyone is able to use the new block group.

Thanks.

> +       if (ret =3D=3D 1) {
> +               did_chunk_alloc =3D true;
> +               bg_list =3D &space_info->block_groups[index];
> +               goto again;
> +       }
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

