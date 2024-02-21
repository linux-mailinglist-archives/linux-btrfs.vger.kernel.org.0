Return-Path: <linux-btrfs+bounces-2604-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0EB85D6C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 12:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249FE1C20FA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 11:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890A53FE35;
	Wed, 21 Feb 2024 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI6mMiYn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54EF28363
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Feb 2024 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514755; cv=none; b=HFAkus7rqturWx8/KrVhOPbeoJmhoqCQLJX5X+fmhQWCC79+Ql7WP/b9DcVXkipPWiZeBTdmb4Edl75yn6I3Sh7HUzkrNSuQ8Ob2xl8j4ZfkBtH3UX1VfiwMELZfz/75Yl4dl1e/aG86w18/7eh7F65M+mFCoWJZPKkAW1Cc3dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514755; c=relaxed/simple;
	bh=y93AIhI8jL5LLXCyvV1q9aq1jy2VfzFHMC2loOs7tJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sf7FSXXFFr+8w0CTL24UIyIZ7NAP/k8vWxBSm5i+g/wLDWDWqUhzSuKr/y3zvBvGv/N15ZCv2VGV3M76u7CT9oG7RXyf+gqiyw1lQUnB/i8a6ZWFZkj8Xs6gTHLCujF9V5Sknstt0QwIiUnRIM/JUzZWAhO8JsytJ9zQ9jzdlK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI6mMiYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0F4C43394
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Feb 2024 11:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708514755;
	bh=y93AIhI8jL5LLXCyvV1q9aq1jy2VfzFHMC2loOs7tJI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dI6mMiYnl0WDviB/4BhssPY4uHB5fipfsTLas/7GafOchRJLqScUfUzSZYOKf27ij
	 hGRfLu7mYgUwGEVWNeN3mG7XpJJRtMGlwCWQY913zPZPLt22sGdz75ouQuyDCd1v/b
	 3lN3gZLw4TEykvzD7Gpk4ZCPxA2hKemOElpn2lUMIZOyF8uccdR9/OYeAhFg6ynmzO
	 YUp/G5N+47Eo2Vio8blFdhBvDGjbobs/dgxEBNEthCQXSUdWubEd/md9PPgRza9+gQ
	 4xEmJ2Boid24iLjJu3t3lCNaUpgeIEOW9LRhvMJG3JSinf0jH4xNkGQHiaiCeVS2CM
	 3UdQfJRmOr7vQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso6616170a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Feb 2024 03:25:55 -0800 (PST)
X-Gm-Message-State: AOJu0YybI3HYSLLT7HoPxMy7f88y2+sRKmvHBQRzSBf/UdfSFAfntWfq
	+jNRi8ms9XDrfwC0jpP3ZTZYwoerMs9Q4Z6fqMknsIhjHDcM2JQf56oOwx3s+t7lXPQ6PMe7a8H
	3FIHKO4e2jmJsGm7eC8WWHS6GToo=
X-Google-Smtp-Source: AGHT+IFWvF2/tW8KPI0iAu2wZgJkN0Dj3RWujvhzaRLbAMr/NpyV+VCyTmeXkUzvH3QORiXOLX5gOEkYZ/YlOwnWWuw=
X-Received: by 2002:a17:906:cb9a:b0:a3e:9ce3:1b2 with SMTP id
 mf26-20020a170906cb9a00b00a3e9ce301b2mr5525365ejb.5.1708514753535; Wed, 21
 Feb 2024 03:25:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708429856.git.fdmanana@suse.com> <20240221111241.GG355@twin.jikos.cz>
In-Reply-To: <20240221111241.GG355@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 21 Feb 2024 11:25:16 +0000
X-Gmail-Original-Message-ID: <CAL3q7H78JY7ogkGpbhEyNio2QiPOHFmT3U+d3YVcuqot2OS-0w@mail.gmail.com>
Message-ID: <CAL3q7H78JY7ogkGpbhEyNio2QiPOHFmT3U+d3YVcuqot2OS-0w@mail.gmail.com>
Subject: Re: [PATCH 0/2] btrfs: fix a couple KCSAN warnings
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:13=E2=80=AFAM David Sterba <dsterba@suse.cz> wro=
te:
>
> On Tue, Feb 20, 2024 at 12:24:32PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > KCSAN reports a couple data races around access to block reserves.
> > While they are very likely harmless it generates some noise and reports
> > will keep coming, so address these.
> >
> > Filipe Manana (2):
> >   btrfs: fix data races when accessing the reserved amount of block res=
erves
> >   btrfs: fix data race at btrfs_use_block_rsv() when accessing block re=
serve
>
> Thre's another way to "fix" the KCSAN warnings, adding a data_race()
> annotation to the access when it does not matter if the lock is taken or
> not.
>
> In commit 748f553c3c4c "btrfs: add KCSAN annotations for unlocked access
> to block_rsv->full" this was added for 'full', have you considered that
> for 'reserved' too? The spin lock is also correct regarding the warning
> but still increases the lock contention.

Yes, I have considered that, and in the change logs of the patches I
mention why I chose to take the lock instead.
As for the contention,, these aren't that heavy given the contexts
where they are used and how much little work they do.

