Return-Path: <linux-btrfs+bounces-1895-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5B18405AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 13:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07C31F24329
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 12:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E88B627E3;
	Mon, 29 Jan 2024 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL8AxVBF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A466166D
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532581; cv=none; b=KHVHSdhAPAiK38c5Gm90VGMLJ0PtyAiQbGEneWEOvsVvi8/fVgvEct7hAmn0zdOX5y4nuoyr56Dlmp6pepPDaHxRLBpiRu+2NmztLrgtpKNhfwK2wJedjnFcpplOTcEKczZ/qdaGKFl1wysRemWQshfV24s9s1/o29lRub9wa8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532581; c=relaxed/simple;
	bh=I+HAGvulRvz7eCOBWABcS7QjUuzLQqJO/q8ytCgFD/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/avRSW7avOf08liBHnDAmgBr0hwPtX0t82TLguq39GUb5PGRVNZlfuEcYSBn+BYX436YaZUAShmr+ueHo5GfdDK19t4JiIThsJIS3dwmHKD5+Z1YtPNqhY1fKARGU4W1qWG66tX0W66CvHQALCiFrQIoD0+aOM3riIWBv8qOSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uL8AxVBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43BEC433F1
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 12:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706532580;
	bh=I+HAGvulRvz7eCOBWABcS7QjUuzLQqJO/q8ytCgFD/0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uL8AxVBFTh/DUMRz0PGnom7SZIXW/FuVrNP8iiKrm6CWBKIkzrSgduUtC/mdyxLDH
	 8jTC2OVb1c/OxMDoFsam7hRJIOZjpwtvq/2VM9GK7ylkbh1onognfpo7C2i/UJU9a0
	 +BhvJt/jmeh11GHN32la6VbOs6b5ZMg+HS2d9uJFp/XzhyNTaXNYnuJPYV3YxkwoMi
	 noPURDXqUvrqEBrDOmFWXHEuppD9SuvkjvCVwLwJdCekXseFsyheEJmNnAvd66SEeQ
	 aOLTQOlYcEnEU/FD7oqxdNOI5bE/JjYQT6gFrJ0TvnMu5UI9Dx21lbthuGJYBUQT0p
	 +ZOi0+tI6lymA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55ee9805da7so1381766a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 04:49:40 -0800 (PST)
X-Gm-Message-State: AOJu0YxNW29yAjRC3BRShwv+0MB+EW/eskG/d39UYIo9xOweT34+I5Sh
	/mg9pKPoO4LDId6zjlUF8zZKEe3qmgxhUTM/K8NlymM94DX26IK/ATNbiLMzY3vpn9dlFdS2m2A
	D1s8g0q4xxXnXiemCjd4kZWO6Srs=
X-Google-Smtp-Source: AGHT+IHGwpwxia9VmX1CB/3byUvE6N7XI4c3zllwz0uFZpBFHx+8R4cN3z5evhKHVm9nNBMR/sRYlj3bvP2MtVC6Mn4=
X-Received: by 2002:a17:906:89b:b0:a35:cbf1:c254 with SMTP id
 n27-20020a170906089b00b00a35cbf1c254mr1270047eje.11.1706532579127; Mon, 29
 Jan 2024 04:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706177914.git.fdmanana@suse.com> <c0649a6d95144ca7040762efe467ac6ee707ac0b.camel@intelfx.name>
In-Reply-To: <c0649a6d95144ca7040762efe467ac6ee707ac0b.camel@intelfx.name>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 29 Jan 2024 12:49:02 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6802ayLHUJFztzZAVzBLJAGdFx=6FHNNy87+obZXXZpQ@mail.gmail.com>
Message-ID: <CAL3q7H6802ayLHUJFztzZAVzBLJAGdFx=6FHNNy87+obZXXZpQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] btrfs: some fixes around unused block deletion
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 9:39=E2=80=AFPM Ivan Shapovalov <intelfx@intelfx.na=
me> wrote:
>
> On 2024-01-25 at 10:26 +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > These fix a couple issues regarding block group deletion, either
> > deleting
> > an unused block group when it shouldn't be deleted due to outstanding
> > reservations relying on the block group, or unused block groups never
> > getting deleted since they were created due to pessimistic space
> > reservation and ended up never being used. More details on the change
> > logs of each patch.
> >
> > Filipe Manana (5):
> >   btrfs: add and use helper to check if block group is used
> >   btrfs: do not delete unused block group if it may be used soon
> >   btrfs: add new unused block groups to the list of unused block
> > groups
> >   btrfs: document what the spinlock unused_bgs_lock protects
> >   btrfs: add comment about list_is_singular() use at
> > btrfs_delete_unused_bgs()
> >
> >  fs/btrfs/block-group.c | 87
> > +++++++++++++++++++++++++++++++++++++++++-
> >  fs/btrfs/block-group.h |  7 ++++
> >  fs/btrfs/fs.h          |  3 ++
> >  3 files changed, 95 insertions(+), 2 deletions(-)
> >
>
> Still broken for me, unfortunately.

I'm curious about your workload. Is it something like continuous,
non-stop deduplication or cloning for example?

Did you actually experience -ENOSPC errors?

Also, if you unmount and then mount again the fs, any unused block
groups should be scheduled for deletion once the cleaner thread runs,
at least if there's not a huge workload for a minute or two.

On top of this patchset, can you try the following patch?

https://pastebin.com/raw/U7b0e03g

If that still doesn't help, try the following the following patch on
top of this patchset:

https://pastebin.com/raw/rKiSmG5w

Thanks.

>
> --
> Ivan Shapovalov / intelfx /

