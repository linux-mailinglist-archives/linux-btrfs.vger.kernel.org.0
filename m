Return-Path: <linux-btrfs+bounces-15851-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A0EB1B25F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 13:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1910618894F8
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B51023F43C;
	Tue,  5 Aug 2025 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAEnwHYV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68410226CF0
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754391706; cv=none; b=uiD5ngSu4u5oy0XsUAw5gjnWJ8G/mHH3olX65DfTlDubEvYwR045dt5yJBHm0ZgOSLQApY8pCFf/C0LpkZgtvTt8g2xr53ydpmJ7N18wm2Spy+JmgLCEwO6ZIX5pMKDtPHAOkkqI+N8Y2EWpmlnw45Nxw4G//N4eJRkZE5+a1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754391706; c=relaxed/simple;
	bh=1aWGv/7+lYFtUAy1dHgzbn6WIyI5vBYV2c2CL9dR48k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJzrieh9kXkmnud6CzZszEgzt6BnVuI60sEJ3jF6MaJgWwj2Nr+UF33XkdxSbCm0EgRELim4BwZF3zloJjOBsJDQelp37Ii293hPU8dUj4n7C2t0aFr7KiCVNYQB5rKgP5KDfnjhp4t3tJERNDUcDlocIass2lLkglqAtlqcFmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAEnwHYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64BEC4CEF0
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 11:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754391705;
	bh=1aWGv/7+lYFtUAy1dHgzbn6WIyI5vBYV2c2CL9dR48k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cAEnwHYVKG3y4iyCmhLFJcOXtYylP3Toy04u7Q9WpEJGI0rsQ9Za+oCeNb1qR4GXL
	 qTtgWlv3LFD9seSbDdJjyDmepqRQvW10HHTk1Iy6XZvo53UwceM7xtkc9/87sJpNI5
	 DiuNgvrxmXt2SipZZS+e1JzazmEzNMxyzuY+ISJZZ38WLpIBgrGKLc3Tjh5A17cGQf
	 EPSg9FL2Oa9mAQ6aZaFRdPU8mlEgX63MI+FFIOT8YGPV6PhYI9uFBX/ZODaYIatqNu
	 +NIIzGbU1eBcoeTqteH1MSZjoh52/6nPIemlrVl4vIa+zxs/N+xOHLJOHoG+uFPFwG
	 RDg551HqZ8sRQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af9842df867so77925966b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Aug 2025 04:01:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YyN8LVnfZ9bzpy/8VIqJX7ydsJB+YPSvmN/sNxpkKTwg+RM+cIO
	ztqOR9LQ0GChUfXm47K+1O97PyqqarrOOuKaqqC4pgm5thb5CYOjL6FTms+xw2UH9gwR1/W/1Yl
	r1npGHZBoQhiy3PLsK2ciY5wANuUsxOg=
X-Google-Smtp-Source: AGHT+IFhJ13B8edVscz3Doe63x+nBEKrSj+LAr7RpF0aSHr72mttyS6peOdl4TXKXSqp/yz1WSg0yYudgNfSJyQDKsw=
X-Received: by 2002:a17:907:2d25:b0:af9:7f4f:776d with SMTP id
 a640c23a62f3a-af97f4fb078mr306183066b.25.1754391704409; Tue, 05 Aug 2025
 04:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753781242.git.wqu@suse.com> <c4e6696127d2205d7faef094e0b951ca88098410.1753781242.git.wqu@suse.com>
In-Reply-To: <c4e6696127d2205d7faef094e0b951ca88098410.1753781242.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 5 Aug 2025 12:01:07 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5g9R9FtG3nids+Nx6GOTApeVUZeSfF-K+a2gTjsahUZg@mail.gmail.com>
X-Gm-Features: Ac12FXyjIEGqYu-__5TqEgKA_oi5j2VR4gE8vjtAHTEIQS9h_8b1Blrg5FSx8UA
Message-ID: <CAL3q7H5g9R9FtG3nids+Nx6GOTApeVUZeSfF-K+a2gTjsahUZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: clear block dirty if submit_one_sector() failed
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 10:32=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> If submit_one_sector() failed, the block will be kept dirty, but with
> their corresponding range finished in the ordered extent.
>
> This means if later a writeback happens again, we can hit the following
> problems:
>
> - ASSERT(block_start !=3D EXTENT_MAP_HOLE) in submit_one_sector()
>   If the original extent map is a hole, then we can hit this case, as
>   the new ordered extent failed, we will drop the new extent map and
>   re-read one from the disk.
>
> - DEBUG_WARN() in btrfs_writepage_cow_fixup()
>   This is because we no longer have an ordered extent for those dirty
>   blocks. The original for them is already finished with error.
>
> [CAUSE]
> The function submit_one_sector() is not following the regular error
> handling of writeback.
> The common practice is to clear the folio dirty, start and finish the
> writeback for the block.
>
> This is normally done by extent_clear_unlock_delalloc() with
> PAGE_START_WRITEBACK | PAGE_END_WRITEBACK flags during
> run_delalloc_range().
>
> So if we keep those failed blocks dirty, they will stay in the page
> cache and wait for the next writeback.
>
> And since the original ordered extent is already finished and removed,
> depending on the original extent map, we either hit the ASSERT() inside
> submit_one_sector(), or hit the DEBUG_WARN() in
> btrfs_writepage_cow_fixup().
>
> [FIX]
> Follow the regular error handling to clear the dirty flag for the block,
> start and finish writeback for that block instead.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c11c93bcc7f6..f6765ddab4a7 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1548,7 +1548,7 @@ static noinline_for_stack int writepage_delalloc(st=
ruct btrfs_inode *inode,
>
>  /*
>   * Return 0 if we have submitted or queued the sector for submission.
> - * Return <0 for critical errors.
> + * Return <0 for critical errors, and the sector will have its dirty fla=
g cleared.
>   *
>   * Caller should make sure filepos < i_size and handle filepos >=3D i_si=
ze case.
>   */
> @@ -1571,8 +1571,19 @@ static int submit_one_sector(struct btrfs_inode *i=
node,
>         ASSERT(filepos < i_size);
>
>         em =3D btrfs_get_extent(inode, NULL, filepos, sectorsize);
> -       if (IS_ERR(em))
> -               return PTR_ERR(em);
> +       if (IS_ERR(em)) {
> +               int ret =3D PTR_ERR(em);
> +
> +               /*
> +                * When submission failed, we should still clear the foli=
o dirty.
> +                * Or the folio will be written back again but without an=
y
> +                * ordered extent.
> +                */
> +               btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsi=
ze);
> +               btrfs_folio_set_writeback(fs_info, folio, filepos, sector=
size);
> +               btrfs_folio_clear_writeback(fs_info, folio, filepos, sect=
orsize);
> +               return ret;

No need for the variable 'ret', it's only used once, we can directly:
return PTR_ERR(em);

> +       }
>
>         extent_offset =3D filepos - em->start;
>         em_end =3D btrfs_extent_map_end(em);
> @@ -1702,8 +1713,9 @@ static noinline_for_stack int extent_writepage_io(s=
truct btrfs_inode *inode,
>          * Here we set writeback and clear for the range. If the full fol=
io
>          * is no longer dirty then we clear the PAGECACHE_TAG_DIRTY tag.
>          *
> -        * If we hit any error, the corresponding sector will still be di=
rty
> -        * thus no need to clear PAGECACHE_TAG_DIRTY.
> +        * If we hit any error, the corresponding sector will still have =
its

"will still have" is odd, it gives the idea the dirty flag was not set
before - it was, but we cleared it when we got an error.

I'd suggest:  "If we hit any error, the corresponding sector will have
its dirty flag cleared and writeback finished ..."

Otherwise it looks good, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> +        * dirty flag cleared and finish writeback just like below, thus
> +        * no need to handle error case either.
>          */
>         if (!submitted_io && !error) {
>                 btrfs_folio_set_writeback(fs_info, folio, start, len);
> --
> 2.50.1
>
>

