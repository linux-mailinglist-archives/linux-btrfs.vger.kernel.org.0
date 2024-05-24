Return-Path: <linux-btrfs+bounces-5280-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 697BC8CE6AA
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 16:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F76283089
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 14:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF3712C554;
	Fri, 24 May 2024 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfqRC24l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD82B12C466;
	Fri, 24 May 2024 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559706; cv=none; b=S6cw/BTn0iGX35LJ0vYLiqZURJVAv1iqQfcAUrDT0ngVOf0oC7Zpc7rNsSsQApXr6OpFnfSb4kNP5RZ4FeUy+zk1FZKMvA/rACz7lO7y/S/vKfGfHd+dckPqyS6KeStPEaDoD4gHmfsxrdShFymsT3k0sbVt4n4I3tWjlsSgQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559706; c=relaxed/simple;
	bh=jOLD+B0VxmIWv7LTxar6ty0Ee1Adzi/qqB67hBzJ79o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTccwpfmyPpcGtWokXKzKM8jWnzk5QfI/G/hXN7Qz8GbJiMzyT9DC+urMlje5JytgIacxh9E3rBsQuYqnA/5j0E5fni4qgaLXSOKagH78gk158jXS8JiFt763GHHgiz1KtYm2vbDfCNtBTPbTIt153SnYKypoOHfxOMl6+/2I5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfqRC24l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5879FC4AF09;
	Fri, 24 May 2024 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716559705;
	bh=jOLD+B0VxmIWv7LTxar6ty0Ee1Adzi/qqB67hBzJ79o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YfqRC24lOVeF+pf1yk7zDQkLmL2cfEyOfdyx8jvuexMd6HY3NyQOycMysksr57tI4
	 mx8B4I4FNwv+tjerVNSyj/9PbxLxViwzXX+3m/LGIDcKMlOaDvPFBMRdNhyGl0d55u
	 73nBoIYF2Saou6bBVRCxuvtTfjn4kbsKzlXp6hQCqGT7zsaWxlkoYQb1veKUzxjlf+
	 /TMHMsGxLxDHCC+Poa5IdJf+mfd268M/JNYUdCFUE9HteEoBWlj0ISroETLR/C6ftF
	 /u8YG/Wf9h0eT6XiKN1eM1gzjQA809XXOoy0HRWO4HeUTtHF5xGnIcx56w3y9X1BbF
	 Dm6B2H7tZlUZQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e576057c2bso131794371fa.1;
        Fri, 24 May 2024 07:08:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6glINaGGALLEW5lzqKO+KsLsSAd4jz0INwUD3HfwCqdx8eVVIAPUlFs7Q3cFapA8LBg6OAFNiDkpahzgMJ74RbMyyBZn6W34E1I54eBTop5WNqGF+y4yIqXYK9zy3495REo4ip6lfTYQ=
X-Gm-Message-State: AOJu0YyATlrvkYimn5aZJaIbnhHfER8LQDrFzTIDmucV9/s0hHGBoPlX
	nYd9WTjC9AiOsbGDL2pUTUC8yMr0Lig29d4lPBq6SRXNN0CwHu5KvXWTDwnDuDLVfLohirsTM74
	s6E5+R2fQLWbY4xshlqImmBR0Iak=
X-Google-Smtp-Source: AGHT+IETr1rNL9PKRy/0zYi5XSFyiRAy5xWNxvtpD5IaKTyo1br2sWEu3Y0Lv7DzjYnbVUIr54kYrJ56YKzjSu5D88w=
X-Received: by 2002:a2e:9899:0:b0:2e5:685a:85b5 with SMTP id
 38308e7fff4ca-2e95b041622mr21195781fa.1.1716559703630; Fri, 24 May 2024
 07:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523-zoned-gc-v4-0-23ed9f61afa0@kernel.org> <20240523-zoned-gc-v4-1-23ed9f61afa0@kernel.org>
In-Reply-To: <20240523-zoned-gc-v4-1-23ed9f61afa0@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 24 May 2024 15:07:46 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6s=3avNUCCQK9W7AH+U_82eq0LaQ5XEL28m9X8k+rHkQ@mail.gmail.com>
Message-ID: <CAL3q7H6s=3avNUCCQK9W7AH+U_82eq0LaQ5XEL28m9X8k+rHkQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] btrfs: zoned: reserve relocation block-group on mount
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Hans Holmberg <Hans.Holmberg@wdc.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 4:32=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Reserve one zone as a data relocation target on each mount. If we already
> find one empty block group, there's no need to force a chunk allocation,
> but we can use this empty data block group as our relocation target.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/block-group.c | 17 +++++++++++++
>  fs/btrfs/disk-io.c     |  2 ++
>  fs/btrfs/zoned.c       | 67 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/btrfs/zoned.h       |  3 +++
>  4 files changed, 89 insertions(+)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 9910bae89966..1195f6721c90 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1500,6 +1500,15 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info =
*fs_info)
>                         btrfs_put_block_group(block_group);
>                         continue;
>                 }
> +
> +               spin_lock(&fs_info->relocation_bg_lock);
> +               if (block_group->start =3D=3D fs_info->data_reloc_bg) {
> +                       btrfs_put_block_group(block_group);
> +                       spin_unlock(&fs_info->relocation_bg_lock);
> +                       continue;
> +               }
> +               spin_unlock(&fs_info->relocation_bg_lock);
> +
>                 spin_unlock(&fs_info->unused_bgs_lock);
>
>                 btrfs_discard_cancel_work(&fs_info->discard_ctl, block_gr=
oup);
> @@ -1835,6 +1844,14 @@ void btrfs_reclaim_bgs_work(struct work_struct *wo=
rk)
>                                       bg_list);
>                 list_del_init(&bg->bg_list);
>
> +               spin_lock(&fs_info->relocation_bg_lock);
> +               if (bg->start =3D=3D fs_info->data_reloc_bg) {
> +                       btrfs_put_block_group(bg);
> +                       spin_unlock(&fs_info->relocation_bg_lock);
> +                       continue;
> +               }
> +               spin_unlock(&fs_info->relocation_bg_lock);

Ok, so the reclaim task and cleaner kthread will not remove the
reserved block group.

But there's nothing preventing someone running balance manually, which
will delete the block group.

E.g. block group X is empty and reserved as the data relocation bg.
The balance ioctl is invoked, it goes through all block groups for relocati=
on.
It happens that it first finds bg X. Deletes bg X.

Now there's no more reserved bg for data relocation, and other tasks
can come in and use the freed space and fill all of it or most of it.

Shouldn't we prevent the data reloc bg from being a target of a manual
relocation too?
E.g. have btrfs_relocate_chunk() do nothing if the bg is the data reloc bg.

Thanks.

> +
>                 space_info =3D bg->space_info;
>                 spin_unlock(&fs_info->unused_bgs_lock);
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 78d3966232ae..16bb52bcb69e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3547,6 +3547,8 @@ int __cold open_ctree(struct super_block *sb, struc=
t btrfs_fs_devices *fs_device
>         }
>         btrfs_discard_resume(fs_info);
>
> +       btrfs_reserve_relocation_bg(fs_info);
> +
>         if (fs_info->uuid_root &&
>             (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
>              fs_info->generation !=3D btrfs_super_uuid_tree_generation(di=
sk_super))) {
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index c52a0063f7db..d291cf4f565e 100644
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
> @@ -2637,3 +2638,69 @@ void btrfs_check_active_zone_reservation(struct bt=
rfs_fs_info *fs_info)
>         }
>         spin_unlock(&fs_info->zone_active_bgs_lock);
>  }
> +
> +static u64 find_empty_block_group(struct btrfs_space_info *sinfo, u64 fl=
ags)
> +{
> +       struct btrfs_block_group *bg;
> +
> +       for (int i =3D 0; i < BTRFS_NR_RAID_TYPES; i++) {
> +               list_for_each_entry(bg, &sinfo->block_groups[i], list) {
> +                       if (bg->flags !=3D flags)
> +                               continue;
> +                       if (bg->used =3D=3D 0)
> +                               return bg->start;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +void btrfs_reserve_relocation_bg(struct btrfs_fs_info *fs_info)
> +{
> +       struct btrfs_root *tree_root =3D fs_info->tree_root;
> +       struct btrfs_space_info *sinfo =3D fs_info->data_sinfo;
> +       struct btrfs_trans_handle *trans;
> +       struct btrfs_block_group *bg;
> +       u64 flags =3D btrfs_get_alloc_profile(fs_info, sinfo->flags);
> +       u64 bytenr =3D 0;
> +
> +       lockdep_assert_not_held(&fs_info->relocation_bg_lock);
> +
> +       if (!btrfs_is_zoned(fs_info))
> +               return;
> +
> +       if (fs_info->data_reloc_bg)
> +               return;
> +
> +       bytenr =3D find_empty_block_group(sinfo, flags);
> +       if (!bytenr) {
> +               int ret;
> +
> +               trans =3D btrfs_join_transaction(tree_root);
> +               if (IS_ERR(trans))
> +                       return;
> +
> +               ret =3D btrfs_chunk_alloc(trans, flags, CHUNK_ALLOC_FORCE=
);
> +               btrfs_end_transaction(trans);
> +               if (ret)
> +                       return;
> +
> +               bytenr =3D find_empty_block_group(sinfo, flags);
> +               if (!bytenr)
> +                       return;
> +
> +       }
> +
> +       bg =3D btrfs_lookup_block_group(fs_info, bytenr);
> +       if (!bg)
> +               return;
> +
> +       if (!btrfs_zone_activate(bg))
> +               bytenr =3D 0;
> +
> +       btrfs_put_block_group(bg);
> +
> +       spin_lock(&fs_info->relocation_bg_lock);
> +       fs_info->data_reloc_bg =3D bytenr;
> +       spin_unlock(&fs_info->relocation_bg_lock);
> +}
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index ff605beb84ef..56c1c19d52bc 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -95,6 +95,7 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_i=
nfo);
>  int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
>                                 struct btrfs_space_info *space_info, bool=
 do_finish);
>  void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
> +void btrfs_reserve_relocation_bg(struct btrfs_fs_info *fs_info);
>  #else /* CONFIG_BLK_DEV_ZONED */
>
>  static inline int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_in=
fo *fs_info)
> @@ -264,6 +265,8 @@ static inline int btrfs_zoned_activate_one_bg(struct =
btrfs_fs_info *fs_info,
>
>  static inline void btrfs_check_active_zone_reservation(struct btrfs_fs_i=
nfo *fs_info) { }
>
> +static inline void btrfs_reserve_relocation_bg(struct btrfs_fs_info *fs_=
info) { }
> +
>  #endif
>
>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, =
u64 pos)
>
> --
> 2.43.0
>
>

