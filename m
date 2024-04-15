Return-Path: <linux-btrfs+bounces-4257-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA6C8A4DC5
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 13:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE67A1C224A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 11:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E373F65197;
	Mon, 15 Apr 2024 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uj3wHBDP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBAA633FE
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180864; cv=none; b=ghuBtDs/VwgQm1vLPb02iLfgm0GIXdRWjN44qQBTQhcSUHMoe7bfaIQ2bcRvfF7X2kC5fIuFrG3hrKgd70GWRNU8G3L8odXglJxHP53a71oI8KePLdS/61M4G4QrUgNZ8WSryjGHxPC5vqcC9lsXazw4NZ5xlGVREXq79TTu2gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180864; c=relaxed/simple;
	bh=elquyA1u2Q+VuTrnM2oBhkN7l8Q+/nLtGfIABHEUEb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZM0K2Ww3rJH90IUzx7lFpnelWLzbXDQx3PpZ6X15+IZXFYZBwrKnpTk6eLylxloqLXBY3C0kzed9fR5cn0QcNiU91yUhiXiz6E2lYUt1O/1Bnkid+zV+jo4CidFapkKrhJKTbZcjvfjYzILIkqKLFtq57S7G5zsh/Z67kiDbVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uj3wHBDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC21FC2BD11
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 11:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713180863;
	bh=elquyA1u2Q+VuTrnM2oBhkN7l8Q+/nLtGfIABHEUEb8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uj3wHBDPt0KvkfKY+EnadY9M/4KgYFxPPdUFSKOpNBXtTnrMD0wTHusPcykNk8c1e
	 pVtVGHPwwca4yN8FycmrXH3fR6NAnrNkMiRpUuuELFAYg6KB4IDdVoSWaryVHhLPbb
	 1CHBc1IS7jYRP7d5+rTIhqU+viNYkRd51of6btH8T6x39aiAn9PAaYsdeoY1kdhLbP
	 gzoxPOjOX2PEfmTWQEdJH/BAI1KHHC7VkoXs4C9+irFOfcdwIYO6mZB3GCpketuSHb
	 leTjK3TG9xH4DXl7dtEqk4accJSijRcZhM5uX0BFXp1MS9Igk0K5Hv5zxueQ7msfK+
	 OfHjGkqKmMQeQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a526d0b2349so90781066b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 04:34:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YyyGKoJnKPJgKaF6pqmUEQI2gjVAq0iSAHAO3DYm7G8kAC/Px7B
	O+l/LevmjZeeWyVazDDuuVoBq4kniNAfoQu3QhVjv11L6D6+VHBU7TzEdsttV9CcZjEpFpt+yYk
	OZpYzGuF9xFUCtLLnLy9vcmFakDs=
X-Google-Smtp-Source: AGHT+IFpoZDZTp0peKqnpuyPU/ftFpY5ya+Dg9dZHO18kBvbSwCdxT0l4+/+K/6zvShT9CHzQxV0X/DNjTWoV9nrd7M=
X-Received: by 2002:a17:906:eec1:b0:a55:201f:75f with SMTP id
 wu1-20020a170906eec100b00a55201f075fmr616302ejb.36.1713180862200; Mon, 15 Apr
 2024 04:34:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cbf5bf79edc537544f383ee3d6c79a1bec45a964.1713100883.git.josef@toxicpanda.com>
In-Reply-To: <cbf5bf79edc537544f383ee3d6c79a1bec45a964.1713100883.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Apr 2024 12:33:45 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7XjBHGkz68PW9oqXKMaU5EN+jshBAZ5ndgqk5RgEDhdw@mail.gmail.com>
Message-ID: <CAL3q7H7XjBHGkz68PW9oqXKMaU5EN+jshBAZ5ndgqk5RgEDhdw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: set start on clone before calling copy_extent_buffer_full
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 2:22=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Our subpage testing started hanging on generic/560 and I bisected it
> down to 1cab1375ba6d ("btrfs: reuse cloned extent buffer during
> fiemap to avoid re-allocations").  This is subtle because we use
> eb->start to figure out where in the folio we're copying to when we're
> subpage, as our ->start may refer to an area inside of the folio.
>
> For example, assume a 16k page size machine with a 4k node size, and
> assume that we already have a cloned extent buffer when we cloned the
> previous search.
>
> copy_extent_buffer_full() will do the following when copying the extent
> buffer path->nodes[0] (src) into cloned (dest):
>
> src->start =3D 8k; // this is the new leaf we're cloning
> cloned->start =3D 4k; // this is left over from the previous clone
>
> src_addr =3D folio_address(src->folios[0]);
> dest_addr =3D folio_address(dest->folios[0]);
>
> memcpy(dest_addr + get_eb_offset_in_folio(dst, 0),
>        src_addr + get_eb_offset_in_folio(src, 0), src->len);
>
> Now get_eb_offset_in_folio() is where the problems occur, because for
> sub-pagesize blocksize we can have multiple eb's per folio, the code for
> this is as follows
>
> size_t get_eb_offset_in_folio(eb, offset) {
>         return (eb->start + offset & (folio_size(eb->folio[0]) - 1));
> }
>
> So in the above example we are copying into offset 4k inside the folio.
> However once we update cloned->start to 8k to match the src the math for
> get_eb_offset_in_folio() changes, and any subsequent reads (ie
> btrfs_item_key_to_cpu()) will start reading from the offset 8k instead
> of 4k where we copied to, giving us garbage.
>
> Fix this by setting start before we co copy_extent_buffer_full() to make
> sure that we're copying into the same offset inside of the folio that we
> will read from later.
>
> All other sites of copy_extent_buffer_full() are correct because we
> either set ->start beforehand or we simply don't change it in the case
> of the tree-log usage.
>
> With this fix we now pass generic/560 on our subpage tests.
>
> Fixes: 1cab1375ba6d ("btrfs: reuse cloned extent buffer during fiemap to =
avoid re-allocations")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Now this change log is informative and helpful. Thanks for the update.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  fs/btrfs/extent_io.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 49f7161a6578..a59cd88cf318 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2809,13 +2809,19 @@ static int fiemap_next_leaf_item(struct btrfs_ino=
de *inode, struct btrfs_path *p
>                 goto out;
>         }
>
> -       /* See the comment at fiemap_search_slot() about why we clone. */
> -       copy_extent_buffer_full(clone, path->nodes[0]);
>         /*
>          * Important to preserve the start field, for the optimizations w=
hen
>          * checking if extents are shared (see extent_fiemap()).
> +        *
> +        * We must set ->start before calling copy_extent_buffer_full(). =
 If we
> +        * are on sub-pagesize blocksize, we use ->start to determine the=
 offset
> +        * into the folio where our eb exists, and if we update ->start a=
fter
> +        * the fact then any subsequent reads of the eb may read from a
> +        * different offset in the folio than where we originally copied =
into.
>          */
>         clone->start =3D path->nodes[0]->start;
> +       /* See the comment at fiemap_search_slot() about why we clone. */
> +       copy_extent_buffer_full(clone, path->nodes[0]);
>
>         slot =3D path->slots[0];
>         btrfs_release_path(path);
> --
> 2.43.0
>
>

