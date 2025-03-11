Return-Path: <linux-btrfs+bounces-12185-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F173A5BF10
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 12:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF613175E03
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 11:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE908252913;
	Tue, 11 Mar 2025 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPtBhHVG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005422343C5
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692782; cv=none; b=TL4Mia3Z7YzeyUWIsl3iu/LBHANZz3Emi9TbHwPeqNT0kf3SPg0DypGSh+jTW0XgW/VW9CydgOvanmCwQ61EcUVx3HjAQgsO9FY+Id8Mv5RxqFWehiJZ+A5K9i/QYggnbPiugLjHEsDEZLDxXqPanq8SnW3BobTgVQM7lLVEV5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692782; c=relaxed/simple;
	bh=d7kMtjcuyWSTsRslqMghpiWivDlRDjgU4JgVCGCdwmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2fxZPnVsh9N5GVjMcI8XiTAFUffVYy8aOGbSGLUghihGKBohg352u9cX58JDhHRmixdeHU3XTSNWUDyKBClutKeFNek4fJUY0HpsQu50RdBgovscjqWtQBEQz/CY7M0KACY805P61dOe8dtKoNLAHB8dkzHv7HksXI63o/b+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPtBhHVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE16C4CEEE
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 11:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741692781;
	bh=d7kMtjcuyWSTsRslqMghpiWivDlRDjgU4JgVCGCdwmA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aPtBhHVG+u+QEVAXs7dy0+oOflr2d+8+TBp0p/dI7W7ASsxU60u3Bw5ptiNR3idUR
	 oRpxBxTj6AC1KHoQ/TRgzaoWLHo1sgZWQ/YzWNZ9FEVZgrEvV0aiOJGm1XBUHL+MgW
	 1fxyArT1PEmpGwY1EylaGswe/3yKg2KTWWNovQYoURNuTunoefMAuR8yKOJW2wUeej
	 8zuX+lcgnZ4//Dei+KvDb0lh8puAmrP73jUeGeBOoNA8gg/L4KIi/NNN++hrE2nW41
	 xTZ90WzNV9e2QTtayoaq0HC2ezI+xqscZnwXd7i5OC2NMmRVKADSnCApSka4505vyB
	 daYFK9T8AzK1g==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so220457366b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 04:33:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YzMF7CVTEEuVHCV4HIlvDC8E16VqRe/iRkhZV3nmQdgEOirETfj
	tVJPclPfuvJNutyVqJS1itZGHKzg70K4laNHqnUSVHnwSAc73+tJbkxsUj4RtGMdPQZKqqMmHgA
	Wf2CvzLquK1Wj2BNM/Zd8gXWefek=
X-Google-Smtp-Source: AGHT+IEcOxWWxoPUmatNF/gBLIjHy1GJ6iwd0fwpX66XKXr9vQPgiW55/+dgJhunkvnuLOvhpYMMcNjTxnzXoj7tbyQ=
X-Received: by 2002:a17:907:158a:b0:abf:fb78:673a with SMTP id
 a640c23a62f3a-ac2b9e1e390mr313399966b.29.1741692779804; Tue, 11 Mar 2025
 04:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c9858984b0807f758c8f1f5f64c1ec95c78930b2.1741662594.git.wqu@suse.com>
In-Reply-To: <c9858984b0807f758c8f1f5f64c1ec95c78930b2.1741662594.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 11 Mar 2025 11:32:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7w7QRmVC_LYwKTCCpGbfJkd-XjYv8jzd0jSFQ=2tJ=hw@mail.gmail.com>
X-Gm-Features: AQ5f1JpTP4QVHLVL4bvyqu6Nfg2RPFyokAacq29CR1IUl-w0ouZwJzB0nl9lLKs
Message-ID: <CAL3q7H7w7QRmVC_LYwKTCCpGbfJkd-XjYv8jzd0jSFQ=2tJ=hw@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: add extra warning if delayed iput is added when
 it's not allowed
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 3:10=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Since I have triggered the ASSERT() on the delayed iput too many times,
> now is the time to add some extra debug warnings for delayed iput.
>
> All delayed iputs should be queued after all ordered extents finish
> their IO and all involved workqueues are flushed.
>
> Thus after the btrfs_run_delayed_iputs() inside close_ctree(), there
> should be no more delayed puts added.
>
> So introduce a new BTRFS_FS_STATE_NO_DELAYED_IPUT, set after the above
> mentioned timing.
> And all btrfs_add_delayed_iput() will check that flag and give a
> WARN_ON_ONCE() for debug builds.
>
> And since we're here, remove the btrfs_run_delayed_iputs() call inside
> btrfs_error_commit_super().
> As that function will only wait for ordered extents to finish their IO,
> delayed iputs will only be added when those ordered extents all finished
> and removed from io tree, this is only ensured after the workqueue
> flush.

This last paragraph is no longer valid, as that part of the change was
moved to another patch.
Don't forget to delete it when committing to for-next.

Otherwise:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v3:
> - Rebased to the latest for-next
>   Which has the removal of btrfs_run_delayed_iputs() from
>   btrfs_error_commit_super() in the previous patch.
>
> - Make the WARN_ON_ONCE() unconditional in btrfs_add_delayed_iput()
>
> v2:
> - Set the new flag early
> - Make the new flag unconditional except the WARN_ON_ONCE() check
> - Remove the btrfs_run_delayed_iputs() inside btrfs_error_commit_super()
> ---
>  fs/btrfs/disk-io.c | 2 ++
>  fs/btrfs/fs.h      | 3 +++
>  fs/btrfs/inode.c   | 1 +
>  3 files changed, 6 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0afd3c0f2fab..56e55f7a0f24 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4397,6 +4397,8 @@ void __cold close_ctree(struct btrfs_fs_info *fs_in=
fo)
>         /* Ordered extents for free space inodes. */
>         btrfs_flush_workqueue(fs_info->endio_freespace_worker);
>         btrfs_run_delayed_iputs(fs_info);
> +       /* There should be no more workload to generate new delayed iputs=
. */
> +       set_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state);
>
>         cancel_work_sync(&fs_info->async_reclaim_work);
>         cancel_work_sync(&fs_info->async_data_reclaim_work);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index c799dfba5ebd..5a346d4a4b91 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -117,6 +117,9 @@ enum {
>         /* Indicates there was an error cleaning up a log tree. */
>         BTRFS_FS_STATE_LOG_CLEANUP_ERROR,
>
> +       /* No more delayed iput can be queued. */
> +       BTRFS_FS_STATE_NO_DELAYED_IPUT,
> +
>         BTRFS_FS_STATE_COUNT
>  };
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index e7e6accbaf6c..5c0a41c32dab 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3438,6 +3438,7 @@ void btrfs_add_delayed_iput(struct btrfs_inode *ino=
de)
>         if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1))
>                 return;
>
> +       WARN_ON_ONCE(test_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->f=
s_state));
>         atomic_inc(&fs_info->nr_delayed_iputs);
>         /*
>          * Need to be irq safe here because we can be called from either =
an irq
> --
> 2.48.1
>
>

