Return-Path: <linux-btrfs+bounces-3912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23C389850B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 12:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B57E1F23F91
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 10:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9172678B63;
	Thu,  4 Apr 2024 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agojv7w+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED5E26AC2
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712226842; cv=none; b=fPOUwwOPaVA/vu9CW2QFulRsCD5qYCnD3tWTKj0xK3lGsPgESAhTaW8CG+CmMdS2H/idB/v24RYkJqkiQz8ruY8MPxB9WWQhenrmEcbK8YDsPd5eLl1VcgaQ6vp5imsbquzRl0j82wniyD48p4dfN94BtQxqsUaGuXKJwpIODyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712226842; c=relaxed/simple;
	bh=uZn5SVUvvQfpCGbAYj3eZ0u+EqpwE8xj0tX5EDNOoDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iU7KWYXE1U7NHCWEWQGPiegFWF2y6qLCy3nqROndmJxELfvyPTL8o7TFt1e7sc3w4hUasKe9v5XaHB8k4vgOwCuPB2fKF4x8EP60J9RJqBYYYhwbBcyYF2rmaMrG/CvVt7W0F8Cu0FhiXkRTPBx7Jc3JYpt3k+BuhyybdArWwg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agojv7w+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500C8C433F1
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 10:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712226842;
	bh=uZn5SVUvvQfpCGbAYj3eZ0u+EqpwE8xj0tX5EDNOoDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=agojv7w+FsOHiLp508SoqbnFqv2kxltfVFWXIAGaHF/gYv/Bc46V/MKD/GJExxRBb
	 3ooTCiMOKkKNQIQonWBVqlOgumfsEfb4CClwRAoZ+rYYAHOH2SEpPHBQLgwKNaoSS+
	 eW45qIJJN2l7xkP5cEmjT/i4VEUx7YYR+IEW7RN3l7hrXHP+FJOUJ7R125opl1elEB
	 PVbyeCZ2I9XSMtq9S4Nsjuq0YSk077rjjm/vAYo4AJufylfLPo84daOPDpnd4rFlJs
	 UVeZ+A5Si7s68yv4OMFgwSaj2FpvCN3AMBhYIwEJLycllhzsxfMzAAaKy9zqPDRADZ
	 h08wY6DLVX1Kg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a468226e135so116247166b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Apr 2024 03:34:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YwpFwSC2rwQIGIyglWlC5fq+uI7+8JfNY1QrBOOE6qDyhxJ3a2s
	SQS/ifb+A58MvT6KPbbA2cWNKnsxm4R7KjQDVg0YSkJ082ICnkitkPWTtrgjT7H04RDgypSDo+u
	g77CiykcR4aKPBgq9Q/rYNEqTq1U=
X-Google-Smtp-Source: AGHT+IH3dlYTfoBkGam70sODrvD6gVoP5ZYzP1T+EMJhNA2pf4XOwSvFP2IsYWN8Uhm5pEz3dJ1Ky19gi+PtLyo//Xc=
X-Received: by 2002:a17:906:c34b:b0:a4e:9970:aee7 with SMTP id
 ci11-20020a170906c34b00b00a4e9970aee7mr1278714ejb.50.1712226840875; Thu, 04
 Apr 2024 03:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712187452.git.wqu@suse.com> <98da90ba55445f69030a7664ae5029d710e4efbd.1712187452.git.wqu@suse.com>
In-Reply-To: <98da90ba55445f69030a7664ae5029d710e4efbd.1712187452.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 4 Apr 2024 11:33:23 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5bCtoPR09vK0LJhPqw1qv8Jz4T5nRT5dSznajzz1+yqg@mail.gmail.com>
Message-ID: <CAL3q7H5bCtoPR09vK0LJhPqw1qv8Jz4T5nRT5dSznajzz1+yqg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] btrfs: add extra comments on extent_map members
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 12:47=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
>  fs/btrfs/extent_map.h | 54 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index 10e9491865c9..82768288c6da 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -35,19 +35,71 @@ enum {
>  };
>
>  /*
> + * This structure represents file extents and holes.
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
> +        * offsetof(struct , disk_bytenr) thus

Missing the structure's name (btrfs_file_extent_item).

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
> +        *
> +        * For non-compressed extents, this matches orig_block_len.

It always matches btrfs_file_extent_item::ram_bytes, regardless of compress=
ion.

Thanks.

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

