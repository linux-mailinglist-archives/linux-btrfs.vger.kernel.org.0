Return-Path: <linux-btrfs+bounces-20503-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7C3D1E7DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 12:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AF47302E3FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 11:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE50A395274;
	Wed, 14 Jan 2026 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAvlNa9X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7E389DEE
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391053; cv=none; b=MhiLrbw32AMvB+rcCP2/gckCTjm0We4ufBjOZY9ryCMBiEbgeLVxdfLzqWjMB+C7Y71eJ94bJW1bXJDNmKCRdxTX3YIE8OeFuCEbb/x5PeFVi26g7jqpUC/62+Jh0tR00V3tlKdXDEowHYpxU3h+JIaYtTFwCEWEBLzQ9nsqHMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391053; c=relaxed/simple;
	bh=z9+SW7dXp/S50MXlsBkrIqSMUwngvi8AGlYviirdjgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGZmbU4cnkQu8Sl772bjxa2PkSLH5HOLsKNaTYr+O3vAd3gQs14dy3pWl2lUhVZKpvVy9OZX8X9kd03QPTHLYodrmdzGx+9CoEUO3jvOu/jfmAsmtFJoYP+alV3bjZ7tCwC28/gYWRySfJV0lEAvmmuRWxVxRipsz4tEx4OWYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAvlNa9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFDAC19422
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 11:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768391052;
	bh=z9+SW7dXp/S50MXlsBkrIqSMUwngvi8AGlYviirdjgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZAvlNa9Xunkgag4w4PKR0SHDwNiD+7gHXsxtNHOY8wqm0qRsKg7I0wH5S4EbOX5Pi
	 SRMyUSvGAZbpNdrV0JdJEJ619jMS9q5nwzQnsgHYvoqsB+oe2Ir8roWwXPPSD6uH64
	 19x122SahOzhwld5eCXSbCDF1PHNT12ch5ufXB9YEQJg8s2BB0QDQnIRBMBuIrYnDP
	 RDv2QreYWXxQjAp6m3T4drt9PeHbpAyHTst47k7bHkZTd8RsQ/axUOggZfMunbvtmI
	 /qf9W20BW/WuYxMmsWf3/GlXpozf9MDeg7yPA1YbIIwBuh712xnGt8GdnlyYS8oVJy
	 FAvAig/w5c4pw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b921d9e67so14857527a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 03:44:12 -0800 (PST)
X-Gm-Message-State: AOJu0YzloXIEIrXjZkGPx+m9DDJ+BAMV+5kLb09EaWe9OLBd0+4DfxWc
	Uuup3UshTfnJcapGADsouIfSKdpupIHGJLlU+gRgFGBWiCrIqIgpkFRErLUCJG+KygmmFFL77ll
	cdSdgKnjR0eCvY7Mu0wkgFw2a80Jtr84=
X-Received: by 2002:a17:907:a191:b0:b87:711f:97a3 with SMTP id
 a640c23a62f3a-b87711fa143mr37659566b.35.1768391051358; Wed, 14 Jan 2026
 03:44:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179097dcd57ea022d37d97eb0bcc69dcd24243ba.1768356495.git.wqu@suse.com>
In-Reply-To: <179097dcd57ea022d37d97eb0bcc69dcd24243ba.1768356495.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 14 Jan 2026 11:43:34 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4FbrDYSfwNTDkje4dKY13bosbxJap8u8zM8pUHuqWtAg@mail.gmail.com>
X-Gm-Features: AZwV_Qjy_bKJaA5oiF77CMBKIWHNUtdUPlQ8meEqZOOMpGpu9tM1mDWiV-YfCys
Message-ID: <CAL3q7H4FbrDYSfwNTDkje4dKY13bosbxJap8u8zM8pUHuqWtAg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: minor improvement on cow_file_range() error handling
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 2:08=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> There are some minor problems related to the error handling of
> cow_file_range():
>
> - The label out_unlock: is not obvious
>   In fact we only go that tag for error handling.
>
> - mapping_set_error() is not always called
>   It's only called if we have processed some range.
>
> Enhance those minor problems by:
>
> - Rename out_unlock: to error:
>   So it's clear we only go there for error handling, not some generic
>   handling shared by the common path.
>
> - Always call mapping_set_error()
>   Not hiding it behind certain error pattern nor behind @lock_folio
>   parameter, which is always provided for all call sites.

We don't need to call mapping_set_error() in cow_file_range(), as
that's always called in the upper call chain already:

extent_writepage() -> writepage_delalloc() ->
btrfs_run_delalloc_range() -> cow_file_range()

Any error returned by cow_file_range() is propagated up to
extent_writepage(), which does:

done:
    if (ret < 0)
           mapping_set_error(folio->mapping, ret);

Thanks.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 67220ed62000..62d43b5bf910 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1456,12 +1456,12 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
>
>         if (unlikely(btrfs_is_shutdown(fs_info))) {
>                 ret =3D -EIO;
> -               goto out_unlock;
> +               goto error;
>         }
>
>         if (btrfs_is_free_space_inode(inode)) {
>                 ret =3D -EINVAL;
> -               goto out_unlock;
> +               goto error;
>         }
>
>         num_bytes =3D ALIGN(end - start + 1, blocksize);
> @@ -1553,7 +1553,7 @@ static noinline int cow_file_range(struct btrfs_ino=
de *inode,
>                         ret =3D -ENOSPC;
>                 }
>                 if (ret < 0)
> -                       goto out_unlock;
> +                       goto error;
>
>                 /* We should not allocate an extent larger than requested=
.*/
>                 ASSERT(cur_alloc_size <=3D num_bytes);
> @@ -1570,7 +1570,8 @@ static noinline int cow_file_range(struct btrfs_ino=
de *inode,
>                 *done_offset =3D end;
>         return ret;
>
> -out_unlock:
> +error:
> +       mapping_set_error(inode->vfs_inode.i_mapping, ret);
>         /*
>          * Now, we have three regions to clean up:
>          *
> @@ -1593,9 +1594,6 @@ static noinline int cow_file_range(struct btrfs_ino=
de *inode,
>                 clear_bits =3D EXTENT_LOCKED | EXTENT_DELALLOC;
>                 page_ops =3D PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_EN=
D_WRITEBACK;
>
> -               if (!locked_folio)
> -                       mapping_set_error(inode->vfs_inode.i_mapping, ret=
);
> -
>                 btrfs_cleanup_ordered_extents(inode, orig_start, start - =
orig_start);
>                 extent_clear_unlock_delalloc(inode, orig_start, start - 1=
,
>                                              locked_folio, NULL, clear_bi=
ts, page_ops);
> --
> 2.52.0
>
>

