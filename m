Return-Path: <linux-btrfs+bounces-5954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F34B916548
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 12:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49251F2344A
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9187214A4C9;
	Tue, 25 Jun 2024 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5tK+QCW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDB2E3E4
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311596; cv=none; b=ay1TM08lvbqVKswjacQqMV5GJXfghzj9uE9d6sFw7C8g8jL0ejo861Dp1PMUVEEwwZHHZ9Y/IFQVsI5PqiFomgGKBK1KDc8GJ0lT+5/++IY8WsnW/G2ux6YHJbHDpXHF1diDmtMaUnXHgwk9PXrqxWVEX3l9IAcsiRrHD+Q/9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311596; c=relaxed/simple;
	bh=6xf/xCinurmss6fXhC2RWp6dMCLrDOoQ/D5l2i/DNNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fyq05pmUHhP6Qc+ShuXwsxYLztXdInyxaPHGQlX32vz6DXJxLGLWmO3ADEU8Mje83ASIYQon8nu/O+eZhhjAXr0a6hh8WVfMApLOTwUJeYnbYoi57tOj07f5TH9/PS2rzODycB5Van2ByhNTqIER2UFZ4LigbmKp7Vueps242zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5tK+QCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7F9C32781
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 10:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719311596;
	bh=6xf/xCinurmss6fXhC2RWp6dMCLrDOoQ/D5l2i/DNNg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r5tK+QCWs2QkJUMKd9fLKQpWEX4maSpiexS0LFQJsuvIxg3giQTBTFPiqmwZPjQz6
	 YRSy389ZbxJzcJOe16C6s/CqyYle8ztPS5+MVKgKHV/UM3eCg8T05AqlOkMrrFISZ0
	 YRMnVesy2GL8/Gf7Pe79vNEMYWPozT871Y2yj2XQfb4C2N/8UE12QblAQMU1El1XQX
	 ciFKZrlqI4UGTf9xr3Acqw1qN8TG0r5wLUQT6gQw9JokdLL/z+q/aD5z+hggaPTMc0
	 Keg0T9L2isOF3TDSjX/j4eYHxbOb4zl29lIl33FpWtdJZf5G254d4cxiA/LeS2BzkX
	 DqEDPUhlXL9vA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7252bfe773so247983266b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 03:33:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YxIUW/CDvTwZQGDhBzyPJ71KGtdlhYqf4Bpssp5BfdPVvbnctIl
	409xkrm5GALZTdP8vPSBdQLIZJ+LhzStxtQMbfEB2IOvi16Xd5i3WQWfMP42Rd9I9TJ+owdkGOr
	mIrKc8dWR0UO1F/0uaBV4ZeEYmVQ=
X-Google-Smtp-Source: AGHT+IHxfPHk6yHDJjXks5etdPuwBRRdvpmV7Z7DZOnKUvTMvu67P/U/vSd5LaTUv10KTbOqRNWj8GdGtgLuWtvby94=
X-Received: by 2002:a17:906:3292:b0:a6f:b5ff:a6fd with SMTP id
 a640c23a62f3a-a7245c85a84mr450682966b.12.1719311594821; Tue, 25 Jun 2024
 03:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719291793.git.wqu@suse.com> <0bd7715ef04abbfca4b97137b5b197333f2eb227.1719291793.git.wqu@suse.com>
In-Reply-To: <0bd7715ef04abbfca4b97137b5b197333f2eb227.1719291793.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Jun 2024 11:32:38 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7b_RG+hR+HeOqa8BF-hsoM41QYbghoy104GxWs05M7kw@mail.gmail.com>
Message-ID: <CAL3q7H7b_RG+hR+HeOqa8BF-hsoM41QYbghoy104GxWs05M7kw@mail.gmail.com>
Subject: Re: [PATCH 3/4] btrfs: fix the ram_bytes assignment for truncated
 ordered extents
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 6:08=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> After adding extra checks on btrfs_file_extent_item::ram_bytes to
> tree-checker, running fsstress with multiple threads can lead to

It's irrelevant to mention multiple threads, that's not necessary to
cause the problem.

> tree-checker warning at write time, as we created file extent items with
> ram_bytes.

This last part of the sentence makes no sense "we created file extent
items with ram_bytes" - they must always have ram_bytes.
I think you meant to say "with an invalid ram_bytes value".

>
> All those offending file extents have offset 0, and ram_bytes matching
> num_bytes, and smaller than disk_num_bytes.
>
> This would also trigger the recently enhanced btrfs-check, which would
> catch such mismatch and report them as minor errors.

mismatch -> mismatches

>
> [CAUSE]
> When a folio/page is invalidated and it is part of a submitted OE, we
> mark the OE truncated just to the beginning of the folio/page.
>
> And for truncated OE, we insert the file extent item with incorrect
> value for ram_bytes (using num_bytes instead of the usual value).
>
> This is not a big deal for end users, as we do not utilize the ram_bytes
> field for regular non-compressed extents.
> This mismatch is just a small violation against on-disk format.
>
> [FIX]
> Fix it by removing the override on btrfs_file_extent_item::ram_bytes.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d6c43120c5d3..45f77ae8963f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3018,10 +3018,8 @@ static int insert_ordered_extent_file_extent(struc=
t btrfs_trans_handle *trans,
>         btrfs_set_stack_file_extent_disk_num_bytes(&stack_fi,
>                                                    oe->disk_num_bytes);
>         btrfs_set_stack_file_extent_offset(&stack_fi, oe->offset);
> -       if (test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags)) {
> +       if (test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags))
>                 num_bytes =3D oe->truncated_len;
> -               ram_bytes =3D num_bytes;
> -       }

The code looks good, with those updates to the the changelog:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>         btrfs_set_stack_file_extent_num_bytes(&stack_fi, num_bytes);
>         btrfs_set_stack_file_extent_ram_bytes(&stack_fi, ram_bytes);
>         btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_t=
ype);
> --
> 2.45.2
>
>

