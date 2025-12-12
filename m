Return-Path: <linux-btrfs+bounces-19697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7595BCB8827
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 10:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 226C430B9BFA
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 09:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAA7313524;
	Fri, 12 Dec 2025 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTsPOUJs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA211586C2
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532360; cv=none; b=X+bfq56HHX6u06nFYaRanNXuySapmY7ptZ7B3c5n6/e56VRO+NA04rorkGdEGIwapW+MXL4koyX4xCr1eeZYpXNMT7E+7VuuQsz4k4yOlzJ+gAyz3GLFywthGVkhd3VxbEmIqcUIBHVPAFd8XoPiuNqIL+hScogr2l8EkCNAs3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532360; c=relaxed/simple;
	bh=L4JmMcm2e7xIiVXOeNkK38obdpqi535MPFLH1xYUj2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qi/eBTf3RtB/2ErZ9W4nOJ8a77Xl3Pxj/qWK82DMPM0/6pe5kEEEq54Xzs3lYmc8aYTc++g1uTm4AKojapj0bPTfmxciNhnDyCNagUJqqIG40G7jNpZpXi8OXhsmjrJJBJo2Gq0lt5e+stj23BGWbwLk9sbWNHuHVg2qMdtDo3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTsPOUJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93528C4CEF5
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 09:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765532359;
	bh=L4JmMcm2e7xIiVXOeNkK38obdpqi535MPFLH1xYUj2U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NTsPOUJs5IQvTenjSWIBdJZ1Y6tuvP23I4dmfT6vs4tpznCwKUmvwOcRSXk6kmFyl
	 +Ns0UolXWQDlsJNjrF58YpBKAc+vMsQZUDgPttGxaXmOXtjLfmMsX+YGqYGBAavxpX
	 K9Zlr+xVBhfTuD2PcufGDo/7ZgQ1y2R4hZXCDjuYC6Hv9FodQjom+95GgC2dqMAvpy
	 Z8ZpwvU272yYOddnnYLkAVVVhIWVxrV358jO6pTD2XATAa6dHrw+QlslJMI9jPWMep
	 CagUqwj9dswhGKl7w2ZDkBW3aKBUzJlf597+he4tgG7cbKTfCMzqdfZFCNFr1LZKFH
	 1fy6p5G/jHtkQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6496a094ae1so1502545a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 01:39:19 -0800 (PST)
X-Gm-Message-State: AOJu0YxpHq1vfKrMJR2Y/wHFJx8F6U7JuRUdl5NN5ai7TFxdUDdM9ff3
	SsWkduGWLdgwr305FxCK+3t7k+I58ZVt7K/QMjycXMvJFrc2BhSe3aMDL/CCiOEizXxoFKQ0tNo
	392hncILsJlq7YBC9BSvdO0bmJOgwB14=
X-Google-Smtp-Source: AGHT+IF+PtYvdn5+Bv0E1pEIOESpbJdncLX5aoFfZH/SENkBqXvUuJu7zYnCDyo79PFY1cMOwPqPjgBvOX5k30hHRRY=
X-Received: by 2002:a17:907:7202:b0:b6d:5262:a615 with SMTP id
 a640c23a62f3a-b7d238c34e4mr135486666b.41.1765532358205; Fri, 12 Dec 2025
 01:39:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212071000.135950-1-johannes.thumshirn@wdc.com> <20251212071000.135950-2-johannes.thumshirn@wdc.com>
In-Reply-To: <20251212071000.135950-2-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Dec 2025 09:38:41 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5xbK_XXwNe8G+JHEmgbv2gcOU73sEqHFWFA+NCExiiaw@mail.gmail.com>
X-Gm-Features: AQt7F2qIdpY99qQTHmT_sbj5l5XteZ9qVS-EYOU4tX1nacmnsDE-y7FqgOSEjlc
Message-ID: <CAL3q7H5xbK_XXwNe8G+JHEmgbv2gcOU73sEqHFWFA+NCExiiaw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] btrfs: zoned: move zoned stats to mountstats
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 7:12=E2=80=AFAM Johannes Thumshirn
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
>  fs/btrfs/zoned.c | 40 +++++++++++++++++++++++++++++++++++++
>  fs/btrfs/zoned.h |  8 ++++++++
>  4 files changed, 60 insertions(+), 52 deletions(-)
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
> index 359a98e6de85..2235187a2807 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2984,3 +2984,43 @@ int btrfs_reset_unused_block_groups(struct btrfs_s=
pace_info *space_info, u64 num
>
>         return 0;
>  }
> +
> +void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_fi=
le *s)
> +{
> +       struct btrfs_block_group *bg;
> +
> +       seq_puts(s, "\n");

Why the newline if we haven't printed anything yet?

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
> +       if (fs_info->data_reloc_bg)
> +               seq_printf(s, "\tdata relocation block-group: %llu\n",
> +                               fs_info->data_reloc_bg);

Should this be under a critical section delimited by the spinlock
fs_info->relocation_bg_lock?

> +       if (fs_info->treelog_bg)
> +               seq_printf(s, "\ttree-log block-group: %llu\n",
> +                               fs_info->treelog_bg);

And this in a critical section delimited by the spinlock
fs_info->treelog_bg_lock?

I also wonder why there are all the tabs and spaces at the beginning
of each line when we are not like in a subsection.

Thanks.

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

