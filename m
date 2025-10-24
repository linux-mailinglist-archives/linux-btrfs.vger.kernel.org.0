Return-Path: <linux-btrfs+bounces-18249-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B4AC04E6E
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 09:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9737A3B781C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 07:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94702F6598;
	Fri, 24 Oct 2025 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPsNMcSw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1144B2F6187
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292545; cv=none; b=sLWv92069C2GNSk8PyyKmciVPIvgQkXh0kjLteiuzwIafQzcq+Y1M6fnHbWjmlzja3Wjb74lc392C7tynpHqEk52+ruNlqPjf503lpMcuD3OcJBsgNqFc6yFQjB6fNfuhKic2/WWwRTPA6ZsHZkM7iZOf04JE55j7jtvE87gmnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292545; c=relaxed/simple;
	bh=SlqkuXubgI4/20M15Ontx6QpCcHAWTAptcWM27e/Vuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZFYhCQerJkRuDaJAJlDRiJYRIM7wFCyThtvNYrVLAMMRUnfr6814TL3aw+TS2qdZE9RNFl5Tq6UvCpT5UGWax5PFKy/DJZsaiG70ZRsnIb4zlAtemf2Rm9JnV++LHJ5dwHaPNfwSvSIjUMoBBvCtpXriveaDdG9sAyQk59no4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPsNMcSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A75C4CEFF
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 07:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761292544;
	bh=SlqkuXubgI4/20M15Ontx6QpCcHAWTAptcWM27e/Vuo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nPsNMcSwcPUTdAUpUmGRZDL7/RkuBF1Zwai02/pliBjh0Q7QugRPSoJN9fXTkK62U
	 usvho8UZg4lQatdgh9EsLJz2PQ1lU2sWjn898afTcTYEx5hp9gkLV3d6jKS4HJXJPL
	 IPLFh8/KCRhcyd1anJ8Gid/G8ZBhXWN8Zvrx2SqIX5VhxpG5aY4yzm9HPC3u+K2SoI
	 ZggrQ3l13VJU0wTI25W68CWeu9OL5X+6F8YRqw0qZLYu4813O+cTFpcKEUPWfyNPpo
	 tBmUV8L1GUc7ncIhcSN4FzfSyo11opivkdMZo+l/mvxpMZkWTTYeCIGlqIKo4jG1q1
	 y2cP5mHoBD4lQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so3009522a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 00:55:44 -0700 (PDT)
X-Gm-Message-State: AOJu0YxnDZ9NOsVDBnwaVwnS6N79rA5A2tcX/jAbMyrMjTjqQXh5H/aC
	CnqXkdpnXYmjMmdUJL6ArDSnGhRL6M4MS9MZdHKYJMFDwIu8zduIJYKifIRxuvGrT65AFxpEtiw
	KryNUK2GESCg4/yrLGUzH+Opy1qoUd8w=
X-Google-Smtp-Source: AGHT+IGIWO9ekcMBzrlyYywaY0FonXjwlnJclM/ln9I2hlQdYHKsTN8gzSZXMqKhafmwZDb+7JKRa2hDXwAe091iG7E=
X-Received: by 2002:a17:907:9815:b0:b33:b8bc:d1da with SMTP id
 a640c23a62f3a-b6d6fe02d48mr169978966b.1.1761292543010; Fri, 24 Oct 2025
 00:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761234580.git.fdmanana@suse.com> <80186103f5b1185fbec7bc6e6b478bd61a221522.1761234581.git.fdmanana@suse.com>
 <816109c0-a32e-484a-897c-c234b866fd80@wdc.com>
In-Reply-To: <816109c0-a32e-484a-897c-c234b866fd80@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 24 Oct 2025 08:55:05 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7HZFg7dFyw6pD27zgbp5feUo57Li=btq1K5oKV6-eeWQ@mail.gmail.com>
X-Gm-Features: AS18NWBQxzY-pk6G3udA9qhWRLsUJ7LhBmhrUV2TWs-Ixr4-xUYDLT9Z7eLJers
Message-ID: <CAL3q7H7HZFg7dFyw6pD27zgbp5feUo57Li=btq1K5oKV6-eeWQ@mail.gmail.com>
Subject: Re: [PATCH 10/28] btrfs: avoid unnecessary reclaim calculation in priority_reclaim_metadata_space()
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 8:06=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 10/23/25 6:01 PM, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If the given ticket was already served (its ->bytes is 0), then we wast=
ed
> > time calculating the metadata reclaim size. So calculate it only after =
we
> > checked the ticket was not yet served.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/space-info.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > index 9a072009eec8..b03c015d5d51 100644
> > --- a/fs/btrfs/space-info.c
> > +++ b/fs/btrfs/space-info.c
> > @@ -1501,7 +1501,6 @@ static void priority_reclaim_metadata_space(struc=
t btrfs_space_info *space_info,
> >       int flush_state =3D 0;
> >
> >       spin_lock(&space_info->lock);
> > -     to_reclaim =3D btrfs_calc_reclaim_metadata_size(space_info);
> >       /*
> >        * This is the priority reclaim path, so to_reclaim could be >0 s=
till
> >        * because we may have only satisfied the priority tickets and st=
ill
> Is the ticket (or ticket->bytes) also protected by the space_info lock?
> If yes that would be an odd dependency TBH. If not we can move the
> spin_lock() call below the ticket->bytes =3D=3D 0 check.

It is dependent and has to be done under space_info->lock.

Besides ensuring the waiter sees the updated value (->bytes set to 0),
they're also needed to synchronize a waiter and a reclaim task.
And that's because tickets are stack allocated - so while the stack
must not be destroyed in the middle of a wakeup or you get an invalid
memory access.

Removing the dependency on the space_info->lock, to reduce contention,
is eliminated in patch 27.

