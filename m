Return-Path: <linux-btrfs+bounces-17593-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6388BC8EC4
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 13:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA163C8625
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 11:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76AB2E1EF8;
	Thu,  9 Oct 2025 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RagN/0Jh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343652E0909
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760011004; cv=none; b=uBonvZxYjqL+TJ8IqlyFNsVZmnMf8BTbMchJKvKlM+jW4rO+jIPpsRMwV2hE1H8tiM7/CFhfEpjTr/nGp7iWwH/9+LCJw1OQnsbN5r2RaJmObCmlpowN1bE24QmjfqLxA/nzkrZCAfT6LrGUtKVm9+TTe7s/k6u1cPaD1XuBUD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760011004; c=relaxed/simple;
	bh=PjpfKn5Eo76fIGaUMafkE4z9RyMCu03zPcVk/wVvD4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiZeCQ6xdriik4tHo9ub0OHF8v1yz8Az9Pg0PSZ+QRbrNddjog0KqQGOW0/uDpol48a8dbRVozbeNj9u21in3uDo7mw/b4feaO0Qi/WrWwSjvVy0e4iWeF6rv5flbAlmydhrMV/Eo81pbX9xoOkAFCwEwU8l3XFQ7RPMCOcwYbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RagN/0Jh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDF2C4CEF5
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 11:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760011003;
	bh=PjpfKn5Eo76fIGaUMafkE4z9RyMCu03zPcVk/wVvD4Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RagN/0Jhb+rIF0bWDOL2EV9fIo+7oiEkHyw5YqDK/7UKtXOrHdxdaY2Mmxkq1Tfp8
	 kOrdujGV6UsZPKWuAG1eM/cAvfhGJ0G28G76eIFfwUN0cmlqBBtVfCI8XVWNaZgFxb
	 4zWl9iuHgiVAs29LfcD4BNQlCDe8/jW69Rm6g7T4XliMjluPLZO4GR2IqXWhy6zlmp
	 Oldn2ZomNBI0h7w+ur5JpCfKnCh6UMem/pZNweXAAssYsV5N4TDo/LbiIkd6IDfY2L
	 5MCv5HkQIPlfmGshL9c5DJ+Jh5asC+UqZwgPfOdHxZEd8tFTgBuVgYOQi+fPnro6SJ
	 iq5+qdI1I/sBw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3b27b50090so157451166b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Oct 2025 04:56:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YyvDmAEgIdxIABIXgL3/tG0B4Vn+30IqkS/+fUvHK74JoLEQ9FV
	qL0ngFMfoWezWEXKvN5urIxrdtkmUcIA3BqFxZha5k5F2E8/vbzRn2HFpzv0SFIlB2WZyghC7uv
	eHDWZc3XCwITKx3ECmOyPeWMpmS8hEZg=
X-Google-Smtp-Source: AGHT+IH++qO54G5zCaIgX1kfnObXeDXEdoBorZxnDZZJKyxOOllOWMho9gvl6raKAXkyFP1VIYweIHuD/pIq5GPhxb8=
X-Received: by 2002:a17:907:94c3:b0:b3e:d492:d7b8 with SMTP id
 a640c23a62f3a-b50acc1aa45mr634228866b.64.1760011002240; Thu, 09 Oct 2025
 04:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009112814.13942-1-mark@harmstone.com> <20251009112814.13942-10-mark@harmstone.com>
In-Reply-To: <20251009112814.13942-10-mark@harmstone.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 9 Oct 2025 12:56:05 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6k9Uxy_aAN5VV8q9OQFUSiGtX_NhuV8C0TCgUQjAgu8A@mail.gmail.com>
X-Gm-Features: AS18NWARH2fyBq3Wlmo40Wiy2aL4rIrIyo_sXOHtUI-fLUulWQjDYVQK1JRrKVA
Message-ID: <CAL3q7H6k9Uxy_aAN5VV8q9OQFUSiGtX_NhuV8C0TCgUQjAgu8A@mail.gmail.com>
Subject: Re: [PATCH v3 09/17] btrfs: release BG lock before calling btrfs_link_bg_list()
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 12:29=E2=80=AFPM Mark Harmstone <mark@harmstone.com>=
 wrote:
>
> Release block_group->lock before calling btrfs_link_bg_list() in
> btrfs_delete_unused_bgs(), as this was causing lockdep issues.

I believe this was asked before:

What issues?
Do we have for example any other place where we have a different
locking order and can cause a deadlock?

Can you please paste the lockdep splat?

>
> This lock isn't held in any other place that we call btrfs_link_bg_list()=
, as
> the block group lists are manipulated while holding fs_info->unused_bgs_l=
ock.
>
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Fixes: 0497dfba98c0 ("btrfs: codify pattern for adding block_group to bg_=
list")

Also as told before, this doesn't seem related to the rest of the
patchset (the new remap tree feature).
So instead of dragging this along in every new version of the
patchset, can you please make it a standalone patch and remove it from
future versions of the patchset?

Thanks.

> ---
>  fs/btrfs/block-group.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index d3433a5b169f..a3c984f905fc 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1620,6 +1620,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *=
fs_info)
>                 if ((space_info->total_bytes - block_group->length < used=
 &&
>                      block_group->zone_unusable < block_group->length) ||
>                     has_unwritten_metadata(block_group)) {
> +                       spin_unlock(&block_group->lock);
> +
>                         /*
>                          * Add a reference for the list, compensate for t=
he ref
>                          * drop under the "next" label for the
> @@ -1628,7 +1630,6 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *=
fs_info)
>                         btrfs_link_bg_list(block_group, &retry_list);
>
>                         trace_btrfs_skip_unused_block_group(block_group);
> -                       spin_unlock(&block_group->lock);
>                         spin_unlock(&space_info->lock);
>                         up_write(&space_info->groups_sem);
>                         goto next;
> --
> 2.49.1
>
>

