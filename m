Return-Path: <linux-btrfs+bounces-4297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82A78A69C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 13:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90CE1C210E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 11:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1285129A68;
	Tue, 16 Apr 2024 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0oFTBFI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B2E12882D
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267556; cv=none; b=HHyDHKJILr9ij8OlaHR4cRNDo22gzllPUv0sfWqJm1zBD1M4PfjEHgQ0Be6e63sIB8fOCiqL1WLCANs6ubR7Tp7rbxvIpuyDHmrq55ks+3S5KhDK9RATzOlH2DGmnRkRhZNI1KyA0FZI0MWxNSUcjSv06LLNVyjvVfW1c3BIbZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267556; c=relaxed/simple;
	bh=zLtC3zV/Sp8/quJM6i9jKnR78jauufaKmqJygvd2jzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfgHH8/EloLOI0f2eQ5gXLpp0tdUD7iW9I+J70k+r5dQsRz/Oo3dGE4Y1Iv3aRRvwnp/Ylf7WNdXnzdQ3mh3+d0yn0NEtxkeZ5lMjDOSVngAsp7BHVsHOt+SpU31beOyxaWTS97rniP9n6EPkuovnXrJtLD/0Crug+FBTbZ0NeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0oFTBFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F79DC2BD10
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 11:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713267555;
	bh=zLtC3zV/Sp8/quJM6i9jKnR78jauufaKmqJygvd2jzM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m0oFTBFIh/VJgsh+fPXywO3175WlkJIBa+JR0uz6UaXs7KEzwT0tJv7hruvZICLn6
	 MgWbzE0zCVAhLu4v9rerh0bGxXEJHUrIVMexm8zS5KQFaGnIR+b+Zr/m0Pg14BCdjI
	 G2I0xd8K+GT/Kb8/V3lbVjNRppxPJb3WrXHmYndgtY2VbZsxaAY+9p5ay7QX8yybC0
	 I67n76F27TFcwuZHjkHgMzHJ5Zxc4gWpMXmIGtSU7HBzm7meIfDMmVzilv1tWt0ewz
	 LZIWOdxKIfdRFVDIULFUlg2/gNqcRtk6IlQQBd0q5Y5SZQzGCXRGO+9Yb8Rlvj/Nb/
	 aINmYTFn1VTNA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a51a1c8d931so549856566b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 04:39:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YzHhP5HJWNqHUQQR++qbOM8vmCDgo28/9WS8JywPTrDfJpLeGqj
	hjJ6h3OOJcDVQH9++lE4Lm2TYSjxAu93S68eQqt3tK22YZipbvNFuIiPhDo2/IKuw73BQoUrKzd
	MWtM+ZTKzS3CbmsyiUHKRE3iqJgE=
X-Google-Smtp-Source: AGHT+IHqZ/5/PhzQQ1Ytn+aRZRwebGRQXABLmPizRp/lTRRzSPOD2GFzfgpPr50d2eal3ODGZLHijqLwty3TIIZh/qg=
X-Received: by 2002:a17:906:601:b0:a52:1433:2c6f with SMTP id
 s1-20020a170906060100b00a5214332c6fmr7660676ejb.64.1713267554034; Tue, 16 Apr
 2024 04:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713223082.git.wqu@suse.com> <8f23c433c686f87ae863071e1c16950c7b9ebd44.1713223082.git.wqu@suse.com>
In-Reply-To: <8f23c433c686f87ae863071e1c16950c7b9ebd44.1713223082.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 16 Apr 2024 12:38:37 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6onSJmgz69_+izymvhg=sdwN8wob1n-pb8-87Yz7OOCw@mail.gmail.com>
Message-ID: <CAL3q7H6onSJmgz69_+izymvhg=sdwN8wob1n-pb8-87Yz7OOCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: set correct ram_bytes when splitting ordered extent
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 12:24=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When running generic/287, the following file extent items can be
> generated:
>
>         item 16 key (258 EXTENT_DATA 2682880) itemoff 15305 itemsize 53
>                 generation 9 type 1 (regular)
>                 extent data disk byte 1378414592 nr 462848
>                 extent data offset 0 nr 462848 ram 2097152
>                 extent compression 0 (none)
>
> Note that file extent item is not a compressed one, but its ram_bytes is
> way larger than its disk_num_bytes.
>
> According to btrfs on-disk scheme, ram_bytes should match disk_num_bytes
> if it's not a compressed one.
>
> [CAUSE]
> Since commit b73a6fd1b1ef ("btrfs: split partial dio bios before
> submit"), for partial dio writes, we would split the ordered extent.
>
> However the function btrfs_split_ordered_extent() doesn't update the
> ram_bytes even it has already shrunk the disk_num_bytes.
>
> Originally the function btrfs_split_ordered_extent() is only introduced
> for zoned devices in commit d22002fd37bd ("btrfs: zoned: split ordered
> extent when bio is sent"), but later commit b73a6fd1b1ef ("btrfs: split
> partial dio bios before submit") makes non-zoned btrfs affected.
>
> Thankfully for un-compressed file extent, we do not really utilize the
> ram_bytes member, thus it won't cause any real problem.
>
> [FIX]
> Also update btrfs_ordered_extent::ram_bytes inside
> btrfs_split_ordered_extent().
>
> Fixes: b73a6fd1b1ef ("btrfs: split partial dio bios before submit")
> Fixes: d22002fd37bd ("btrfs: zoned: split ordered extent when bio is sent=
")

It's confusing to have two commits here.

Given that the second one is the one that introduced the ordered
extent splitting function and that the first one just uses that
function, leaving only the second Fixes tag makes it clear and avoids
confusion. I.e. it's not the first commit that introduced the bug.

Otherwise it looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ordered-data.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index b749ba45da2b..c2a42bcde98e 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -1188,6 +1188,7 @@ struct btrfs_ordered_extent *btrfs_split_ordered_ex=
tent(
>         ordered->disk_bytenr +=3D len;
>         ordered->num_bytes -=3D len;
>         ordered->disk_num_bytes -=3D len;
> +       ordered->ram_bytes -=3D len;
>
>         if (test_bit(BTRFS_ORDERED_IO_DONE, &ordered->flags)) {
>                 ASSERT(ordered->bytes_left =3D=3D 0);
> --
> 2.44.0
>
>

