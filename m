Return-Path: <linux-btrfs+bounces-15047-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37A6AEB7B8
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 14:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F623BDC86
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016F02D5417;
	Fri, 27 Jun 2025 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRovy+Du"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456682D3EE3
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751027447; cv=none; b=l8j1WXk0kfF6K/wT3hf+4+UhZD2f/VYxS6xMxIwyQQQQaMJ01XXBTn4xu6KUJuHkB8nyQWj2PsCUNDRZwpF1TKqCqwnSg0aL5Ngff+dCGmPYVqwDl4zWUG+Vfnfk4fvi2CQrL/rlzcOctdQBSwSrRMsWCaS7Mfmb4iUfhSSSCaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751027447; c=relaxed/simple;
	bh=PhTvP+nCs4IEW2ckAs2dQcG8nXWXBz1c1cDf93I0goA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9MPDp1bEsirgl8MLGFNWnnsIRxcqNtoJ5C6g5V5Og80r7u90yvh09wVTDHJFwZQEPGa7Xe2vUkTdu6+Rr6ri7L0N+lFqo/MkBErJbX31XiEvuLo4L/KO+UJHZLAd/i4Xfrz6RtZ7TJJRmrpnvHO8hCvVReeDO+Vlv+5bHZ/xSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRovy+Du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C0DC4CEED
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 12:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751027445;
	bh=PhTvP+nCs4IEW2ckAs2dQcG8nXWXBz1c1cDf93I0goA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BRovy+DuSLW2z30y2F5klZwF6icIauEzS9bmlyGrKgG0WnUQazzqyk60YFl/1oRxS
	 7SuruSj1aiJRRRgHh0bZ7OBbCiAGeP8+93llOJVMLASKaV1ylGLLzm/tETrRq0aATq
	 5Z7G6wPfI8mOiq4FVdeeW+PRjQv1A+5mTjIMO18m+E+x57kmou5y0CYxq41xOvLEM0
	 TIztWtrP3yY5cyS93Gf2vV8941iBFVqXTCLcY4VQ0A+qZV7h/imjEGL8WfQ218TdZp
	 tWbXsUQmjT9ZpEBDfUKRxB+wwhSagHJLEd8GfkHo8A01/5FxZmbU910sHvtFC4ytFM
	 A20BZPt4u0amQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso371356966b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 05:30:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YyRYXJDdzNsky2PfZk/yMQV6DPJtVZyEZGSXjaqQEaN/ONEJVS2
	IZ2qq5NsYIu4weTnMPSL1PzO1/LLDx//O326kEtBTSTVMh4+jK7exXy9REs+E9v1BYECtKCpg0W
	ley99/flwS3VzFUXeqZAeA9F21CvKzbE=
X-Google-Smtp-Source: AGHT+IEeXj7NINwI84jTdJqEzP6IwblZ4UkGPHkm7f4wAqo9dFFfCF8lEbMFwfdaliW3LUVZSs4kKBhEYDPOVxaGNxw=
X-Received: by 2002:a17:907:d29:b0:adb:3fb8:27f9 with SMTP id
 a640c23a62f3a-ae3504ce110mr238084866b.25.1751027444388; Fri, 27 Jun 2025
 05:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627091914.100715-1-jth@kernel.org> <20250627091914.100715-7-jth@kernel.org>
In-Reply-To: <20250627091914.100715-7-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 27 Jun 2025 13:30:07 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7wcAD4qZezupEj26D-s0tm7=YK+0YH8Z0L_yy0E2Mi4A@mail.gmail.com>
X-Gm-Features: Ac12FXzE8z5Kj7CGCiQau-R_Q4QuTXI6Bj41cLcITXZv52lrKe5nKIhLVTB8W9c
Message-ID: <CAL3q7H7wcAD4qZezupEj26D-s0tm7=YK+0YH8Z0L_yy0E2Mi4A@mail.gmail.com>
Subject: Re: [PATCH RFC 6/9] btrfs: remove btrfs_root's delalloc_mutex
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, David Sterba <dsterba@suse.com>, 
	Josef Bacik <josef@toxicpanda.com>, Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 10:23=E2=80=AFAM Johannes Thumshirn <jth@kernel.org=
> wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> When running metadata space reclaim under high I/O concurrency, we observ=
e
> hung tasks caused by lock contention on `btrfs_root::delalloc_mutex`. For
> example:
>
>   INFO: task kworker/u132:1:2177 blocked for more than 122 seconds.
>         Not tainted 6.16.0-rc3+ #1246
>   Workqueue: events_unbound btrfs_preempt_reclaim_metadata_space
>   Call Trace:
>     __schedule+0x2f9/0x7b0
>     schedule+0x27/0x80
>     __mutex_lock.constprop.0+0x4af/0x890
>     start_delalloc_inodes+0x6e/0x400
>     btrfs_start_delalloc_roots+0x162/0x270
>     shrink_delalloc+0x10c/0x2d0
>     flush_space+0x202/0x280
>     btrfs_preempt_reclaim_metadata_space+0xe7/0x340
>
> The `delalloc_mutex` serializes delalloc flushing per root but is no
> longer necessary. All critical paths (inode flushing, extent writing,
> metadata updates) are already synchronized using finer-grained locking at
> the inode, page, and tree levels. In particular, concurrent flushers
> coordinate via inode locking, and no shared state requires global
> serialization across the root.

Well that's not enough...
The mutex is there to ensure that if two (or more) tasks call
start_delalloc_inodes(), they only return after all IO is flushed and
ordered extents completed.
Without the mutex we break the semantics.

For example, after removing the mutex as you propose here, we have:

1) Task A enters start_delalloc_inodes() and takes the spinlock
root->delalloc_lock;

2) Task B also enters start_delalloc_inodes() and spins on
root->delalloc_lock because it's currently held by task A;

3) Task A extracts inode X from the local split list, grabs a
reference for it and unlocks root->delalloc_lock;

4) Task B takes the root->delalloc_lock and sees an empty
root->delalloc_inodes list, so it will never wait for all the
writeback and ordered extents from inode X to complete, and return
before they complete.

You see, inode locks, page locks, etc, don't even enter the equation
here and are irrelevant.


>
> Removing this mutex avoids unnecessary blocking in reclaim paths and
> improves responsiveness under pressure, especially on systems with many
> flushers or multi-queue SSDs/ZNS devices.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Duplicated SoB tags.

Thanks.

> ---
>  fs/btrfs/ctree.h   | 1 -
>  fs/btrfs/disk-io.c | 1 -
>  fs/btrfs/inode.c   | 2 --
>  3 files changed, 4 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 8a54a0b6e502..06c7742a5de0 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -238,7 +238,6 @@ struct btrfs_root {
>         spinlock_t root_item_lock;
>         refcount_t refs;
>
> -       struct mutex delalloc_mutex;
>         spinlock_t delalloc_lock;
>         /*
>          * all of the inodes that have delalloc bytes.  It is possible fo=
r
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 929f39886b0e..e39f5e893312 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -678,7 +678,6 @@ static struct btrfs_root *btrfs_alloc_root(struct btr=
fs_fs_info *fs_info,
>         mutex_init(&root->objectid_mutex);
>         mutex_init(&root->log_mutex);
>         mutex_init(&root->ordered_extent_mutex);
> -       mutex_init(&root->delalloc_mutex);
>         init_waitqueue_head(&root->qgroup_flush_wait);
>         init_waitqueue_head(&root->log_writer_wait);
>         init_waitqueue_head(&root->log_commit_wait[0]);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d68f4ef61c43..b9c52b9ea912 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8673,7 +8673,6 @@ static int start_delalloc_inodes(struct btrfs_root =
*root,
>         int ret =3D 0;
>         bool full_flush =3D wbc->nr_to_write =3D=3D LONG_MAX;
>
> -       mutex_lock(&root->delalloc_mutex);
>         spin_lock(&root->delalloc_lock);
>         list_splice_init(&root->delalloc_inodes, &splice);
>         while (!list_empty(&splice)) {
> @@ -8730,7 +8729,6 @@ static int start_delalloc_inodes(struct btrfs_root =
*root,
>                 list_splice_tail(&splice, &root->delalloc_inodes);
>                 spin_unlock(&root->delalloc_lock);
>         }
> -       mutex_unlock(&root->delalloc_mutex);
>         return ret;
>  }
>
> --
> 2.49.0
>
>

