Return-Path: <linux-btrfs+bounces-4180-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B9B8A2C5A
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 12:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5135A283F3F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 10:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736B82BB10;
	Fri, 12 Apr 2024 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sv77B1Fr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2042C9D
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917948; cv=none; b=unvI43EIVpecVB2OrodROJXkwzFwen1+VKFqLO9JqA1n00wxK7455dTcnqyIF5QfMqw+JLiRX1MmyOheEYUwI3qJCl1z8e66yFoj5TFZ/SW8PWbwdYLIkR9O+9i5ehn0i6HeN0neXdbokGC7XsBBcO95EEFPbLNn0KLKc8S5oFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917948; c=relaxed/simple;
	bh=FgHmhESKI7Gw8sNEDqLyasWwOCvlYVqc9c+VNcENuU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFKUgmUoFvMGuZ/aKPjgC/yTDEHZafAAV5fPHL89tEGjIv61Q5hwYiSBMFm5CwCz63yofrtdBZ2K/TNfMTShi15wJEIT5x160h622NAIcUCIKUZyIy/2MKERrbigc2shgdRb61LvMyMJQ9purOsOVUpQGryeFknrUOqbfhy8R8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sv77B1Fr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D3FC113CC
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 10:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712917948;
	bh=FgHmhESKI7Gw8sNEDqLyasWwOCvlYVqc9c+VNcENuU0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Sv77B1Fre+hzXiVwKKeUj9kKORELEYo8TpCpOb8k/Ki35+/6+/RbAKNUkQnZfUeOR
	 6CuEEf0W6KF0zHNvJG8ez3b3eOcZHSQUlegBuO36uFc9O7Qo1toUmRy+bCjbWMRBX4
	 s3eS8D3ePZY5m1fKarmmZvKoY9T6j8cv9tTnWk1EeC9OrL5pYt6S3uDhHcTOTectYq
	 3M3XlssyJN78HW/PFAUXgMA7YPcou9jd81H5EUL0JFieHz10+S+1Lj2Q349NVAuhxN
	 sbKnpam8YNEZzrgPj7ub3/PdPODpsk/rtJMyiQftgnJAyRNx7XmARYBm/cSaYQ2Stz
	 9Dc1UNWEUE7gg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a51969e780eso98927866b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 03:32:28 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywh8sxSAQfNG+qTbwQfjhJrbuHGLQiDzVCDX4eBry/q2TCoqdbv
	I0mrauOeiABOvp/4vxFA4nIie3CgkXc7KKpRxHF9bXlhFBpi7mNvSQxSef1ppNtM9Oy5irpFzsm
	JfUBs/VbhQQ8DJtQRvLNydYRAQQg=
X-Google-Smtp-Source: AGHT+IHmP8gRIds2IF5CMmeHBV01vVOtkdz1AMuEJplYvhiyrOdc5PbeLNg8Jys68TZRa4kS9rTrWEUEtQ65Sk6fCSM=
X-Received: by 2002:a17:906:6851:b0:a4e:2178:d91a with SMTP id
 a17-20020a170906685100b00a4e2178d91amr1351010ejs.59.1712917946666; Fri, 12
 Apr 2024 03:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712875458.git.wqu@suse.com>
In-Reply-To: <cover.1712875458.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Apr 2024 11:31:49 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7smJkLMYnSP0akpsc_nORFN4bLp_Wp4VxA2nytxp8Few@mail.gmail.com>
Message-ID: <CAL3q7H7smJkLMYnSP0akpsc_nORFN4bLp_Wp4VxA2nytxp8Few@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] btrfs: more explaination on extent_map members
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:48=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [REPO]
> https://github.com/adam900710/linux.git/ em_cleanup
>
> The first 3 patches only. As later patches are the huge rename part.
>
> [CHANGELOG]
> v4:
> - Add extra comments for the extent map merging
>   Since extent maps can be merged, the members are only matching
>   on-disk file extent items before merging.
>   This also means users of extent_map should not rely on it for
>   a reliable file extent item member.
>   (That's also why we use ordered_extent not extent_maps, to update
>    file extent items)

So this isn't true.
We use information from the ordered extent to create the file extent
item, when finishing the ordered extent, because the ordered extent is
immediately accessible.
We could also use the extent map, we would just have to do a tree search fo=
r it.
The extent map created when starting delalloc or at the beginning of a
DIO write is pinned and in the list of modified extents, so it can't
be merged and it represents exactly one file extent item - the one
going to be inserted the inode's subvolume tree when finishing the
ordered extent.

>
> v3:
> - Rebased to latest for-next branch
> - Further comments polishment
> - Coding style update to follow the guideline
>
> v2:
> - Add Filipe's cleanup on mod_start/mod_len
>   These two members are no longer utilized, saving me quite some time on
>   digging into their usage.
>
> - Update the comments of the extent_map structure
>   To make them more readable and less confusing.
>
> - Further cleanup for inline extent_map reading
>
> - A new patch to do extra sanity checks for create_io_em()
>   Firstly pure NOCOW writes should not call create_io_em(), secondly
>   with the new knowledge of extent_map, it's easier to do extra sanity
>   checks for the already pretty long parameter list.
>
> Btrfs uses extent_map to represent a in-memory file extent.
>
> There are severam members that are 1:1 mappe in on-disk file extent
> items and extent maps:
>
> - extent_map::start     =3D=3D      key.offset
> - extent_map::len       =3D=3D      file_extent_num_bytes
> - extent_map::ram_bytes =3D=3D      file_extent_ram_bytes
>
> But that's all, the remaining are pretty different:
>
> - Use block_start to indicate holes/inline extents
>   Meanwhile btrfs on-disk file extent items go with a dedicated type for
>   inline extents, and disk_bytenr 0 for holes.
>
> - Weird block_start/orig_block_len/orig_start
>   In theory we can directly go with the same file_extent_disk_bytenr,
>   file_extent_disk_num_bytes and file_extent_offset to calculate the
>   remaining members (block_start/orig_start/orig_block_len/block_len).
>
>   But for whatever reason, we didn't go that path and have a hell of
>   weird and inconsistent calculation for them.
>
> Qu Wenruo (3):
>   btrfs: add extra comments on extent_map members
>   btrfs: simplify the inline extent map creation
>   btrfs: add extra sanity checks for create_io_em()
>
>  fs/btrfs/extent_map.h | 58 ++++++++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/file-item.c  | 20 +++++++--------
>  fs/btrfs/inode.c      | 40 ++++++++++++++++++++++++++++-
>  3 files changed, 106 insertions(+), 12 deletions(-)
>
> --
> 2.44.0
>
>

