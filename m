Return-Path: <linux-btrfs+bounces-3824-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED93895891
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 17:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27C61C23F9C
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD96134730;
	Tue,  2 Apr 2024 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxFSCniK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50A1131756
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072760; cv=none; b=UXD2YF0zV8slsr54IIwe3O10XJSpSKlq9yasqzdb+Rt+7Lwb1Hb+4aLP6P9n/b6Gp3/XVYL0nIyzDx3NfpwqTPP2nYljytNwk/ca+BznnIngXOUN8zhldPdLBm6eI7qgiRr0FJrAYM2dixmVh+eQS3REjxL/zp8VUkV/nOeazSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072760; c=relaxed/simple;
	bh=8PWWmnFwmb2gXlNudfw6DY5rpQxXTKKuARhzmUcKwG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhlfAmdJsLQlrRVsARiv8iShqXfW5EF143DKZ4mQn/iXW0JAunrTLHaukaDwDEHn/VUvboZD7dqHYTcBwoF/AUmLmljYpqKwMy3yf5IKfc0N+O/PbwdqlVuw9RmC5qbIh690W70fLICZ1Z/Fei0qmjPVbwERBneyN1TJUfroB6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxFSCniK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B94C43390
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 15:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712072759;
	bh=8PWWmnFwmb2gXlNudfw6DY5rpQxXTKKuARhzmUcKwG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KxFSCniKqnLK8X3wZrXZ9b8uLGRZ764uIdOq33ifLID7DTg/TCf8LMZDIJAzp9PP2
	 0AO+L3VxNvGlGyd/EueadBt9NW5H/l2Hc4hJnVAWop060n+q704nSJET7WHVbVPyFm
	 l+lTvqsiPQW+E6DLn7+p8F5FEsceIY7qFnllxt6kwQCnQYRN453XW81W8jjfRGS07S
	 PSV96z/RH85kpipn2onDN/f3Ptronac0DD4E76vXmuGRdfHamrgX3K7y6yzRqDDi9e
	 65ascExaJVx2ewDklgAGqY1tMjWz66EURr2srmrd8CVBa8gVDoWTZOyjE6n+bl5+qm
	 1zUAVXQu0KH2g==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56df377bd13so924953a12.0
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Apr 2024 08:45:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YzUlsAEOfZY1his+MZFg2wnRG2WqX082cJSqmoDUhss1XiUoo2a
	i9G5A9O1w15adJZBY7MjFdgujNunI5JCozkchmB/rKDnc1oQKuDCmT6M5XXXxK1IRZladpMNCR1
	ur6IIep7+ueMaJgURFpVnZW6x9Ac=
X-Google-Smtp-Source: AGHT+IH7/wE+Agyj3ppdWuSRpx//8lOCrhOTKYXLLyBZsuRsx3JLsPRDBCDlK03gh8VzqEvFURNh3V67jMXGpt5+gVY=
X-Received: by 2002:a17:906:b151:b0:a46:5d40:eb97 with SMTP id
 bt17-20020a170906b15100b00a465d40eb97mr7083827ejb.70.1712072758023; Tue, 02
 Apr 2024 08:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712038308.git.wqu@suse.com> <50b37f24a3ac5a2c68529a2373ad98d9c45e6f33.1712038308.git.wqu@suse.com>
In-Reply-To: <50b37f24a3ac5a2c68529a2373ad98d9c45e6f33.1712038308.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 2 Apr 2024 15:45:21 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5tYKCRPWbYF+jCjMWr7-78NtH4umcw2OnKVa4uvjQ=PA@mail.gmail.com>
Message-ID: <CAL3q7H5tYKCRPWbYF+jCjMWr7-78NtH4umcw2OnKVa4uvjQ=PA@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: add extra comments on extent_map members
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 7:24=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> The extent_map structure is very critical to btrfs, as it is involved
> for both read and write paths.
>
> Unfortunately the structure is not properly explained, making it pretty
> hard to understand nor to do further improvement.
>
> This patch would add extra comments explaining the major numbers base on

would add -> adds

And by "numbers" I think you wanted to say "members"?

base -> based

> my code reading.
> Hopefully we can find more members to cleanup in the future.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_map.h | 62 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 61 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index c5a098c99cc6..30322defcd03 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -37,21 +37,81 @@ enum {
>  };
>
>  /*
> + * This extent_map structure is an in-memory representation of file exte=
nts,
> + * it would represent all file extents (including holes, no matter if we=
 have
> + * hole file extents).

This can simply be:

"This structure represents file extents and holes."

Which also fixes some grammar (it would represent -> it represents)
and the stuff between parentheses is confusing.

> + *
>   * Keep this structure as compact as possible, as we can have really lar=
ge
>   * amounts of allocated extent maps at any time.
>   */
>  struct extent_map {
>         struct rb_node rb_node;
>
> -       /* all of these are in bytes */
> +       /* All of these are in bytes */

Please add punctuation as well.

> +
> +       /*
> +        * File offset of the file extent. matching key.offset of
> +        * (INO EXTENT_DATA FILEPOS) key.
> +        */

"File offset matching the offset of a BTRFS_EXTENT_ITEM_KEY key."

That's a lot more clear than using the shortened format from tree-dump.
Also note that "matching" should start with a capital letter
(beginning of sentence.

>         u64 start;
> +
> +       /*
> +        * Length of the file extent.
> +        * For non-inlined file extents it's btrfs_file_extent_item::num_=
bytes.
> +        * For inlined file extents it's sectorsize. (as there is no reli=
able
> +        * btrfs_file_extent::num_bytes).

Don't put whole sentences in parentheses after a punctuation mark.
This can also be rephrased in a more clear way:

"For inline extents it's sectorsize and
btrfs_file_extent_item::num_bytes has data and not a valid length,
because inline data starts at offsetof(struct btrfs_file_extent_item,
disk_bytenr)."

> +        */
>         u64 len;
> +
> +       /*
> +        * The modified range start/length, these are in-memory-only
> +        * members for fsync/logtree optimization.
> +        */

These were initially used to avoid logging the same csum ranges
multiple times when extent maps get merged.
But from a quick look and experiment we don't actually need them in
order to avoid that (we don't merge new modified extents).
I'll send a patch to remove them and update the fsync logic.

>         u64 mod_start;
>         u64 mod_len;
> +
> +       /*
> +        * The file offset of the original file extent before splitting.
> +        *
> +        * This is an in-memory-only member, mathcing

in-memory-only -> in-memory only
mathcing -> matching

> +        * em::start - btrfs_file_extent_item::offset for regular/preallo=
cated

Instead of em, which is only a typical variable name we use for extent
maps, use 'extent_map' so that it's precise and leaves no room for
confusion.

> +        * extents. EXTENT_MAP_HOLE otherwise.
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
> +        * For hole extents it is EXTENT_MAP_HOLE and for inline extents =
it is
> +        * EXTENT_MAP_INLINE.
> +        */
>         u64 block_start;
> +
> +       /*
> +        * The on-disk length for the file extent.
> +        *
> +        * For compressed extents it matches btrfs_file_extent_item::disk=
_num_bytes.
> +        * For uncompressed extents it matches em::len.

Same as before, use 'extent_map::len' instead of 'em::len'.

> +        * Otherwise -1 (aka doesn't make much sense).

That is cryptic...
Should be something like:  "If the extent map represents a hole, then
it's -1 and shouldn't be used."

Thanks.



> +        */
>         u64 block_len;
>
>         /*
> --
> 2.44.0
>
>

