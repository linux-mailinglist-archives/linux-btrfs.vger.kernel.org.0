Return-Path: <linux-btrfs+bounces-20155-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A74CF84EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 13:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F7B9301AE3F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 12:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF527313E38;
	Tue,  6 Jan 2026 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3guqnPY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED42730FC37
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702327; cv=none; b=V7MQN0ko+Uz8+VaB4OiUn6Wc5NVJo+lhVPJsoEt+IZ5Sl0cik9A2eW6Fyv/gimEBbVT1aLWjQVCt+YKyv6ZP+9ALDo3nl/FiJ02ax5g+Ouhzn9T9iYX1ACDP9hqS/PSUdrTL7F0cw5YWsNyE3Gj8e4je92edbBv1wYafoBIHi8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702327; c=relaxed/simple;
	bh=b4k2PbgfAzChBisQABl/qn8msIycQV9bAk8gpAJVFyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaCHtiNatsoU2tZFDp6w75+trBe0TciDxkln+5Wl/aYayzBOB2ednhlPporC7+5+9QDt7PacKTpdUacm9oTv+sCzKgGjq2LCvbs8VkNgy7CgKHNeCDpCIf+P/lTi081eflLeFqLG8ZWKVH0pTbjUJVHZySUbykfxYfJ2AIhQMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3guqnPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBF9C19422
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 12:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767702326;
	bh=b4k2PbgfAzChBisQABl/qn8msIycQV9bAk8gpAJVFyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R3guqnPYIPsHxp2o8SFdqyb8MfPuRbPd6qrN5svePL2wMKsvlzi7VwVn08VIEReke
	 AWpJr89ObrQfQPE3qx+BxGN3uBRUP4tc7CT4UvAetclnwFsuRCwnI2s/WMDDmfYmhe
	 ygxL82HnjZKwxzXbS5m6DFVIHkBHADHKe6QBL96F4e0uJO5H0obzCre6OcV6RWiQe8
	 rw2y6m+uaobkDQnjCNms1tldpt5WQkbMOz/w/Cy9qYyCUXWN0zPPEQBxg8mpAZ4Lu9
	 B8QfBYCnO7d3L52TQetX4AkfHe0NSjFDOx/eQtOgAFjJJIMRI9jdn8NjRXZy1H+ZLR
	 W5xI5hTbgBT+g==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b843d418e37so34811966b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Jan 2026 04:25:26 -0800 (PST)
X-Gm-Message-State: AOJu0Yy8HXWXfaasTp29TqPh2bVB2XD/3Rtyok8L3n7KGQENAJj/XmbH
	Uch7odlbrJCFXFhC+ZJIltRy+ZCHeasD1bVyinPpguv+OMasxI2gRN26ORwB8fL1JjpxTd5Jcdm
	BACOfKsfvrqZqR9g1+vQteicp2CPQQDE=
X-Google-Smtp-Source: AGHT+IGAWWqEE92jA5DsqH8mfE/vr2YYYSIP/Clti5thIe8Wm9Coaxu8go3rrzzp9Tpj43rcsYpdeX2dvUR1UDZkdDM=
X-Received: by 2002:a17:907:3d94:b0:b76:d4fb:c30b with SMTP id
 a640c23a62f3a-b84299b58e7mr249299266b.27.1767702325334; Tue, 06 Jan 2026
 04:25:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d03b605a911523e504cb1d6f00010c40d6558980.1767693386.git.wqu@suse.com>
In-Reply-To: <d03b605a911523e504cb1d6f00010c40d6558980.1767693386.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 6 Jan 2026 12:24:48 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7ZTMMfa7OmQvA16hCf0MHqVbhW7hBpitmqcyi4TUOiNw@mail.gmail.com>
X-Gm-Features: AQt7F2pjMB-kGxnStMVFRbEagBcdMy5wH7OeIb3kajsK9X7TEuSBc_6aIPe6Uws
Message-ID: <CAL3q7H7ZTMMfa7OmQvA16hCf0MHqVbhW7hBpitmqcyi4TUOiNw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: send: check for inline extents in range_is_hole_in_parent()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 10:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Before accessing the disk_bytenr field of a file extent item we need
> to check if we are dealing with an inline extent.
> This is because for inline extents their data starts at the offset of
> the disk_bytenr field. So accessing the disk_bytenr
> means we are accessing inline data or in case the inline data is less
> than 8 bytes we can actually cause an invalid
> memory access if this inline extent item is the first item in the leaf
> or access metadata from other items.
>
> Fixes: 82bfb2e7b645 ("Btrfs: incremental send, fix unnecessary hole write=
s for sparse files")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
> Changelog
> v2:
> - Update the subject and commit message
>   To give a more clear explanation on why we shouldn't touch disk_bytenr
>   and other members before making sure the file extent is not an inlined
>   one.
> ---
>  fs/btrfs/send.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 2522faa97478..d8127a7120c2 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -6383,6 +6383,8 @@ static int range_is_hole_in_parent(struct send_ctx =
*sctx,
>                 extent_end =3D btrfs_file_extent_end(path);
>                 if (extent_end <=3D start)
>                         goto next;
> +               if (btrfs_file_extent_type(leaf, fi) =3D=3D BTRFS_FILE_EX=
TENT_INLINE)
> +                       return 0;
>                 if (btrfs_file_extent_disk_bytenr(leaf, fi) =3D=3D 0) {
>                         search_start =3D extent_end;
>                         goto next;
> --
> 2.52.0
>
>

