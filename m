Return-Path: <linux-btrfs+bounces-5248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80778CD545
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 16:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436151F2436A
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 14:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662EE14AD35;
	Thu, 23 May 2024 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXwDSxcn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E991DFF8
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472968; cv=none; b=K3cZ1DoIeWIC6i6aILdh9ZX7SaPUIPEz+xTMSFMgIJDl3BETLaTUPciJenaCVBpi9htLVTXVYsrF/Lsfeho5yAKjQl/TN+WfsJ1Z8BC1AkZJtFP3PTkQLwZdHWzwpu9fTQW7CgX/db4dqZTZZyPOtppGwjP78WXBMKf/WQh9Tks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472968; c=relaxed/simple;
	bh=BvEMDcv5L/qVBT1615ZFBCvIVZ1jfx3h89ehKEp6sKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2CInW5oz1KKvWCTxCcp3psNmofPSaSiXTht4dFNN6uXjszfYWPNkQNgAXzCwpgD4zwAK3HNcHSufusTqprt+vr4lTKIp1WPj9O+kEN6t+TogQPFcoEYqkEkpp2PHHel4fsNZRvTerV1JJjKCNrt2aB6IbP+VTIlaOhHmZDS2mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXwDSxcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DD8C3277B
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 14:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716472968;
	bh=BvEMDcv5L/qVBT1615ZFBCvIVZ1jfx3h89ehKEp6sKE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZXwDSxcntP4DEg5OxKf7Lt0epzdv/TF/VpHszEeyUPxZVHsNHxEW6IOOGUzr3fLLY
	 xFmHubqcUGgBu94nibFk08sis+pxJZ7Um8GWTNFdHI1c6g7c2H4u5lDDTxcpbl4TVA
	 oOnfVtrJKYGEX6gC48fUbZ0sgDScueCftV9g4qRNCZpnlPPbOzHbS/xr1EWO0HtTZ/
	 fr75hM49d+tMPyFe5kap6j9MRvvM4AhNrXDsd1omXibRJ3I5qy/4SsZaLtX+yP3Dik
	 ab7BPyQcPWEXXBL8vrDHkn4DXvtcGDkSJ5boL/MGya4nWLk8S8fZ6YpzIeWsry57ad
	 YcrDxGhmvHYgA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59b49162aeso1103486466b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 07:02:48 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywm137Or+MPJDtX+mmpfNwZqifbCFMW3S95bBgQUIprrgQ25HLg
	46XgKB8cAWC81P5uxlCklLiTYcO2zein3nli6Chf2SB6fdWyFBYih1RtYvHJ/iGPdMMFNleKAZs
	qk/Y/TRJNT12nADfHfrueLkcFiaU=
X-Google-Smtp-Source: AGHT+IGaMnjj4eVENC+evmERKHDk6BDb1HA8FFbbRbVbmdL+Rf76gKtfyB1vy1SRZDTBocH7wAPUJEGg3JfdFuHY2ms=
X-Received: by 2002:a17:906:dce:b0:a59:b543:c9f9 with SMTP id
 a640c23a62f3a-a622806b570mr379034866b.7.1716472966763; Thu, 23 May 2024
 07:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716386100.git.fdmanana@suse.com> <0452200a-1285-4f34-bd15-3ffb6b49c688@gmx.com>
In-Reply-To: <0452200a-1285-4f34-bd15-3ffb6b49c688@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 23 May 2024 15:02:08 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4bHDt6BG4q8Oizc0vHd_FTM6j+aPjSUVcj5OxHiBv3XQ@mail.gmail.com>
Message-ID: <CAL3q7H4bHDt6BG4q8Oizc0vHd_FTM6j+aPjSUVcj5OxHiBv3XQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] btrfs: avoid some unnecessary commit of empty transactions
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 11:21=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/5/23 00:06, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > A few places can unnecessarily create an empty transaction and then com=
mit
> > it, when the goal is just to catch the current transaction and wait for
> > its commit to complete. This results in wasting IO, time and rotation o=
f
> > the precious backup roots in the super block. Details in the change log=
s.
> > The patches are all independent, except patch 4 that applies on top of
> > patch 3 (but could have been done in any order really, they are indepen=
dent).
>
> Looks good to me.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Have you considered outputting a warning if we're committing an empty
> transaction (for debug build)?
>
> That would prevent such problem from happening again.

It's not really a bug, just inefficient behaviour with side effects
for this particular type of use case.

An empty transaction can happen in other in other scenarios too like:

btrfs_start_transaction()

do something that fails, call btrfs_end_transaction() and return error
to user space

In that case no transaction abort happens since we haven't modified
anything, and if no one else uses that transaction until it's
committed, it's an "empty" transaction.

So the warning is not feasible.

Thanks.

>
> Thanks,
> Qu
> >
> > Filipe Manana (7):
> >    btrfs: qgroup: avoid start/commit empty transaction when flushing re=
servations
> >    btrfs: avoid create and commit empty transaction when committing sup=
er
> >    btrfs: send: make ensure_commit_roots_uptodate() simpler and more ef=
ficient
> >    btrfs: send: avoid create/commit empty transaction at ensure_commit_=
roots_uptodate()
> >    btrfs: scrub: avoid create/commit empty transaction at finish_extent=
_writes_for_zoned()
> >    btrfs: add and use helper to commit the current transaction
> >    btrfs: send: get rid of the label and gotos at ensure_commit_roots_u=
ptodate()
> >
> >   fs/btrfs/disk-io.c     |  8 +-------
> >   fs/btrfs/qgroup.c      | 31 +++++--------------------------
> >   fs/btrfs/scrub.c       |  6 +-----
> >   fs/btrfs/send.c        | 32 ++++++++------------------------
> >   fs/btrfs/space-info.c  |  9 +--------
> >   fs/btrfs/super.c       | 11 +----------
> >   fs/btrfs/transaction.c | 19 +++++++++++++++++++
> >   fs/btrfs/transaction.h |  1 +
> >   8 files changed, 37 insertions(+), 80 deletions(-)
> >

