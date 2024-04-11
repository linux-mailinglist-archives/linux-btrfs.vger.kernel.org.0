Return-Path: <linux-btrfs+bounces-4138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D528A0DFD
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 12:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF891C21165
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 10:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB74A145B2C;
	Thu, 11 Apr 2024 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu6hMy0C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129EF1F5FA
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830190; cv=none; b=PWqKeKjSx0RS/Da3y5fIcCbROeLuvu0az5KTVbXxiCSif15qfsJNqHKQKfcjxBq0z9ZEudIB10gfxzz098vOf4R0sBrpj1Q91yUbqMI1zeM2SPeLKqOxlFPEQR1w3csUQMslggdoEOBVDF99As9IPHqvWKuXQDpLbFc/D+teVX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830190; c=relaxed/simple;
	bh=gXN2uhsUEqlYxASP2z/3J0jOKs/859j3GfhVHg0+Hkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlrFeFK4FOOO8oqLQ5luxeot/dAJ75iVBH65cBy1SIBqJd7eK8ODkFWQieq8mubom/bnqxQCloVOCk6VKHPez/phrNzz3o0ZR3BTOa+EdtvRWmSRfIDTwX+SJ1Ue2Qw+trW3oqqxvkVGTauXtKbe5xB3j6yC/qkWo6OLjGK/x+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cu6hMy0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D141AC43390
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 10:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712830189;
	bh=gXN2uhsUEqlYxASP2z/3J0jOKs/859j3GfhVHg0+Hkw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Cu6hMy0CirrC+2YH60XBgX2TaCp45lW3e6hFsfpQns2G15HQqHEyH4AgAX9wX1XHZ
	 /QxRKbf3EchY9YfZXqLLkru5mmN4GB3bdfKq+/G8I29pFyPKPP0N465tewJi88aiGu
	 b2+4lxGe2VGp/sp0/2EguIIfMiqv1m7LO3wRlhcq4zJ60mQo7kKu++jcNd5FvJu+4p
	 2O/LAUf7MbLsZdZZHrheV2Ze7rDA4D52uvAQegxrGrrMae4gq/bALH/eCR4dREdU77
	 cdZFwcJVBfkotTP7SZCcm+olcAE6hlRkhMdQHJse4UCQiIdtGHz56PQm3D2k0nOaaz
	 QfFm9bc0xIuKg==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e6646d78bso4526363a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 03:09:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YyS/nLfQY54RgsCKzrVLY8pduNJwl2qFVVIFSkGxGgBhTFjmivo
	f/tH19i5+9SYN6rXEoUlBlXavRV1iKXvsE8mJhlSwdP6dSj/8lOHWYFa/d+Vb/NnT2Ok6t3FJAU
	hBL+kbr+GUMu6QmWH4zjrIMtVu5M=
X-Google-Smtp-Source: AGHT+IGxKAWH4zVtL1q6dVCYM+cqZu9VqUddHJgXNTJvubhlg/BOhxvbYc1gn/pmR6EMD8E9wtcvQV0cuFm0zmaTVOI=
X-Received: by 2002:a17:906:e94b:b0:a51:bee2:2f3c with SMTP id
 jw11-20020a170906e94b00b00a51bee22f3cmr3183989ejb.18.1712830188403; Thu, 11
 Apr 2024 03:09:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712748143.git.fdmanana@suse.com> <0f1a834bcb67f4c57885706b54e19d22e64b9ce7.1712748143.git.fdmanana@suse.com>
 <4ff14e1a-964b-45e0-885f-1e86386c7924@gmx.com>
In-Reply-To: <4ff14e1a-964b-45e0-885f-1e86386c7924@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 11 Apr 2024 11:09:11 +0100
X-Gmail-Original-Message-ID: <CAL3q7H53UG1_EJrCsau1mwyn0mO7G4YeLqqzPSFGv-q_DD3HMQ@mail.gmail.com>
Message-ID: <CAL3q7H53UG1_EJrCsau1mwyn0mO7G4YeLqqzPSFGv-q_DD3HMQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] btrfs: add a global per cpu counter to track number
 of used extent maps
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 6:39=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/4/10 20:58, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Add a per cpu counter that tracks the total number of extent maps that =
are
> > in extent trees of inodes that belong to fs trees. This is going to be
> > used in an upcoming change that adds a shrinker for extent maps. Only
> > extent maps for fs trees are considered, because for special trees such=
 as
> > the data relocation tree we don't want to evict their extent maps which
> > are critical for the relocation to work, and since those are limited, i=
t's
> > not a concern to have them in memory during the relocation of a block
> > group. Another case are extent maps for free space cache inodes, which
> > must always remain in memory, but those are limited (there's only one p=
er
> > free space cache inode, which means one per block group).
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> [...]
> > --- a/fs/btrfs/extent_map.c
> > +++ b/fs/btrfs/extent_map.c
> > @@ -76,6 +76,14 @@ static u64 range_end(u64 start, u64 len)
> >       return start + len;
> >   }
> >
> > +static void dec_evictable_extent_maps(struct btrfs_inode *inode)
> > +{
> > +     struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> > +
> > +     if (!btrfs_is_testing(fs_info) && is_fstree(btrfs_root_id(inode->=
root)))
> > +             percpu_counter_dec(&fs_info->evictable_extent_maps);
> > +}
> > +
> >   static int tree_insert(struct rb_root_cached *root, struct extent_map=
 *em)
> >   {
> >       struct rb_node **p =3D &root->rb_root.rb_node;
> > @@ -223,8 +231,9 @@ static bool mergeable_maps(const struct extent_map =
*prev, const struct extent_ma
> >       return next->block_start =3D=3D prev->block_start;
> >   }
> >
> > -static void try_merge_map(struct extent_map_tree *tree, struct extent_=
map *em)
> > +static void try_merge_map(struct btrfs_inode *inode, struct extent_map=
 *em)
>
> Maybe it would be a little easier to read if the extent_map_tree to
> btrfs_inode conversion happens in a dedicated patch, just like all the
> previous ones?

Sure, I can do that. But it's such a small and trivial change that I
didn't think it would make review harder, even because the patch is
very small.

>
> Otherwise the introduction of the per-cpu counter looks good to me.
>
> Thanks,
> Qu

