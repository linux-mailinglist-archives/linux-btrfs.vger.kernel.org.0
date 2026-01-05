Return-Path: <linux-btrfs+bounces-20099-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5038CF3535
	for <lists+linux-btrfs@lfdr.de>; Mon, 05 Jan 2026 12:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD86D30161DE
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 11:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7BA33121B;
	Mon,  5 Jan 2026 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojU1OH5L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8869A2F3C1D
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613478; cv=none; b=V9mOxGx4QLPidJBYJ5HfhJtCnnOjgwFNr3oxmT8ZcgZ9lKN9SZAISaVGNYXr4EJyvqDhyg95t4gSjOtmdy/hzlDlCEpOK01xyr40pkjnbdWMknUHUFzlu0cGFH9CXWfDaHAJtLBQ1/g00pj+6FFIQ9mZp9IEotx5QhF/uIfTipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613478; c=relaxed/simple;
	bh=hBvHEPpE3E52q4ia3ivaxcDLoxCcJ+ZbFOsiuD/x+9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ce1JIY9sZkL1c808MYvY4zq2e+t08xi+YuAWXLl9G9hDTK3ogX2f+k36baoKA5PuC6t58UylIBvBFQDsKQic/zYCvYhlxUNtcuWVhLCnU+NTynEhDc8GR67LtsPgZTBJ9xR9tnPnBtOXaqY+XUnaEpAgZyW8HvXbM031pRmpDUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojU1OH5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5C2C19421
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767613478;
	bh=hBvHEPpE3E52q4ia3ivaxcDLoxCcJ+ZbFOsiuD/x+9k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ojU1OH5LjUkO0NRpeq4WVgSjUVtrM0VLEPfCIN0aGY+BGhbYbyYMCsH9tv7g/ug90
	 y/uO3zf7eQ6P5c+VbUT/PMdBGYC0cqGuqVHOsPzQA/lSB0QQiKP15xBBd4FxZ+j6X+
	 MO29nRQQngKpc424pjLkzU1fn9b1AVvxpTckEDaI7I0t2cc5wKzjaifyIU7dA6xB1m
	 wxvdf+gepnE9OG6upINMCt6Z+5/iDxouuWNs1ibQWqkBB6n37TUtWrdGVm75DkDgUu
	 OOVyl0kMp7YuQf/A6zI6/o7NWvaauWD4AaBWeZxaMUOdmhmTkzY8C/pIYykf0FD5Q6
	 4vk3hi+Yne3ow==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b713c7096f9so2211230466b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jan 2026 03:44:38 -0800 (PST)
X-Gm-Message-State: AOJu0Yz8HfNeLii7OaZOhZWOD2RAC2QsEQZqhwzAIzaWAWGO3CYHFIu8
	zJmDSzGXZzhUOKw/g3f8BL3IqZ9crgvC+P9Hskz6U648F/ZtQxZ+rnaEjq7hgqPbcrYy8uyA/D5
	ONBZRaZ+hsyfK2k03rAsQv92Kb9EEK88=
X-Google-Smtp-Source: AGHT+IG9gA7ULl3qVrXBgxbh1YZdQZVLUHMZ6JLZ3iEEnjbjISfBCWvMDxRObm+SzScNPF4PA+fQejwj2jvUku8jOds=
X-Received: by 2002:a17:907:724e:b0:b6d:5bc3:e158 with SMTP id
 a640c23a62f3a-b8036f2ac34mr5291978266b.17.1767613476914; Mon, 05 Jan 2026
 03:44:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7796cd714c563e8990b47899600eb5da17754b91.1766391527.git.wqu@suse.com>
In-Reply-To: <7796cd714c563e8990b47899600eb5da17754b91.1766391527.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 5 Jan 2026 11:43:59 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5orp00gO8QHxZXuckGyJEXeB6Wt6uMoxmv_zL=87h5dg@mail.gmail.com>
X-Gm-Features: AQt7F2r2_LtWL6RubaSpPK_PcJUbwrROiGiQoNLgXFcemd79v5KLLtL_n4TT2Cc
Message-ID: <CAL3q7H5orp00gO8QHxZXuckGyJEXeB6Wt6uMoxmv_zL=87h5dg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: check inlined file extent before accessing members
 after type
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 8:40=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> During the rework of btrfs_file_extent_item, I hit a call site inside
> range_is_hole_in_parent() where I can not find an obvious check on
> btrfs_file_extent_item::type before accessing
> btrfs_file_extent_disk_bytenr().
>
> Do a proper type check before accessing btrfs_file_extent_disk_bytenr().

The change is good, but the subject and changelog could be better.

The subject should be more specific about where and not the why, something =
like:

"btrfs: send: check for inline extents in range_is_hole_in_parent()"

The changelog should mention why we need to do it.

First the detail that you were reworking btrfs_file_extent_item is
totally irrelevant to add to the change log, we don't gain any insight
with that information.
Second, it doesn't explain why we can't access the disk_bytenr of an
inline extent item.

Something like:

"
Before accessing the disk_bytenr field of a file extent item we need
to check if we are dealing with an inline extent.
This is because for inline extents their data starts at the offset of
the disk_bytenr field. So accessing the disk_bytenr
means we are accessing inline data or in case the inline data is less
than 8 bytes we can actually cause an invalid
memory access if this inline extent item is the first item in the leaf
or access metadata from other items.
"

Thanks.

>
> Fixes: 82bfb2e7b645 ("Btrfs: incremental send, fix unnecessary hole write=
s for sparse files")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
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

