Return-Path: <linux-btrfs+bounces-12729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C52A77F82
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 17:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F22EC7A214E
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 15:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EF420DD49;
	Tue,  1 Apr 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNhvzseJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EEE20C01C
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522611; cv=none; b=lh046aiyxE0rVCubFUNn4MuSXiW6khRQSAPv3l+CDlM7xAEKPbXOeHT98nO9TYIIOxXMeimZTqGytGS/7rcuK5NeY4/aWWFbOCOYNGQE0lIBiEYxXBjGyMe7tWjznzI6e0LAhHYZvkGMzexGZgacnPsNQv/zEs2ppdpJf2sXvno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522611; c=relaxed/simple;
	bh=hTgBX6wC0pgrZgI2knmAPLU+sze3makKMjXt8vO5bCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EaiznPKKQu/+6ZDpQWhEGN1GYcwDi/TkM/HmYzN3B4lPXqF/MXqctW7MwhgpGWPvlfB/RqtCH5Czgb6hOccQT3ZPUxluRSW9t7V46Q6A2WwpVPEJselb3Zn/5/4SChTvmZ3F/AUuCwb7UITRRallDwhyz/YGk1Mvni5ZD8+P0Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNhvzseJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C01C4CEEA
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743522610;
	bh=hTgBX6wC0pgrZgI2knmAPLU+sze3makKMjXt8vO5bCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LNhvzseJVAXbXvvdxO/8ivZAgU63RdDWHWkYvD88+oybZJLwczBBmX9WRce/1y+0g
	 rR/t6Y7nRzmDHKyJ9BTpjCpf1q6CNOZH+CtHOgwuS5eQUCMxvg0OHL4Mg0AE1vAiOF
	 4XPhcoAiY/kHOHizVCRtFi9wQ8dDznacnkWloG3/E8ombUQ9QF4BdR4QUDIb2KdFY2
	 pHcPxZbFYZyTgwKqzWTjF+Prpx0g57j+2zwzQiiSFUw37HQ0t/jTSeSXqxdQ7LGnf8
	 qWeVYzjJc3HinyLA4O4CwghbTBmIcF6a0akEZHXgHjupKEnYDgYAzuzOkjJiPmQDca
	 W+C2n4Sj7k+7w==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso1054950166b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Apr 2025 08:50:10 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy92xX3E9lsBuQRTQ7AURTfaKMsZB4EUyy4a0VPCMVWjUgOc0lm
	Vp1NvrEwkmmxhzXgZWGch4trEjRCW6tf+xkWfJyNitzhzthYHjTpje7P2R/+XdRt6KzVIwTqCTs
	8HLfcVpBV9NhDLVV1GarIkdsk89s=
X-Google-Smtp-Source: AGHT+IHwqyJ+a9/AN3qpjQ5mQ12KdhSn7dOzR90WG7THIBbLA8XjXWxhXACHHA/IFxoP4Q3Nk/rjkTN23LTBb5JvNwI=
X-Received: by 2002:a17:907:720b:b0:ac7:364b:7ec6 with SMTP id
 a640c23a62f3a-ac7826c8598mr403120666b.0.1743522609126; Tue, 01 Apr 2025
 08:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743493507.git.wqu@suse.com> <235ae192f8d1f9b525aa00a27fd476e2979ada1b.1743493507.git.wqu@suse.com>
In-Reply-To: <235ae192f8d1f9b525aa00a27fd476e2979ada1b.1743493507.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 1 Apr 2025 15:49:32 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5dyAOgxi_ocsL_wXaaLYgMPtTtWNamkRniMxURyNKnxg@mail.gmail.com>
X-Gm-Features: AQ5f1JpAh1B4lQmmVhLzlaykvbpMkAPRhbImR2968K7FhCe1zDEevcfHHjbVKqc
Message-ID: <CAL3q7H5dyAOgxi_ocsL_wXaaLYgMPtTtWNamkRniMxURyNKnxg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] btrfs: fix the file offset calculation inside btrfs_decompress_buf2page()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 8:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG WITH EXPERIMENTAL LARGE FOLIOS]
> When testing the experimental large data folio support with compression,
> there are several ASSERT()s triggered from btrfs_decompress_buf2page()
> when running fsstress with compress=3Dzstd mount option:
>
> - ASSERT(copy_len) from btrfs_decompress_buf2page()
> - VM_BUG_ON(offset + len > PAGE_SIZE) from memcpy_to_page()
>
> [CAUSE]
> Inside btrfs_decompress_buf2page(), we need to grab the file offset from
> the current bvec.bv_page, to check if we even need to copy data into the
> bio.
>
> And since we're using single page bvec, and no large folio, every page
> inside the folio should have its index properly setup.
>
> But when large folios are involved, only the first page (aka, the head
> page) of a large folio has its index properly initialized.
>
> The other pages inside the large folio will not have their indexes
> properly initialized.
>
> Thus the page_offset() call inside btrfs_decompress_buf2page() will
> result garbage, and completely screw up the @copy_len calculation.
>
> [FIX]
> Instead of using page->index directly, go with page_pgoff(), which can
> handle non-head pages correctly.
>
> So introduce a helper, file_offset_from_bvec(), to get the file offset
> from a single page bio_vec, so the copy_len calculation can be done
> correctly.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index e7f8ee5d48a4..cb954f9bc332 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -1137,6 +1137,22 @@ void __cold btrfs_exit_compress(void)
>         bioset_exit(&btrfs_compressed_bioset);
>  }
>
> +/*
> + * The bvec is a single page bvec from a bio that contains folios from a=
 filemap.
> + *
> + * Since the folios may be large one, and if the bv_page is not a head p=
age of

folios -> folio
large -> a large

Otherwise it looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> + * a large folio, then page->index is unreliable.
> + *
> + * Thus we need this helper to grab the proper file offset.
> + */
> +static u64 file_offset_from_bvec(const struct bio_vec *bvec)
> +{
> +       const struct page *page =3D bvec->bv_page;
> +       const struct folio *folio =3D page_folio(page);
> +
> +       return (page_pgoff(folio, page) << PAGE_SHIFT) + bvec->bv_offset;
> +}
> +
>  /*
>   * Copy decompressed data from working buffer to pages.
>   *
> @@ -1188,7 +1204,7 @@ int btrfs_decompress_buf2page(const char *buf, u32 =
buf_len,
>                  * cb->start may underflow, but subtracting that value ca=
n still
>                  * give us correct offset inside the full decompressed ex=
tent.
>                  */
> -               bvec_offset =3D page_offset(bvec.bv_page) + bvec.bv_offse=
t - cb->start;
> +               bvec_offset =3D file_offset_from_bvec(&bvec) - cb->start;
>
>                 /* Haven't reached the bvec range, exit */
>                 if (decompressed + buf_len <=3D bvec_offset)
> --
> 2.49.0
>
>

