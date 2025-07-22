Return-Path: <linux-btrfs+bounces-15628-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DA3B0D6E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 12:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D348A7B5205
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 10:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182412E3AF6;
	Tue, 22 Jul 2025 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0Bo0gLs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1D9289808
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178694; cv=none; b=s/6Y0oJDSJxt/MHdK8eP7NpDa5uBkfWlqhi7nmj1XwnzimXLmoztXJv6RlrFQuYE3Ta1UIzlfrg03Pb/VuUHtD30cs9jV0A9GPxof5AaXVOcgvnAcTu32t+S+8iqWyzWIBVrGY2yb/dqXX/KbA/yjnUs/iRnQjvvIPTsjDrxFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178694; c=relaxed/simple;
	bh=SF2Q1i8fxblzM1hVOnUIZyfh85kLZuFEsSKxQAnB8QY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LabiaMKH+cX2TkIvIk2F9wj/t+QyjmMVn2WOQJ8ScxSUO+BAOHl4txU12dxKGHvhc62O7OaLMK7+QBo2uFoy2DrJRsYvTHYES7h4HJdVUKMb/jVlkg8vRtHCm8crJGZtgS7Ole0IHBZC71GginsQ1zSWlcSfjd9hrag5glPi+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0Bo0gLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63D4C4CEF4
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 10:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753178693;
	bh=SF2Q1i8fxblzM1hVOnUIZyfh85kLZuFEsSKxQAnB8QY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R0Bo0gLs9ShIe4wx6jbUtqzPryvMcNYqV7OwqqOc4nw9pTi8/bIpIuOefmLIzhzJQ
	 JIRAYytPLA85BH4PZ8zwDJ/NTG0siKK66ZcPr2uV99OiIgXOeT8FPkqwwYPA6l8ABq
	 ODSl6aNb6iuyXAxn0xQlV5Ir51z0+3hQqzlZdmoGUHnQNGmPONTKCxN4z3XoSpbtQB
	 sDcLzQUvJs4UU7ZPDOEaNDUCgUSd1wb0Dh6Ie0YMgPJyzTx5ODUxtPjDA25ddbGu3z
	 LYhcnIARWY3hE7sxxRpc6NNrj2dL5DwSIyygHIO+56FQ5t58yNCB6FUv0EaM+qPWJo
	 tF6jWDHbVYQdA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aec5a714ae9so669821866b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 03:04:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YxL4ctu+W4yeZhRwvmwsXAAVr4lvb2vdKy/mivUVEo2HEns8bju
	9nb9QZ5rKdyplEAd4KooTHpHfunhBas8yL7sSkpcOv92S0INbueGc8s20hx4jTS9CWJw+YJR4UU
	+f4QH2NZSwaOOV/mO7z3cKY4wlf0rWUU=
X-Google-Smtp-Source: AGHT+IHFXK9ZtQqQ1JKeLb6WLYFq6ybryhG8q5d8/e2FrwLBap1nJvnNtrgaOTahqC/EHkuHwhianPpeNMMdMnTzJi8=
X-Received: by 2002:a17:907:1b03:b0:ae6:add5:ac8a with SMTP id
 a640c23a62f3a-ae9c9940c23mr2396700166b.11.1753178692539; Tue, 22 Jul 2025
 03:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753117707.git.fdmanana@suse.com> <63f83bf0-e5d0-44a6-8a7b-0ab32b2c64ee@suse.com>
In-Reply-To: <63f83bf0-e5d0-44a6-8a7b-0ab32b2c64ee@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 22 Jul 2025 11:04:15 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5=0ucPEW3EbRGkaF1xgQaRM0S7ocTEYpsNxYWkgTfJ5A@mail.gmail.com>
X-Gm-Features: Ac12FXxWw_dXUo3NflW5_wOGCHb6NB_EcpN0-iJVxnIZKX_GozsW8ywWH6gtimg
Message-ID: <CAL3q7H5=0ucPEW3EbRGkaF1xgQaRM0S7ocTEYpsNxYWkgTfJ5A@mail.gmail.com>
Subject: Re: [PATCH 00/10] btrfs: improve error reporting for log tree replay
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 1:16=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/7/22 02:46, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Most errors that happen during log replay or destroying a log tree are =
hard
> > to figure out where they come from, since typically deep in the call ch=
ain
> > of log tree walking we return errors and propagate them up to the calle=
r of
> > the main log tree walk function, which then aborts the transaction or t=
urns
> > the filesystem into error state (btrfs_handle_fs_error()). This means a=
ny
> > stack trace and message provided by a transaction abort or turning fs i=
nto
> > error state, doesn't provide information where exactly in the deep call
> > chain the error comes from.
> >
> > These changes mostly make transacton aborts and btrfs_handle_fs_error()
> > calls where errors happen, so that we get much more useful information
> > which sometimes is enough to understand issues. The rest are just some
> > cleanups.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Although I believe we may further enhance the output by dumping the log
> tree when replay_one_buffer() function failed.
>
> Especially considering we don't have a simple way to dump the log tree
> for a subvolume (always needs to go through the log tree root, then into
> the log tree of a subvolume).

Dumping the log tree alone is not as useful as you might think.

Unless there's an actual IO error due to some extent buffer not
getting persisted, problems during log replay happen because:

1) There are items we didn't log - you can only figure that out by
checking the subvolume tree as well;

2) There are items we logged but should have been removed from a log
tree after events such as unlinks and renames for example - again,
that can figured out only by checking the subvolume tree as well;

So most, if not all problems during log replay, that I remember ever
fixing, and there were lots of them, boiled down to that.
And most times we also need to have an idea of what file/dir
operations happened besides checking the log and subvolume trees.

Also dumping an entire log tree is too much, as it can reach 3 levels
(root at level 2) during the lifetime of a transaction.

There are other things I want to do on top of these changes, but
dumping an entire log tree is not of them.


>
> Thanks,
> Qu
>
>
> >
> > Filipe Manana (10):
> >    btrfs: error on missing block group when unaccounting log tree exten=
t buffers
> >    btrfs: abort transaction on specific error places when walking log t=
ree
> >    btrfs: abort transaction in the process_one_buffer() log tree walk c=
allback
> >    btrfs: use local variable for the transaction handle in replay_one_b=
uffer()
> >    btrfs: return real error from read_alloc_one_name() in drop_one_dir_=
item()
> >    btrfs: abort transaction where errors happen during log tree replay
> >    btrfs: exit early when replaying hole file extent item from a log tr=
ee
> >    btrfs: process inline extent earlier in replay_one_extent()
> >    btrfs: use local key variable to pass arguments in replay_one_extent=
()
> >    btrfs: collapse unaccount_log_buffer() into clean_log_buffer()
> >
> >   fs/btrfs/tree-log.c | 659 +++++++++++++++++++++++++++----------------=
-
> >   1 file changed, 401 insertions(+), 258 deletions(-)
> >
>
>

