Return-Path: <linux-btrfs+bounces-10487-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041F49F5034
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 17:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2B367A3F7B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520BA1F8929;
	Tue, 17 Dec 2024 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHcfeLEd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EBB1F890C
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450391; cv=none; b=QoN23WUgwDfuGSt7S96zBQw+e90XnVRZEXGnB9N65U+/6ivCngmzIW4gxOndtqZSP+nd86SAY0Ltgydtn1KIJvrOZTBFPH4/UK6KSD3gMwvf/x944YJZJSmxDFcih2LkvXGV/QKw0XaQ0SWDe8Onz5R547vRbv3yv/zaevET+k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450391; c=relaxed/simple;
	bh=dN9bNRBhB5/NFo7jfm9vy4vTKgLRrj6iujGOKhVs4ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y840oOKpFSdAeQRAJNjGOUtOrJteEITl1G9SB8j951oZaubEP7C4Fxyo0Lsfo9HxNS204jxbaiZKeiUdaEaecjLIBG3KHRt5vFMzPOLadIiRKkV9o+Jgi+Q5iz1rFXhAbcPyW0kJH+C3eKPNdB61VFOz/LO1+yGCx1VNnrtfoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHcfeLEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3276C4CEE2
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734450390;
	bh=dN9bNRBhB5/NFo7jfm9vy4vTKgLRrj6iujGOKhVs4ls=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EHcfeLEdsi7SL/BkXGE8nX6gT86YKBUjcjNqpUqhhcI9ytffJDAtU5kMW3tmraWJf
	 Xvk9SS4At4fMdIWaxYusMMOwFDEsPif9iz4seQ0Bt7V71vIRwcsuERCIZfH0X/0a5B
	 vkoIE9w9DO6qEr1xBZaiVJH/jxgtMIFouUe1FlFjoRyqxFPDVnlAWLjWiF2hGNhoM0
	 uJi9cj2+Xbs/4JE1yS4kBDbNXQHVXWt3yfX54VnW2yLKeaVqsD9RJHARok3lHvPEcp
	 GEhiax5xLZPnJerRNfUyQQLtqQ0zsaaE909q9xRusD8IXnfRjnhSquLQtVU0fZjZVi
	 LZQGGDE5+xPxA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa6a618981eso886025166b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 07:46:30 -0800 (PST)
X-Gm-Message-State: AOJu0YyaZNukfI0cCcqWeEt+tWFMyAWjxQlK8JI2h91YN5gWeh2ODr9v
	GOZPuhc0NbJVUq94NHT8qIqdx2F5Nx+Ft7xCZ4MCecKWbG1sQpHIQ6VSjrfZAW3vRN0Gb1DkGcM
	o+TQ7ESaxD4VzaS0J2cYQO/94CZw=
X-Google-Smtp-Source: AGHT+IEhQUmsYBZ68wJnoGCobIJKhv74B8HRG0/35Qb4IQ6zZyPI8NLvMrg6ys7j0CndcyC4k1f/2sTcQVXxJsnp5fY=
X-Received: by 2002:a17:906:c102:b0:aa6:6885:e2f6 with SMTP id
 a640c23a62f3a-aab779b7968mr1763508466b.36.1734450389473; Tue, 17 Dec 2024
 07:46:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733989299.git.jth@kernel.org> <93790ce532e9e18fba57268a6230ec312ca38360.1733989299.git.jth@kernel.org>
In-Reply-To: <93790ce532e9e18fba57268a6230ec312ca38360.1733989299.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 15:45:52 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6jH_eRj-ksqd2-cgwHmFEex7BfBJAZ8PdGw5Bg-7pfHQ@mail.gmail.com>
Message-ID: <CAL3q7H6jH_eRj-ksqd2-cgwHmFEex7BfBJAZ8PdGw5Bg-7pfHQ@mail.gmail.com>
Subject: Re: [PATCH 05/14] btrfs: fix tail delete of RAID stripe-extents
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 7:56=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Fix tail delete of RAID stripe-extents, if there is a range to be deleted
> as well after the tail delete of the extent.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 092e24e1de32..6246ab4c1a21 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -121,11 +121,18 @@ int btrfs_delete_raid_extent(struct btrfs_trans_han=
dle *trans, u64 start, u64 le
>                  * length to the new size and then re-insert the item.
>                  */
>                 if (found_start < start) {
> -                       u64 diff =3D start - found_start;
> +                       u64 diff_start =3D start - found_start;
>
>                         btrfs_partially_delete_raid_extent(trans, path, &=
key,
> -                                                          diff, 0);
> -                       break;
> +                                                          diff_start, 0)=
;
> +
> +                       start +=3D (key.offset - diff_start);
> +                       length -=3D (key.offset - diff_start);

So this can underflow in case the item we found covers a range that
spans 'end', that is in case found_end > end.

For example if the length argument was originally 1M, the item has a
found_start < start, diff_start is 512K and item's offset is 2M, in
which case we get:

length -=3D 2M - 512K
length -=3D 1.5M
1M -=3D 1.5M
-512K

So it should be:

start +=3D min(found_end, end) - start;
length +=3D min(found_end, end) - start;

But in this case we would also need to split the item into two, as
we're "punching a hole".
Or is this an impossible case, to have a single stripe extent with
found_start < start and found_end > end?

Thanks.


> +                       if (length =3D=3D 0)
> +                               break;
> +
> +                       btrfs_release_path(path);
> +                       continue;
>                 }
>
>                 /*
> --
> 2.43.0
>
>

