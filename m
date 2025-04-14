Return-Path: <linux-btrfs+bounces-12996-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 669B4A88614
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 16:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54AD41785C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 14:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3FC1A724C;
	Mon, 14 Apr 2025 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI97mKhs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BDC170A0B
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642467; cv=none; b=FlysntMArwIvyMSi/CZqy1+/b/xzgbKnNDgMOiExUN13Te/xUVAJxLgBYo14/l6DdzoA9OQB3kB115Sh6DTQ0NeoE1keguwZgHcl0352JcP4/2uhV6SxmlNDGOhOlirfQHkmSQ+TxMMwca5xoVBDDsf9W0/2agRvxu4RWeqr5Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642467; c=relaxed/simple;
	bh=f9d/buP3v3WUUX19nacadzWp3nM+/XjLkpHkb19yPk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MI/tLGun2VPpxhM/U4VoAW9vWRY4kUMUvNUkD5HjD+j19v87XSMQarTmxE+nc67B4b32ylLrjIvN+qcyPMkvEBjs4hll8A5iXbaysHIz6VlzZ0dMkFBvSBLQgBlEDEPDdczELvjR+XpX2SP0Y3WPY+/SeuWhhkS/QyI2m+VSBFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI97mKhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D625C4CEE2
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 14:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744642467;
	bh=f9d/buP3v3WUUX19nacadzWp3nM+/XjLkpHkb19yPk4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uI97mKhsHN7ZB21NVlLPP8M9Dr2dqAGts8kqO7c+KpxEgcQ63RH1HmCrMEZSecDT5
	 5p0lFm9hgGF7P+RYsl+1yNdDu6eVPgBlgAnSbbb5QqTZsOrAF/wgIOpv8WdwSpwx7G
	 JuUjGp9gqLg/bvReXiNRAtz5mhI+PKAyU3N6so7WwbEOInZe0dOHxTOG/PMr+Nvv0l
	 aJXojUolW/qgV30VPitgBvk000wfMLyxUGZqn2uK8PWkc9T3Vd+FSyE26wKq7XFa/N
	 FRJfaWxvWb8A+XRTq8L6E3M35RAAgmU+V5+kMFH8pMQoe2aFdjUR5lqY6fPMhcRh7i
	 42XZtSGZMVoVQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaecf50578eso807843266b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 07:54:26 -0700 (PDT)
X-Gm-Message-State: AOJu0YyZlwBa8n3sn7H8zUsjturGN2VpeaDl11ZKxcNs8+50NqYqQdna
	JHJPhMpr1eyZN1ABpBY+qgjJPo9USiBmt5+Q4XXVBwu/HzWVA/uNDUr/Un58Q5Ix7c41zKAk8eh
	fMtUI+x528nK8v9PlfDZ5slF2LTY=
X-Google-Smtp-Source: AGHT+IG4R3W4vu1c6siTIa7eqyaJcYgsCtc3amsf7v8Rt6yQ8KrtKpZeWUoRG8MRUUR5dZWpf2AAsvMmxYQ6bnUnO74=
X-Received: by 2002:a17:907:1b02:b0:ac3:8516:9cf2 with SMTP id
 a640c23a62f3a-acad36d7628mr1120725666b.55.1744642465481; Mon, 14 Apr 2025
 07:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4a76fdcba3b1707714fa6b08f28f955c35cae0ee.1744063163.git.wqu@suse.com>
In-Reply-To: <4a76fdcba3b1707714fa6b08f28f955c35cae0ee.1744063163.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 14 Apr 2025 15:53:48 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4QKHcnz-OSQEztEkugSX_WccbWep0njAv+cA8qOxzcFw@mail.gmail.com>
X-Gm-Features: ATxdqUFadHC4rJ0AiHfUKA4fc3-RygNSJfoplnoK8k7fw72YGMaTLNBmIIIiM1I
Message-ID: <CAL3q7H4QKHcnz-OSQEztEkugSX_WccbWep0njAv+cA8qOxzcFw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: prepare compreesion paths for large data folios
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 11:05=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> All compression algorithms inside btrfs are not supporting
> large folios due to the following points:
>
> - btrfs_calc_input_length() is assuming page sized folio
>
> - kmap_local_folio() usages are using offset_in_page()
>
> Prepare them to support large data folios by:
>
> - Add a folio parameter to btrfs_calc_input_length()
>   And use that folio parameter to calculate the correct length.
>
>   Since we're here, also add extra ASSERT()s to make sure the parameter
>   @cur is inside the folio range.
>
>   This affects only zlib and zstd. Lzo compresses at most one block one
>   time, thus not affected.

"one block one time" -> "one block at a time"

>
> - Use offset_in_folio() to calculate the kmap_local_folio() offset
>   This affects all 3 algorithms.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This is exposed by the fstests run btrfs/138 with large data folios
> enabled, which verify the contents of compressed extents and found out
> that the compressed data is all duplication of the first page.
>
> That's the only new regression exposed during my large data folios runs.
> The final enablement patch will be sent when all dependent patches are
> mreged.
> ---
>  fs/btrfs/compression.h | 12 +++++++++---
>  fs/btrfs/lzo.c         |  5 ++---
>  fs/btrfs/zlib.c        |  7 +++----
>  fs/btrfs/zstd.c        |  8 ++++----
>  4 files changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index df198623cc08..d3a61d5fb425 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -11,7 +11,9 @@
>  #include <linux/list.h>
>  #include <linux/workqueue.h>
>  #include <linux/wait.h>
> +#include <linux/pagemap.h>
>  #include "bio.h"
> +#include "messages.h"
>
>  struct address_space;
>  struct page;
> @@ -73,11 +75,15 @@ struct compressed_bio {
>  };
>
>  /* @range_end must be exclusive. */
> -static inline u32 btrfs_calc_input_length(u64 range_end, u64 cur)
> +static inline u32 btrfs_calc_input_length(struct folio *folio,
> +                                         u64 range_end, u64 cur)
>  {
> -       u64 page_end =3D round_down(cur, PAGE_SIZE) + PAGE_SIZE;
> +       u64 folio_end =3D folio_pos(folio) + folio_size(folio);

Can be made const.

Otherwise it looks fine.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> -       return min(range_end, page_end) - cur;
> +       /* @cur must be inside the folio. */
> +       ASSERT(folio_pos(folio) <=3D cur);
> +       ASSERT(cur < folio_end);
> +       return min(range_end, folio_end) - cur;
>  }
>
>  int __init btrfs_init_compress(void);
> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> index a45bc11f8665..d403641889ca 100644
> --- a/fs/btrfs/lzo.c
> +++ b/fs/btrfs/lzo.c
> @@ -252,9 +252,8 @@ int lzo_compress_folios(struct list_head *ws, struct =
address_space *mapping,
>                 /* Compress at most one sector of data each time */
>                 in_len =3D min_t(u32, start + len - cur_in, sectorsize - =
sector_off);
>                 ASSERT(in_len);
> -               data_in =3D kmap_local_folio(folio_in, 0);
> -               ret =3D lzo1x_1_compress(data_in +
> -                                      offset_in_page(cur_in), in_len,
> +               data_in =3D kmap_local_folio(folio_in, offset_in_folio(fo=
lio_in, cur_in));
> +               ret =3D lzo1x_1_compress(data_in, in_len,
>                                        workspace->cbuf, &out_len,
>                                        workspace->mem);
>                 kunmap_local(data_in);
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index b32aa05b288e..f8cd9d6d7e37 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -203,7 +203,6 @@ int zlib_compress_folios(struct list_head *ws, struct=
 address_space *mapping,
>                                 workspace->strm.next_in =3D workspace->bu=
f;
>                                 workspace->strm.avail_in =3D copy_length;
>                         } else {
> -                               unsigned int pg_off;
>                                 unsigned int cur_len;
>
>                                 if (data_in) {
> @@ -215,9 +214,9 @@ int zlib_compress_folios(struct list_head *ws, struct=
 address_space *mapping,
>                                                 start, &in_folio);
>                                 if (ret < 0)
>                                         goto out;
> -                               pg_off =3D offset_in_page(start);
> -                               cur_len =3D btrfs_calc_input_length(orig_=
end, start);
> -                               data_in =3D kmap_local_folio(in_folio, pg=
_off);
> +                               cur_len =3D btrfs_calc_input_length(in_fo=
lio, orig_end, start);
> +                               data_in =3D kmap_local_folio(in_folio,
> +                                                          offset_in_foli=
o(in_folio, start));
>                                 start +=3D cur_len;
>                                 workspace->strm.next_in =3D data_in;
>                                 workspace->strm.avail_in =3D cur_len;
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index cd5f38d6fbaa..b20aeaf12424 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -426,8 +426,8 @@ int zstd_compress_folios(struct list_head *ws, struct=
 address_space *mapping,
>         ret =3D btrfs_compress_filemap_get_folio(mapping, start, &in_foli=
o);
>         if (ret < 0)
>                 goto out;
> -       cur_len =3D btrfs_calc_input_length(orig_end, start);
> -       workspace->in_buf.src =3D kmap_local_folio(in_folio, offset_in_pa=
ge(start));
> +       cur_len =3D btrfs_calc_input_length(in_folio, orig_end, start);
> +       workspace->in_buf.src =3D kmap_local_folio(in_folio, offset_in_fo=
lio(in_folio, start));
>         workspace->in_buf.pos =3D 0;
>         workspace->in_buf.size =3D cur_len;
>
> @@ -511,9 +511,9 @@ int zstd_compress_folios(struct list_head *ws, struct=
 address_space *mapping,
>                         ret =3D btrfs_compress_filemap_get_folio(mapping,=
 start, &in_folio);
>                         if (ret < 0)
>                                 goto out;
> -                       cur_len =3D btrfs_calc_input_length(orig_end, sta=
rt);
> +                       cur_len =3D btrfs_calc_input_length(in_folio, ori=
g_end, start);
>                         workspace->in_buf.src =3D kmap_local_folio(in_fol=
io,
> -                                                        offset_in_page(s=
tart));
> +                                                        offset_in_folio(=
in_folio, start));
>                         workspace->in_buf.pos =3D 0;
>                         workspace->in_buf.size =3D cur_len;
>                 }
> --
> 2.49.0
>
>

