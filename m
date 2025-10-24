Return-Path: <linux-btrfs+bounces-18265-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A6EC04FCE
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 10:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0FA34F7B57
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 08:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD69C3019BD;
	Fri, 24 Oct 2025 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WovMKko5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8C3016EA
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293457; cv=none; b=UbhWB8V9ajVB8yqA5Jo1waf1pKusS+rTCxBP5tQ+cyCR+oXpKe544WXLXA49S6GR00RnmHGeCop+gAWCTgcR7TsKR4h1M3BRt5YStLS0op6xHD27va4SFo1inLpELf8DLWbt0JFJ3zofxZrmdgVCgyJaIyALItv5U8p/AvuLFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293457; c=relaxed/simple;
	bh=H6vcpfWsT9jOdGMVAd6E2A7Zv3njnxynCHfFnGjqBjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZI2vWWDdPwtMmHkdpQewyXxBeUJMF5NjI2DqPOo1b0Uo+o94JXKr5KpmtiLv2cKPuBNQ5QJcxL0ky3mouLSxjFqV+/rC4/+P2tOmizITsuvepjGANAuozz0UYR8Tw55bWyG6TIx9tsAaKatw1SxByBCzK8bDgt/mr+gOCmbtt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WovMKko5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE027C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 08:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761293456;
	bh=H6vcpfWsT9jOdGMVAd6E2A7Zv3njnxynCHfFnGjqBjU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WovMKko5rb8WFCDhBVK4WaFY5Ibl9H4VYUhYJkyqHgwPfzWdb80gLvMKtE53Fy4oo
	 yPFjjBrZJwywD0BkMQfr82HP6SFRnJsrmKY9pEq38bngjyKa42H+eKuUo6wE06g04k
	 9Lvlx6GmEhdM9AZOnvtrxDJmlAaYyv5rIBZ2tzgRdi97IenCGe4yCb03GjvP8Kg/FB
	 iSfswROo+zsBYTd3CYkiQEzNYahvkaGcGkafFeUN3sPQjGLVDpaW+CrCSCVemJSCbY
	 o9HJVOBfwctgm45BwtcQ7hRxSh9GJGLMffYhpILartIyfjmKXn3PHQv5/ydxPE9WG3
	 /0ST/Snq/twlw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so359772666b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 01:10:56 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyttp8Tl10SsAnFNKV/fb2nVp1zebd9BLIpQ0+3wQcm1p3kNYBN
	JPSAmJxvV+T4aAn6A7nvs7MJ8JwIv4g1l9RgGUCIAh9+e4zee06DcljqENmgEyGJuvZwkwPmveV
	SYAhrqw0jMp5vH8vPapZFPyQ1ybs4wOo=
X-Google-Smtp-Source: AGHT+IF5XuUd0/sW4aaPGxWUW3jmvEW65I9jlxu8ReiT1mf4Oy/9SI10wZuUsclY8KzzB6y0xGTcqIc+mOfDiNsApG8=
X-Received: by 2002:a17:907:5ce:b0:b2d:830a:8c0a with SMTP id
 a640c23a62f3a-b6d6ffac084mr147711666b.35.1761293455276; Fri, 24 Oct 2025
 01:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bfc7d8db794cc39fa2909c0b38a69f1a1ae73b81.1761262682.git.wqu@suse.com>
In-Reply-To: <bfc7d8db794cc39fa2909c0b38a69f1a1ae73b81.1761262682.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 24 Oct 2025 09:10:17 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4+asCJg91QDwChQ-WFugswD6Ygi1fO_jJ9br4TamqYOA@mail.gmail.com>
X-Gm-Features: AWmQ_bljeTl0OHOG_aVkaq3Smxi621keiVh4OpWEvRMtM9V7XsU2roWL7m-B3IA
Message-ID: <CAL3q7H4+asCJg91QDwChQ-WFugswD6Ygi1fO_jJ9br4TamqYOA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: ensure no dirty metadata is written back for an
 fs with errors
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 12:42=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
> But there are some metadata modifications before that error, and they are
> still in the btree inode page cache.
>
> Since there will be no real transaction commit, all those dirty folios
> are just kept as is in the page cache, and they can not be invalidated
> by invalidate_inode_pages2() call inside close_ctree(), because they are
> dirty.
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
> an error state, immediately mark the bbio as failure, instead of really
> submitting them.
>
> Then during close_ctree(), iput() will just discard all those dirty
> tree blocks without really writing them back, thus no more new jobs for
> already stopped-and-freed workqueues.
>
> The extra discard in write_one_eb() also acts as an extra safenet.
> E.g. the transaction abort is triggered by some extent/free space
> tree corruptions, and since extent/free space tree is already corrupted
> some tree blocks may be allocated where they shouldn't be (overwriting
> existing tree blocks). In that case writing them back will further
> corrupting the fs.
>
> CC: stable@vger.kernel.org #6.6

The correct syntax is:

stable@vger.kernel.org # 6.6+

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog
> v2:
> - Various grammar and newline fixes
>
> - A shorter title line
>
> - Enhance the [FIX] part, explain the full fix
>
> - Limit the backport for 6.6
>   v6.1 code base is very different compared to the current one, thus
>   backporting to v6.6 would be the limit.
>
> - Explain more why discarding bios at write_one_eb() is safer
>
> - Remove the extra flushing part inside close_ctree()
>   There is no difference flushing the dirty folios manually or by
>   iput(), as dirty folios are discarded anyway, no new job will be
>   created.
> ---
>  fs/btrfs/extent_io.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 870584dde575..8f6b8baba003 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2246,6 +2246,14 @@ static noinline_for_stack void write_one_eb(struct=
 extent_buffer *eb,
>                 wbc_account_cgroup_owner(wbc, folio, range_len);
>                 folio_unlock(folio);
>         }
> +       /*
> +        * If the fs is already in error status, do not submit any writeb=
ack
> +        * but immediately finish it.
> +        */
> +       if (unlikely(BTRFS_FS_ERROR(fs_info))) {
> +               btrfs_bio_end_io(bbio, errno_to_blk_status(-EROFS));

Btw, BTRFS_FS_ERROR() returns the error that has caused the
transaction to abort.
So instead of -EROFS we can pass BTRFS_FS_ERROR(fs_info).

In the end it doesn't make any difference since the error is not
returned to userspace.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +               return;
> +       }
>         btrfs_submit_bbio(bbio, 0);
>  }
>
> --
> 2.51.0
>
>

