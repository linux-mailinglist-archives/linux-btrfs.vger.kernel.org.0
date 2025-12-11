Return-Path: <linux-btrfs+bounces-19656-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7460DCB5AB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 12:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E22643001BD0
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA032E62D4;
	Thu, 11 Dec 2025 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYSOUnS+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C9F23D7CA
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765453315; cv=none; b=qCuHBaRgBDoYYYNI56rGapPxGTE0CRYqgjwioHweK1PADl0PEV5H53BfixLL5dVMqoS2bJfhLbXTzauO+Btw44ayjsx7GJnFNRIh2tAsD6X+eQ7srelXZOPYxZvjTPvNdjnSzql2lO3+HG+4mMAPYriTcG27j+ph2Mcpc7SJoHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765453315; c=relaxed/simple;
	bh=J4Pu2lNrBsvyF3JL0H4l+6u5p4iY/TRdVpPJJ9ijVpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wozwt3ctTfHHkkmBqsUiLIz80RyTp13yFfZ0Xo9XOOzuCi3+iNvKJxtHQfz3MPrrfmFtXby98iETeh9kwpTuN2Yrlc7j3FZcfar9JwOKWdYDQQ0rFXv3XPYyftuii7TzaIWpg2iWBrLaacAWMfBNc1L/7W+/6OEh7dow9S26KCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYSOUnS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647DFC4CEF7
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 11:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765453315;
	bh=J4Pu2lNrBsvyF3JL0H4l+6u5p4iY/TRdVpPJJ9ijVpM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iYSOUnS+6hhNs3ZpVmXJsxY0c8Ov4z/W7KRREHZBUCu8hvIzVuu+OfcR+Fd1pkRXf
	 3scbzdYGHEGrkdwkxFYtJoghws+vIi+fBjHIj+788EUx39PXIRU9yVwapLq7zHTzVT
	 eCc/XtA/TUVwq2y3SxdpMCmq0CbYT62hntrMF7PNfkuzFXcq1T7aRQ/ZyHmiZ3vQ1X
	 X+snjqsQdnve4Biuu/BW1GJ0ys9hfPuDilsFEQNcpkddq0VJqpZjTD35jdZYLC0eSx
	 jv33e/5W3Bi0ZyzgX3vBZdpj9daxdW3mZj9o26RLSu1652TzLd5JFAY+VgQKaoZSy8
	 nKRTjPnNhiCFQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b79ea617f55so160765666b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 03:41:55 -0800 (PST)
X-Gm-Message-State: AOJu0Yx63NntF7d/VSXdF8siYnoXHMWiubpOh5b9bd7Pj2VoLpRdZzWl
	jA4OQNIy5l7xT2XbZyx8FF3I0MGfwb31OogI947axZDt416Dv0OYlyKW1wRR1IyAKinFt4cT08N
	Nm0Dc2iwANsqCCvXLaFdV35S4bexBH0w=
X-Google-Smtp-Source: AGHT+IE8OImqZFYg/rrjmP1VhFp27lVK/6uaUQyPoZLSSTd09b4wyyX5s0zxook1luabDjHlsC6FL0mHxtHFTDwTbOY=
X-Received: by 2002:a17:907:3f20:b0:b72:5fac:d05a with SMTP id
 a640c23a62f3a-b7ce8490982mr662913666b.37.1765453313998; Thu, 11 Dec 2025
 03:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765418669.git.wqu@suse.com> <4d0eff22caa7217a4c1972a755043ee3324c5348.1765418669.git.wqu@suse.com>
In-Reply-To: <4d0eff22caa7217a4c1972a755043ee3324c5348.1765418669.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 11 Dec 2025 11:41:17 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7O4dZzjo6tEoUMbkTbj6mJhh+ngM3s=Yudew5a2h0GDQ@mail.gmail.com>
X-Gm-Features: AQt7F2pP-lLLcaoGAXZbX1PlzIkgOY9gtGfC4Gv89XardeNKI8CotrKU9snKI_c
Message-ID: <CAL3q7H7O4dZzjo6tEoUMbkTbj6mJhh+ngM3s=Yudew5a2h0GDQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: add an ASSERT() to catch ordered extents
 without datasum
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 2:16=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Inside btrfs_finish_one_ordered(), there are only very limited
> situations where the OE has no checksum:
>
> - The OE is completely truncated or error happened
>   In that case no file extent is going to be inserted.
>
> - The inode has NODATASUM flag
>
> - The inode belongs to data reloc tree
>
> Add an ASSERT() using the last two cases, which will help us to catch
> problems described in commit 18de34daa7c6 ("btrfs: truncate ordered
> extent when skipping writeback past i_size"), and prevent future similar
> cases.

How exactly does this new assertion catches that case described in that com=
mit?
We had csums there, just not for the whole range of the ordered
extent, just for the range from its start offset to the rounded up
i_size (which is less than the ordered extent's end offset).

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 461725c8ccd7..740de9436d24 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3226,6 +3226,21 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_=
extent *ordered_extent)
>                 goto out;
>         }
>
> +       /*
> +        * If we have no data checksum, either the OE is:
> +        * - Fully truncated
> +        *   Those ones won't reach here.
> +        *
> +        * - No data checksum
> +        *
> +        * - Belongs to data reloc inode
> +        *   Which doesn't have csum attached to OE, but cloned
> +        *   from original chunk.
> +        */
> +       if (list_empty(&ordered_extent->list))
> +               ASSERT(inode->flags & BTRFS_INODE_NODATASUM ||
> +                      btrfs_is_data_reloc_root(inode->root));

No need to inode->root, we have a local variable with the root already.

> +
>         ret =3D add_pending_csums(trans, &ordered_extent->list);
>         if (unlikely(ret)) {
>                 btrfs_abort_transaction(trans, ret);
> --
> 2.52.0
>
>

