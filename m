Return-Path: <linux-btrfs+bounces-18464-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7282C2453C
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 11:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16E318973F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 09:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D3A333458;
	Fri, 31 Oct 2025 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn72hDdi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C234D3B5
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904732; cv=none; b=HYjeB7EnZp83vAWlc5zeYyvosMqbQ6GkhpBgh2fIl1kvYZA62m/gxRk3n9LKSzelqU7P8KZaCByCyRgbYd5aI+zjrmMnIiz6B9TythIeHOIwxilrnC0klSIOAL2/WMY/Daaq+SKhhHKVs4i16Uclvt5TRNJbdma5z4mmYHABZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904732; c=relaxed/simple;
	bh=mkYlBNFGjjNc3C0HRhegUDPIVU79wGXf+vW+blz/nWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcfdtQWvkx70C0SeoNS8xYVBjV3P7t7BKyqUZAgdT5BkVt9GtS3TURyzbPMD7BjtHE66uPgzdMF/B6dd6EOThiHtKdUO0N2PNwoAQBBstOEVL6LNElgvyncypwwJeTwmGArMz5CyBFFwx4QFp5t1MhCRm9RBM2RLRAgPmNgZBHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rn72hDdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDD8C4CEE7
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 09:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761904731;
	bh=mkYlBNFGjjNc3C0HRhegUDPIVU79wGXf+vW+blz/nWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rn72hDdiYukv8jb3sRUauCATJD5zZck3CMc821Cm0FA0cwdTguEjtKEBq0zQxxFmp
	 WffqVRnennTM4oqJSe0esFfsSJw24k83C7WuSx6BfzKFiIeOHo29nsvfIL8qdvFX2u
	 6UPU8OjYKQoy6Od7RtfxGOfrKxN84T9JiZMz3C73ZeOYiPkQxnCZKcjP/ywrQFEXrt
	 SPlkB1I1bf9U4DF+XVdXaJWiMCzc+pHCI0V9kZjjhEE4jbJSFL0Xpbu4DzOX9/SGfy
	 6m2hSNKzMUgtWo+mGxndUF3b5zWrf4HI709nxCXJYIutzr+6cikulsrQhCRXlHhQAH
	 AAtZTjcVgDLBw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b704db3686cso461250866b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 02:58:50 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywdgx14UWnHSbY1HHAXE4wWQ4OnYZXUt0MP9SHh1P5GMhVO3EEL
	U/lqsABSs96dHu4/f9H9HDofnLR1XtZIBtfQWXk9ZWqYQ5iBkoUuPFRL0sGTwNHE9MqQWOHZ/1Q
	gtDUC0NEUwjMhhs23iTMCQTFWd17dIYA=
X-Google-Smtp-Source: AGHT+IHQCAqUq5yU/I8szFNTq++1v3jGGSp2zhftDy7BZklSMEs6FiLfycK7Sf8yUBFCFgS3a6oWschbRB8fsGU3kAQ=
X-Received: by 2002:a17:907:3da7:b0:b6d:4034:8d11 with SMTP id
 a640c23a62f3a-b70708a07ccmr295576066b.62.1761904729581; Fri, 31 Oct 2025
 02:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fe6582f4535be27e11a6125f89265ebe8c82aac6.1761867805.git.wqu@suse.com>
In-Reply-To: <fe6582f4535be27e11a6125f89265ebe8c82aac6.1761867805.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 31 Oct 2025 09:58:12 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7+UKqz5JDcLBQ+sJH-A40MR5_3M+GhskQ1Zw1+OJftxA@mail.gmail.com>
X-Gm-Features: AWmQ_bmDpdriAH2HwIPNAKj6Al-MFjVgCKCywTaVEss5RHGdJ9EiOROPRXijGhg
Message-ID: <CAL3q7H7+UKqz5JDcLBQ+sJH-A40MR5_3M+GhskQ1Zw1+OJftxA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fallback to buffered IO if the data profile has duplication
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 11:48=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BACKGROUND]
> Inspired by a recent kernel bug report, which is related to direct IO
> buffer modification during writeback, that leads to contents mismatch of
> different RAID1 mirrors.
>
> [CAUSE AND PROBLEMS]
> The root cause is exactly the same explained in commit 968f19c5b1b7
> ("btrfs: always fallback to buffered write if the inode requires
> checksum"), that we can not trust direct IO buffer which can be modified
> halfway during writeback.
>
> Unlike data checksum verification, if this happened on inodes without
> data checksum but has the data has extra mirrors, it will lead to
> stealth data mismatch on different mirrors.
>
> This will be way harder to detect without data checksum.
>
> Furthermore for RAID56, we can even have data without checksum and data
> with checksum mixed inside the same full stripe.
>
> In that case if the direct IO buffer got changed halfway for the
> nodatasum part, the data with checksum immediately lost its ability to
> recover, e.g.:
>
> " " =3D Good old data or parity calculated using good old data
> "X" =3D Data modified during writeback
>
>               0                32K                      64K
>   Data 1      |                                         |  Has csum
>   Data 2      |XXXXXXXXXXXXXXXX                         |  No csum
>   Parity      |                                         |
>
> In above case, the parity is calculated using data 1 (has csum, from
> page cache, won't change during writeback), and old data 2 (has no csum,
> direct IO write).
>
> After parity is calculated, but before submission to the storage, direct
> IO buffer of data 2 is modified, causing the range [0, 32K) of data 2
> has a different content.
>
> Now all data is submitted to the storage, and the fs got fully synced.
>
> Then the device of data 1 is lost, has to be rebuilt from data 2 and
> parity. But since the data 2 has some modified data, and the parity is
> calculated using old data, the recovered data is no the same for data 1,
> causing data checksum mismatch.
>
> [FIX]
> Fix this problem by introduce a new helper,

introduce -> introducing

> btrfs_has_data_duplication(), to check if there is any data profiles

is any -> are any

> that have any duplication. If so fallback to buffered IO to keep data
> consistent, no matter if the inode has data checksum or not.
>
> However this is not going to fix all situations, as it's still possible
> to race with balance where the fs got a new data profile after
> btrfs_has_data_duplication() check.
> But this fix should still greatly reduce the window of the original bug.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D99171
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/direct-io.c  |  9 +++++++++
>  fs/btrfs/space-info.c | 18 ++++++++++++++++++
>  fs/btrfs/space-info.h |  1 +
>  3 files changed, 28 insertions(+)
>
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index 962fccceffd6..3165543f35bc 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -12,6 +12,7 @@
>  #include "volumes.h"
>  #include "bio.h"
>  #include "ordered-data.h"
> +#include "space-info.h"
>
>  struct btrfs_dio_data {
>         ssize_t submitted;
> @@ -827,6 +828,14 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struc=
t iov_iter *from)
>         if (iocb->ki_pos + iov_iter_count(from) <=3D i_size_read(inode) &=
& IS_NOSEC(inode))
>                 ilock_flags |=3D BTRFS_ILOCK_SHARED;
>
> +       /*
> +        * If our data profile has duplication (either extra mirrors or R=
AID56),
> +        * we can not trust the direct IO buffer, the content may change =
during
> +        * writeback and cause different contents written to different mi=
rrors.
> +        */
> +       if (btrfs_has_data_duplication(fs_info))
> +               goto buffered;
> +
>  relock:
>         ret =3D btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
>         if (ret < 0)
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 63d14b5dfc6c..02b5ebdd3146 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -2203,3 +2203,21 @@ void btrfs_return_free_space(struct btrfs_space_in=
fo *space_info, u64 len)
>         if (len)
>                 btrfs_try_granting_tickets(space_info);
>  }
> +
> +bool btrfs_has_data_duplication(struct btrfs_fs_info *fs_info)
> +{
> +       struct btrfs_space_info *sinfo =3D fs_info->data_sinfo;
> +       bool ret =3D false;
> +
> +       down_write(&sinfo->groups_sem);
> +       for (int i =3D 0; i < BTRFS_NR_RAID_TYPES; i++) {
> +               if (!list_empty(&sinfo->block_groups[i]) &&
> +                   (btrfs_raid_array[i].ncopies > 1 ||
> +                    btrfs_raid_array[i].nparity !=3D 0)) {
> +                       ret =3D true;
> +                       break;
> +               }
> +       }
> +       up_write(&sinfo->groups_sem);

This is huge and rather heavy.
Taking the lock in write mode will block with concurrent extent
allocations which take it in read mode.

We could lock in read mode instead, but this can be much simpler by doing t=
his:

return (btrfs_data_alloc_profile(fs_info) &
BTRFS_BLOCK_GROUP_PROFILE_MASK) !=3D 0;

Thanks.



> +       return ret;
> +}
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index a4c2a3c8b388..15b96163a167 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -315,5 +315,6 @@ void btrfs_set_periodic_reclaim_ready(struct btrfs_sp=
ace_info *space_info, bool
>  int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_in=
fo);
>  void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
>  void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 le=
n);
> +bool btrfs_has_data_duplication(struct btrfs_fs_info *fs_info);
>
>  #endif /* BTRFS_SPACE_INFO_H */
> --
> 2.51.2
>
>

