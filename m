Return-Path: <linux-btrfs+bounces-16935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6031EB85701
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 17:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD91A1665B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 15:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCCA1DB92A;
	Thu, 18 Sep 2025 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+Jcrtxa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7532D19DF4F
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207868; cv=none; b=a3tP/VpGjlGAA7wTaHPh+FIpNAaqlRZSaqHKdrQUrrsl1AaaptDM8GlJVJkbeFOc81eBTmCQ9/R1coX8DhDfS5liwHYFe2gLcT8OoZTGTh/tJoqVhyDT1OsSWkAqq3t3rRR0sKxlkv28eEDQABI3ChK+RKUV7zf4Vx0OzYyDskc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207868; c=relaxed/simple;
	bh=2eqqhZC/BedUhhv27l744v2P5xFkujyC7R/je5Rn/x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HodPiMcDrq3GUDQKRzb1jF9x7qRjJszmWGtOpF/7XtXYNn0BJ0MjudKQaOpFCXsip/8+uEfbNTLrvRuhTNxR7apnE7Bb5899u/00MYFtsfAAdohMSA/QtBd4bNpt2mvLmKZdc3zqjmDHU32Ryw3IEzCJaNPZFFGb4wNhXBHC4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+Jcrtxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32ECAC4CEF7
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207868;
	bh=2eqqhZC/BedUhhv27l744v2P5xFkujyC7R/je5Rn/x0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b+JcrtxacfXp50KLnfXMj/iSuGqPnbgi+E6aVBjaFljIHQVa9jPV7CDMheTwNBBEY
	 RTuSHsrSBj91HI/VAAXbDe8deTuDui2mA9mNu7tQ0e0+fh9jD02tScILAa+iou1AsI
	 amHgdFaTFvRcyt56wSULFEYa1IcYz6SDUGw8DbzqPuM319Q41oEWifD2IqKw7oYKe5
	 PHNp2yv016kgfbD796bw0sOmi0X+A8MkW5+PRGfrsaGQZnN/KV53av+y+C+Gi2IMOy
	 kgjWs2jcrotXT+Wnw64YBvkFrn7KGNgSwCG68/ikcVbzT5C3qIkQFtVRVZ7Zv1SxxP
	 TgLTA3Ak5DW+w==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b0e7bc49263so187055266b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 08:04:28 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyr0MC7KucgcbEde/6kUYtLoioCM204EJ1JClvrA0nfA9Rr71fB
	QFaW4mkMrvBaP7Y+UGeCz2GU6EqRMcO6iUfW39LSSap9wvpRVQhdvrciWU7jIGDcj8knv9viiUS
	eul4k4zcJ/1Z79Qy4W5KUrbJ//luvN2Q=
X-Google-Smtp-Source: AGHT+IGB2VokxbXE80LkkQGu29u21bxV7/M6KzFXWDDAr36v+jK2en2v0VsJuYjc7xe231frhjDIzwiSkhly4Lhy4Og=
X-Received: by 2002:a17:907:d64a:b0:b0c:1701:bfa1 with SMTP id
 a640c23a62f3a-b1bbb54adfemr662202766b.27.1758207866673; Thu, 18 Sep 2025
 08:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758130856.git.dsterba@suse.com>
In-Reply-To: <cover.1758130856.git.dsterba@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 18 Sep 2025 16:03:49 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6iGyeCzY4GZ62d3p7MPhKoW95K-Cu+H4fmaoX9EH6VnA@mail.gmail.com>
X-Gm-Features: AS18NWAush41XcrK57f41onlUk8KjpCiHBOz5ue54lq5YQsU5GHCWtKmQNvN-3Q
Message-ID: <CAL3q7H6iGyeCzY4GZ62d3p7MPhKoW95K-Cu+H4fmaoX9EH6VnA@mail.gmail.com>
Subject: Re: [PATCH 0/3 RFC] Unlikely annotations for EIO/EUCLEAN/abort branches
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 6:54=E2=80=AFPM David Sterba <dsterba@suse.com> wro=
te:
>
> Hi,
>
> manually add unlikely annotations to the branches that lead to critical
> but rare errors. This is RFC as this has a big conflict surface.
> However this would be a one-time action, possibly done now before 6.18
> freeze.
>
> The base is current for-next (without series [1]):
>
>    text    data     bss     dec     hex filename
> 1650172  136289   15560 1802021  1b7f25 pre/btrfs.ko
> 1650934  136289   15560 1802783  1b821f post/btrfs.ko
> DELTA: +762
>
> There are differences in the generated assembly so the compiler does not
> detect the error branches as unlikely by itself (sometimes it does due
> to __cold function annotations).
>
> I've used my prototype branch from some time ago so some of the
> annotations could be still missing, this is more about getting the idea
> of the scope.

Just glancing and it seems good to me.
It would be nice to add a changelog to the patches, despite being trivial.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

>
> [1] https://lore.kernel.org/linux-btrfs/cover.1758095164.git.fdmanana@sus=
e.com/
>
> David Sterba (3):
>   btrfs: add unlikely annotations to branches leading to EUCLEAN
>   btrfs: add unlikely annotations to branches leading to EIO
>   btrfs: add unlikely annotations to branches leading to transaction
>     abort
>
>  fs/btrfs/backref.c          | 24 ++++++-------
>  fs/btrfs/bio.c              |  4 +--
>  fs/btrfs/block-group.c      | 24 ++++++-------
>  fs/btrfs/ctree.c            | 66 +++++++++++++++++------------------
>  fs/btrfs/defrag.c           |  2 +-
>  fs/btrfs/delayed-inode.c    |  2 +-
>  fs/btrfs/dev-replace.c      | 10 +++---
>  fs/btrfs/disk-io.c          | 48 +++++++++++++-------------
>  fs/btrfs/export.c           |  2 +-
>  fs/btrfs/extent-tree.c      | 68 ++++++++++++++++++-------------------
>  fs/btrfs/extent_io.c        |  2 +-
>  fs/btrfs/extent_map.c       |  2 +-
>  fs/btrfs/file-item.c        |  2 +-
>  fs/btrfs/file.c             | 45 ++++++++++++------------
>  fs/btrfs/free-space-cache.c |  2 +-
>  fs/btrfs/free-space-tree.c  | 24 ++++++-------
>  fs/btrfs/inode.c            | 58 +++++++++++++++----------------
>  fs/btrfs/ioctl.c            |  6 ++--
>  fs/btrfs/lzo.c              |  6 ++--
>  fs/btrfs/qgroup.c           | 18 +++++-----
>  fs/btrfs/raid56.c           | 14 ++++----
>  fs/btrfs/relocation.c       | 14 ++++----
>  fs/btrfs/root-tree.c        |  6 ++--
>  fs/btrfs/scrub.c            | 18 +++++-----
>  fs/btrfs/send.c             | 12 +++----
>  fs/btrfs/super.c            |  6 ++--
>  fs/btrfs/verity.c           |  4 +--
>  fs/btrfs/volumes.c          | 30 ++++++++--------
>  fs/btrfs/zoned.c            | 50 +++++++++++++--------------
>  fs/btrfs/zstd.c             |  2 +-
>  30 files changed, 284 insertions(+), 287 deletions(-)
>
> --
> 2.51.0
>
>

