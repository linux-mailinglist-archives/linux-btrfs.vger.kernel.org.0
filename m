Return-Path: <linux-btrfs+bounces-3301-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C7187C221
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 18:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C90DB21DB2
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 17:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10952745FA;
	Thu, 14 Mar 2024 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQs5R/zs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8A97443F
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710437400; cv=none; b=BTr8efyRMMM7viZBcRHwkB4cy+dyjuOM8lG1uvAZ0jpTNEYWTB/mVhLzxrsTRIMuUNfnqF+I8KP9xdkTDKwSryEytckOfGcvCvTKyTM9et3OZktymnqfLiA2yjEImIB4hKQO7bnYVY1c6qy4R8caHdi8Bept8BoTtumYqrGMFRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710437400; c=relaxed/simple;
	bh=KEyS1eDz5861V74C+stV7qs3v9Ro/gquWQVcdQlPC2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvIqguILL4W+ethRYSucrovpAVjthG6oXplF8gtbDnNGoDsJbFLPIkUw6WvH3pu9Rr4o3d9e6TnOSkbB7Hpp3ikZZ3UcefHVTtX3emMmJNY6TwcBLSWbjeImdfbme6w0n5J+VoDHPSvlnbzlVTDiH0+mSGHQmayhnF8ZnGcGwq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQs5R/zs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C062CC433F1
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 17:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710437399;
	bh=KEyS1eDz5861V74C+stV7qs3v9Ro/gquWQVcdQlPC2M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gQs5R/zsqEpwHdYjfUjvZTQm8C+AVdDDg9jS7+apyAUEhaZexiF3yqRzEtn0Jf12/
	 HG7nLNn0PCKJbXrlYcQK0c4SRSyIxNCVTPpWj5DGMv2WLhsnGJGgATHwi5t9ZkyGDa
	 WiHGsYYUlNojBKBWzNwR/ItIz3RJHXmJvtTygMR5pcOqk32JUAGTq/UJQGJAJAWylN
	 tJD7SIo2L1fI8obm9jMj5rWlXY4mIGYbJpVLUTXoaUEopYPuolIqg5GPyD4bf5Tg7w
	 DiAzw7dyd6v7LhcCtXtqRwLeOP5Zpl+09uMbQ7igcQW9CFJVxEMXMm/3HX5gygt1WL
	 y8ck8Iz1HteHQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513ccc70a6dso1907140e87.1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 10:29:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YyDf9RxdkousFgkv9/WqtPfky52WQmjheWcilZyysrmxxiRTFnK
	MPsoKn53ymA9H8M3Kqw6LqgTX6oQN+hRKzLRyCyHDZOGm6ld40Dbxt9+bU8aFcaF2Jzo8cAMpzA
	7b/A2nAsdlHNghnrkMBVGSfdUWsY=
X-Google-Smtp-Source: AGHT+IHcoAz4hMTZNhTEDnccroiCg1ih+ks416x+9sor/uktNmGx4cjjGEXf1XL+Z2Bq49qHQFCp2p4Y/P8+lIHGZEQ=
X-Received: by 2002:a19:640f:0:b0:513:af27:df03 with SMTP id
 y15-20020a19640f000000b00513af27df03mr632678lfb.5.1710437398053; Thu, 14 Mar
 2024 10:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710409033.git.wqu@suse.com> <8a27a999b81dc317ff9420f87288cf9fdd6da4b7.1710409033.git.wqu@suse.com>
In-Reply-To: <8a27a999b81dc317ff9420f87288cf9fdd6da4b7.1710409033.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 14 Mar 2024 17:29:21 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5icEETAE_mQi6Ak_fMKjjHvNujHdSQ2Aa1sn6Rj74FFQ@mail.gmail.com>
Message-ID: <CAL3q7H5icEETAE_mQi6Ak_fMKjjHvNujHdSQ2Aa1sn6Rj74FFQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] btrfs: scrub: simplify the inode iteration output
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 9:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> The following two output are not really needed:
>
> - nlinks
>   Normally file inodes should have nlinks as 1, for those inodes have
>   multiple hard links, the inode/root number is still enough to pin it
>   down to certain inode.
>
> - size
>   The size is always fixed to sector size.
>
> By removing the nlinks output, we can reduce one inode item lookup.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Seems reasonable, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  fs/btrfs/scrub.c | 27 +--------------------------
>  1 file changed, 1 insertion(+), 26 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 277583464371..18b2ee3b1616 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -388,17 +388,13 @@ static noinline_for_stack struct scrub_ctx *scrub_s=
etup_ctx(
>  static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes=
,
>                                      u64 root, void *warn_ctx)
>  {
> -       u32 nlink;
>         int ret;
>         int i;
>         unsigned nofs_flag;
> -       struct extent_buffer *eb;
> -       struct btrfs_inode_item *inode_item;
>         struct scrub_warning *swarn =3D warn_ctx;
>         struct btrfs_fs_info *fs_info =3D swarn->dev->fs_info;
>         struct inode_fs_paths *ipath =3D NULL;
>         struct btrfs_root *local_root;
> -       struct btrfs_key key;
>
>         local_root =3D btrfs_get_fs_root(fs_info, root, true);
>         if (IS_ERR(local_root)) {
> @@ -406,26 +402,6 @@ static int scrub_print_warning_inode(u64 inum, u64 o=
ffset, u64 num_bytes,
>                 goto err;
>         }
>
> -       /*
> -        * this makes the path point to (inum INODE_ITEM ioff)
> -        */
> -       key.objectid =3D inum;
> -       key.type =3D BTRFS_INODE_ITEM_KEY;
> -       key.offset =3D 0;
> -
> -       ret =3D btrfs_search_slot(NULL, local_root, &key, swarn->path, 0,=
 0);
> -       if (ret) {
> -               btrfs_put_root(local_root);
> -               btrfs_release_path(swarn->path);
> -               goto err;
> -       }
> -
> -       eb =3D swarn->path->nodes[0];
> -       inode_item =3D btrfs_item_ptr(eb, swarn->path->slots[0],
> -                                       struct btrfs_inode_item);
> -       nlink =3D btrfs_inode_nlink(eb, inode_item);
> -       btrfs_release_path(swarn->path);
> -
>         /*
>          * init_path might indirectly call vmalloc, or use GFP_KERNEL. Sc=
rub
>          * uses GFP_NOFS in this context, so we keep it consistent but it=
 does
> @@ -451,12 +427,11 @@ static int scrub_print_warning_inode(u64 inum, u64 =
offset, u64 num_bytes,
>          */
>         for (i =3D 0; i < ipath->fspath->elem_cnt; ++i)
>                 btrfs_warn_in_rcu(fs_info,
> -"%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, off=
set %llu, length %u, links %u (path: %s)",
> +"%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, off=
set %llu, path: %s",
>                                   swarn->errstr, swarn->logical,
>                                   btrfs_dev_name(swarn->dev),
>                                   swarn->physical,
>                                   root, inum, offset,
> -                                 fs_info->sectorsize, nlink,
>                                   (char *)(unsigned long)ipath->fspath->v=
al[i]);
>
>         btrfs_put_root(local_root);
> --
> 2.44.0
>
>

