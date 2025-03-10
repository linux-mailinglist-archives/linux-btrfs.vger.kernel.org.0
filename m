Return-Path: <linux-btrfs+bounces-12133-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA91A59177
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 11:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0414F16B25B
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 10:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739C0226CEE;
	Mon, 10 Mar 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdhiFyay"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E016D9C2
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603403; cv=none; b=LmXu5XpyZwfl4zGG2JK9XA0s0hPOQQ8oclKNGM4gpzMrhXiGdWb6ijtl5eoXLwjk550qMujZLocNYpqM0lWA3MLH/nA9FnZ60+HXUf0HhBMkArfBynTgEkwijQ7ZZOC8dclJDFhU3zlwNDLCfihY3sI92w4x6rFX6RW9qdKzgqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603403; c=relaxed/simple;
	bh=QQltBeYxV5lLcjQ0q2sjLoGMcNGlKw6LKfUFvWiMr8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlpfDQIepRmfizZ9u5t7sPbR98TMrFk1oZE375An/BzE//WMbeBTPbhkkyVL9FzvOhXG1bGMya7RsOkxUPCYFCuQZR7a/mnqxZAGS210nql1QRdO02rHkUJXzV6qND5Xd9nEEcV8x+T+Z6qPVGsiHK7scCDYmLtNViABJgLNcB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdhiFyay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F478C4CEE5
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 10:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741603403;
	bh=QQltBeYxV5lLcjQ0q2sjLoGMcNGlKw6LKfUFvWiMr8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jdhiFyay/qO9dJJBCSUlleZlHMDfXAWPQRdr20J8iZaEn8mc6l3FwXNkweBrbzTEQ
	 yjyGt3mZPIxEhG1FhQV1oYDYsEWHcM10NmBedt5bZc80fRGeib6AWOthz884V1ESiR
	 iEzlXc4r+TzmHQiWJpa21tQj9MIsDBmJC0X3Li1wggOW/iYtT9UyGWj3uJ5+fNXUjW
	 fbcisG0vtRpg7jfPqk32WjQq2s0AiY4js7Ha+/4E+74/eL+94pnbsw3KT3+Tj+PQpF
	 y80i9SkAYxQ1LIHk/A5P9uOkghd621DDWE8RQf4D8gWFpxcHpvw1T1uUzBwdMwGq77
	 wxqP798sSBuqA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so2273464a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 03:43:23 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy0IzbiAX4abHziQDCzRejg51LIMxAShwgpykJkd9A08Ifj7Bew
	RFWD4/jCGorSSwb4W5UdQRpYoxuKhHBHpijR9cC2EGjegCfaRwPYWDN0Sgy35AW5DLfXMlfFjea
	dvJUcpJRwVXWV+TOBxEzvbNSvj/0=
X-Google-Smtp-Source: AGHT+IEvERsdZ8lTAt4QLbsXkzFqwhqSIO9FV8QrFDzX94kLVu+yZ8hRtbMIZnpGtpV2VPSPEsrYxJQNh0GlNQB5G9Q=
X-Received: by 2002:a05:6402:1ed2:b0:5dc:74fd:abf1 with SMTP id
 4fb4d7f45d1cf-5e5e22d523amr38832763a12.15.1741603401764; Mon, 10 Mar 2025
 03:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <65dce6b59ca3aa2bcd2e492271dcc3faa6f0a9ad.1741583506.git.wqu@suse.com>
In-Reply-To: <65dce6b59ca3aa2bcd2e492271dcc3faa6f0a9ad.1741583506.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 10 Mar 2025 10:42:44 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7jU5TKHxmo9QQbSxz+BnTvO1PXZzgy3xY-3txhhjFA+A@mail.gmail.com>
X-Gm-Features: AQ5f1JqogPSdbEQVG9qKajQZ76nyYMUidWHVas_wG2OkERsYPGtIoCmgVGr4SgI
Message-ID: <CAL3q7H7jU5TKHxmo9QQbSxz+BnTvO1PXZzgy3xY-3txhhjFA+A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add extra warning if delayed iput is added when
 it's not allowed
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 5:15=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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

This is a bad idea to make such unrelated change in the same patch.
After all this one is about adding a warning and making things easier
to catch.

It should either go as a separate patch or it fits much better in the
previous patch ("btrfs: run btrfs_error_commit_super() early").


> As that function will only wait for ordered extents to finish their IO,
> delayed iputs will only be added when those ordered extents all finished
> and removed from io tree, this is only ensured after the workqueue

It's not "io tree", that's used for extent locking, setting delalloc
ranges, etc.
You mean the ordered extents tree in the inode (struct
btrfs_inode::ordered_tree).

> flush.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Set the new flag early
> - Make the new flag unconditional except the WARN_ON_ONCE() check
> - Remove the btrfs_run_delayed_iputs() inside btrfs_error_commit_super()
> ---
>  fs/btrfs/disk-io.c | 6 ++----
>  fs/btrfs/fs.h      | 3 +++
>  fs/btrfs/inode.c   | 4 ++++
>  3 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 671f11787f34..466d9c434030 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4384,6 +4384,8 @@ void __cold close_ctree(struct btrfs_fs_info *fs_in=
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
> @@ -4540,10 +4542,6 @@ static void btrfs_error_commit_super(struct btrfs_=
fs_info *fs_info)
>         /* cleanup FS via transaction */
>         btrfs_cleanup_transaction(fs_info);
>
> -       mutex_lock(&fs_info->cleaner_mutex);
> -       btrfs_run_delayed_iputs(fs_info);
> -       mutex_unlock(&fs_info->cleaner_mutex);
> -
>         down_write(&fs_info->cleanup_work_sem);
>         up_write(&fs_info->cleanup_work_sem);
>  }
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index b8c2e59ffc43..3a9e0a4c54e5 100644
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
> index 8ac4858b70e7..d2bf81c08f13 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3435,6 +3435,10 @@ void btrfs_add_delayed_iput(struct btrfs_inode *in=
ode)
>         if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1))
>                 return;
>
> +#ifdef CONFIG_BTRFS_DEBUG
> +       WARN_ON_ONCE(test_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->f=
s_state));
> +#endif

As commented before, I would not add this under CONFIG_BTRFS_DEBUG,
just leave it there to always run.
Like that it'll be much faster to discover issues, as users typically
don't run a kernel with CONFIG_BTRFS_DEBUG.

Thanks.


> +
>         atomic_inc(&fs_info->nr_delayed_iputs);
>         /*
>          * Need to be irq safe here because we can be called from either =
an irq
> --
> 2.48.1
>
>

