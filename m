Return-Path: <linux-btrfs+bounces-19841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E291CC8B24
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 17:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D50923140C67
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 15:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454888462;
	Wed, 17 Dec 2025 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9LzD5U6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2904832938A
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765986807; cv=none; b=LNhKVmWSe+0BuK3o8xFnLwtMv85uBYI3gh4zsISTq6mIgY0hAn1jRZD5n5FrGEy6rCbiBbi9HPi6HftUFRvn1LMiYODOHcguO4M9TrMmbUIB1x2bV6yuCBjVCVgnzTyM0wEeBv9ygcdDWh0VqkR7m8i9+k5UpHxzTdBvCiP4HwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765986807; c=relaxed/simple;
	bh=Aq/EUVD/pi+uYF9YxHPsI2E6ACFLxMop/zCMrZguxYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkawz+esvcFTYohoPilpq+TPxCXpFzedQDkqRkqjrTeMZmpWmuZKtNJqWh+XmPYKqYjVs3TQGrahHlRGzgRbKiekzWgtbLzCA/waXMCwvWu931036px2BJwt4tAfQ9DNtmbOPKsr+QYk0Jz5rYRYD517ft7tcFJk7E3KTJSFZTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9LzD5U6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B07C113D0
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765986806;
	bh=Aq/EUVD/pi+uYF9YxHPsI2E6ACFLxMop/zCMrZguxYc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A9LzD5U6orLz057uETHk0Fn1LIn/n3rTA1HNkPRg7iCSHCyI51GKaNyxR643hr5JL
	 RvUIOc0w4b5vGBxDDnTap2GCwQefC3+Ns/i7yZJd07pIaplpFpygktvzpcwXlywXYX
	 f+RVeaSuQAtdgiWMrL9ywr0XI1ll/j7pS92K9kuWkqxffqzD4g90WcECTjbTiu5tvr
	 G0Fl4o1G0rBiSWsTmKrInAQXgzESLghuh7pKIbFdkTC8/27JY+ECZG4rjcMgKncVK/
	 7OII9UUboAYR/U73jkBtU7EYnNOQnUZ9D+3Pc1wY2WrrFy37m+/HvPz1ch/aWe62RE
	 VzwMvUImf14BQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b79d6a70fc8so1047185666b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 07:53:26 -0800 (PST)
X-Gm-Message-State: AOJu0YzH2vrCRehGGifYLE/7cZ/MDEJ6ohqH46CIzXmYDN7ZIh8ZDlRq
	aX/ethbBC6WjIsjuyQ7hOBzaqhn4QnWKsJN27Oj90Cl32UT42U2XL2n3gTiTS6K+d9kSWSRC8nh
	hxZVyDWL9raaMPeyrUrS7OP4q3fy7Ink=
X-Google-Smtp-Source: AGHT+IH5Pl439BSEf34ZuNNs2J4jxBoPa35Mqh0WZwseBM5znX4EQO6V6UmcdVvL3LNZ0N+YmAj5csgGrCAsJxC7UaA=
X-Received: by 2002:a17:906:6a21:b0:b80:117d:46e5 with SMTP id
 a640c23a62f3a-b80117d4cbamr207349066b.29.1765986805082; Wed, 17 Dec 2025
 07:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217134139.275174-1-johannes.thumshirn@wdc.com> <20251217134139.275174-3-johannes.thumshirn@wdc.com>
In-Reply-To: <20251217134139.275174-3-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 17 Dec 2025 15:52:48 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6ErpgrOVekKUvkR-iB-qUGU7iQu-EQjph74yG0W5jkpA@mail.gmail.com>
X-Gm-Features: AQt7F2rbvRNSIW22ddfA-Ne6efehN8sUQOvdmo3CDHDfpvWGPR5ORzpLs8hQi8g
Message-ID: <CAL3q7H6ErpgrOVekKUvkR-iB-qUGU7iQu-EQjph74yG0W5jkpA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] btrfs: zoned: show statistics about zoned
 filesystems in mountstats
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Filipe Manana <fdmanana@suse.com>, 
	Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 2:24=E2=80=AFPM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Add statistics output to /proc/<pid>/mountstats for zoned BTRFS, similar
> to the zoned statistics from XFS in mountstats.
>
> The output for /proc/<pid>/mountstats on an example filesystem will be as
> follows:
>
>   device /dev/vda mounted on /mnt with fstype btrfs
>     zoned statistics:
>           active block-groups: 7
>             reclaimable: 0
>             unused: 5
>             need reclaim: false
>           data relocation block-group: 1342177280
>           active zones:
>             start: 1073741824, wp: 268419072 used: 0, reserved: 268419072=
, unusable: 0
>             start: 1342177280, wp: 0 used: 0, reserved: 0, unusable: 0
>             start: 1610612736, wp: 49152 used: 16384, reserved: 16384, un=
usable: 16384
>             start: 1879048192, wp: 950272 used: 131072, reserved: 622592,=
 unusable: 196608
>             start: 2147483648, wp: 212238336 used: 0, reserved: 212238336=
, unusable: 0
>             start: 2415919104, wp: 0 used: 0, reserved: 0, unusable: 0
>             start: 2684354560, wp: 0 used: 0, reserved: 0, unusable: 0
>
> Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
>  fs/btrfs/super.c | 13 ++++++++++++
>  fs/btrfs/zoned.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/zoned.h |  8 +++++++
>  3 files changed, 75 insertions(+)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index a37b71091014..e382acec2b1e 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2485,6 +2485,18 @@ static void btrfs_shutdown(struct super_block *sb)
>  }
>  #endif
>
> +static int btrfs_show_stats(struct seq_file *s, struct dentry *root)
> +{
> +       struct btrfs_fs_info *fs_info =3D btrfs_sb(root->d_sb);
> +
> +       if (btrfs_is_zoned(fs_info)) {
> +               btrfs_show_zoned_stats(fs_info, s);
> +               return 0;
> +       }
> +
> +       return 0;
> +}
> +
>  static const struct super_operations btrfs_super_ops =3D {
>         .drop_inode     =3D btrfs_drop_inode,
>         .evict_inode    =3D btrfs_evict_inode,
> @@ -2500,6 +2512,7 @@ static const struct super_operations btrfs_super_op=
s =3D {
>         .unfreeze_fs    =3D btrfs_unfreeze,
>         .nr_cached_objects =3D btrfs_nr_cached_objects,
>         .free_cached_objects =3D btrfs_free_cached_objects,
> +       .show_stats     =3D btrfs_show_stats,
>  #ifdef CONFIG_BTRFS_EXPERIMENTAL
>         .remove_bdev    =3D btrfs_remove_bdev,
>         .shutdown       =3D btrfs_shutdown,
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 359a98e6de85..fa61276058d8 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2984,3 +2984,57 @@ int btrfs_reset_unused_block_groups(struct btrfs_s=
pace_info *space_info, u64 num
>
>         return 0;
>  }
> +
> +void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_fi=
le *s)
> +{
> +       struct btrfs_block_group *bg;
> +       u64 data_reloc_bg;
> +       u64 treelog_bg;
> +
> +       seq_puts(s, "\n  zoned statistics:\n");
> +
> +       spin_lock(&fs_info->zone_active_bgs_lock);
> +       seq_printf(s, "\tactive block-groups: %zu\n",
> +                            list_count_nodes(&fs_info->zone_active_bgs))=
;
> +       spin_unlock(&fs_info->zone_active_bgs_lock);
> +
> +       spin_lock(&fs_info->unused_bgs_lock);
> +       seq_printf(s, "\t  reclaimable: %zu\n",
> +                            list_count_nodes(&fs_info->reclaim_bgs));
> +       seq_printf(s, "\t  unused: %zu\n", list_count_nodes(&fs_info->unu=
sed_bgs));
> +       spin_unlock(&fs_info->unused_bgs_lock);
> +
> +       seq_printf(s,"\t  need reclaim: %s\n",
> +                  str_true_false(btrfs_zoned_should_reclaim(fs_info)));
> +
> +       data_reloc_bg =3D data_race(fs_info->data_reloc_bg);
> +       if (data_reloc_bg)
> +               seq_printf(s, "\tdata relocation block-group: %llu\n",
> +                          data_reloc_bg);
> +       treelog_bg =3D data_race(fs_info->treelog_bg);
> +       if (treelog_bg)
> +               seq_printf(s, "\ttree-log block-group: %llu\n", treelog_b=
g);
> +
> +       spin_lock(&fs_info->zone_active_bgs_lock);
> +       seq_puts(s, "\tactive zones:\n");
> +       list_for_each_entry(bg, &fs_info->zone_active_bgs, active_bg_list=
) {
> +               u64 start;
> +               u64 alloc_offset;
> +               u64 used;
> +               u64 reserved;
> +               u64 zone_unusable;
> +
> +               spin_lock(&bg->lock);
> +               start =3D bg->start;
> +               alloc_offset =3D bg->alloc_offset;
> +               used =3D bg->used;
> +               reserved =3D bg->reserved;
> +               zone_unusable =3D bg->zone_unusable;
> +               spin_unlock(&bg->lock);
> +
> +               seq_printf(s,
> +                          "\t  start: %llu, wp: %llu used: %llu, reserve=
d: %llu, unusable: %llu\n",
> +                          start, alloc_offset, used, reserved, zone_unus=
able);
> +       }
> +       spin_unlock(&fs_info->zone_active_bgs_lock);
> +}
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 5cefdeb08b7b..e54b951359ea 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -10,6 +10,7 @@
>  #include <linux/errno.h>
>  #include <linux/spinlock.h>
>  #include <linux/mutex.h>
> +#include <linux/seq_file.h>
>  #include "messages.h"
>  #include "volumes.h"
>  #include "disk-io.h"
> @@ -96,6 +97,8 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_i=
nfo);
>  int btrfs_zoned_activate_one_bg(struct btrfs_space_info *space_info, boo=
l do_finish);
>  void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
>  int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info,=
 u64 num_bytes);
> +void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_fi=
le *s);
> +
>  #else /* CONFIG_BLK_DEV_ZONED */
>
>  static inline int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_in=
fo *fs_info)
> @@ -275,6 +278,11 @@ static inline int btrfs_reset_unused_block_groups(st=
ruct btrfs_space_info *space
>         return 0;
>  }
>
> +static inline int btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, =
struct seq_file *s)
> +{
> +       return 0;
> +}
> +
>  #endif
>
>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, =
u64 pos)
> --
> 2.52.0
>
>

