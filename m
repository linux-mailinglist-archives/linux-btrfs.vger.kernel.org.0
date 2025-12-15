Return-Path: <linux-btrfs+bounces-19741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1383DCBD62F
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 11:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4962B3019198
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EF43164DB;
	Mon, 15 Dec 2025 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJrzZ6jE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9B1314A8E
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765795160; cv=none; b=pSwPmwl61IVIWQVkQt5Yc6imyBw+vVFcu61Ztde9s1pC9vGVDsE6mBI2Ra6TbwYiZpqv9G/3HpuQFXg/wVII29KSjteKo+Ti4NzLgJS81ZqrlGTq5g3kEVBzEMKf+2cIf8i4Lxofn9yb5c/099u2nyonHVCy4DLMxV65SnicHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765795160; c=relaxed/simple;
	bh=vGSF6K5zCfynjMKyz5F9NAYFfV1tXg3c/K6I0x2CMsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wcx6jpQppTe8i1DryG08AatriHd/eJmthyADCuh+NgDdhN3c9Jv0uXRFwXHP81kQsUIlUK8FNXvHgq2gJEp92cv1vgoCDmdEz7KqS+9pA15ONe25c0zpUPvwQvIvpYNwQ2cV/Lzws8hXE8IsFBc6wIhvftNoZ7a1K5q0aGNWmog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJrzZ6jE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26460C4CEF5
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 10:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765795160;
	bh=vGSF6K5zCfynjMKyz5F9NAYFfV1tXg3c/K6I0x2CMsE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FJrzZ6jEqmddi2SPAPAP99gmJJZepnzXU4YVe7i3u+b22wKYied+jPrLAIxbAPXWl
	 uIqb83Xa7pF7geJpb/pwLA5unS2Da97h0p6niDb2xO4lEb+AG49g/USJag1zZoQb1f
	 58GdW8FM6fpoI9Qf6wELO7fPRfnBHRgc8Al26wTT6vfwmZmW1HdMiRS0JSHD1Y4td6
	 roOU15LmPrr0N9UaBlvwuOahhPSt1l9JvfC8GUmV0L/ZM7AhiOL4hmk8ZwXyv+/iNu
	 iVFRymRykdNswW/VwoP+DufCFC5Xwdfbz+xkGjbncIbPpbq79Yk+qHflv4R9JZx6Xl
	 H8S9qu2/a2/4g==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so5690386a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 02:39:20 -0800 (PST)
X-Gm-Message-State: AOJu0YydcqJH9ChnkYE8DStqNZUb3SFY76vYUX61MVGChCjFlP/BhVPu
	FnqC3IP+MVXrq+kPLyylKdkgH5GegGnJVwz4bbmEqhu7JdtFQWEE+vrbj1RHAFzDMjkolBRa+Wi
	Ug01ebuMYE7pJrVbs+ONq06H3N+oLqfI=
X-Google-Smtp-Source: AGHT+IFqcgyZl3rUACXsitNdKGdK8k23bQpcKo5lBexucLNU9aWPZYtAy3slJg5XgUasMyGPKVnoLsXlEfuicvfggqc=
X-Received: by 2002:a17:907:7b82:b0:b70:68d7:ac0c with SMTP id
 a640c23a62f3a-b7d238ddd7emr893971566b.42.1765795158741; Mon, 15 Dec 2025
 02:39:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251213050305.10790-1-johannes.thumshirn@wdc.com> <20251213050305.10790-2-johannes.thumshirn@wdc.com>
In-Reply-To: <20251213050305.10790-2-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Dec 2025 10:38:41 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5pJXeNwuD7+BEfnXrKnRE8Ff10Rtr02OUjWfgA=euoUw@mail.gmail.com>
X-Gm-Features: AQt7F2p0i1eozarzZyrdWWA4BTIZxScwQChW8f96M-WsxDwH_W6tJM_gVt2x9io
Message-ID: <CAL3q7H5pJXeNwuD7+BEfnXrKnRE8Ff10Rtr02OUjWfgA=euoUw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] btrfs: zoned: move zoned stats to mountstats
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 13, 2025 at 5:03=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Move zoned statistics to /proc/<pid>/mountstats just like it is for XFS,
> because sysfs is limited to a single page, which causes the output to be
> truncated.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/super.c | 12 +++++++++++
>  fs/btrfs/sysfs.c | 52 ------------------------------------------------
>  fs/btrfs/zoned.c | 43 +++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/zoned.h |  8 ++++++++
>  4 files changed, 63 insertions(+), 52 deletions(-)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index a37b71091014..ecbfeaa859a0 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2485,6 +2485,17 @@ static void btrfs_shutdown(struct super_block *sb)
>  }
>  #endif
>
> +static int btrfs_show_stats(struct seq_file *s, struct dentry *root)
> +{
> +       struct btrfs_fs_info *fs_info =3D btrfs_sb(root->d_sb);
> +
> +       if (!btrfs_is_zoned(fs_info))
> +               return 0 ;
> +
> +       btrfs_show_zoned_stats(fs_info, s);
> +       return 0;
> +}
> +
>  static const struct super_operations btrfs_super_ops =3D {
>         .drop_inode     =3D btrfs_drop_inode,
>         .evict_inode    =3D btrfs_evict_inode,
> @@ -2500,6 +2511,7 @@ static const struct super_operations btrfs_super_op=
s =3D {
>         .unfreeze_fs    =3D btrfs_unfreeze,
>         .nr_cached_objects =3D btrfs_nr_cached_objects,
>         .free_cached_objects =3D btrfs_free_cached_objects,
> +       .show_stats     =3D btrfs_show_stats,
>  #ifdef CONFIG_BTRFS_EXPERIMENTAL
>         .remove_bdev    =3D btrfs_remove_bdev,
>         .shutdown       =3D btrfs_shutdown,
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 7f00e4babbc1..f0974f4c0ae4 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -25,7 +25,6 @@
>  #include "misc.h"
>  #include "fs.h"
>  #include "accessors.h"
> -#include "zoned.h"
>
>  /*
>   * Structure name                       Path
> @@ -1188,56 +1187,6 @@ static ssize_t btrfs_commit_stats_store(struct kob=
ject *kobj,
>  }
>  BTRFS_ATTR_RW(, commit_stats, btrfs_commit_stats_show, btrfs_commit_stat=
s_store);
>
> -static ssize_t btrfs_zoned_stats_show(struct kobject *kobj,
> -                                     struct kobj_attribute *a, char *buf=
)
> -{
> -       struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);
> -       struct btrfs_block_group *bg;
> -       size_t ret =3D 0;
> -
> -
> -       if (!btrfs_is_zoned(fs_info))
> -               return ret;
> -
> -       spin_lock(&fs_info->zone_active_bgs_lock);
> -       ret +=3D sysfs_emit_at(buf, ret, "active block-groups: %zu\n",
> -                            list_count_nodes(&fs_info->zone_active_bgs))=
;
> -       spin_unlock(&fs_info->zone_active_bgs_lock);
> -
> -       mutex_lock(&fs_info->reclaim_bgs_lock);
> -       spin_lock(&fs_info->unused_bgs_lock);
> -       ret +=3D sysfs_emit_at(buf, ret, "\treclaimable: %zu\n",
> -                            list_count_nodes(&fs_info->reclaim_bgs));
> -       ret +=3D sysfs_emit_at(buf, ret, "\tunused: %zu\n",
> -                            list_count_nodes(&fs_info->unused_bgs));
> -       spin_unlock(&fs_info->unused_bgs_lock);
> -       mutex_unlock(&fs_info->reclaim_bgs_lock);
> -
> -       ret +=3D sysfs_emit_at(buf, ret, "\tneed reclaim: %s\n",
> -                            str_true_false(btrfs_zoned_should_reclaim(fs=
_info)));
> -
> -       if (fs_info->data_reloc_bg)
> -               ret +=3D sysfs_emit_at(buf, ret,
> -                                    "data relocation block-group: %llu\n=
",
> -                                    fs_info->data_reloc_bg);
> -       if (fs_info->treelog_bg)
> -               ret +=3D sysfs_emit_at(buf, ret,
> -                                    "tree-log block-group: %llu\n",
> -                                    fs_info->treelog_bg);
> -
> -       spin_lock(&fs_info->zone_active_bgs_lock);
> -       ret +=3D sysfs_emit_at(buf, ret, "active zones:\n");
> -       list_for_each_entry(bg, &fs_info->zone_active_bgs, active_bg_list=
) {
> -               ret +=3D sysfs_emit_at(buf, ret,
> -                                    "\tstart: %llu, wp: %llu used: %llu,=
 reserved: %llu, unusable: %llu\n",
> -                                    bg->start, bg->alloc_offset, bg->use=
d,
> -                                    bg->reserved, bg->zone_unusable);
> -       }
> -       spin_unlock(&fs_info->zone_active_bgs_lock);
> -       return ret;
> -}
> -BTRFS_ATTR(, zoned_stats, btrfs_zoned_stats_show);
> -
>  static ssize_t btrfs_clone_alignment_show(struct kobject *kobj,
>                                 struct kobj_attribute *a, char *buf)
>  {
> @@ -1649,7 +1598,6 @@ static const struct attribute *btrfs_attrs[] =3D {
>         BTRFS_ATTR_PTR(, bg_reclaim_threshold),
>         BTRFS_ATTR_PTR(, commit_stats),
>         BTRFS_ATTR_PTR(, temp_fsid),
> -       BTRFS_ATTR_PTR(, zoned_stats),
>  #ifdef CONFIG_BTRFS_EXPERIMENTAL
>         BTRFS_ATTR_PTR(, offload_csum),
>  #endif
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 359a98e6de85..41c6b58556a9 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2984,3 +2984,46 @@ int btrfs_reset_unused_block_groups(struct btrfs_s=
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
> +       seq_puts(s, "\n");
> +
> +       spin_lock(&fs_info->zone_active_bgs_lock);
> +       seq_printf(s, "\tactive block-groups: %zu\n",
> +                            list_count_nodes(&fs_info->zone_active_bgs))=
;
> +       spin_unlock(&fs_info->zone_active_bgs_lock);
> +
> +       mutex_lock(&fs_info->reclaim_bgs_lock);
> +       spin_lock(&fs_info->unused_bgs_lock);
> +       seq_printf(s, "\t  reclaimable: %zu\n",
> +                            list_count_nodes(&fs_info->reclaim_bgs));
> +       seq_printf(s, "\t  unused: %zu\n", list_count_nodes(&fs_info->unu=
sed_bgs));
> +       spin_unlock(&fs_info->unused_bgs_lock);
> +       mutex_unlock(&fs_info->reclaim_bgs_lock);
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
> +               seq_printf(s,
> +                          "\t  start: %llu, wp: %llu used: %llu, reserve=
d: %llu, unusable: %llu\n",
> +                          bg->start, bg->alloc_offset, bg->used, bg->res=
erved,
> +                          bg->zone_unusable);

We need data_race(), or bg locking, before accessing ->used, ->reserved, et=
c...

> +       }
> +       spin_unlock(&fs_info->zone_active_bgs_lock);

I think it would be nice and clear to an example output of the file to
changelog, like the one you pasted here:

https://lore.kernel.org/linux-btrfs/847e76d6-fc1a-434e-85ef-b6887f426934@wd=
c.com/

Thanks.


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

