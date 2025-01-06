Return-Path: <linux-btrfs+bounces-10733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C553AA02381
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 11:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E4307A191A
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 10:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8481DC18F;
	Mon,  6 Jan 2025 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTp1Cle7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC71D8E06
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736160883; cv=none; b=n5GLv+IJzXyhqB536C3rp3dycAfdDspocWMY0K2U/dnv0AOfLIxrSmJ58cwkyBqKCkf6AL06gMt62Ks45HLiKrWHrBr/iTf8jnPlC2soFTvit2EaK6svinGa7LWO1zE3t+rplmdzHviqrBhN7cgGc+ifEYHs3WsvxRJCnnivP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736160883; c=relaxed/simple;
	bh=IQ4jvmVos7tWBD83vGo3/ADIR1THcm1uAI1NPPvmFyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9M6AAEVd7IfUDqNvCFXWXLcbDrVHVmTk3xXn8e42lleTb/7biRkQPDVKqk1ErKaoCNyCW472f8jN4UQYMjoBqIeuYIYSjL0Ut2P40MHKZcZNYI+1IKbWrTaNPuvsjabjH3oYFjnOWFGjaFmYt1wo4J76bZfiDoB5sMMJv5D5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTp1Cle7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB2FC4CEDD
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736160883;
	bh=IQ4jvmVos7tWBD83vGo3/ADIR1THcm1uAI1NPPvmFyk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LTp1Cle7k2crw/8lO/aG9uQiVI/F2h7s09e/AwMrg47JLK41rVQ6daursc9lN2mqD
	 jY/pEogZL1Zd+6SFTVmN73Qevl/aSpKn0kzvQmVuJeFHYGXU7KbyyGQH7dVcxLxAhe
	 8KVV9VrCdJXsYM3L8YKwHjcNMOwznHc5Rtgp0UrHxZqs9YRnbtMMHgXt0qmijqq7Tz
	 BNheQ37KEpbAcIgOhLQMGCNMxNh5CND23LKI5wAqDfO0F99EBr5Ted5nY7AE4s9gbM
	 Oz1VIZG/TJBPDWkiCY2UhS2Q6wdGYWsim/oq3gmVfJNfF/yPGIq8INVGmk2XZ5nV0I
	 9whfPgpzgMGuQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa67ac42819so2042986766b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2025 02:54:43 -0800 (PST)
X-Gm-Message-State: AOJu0YwfMzxdtTskorWG0o8cvri8onSVDJqofAGE+geBVNOanHF/egSi
	+oYn7q1TpM3OWM2KlUA28/yqEwTd7iG9QCq+HAuCqrb2xtarQTXTp3//uqaJb4fu/FjT1bvKlVm
	nM6D0Xfjw9pHEGY8rupeey0DtvHU=
X-Google-Smtp-Source: AGHT+IEaV7Z1Uk7wVB53nT3aB4WiWd437g8oqOTSyC4vx2vPvFr0qLE2/QuYnALFbotG9WLLqeG8uHrPEsfqkIyP4Os=
X-Received: by 2002:a17:907:c816:b0:aaf:f32:cd34 with SMTP id
 a640c23a62f3a-aaf0f32d0afmr4134370866b.15.1736160882031; Mon, 06 Jan 2025
 02:54:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734527445.git.fdmanana@suse.com> <20241223200859.GN31418@twin.jikos.cz>
In-Reply-To: <20241223200859.GN31418@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 6 Jan 2025 10:54:05 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4vqj-u+NdkiRgc+PNjFbhkRgm_ECHGyGD=CjRgTLKOdw@mail.gmail.com>
Message-ID: <CAL3q7H4vqj-u+NdkiRgc+PNjFbhkRgm_ECHGyGD=CjRgTLKOdw@mail.gmail.com>
Subject: Re: [PATCH 00/20] btrfs: remove plenty of redundant
 btrfs_mark_buffer_dirty() calls
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 8:09=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Wed, Dec 18, 2024 at 05:06:27PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > There's quite a lot of places calling btrfs_mark_buffer_dirty() when it
> > is not necessary because we already have a path setup for writing, due
> > to calls to btrfs_search_slot() with a 'cow' argument having a value of=
 1
> > or anything that calls btrfs_search_slot() that way (and it's obvious
> > from the context). These make the code more verbose, add some overhead
> > and increase the module's text size unnecessarily. This patchset remove=
s
> > such unnecessary calls. Often people keep adding them because they copy
> > the approach done from such places.
>
> I've read the explict calls to btrfs_mark_buffer_dirty() as source-level
> marker of the section pairing btrfs_search_slot(). There are also some
> assertions and eb state checks that were done in set_extent_buffer_dirty(=
),
> now we're losing them.

No, we aren't losing the assertions.
We've done them inside ctree.c, where we have already called
btrfs_mark_buffer_dirty() (which calls set_extent_buffer_dirty()).

>
> While the code gets reduced and the calls may be redundant for some
> reasons I think we should keep something at least to do the assertions,
> or eventually optimize btrfs_mark_buffer_dirty() to be faster if the
> path is set up by the search slot with cow=3D1.

This isn't just about optimization.
It's about simplifying usage of btree modification calls to users
outside ctree.c and having cleaner APIs.

In some places outside ctree.c we (unnecessarily) call
btrfs_mark_buffer_dirty(), while for others we don't.
Probably in the very early days it was needed for some reason, but
that's not the case anymore and we call btrfs_mark_buffer_dirty()
every time we COW or allocate a new block as part of a node/leaf split
in ctree.c.

Keeping these redundant calls is like saying we don't trust what
ctree.c does. Marking a new extent buffer dirty is a clear
responsibility of ctree.c.

