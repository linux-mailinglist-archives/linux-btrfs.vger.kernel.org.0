Return-Path: <linux-btrfs+bounces-18185-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95478C02224
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 17:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7313AB881
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 15:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5752338F43;
	Thu, 23 Oct 2025 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2VT8Rhw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D3E222564
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233251; cv=none; b=QFZ00IuTo2A89cAmGV16NYK9HZx/89asMyARZwmxXB95d0DR3E5dQporAVYrYDQ1xrIrg9Pa0hNJhAS99k2sTAenmBug1lLaXYRvgEGBHfLF8XhFHoolrdM4C0bKIpcg1IdmIcRNviXu1+9MxduXLJfWqBvd64CePavCZR9vg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233251; c=relaxed/simple;
	bh=5cOE1QRO3P8uX3TVstNdQ2oWnMyWJPbmMi6pJmtsWvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsI+KBL2eAiLnKTZLPAZ+a4kUtERh2IjWVObiiXJvQce2MXayzF3+eDpviKfINQ6yyy8RcGR/6OhD8f8mkcMTRd1ujzCIUhXuW7o8nY1dYMCsxBBIUHykuxsjom5xLKIAYodPJNCLAhqFU0Z+RrpoBRbcQrbwUPtlZGi5syK2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2VT8Rhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C880FC4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761233250;
	bh=5cOE1QRO3P8uX3TVstNdQ2oWnMyWJPbmMi6pJmtsWvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A2VT8RhwDYGm32OsFaRilh7yH+/uA0VD01p/9abKzTJOMVfLGe/12aYrQdPvBfqCa
	 l42ZtQ0gO7C/DkCjko4PEW38u+8WdAZMBM39B4DCg42MxE+rMYXlXsCfQB1Ewyn8bB
	 S988XiW6GHQUx3tAmQ1fzKAtH187kWwu8g7vCk00yFB3Stx5YaZLUQid1MQWjhd/mM
	 WrEzugMklukAf1jwVN9OlEgo0p56yAEFzwjR3YwHX9bkBLE05TjiKUwKp9Bm76SObv
	 4CM63EAIq5VH9No7bxybkWArHx/UkK0U1Oaj9PBnHwyxXAt6Df475wLE+2M112hxye
	 V3malbOeK0ACQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b5a8184144dso158788166b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 08:27:30 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy0Umz80lx2opMvdMlrzdjI0oGJUR2pKYXxy3hZaEqrNDkRHmK5
	5Yy9OVKAWcMhjyQj5vnhUf13/y0SFlYPAWu7wIyMw7l4pz+O0yIjZMVjdexxWx9O3UwiUCAEEzv
	YZWzsEGerb8eEFJZQ2QTfkRjxpH/xldw=
X-Google-Smtp-Source: AGHT+IGJvyxw/zoyMvO9m7LuqUkB0Ic3ETG0kQe23JibZWFvRKlI4PVocM0HgI8ZVCE47dnyHOVYaqTlSmmyse+uS9s=
X-Received: by 2002:a17:907:9447:b0:b3f:ccac:af47 with SMTP id
 a640c23a62f3a-b6475e09b90mr2999766366b.31.1761233249376; Thu, 23 Oct 2025
 08:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2059d92d64eb181f1d37538d1279ed5b191ce1ab.1761211916.git.wqu@suse.com>
In-Reply-To: <2059d92d64eb181f1d37538d1279ed5b191ce1ab.1761211916.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 23 Oct 2025 16:26:52 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7KmObsE2JURpKLVRT_ufa_2v4M2KAFahUndq5Jqxwnow@mail.gmail.com>
X-Gm-Features: AS18NWAUZhpIRtGgf51Wv3VgNnV3-KVKNMAOHfuMrojw2vn7r2Rw1A-tmi2_iFA
Message-ID: <CAL3q7H7KmObsE2JURpKLVRT_ufa_2v4M2KAFahUndq5Jqxwnow@mail.gmail.com>
Subject: Re: [PATCH] btrfs: make sure no dirty metadata write is submitted
 after btrfs_stop_all_workers()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 10:33=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> During development of a minor feature (make sure all btrfs_bio::end_io()
> is called in task context), I noticed a crash in generic/388, where
> metadata writes triggered new works after btrfs_stop_all_workers().
>
> It turns out that it can even happen without any code modification, just
> using RAID5 for metadata and the same workload from generic/388 is going
> to trigger the use-after-free.
>
> [CAUSE]
> If btrfs hits an error, the fs is marked as error, no new
> transaction is allowed thus metadata is in a frozen state.
>
> But there are some metadata modification before that error, and they are

modification -> modifications

> still in the btree inode page cache.
>
> Since there will be no real transaction commitment, all those dirty

commitment -> commit

> folios are just kept as is in the page cache, and they can not be
> invalidated by invalidate_inode_pages2() call inside close_ctree(),
> because they are dirty.
>
> And finally after btrfs_stop_all_workers(), we call iput() on btree
> inode, which triggers writeback of those dirty metadata.
>
> And if the fs is using RAID56 metadata, this will trigger RMW and queue
> new works into rmw_workers, which is already stopped, causing warning
> from queue_work() and use-after-free.
>
> [FIX]
> Add a special handling for write_one_eb(), that if the fs is already in
> an error state immediately mark the bbio as failure, instead of really
> submitting them into the device.

Ok, so you are describing half of the fix here, but no motion of the
flushing done in close_ctree().

>
> This means for test case like generic/388, at iput() those dirty folios
> will just be discarded without triggering IO.
>
> CC: stable@vger.kernel.org

Can we get a minimum version here or a Fixes tag?

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c   | 12 ++++++++++++
>  fs/btrfs/extent_io.c | 11 +++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0aa7e5d1b05f..8b0fc2df85f1 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4402,11 +4402,23 @@ void __cold close_ctree(struct btrfs_fs_info *fs_=
info)
>
>         btrfs_put_block_group_cache(fs_info);
>
> +       /*
> +        * If the fs is already in trans aborted case, also trigger write=
back of all
> +        * dirty metadata folios.
> +        * Those folios will not reach disk but dicarded directly.

dicarded -> discarded

> +        * This is to make sure no dirty folios before iput(), or iput() =
will
> +        * trigger writeback again, and may even cause extra works queued
> +        * into workqueue.

A bit convoluted and confusing.
How about:

"This is to make sure the final iput on the btree inode, done after
stopping and freeing all workqueues, does not trigger writeback of
dirty extent buffers and attempt to queue jobs, which would result in
a use-after-free against a workqueue."

> +        */
> +       if (unlikely(BTRFS_FS_ERROR(fs_info)))
> +               filemap_write_and_wait(fs_info->btree_inode->i_mapping);

So two suggestions:

1) Move this into btrfs_error_commit_super(), to have all code related
to fs in error state in one single place.

2) Instead of of calling filemap_write_and_wait(), make this simpler
by doing the iput() of the btree inode right before calling
btrfs_stop_all_workers() and removing the call to
invalidate_inode_pages2() which is irrelevant since the final iput()
removes everything from the page cache except dirty pages (but the
iput() already triggered writeback of them).

In fact for this scenario the call to invalidate_inode_pages2() must
be returning -EBUSY due to the dirty pages, but we have always ignored
its return value.

From a quick glance, it seems to me that suggestion 2 should work.

> +
>         /*
>          * we must make sure there is not any read request to
>          * submit after we stopping all workers.
>          */
>         invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
> +

Stray new line here.

>         btrfs_stop_all_workers(fs_info);
>
>         /* We shouldn't have any transaction open at this point */
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 870584dde575..a8a53409bb3f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2246,6 +2246,17 @@ static noinline_for_stack void write_one_eb(struct=
 extent_buffer *eb,
>                 wbc_account_cgroup_owner(wbc, folio, range_len);
>                 folio_unlock(folio);
>         }
> +       /*
> +        * If the fs is already in error status, do not submit any writeb=
ack
> +        * but immediately finish it.
> +        * This is to avoid iput() triggering dirty folio writeback for
> +        * transaction aborted fses, which can cause extra works into
> +        * already stopped workqueues.

Confusing as before.
Better say it's to avoid use-after-tree on the workqueues triggered by
the final iput() of the btree inode, which happens after stopping and
freeing all workqueues.

The subject is also kind of too long. Something much shorter which
says the same:

"btrfs: ensure no dirty metadata before stopping work queues during unmount=
"

Thanks.

> +        */
> +       if (unlikely(BTRFS_FS_ERROR(fs_info))) {
> +               btrfs_bio_end_io(bbio, errno_to_blk_status(-EROFS));
> +               return;
> +       }
>         btrfs_submit_bbio(bbio, 0);
>  }
>
> --
> 2.51.0
>
>

