Return-Path: <linux-btrfs+bounces-19787-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3FCCC23F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 12:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 383543005D1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 11:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC89233F378;
	Tue, 16 Dec 2025 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRmL5g34"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5FB39FD9
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884601; cv=none; b=T3vdH+GMJK1WgGQB+8c1Ww2EE7UqVPW0PoYMUS4SIvbImNCJexEnoBFv0vWMA8hPbb/PXAFMFs4FZUgykcjHA3gEG8wY0D7uCNJnbTqg2+iU1cpp7xzqF9ZWimZSQABevjWFVpyMEwxs3jSVinakJju5yrwXOON5kQ51bmgH1ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884601; c=relaxed/simple;
	bh=5samc4X41bC97gMRrjNZ2YN86r6TPnJh/JmOBB8ZuhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPMWTqdgnKYSS7RFaY+NRYqqdlLIiSXInK5MMupVzX2HkO6McZUldZLMVTtnBYHIsecGm3x3xPjcXyqabGkQx4MbzirLnrXIaEKFo4MjMXoKt53IWRlnZ2yd4R+jPBSW7q2q8ucoTJn4r7cyp6bR2QyJIKIsRwlZbpLuTU71fbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRmL5g34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17EAC4CEF5
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 11:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765884600;
	bh=5samc4X41bC97gMRrjNZ2YN86r6TPnJh/JmOBB8ZuhA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YRmL5g34ZAr+kezbZb5n1eQfgbO00GtRhflSrfD4JniZTVgXBEzIBoxlh55TSTw2V
	 UzLOfqJWODsci1JW1KRWI+85DTs4yF7PiFTOioEsJ6f2VmDgpcki2Zce327FZqdzjo
	 hCW1rxVap8N0NPYfbseh++BbeUxtOSOgEps9voseWpcBeIxWn+kmbhHFI6QzIpnmdI
	 gyt1mZKFYZRw1f0VbcRsDLGGFqO2dOduMXBOoNVWmlB8ilTbw88JH/ygLRO+h4Crp7
	 pLWYOkv268R6rg9rWWdcVC5DUlNZCpk+JOjiqVeJp/mkrh1C+UbtG1v5jfDZ5FaGD6
	 nIoZPCeSTfUbA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so963026766b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 03:30:00 -0800 (PST)
X-Gm-Message-State: AOJu0Ywb7o4VL749evHBZI5SwBGR8GCHkcEXqIj4bHLSh2EYUx2+Uavw
	2nRDfMtBJ+sjRYFcgLqtbVU24cIpBjTaBahxRtRDHWmc3Bc4Jcr+WaZoR/DZbVygZ6lHQbKOzvZ
	7g+YN5xxDqeYYEmsEBE8yEuGrj0I6M7k=
X-Google-Smtp-Source: AGHT+IFHo6l8+7e0xUbPQfSch+c5e+ulOtunQKDByjQyQneOw+/xNfsaCuk9Twp+RhjBlGMCvdHP95wQmjawpe99bYg=
X-Received: by 2002:a17:906:2092:b0:b7f:f730:3fd6 with SMTP id
 a640c23a62f3a-b7ff73063a3mr133838666b.62.1765884598973; Tue, 16 Dec 2025
 03:29:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <79e1be995894f1c987a54c6298c36459a756b672.1765081384.git.wqu@suse.com>
In-Reply-To: <79e1be995894f1c987a54c6298c36459a756b672.1765081384.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 16 Dec 2025 11:29:22 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7PAUkGfAc6KBFryYX5E0-oMQYca0q8B666E7ZkEu9XiA@mail.gmail.com>
X-Gm-Features: AQt7F2qjSSzs8ruHT48iCsx2woXQWL8Y7bnFl4mTSUVsU1geOG3yQLuylIjIlgk
Message-ID: <CAL3q7H7PAUkGfAc6KBFryYX5E0-oMQYca0q8B666E7ZkEu9XiA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: avoid access-byoned-folio for bs > ps encoded writes
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 4:24=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [POTENTIAL BUG]
> If the system page size is 4K and fs block size is 8K, and max_inline
> mount option is set to 6K, we can inline a 6K sized data extent.
>
> Then a encoded write submitted a compressed extent which is at file
> offset 0, and the compressed length is 6K, which is allowed to be inlined=
.
>
> Now a read beyond page boundary is triggered inside write_extent_buffer()
> from insert_inline_extent().
>
> [CAUSE]
> Currently the function __cow_file_range_inline() can only accept a
> single folio.
>
> For regular compressed write path, we always allocate the compressed
> folios using the minimal order matching the block size, thus the
> @compressed_folio should always cover a full fs block thus it is fine.
>
> But for encoded writes, they allocate page size folios, this means we
> can hit a case where the compressed data is smaller than block size but
> still larger than page size, in that case __cow_file_range_inline() will
> be called with @compressed_size larger than a page.
>
> In that case we will trigger a read beyond the folio inside
> insert_inline_extent().
>
> Thankfully this is not that common, as the default max_inline is only
> 2048 bytes, smaller than PAGE_SIZE, and bs > ps support is still
> experimental.
>
> [FIX]
> We need to either allow insert_inline_extent() to accept a page array to
> properly support such case, or reject such inline extent.
>
> The latter is a much simpler solution, and considering bs > ps will stay
> as a corner case and non-default max_inline will be even rarer, I don't
> think we really need to fulfill such niche.
>
> So just reject any inline extent that's larger than PAGE_SIZE, and add
> an extra ASSERT() to insert_inline_extent() to catch such beyond-boundary
> access.
>
> Fixes: ec20799064c8 ("btrfs: enable encoded read/write/send for bs > ps c=
ases")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0cbac085cdaf..2f6be047c6ad 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -482,10 +482,12 @@ static int insert_inline_extent(struct btrfs_trans_=
handle *trans,
>          * The compressed size also needs to be no larger than a sector.
>          * That's also why we only need one page as the parameter.
>          */
> -       if (compressed_folio)
> +       if (compressed_folio) {
>                 ASSERT(compressed_size <=3D sectorsize);
> -       else
> +               ASSERT(compressed_size <=3D PAGE_SIZE);

Don't forget to update the comment above and replace sector by page.

Also, typo in the subject:  byoned -> beyond.

Thanks.

> +       } else {
>                 ASSERT(compressed_size =3D=3D 0);
> +       }
>
>         if (compressed_size && compressed_folio)
>                 cur_size =3D compressed_size;
> @@ -572,6 +574,18 @@ static bool can_cow_file_range_inline(struct btrfs_i=
node *inode,
>         if (offset !=3D 0)
>                 return false;
>
> +       /*
> +        * Even for bs > ps cases, cow_file_range_inline() can only accep=
t a
> +        * single folio.
> +        *
> +        * This can be problematic and cause access beyond page boundary =
if a
> +        * page sized folio is passed into that function.
> +        * And encoded write is doing exactly that.
> +        * So here limits the inlined extent size to PAGE_SIZE.
> +        */
> +       if (size > PAGE_SIZE || compressed_size > PAGE_SIZE)
> +               return false;
> +
>         /* Inline extents are limited to sectorsize. */
>         if (size > fs_info->sectorsize)
>                 return false;
> --
> 2.52.0
>
>

