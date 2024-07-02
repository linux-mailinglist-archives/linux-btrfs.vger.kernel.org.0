Return-Path: <linux-btrfs+bounces-6128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212E2923AAA
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 11:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C86F1C22964
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 09:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6283A156C40;
	Tue,  2 Jul 2024 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNJbQtKd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D47A156230
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913864; cv=none; b=AILFetIB9Qwdu8TDuhq0m+rDQ7l9ZC/sZOTu+JAw9OGqNUsyHaBpSzs3cJsLqElEYLeVmiHISutvpA0exyENEn+HaegbCR+46VjDL/T21K9SHnatWjMLdG+RIADJ9KMcuSPcoRA/uqoHZFA2a8IWm6PMomcUlHVXntv6nLFHtqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913864; c=relaxed/simple;
	bh=wIqc+4RJyfvLritI9CzTgnr5YbPWPjHUvQnLIlDOeag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozP7tRmECIXM22j+nlCbUIVTgFx3VWJAd/l2oTUjQ0MoRTDPCPjw0k7TM//UwWA5iwgUc0i6whmbM1zOszfSjP33V1IBCpZVQjmsvuLqvXrzwmVqdCGxE1jgvc/zvt7GVxjMCYT9NTKC7O/HL7DDc72Y5XHp34TUIUDDaIv82ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNJbQtKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7EBC2BD10
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 09:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719913864;
	bh=wIqc+4RJyfvLritI9CzTgnr5YbPWPjHUvQnLIlDOeag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NNJbQtKdnKzZlAzn5riy1E4rhKHFOzYlEQeaorU0TqP8zzDuacZkBT00xOuJH9avK
	 15Fhy/G2ol8SWkAbBVEga/8HfRsP9MOT2AAsccOU4oWqHHxook/Cc0FImpy/sv0b/4
	 MsjUgddSlfFFuZ1EbEZWew+uLa/QgM881EmixtBODLvzsWcc33zJHKAnl8xXTDjQx6
	 Wr666h6PBWxU13iLn02a2S4yMqrxocZwFk1MQTA1nVMpvtZw6nL1hXjtiTMWwSIQB3
	 V9ZXeybva3pgiQhx19riSgi/2UI5gwGV25+Seo4SelJD7DB2w6U5g/uLlDxDfvF0uv
	 xyHP14hxCn1vQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a728f74c23dso448042466b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Jul 2024 02:51:04 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzq88xIT6sSEqcCPK+Xk3GfExqgwePWI1OXgAh6Nljn6GDiN/+x
	DW1E0cC4dbE686jk18IjuZ3Oa2kvJlUuyP6IMT045/b/UgbKn4bu3E6JNtvVPub04NFu2fXeFku
	pAuTeOwHNdQIv3oQF4t8yGC5e1dM=
X-Google-Smtp-Source: AGHT+IG1NHXsQoosPx39OE7MyD6xWFpjy7P1RrqWVhjx4AV3bWmiQXi2oFJbpxCgpkIFhogv1S6O3PDYsc8qGMF31Co=
X-Received: by 2002:a17:906:19cb:b0:a72:6849:cb21 with SMTP id
 a640c23a62f3a-a75144a91ebmr543159266b.54.1719913862868; Tue, 02 Jul 2024
 02:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <511fdb3b7fc4293159d4af8e62775c2c1eb95250.1719874991.git.boris@bur.io>
In-Reply-To: <511fdb3b7fc4293159d4af8e62775c2c1eb95250.1719874991.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 2 Jul 2024 10:50:25 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4dPLUYbr5xRZciF=pMo3rtucZ2oEkM+o6VELLYrcHy+A@mail.gmail.com>
Message-ID: <CAL3q7H4dPLUYbr5xRZciF=pMo3rtucZ2oEkM+o6VELLYrcHy+A@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix __folio_put with folio refcount held
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 12:05=E2=80=AFAM Boris Burkov <boris@bur.io> wrote:
>
> The conversion to folios switched __free_page to __folio_put in the
> error path in btrfs_do_encoded_write and __alloc_dummy_extent_buffer.
>
> However, this gets the page refcounting wrong. If we do hit that error
> path (I reproduced by modifying btrfs_do_encoded_write to pretend to
> always fail in a way that jumps to out_folios and running the xfstest
> btrfs/281), then we always hit the following BUG freeing the folio:
>
> BUG: Bad page state in process btrfs  pfn:40ab0b
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x61be5 pfn:0x=
40ab0b
>  flags: 0x5ffff0000000000(node=3D0|zone=3D2|lastcpupid=3D0x1ffff)
> raw: 05ffff0000000000 0000000000000000 dead000000000122 0000000000000000
> raw: 0000000000061be5 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: nonzero _refcount
> Call Trace:
> <TASK>
> dump_stack_lvl+0x3d/0xe0
> bad_page+0xea/0xf0
> free_unref_page+0x8e1/0x900
> ? __mem_cgroup_uncharge+0x69/0x90
> __folio_put+0xe6/0x190
> btrfs_do_encoded_write+0x445/0x780
> ? current_time+0x25/0xd0
> btrfs_do_write_iter+0x2cc/0x4b0
> btrfs_ioctl_encoded_write+0x2b6/0x340
>
> It turns out __free_page dereferenced the page while __folio_put does
> not. Switch __folio_put to folio_put which does dereference the folio
> first.
>
> Fixes: 400b172b8cdc ("btrfs: compression: migrate compression/decompressi=
on paths to folios")

So this landed in 6.10-rc1, and corresponds to one change in this
patch, the one for inode.c.

> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog
> v2:
> - Fixed __folio_put in __alloc_dummy_extent_buffer as well
>
>  fs/btrfs/extent_io.c | 2 +-
>  fs/btrfs/inode.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index d3ce07ab9692..cb315779af30 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2775,7 +2775,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(s=
truct btrfs_fs_info *fs_info,
>         for (int i =3D 0; i < num_folios; i++) {
>                 if (eb->folios[i]) {
>                         detach_extent_buffer_folio(eb, eb->folios[i]);
> -                       __folio_put(eb->folios[i]);
> +                       folio_put(eb->folios[i]);

Now this bug was introduced in commit 13df3775efca ("btrfs: cleanup
metadata page pointer usage"), which was added in kernel 6.8-rc1.

Why only one Fixes tag in the changelog?
And how do you expect this to be backported?

Two separate patches will be less confusing when it comes to
backporting, given the different kernel versions.



>                 }
>         }
>         __free_extent_buffer(eb);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0a11d309ee89..12fb7e8056a1 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9558,7 +9558,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, =
struct iov_iter *from,
>  out_folios:
>         for (i =3D 0; i < nr_folios; i++) {
>                 if (folios[i])
> -                       __folio_put(folios[i]);
> +                       folio_put(folios[i]);
>         }
>         kvfree(folios);
>  out:
> --
> 2.45.2
>
>

