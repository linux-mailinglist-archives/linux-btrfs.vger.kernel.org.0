Return-Path: <linux-btrfs+bounces-3959-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FED2899CDC
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 14:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A551A1F22CE2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 12:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F8016C69F;
	Fri,  5 Apr 2024 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAS3ycpu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489B216ABFA
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319909; cv=none; b=KfFGSac0LdL5Mpqu4ICez56Ik+gFMI7HbM8J0VY6fKvsKNbJGW8Vuk2jvq1OyuBvZLiWKT6OvItMr0BjURnDUuIU912lhCx1XWn4rCxdVy8Xox7PjR9YFto/bPC9Uc48ljpgZTxXPLV64c5hDmjvdU+ZNGuYr8ow19ihifwwg/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319909; c=relaxed/simple;
	bh=cbV0qwulWPn2WfkcxIIpPr5HbcTBSwlfs8kuaHCSsb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDZSmtEjj1bWKyppcIcZpQ2nS+odqyxc84S6n/3u9yaQjietVgw3JFW2HLYvJam4sUC5VsXJXP+eXuhfNF1eFmhHrxQoT4vJkOed0BE9t6BliKPo8WwVYjO4eQ3flTtSeYoKaANUd+hlY1quYmj5b0cJ9c6Mmovyv90Cnyt/E74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAS3ycpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD3BC43390
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 12:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712319908;
	bh=cbV0qwulWPn2WfkcxIIpPr5HbcTBSwlfs8kuaHCSsb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vAS3ycpuW2ngM7XZ4bvxv3DQy9ps6FA5paqoLz1t96wXzA4aECRXm5EaAnozUQ7gh
	 SLS7O3QIuaWbHAMB++UMl3Li+oQ7GDyy4lq9V2/SSXGZJrJg1viPCrGQLTJ8T9Nf4U
	 kKdl6DlQLP01QJXccxE4Kx1DghCiTIgGQRIjzstuuZp2K8hKVzIPtl+JyTeUeLFDrS
	 8H14wAdxaUNMaZzogBOAl03Xfht3YTfL67UjIzImNSlKrHy+oLA4+QgtUrAHHCzfwo
	 QRhRLc/OFQ6pflOGQNeN8E80OrE34UP7ji/iexP9bylgb0/eMfukhhjplynh1AtEES
	 ciMV34oa86OiQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51381021af1so3384220e87.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 05:25:08 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy8TH6tEJX3fNrBEGptiMEJEDgZU65FTKuu0eJkwO9a4dtdkiLW
	DQrHUGhFT5ZiSYzr/PAIzVBjprQF5eNATJgS1kJoEzNHEJrfqU6H1DTURkYWJd5Ol603ilU1BRm
	pUQRc5DLNl+juGfl2ec9hNYCcIg8=
X-Google-Smtp-Source: AGHT+IEg+JpZG+uIzJLPxXU+JmPKW4rq5Pg9WjG00ztRdGcRJ/pUqgtBqfjkmHYygjLheYhWUehCUQ3VgSSiAgDaANg=
X-Received: by 2002:ac2:5150:0:b0:515:8dd3:e94d with SMTP id
 q16-20020ac25150000000b005158dd3e94dmr1151295lfd.68.1712319907154; Fri, 05
 Apr 2024 05:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712287421.git.wqu@suse.com> <261cf7744120a2312ce2cdb22dbbfe439a11268a.1712287421.git.wqu@suse.com>
In-Reply-To: <261cf7744120a2312ce2cdb22dbbfe439a11268a.1712287421.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 5 Apr 2024 13:24:30 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5-2gfkd7xjy9QVrtgDZGv34jhQrTTtuNL8Qs08rNimrA@mail.gmail.com>
Message-ID: <CAL3q7H5-2gfkd7xjy9QVrtgDZGv34jhQrTTtuNL8Qs08rNimrA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] btrfs: add extra comments on extent_map members
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 4:28=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
>  fs/btrfs/extent_map.h | 52 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index 10e9491865c9..0b938e12cc78 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -35,19 +35,69 @@ enum {
>  };
>
>  /*
> + * This structure represents file extents and holes.

So I clearly forgot this before, but we should add the caveat that
it's guaranteed that it represents a single file extent only if the
extent is new and not persisted (in the list of modified extents and
not fsynced).
Otherwise it can represent 2 or more extents that were merged (to save
memory), which adds some caveats I mention below.

Holes can also be merged of course (e.g. read part of a hole, we
create an extent map for that part, read the remainder of the hole,
create another extent map for that remainder, which then merges with
the former).

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

So yes and no.
When merging extent maps, it's not updated, so it's tricky.
But that's ok because an extent map only needs to represent exactly
one file extent item if it's new and was not fsynced yet.

>         u64 orig_block_len;
> +
> +       /*
> +        * The decompressed size of the whole on-disk extent, matching
> +        * btrfs_file_extent_item::ram_bytes.
> +        */
>         u64 ram_bytes;

Same here regarding the merging.

Sorry I forgot this before.

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

