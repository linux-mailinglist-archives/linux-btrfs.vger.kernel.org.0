Return-Path: <linux-btrfs+bounces-8089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3E897B330
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 18:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED021F24E41
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 16:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3384817B4ED;
	Tue, 17 Sep 2024 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arADsnIA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572972905
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726592261; cv=none; b=YQk2gqP3sVvqb4ehPOGOQXchQ7HvaG6V5BTpGRkDNvjPBYbu+0HgX66CMMPexy7oJAjwQEM214QaYkyHy8ChYUUwLaD5GFBLEdDLleIEW5Zu6IjTXAFaBqSGCEmdKVG/cWz3b7XWWcLA48wLWvyCA1QJUsdh94g4L5/fcmDGnjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726592261; c=relaxed/simple;
	bh=UP1FCLcqHIrhlElllV6CXN3XOlJ8o7l0ZK/ZIc09Dh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgWPu82+MINcC7q/mF4JQ/JFECY16CpGD6ePqfiybqQD88KISvh1tzQaA3LdAR6Qr0+M1NAd2Q4C3UYZlzUkwMu/CzNn+1pTVi2dcxNs+Pj+UEBTipuLfJNMDZW/pVSLhk3fhJh86jkAqkcoV/gctl8bs2wWIeudU3jUsgAAWCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arADsnIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6633C4CEC5
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 16:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726592260;
	bh=UP1FCLcqHIrhlElllV6CXN3XOlJ8o7l0ZK/ZIc09Dh8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=arADsnIAcJ+HM4yQdIglZmbxSkxpqfUY7j5JoyYwDBPSlhoerpTrGpNoqOsoiXuXN
	 WErw40/OTZIIrM2Fm0s/4IfyNUe3MYe0On1TiIsRax3ec3YuDwh7s6ch1/FbBsQxfe
	 zW2VD3z49l8L6GpA7wWernxb4SDxsU4hLpiRMd3WjDlKckUbeuvmY7bOZdvYb7sL2V
	 +8czvVQGUILfyHsEZ/V3JyhMMclCnVWO2MdocI78aUNsAlOs+fPixghaN+2WKFkwyb
	 pGRCR682yGKlBB4lPUSBq37PHNFG2uW47H8lWEH8760pdAuCagHmeCrRbVfT0rwlUi
	 fdA2YNEHwg9KQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so811209466b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 09:57:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YxkzTq9y8M+L9dX86FPlBDfIkUwlAta7eyhesgHgs2tt0+/FiTN
	7sPZhKiAZMJJpXGs96zY2nWpEw+dkynK3yfEv2RN29M+IonXgPkJlbte52ElW9QxEFmh87VZ89W
	jQLCuL8WfQCJ9rsV06S7E2Zsdd+U=
X-Google-Smtp-Source: AGHT+IGsW4qA+Wfnteq7v28YWjXcfE6tdnjV5cWESNToTuhotH3ovSqpOVMwf1LoKckSZdbNw6Jn1SoGwjRgBgn0fYQ=
X-Received: by 2002:a17:907:e28f:b0:a8d:2ab2:c99e with SMTP id
 a640c23a62f3a-a9029730615mr2078976366b.55.1726592259434; Tue, 17 Sep 2024
 09:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726477365.git.wqu@suse.com> <dc5425aaed885ceb579ceb95d936c5fb0f5acd81.1726477365.git.wqu@suse.com>
In-Reply-To: <dc5425aaed885ceb579ceb95d936c5fb0f5acd81.1726477365.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Sep 2024 17:57:02 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5HRyzHh+vJFpAcGb7v8xkzy9-TMRPGC2BorHEk1y61cg@mail.gmail.com>
Message-ID: <CAL3q7H5HRyzHh+vJFpAcGb7v8xkzy9-TMRPGC2BorHEk1y61cg@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from CONFIG_BTRFS_DEBUG
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 10:06=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Currently CONFIG_BTRFS_EXPERIMENTAL is not only for the extra debugging
> output, but also for experimental features.
>
> This is not ideal to distinguish planned but not yet stable features
> from those purely designed for debug.
>
> This patch will split the following features into
> CONFIG_BTRFS_EXPERIMENTAL:
>
> - Extent map shrinker
>   This seems to be the first one to exit experimental.
>
> - Extent tree v2
>   This seems to be the last one to graduate from experimental.
>
> - Raid stripe tree
> - Csum offload mode
> - Send string v3

string -> stream

Also this change is breaking fstests btrfs/304 to 308 if
CONFIG_BTRFS_EXPERIMENTAL is not set.
That's because sysfs is still exposing the raid_stripe_tree and
extent_tree_v2 under a #ifdef CONFIG_BTRFS_DEBUG.

Thanks.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/Kconfig   | 9 +++++++++
>  fs/btrfs/bio.c     | 2 +-
>  fs/btrfs/fs.h      | 4 ++--
>  fs/btrfs/send.h    | 2 +-
>  fs/btrfs/super.c   | 6 +++---
>  fs/btrfs/sysfs.c   | 4 ++--
>  fs/btrfs/volumes.h | 4 ++--
>  7 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> index 4fb925e8c981..ead317f1eeb8 100644
> --- a/fs/btrfs/Kconfig
> +++ b/fs/btrfs/Kconfig
> @@ -78,6 +78,15 @@ config BTRFS_ASSERT
>
>           If unsure, say N.
>
> +config BTRFS_EXPERIMENTAL
> +       bool "Btrfs experimental features"
> +       depends on BTRFS_FS
> +       help
> +         Enable experimental features.  These features may not be stable=
 enough
> +         for end users.  This is meant for btrfs developers only.
> +
> +         If unsure, say N.
> +
>  config BTRFS_FS_REF_VERIFY
>         bool "Btrfs with the ref verify tool compiled in"
>         depends on BTRFS_FS
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index ce13416bc10f..056f8a171bba 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -605,7 +605,7 @@ static bool should_async_write(struct btrfs_bio *bbio=
)
>  {
>         bool auto_csum_mode =3D true;
>
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>         struct btrfs_fs_devices *fs_devices =3D bbio->fs_info->fs_devices=
;
>         enum btrfs_offload_csum_mode csum_mode =3D READ_ONCE(fs_devices->=
offload_csum_mode);
>
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index cbfb225858a5..785ec15c1b84 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -263,10 +263,10 @@ enum {
>          BTRFS_FEATURE_INCOMPAT_ZONED           |       \
>          BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA)
>
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>         /*
>          * Features under developmen like Extent tree v2 support is enabl=
ed
> -        * only under CONFIG_BTRFS_DEBUG.
> +        * only under CONFIG_BTRFS_EXPERIMENTAL
>          */
>  #define BTRFS_FEATURE_INCOMPAT_SUPP            \
>         (BTRFS_FEATURE_INCOMPAT_SUPP_STABLE |   \
> diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
> index b07f4aa66878..9309886c5ea1 100644
> --- a/fs/btrfs/send.h
> +++ b/fs/btrfs/send.h
> @@ -16,7 +16,7 @@ struct btrfs_ioctl_send_args;
>
>  #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
>  /* Conditional support for the upcoming protocol version. */
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>  #define BTRFS_SEND_STREAM_VERSION 3
>  #else
>  #define BTRFS_SEND_STREAM_VERSION 2
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 98fa0f382480..e8a5bf4af918 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2403,10 +2403,10 @@ static long btrfs_nr_cached_objects(struct super_=
block *sb, struct shrink_contro
>         trace_btrfs_extent_map_shrinker_count(fs_info, nr);
>
>         /*
> -        * Only report the real number for DEBUG builds, as there are rep=
orts of
> -        * serious performance degradation caused by too frequent shrinks=
.
> +        * Only report the real number for EXPERIMENTAL builds, as there =
are
> +        * reports of serious performance degradation caused by too frequ=
ent shrinks.
>          */
> -       if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
> +       if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL))
>                 return nr;
>         return 0;
>  }
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 03926ad467c9..b843308e2bc6 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1390,7 +1390,7 @@ static ssize_t btrfs_bg_reclaim_threshold_store(str=
uct kobject *kobj,
>  BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
>               btrfs_bg_reclaim_threshold_store);
>
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>  static ssize_t btrfs_offload_csum_show(struct kobject *kobj,
>                                        struct kobj_attribute *a, char *bu=
f)
>  {
> @@ -1450,7 +1450,7 @@ static const struct attribute *btrfs_attrs[] =3D {
>         BTRFS_ATTR_PTR(, bg_reclaim_threshold),
>         BTRFS_ATTR_PTR(, commit_stats),
>         BTRFS_ATTR_PTR(, temp_fsid),
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>         BTRFS_ATTR_PTR(, offload_csum),
>  #endif
>         NULL,
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 03d2d60afe0c..c207c94a4a5e 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -300,7 +300,7 @@ enum btrfs_read_policy {
>         BTRFS_NR_READ_POLICY,
>  };
>
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>  /*
>   * Checksum mode - offload it to workqueues or do it synchronously in
>   * btrfs_submit_chunk().
> @@ -424,7 +424,7 @@ struct btrfs_fs_devices {
>         /* Policy used to read the mirrored stripes. */
>         enum btrfs_read_policy read_policy;
>
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>         /* Checksum mode - offload it or do it synchronously. */
>         enum btrfs_offload_csum_mode offload_csum_mode;
>  #endif
> --
> 2.46.0
>
>

