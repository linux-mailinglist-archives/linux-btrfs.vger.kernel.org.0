Return-Path: <linux-btrfs+bounces-10483-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9139F4EA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 15:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A611162988
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 14:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367DD1F75A5;
	Tue, 17 Dec 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZV5eo10j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CC1F4735
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447408; cv=none; b=Jektw5L46C4rAlhuL4raIoEOrDxO6RNMjsBVif/0qiCyZopS1FrwfxvI8kke0CplnsN0O5awvx9qu2Hknsv8FDh4HyfcLern8N2G4kTJ4MdJosRXPBzWYqy5jA8LwUl3KP33btGpJgnFpDHQgjbFtq7PUhy8o3wvCIUvHglpdcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447408; c=relaxed/simple;
	bh=TufOXkWlyhbHNXbpShWdb/H5U1AcmPgEMTRBshGiHx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+gbPK8f61+MQzBvC57qL2QTOYsgoBMr4KY8B200cbNOqRlTGWgZ4me9FpHzhQy+EPFmJUWrO/0tr9p/ipSbZeB0kvQg7eDzSOsFEHCOoP1JL33QAbnIACdNmn+y5HphKeaVWYpJBzJcXzDuNW0z+yvOe2IhMdp8NAUIlLawGU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZV5eo10j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2833C4AF09
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734447407;
	bh=TufOXkWlyhbHNXbpShWdb/H5U1AcmPgEMTRBshGiHx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZV5eo10j1nViBZi6Fa0VbEGKRjqfXbh9U3JOe1cLCcX7NbAqQw7lfrU7zScS8o6bt
	 t1eaQ+c22b0ctJQzgv+YssmODeiAOV721aHCafAL7zeVD5X59djqQitvVkr4ZCsIPU
	 sR5OKDwjIzbx/wSmfepkt7VWZC5qE2lZgIxA734dsYvSgonnn17rUp/7RhOctI6cpE
	 dLmwZyR7uvqsRoLtA8ns00VtKbMYIZdshH7+FzkIE5SXLStSlcHqf0H8059/drmJwF
	 aTeQ52gJtpgtH9hghxGifnptCUfxR+audzJq7wKL5Vtkvk3AwaNB73K046mGtU5IgC
	 Z6pENXQDQGm0A==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa69107179cso1005524766b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 06:56:47 -0800 (PST)
X-Gm-Message-State: AOJu0Yztn4UOfUebUvsv3+9GgJVhy+cVygUshPF70jfX3xZdrBIEYgho
	Lg0lkS0LLkPfw/Gpqz6zd+/Su+1VnDib66Hp0HUMsqP8eGnxNcun1ASi+es8fKeAiGoM+bny0Ep
	AsQlQwvfjtcqqGSIGCwzJEhcqWyU=
X-Google-Smtp-Source: AGHT+IERjPuw69MlWdHW6ijzEbRed6gvdkD6+daau7vpgG5j7X4KCZIcNQdorrgIvN6ZFGTKGPFRx6zL/0yTubddbzs=
X-Received: by 2002:a17:907:2d12:b0:aa6:a05c:b068 with SMTP id
 a640c23a62f3a-aab77ed3314mr1425000666b.56.1734447406357; Tue, 17 Dec 2024
 06:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733989299.git.jth@kernel.org> <29bc20b873dca2bf2e44af4b13ffb85c28d7b3de.1733989299.git.jth@kernel.org>
In-Reply-To: <29bc20b873dca2bf2e44af4b13ffb85c28d7b3de.1733989299.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 14:56:09 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4fk2QmZkjaZGneC=3+HM9bBzF-NE=phseWPcm4Cr4j7A@mail.gmail.com>
Message-ID: <CAL3q7H4fk2QmZkjaZGneC=3+HM9bBzF-NE=phseWPcm4Cr4j7A@mail.gmail.com>
Subject: Re: [PATCH 03/14] btrfs: fix search when deleting a RAID stripe-extent
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
> When searching for a RAID stripe-extent for deletion, use an offset of -1
> to always get the "left" slot in the btree and correctly handle the slot
> selection.

Can you elaborate?

It's not clear from this very brief change log what the problem is, or
if there's actually a problem.

Is this a bug, and what are the consequences? Are we missing stripe
extent items and causing some corruption or just unnecessary items?

Or is it just an optimization?

>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index d341fc2a8a4f..d6f7d7d60e76 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -81,14 +81,18 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handl=
e *trans, u64 start, u64 le
>         while (1) {
>                 key.objectid =3D start;
>                 key.type =3D BTRFS_RAID_STRIPE_KEY;
> -               key.offset =3D 0;
> +               key.offset =3D (u64)-1;

On a first glance, having the 0 seems to be what leaves us at what you
mention in the change log as "the most left slot" and not -1.

For example if there's an item with key (X BTRFS_RAID_STRIPE_KEY 1M)
and the input arguments are start =3D=3D X and length =3D=3D 1M,
doing the search with offset 0 leaves at that exact slot where the
item is, but with an offset of (u64)-1 it leaves us on the next slot.

So please provide an example leaf layout and an example range passed
to btrfs_delete_raid_extent() that results in a bug or non-optimal
behaviour, or whatever is the problem you found.

Thanks.

>
>                 ret =3D btrfs_search_slot(trans, stripe_root, &key, path,=
 -1, 1);
>                 if (ret < 0)
>                         break;
>
> -               if (path->slots[0] =3D=3D btrfs_header_nritems(path->node=
s[0]))
> -                       path->slots[0]--;
> +               if (ret =3D=3D 1) {
> +                       ret =3D 0;
> +                       if (path->slots[0] =3D=3D
> +                           btrfs_header_nritems(path->nodes[0]))
> +                               path->slots[0]--;
> +               }
>
>                 leaf =3D path->nodes[0];
>                 slot =3D path->slots[0];
> --
> 2.43.0
>
>

