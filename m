Return-Path: <linux-btrfs+bounces-12084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3495A566E0
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 12:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF1B7A52E2
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B59216E30;
	Fri,  7 Mar 2025 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/14A76s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A5A20764E
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347407; cv=none; b=XlKT5ymNWKYbZFIOmPTGdvBNo5WHidRuek4tfpRA6nYi6Zp+S1mtaV2BoXsOlj7peQTmwDOp4ZIRrJy72s4vkiOjl/JIKgE8nyGF4AuFGWYsj8ynszEtHrpUdI1En0/KPRJEKgVDJQC4IP5REaoBGi7LSzWflPDeSMlTna0+MP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347407; c=relaxed/simple;
	bh=ez8gz0nbwmK2sBjrgn36Qet0e3/X3TWdEZmqqfSyvOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ff6sWrQy4zxS24EZiNis/5rlcy+CgOB9gMVh8eoTjF3F8O0+tTzM0i3b0++WaVooSGub234b9c+Y+Fl/D6OAnx4YfWYKvGO4d1pLu55gWMw68LP3JLIGZ9faEHrxEa0VP9PikSH2f1l7OVleLZ8/meXMQx9mKnWX5WPADU36C2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/14A76s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D29CC4CED1
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 11:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347405;
	bh=ez8gz0nbwmK2sBjrgn36Qet0e3/X3TWdEZmqqfSyvOk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l/14A76sXLpPIurx6hF+iAxVGJl1EdVaOHxJHUR/pYl+eju3mcSSH7mbVw58E2AY4
	 GAV38IWL4S8EEhY0lPbBnJ+xywfa9iZd0NkPtoaUC+EZR8ytzP5Y3PIKVcUmJGGMMj
	 Eab25NTfuRxVXQEtUtP7+44PXZU7xLcxVqT1uNTkCaYWtCXnkF/qVMTc9LIwWq3e+E
	 3Ib7ZaMnxw4kDgayas7wlvOia+4k3w7Cwy7HJwfsGUPESDe6vvkgEVe0VbtSI6Zggb
	 fkEX0aPlGAXQccytOGTiT3hiZ1E3ZBwVnFaqtX6PE4063ET5ifv2UDlCzMj4mHufKk
	 9ysVhVgmJx0ng==
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390ec449556so2052530f8f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Mar 2025 03:36:45 -0800 (PST)
X-Gm-Message-State: AOJu0YxhtaivmhO3Z7Pw+wn66EWI5cyhetwzpE/AXxNaWWWy3v1CY+uj
	HuxBZveMw59ANYR3JyysqLGsLglaB8jybX1XYOMJhwaorY/1vZIBXDWUl8ENwWUS5sHuyol0o28
	fMmk7v5hfLpQNBzVmjBSwNP4AsMI=
X-Google-Smtp-Source: AGHT+IG+0sR/SMqb+jR6bdG0o3LUYpsN3IrZOfDHAm68aftXclEH96l93cJZA2bYF8te/ga68XLc6OJf1aZ4sIGcqLQ=
X-Received: by 2002:a5d:6dae:0:b0:38c:3f12:64be with SMTP id
 ffacd0b85a97d-39132da229cmr2619631f8f.35.1741347403946; Fri, 07 Mar 2025
 03:36:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741321288.git.wqu@suse.com> <1065439fbc1fc7aa0db509344c91e37467a717fe.1741321288.git.wqu@suse.com>
In-Reply-To: <1065439fbc1fc7aa0db509344c91e37467a717fe.1741321288.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 7 Mar 2025 11:36:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H58uM_zruchZ5mJoF6KD-wT_ankVRpjp3HMVrC1x=ou3Q@mail.gmail.com>
X-Gm-Features: AQ5f1JotTLt4tuJrC0JW6clB3l4Cw9K6v_FM7BWGILEMrSTtlLwsnAaqtoOqQes
Message-ID: <CAL3q7H58uM_zruchZ5mJoF6KD-wT_ankVRpjp3HMVrC1x=ou3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: run btrfs_error_commit_super() early
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 4:27=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Even after all the error fixes related the
> "ASSERT(list_empty(&fs_info->delayed_iputs));" in close_ctree(), I can
> still hit it reliably with my experimental 2K block size.
>
> [CAUSE]
> In my case, all the error is triggered after the fs is already in error
> status.
>
> I find the following call trace to be the cause of race:
>
>            Main thread                 |     endio_write_workers
> ---------------------------------------+------------------------
> close_ctree()                          |
> |- btrfs_error_commit_super()          |
> |  |- btrfs_cleanup_tranasction()      |

btrfs_cleanup_tranasction() ->btrfs_cleanup_transaction()

> |  |  |- btrfs_wait_ordered_roots()    |

It took me a bit to see where this call came from, which is from
btrfs_destroy_all_ordered_extents() which is called by
btrfs_cleanup_transaction().
Could be added here.

> |  |- btrfs_run_delayed_iputs()        |
> |                                      | btrfs_finish_ordered_io()
> |                                      | |- btrfs_put_ordered_extent()
> |                                      |    |- btrfs_add_delayed_iput()
> |- ASSERT(list_empty(delayed_iputs))   |
>    !!! Triggered !!!
>
> The root cause is that, btrfs_wait_ordered_roots() only wait for
> ordered extents to finish their IOs, not to wait for them to finish and
> removed.
>
> [FIX]
> Since btrfs_error_commit_super() will flush and wait for all ordered
> extents, it should be executed early, before we start flushing the
> workqueues.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b0f125d8efa0..320136a59db2 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4320,6 +4320,14 @@ void __cold close_ctree(struct btrfs_fs_info *fs_i=
nfo)
>         /* clear out the rbtree of defraggable inodes */
>         btrfs_cleanup_defrag_inodes(fs_info);
>
> +       /*
> +        * Handle the error fs first, as it will flush and wait for
> +        * all ordred extents.

ordred -> ordered

Those can be fixed when pushing to for-next.

Looks good:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +        * This will generate delayed iputs, thus we want to handle it fi=
rst.
> +        */
> +       if (unlikely(BTRFS_FS_ERROR(fs_info)))
> +               btrfs_error_commit_super(fs_info);
> +
>         /*
>          * Wait for any fixup workers to complete.
>          * If we don't wait for them here and they are still running by t=
he time
> @@ -4410,9 +4418,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_in=
fo)
>                         btrfs_err(fs_info, "commit super ret %d", ret);
>         }
>
> -       if (BTRFS_FS_ERROR(fs_info))
> -               btrfs_error_commit_super(fs_info);
> -
>         kthread_stop(fs_info->transaction_kthread);
>         kthread_stop(fs_info->cleaner_kthread);
>
> --
> 2.48.1
>

