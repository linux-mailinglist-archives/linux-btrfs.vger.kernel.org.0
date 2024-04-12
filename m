Return-Path: <linux-btrfs+bounces-4181-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198D48A2C92
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 12:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA436286378
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 10:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950D33FBAC;
	Fri, 12 Apr 2024 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAWvJrD6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79D06FCC
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918306; cv=none; b=TKuHAS79Ahnr8jeXiB4TCTdfc+XPAWriyj/tuQUV3LNUpCjrmZvTHTEp1vHSBNNEi0qNJDLSgF3AdHOLhCsdicol/Vj64SOX4Bokwbmug9yx2lMCqh4RV43CF/uHuUUeZI5SJAB/ed/Qh0X9xoA+aucBEDixc6KJ/v7L3BMdlqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918306; c=relaxed/simple;
	bh=PFNm0CrT0y6tIdUt5dWVGCnUFtIEdgE6ibgtE70PVPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXR5t/obmwRACs+BU5Xf7tSdesgcPbvsGmtDmAkjFOPN5CE2Xe91o0N2k3j2cU9EndXIeQiV4bBYNPwgqV1V0ogEEPkporPZVnZUtZ/gJQpR2f04GmPgvUEiTd2Dd8AKhSvhkwg1nx86d6b3E4S9MpVm+mP7GVGlOmswvFp8bQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAWvJrD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CF9C113CC
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 10:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712918306;
	bh=PFNm0CrT0y6tIdUt5dWVGCnUFtIEdgE6ibgtE70PVPw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bAWvJrD6tjsvbst6H812BAGfTDSkPUJ5sGY+ESv6/my96Slg1OUfEr8ivQYawv3w+
	 +Vv21XNbIw90aPnkTKE2SksaN58FN39lCSKw4aEzNXesLwuMNJxA71lN10FPHV+b6W
	 qX0bTbAAcjiI1yR8dG8oHqdLTsX3tU+oN26OoeGOhNPaVf8ScziXPB21sAnFs/mjWL
	 7hsbt77eHfrqiVhUw/P436XQzjgYzaSIzALhVy331m7W0nH0lkJGM/82NfNju8Txl1
	 8Czdd+/FuG8D1DUMh4bK1vEYqzsi0Zpeu/rIPDnEFSXuYJj0t56vqgpLzlEuKpQ/Xn
	 /u774RkE5cpAQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a51beae2f13so83101966b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 03:38:26 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw/c7QndTwJ0H1sxFMlK12X/OM52wp7Zhrwl0J1bQCLt6gisirJ
	4wDob8KmxGej1jdYfrbuxEDa3G95kymeG6yro+pK6OSbgsZGLq9e9ttaUVHsqzXwHI99ZlPizfy
	AA1+sg2DuIfhq+bWkCQxgOHI81Xo=
X-Google-Smtp-Source: AGHT+IH5teZ76N4g9ejscRlqH4uWjcqZOnsZuc4htaDSFPWTHbwNimQeB60rfgweQ5WI6plJGHmq/DiaVyMTSrYP0Pk=
X-Received: by 2002:a17:906:1359:b0:a52:3be5:2ca1 with SMTP id
 x25-20020a170906135900b00a523be52ca1mr570252ejb.1.1712918304790; Fri, 12 Apr
 2024 03:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712875458.git.wqu@suse.com> <00d249a2c9bfec06516c6fb84a053104b6f12095.1712875458.git.wqu@suse.com>
In-Reply-To: <00d249a2c9bfec06516c6fb84a053104b6f12095.1712875458.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Apr 2024 11:37:48 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4OYcQtfNrMRXYFQgM1aB2wOyDbQqcHA3iECctbdBB3rQ@mail.gmail.com>
Message-ID: <CAL3q7H4OYcQtfNrMRXYFQgM1aB2wOyDbQqcHA3iECctbdBB3rQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] btrfs: add extra comments on extent_map members
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:48=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> The extent_map structure is very critical to btrfs, as it is involved
> for both read and write paths.
>
> Unfortunately the structure is not properly explained, making it pretty
> hard to understand nor to do further improvement.
>
> This patch adds extra comments explaining the major members based on
> my code reading.
> Hopefully we can find more members to cleanup in the future.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_map.h | 58 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index 10e9491865c9..1b8a55e4b678 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -35,19 +35,75 @@ enum {
>  };
>
>  /*
> + * This structure represents file extents and holes.
> + *
> + * Unlike on-disk file extent items, extent maps can be merged to
> + * save memory.
> + * This means members only match file extent items before any merging.
> + * And users of extent_map should never assume the members are always
> + * matching an on-disk file extent item.

They can safely assume they match one single file extent item if the
extent map is pinned or it's in the list of modified extents of the
extent tree.
This is very important and the fast fsync path relies on this for correctne=
ss.

There's also the case of compressed extents, which are never merged.

So that part of saying "never assume ..." is misleading and doesn't
match reality.

With that corrected:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> + *
>   * Keep this structure as compact as possible, as we can have really lar=
ge
>   * amounts of allocated extent maps at any time.
>   */
>  struct extent_map {
>         struct rb_node rb_node;
>
> -       /* all of these are in bytes */
> +       /* All of these are in bytes. */
> +
> +       /* File offset matching the offset of a BTRFS_EXTENT_ITEM_KEY key=
. */
>         u64 start;
> +
> +       /*
> +        * Length of the file extent.
> +        *
> +        * For non-inlined file extents it's btrfs_file_extent_item::num_=
bytes.
> +        * For inline extents it's sectorsize, since inline data starts a=
t
> +        * offsetof(struct btrfs_file_extent_item, disk_bytenr) thus
> +        * btrfs_file_extent_item::num_bytes is not valid.
> +        */
>         u64 len;
> +
> +       /*
> +        * The file offset of the original file extent before splitting.
> +        *
> +        * This is an in-memory only member, matching
> +        * extent_map::start - btrfs_file_extent_item::offset for
> +        * regular/preallocated extents. EXTENT_MAP_HOLE otherwise.
> +        */
>         u64 orig_start;
> +
> +       /*
> +        * The full on-disk extent length, matching
> +        * btrfs_file_extent_item::disk_num_bytes.
> +        */
>         u64 orig_block_len;
> +
> +       /*
> +        * The decompressed size of the whole on-disk extent, matching
> +        * btrfs_file_extent_item::ram_bytes.
> +        */
>         u64 ram_bytes;
> +
> +       /*
> +        * The on-disk logical bytenr for the file extent.
> +        *
> +        * For compressed extents it matches btrfs_file_extent_item::disk=
_bytenr.
> +        * For uncompressed extents it matches
> +        * btrfs_file_extent_item::disk_bytenr + btrfs_file_extent_item::=
offset
> +        *
> +        * For holes it is EXTENT_MAP_HOLE and for inline extents it is
> +        * EXTENT_MAP_INLINE.
> +        */
>         u64 block_start;
> +
> +       /*
> +        * The on-disk length for the file extent.
> +        *
> +        * For compressed extents it matches btrfs_file_extent_item::disk=
_num_bytes.
> +        * For uncompressed extents it matches extent_map::len.
> +        * For holes and inline extents it's -1 and shouldn't be used.
> +        */
>         u64 block_len;
>
>         /*
> --
> 2.44.0
>
>

