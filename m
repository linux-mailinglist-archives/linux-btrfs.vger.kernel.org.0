Return-Path: <linux-btrfs+bounces-10751-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672EEA02BA0
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 16:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54673A7BCC
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED051D934B;
	Mon,  6 Jan 2025 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDJN3KhQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C82155352
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178241; cv=none; b=CFU76y/n2a3FTWeGU2ZmSQVXFpM3tBQYI7X1LCg9J35JJ8jIWXlf8P4+kASdW/eNjeyzH1Ut21X0BeHUAToA3O/GSMVDtMlMs4MQXBzDXt6591NOHKwFQbaRhg9BI/+Skkk713YhlaXmsQMy2+KRnQATfNT1Qkocq0iFSbMIR/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178241; c=relaxed/simple;
	bh=wPGM5S5uz2nIaKFLaok7L8Qn+kQnyl0rVsgxEFYbw1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RautcZ05PGp65IJDTU+XbBzx8DnTeuRFJRxTXNLe4jJOrUejI7omHlM2KVNa9vIKLgsph1NYW+gLtzf0OSO6bxzkABvG9fGiITr9rEXVJmFMLvPK6JPleZXTPQA4Bnt6U22+F5Efz4C0UNF89b54EpV9T3NwjbZC1BSiJqmRy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDJN3KhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DCFC4CEE2
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 15:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736178241;
	bh=wPGM5S5uz2nIaKFLaok7L8Qn+kQnyl0rVsgxEFYbw1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BDJN3KhQaYn2FakecRYJKmriej2K2eNzmXrYKbMK7YpU3u94iJb+Pe/+1JYZ363J4
	 K5QBlB5F2/sdXC2z51edm3fud2QBsfn8TfbhOKgcJTLQ9+8lUFjOrPIUty6xgvtX0Q
	 EM292aUaGaxoXIqVj0OafJgkgFSjuVYE7CD4sO7U6kqaclycnDuQk8J8gTwB5TNNn3
	 Mcr/6yEJsdzx32YC1UxPUB7m74/BTPwOQd6zG3UpVOM4dPJcLgetUxe+9PD1TSEPsk
	 tHEtbe75usZBTJaLcjiU9jskz6JIuyH4LxpBoKouzcyRwjQAqrC1w8GgThUHzmpWf5
	 xQyE0EuyoQnqQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaeecbb7309so89439966b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2025 07:44:01 -0800 (PST)
X-Gm-Message-State: AOJu0YxCdEwSF9aORn/PxmsmCiM9ps3xL3TQHjeKufNrf/xu/yAwoez9
	F4wo9KZr47hlvhRgiOnbPKM19xChLNW+oPs+RtprI4QD/36pFu5x4hUTejA4HkIuB9oi/HJ44VW
	79VSkoCleeuYQUcU6MnDgWjwUdnM=
X-Google-Smtp-Source: AGHT+IGMkLu3VkF2hVdlwil6aif2j+iBQbk5+uV1NzLbh3qSUrSM0FAhP3M9tLdLkr1HvU7xjyNDaiMawafgYwOeJ5U=
X-Received: by 2002:a17:907:944f:b0:aac:439:10ce with SMTP id
 a640c23a62f3a-aac2ba3c11amr6518458266b.27.1736178239626; Mon, 06 Jan 2025
 07:43:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734527445.git.fdmanana@suse.com> <20241223200859.GN31418@twin.jikos.cz>
 <CAL3q7H4vqj-u+NdkiRgc+PNjFbhkRgm_ECHGyGD=CjRgTLKOdw@mail.gmail.com> <20250106141924.GW31418@twin.jikos.cz>
In-Reply-To: <20250106141924.GW31418@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 6 Jan 2025 15:43:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6H1RYSsxZkADxcAaf8XFRb8o_LA=dKiC+KVsfjJH20cw@mail.gmail.com>
Message-ID: <CAL3q7H6H1RYSsxZkADxcAaf8XFRb8o_LA=dKiC+KVsfjJH20cw@mail.gmail.com>
Subject: Re: [PATCH 00/20] btrfs: remove plenty of redundant
 btrfs_mark_buffer_dirty() calls
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 2:19=E2=80=AFPM David Sterba <dsterba@suse.cz> wrote=
:
>
> On Mon, Jan 06, 2025 at 10:54:05AM +0000, Filipe Manana wrote:
> > On Mon, Dec 23, 2024 at 8:09=E2=80=AFPM David Sterba <dsterba@suse.cz> =
wrote:
> > >
> > > On Wed, Dec 18, 2024 at 05:06:27PM +0000, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > There's quite a lot of places calling btrfs_mark_buffer_dirty() whe=
n it
> > > > is not necessary because we already have a path setup for writing, =
due
> > > > to calls to btrfs_search_slot() with a 'cow' argument having a valu=
e of 1
> > > > or anything that calls btrfs_search_slot() that way (and it's obvio=
us
> > > > from the context). These make the code more verbose, add some overh=
ead
> > > > and increase the module's text size unnecessarily. This patchset re=
moves
> > > > such unnecessary calls. Often people keep adding them because they =
copy
> > > > the approach done from such places.
> > >
> > > I've read the explict calls to btrfs_mark_buffer_dirty() as source-le=
vel
> > > marker of the section pairing btrfs_search_slot(). There are also som=
e
> > > assertions and eb state checks that were done in set_extent_buffer_di=
rty(),
> > > now we're losing them.
> >
> > No, we aren't losing the assertions.
> > We've done them inside ctree.c, where we have already called
> > btrfs_mark_buffer_dirty() (which calls set_extent_buffer_dirty()).
>
> What I mean that we would be doing the assertions again, after some
> lines of code since the last call to btrfs_mark_buffer_dirty() from
> ctree.c.
>
> > > While the code gets reduced and the calls may be redundant for some
> > > reasons I think we should keep something at least to do the assertion=
s,
> > > or eventually optimize btrfs_mark_buffer_dirty() to be faster if the
> > > path is set up by the search slot with cow=3D1.
> >
> > This isn't just about optimization.
> > It's about simplifying usage of btree modification calls to users
> > outside ctree.c and having cleaner APIs.
> >
> > In some places outside ctree.c we (unnecessarily) call
> > btrfs_mark_buffer_dirty(), while for others we don't.
> > Probably in the very early days it was needed for some reason, but
> > that's not the case anymore and we call btrfs_mark_buffer_dirty()
> > every time we COW or allocate a new block as part of a node/leaf split
> > in ctree.c.
> >
> > Keeping these redundant calls is like saying we don't trust what
> > ctree.c does. Marking a new extent buffer dirty is a clear
> > responsibility of ctree.c.
>
> I would not interpret is as distrust in the ctree.c code but rather as
> an additional verification like we do elsewhere. Schematically
>
> caller - start a new change in eb, call the API
> ctree.c - create new eb
> ctree.c - call btrfs_mark_buffer_dirty()
> caller - do more changes, anything until the path is released etc
> caller - (removed in the series) call btrfs_mark_buffer_dirty(), now
>          performing transid assertion checks,
>          in set_extent_buffer_dirty():
>          - check_buffer_tree_ref()
>          - a few WARN_ONs checking state bits
>          - folio dirty bit checks
>
> From functional POV removing btrfs_mark_buffer_dirty() is ok, but we may
> still want to add a simple helper that verifies similar things as
> before. With assertions it happens that the checks are redundant.

Well yes, but this is still odd.

The ctree.c call returned a path with a write locked leaf - so none of
the checks should ever fail after the btrfs_mark_buffer_dirty() call
made by ctree.c
If we don't trust that, following that reasoning, it's the same as
making every caller also assert that the leaf is write locked (and we
don't do that).

> But feel free to add the series to for-next. The additional verification
> would need a separate pass, examine the code locations and pick the
> right checks.

