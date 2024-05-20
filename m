Return-Path: <linux-btrfs+bounces-5111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764958C9BA7
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 12:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965A5B21D07
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 10:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BBB524B4;
	Mon, 20 May 2024 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtrrRrEP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061A2032B
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716202304; cv=none; b=XTDOYU1bsvh+tMKTSkAgVE+qUJpb/zJJcTcDtKVOa1cL4mNnunUeM6vSle03H+TR4VYBwbohDkw7MxUXbB5KA7uleKZhOeKw3V30NxCwKPF7RMPN0mJfkji3jLiUz2goPlehf8cJgFgk4k7cg2voxz5ozzbxsePOaFBXxHUfpLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716202304; c=relaxed/simple;
	bh=BqXEDBr/X6CV0bWobJEyUoivAHn+/Uo2K38O4GOpx4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kp6kXjHWIpyeVK3xM410ozFsucbDkMl9i1fiCJM2sBPGZ2eAHT75SdpR/npnVsXatqDyyNw5azCMXiS3XwEsEhAOlLURij9rD/0ua7C2cvwM5Gaw5sAYLn35k7VWYyqz3s/WuUfY0DhbYus0m6bTZXQVB4y4yOHDQFg/2T0ueNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtrrRrEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48722C2BD10
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 10:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716202304;
	bh=BqXEDBr/X6CV0bWobJEyUoivAHn+/Uo2K38O4GOpx4Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WtrrRrEPN9xUalvIfZ84cAvRkft9EVO/OVcyP267ycamwhVRC9L0u+eCP8JnSEOnc
	 Bzm70A29gACTa2YLu4u3oc2BajqpEON7eK9eazi37goL6h0YJh+dsWD88+gQTTWZNS
	 hLyJwleTdplMqjaL8drWKGXK+pR8xIDU56pGG7NSJ1KRavXpnI84qOij039pZWd4sd
	 Ot9TzereQxtnBAUZIZKlDyk0403ykVMpD3+iFV10/1g8mHzQ/ZTdKDCeg3o0ItpuMy
	 U6mvEuKR5ZPglFVoG1M4mepSJLTHI4wwt20Vj65nTFvG8e/lGtF6J9Da8CMzwzxDMx
	 dZIZWS+U0zF4g==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572e48f91e9so8017518a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 03:51:44 -0700 (PDT)
X-Gm-Message-State: AOJu0YysCdW3ewjcvQwC7ghQnLFbqRUJAa+Pi3XJytRZGJU/R53pH3N+
	4okFo2ouyr4k/NxgC29GVoXsg4GCVnOorVRmkiQvg/iolRUMvOaC+OJR+QkutCaEmID2ZUcOeO1
	+f3N5lTitnmuJk1eBWHrIbTtIixM=
X-Google-Smtp-Source: AGHT+IGbvj84qywyyBAGCewwq9CN71sQlpnTD9FNJ4UsWhThXN/KFr/8B7FNTLiRIN0SpOgKc0G+H0Ll43nj7T0ZtoU=
X-Received: by 2002:a17:906:3546:b0:a59:9ef3:f6df with SMTP id
 a640c23a62f3a-a5a2d581e6emr1957509566b.22.1716202302894; Mon, 20 May 2024
 03:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <31b95191f9f1c8aa600370b70a77d69ebfd30bd3.1716177342.git.wqu@suse.com>
In-Reply-To: <31b95191f9f1c8aa600370b70a77d69ebfd30bd3.1716177342.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 20 May 2024 11:51:04 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7RxYhiTTMZU_qQ9yZKRm7Qo_YdhDq1zNxz=g_gVALhcw@mail.gmail.com>
Message-ID: <CAL3q7H7RxYhiTTMZU_qQ9yZKRm7Qo_YdhDq1zNxz=g_gVALhcw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: enhance function extent_range_clear_dirty_for_io()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 4:56=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Enhance that function by:
>
> - Moving it to inode.c
>   As there is only one user inside compress_file_range(), there is no
>   need to export it through extent_io.h.
>
> - Add extra error handling
>   Previously we go BUG_ON() if we can not find a page inside the range.
>   Now we downgrade it to ASSERT(), as this really means some logic
>   error since we should have all the pages locked already.
>
> - Make it subpage compatible
>   Although currently compression only happens in a full page basis even
>   for subpage routine, there is no harm to make it subpage compatible
>   now.

The changes seem ok and reasonable to me.

However I think these are really 3 separate changes that should be in
3 different patches.
It makes it easier to review and to revert in case there's a need to do so.

So I would make the move to inode.c first, and then the other changes.
Or the move last in case we need to backport the other changes.

Some comments inlined below.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 15 ---------------
>  fs/btrfs/extent_io.h |  1 -
>  fs/btrfs/inode.c     | 31 ++++++++++++++++++++++++++++++-
>  3 files changed, 30 insertions(+), 17 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index a8fc0fcfa69f..9a6f369945c6 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -164,21 +164,6 @@ void __cold extent_buffer_free_cachep(void)
>         kmem_cache_destroy(extent_buffer_cache);
>  }
>
> -void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64=
 end)
> -{
> -       unsigned long index =3D start >> PAGE_SHIFT;
> -       unsigned long end_index =3D end >> PAGE_SHIFT;
> -       struct page *page;
> -
> -       while (index <=3D end_index) {
> -               page =3D find_get_page(inode->i_mapping, index);
> -               BUG_ON(!page); /* Pages should be in the extent_io_tree *=
/
> -               clear_page_dirty_for_io(page);
> -               put_page(page);
> -               index++;
> -       }
> -}
> -
>  static void process_one_page(struct btrfs_fs_info *fs_info,
>                              struct page *page, struct page *locked_page,
>                              unsigned long page_ops, u64 start, u64 end)
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index dca6b12769ec..7c2f1bbc6b67 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -350,7 +350,6 @@ void extent_buffer_bitmap_clear(const struct extent_b=
uffer *eb,
>  void set_extent_buffer_dirty(struct extent_buffer *eb);
>  void set_extent_buffer_uptodate(struct extent_buffer *eb);
>  void clear_extent_buffer_uptodate(struct extent_buffer *eb);
> -void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64=
 end);
>  void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, =
u64 end,
>                                   struct page *locked_page,
>                                   struct extent_state **cached,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 000809e16aba..541a719284a9 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -890,6 +890,32 @@ static inline void inode_should_defrag(struct btrfs_=
inode *inode,
>                 btrfs_add_inode_defrag(NULL, inode, small_write);
>  }
>
> +static int extent_range_clear_dirty_for_io(struct inode *inode, u64 star=
t, u64 end)
> +{
> +       struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> +       const u64 len =3D end + 1 - start;
> +       unsigned long end_index =3D end >> PAGE_SHIFT;
> +       bool missing_folio =3D false;
> +
> +       /* We should not have such large range. */
> +       ASSERT(len < U32_MAX);
> +       for (unsigned long index =3D start >> PAGE_SHIFT;
> +            index <=3D end_index; index++) {
> +               struct folio *folio;
> +
> +               folio =3D filemap_get_folio(inode->i_mapping, index);
> +               if (IS_ERR(folio)) {
> +                       missing_folio =3D true;
> +                       continue;
> +               }
> +               btrfs_folio_clamp_clear_dirty(fs_info, folio, start, len)=
;
> +               folio_put(folio);
> +       }
> +       if (missing_folio)
> +               return -ENOENT;

Why not return the error from filemap_get_folio()? We could keep it
and then return it after finishing the loop.
Currently it can only return -ENOENT, according to the function's
comment, but it would be better future proof and return whatever error
it returns.

Thanks.

> +       return 0;
> +}
> +
>  /*
>   * Work queue call back to started compression on a file and pages.
>   *
> @@ -931,7 +957,10 @@ static void compress_file_range(struct btrfs_work *w=
ork)
>          * Otherwise applications with the file mmap'd can wander in and =
change
>          * the page contents while we are compressing them.
>          */
> -       extent_range_clear_dirty_for_io(&inode->vfs_inode, start, end);
> +       ret =3D extent_range_clear_dirty_for_io(&inode->vfs_inode, start,=
 end);
> +
> +       /* We have locked all the involved pagse, shouldn't hit a missing=
 page. */
> +       ASSERT(ret =3D=3D 0);
>
>         /*
>          * We need to save i_size before now because it could change in b=
etween
> --
> 2.45.1
>
>

