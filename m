Return-Path: <linux-btrfs+bounces-4023-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C88B289BDD6
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 13:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C86C282485
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 11:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E904651A1;
	Mon,  8 Apr 2024 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXaNHlp9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99EA45958
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574743; cv=none; b=mRJ/eS75WJ4jbfMDVPdcxpE42hhQiT/q/p1OhL2xdWYzoTfMhU4A/xuMQsC1/hVugvfyiqgR9gZIvBXpcfYIBk1kZul820BUCSmmVzjKVWj5e/RJgkwaKy7qaQNayGitG7wZVm5XRY0hl+b07QNCVYtfX5+ulb7wwQoUqEnJzvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574743; c=relaxed/simple;
	bh=E4j8VlYdKGbPxfLu8TzKrd+5wZu2tHuBdh76w/xE6d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgpmBKJ5GKjkImTJOk/+bRRx5AZH5h17fv2EyCpDXTPUj8U/whCz6iziTBU92odL+X+fiYjNTskhqKajocjRGixyLQHLCBprZrHySzj7G+WFTyVQo0Ww2VfojFlJfevSwQ09Dd76BU54L2vASBS2cFHnirftiYe3TnFkyN1fJXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXaNHlp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57167C43390
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 11:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712574743;
	bh=E4j8VlYdKGbPxfLu8TzKrd+5wZu2tHuBdh76w/xE6d4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OXaNHlp9RwSnkHcUDOIiey63m3owcBrPNbue0k1y+CQ2mRazBmA6kfTH4ZCcnifGd
	 cD810QMeJLkKHxtgJUbHpvIx583hmJmJfpRHNvCzIg9eKv45EW/CbCvicAjJ7hFY1g
	 Gr7fhgPKZit8TSjdpLkaKHtnBRLrVLgWvR6mYjc47LKKxoClABBf7ol6qrFjAG3Yxr
	 Vx5ty56FTiH54ZqUjYQgr56P+sIz9P0ZrHMiSwKju9Qb27zoIAJEdniZW9B+G3P7we
	 d62xgqj3ChLJOSX5SWklv5SmWSy8vnHyAZZLuCPclvjpWuToXEOpkl8pUV5l5TnwEr
	 yjfdiSpBD7NBQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a51b008b3aeso255699266b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Apr 2024 04:12:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwmE+3rIVI5aBkxJ/Uxn+pJuDEsNSSOQdKaRO4AdULeDGaxxbLgkdbsgIT/Ey/ZyHL2qJL9Zr//n/0/L8KRzPLhxMA5S1iR04PNAU=
X-Gm-Message-State: AOJu0YwdM5g3kAkhP97o5A5mR3TvbR6ow+273kn1evJzG8cIbRu7RYAD
	Huj+3UBlVc5gL4EVFIiQ68fBiu4hvpRMiWDBT+k4sTURkDxrEHDX9reaagA0rH7uwiqv3cypqzK
	uqM3zqb4SVJGovIfYTloHVjjBhWY=
X-Google-Smtp-Source: AGHT+IG4aM7jFdvMNzwznpZ2c8bQSpf7J6lrb/Hr87e/4mPjunCrMn7DKWN1qwvadOyYgUOrqzfA8bA6muKvUQBA5MU=
X-Received: by 2002:a17:906:70e:b0:a4e:9970:aee7 with SMTP id
 y14-20020a170906070e00b00a4e9970aee7mr5773040ejb.50.1712574741855; Mon, 08
 Apr 2024 04:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712287421.git.wqu@suse.com> <261cf7744120a2312ce2cdb22dbbfe439a11268a.1712287421.git.wqu@suse.com>
 <CAL3q7H5-2gfkd7xjy9QVrtgDZGv34jhQrTTtuNL8Qs08rNimrA@mail.gmail.com> <bbc9acb4-a8a3-4fde-9e55-6b49a009dc00@gmx.com>
In-Reply-To: <bbc9acb4-a8a3-4fde-9e55-6b49a009dc00@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 8 Apr 2024 12:11:45 +0100
X-Gmail-Original-Message-ID: <CAL3q7H41R98aw5V=sOw8VedObDJL3XaqWkRNcOD73hLdjUf-=Q@mail.gmail.com>
Message-ID: <CAL3q7H41R98aw5V=sOw8VedObDJL3XaqWkRNcOD73hLdjUf-=Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] btrfs: add extra comments on extent_map members
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 10:36=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/4/5 22:54, Filipe Manana =E5=86=99=E9=81=93:
> > On Fri, Apr 5, 2024 at 4:28=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> The extent_map structure is very critical to btrfs, as it is involved
> >> for both read and write paths.
> >>
> >> Unfortunately the structure is not properly explained, making it prett=
y
> >> hard to understand nor to do further improvement.
> >>
> >> This patch adds extra comments explaining the major members based on
> >> my code reading.
> >> Hopefully we can find more members to cleanup in the future.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/extent_map.h | 52 +++++++++++++++++++++++++++++++++++++++++=
+-
> >>   1 file changed, 51 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> >> index 10e9491865c9..0b938e12cc78 100644
> >> --- a/fs/btrfs/extent_map.h
> >> +++ b/fs/btrfs/extent_map.h
> >> @@ -35,19 +35,69 @@ enum {
> >>   };
> >>
> >>   /*
> >> + * This structure represents file extents and holes.
> >
> > So I clearly forgot this before, but we should add the caveat that
> > it's guaranteed that it represents a single file extent only if the
> > extent is new and not persisted (in the list of modified extents and
> > not fsynced).
> > Otherwise it can represent 2 or more extents that were merged (to save
> > memory), which adds some caveats I mention below.
>
> In fact I also wanted to address this, especially if I'm going to
> introduce disk_bytenr/disk_num_bytes, as they can be merged, the merged
> disk_bytenr/disk_num_bytes would not exist on-disk.
>
> But on the other hand, it's a little too obvious, thus I didn't mention
> through the whole series.

Well, a lot of the comments this patch is adding are too obvious as well.
So I don't see why mentioning an extent map may represent merged
extents is too obvious, if anything, it's less obvious than the
comments for some of the fields the patch is adding.

>
> >
> > Holes can also be merged of course (e.g. read part of a hole, we
> > create an extent map for that part, read the remainder of the hole,
> > create another extent map for that remainder, which then merges with
> > the former).
> >
> [...]
> >> +
> >> +       /*
> >> +        * The full on-disk extent length, matching
> >> +        * btrfs_file_extent_item::disk_num_bytes.
> >> +        */
> >
> > So yes and no.
> > When merging extent maps, it's not updated, so it's tricky.
>
> And that's already found in my sanity checks.
>
> > But that's ok because an extent map only needs to represent exactly
> > one file extent item if it's new and was not fsynced yet.
>
> I can update the comments to add extra comments on merged behavior, and
> fix the unexpected handling for merging/split.

Fix what?
It's only important to be accurate for extents that need to be logged
(in the modified list of extents), and those are never merged or
split.

Otherwise it doesn't affect use cases other than fsync.

>
> >
> >>          u64 orig_block_len;
> >> +
> >> +       /*
> >> +        * The decompressed size of the whole on-disk extent, matching
> >> +        * btrfs_file_extent_item::ram_bytes.
> >> +        */
> >>          u64 ram_bytes;
> >
> > Same here regarding the merging.
> >
> > Sorry I forgot this before.
>
> No big deal, as my super strict sanity checks are crashing everywhere, I
> have already experienced this quirk.
>
> So I would add extra comments on the merging behaviors, but I'm afraid
> since the current code doesn't handle certain members correctly (and a
> lot of callers even do not populate things like ram_bytes), I'm afraid
> those extra comments would only come after I fixed all of them.

Well, as mentioned before it's ok for some fields to not be updated
after merging, and to a lesser extent, splitted.
Having all fields correct only makes sense when the mapping to a file
extent item is exactly 1 to 1 and the extent is new and needs to be
logged.

>
> Thanks,
> Qu

